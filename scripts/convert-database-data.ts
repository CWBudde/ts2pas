#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

// Database & Data packages (ranks 51-60)
const DATABASE_DATA_PACKAGES = [
  '@types/mongoose',
  '@types/pg',
  '@types/mysql',
  '@types/redis',
  '@types/mongodb',
  '@types/bluebird',
  '@types/request',
  '@types/axios',
  '@types/ws',
  '@types/socket.io',
];

console.log('Converting Database & Data packages (51-60)...\n');
convertMultiplePackages(DATABASE_DATA_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
