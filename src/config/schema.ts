/**
 * Configuration schema for ts2pas
 */

export interface Ts2PasConfig {
  /**
   * Indentation size in spaces (default: 2)
   */
  indentSize?: number;

  /**
   * Output style: 'dws' for DWScript or 'pas2js' for pas2js (default: 'dws')
   */
  style?: 'dws' | 'pas2js';

  /**
   * Namespace prefix for generated units (default: 'JS')
   */
  namespacePrefix?: string;

  /**
   * Enable verbose output (default: false)
   */
  verbose?: boolean;

  /**
   * Custom type mappings (TypeScript type -> Pascal type)
   */
  typeMappings?: Record<string, string>;

  /**
   * Files to exclude (glob patterns)
   */
  exclude?: string[];

  /**
   * Files to include (glob patterns)
   */
  include?: string[];

  /**
   * Output directory for batch processing
   */
  outputDir?: string;

  /**
   * Watch mode options
   */
  watch?: {
    /**
     * Debounce delay in milliseconds (default: 100)
     */
    debounce?: number;

    /**
     * Files to watch (glob patterns)
     */
    patterns?: string[];
  };
}

/**
 * Default configuration values
 */
export const DEFAULT_CONFIG: Required<Omit<Ts2PasConfig, 'typeMappings' | 'exclude' | 'include' | 'outputDir' | 'watch'>> = {
  indentSize: 2,
  style: 'dws',
  namespacePrefix: 'JS',
  verbose: false,
};

/**
 * Validate and normalize configuration
 */
export function validateConfig(config: unknown): Ts2PasConfig {
  if (typeof config !== 'object' || config === null) {
    throw new Error('Configuration must be an object');
  }

  const cfg = config as Partial<Ts2PasConfig>;
  const validated: Ts2PasConfig = {};

  // Validate indentSize
  if (cfg.indentSize !== undefined) {
    if (typeof cfg.indentSize !== 'number' || cfg.indentSize < 0 || cfg.indentSize > 8) {
      throw new Error('indentSize must be a number between 0 and 8');
    }
    validated.indentSize = cfg.indentSize;
  }

  // Validate style
  if (cfg.style !== undefined) {
    if (cfg.style !== 'dws' && cfg.style !== 'pas2js') {
      throw new Error('style must be either "dws" or "pas2js"');
    }
    validated.style = cfg.style;
  }

  // Validate namespacePrefix
  if (cfg.namespacePrefix !== undefined) {
    if (typeof cfg.namespacePrefix !== 'string' || !/^[A-Za-z][A-Za-z0-9_]*$/.test(cfg.namespacePrefix)) {
      throw new Error('namespacePrefix must be a valid Pascal identifier (letters, numbers, underscore, starting with letter)');
    }
    validated.namespacePrefix = cfg.namespacePrefix;
  }

  // Validate verbose
  if (cfg.verbose !== undefined) {
    if (typeof cfg.verbose !== 'boolean') {
      throw new Error('verbose must be a boolean');
    }
    validated.verbose = cfg.verbose;
  }

  // Validate typeMappings
  if (cfg.typeMappings !== undefined) {
    if (typeof cfg.typeMappings !== 'object' || cfg.typeMappings === null || Array.isArray(cfg.typeMappings)) {
      throw new Error('typeMappings must be an object');
    }
    // Validate each mapping
    const mappings: Record<string, string> = {};
    for (const [key, value] of Object.entries(cfg.typeMappings)) {
      if (typeof value !== 'string') {
        throw new Error(`typeMappings["${key}"] must be a string`);
      }
      mappings[key] = value;
    }
    validated.typeMappings = mappings;
  }

  // Validate exclude
  if (cfg.exclude !== undefined) {
    if (!Array.isArray(cfg.exclude)) {
      throw new Error('exclude must be an array of strings');
    }
    for (const pattern of cfg.exclude) {
      if (typeof pattern !== 'string') {
        throw new Error('exclude patterns must be strings');
      }
    }
    validated.exclude = cfg.exclude;
  }

  // Validate include
  if (cfg.include !== undefined) {
    if (!Array.isArray(cfg.include)) {
      throw new Error('include must be an array of strings');
    }
    for (const pattern of cfg.include) {
      if (typeof pattern !== 'string') {
        throw new Error('include patterns must be strings');
      }
    }
    validated.include = cfg.include;
  }

  // Validate outputDir
  if (cfg.outputDir !== undefined) {
    if (typeof cfg.outputDir !== 'string') {
      throw new Error('outputDir must be a string');
    }
    validated.outputDir = cfg.outputDir;
  }

  // Validate watch options
  if (cfg.watch !== undefined) {
    if (typeof cfg.watch !== 'object' || cfg.watch === null || Array.isArray(cfg.watch)) {
      throw new Error('watch must be an object');
    }
    const watchConfig: Ts2PasConfig['watch'] = {};

    if (cfg.watch.debounce !== undefined) {
      if (typeof cfg.watch.debounce !== 'number' || cfg.watch.debounce < 0) {
        throw new Error('watch.debounce must be a non-negative number');
      }
      watchConfig.debounce = cfg.watch.debounce;
    }

    if (cfg.watch.patterns !== undefined) {
      if (!Array.isArray(cfg.watch.patterns)) {
        throw new Error('watch.patterns must be an array of strings');
      }
      for (const pattern of cfg.watch.patterns) {
        if (typeof pattern !== 'string') {
          throw new Error('watch.patterns must contain only strings');
        }
      }
      watchConfig.patterns = cfg.watch.patterns;
    }

    validated.watch = watchConfig;
  }

  return validated;
}

/**
 * Merge configuration with defaults
 */
export function mergeConfig(config: Ts2PasConfig): Required<Omit<Ts2PasConfig, 'typeMappings' | 'exclude' | 'include' | 'outputDir' | 'watch'>> & Partial<Pick<Ts2PasConfig, 'typeMappings' | 'exclude' | 'include' | 'outputDir' | 'watch'>> {
  return {
    ...DEFAULT_CONFIG,
    ...config,
  };
}
