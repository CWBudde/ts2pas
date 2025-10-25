import { describe, it, expect } from 'vitest';
import { convertTypeScriptToPascal } from '../src/index.js';
import { sanitizePascalIdentifier, capitalize } from '../src/utils/index.js';

describe('ts2pas basic functionality', () => {
  it('should export the main conversion function', () => {
    expect(convertTypeScriptToPascal).toBeDefined();
    expect(typeof convertTypeScriptToPascal).toBe('function');
  });

  it('should convert TypeScript to Pascal', () => {
    const result = convertTypeScriptToPascal('export interface Test { value: string; }', {
      indentSize: 2,
      style: 'dws',
      fileName: 'Test',
    });

    expect(result).toContain('unit');
    expect(result).toContain('interface');
    expect(result).toContain('implementation');
    expect(result).toContain('end.');
    expect(result).toContain('Test');
  });

  it('should parse and identify TypeScript declarations', () => {
    const code = `
      export interface MyInterface {}
      export class MyClass {}
      export function myFunction(): void {}
    `;

    const result = convertTypeScriptToPascal(code, {
      fileName: 'Module',
    });

    expect(result).toContain('MyInterface');
    expect(result).toContain('MyClass');
    expect(result).toContain('myFunction');
  });

  it('should generate proper unit names', () => {
    const result = convertTypeScriptToPascal('', {
      fileName: 'my-module.d.ts',
      namespacePrefix: 'JS',
    });

    expect(result).toMatch(/unit JS_[Mm]y_module;/);
  });

  it('should handle custom namespace prefix', () => {
    const result = convertTypeScriptToPascal('', {
      fileName: 'test',
      namespacePrefix: 'Custom',
    });

    expect(result).toContain('unit Custom_Test;');
  });

  it('should respect indentation size', () => {
    const result = convertTypeScriptToPascal('export interface Test {}', {
      indentSize: 4,
      fileName: 'Test',
    });

    // Check that there's proper indentation in the output
    const lines = result.split('\n');
    const indentedLines = lines.filter((line) => line.startsWith('    '));
    expect(indentedLines.length).toBeGreaterThan(0);
  });
});

describe('utility functions', () => {
  describe('sanitizePascalIdentifier', () => {
    it('should sanitize invalid characters', () => {
      expect(sanitizePascalIdentifier('my-name')).toBe('my_name');
      expect(sanitizePascalIdentifier('my.name')).toBe('my_name');
      expect(sanitizePascalIdentifier('my name')).toBe('my_name');
    });

    it('should handle identifiers starting with numbers', () => {
      expect(sanitizePascalIdentifier('123name')).toBe('_123name');
    });

    it('should escape reserved words', () => {
      expect(sanitizePascalIdentifier('begin')).toBe('_begin');
      expect(sanitizePascalIdentifier('end')).toBe('_end');
      expect(sanitizePascalIdentifier('class')).toBe('_class');
    });

    it('should preserve valid identifiers', () => {
      expect(sanitizePascalIdentifier('MyClass')).toBe('MyClass');
      expect(sanitizePascalIdentifier('_private')).toBe('_private');
    });
  });

  describe('capitalize', () => {
    it('should capitalize first letter', () => {
      expect(capitalize('hello')).toBe('Hello');
      expect(capitalize('world')).toBe('World');
    });

    it('should handle already capitalized strings', () => {
      expect(capitalize('Hello')).toBe('Hello');
    });

    it('should handle empty strings', () => {
      expect(capitalize('')).toBe('');
    });
  });
});
