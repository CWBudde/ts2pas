/**
 * Content Analysis Utilities
 *
 * Analyzes TypeScript definition files to determine characteristics
 * such as whether they are re-export manifests
 */

import * as ts from 'typescript';
import { parseReferenceDirectives } from './references.js';

export interface ContentAnalysis {
  /** Total number of declarations */
  totalDeclarations: number;
  /** Number of meaningful declarations (non-empty interfaces, types, etc.) */
  meaningfulDeclarations: number;
  /** Number of empty interfaces */
  emptyInterfaces: number;
  /** Number of reference directives */
  referenceCount: number;
  /** Lines of actual code (excluding comments and whitespace) */
  codeLines: number;
  /** Total lines */
  totalLines: number;
  /** Number of import statements */
  importCount: number;
  /** Number of export statements */
  exportCount: number;
  /** Whether this is an import re-export (import X; export = X) */
  isImportReExport: boolean;
  /** Module name being re-exported (if applicable) */
  reExportModuleName?: string;
  /** Whether this appears to be a re-export manifest */
  isReExportManifest: boolean;
  /** Confidence score (0-100) that this is a re-export manifest */
  manifestConfidence: number;
}

/**
 * Analyze TypeScript content to determine if it's a re-export manifest
 *
 * A file is considered a re-export manifest if:
 * - It has multiple reference directives (3+)
 * - It has minimal meaningful content (< 5 declarations)
 * - Most interfaces are empty or have < 2 members
 *
 * @param content - TypeScript source content
 * @param sourceFile - Optional parsed TypeScript source file
 * @returns Content analysis result
 */
export function analyzeContent(
  content: string,
  sourceFile?: ts.SourceFile
): ContentAnalysis {
  // Parse reference directives
  const references = parseReferenceDirectives(content);
  const referenceCount = references.length;

  // Count lines
  const lines = content.split('\n');
  const totalLines = lines.length;

  // Count code lines (non-empty, non-comment lines)
  const codeLines = lines.filter((line) => {
    const trimmed = line.trim();
    return (
      trimmed.length > 0 &&
      !trimmed.startsWith('//') &&
      !trimmed.startsWith('/*') &&
      !trimmed.startsWith('*') &&
      trimmed !== '*/'
    );
  }).length;

  // Analyze declarations if source file provided
  let totalDeclarations = 0;
  let meaningfulDeclarations = 0;
  let emptyInterfaces = 0;
  let importCount = 0;
  let exportCount = 0;
  let isImportReExport = false;
  let reExportModuleName: string | undefined;

  if (sourceFile) {
    const declAnalysis = analyzeDeclarations(sourceFile);
    totalDeclarations = declAnalysis.total;
    meaningfulDeclarations = declAnalysis.meaningful;
    emptyInterfaces = declAnalysis.emptyInterfaces;

    const importExportAnalysis = analyzeImportsExports(sourceFile);
    importCount = importExportAnalysis.importCount;
    exportCount = importExportAnalysis.exportCount;
    isImportReExport = importExportAnalysis.isImportReExport;
    reExportModuleName = importExportAnalysis.reExportModuleName;
  }

  // Calculate if this is a re-export manifest
  const { isManifest, confidence } = determineIfManifest({
    referenceCount,
    totalDeclarations,
    meaningfulDeclarations,
    emptyInterfaces,
    codeLines,
    isImportReExport,
    importCount,
    exportCount,
  });

  return {
    totalDeclarations,
    meaningfulDeclarations,
    emptyInterfaces,
    referenceCount,
    codeLines,
    totalLines,
    importCount,
    exportCount,
    isImportReExport,
    reExportModuleName,
    isReExportManifest: isManifest,
    manifestConfidence: confidence,
  };
}

/**
 * Analyze declarations in a source file
 */
function analyzeDeclarations(sourceFile: ts.SourceFile): {
  total: number;
  meaningful: number;
  emptyInterfaces: number;
} {
  let total = 0;
  let meaningful = 0;
  let emptyInterfaces = 0;

  function visit(node: ts.Node): void {
    // Count top-level declarations
    if (
      ts.isInterfaceDeclaration(node) ||
      ts.isTypeAliasDeclaration(node) ||
      ts.isClassDeclaration(node) ||
      ts.isEnumDeclaration(node) ||
      ts.isFunctionDeclaration(node) ||
      ts.isModuleDeclaration(node)
    ) {
      total++;

      // Check if this is meaningful
      if (ts.isInterfaceDeclaration(node)) {
        const memberCount = node.members.length;
        if (memberCount === 0) {
          emptyInterfaces++;
        } else if (memberCount >= 2) {
          // Interfaces with 2+ members are considered meaningful
          meaningful++;
        }
      } else if (ts.isEnumDeclaration(node)) {
        // Enums with members are meaningful
        if (node.members.length > 0) {
          meaningful++;
        }
      } else if (ts.isClassDeclaration(node)) {
        // Classes with members are meaningful
        if (node.members && node.members.length > 0) {
          meaningful++;
        }
      } else if (ts.isTypeAliasDeclaration(node)) {
        // Non-trivial type aliases are meaningful
        const typeText = node.type.getText(sourceFile);
        if (typeText.length > 10 && !isSimpleTypeAlias(typeText)) {
          meaningful++;
        }
      } else if (ts.isFunctionDeclaration(node)) {
        // Functions are meaningful
        meaningful++;
      } else if (ts.isModuleDeclaration(node)) {
        // Non-empty modules are meaningful
        if (node.body && ts.isModuleBlock(node.body) && node.body.statements.length > 0) {
          meaningful++;
        }
      }
    }

    ts.forEachChild(node, visit);
  }

  ts.forEachChild(sourceFile, visit);

  return { total, meaningful, emptyInterfaces };
}

