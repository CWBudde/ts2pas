import { Command } from 'commander';
import { readFile, writeFile, watch as fsWatch, mkdir } from 'fs/promises';
import { resolve, basename, dirname, join } from 'path';
import { existsSync } from 'fs';
import { glob } from 'glob';
import chalk from 'chalk';
import ora from 'ora';
import https from 'https';
import { convertTypeScriptToPascal } from './index.js';
import { loadConfig, mergeCliOptions, getFinalConfig } from './config/index.js';
import type { Ts2PasConfig } from './config/index.js';

const program = new Command();

/**
 * Fetch content from URL
 */
async function fetchFromUrl(url: string): Promise<string> {
  return new Promise((resolve, reject) => {
    https.get(url, (res): void => {
      if (res.statusCode === 301 || res.statusCode === 302) {
        // Handle redirect
        const location = res.headers.location;
        if (location) {
          fetchFromUrl(location).then(resolve).catch(reject);
          return;
        }
        reject(new Error('Redirect missing location header'));
        return;
      }

      if (res.statusCode !== 200) {
        reject(new Error(`HTTP ${res.statusCode}: ${res.statusMessage}`));
        return;
      }

      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

/**
 * Convert GitHub URL to raw content URL
 */
function githubToRawUrl(url: string): string {
  // Convert github.com URLs to raw.githubusercontent.com
  const githubRegex = /^https?:\/\/(www\.)?github\.com\/([^\/]+)\/([^\/]+)\/blob\/([^\/]+)\/(.+)$/;
  const match = url.match(githubRegex);

  if (match) {
    const [, , owner, repo, branch, path] = match;
    return `https://raw.githubusercontent.com/${owner}/${repo}/${branch}/${path}`;
  }

  return url;
}


/**
 * Process a single TypeScript file to Pascal
 */
async function processFile(
  inputPath: string,
  outputPath: string,
  options: any
): Promise<void> {
  const tsContent = await readFile(inputPath, 'utf-8');
  const fileName = basename(inputPath, '.d.ts');

  const pascalContent = convertTypeScriptToPascal(tsContent, {
    fileName,
    ...options,
  });

  // Ensure output directory exists
  const outputDir = dirname(outputPath);
  if (!existsSync(outputDir)) {
    await mkdir(outputDir, { recursive: true });
  }

  await writeFile(outputPath, pascalContent, 'utf-8');
}

program
  .name('ts2pas')
  .description('TypeScript definition file to DWScript Pascal converter')
  .version('1.0.0-alpha.1')
  .argument('[input]', 'Input TypeScript definition file (.d.ts)')
  .argument('[output]', 'Output Pascal file (.pas)')
  .option('--url <url>', 'Fetch TypeScript definitions from GitHub URL')
  .option('--watch', 'Watch mode - regenerate on file changes')
  .option('--config <path>', 'Path to configuration file')
  .option('--indent <size>', 'Indentation size (default: 2)', '2')
  .option('--style <style>', 'Output style: dws|pas2js (default: dws)', 'dws')
  .option('--namespace-prefix <prefix>', 'Namespace prefix for generated units (default: JS)')
  .option('--verbose', 'Verbose output')
  .action(async (input, output, options) => {
    try {
      // Load configuration (auto-discover or explicit path)
      const spinner = ora('Loading configuration...').start();
      let config: Ts2PasConfig = {};
      try {
        config = await loadConfig({
          configPath: options.config,
          cwd: process.cwd(),
        });
        if (Object.keys(config).length > 0 || options.config) {
          spinner.succeed('Configuration loaded');
        } else {
          spinner.stop();
        }
      } catch (error) {
        spinner.fail('Failed to load configuration');
        throw error;
      }

      // Merge CLI options with config (CLI takes precedence)
      const mergedConfig = mergeCliOptions(config, {
        indent: options.indent,
        style: options.style,
        namespacePrefix: options.namespacePrefix,
        verbose: options.verbose,
      });

      // Get final config with defaults
      const finalConfig = getFinalConfig(mergedConfig);
      const mergedOptions = {
        indentSize: finalConfig.indentSize,
        style: finalConfig.style,
        namespacePrefix: finalConfig.namespacePrefix,
        verbose: finalConfig.verbose,
        typeMappings: finalConfig.typeMappings,
      };

      let tsContent: string;
      let fileName: string;
      let outputPath: string;

      // Handle GitHub URL mode
      if (options.url) {
        const url = githubToRawUrl(options.url);
        fileName = basename(url).replace(/\.d\.ts$/, '');

        const spinner = ora(`Fetching from ${url}...`).start();
        try {
          tsContent = await fetchFromUrl(url);
          spinner.succeed('TypeScript definition fetched successfully');
        } catch (error) {
          spinner.fail('Failed to fetch from URL');
          throw error;
        }

        outputPath = output ? resolve(process.cwd(), output) : `${fileName}.pas`;
      } else {
        // Validate input file
        if (!input) {
          console.error(chalk.red('Error: Input file or --url required'));
          program.help();
          process.exit(1);
        }

        const inputPath = resolve(process.cwd(), input);
        fileName = basename(input, '.d.ts');
        outputPath = output ? resolve(process.cwd(), output) : input.replace(/\.d\.ts$/, '.pas');

        const spinner = ora('Reading TypeScript definition file...').start();
        try {
          // Read input file
          tsContent = await readFile(inputPath, 'utf-8');
          spinner.succeed('TypeScript definition file read successfully');
        } catch (error) {
          spinner.fail('Failed to read input file');
          throw error;
        }
      }

      // Convert TypeScript to Pascal
      const conversionSpinner = ora('Converting TypeScript to Pascal...').start();
      try {
        const pascalContent = convertTypeScriptToPascal(tsContent, {
          fileName,
          ...mergedOptions,
        });
        conversionSpinner.succeed('Conversion completed');

        // Write output file
        const writeSpinner = ora(`Writing Pascal file to ${outputPath}...`).start();
        await writeFile(outputPath, pascalContent, 'utf-8');
        writeSpinner.succeed(chalk.green(`Pascal file written successfully to ${outputPath}`));

        console.log(chalk.blue('\n✨ Conversion completed successfully!'));
      } catch (error) {
        conversionSpinner.fail('Conversion failed');
        throw error;
      }
    } catch (error) {
      console.error(chalk.red('\nError:'), error instanceof Error ? error.message : String(error));
      if (options.verbose && error instanceof Error && error.stack) {
        console.error(chalk.gray(error.stack));
      }
      process.exit(1);
    }
  });

// Watch mode command
program
  .command('watch')
  .description('Watch TypeScript definition files and regenerate on changes')
  .argument('<input...>', 'Input files or patterns to watch')
  .option('-o, --output-dir <dir>', 'Output directory for generated Pascal files')
  .option('--config <path>', 'Path to configuration file')
  .option('--indent <size>', 'Indentation size (default: 2)', '2')
  .option('--style <style>', 'Output style: dws|pas2js (default: dws)', 'dws')
  .option('--namespace-prefix <prefix>', 'Namespace prefix for generated units')
  .option('--verbose', 'Verbose output')
  .action(async (inputs: string[], options) => {
    try {
      // Load configuration
      const config = await loadConfig({
        configPath: options.config,
        cwd: process.cwd(),
      });
      if (Object.keys(config).length > 0 || options.config) {
        console.log(chalk.green('Configuration loaded'));
      }

      // Merge CLI options with config
      const mergedConfig = mergeCliOptions(config, {
        indent: options.indent,
        style: options.style,
        namespacePrefix: options.namespacePrefix,
        verbose: options.verbose,
      });

      const finalConfig = getFinalConfig(mergedConfig);
      const mergedOptions = {
        indentSize: finalConfig.indentSize,
        style: finalConfig.style,
        namespacePrefix: finalConfig.namespacePrefix,
        verbose: finalConfig.verbose,
        typeMappings: finalConfig.typeMappings,
      };

      // Resolve output directory
      const outputDir = options.outputDir ? resolve(process.cwd(), options.outputDir) : process.cwd();

      // Expand glob patterns to get actual files
      const allFiles: string[] = [];
      for (const pattern of inputs) {
        const matches = await glob(pattern, { absolute: true, windowsPathsNoEscape: true });
        allFiles.push(...matches);
      }

      if (allFiles.length === 0) {
        console.error(chalk.red('Error: No files found matching the provided patterns'));
        process.exit(1);
      }

      console.log(chalk.blue(`\n👀 Watching ${allFiles.length} file(s) for changes...\n`));

      // Process all files initially
      for (const file of allFiles) {
        const outputPath = join(outputDir, basename(file).replace(/\.d\.ts$/, '.pas'));
        const spinner = ora(`Processing ${basename(file)}...`).start();
        try {
          await processFile(file, outputPath, mergedOptions);
          spinner.succeed(chalk.green(`Generated ${basename(outputPath)}`));
        } catch (error) {
          spinner.fail(chalk.red(`Failed to process ${basename(file)}`));
          if (mergedOptions.verbose && error instanceof Error) {
            console.error(chalk.gray(error.stack || error.message));
          }
        }
      }

      console.log(chalk.blue('\n✨ Initial conversion completed. Watching for changes...\n'));

      // Watch each file for changes
      allFiles.forEach(file => {
        const outputPath = join(outputDir, basename(file).replace(/\.d\.ts$/, '.pas'));

        const watcher = fsWatch(file);

        (async () => {
          try {
            for await (const event of watcher) {
              if (event.eventType === 'change') {
                const spinner = ora(`Regenerating ${basename(outputPath)}...`).start();
                try {
                  await processFile(file, outputPath, mergedOptions);
                  spinner.succeed(chalk.green(`Updated ${basename(outputPath)} at ${new Date().toLocaleTimeString()}`));
                } catch (error) {
                  spinner.fail(chalk.red(`Failed to regenerate ${basename(file)}`));
                  if (mergedOptions.verbose && error instanceof Error) {
                    console.error(chalk.gray(error.stack || error.message));
                  }
                }
              }
            }
          } catch (error) {
            if ((error as any).code !== 'ERR_USE_AFTER_CLOSE') {
              console.error(chalk.red('Watcher error:'), error);
            }
          }
        })();
      });

      // Handle Ctrl+C gracefully
      process.on('SIGINT', () => {
        console.log(chalk.yellow('\n\n👋 Stopping file watchers...'));
        process.exit(0);
      });

    } catch (error) {
      console.error(chalk.red('\nError:'), error instanceof Error ? error.message : String(error));
      if (options.verbose && error instanceof Error && error.stack) {
        console.error(chalk.gray(error.stack));
      }
      process.exit(1);
    }
  });

// Batch processing command
program
  .command('batch')
  .description('Process multiple TypeScript definition files')
  .argument('<pattern>', 'Glob pattern for input files (e.g., "*.d.ts")')
  .option('-o, --output-dir <dir>', 'Output directory for generated Pascal files')
  .option('--config <path>', 'Path to configuration file')
  .option('--indent <size>', 'Indentation size (default: 2)', '2')
  .option('--style <style>', 'Output style: dws|pas2js (default: dws)', 'dws')
  .option('--namespace-prefix <prefix>', 'Namespace prefix for generated units')
  .option('--verbose', 'Verbose output')
  .action(async (pattern: string, options) => {
    try {
      // Load configuration
      const spinner = ora('Loading configuration...').start();
      let config: Ts2PasConfig = {};
      try {
        config = await loadConfig({
          configPath: options.config,
          cwd: process.cwd(),
        });
        if (Object.keys(config).length > 0 || options.config) {
          spinner.succeed('Configuration loaded');
        } else {
          spinner.stop();
        }
      } catch (error) {
        spinner.fail('Failed to load configuration');
        throw error;
      }

      // Merge CLI options with config
      const mergedConfig = mergeCliOptions(config, {
        indent: options.indent,
        style: options.style,
        namespacePrefix: options.namespacePrefix,
        verbose: options.verbose,
      });

      const finalConfig = getFinalConfig(mergedConfig);
      const mergedOptions = {
        indentSize: finalConfig.indentSize,
        style: finalConfig.style,
        namespacePrefix: finalConfig.namespacePrefix,
        verbose: finalConfig.verbose,
        typeMappings: finalConfig.typeMappings,
      };

      // Resolve output directory
      const outputDir = options.outputDir ? resolve(process.cwd(), options.outputDir) : process.cwd();

      // Find all matching files
      const findSpinner = ora(`Searching for files matching "${pattern}"...`).start();
      const files = await glob(pattern, { absolute: true, windowsPathsNoEscape: true });

      if (files.length === 0) {
        findSpinner.fail(chalk.red('No files found matching the pattern'));
        process.exit(1);
      }

      findSpinner.succeed(chalk.green(`Found ${files.length} file(s) to process`));

      // Process each file
      let successCount = 0;
      let failCount = 0;

      console.log(chalk.blue(`\nProcessing ${files.length} file(s)...\n`));

      for (const file of files) {
        const outputPath = join(outputDir, basename(file).replace(/\.d\.ts$/, '.pas'));
        const spinner = ora(`Processing ${basename(file)}...`).start();

        try {
          await processFile(file, outputPath, mergedOptions);
          spinner.succeed(chalk.green(`Generated ${basename(outputPath)}`));
          successCount++;
        } catch (error) {
          spinner.fail(chalk.red(`Failed to process ${basename(file)}`));
          if (mergedOptions.verbose && error instanceof Error) {
            console.error(chalk.gray(error.stack || error.message));
          }
          failCount++;
        }
      }

      // Summary
      console.log(chalk.blue('\n' + '='.repeat(50)));
      console.log(chalk.blue('Batch Processing Summary'));
      console.log(chalk.blue('='.repeat(50)));
      console.log(chalk.green(`✓ Success: ${successCount} file(s)`));
      if (failCount > 0) {
        console.log(chalk.red(`✗ Failed: ${failCount} file(s)`));
      }
      console.log(chalk.blue('='.repeat(50) + '\n'));

      if (failCount > 0) {
        console.log(chalk.yellow('Some files failed to process. Use --verbose for details.'));
        process.exit(1);
      } else {
        console.log(chalk.green('✨ All files processed successfully!'));
      }

    } catch (error) {
      console.error(chalk.red('\nError:'), error instanceof Error ? error.message : String(error));
      if (options.verbose && error instanceof Error && error.stack) {
        console.error(chalk.gray(error.stack));
      }
      process.exit(1);
    }
  });

program.parse();
