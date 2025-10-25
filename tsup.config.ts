import { defineConfig } from 'tsup';

export default defineConfig({
  entry: {
    cli: 'src/cli.ts',
    index: 'src/index.ts',
  },
  format: ['esm'],
  target: 'node18',
  platform: 'node',

  // Output options
  outDir: 'dist',
  clean: true,

  // Type declarations
  dts: true,

  // Source maps for debugging
  sourcemap: true,

  // Minification (disable for development)
  minify: false,

  // Splitting for better tree-shaking
  splitting: false,

  // Shims
  shims: true,

  // Banner to make CLI executable
  banner: {
    js: '#!/usr/bin/env node',
  },

  // External dependencies (don't bundle these)
  external: [],

  // Watch mode options
  onSuccess: async () => {
    console.log('✓ Build completed successfully');
  },
});
