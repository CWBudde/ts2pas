/**
 * ts2pas - TypeScript to DWScript Pascal Converter
 *
 * Main entry point for the library API
 */

import { parseTypeScriptDefinition } from './parser/index.js';
import { transformSourceFile } from './ast/index.js';
import { PascalCodeGenerator } from './codegen/index.js';
import { parseReferenceDirectives, type ReferenceDirective } from './utils/references.js';
import { analyzeContent, type ContentAnalysis } from './utils/content-analysis.js';

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
  /** Uses clause (list of unit names this unit depends on) */
  usesClause?: string[];
  /** Explicit unit name (overrides generated name from fileName) */
  unitName?: string;
}

/**
 * Result of converting TypeScript to Pascal, including metadata
 */
export interface ConversionResult {
  /** Generated Pascal code */
  pascalCode: string;
  /** Reference directives found in the source */
  references: ReferenceDirective[];
  /** Content analysis (whether it's a re-export manifest, etc.) */
  analysis: ContentAnalysis;
  /** Unit name that was generated */
  unitName: string;
}

/**
 * Convert TypeScript definition file content to Pascal code with metadata
 *
 * @param tsContent - TypeScript definition file content
 * @param options - Conversion options
 * @returns Conversion result with Pascal code and metadata
 */
export function convertTypeScriptToPascalWithMetadata(
  tsContent: string,
  options: ConversionOptions = {}
): ConversionResult {
  const {
    indentSize = 2,
    style = 'dws',
    verbose = false,
    typeMapping = {},
    namespacePrefix = 'JS',
    fileName = 'Converted',
    externalClasses = true,
    usesClause = [],
    unitName: explicitUnitName,
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

  // Parse reference directives
  const references = parseReferenceDirectives(tsContent);

  if (verbose && references.length > 0) {
    console.log(`Found ${references.length} reference directives`);
  }

  // Analyze content
  const analysis = analyzeContent(tsContent, parseResult.sourceFile);

  if (verbose) {
    console.log('Content analysis:', {
      meaningfulDeclarations: analysis.meaningfulDeclarations,
      totalDeclarations: analysis.totalDeclarations,
      referenceCount: analysis.referenceCount,
      isReExportManifest: analysis.isReExportManifest,
      manifestConfidence: `${analysis.manifestConfidence}%`,
    });
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

  // Update unit name with namespace prefix (or use explicit unit name if provided)
  const unitName = explicitUnitName || generateUnitName(fileName, namespacePrefix);
  pascalUnit.name = unitName;

  // Add uses clause if provided
  if (usesClause.length > 0) {
    pascalUnit.usesClause = usesClause;
  }

  // Add header comment
  const headerComment = [
    '(*',
    ' * Auto-generated from TypeScript definitions',
    ` * Source: ${fileName}`,
    ' * Generator: ts2pas v1.0.0-alpha.1',
    ' *)',
  ].join('\n' + ' '.repeat(indentSize));

  // Add warning comment if this is a re-export manifest
  let warningComment = '';
  if (analysis.isImportReExport && analysis.reExportModuleName) {
    // Import re-export pattern (e.g., webpack)
    warningComment = [
      '',
      '(*',
      ' * ⚠️  WARNING: Import Re-export Detected',
      ` * This file imports and re-exports the "${analysis.reExportModuleName}" package.`,
      ' * The actual type definitions are in that package, not in this @types package.',
      ' * To get complete types, you would need to convert the source package itself.',
      ' *)',
      '',
    ].join('\n' + ' '.repeat(indentSize));
  } else if (analysis.isReExportManifest && references.length > 0) {
    // File-based re-export pattern (e.g., lodash)
    warningComment = [
      '',
      '(*',
      ' * ⚠️  WARNING: Re-export Manifest Detected',
      ` * This file contains ${references.length} reference directive(s) to other modules.`,
      ' * Consider using multi-file conversion to get complete type definitions.',
      ' * Referenced modules:',
      ...references.map((ref) => ` *   - ${ref.value}`),
      ' *)',
      '',
    ].join('\n' + ' '.repeat(indentSize));
  }

  // Generate Pascal code
  const codeGenerator = new PascalCodeGenerator({
    indentSize,
    style,
  });

  let pascalCode = codeGenerator.generateUnit(pascalUnit);

  // Insert header comment and warning after unit declaration
  const lines = pascalCode.split('\n');
  const interfaceIndex = lines.findIndex((line) => line.trim() === 'interface');

  if (interfaceIndex !== -1) {
    const commentsToInsert = warningComment ? [headerComment, warningComment] : [headerComment];
    lines.splice(interfaceIndex + 1, 0, '', ...commentsToInsert.join('\n').split('\n'), '');
    pascalCode = lines.join('\n');
  }

  return {
    pascalCode,
    references,
    analysis,
    unitName,
  };
}

/**
 * Convert TypeScript definition file content to Pascal code
 *
 * This is a convenience function that returns only the Pascal code.
 * For detailed metadata including re-export detection, use convertTypeScriptToPascalWithMetadata()
 *
 * @param tsContent - TypeScript definition file content
 * @param options - Conversion options
 * @returns Generated Pascal code
 */
export function convertTypeScriptToPascal(
  tsContent: string,
  options: ConversionOptions = {}
): string {
  const result = convertTypeScriptToPascalWithMetadata(tsContent, options);
  return result.pascalCode;
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
export * from './utils/references.js';
export * from './utils/content-analysis.js';
