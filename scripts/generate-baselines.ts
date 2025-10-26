#!/usr/bin/env node
/**
 * Generate baseline Pascal outputs for regression testing
 *
 * This script converts all .d.ts files in tests/fixtures/input to Pascal
 * and saves the output as baselines for future regression testing.
 */

import * as fs from 'fs';
import * as path from 'path';
import { fileURLToPath } from 'url';
import { convertTypeScriptToPascal } from '../src/index.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const FIXTURES_DIR = path.join(__dirname, '../tests/fixtures/input');
const BASELINES_DIR = path.join(__dirname, '../tests/fixtures/baselines');

interface BaselineInfo {
  inputFile: string;
  baselineFile: string;
  timestamp: string;
  version: string;
  success: boolean;
  error?: string;
}

/**
 * Ensure baselines directory exists
 */
function ensureBaselinesDir(): void {
  if (!fs.existsSync(BASELINES_DIR)) {
    fs.mkdirSync(BASELINES_DIR, { recursive: true });
  }
}

/**
 * Get all .d.ts files from fixtures directory
 */
function getFixtureFiles(): string[] {
  if (!fs.existsSync(FIXTURES_DIR)) {
    console.error(`Fixtures directory not found: ${FIXTURES_DIR}`);
    return [];
  }

  return fs.readdirSync(FIXTURES_DIR)
    .filter(file => file.endsWith('.d.ts'))
    .map(file => path.join(FIXTURES_DIR, file));
}

/**
 * Generate baseline for a single fixture file
 */
function generateBaseline(inputFile: string): BaselineInfo {
  const fileName = path.basename(inputFile, '.d.ts');
  const baselineFile = path.join(BASELINES_DIR, `${fileName}.pas`);

  const info: BaselineInfo = {
    inputFile,
    baselineFile,
    timestamp: new Date().toISOString(),
    version: '2.0.0-beta.1',
    success: false,
  };

  try {
    // Read TypeScript input
    const tsContent = fs.readFileSync(inputFile, 'utf-8');

    // Convert to Pascal
    const pascalCode = convertTypeScriptToPascal(tsContent, {
      fileName,
      indentSize: 2,
      style: 'dws',
      verbose: false,
    });

    // Write baseline
    fs.writeFileSync(baselineFile, pascalCode, 'utf-8');

    info.success = true;
    console.log(`✓ Generated baseline: ${fileName}.pas`);
  } catch (error) {
    info.success = false;
    info.error = error instanceof Error ? error.message : String(error);
    console.error(`✗ Failed to generate baseline for ${fileName}: ${info.error}`);
  }

  return info;
}

/**
 * Generate metadata file with baseline information
 */
function generateMetadata(baselines: BaselineInfo[]): void {
  const metadata = {
    generated: new Date().toISOString(),
    version: '2.0.0-beta.1',
    totalFiles: baselines.length,
    successful: baselines.filter(b => b.success).length,
    failed: baselines.filter(b => !b.success).length,
    baselines: baselines.map(b => ({
      inputFile: path.basename(b.inputFile),
      baselineFile: path.basename(b.baselineFile),
      success: b.success,
      error: b.error,
    })),
  };

  const metadataFile = path.join(BASELINES_DIR, 'metadata.json');
  fs.writeFileSync(metadataFile, JSON.stringify(metadata, null, 2), 'utf-8');
  console.log(`\n✓ Metadata saved to: ${metadataFile}`);
}

/**
 * Main function
 */
function main(): void {
  console.log('🔨 Generating regression test baselines...\n');

  ensureBaselinesDir();

  const fixtureFiles = getFixtureFiles();
  if (fixtureFiles.length === 0) {
    console.log('No fixture files found.');
    return;
  }

  console.log(`Found ${fixtureFiles.length} fixture file(s)\n`);

  const baselines = fixtureFiles.map(generateBaseline);

  generateMetadata(baselines);

  const successful = baselines.filter(b => b.success).length;
  const failed = baselines.filter(b => !b.success).length;

  console.log('\n' + '='.repeat(50));
  console.log(`✓ Successful: ${successful}`);
  console.log(`✗ Failed: ${failed}`);
  console.log(`📊 Total: ${baselines.length}`);
  console.log('='.repeat(50));

  if (failed > 0) {
    console.log('\nFailed files:');
    baselines.filter(b => !b.success).forEach(b => {
      console.log(`  - ${path.basename(b.inputFile)}: ${b.error}`);
    });
    process.exit(1);
  }

  console.log('\n✅ All baselines generated successfully!');
}

main();
