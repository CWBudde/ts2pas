import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    // Test environment
    environment: 'node',

    // Coverage configuration
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html', 'lcov'],
      exclude: [
        'node_modules/',
        'dist/',
        'tests/',
        'legacy/',
        'scripts/',
        '**/*.test.ts',
        '**/*.spec.ts',
        '**/types.ts',
        '**/*.config.ts',
        'src/cli.ts', // CLI tested via integration tests
        'src/parser/visitor.ts', // Base visitor classes - not used in production
        'eslint.config.js',
        'tsup.config.ts',
      ],
      include: [
        'src/**/*.ts',
      ],
      all: true,
      lines: 80,
      functions: 80,
      branches: 80,
      statements: 80,
    },

    // Test files
    include: ['tests/**/*.test.ts', 'tests/**/*.spec.ts'],

    // Globals
    globals: true,

    // Timeouts
    testTimeout: 10000,
    hookTimeout: 10000,

    // Reporter
    reporters: ['default'],

    // Watch mode
    watch: false,
  },
});
