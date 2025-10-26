#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

// Build Tools & CLI packages (ranks 61-75)
const BUILD_TOOLS_CLI_PACKAGES = [
  '@types/webpack',
  '@types/webpack-env',
  '@types/eslint',
  '@types/prettier',
  '@types/babel__core',
  '@types/babel__traverse',
  '@types/commander',
  '@types/yargs-parser',
  '@types/inquirer',
  '@types/ora',
  '@types/cli-progress',
  '@types/chalk',
  '@types/debug',
  '@types/glob',
  '@types/minimatch',
];

console.log('Converting Build Tools & CLI packages (61-75)...\n');
convertMultiplePackages(BUILD_TOOLS_CLI_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
