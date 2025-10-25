#!/usr/bin/env node

import { Command } from 'commander';
import { readFile, writeFile } from 'fs/promises';
import { resolve } from 'path';
import chalk from 'chalk';
import ora from 'ora';
import { convertTypeScriptToPascal } from './index.js';

const program = new Command();

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
  .option('--verbose', 'Verbose output')
  .action(async (input, output, options) => {
    try {
      // Handle GitHub URL mode
      if (options.url) {
        console.log(chalk.yellow('GitHub URL fetching not yet implemented'));
        console.log(chalk.gray(`Would fetch from: ${options.url}`));
        process.exit(1);
      }

      // Validate input file
      if (!input) {
        console.error(chalk.red('Error: Input file required'));
        program.help();
      }

      const inputPath = resolve(process.cwd(), input);
      const outputPath = output ? resolve(process.cwd(), output) : input.replace(/\.d\.ts$/, '.pas');

      const spinner = ora('Reading TypeScript definition file...').start();

      try {
        // Read input file
        const tsContent = await readFile(inputPath, 'utf-8');
        spinner.succeed('TypeScript definition file read successfully');

        // Convert TypeScript to Pascal
        spinner.start('Converting TypeScript to Pascal...');
        const pascalContent = convertTypeScriptToPascal(tsContent, {
          indentSize: parseInt(options.indent, 10),
          style: options.style as 'dws' | 'pas2js',
          verbose: options.verbose || false,
        });
        spinner.succeed('Conversion completed');

        // Write output file
        spinner.start(`Writing Pascal file to ${outputPath}...`);
        await writeFile(outputPath, pascalContent, 'utf-8');
        spinner.succeed(chalk.green(`Pascal file written successfully to ${outputPath}`));

        console.log(chalk.blue('\n✨ Conversion completed successfully!'));
      } catch (error) {
        spinner.fail('Conversion failed');
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

// Watch mode command (future implementation)
program
  .command('watch')
  .description('Watch TypeScript definition files and regenerate on changes')
  .argument('<input...>', 'Input files or patterns to watch')
  .option('-o, --output-dir <dir>', 'Output directory for generated Pascal files')
  .action(() => {
    console.log(chalk.yellow('Watch mode not yet implemented'));
    process.exit(1);
  });

// Batch processing command (future implementation)
program
  .command('batch')
  .description('Process multiple TypeScript definition files')
  .argument('<pattern>', 'Glob pattern for input files (e.g., "*.d.ts")')
  .option('-o, --output-dir <dir>', 'Output directory for generated Pascal files')
  .action(() => {
    console.log(chalk.yellow('Batch mode not yet implemented'));
    process.exit(1);
  });

program.parse();
