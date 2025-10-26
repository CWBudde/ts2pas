#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

// Node.js & Express ecosystem packages (ranks 36-50)
const NODE_EXPRESS_PACKAGES = [
  '@types/body-parser',
  '@types/cors',
  '@types/cookie-parser',
  '@types/morgan',
  '@types/serve-static',
  '@types/express-session',
  '@types/passport',
  '@types/passport-local',
  '@types/passport-jwt',
  '@types/bcrypt',
  '@types/jsonwebtoken',
  '@types/helmet',
  '@types/compression',
  '@types/multer',
  '@types/nodemailer',
];

console.log('Converting Node.js & Express Ecosystem packages (36-50)...\n');
convertMultiplePackages(NODE_EXPRESS_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
