#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

// Testing frameworks packages (ranks 26-35)
const TESTING_FRAMEWORKS_PACKAGES = [
  '@types/mocha',
  '@types/jasmine',
  '@types/chai',
  '@types/sinon',
  '@types/enzyme',
  '@types/supertest',
  '@types/testing-library__react',
  '@types/testing-library__jest-dom',
  '@types/istanbul-reports',
  '@types/json-schema',
];

console.log('Converting Testing Frameworks packages (26-35)...\n');
convertMultiplePackages(TESTING_FRAMEWORKS_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
