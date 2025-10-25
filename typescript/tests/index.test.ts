import { describe, it, expect } from 'vitest';
import { convertTypeScriptToPascal } from '../src/index.js';
import { sanitizePascalIdentifier, capitalize } from '../src/utils/index.js';

describe('ts2pas basic functionality', () => {
  it('should export the main conversion function', () => {
    expect(convertTypeScriptToPascal).toBeDefined();
    expect(typeof convertTypeScriptToPascal).toBe('function');
  });

  it('should convert TypeScript to Pascal (placeholder)', () => {
    const result = convertTypeScriptToPascal('// TypeScript definition', {
      indentSize: 2,
      style: 'dws',
    });

    expect(result).toContain('unit');
    expect(result).toContain('interface');
    expect(result).toContain('implementation');
    expect(result).toContain('end.');
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
