/**
 * TypeScript Reference Directive Parser
 *
 * Handles parsing of /// <reference> directives from TypeScript files
 */

export interface ReferenceDirective {
  /** Type of reference: 'path' for local files, 'types' for package references */
  type: 'path' | 'types';
  /** The referenced path or package name */
  value: string;
  /** Original line for debugging */
  originalLine: string;
}

/**
 * Parse TypeScript reference directives from source content
 *
 * Handles:
 * - /// <reference path="./file.d.ts" />
 * - /// <reference types="package-name" />
 *
 * @param content - TypeScript source content
 * @returns Array of parsed reference directives
 */
export function parseReferenceDirectives(content: string): ReferenceDirective[] {
  const references: ReferenceDirective[] = [];
  const lines = content.split('\n');

  // Regex patterns for reference directives
  const pathRegex = /\/\/\/\s*<reference\s+path\s*=\s*["']([^"']+)["']\s*\/>/i;
  const typesRegex = /\/\/\/\s*<reference\s+types\s*=\s*["']([^"']+)["']\s*\/>/i;

  for (const line of lines) {
    const trimmedLine = line.trim();

    // Check for path reference
    const pathMatch = trimmedLine.match(pathRegex);
    if (pathMatch) {
      references.push({
        type: 'path',
        value: pathMatch[1],
        originalLine: line,
      });
      continue;
    }

    // Check for types reference
    const typesMatch = trimmedLine.match(typesRegex);
    if (typesMatch) {
      references.push({
        type: 'types',
        value: typesMatch[1],
        originalLine: line,
      });
    }
  }

  return references;
}

/**
 * Normalize a reference path for use in URLs or file systems
 *
 * Converts:
 * - "./JQuery.d.ts" -> "JQuery.d.ts"
 * - "subdir/file.d.ts" -> "subdir/file.d.ts"
 *
 * @param path - Reference path from directive
 * @returns Normalized path
 */
export function normalizeReferencePath(path: string): string {
  // Remove leading ./ if present
  return path.replace(/^\.\//, '');
}

/**
 * Convert a reference path to a Pascal unit name
 *
 * Examples:
 * - "JQuery.d.ts" -> "JQuery"
 * - "subdir/Module.d.ts" -> "Subdir_Module"
 * - "some-file.d.ts" -> "Some_File"
 *
 * @param path - Reference path or package name
 * @param prefix - Namespace prefix (e.g., "JS")
 * @returns Valid Pascal unit name
 */
export function referenceToUnitName(path: string, prefix: string = 'JS'): string {
  // Remove .d.ts extension
  let name = path.replace(/\.d\.ts$/, '').replace(/\.ts$/, '');

  // Replace directory separators with underscores
  name = name.replace(/[\/\\]/g, '_');

  // Sanitize for Pascal identifier (replace invalid chars with underscores)
  name = name.replace(/[^a-zA-Z0-9_]/g, '_');

  // Remove leading underscores
  name = name.replace(/^_+/, '');

  // Capitalize first letter of each word (after underscores)
  name = name
    .split('_')
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join('_');

  // Ensure it starts with a letter
  if (/^\d/.test(name)) {
    name = 'U_' + name;
  }

  // Add prefix if not already present
  if (prefix && !name.startsWith(prefix + '_')) {
    name = prefix + '_' + name;
  }

  return name;
}

/**
 * Extract the package name from a types reference
 *
 * @param typesRef - The types reference value
 * @returns Package name for DefinitelyTyped lookup
 */
export function getPackageNameFromTypesRef(typesRef: string): string {
  // Types references are already package names (e.g., "sizzle" -> "@types/sizzle")
  return typesRef;
}
