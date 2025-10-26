#!/usr/bin/env tsx

import { convertMultiplePackages } from './convert-types-package.js';

// React ecosystem packages (ranks 11-25)
const REACT_ECOSYSTEM_PACKAGES = [
  '@types/prop-types',
  '@types/react-router',
  '@types/react-router-dom',
  '@types/react-redux',
  '@types/redux',
  '@types/styled-components',
  '@types/react-select',
  '@types/react-table',
  '@types/react-beautiful-dnd',
  '@types/react-datepicker',
  '@types/react-modal',
  '@types/react-helmet',
  '@types/react-native',
  '@types/react-test-renderer',
  '@types/emotion',
];

console.log('Converting React ecosystem packages (11-25)...\n');
convertMultiplePackages(REACT_ECOSYSTEM_PACKAGES).catch((error) => {
  console.error('Conversion failed:', error);
  process.exit(1);
});
