/**
 * Configuration management for ts2pas
 */

import { readFile } from 'fs/promises';
import { resolve, dirname } from 'path';
import { existsSync } from 'fs';
import { Ts2PasConfig, validateConfig, mergeConfig, DEFAULT_CONFIG } from './schema.js';

export * from './schema.js';

/**
 * Default config file names to search for
 */
const DEFAULT_CONFIG_FILES = [
  'ts2pas.config.json',
  '.ts2pasrc',
  '.ts2pasrc.json',
];

/**
 * Load configuration from a file
 */
export async function loadConfigFile(configPath: string): Promise<Ts2PasConfig> {
  try {
    const content = await readFile(configPath, 'utf-8');
    const parsed = JSON.parse(content);
    return validateConfig(parsed);
  } catch (error) {
    if (error instanceof SyntaxError) {
      throw new Error(`Invalid JSON in config file ${configPath}: ${error.message}`);
    }
    throw new Error(`Failed to load config from ${configPath}: ${error instanceof Error ? error.message : String(error)}`);
  }
}

/**
 * Find and load configuration file from current directory or parents
 */
export async function findConfigFile(startDir: string = process.cwd()): Promise<Ts2PasConfig | null> {
  let currentDir = resolve(startDir);
  const root = dirname(currentDir);

  // Search up the directory tree
  while (true) {
    // Try each default config file name
    for (const configFile of DEFAULT_CONFIG_FILES) {
      const configPath = resolve(currentDir, configFile);
      if (existsSync(configPath)) {
        try {
          return await loadConfigFile(configPath);
        } catch (error) {
          // Log error but continue searching
          if (process.env.DEBUG) {
            console.error(`Failed to load ${configPath}:`, error);
          }
        }
      }
    }

    // Move to parent directory
    const parentDir = dirname(currentDir);
    if (parentDir === currentDir || currentDir === root) {
      // Reached root
      break;
    }
    currentDir = parentDir;
  }

  return null;
}

/**
 * Load configuration with the following priority:
 * 1. Explicit config file path (if provided)
 * 2. Auto-discovered config file in current directory or parents
 * 3. Default configuration
 */
export async function loadConfig(options: {
  configPath?: string;
  cwd?: string;
}): Promise<Ts2PasConfig> {
  // If explicit config path provided, load it
  if (options.configPath) {
    return await loadConfigFile(resolve(options.cwd || process.cwd(), options.configPath));
  }

  // Try to find config file automatically
  const foundConfig = await findConfigFile(options.cwd);
  if (foundConfig) {
    return foundConfig;
  }

  // Return empty config (defaults will be applied later)
  return {};
}

/**
 * Merge CLI options with configuration file
 * CLI options take precedence over config file
 */
export function mergeCliOptions(
  config: Ts2PasConfig,
  cliOptions: {
    indent?: string | number;
    style?: string;
    namespacePrefix?: string;
    verbose?: boolean;
  }
): Ts2PasConfig {
  const merged: Ts2PasConfig = { ...config };

  // CLI options override config file
  if (cliOptions.indent !== undefined) {
    merged.indentSize = typeof cliOptions.indent === 'string'
      ? parseInt(cliOptions.indent, 10)
      : cliOptions.indent;
  }

  if (cliOptions.style !== undefined) {
    if (cliOptions.style === 'dws' || cliOptions.style === 'pas2js') {
      merged.style = cliOptions.style;
    }
  }

  if (cliOptions.namespacePrefix !== undefined) {
    merged.namespacePrefix = cliOptions.namespacePrefix;
  }

  if (cliOptions.verbose !== undefined) {
    merged.verbose = cliOptions.verbose;
  }

  return merged;
}

/**
 * Get final configuration with defaults applied
 */
export function getFinalConfig(config: Ts2PasConfig): Required<Omit<Ts2PasConfig, 'typeMappings' | 'exclude' | 'include' | 'outputDir' | 'watch'>> & Partial<Pick<Ts2PasConfig, 'typeMappings' | 'exclude' | 'include' | 'outputDir' | 'watch'>> {
  return mergeConfig(config);
}

export { DEFAULT_CONFIG };
