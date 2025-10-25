/**
 * ts2pas - TypeScript to DWScript Pascal Converter
 *
 * Main entry point for the library API
 */

import { parseTypeScriptDefinition } from './parser/index.js';
import { transformSourceFile } from './ast/index.js';
import { PascalCodeGenerator } from './codegen/index.js';

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
  /** Whether to mark classes as external (for DWScript) */
  externalClasses?: boolean;
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
    externalClasses = true,
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

  // Transform TypeScript AST to Pascal AST
  const pascalUnit = transformSourceFile(parseResult.sourceFile, {
    typeMapping,
    externalClasses,
    style,
  });

  if (verbose) {
    console.log(`Transformed to ${pascalUnit.interfaceDeclarations.length} Pascal declarations`);
  }

  // Update unit name with namespace prefix
  const unitName = generateUnitName(fileName, namespacePrefix);
  pascalUnit.name = unitName;

  // Add header comment
  const headerComment = [
    '(*',
    ' * Auto-generated from TypeScript definitions',
    ` * Source: ${fileName}`,
    ' * Generator: ts2pas v1.0.0-alpha.1',
    ' *)',
  ].join('\n' + ' '.repeat(indentSize));

  // Generate Pascal code
  const codeGenerator = new PascalCodeGenerator({
    indentSize,
    style,
  });

  let pascalCode = codeGenerator.generateUnit(pascalUnit);

  // Insert header comment after unit declaration
  const lines = pascalCode.split('\n');
  const interfaceIndex = lines.findIndex((line) => line.trim() === 'interface');

  if (interfaceIndex !== -1) {
    lines.splice(interfaceIndex + 1, 0, '', headerComment, '');
    pascalCode = lines.join('\n');
  }

  return pascalCode;
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

  // Ensure it starts with a letter
  if (/^\d/.test(name)) {
    name = 'U_' + name;
  }

  // Capitalize first letter of the base name
  name = name.charAt(0).toUpperCase() + name.slice(1);

  // Add prefix
  if (prefix && !name.startsWith(prefix)) {
    name = prefix + '_' + name;
  }

  return name;
}

// Export types and interfaces for public API
export * from './types.js';
export * from './parser/index.js';
export * from './ast/index.js';