/**
 * Check if a type alias is simple (just a rename)
 */
function isSimpleTypeAlias(typeText: string): boolean {
  // Simple if it's just a single identifier or primitive
  return /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(typeText.trim()) ||
    ['string', 'number', 'boolean', 'any', 'void', 'unknown', 'never'].includes(typeText.trim());
}

/**
 * Analyze imports and exports in a source file
 */
function analyzeImportsExports(sourceFile: ts.SourceFile): {
  importCount: number;
  exportCount: number;
  isImportReExport: boolean;
  reExportModuleName?: string;
} {
  let importCount = 0;
  let exportCount = 0;
  let importedNames = new Set<string>();
  let exportedNames = new Set<string>();
  let hasExportEquals = false;
  let exportEqualsName: string | undefined;
  let reExportModuleName: string | undefined;

  function visit(node: ts.Node): void {
    // Count import declarations
    if (ts.isImportDeclaration(node)) {
      importCount++;
      // Track named imports
      if (node.importClause) {
        const name = node.importClause.name;
        if (name) {
          importedNames.add(name.text);
        }
      }
    }
    // Count import equals declarations (import x = require("..."))
    else if (ts.isImportEqualsDeclaration(node)) {
      importCount++;
      importedNames.add(node.name.text);

      // Get module name if it's a require
      if (ts.isExternalModuleReference(node.moduleReference)) {
        const expr = node.moduleReference.expression;
        if (ts.isStringLiteral(expr)) {
          reExportModuleName = expr.text;
        }
      }
    }
    // Count export declarations
    else if (ts.isExportDeclaration(node)) {
      exportCount++;
    }
    // Count export assignments (export = X)
    else if (ts.isExportAssignment(node)) {
      exportCount++;
      hasExportEquals = true;

      // Check if it's exporting a simple identifier
      if (ts.isIdentifier(node.expression)) {
        exportEqualsName = node.expression.text;
        exportedNames.add(node.expression.text);
      }
    }

    ts.forEachChild(node, visit);
  }

  ts.forEachChild(sourceFile, visit);

  // Determine if this is an import re-export pattern
  // Pattern: import X = require("Y"); export = X;
  // Or: import X from "Y"; export default X;
  const isImportReExport =
    importCount > 0 &&
    hasExportEquals &&
    exportEqualsName !== undefined &&
    importedNames.has(exportEqualsName);

  return {
    importCount,
    exportCount,
    isImportReExport,
    reExportModuleName: isImportReExport ? reExportModuleName : undefined,
  };
}

/**
 * Determine if content represents a re-export manifest
 */
function determineIfManifest(metrics: {
  referenceCount: number;
  totalDeclarations: number;
  meaningfulDeclarations: number;
  emptyInterfaces: number;
  codeLines: number;
  isImportReExport: boolean;
  importCount: number;
  exportCount: number;
}): { isManifest: boolean; confidence: number } {
  const {
    referenceCount,
    totalDeclarations,
    meaningfulDeclarations,
    emptyInterfaces,
    codeLines,
    isImportReExport,
    importCount,
    exportCount,
  } = metrics;

  let score = 0;
  const weights = {
    importReExport: 80,      // Import and re-export pattern (very strong signal)
    manyReferences: 40,      // 3+ references
    fewDeclarations: 30,     // < 5 meaningful declarations
    mostlyEmpty: 20,         // Most interfaces are empty
    littleCode: 10,          // < 50 lines of code
  };

  // Very strong signal: import re-export pattern
  if (isImportReExport) {
    score += weights.importReExport;
  }

  // High reference count
  if (referenceCount >= 5) {
    score += weights.manyReferences;
  } else if (referenceCount >= 3) {
    score += weights.manyReferences * 0.7;
  } else if (referenceCount >= 1) {
    score += weights.manyReferences * 0.3;
  }

  // Few meaningful declarations
  if (meaningfulDeclarations === 0) {
    score += weights.fewDeclarations;
  } else if (meaningfulDeclarations <= 2) {
    score += weights.fewDeclarations * 0.7;
  } else if (meaningfulDeclarations <= 5) {
    score += weights.fewDeclarations * 0.3;
  }

  // Mostly empty interfaces
  if (totalDeclarations > 0) {
    const emptyRatio = emptyInterfaces / totalDeclarations;
    if (emptyRatio >= 0.8) {
      score += weights.mostlyEmpty;
    } else if (emptyRatio >= 0.5) {
      score += weights.mostlyEmpty * 0.5;
    }
  }

  // Little actual code
  if (codeLines < 30) {
    score += weights.littleCode;
  } else if (codeLines < 50) {
    score += weights.littleCode * 0.5;
  }

  // Determine if it's a manifest (>= 65% confidence)
  const isManifest = score >= 65;

  return { isManifest, confidence: Math.min(100, Math.round(score)) };
}
