#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

const TOP_10_PACKAGES = [
  '@types/node',
  '@types/react',
  '@types/lodash',
  '@types/express',
  '@types/react-dom',
  '@types/jest',
  '@types/jquery',
  '@types/fs-extra',
  '@types/yargs',
  '@types/cordova',
];

// Run the conversion
convertMultiplePackages(TOP_10_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
