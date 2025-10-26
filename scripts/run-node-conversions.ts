#!/usr/bin/env tsx

import { convertNodeModules } from './convert-node-modules.js';

// Core Node.js modules to convert (ordered by importance/usage)
const CORE_NODE_MODULES = [
  'fs',           // File system - most commonly used
  'path',         // Path utilities - essential
  'http',         // HTTP server/client
  'events',       // Event emitter - fundamental
  'buffer',       // Buffer handling
  'stream',       // Streams
  'process',      // Process information
  'util',         // Utilities
];

// Get command line arguments
const args = process.argv.slice(2);

if (args.includes('--all')) {
  // Convert all 15 modules
  const allModules = [
    ...CORE_NODE_MODULES,
    'crypto',       // Cryptography
    'child_process',// Child processes
    'os',           // Operating system
    'net',          // Network
    'url',          // URL parsing
    'querystring',  // Query string
    'timers',       // Timers
  ];
  console.log('Converting all 15 core Node.js modules...');
  convertNodeModules(allModules).catch((error) => {
    console.error('Conversion failed:', error);
    process.exit(1);
  });
} else if (args.length > 0 && !args[0].startsWith('--')) {
  // Convert specific modules
  convertNodeModules(args).catch((error) => {
    console.error('Conversion failed:', error);
    process.exit(1);
  });
} else {
  // Convert top 8 modules by default
  console.log('Converting top 8 core Node.js modules...');
  convertNodeModules(CORE_NODE_MODULES).catch((error) => {
    console.error('Conversion failed:', error);
    process.exit(1);
  });
}
