#!/usr/bin/env tsx

import { writeFile, mkdir } from 'fs/promises';
import { existsSync } from 'fs';
import { join } from 'path';
import https from 'https';
import { convertTypeScriptToPascal } from '../src/index.js';

interface ModuleConversionResult {
  moduleName: string;
  success: boolean;
  outputFile?: string;
  error?: string;
  stats?: {
    linesOfTypeScript: number;
    linesOfPascal: number;
    conversionTime: number;
    sourceSize: number;
  };
}

/**
 * Fetch content from URL
 */
async function fetchFromUrl(url: string): Promise<string> {
  return new Promise((resolve, reject) => {
    https.get(url, (res): void => {
      if (res.statusCode === 301 || res.statusCode === 302) {
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
      res.on('data', (chunk) => (data += chunk));
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

/**
 * Get URL for a specific Node.js module definition file
 */
function getNodeModuleUrl(moduleName: string): string {
  return `https://raw.githubusercontent.com/DefinitelyTyped/DefinitelyTyped/master/types/node/${moduleName}.d.ts`;
}

/**
 * Convert a Node.js module to Pascal
 */
async function convertNodeModule(
  moduleName: string,
  outputDir: string = 'conversions/node'
): Promise<ModuleConversionResult> {
  const result: ModuleConversionResult = {
    moduleName,
    success: false,
  };

  const startTime = Date.now();

  try {
    console.log(`\n📦 Fetching Node.js ${moduleName} module...`);

    // Fetch TypeScript definition
    const url = getNodeModuleUrl(moduleName);
    const tsContent = await fetchFromUrl(url);

    const sourceSize = tsContent.length;
    console.log(`✓ Downloaded ${sourceSize.toLocaleString()} bytes`);

    // Count TypeScript lines
    const tsLines = tsContent.split('\n').length;

    // Convert to Pascal
    console.log(`🔄 Converting to Pascal...`);
    const pascalContent = convertTypeScriptToPascal(tsContent, {
      fileName: moduleName,
      indentSize: 2,
      namespacePrefix: '',  // Use clean unit names without prefix
    });

    // Count Pascal lines
    const pasLines = pascalContent.split('\n').length;

    // Ensure output directory exists
    if (!existsSync(outputDir)) {
      await mkdir(outputDir, { recursive: true });
    }

    // Write output file
    const outputFile = join(outputDir, `${moduleName}.pas`);
    await writeFile(outputFile, pascalContent, 'utf-8');

    const conversionTime = Date.now() - startTime;

    result.success = true;
    result.outputFile = outputFile;
    result.stats = {
      linesOfTypeScript: tsLines,
      linesOfPascal: pasLines,
      conversionTime,
      sourceSize,
    };

    console.log(`✅ Successfully converted to ${outputFile}`);
    console.log(
      `   Stats: ${tsLines.toLocaleString()} TS lines → ${pasLines.toLocaleString()} Pascal lines (${conversionTime}ms, ${(sourceSize / 1024).toFixed(1)}KB)`
    );
  } catch (error) {
    result.error = error instanceof Error ? error.message : String(error);
    console.error(`❌ Failed to convert ${moduleName}: ${result.error}`);
  }

  return result;
}

/**
 * Convert multiple Node.js modules
 */
async function convertNodeModules(
  modules: string[],
  outputDir: string = 'conversions/node'
): Promise<void> {
  console.log(`\n🚀 Starting conversion of ${modules.length} Node.js modules...\n`);

  const results: ModuleConversionResult[] = [];

  for (const module of modules) {
    const result = await convertNodeModule(module, outputDir);
    results.push(result);
  }

  // Generate report
  const reportPath = join('conversions/logs', 'node-modules-report.json');
  await mkdir('conversions/logs', { recursive: true });
  await writeFile(reportPath, JSON.stringify(results, null, 2), 'utf-8');

  // Print summary
  console.log(`\n\n📊 Node.js Modules Conversion Summary`);
  console.log(`${'='.repeat(70)}`);

  const successful = results.filter((r) => r.success).length;
  const failed = results.filter((r) => !r.success).length;

  const totalTsLines = results
    .filter((r) => r.stats)
    .reduce((sum, r) => sum + (r.stats?.linesOfTypeScript || 0), 0);
  const totalPasLines = results
    .filter((r) => r.stats)
    .reduce((sum, r) => sum + (r.stats?.linesOfPascal || 0), 0);
  const totalSize = results
    .filter((r) => r.stats)
    .reduce((sum, r) => sum + (r.stats?.sourceSize || 0), 0);

  console.log(`✅ Successful: ${successful}/${modules.length}`);
  console.log(`❌ Failed: ${failed}/${modules.length}`);
  console.log(`📊 Total TypeScript Lines: ${totalTsLines.toLocaleString()}`);
  console.log(`📊 Total Pascal Lines: ${totalPasLines.toLocaleString()}`);
  console.log(`📊 Total Source Size: ${(totalSize / 1024 / 1024).toFixed(2)} MB`);
  console.log(`📊 Compression Ratio: ${((totalPasLines / totalTsLines) * 100).toFixed(1)}%`);

  if (failed > 0) {
    console.log(`\n❌ Failed modules:`);
    results
      .filter((r) => !r.success)
      .forEach((r) => console.log(`   - ${r.moduleName}: ${r.error}`));
  }

  // Show top conversions by size
  const topBySize = [...results]
    .filter((r) => r.stats)
    .sort((a, b) => (b.stats?.linesOfPascal || 0) - (a.stats?.linesOfPascal || 0))
    .slice(0, 5);

  console.log(`\n📈 Top 5 Modules by Pascal Output:`);
  topBySize.forEach((r, i) => {
    console.log(
      `   ${i + 1}. ${r.moduleName}: ${r.stats?.linesOfPascal.toLocaleString()} lines`
    );
  });

  console.log(`\n📝 Full report saved to: ${reportPath}`);
}

// Core Node.js modules to convert (ordered by importance/usage)
const CORE_NODE_MODULES = [
  'fs',           // File system - most commonly used
  'path',         // Path utilities - essential
  'http',         // HTTP server/client
  'events',       // Event emitter - fundamental
  'buffer',       // Buffer handling
  'stream',       // Streams
  'process',      // Process information
  'util',         // Utilities
  'crypto',       // Cryptography
  'child_process',// Child processes
  'os',           // Operating system
  'net',          // Network
  'url',          // URL parsing
  'querystring',  // Query string
  'timers',       // Timers
];

// Run if called directly
if (import.meta.url === `file://${process.argv[1].replace(/\\/g, '/')}`) {
  const args = process.argv.slice(2);

  if (args.length === 0) {
    // Convert top 8 core modules by default
    const topModules = CORE_NODE_MODULES.slice(0, 8);
    console.log('Converting top 8 core Node.js modules...');
    convertNodeModules(topModules).catch(console.error);
  } else if (args[0] === '--all') {
    // Convert all core modules
    console.log('Converting all 15 core Node.js modules...');
    convertNodeModules(CORE_NODE_MODULES).catch(console.error);
  } else {
    // Convert specific modules
    convertNodeModules(args).catch(console.error);
  }
}

export { convertNodeModule, convertNodeModules };
