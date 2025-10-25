/**
 * ts2pas - TypeScript to DWScript Pascal Converter
 *
 * Main entry point for the library API
 */

import { parseTypeScriptDefinition, DeclarationKind } from './parser/index.js';
import { TypeHandler } from './parser/types.js';
import { PascalUnit } from './types.js';

export interface ConversionOptions {
  /** Indentation size (spaces) */
  indentSize?: number;
  /** Output style: 'dws' for DWScript, 'pas2js' for Pas2JS */
  style?: 'dws' | 'pas2js';
  /** Enable verbose logging */
  verbose?: boolean;
  /** Custom type mappings */
  typeMapping?: Record<string, string>;
  /** Namespace prefix for generated units */
  namespacePrefix?: string;
  /** File name (used for unit name) */
  fileName?: string;
}

/**
 * Convert TypeScript definition file content to Pascal code
 *
 * @param tsContent - TypeScript definition file content
 * @param options - Conversion options
 * @returns Generated Pascal code
 */
export function convertTypeScriptToPascal(
  tsContent: string,
  options: ConversionOptions = {}
): string {
  const {
    indentSize = 2,
    style = 'dws',
    verbose = false,
    typeMapping = {},
    namespacePrefix = 'JS',
    fileName = 'Converted',
  } = options;

  if (verbose) {
    console.log('Conversion options:', { indentSize, style, namespacePrefix });
  }

  // Parse TypeScript definition file
  const parseResult = parseTypeScriptDefinition(tsContent, {
    fileName: fileName.endsWith('.d.ts') ? fileName : `${fileName}.d.ts`,
    includeJsDoc: true,
  });

  if (verbose) {
    console.log(`Parsed ${parseResult.declarations.length} declarations`);
    console.log(
      `Found: ${parseResult.declarations.map((d) => `${d.kind}:${d.name}`).join(', ')}`
    );

    if (parseResult.diagnostics.length > 0) {
      console.warn(`${parseResult.diagnostics.length} diagnostic messages`);
    }
  }

  // Generate unit name from file name
  const unitName = generateUnitName(fileName, namespacePrefix);

  // Create Pascal unit
  const unit = new PascalUnit(unitName, [], []);

  // Add comment header
  const declarations: string[] = [];
  declarations.push('(*');
  declarations.push(` * Auto-generated from TypeScript definitions`);
  declarations.push(` * Source: ${fileName}`);
  declarations.push(` * Generator: ts2pas v1.0.0-alpha.1`);
  declarations.push(' *)');
  declarations.push('');

  // Process declarations
  for (const decl of parseResult.declarations) {
    if (!decl.isExported) {
      // Skip non-exported declarations
      continue;
    }

    switch (decl.kind) {
      case DeclarationKind.Class:
        declarations.push(`// Class: ${decl.name}`);
        declarations.push(`// TODO: Implement class conversion`);
        declarations.push('');
        break;

      case DeclarationKind.Interface:
        declarations.push(`// Interface: ${decl.name}`);
        declarations.push(`// TODO: Implement interface conversion`);
        declarations.push('');
        break;

      case DeclarationKind.Function:
        declarations.push(`// Function: ${decl.name}`);
        declarations.push(`// TODO: Implement function conversion`);
        declarations.push('');
        break;

      case DeclarationKind.TypeAlias:
        declarations.push(`// Type alias: ${decl.name} = ${decl.metadata?.type}`);
        declarations.push(`// TODO: Implement type alias conversion`);
        declarations.push('');
        break;

      case DeclarationKind.Enum:
        declarations.push(`// Enum: ${decl.name}`);
        declarations.push(`// TODO: Implement enum conversion`);
        declarations.push('');
        break;

      case DeclarationKind.Variable:
        declarations.push(`// Variable: ${decl.name}`);
        declarations.push(`// TODO: Implement variable conversion`);
        declarations.push('');
        break;

      case DeclarationKind.Module:
        declarations.push(`// Module/Namespace: ${decl.name}`);
        declarations.push(`// TODO: Implement module conversion`);
        declarations.push('');
        break;

      default:
        // Skip imports/exports for now
        break;
    }
  }

  // Build the Pascal unit
  const indent = ' '.repeat(indentSize);
  let output = `unit ${unitName};\n\n`;
  output += 'interface\n\n';
  output += declarations.map((line) => (line ? indent + line : '')).join('\n');
  output += '\n\nimplementation\n\n';
  output += 'end.\n';

  return output;
}

/**
 * Generate a valid Pascal unit name from a file name
 */
function generateUnitName(fileName: string, prefix: string): string {
  // Remove extension
  let name = fileName.replace(/\.d\.ts$/, '').replace(/\.ts$/, '');

  // Get base name (remove path)
  name = name.split('/').pop() || 'Converted';
  name = name.split('\\').pop() || 'Converted';

  // Sanitize for Pascal identifier
  name = name.replace(/[^a-zA-Z0-9_]/g, '_');

  // Add prefix
  if (prefix && !name.startsWith(prefix)) {
    name = prefix + '_' + name;
  }

  // Ensure it starts with a letter
  if (/^\d/.test(name)) {
    name = 'U_' + name;
  }

  // Capitalize first letter
  name = name.charAt(0).toUpperCase() + name.slice(1);

  return name;
}

// Export types and interfaces for public API
export * from './types.js';
export * from './parser/index.js';
