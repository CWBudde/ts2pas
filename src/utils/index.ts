/**
 * Utility Functions Module
 */

/**
 * Sanitize a string to be a valid Pascal identifier
 */
export function sanitizePascalIdentifier(name: string): string {
  // Replace invalid characters with underscores
  let sanitized = name.replace(/[^a-zA-Z0-9_]/g, '_');

  // Ensure it doesn't start with a number
  if (/^\d/.test(sanitized)) {
    sanitized = '_' + sanitized;
  }

  // Avoid Pascal reserved words
  const reserved = new Set([
    'and',
    'array',
    'as',
    'asm',
    'begin',
    'case',
    'class',
    'const',
    'constructor',
    'destructor',
    'div',
    'do',
    'downto',
    'else',
    'end',
    'except',
    'exports',
    'file',
    'finalization',
    'finally',
    'for',
    'function',
    'goto',
    'if',
    'implementation',
    'in',
    'inherited',
    'initialization',
    'inline',
    'interface',
    'is',
    'label',
    'library',
    'mod',
    'nil',
    'not',
    'object',
    'of',
    'or',
    'out',
    'packed',
    'procedure',
    'program',
    'property',
    'raise',
    'record',
    'repeat',
    'set',
    'shl',
    'shr',
    'string',
    'then',
    'threadvar',
    'to',
    'try',
    'type',
    'unit',
    'until',
    'uses',
    'var',
    'while',
    'with',
    'xor',
  ]);

  if (reserved.has(sanitized.toLowerCase())) {
    sanitized = '_' + sanitized;
  }

  return sanitized;
}

/**
 * Capitalize the first letter of a string
 */
export function capitalize(str: string): string {
  return str.charAt(0).toUpperCase() + str.slice(1);
}

/**
 * Convert camelCase or PascalCase to snake_case
 */
export function toSnakeCase(str: string): string {
  return str.replace(/([A-Z])/g, '_$1').toLowerCase();
}

/**
 * Convert snake_case to PascalCase
 */
export function toPascalCase(str: string): string {
  return str
    .split('_')
    .map((part) => capitalize(part))
    .join('');
}

/**
 * Check if a string is a valid Pascal identifier
 */
export function isValidPascalIdentifier(name: string): boolean {
  return /^[a-zA-Z_][a-zA-Z0-9_]*$/.test(name);
}

/**
 * Indent text by a specified number of spaces
 */
export function indent(text: string, spaces: number): string {
  const indentation = ' '.repeat(spaces);
  return text
    .split('\n')
    .map((line) => (line.trim() ? indentation + line : line))
    .join('\n');
}
