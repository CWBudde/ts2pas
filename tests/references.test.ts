import { describe, it, expect } from 'vitest';
import {
  parseReferenceDirectives,
  normalizeReferencePath,
  referenceToUnitName,
  getPackageNameFromTypesRef,
} from '../src/utils/references.js';

describe('Reference Directive Parser', () => {
  describe('parseReferenceDirectives', () => {
    it('should parse path references', () => {
      const content = `
/// <reference path="./JQuery.d.ts" />
/// <reference path="misc.d.ts" />
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(2);
      expect(refs[0]).toEqual({
        type: 'path',
        value: './JQuery.d.ts',
        originalLine: expect.any(String),
      });
      expect(refs[1]).toEqual({
        type: 'path',
        value: 'misc.d.ts',
        originalLine: expect.any(String),
      });
    });

    it('should parse types references', () => {
      const content = `
/// <reference types="sizzle" />
/// <reference types="node" />
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(2);
      expect(refs[0]).toEqual({
        type: 'types',
        value: 'sizzle',
        originalLine: expect.any(String),
      });
      expect(refs[1]).toEqual({
        type: 'types',
        value: 'node',
        originalLine: expect.any(String),
      });
    });

    it('should parse mixed references', () => {
      const content = `
/// <reference types="sizzle" />
/// <reference path="JQueryStatic.d.ts" />
/// <reference path="JQuery.d.ts" />
/// <reference path="misc.d.ts" />
export = jQuery;
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(4);
      expect(refs[0].type).toBe('types');
      expect(refs[1].type).toBe('path');
      expect(refs[2].type).toBe('path');
      expect(refs[3].type).toBe('path');
    });

    it('should handle single and double quotes', () => {
      const content = `
/// <reference path='single.d.ts' />
/// <reference path="double.d.ts" />
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(2);
      expect(refs[0].value).toBe('single.d.ts');
      expect(refs[1].value).toBe('double.d.ts');
    });

    it('should handle extra whitespace', () => {
      const content = `
///   <reference   path  =  "./file.d.ts"   />
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(1);
      expect(refs[0].value).toBe('./file.d.ts');
    });

    it('should ignore non-reference comments', () => {
      const content = `
// This is a comment
/// <reference path="valid.d.ts" />
/* Block comment */
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(1);
      expect(refs[0].value).toBe('valid.d.ts');
    });

    it('should return empty array for content without references', () => {
      const content = `
interface Foo {
  bar(): void;
}
      `;

      const refs = parseReferenceDirectives(content);

      expect(refs).toHaveLength(0);
    });
  });

  describe('normalizeReferencePath', () => {
    it('should remove leading ./', () => {
      expect(normalizeReferencePath('./file.d.ts')).toBe('file.d.ts');
      expect(normalizeReferencePath('./subdir/file.d.ts')).toBe('subdir/file.d.ts');
    });

    it('should leave paths without ./ unchanged', () => {
      expect(normalizeReferencePath('file.d.ts')).toBe('file.d.ts');
      expect(normalizeReferencePath('subdir/file.d.ts')).toBe('subdir/file.d.ts');
    });
  });

  describe('referenceToUnitName', () => {
    it('should convert simple file names', () => {
      expect(referenceToUnitName('JQuery.d.ts', 'JS')).toBe('JS_JQuery');
      expect(referenceToUnitName('misc.d.ts', 'JS')).toBe('JS_Misc');
    });

    it('should handle paths with directories', () => {
      expect(referenceToUnitName('lib/JQuery.d.ts', 'JS')).toBe('JS_Lib_JQuery');
      expect(referenceToUnitName('utils/helpers.d.ts', 'JS')).toBe('JS_Utils_Helpers');
    });

    it('should handle hyphenated names', () => {
      expect(referenceToUnitName('fs-extra.d.ts', 'JS')).toBe('JS_Fs_Extra');
      expect(referenceToUnitName('react-dom.d.ts', 'JS')).toBe('JS_React_Dom');
    });

    it('should sanitize invalid characters', () => {
      expect(referenceToUnitName('file@name.d.ts', 'JS')).toBe('JS_File_Name');
      expect(referenceToUnitName('file.name.d.ts', 'JS')).toBe('JS_File_Name');
    });

    it('should handle numeric prefixes', () => {
      expect(referenceToUnitName('3d-utils.d.ts', 'JS')).toBe('JS_U_3d_Utils');
    });

    it('should work without .d.ts extension', () => {
      expect(referenceToUnitName('sizzle', 'JS')).toBe('JS_Sizzle');
    });

    it('should use provided prefix', () => {
      expect(referenceToUnitName('test.d.ts', 'MY')).toBe('MY_Test');
      expect(referenceToUnitName('test.d.ts', '')).toBe('Test');
    });

    it('should handle windows paths', () => {
      expect(referenceToUnitName('lib\\JQuery.d.ts', 'JS')).toBe('JS_Lib_JQuery');
    });
  });

  describe('getPackageNameFromTypesRef', () => {
    it('should return package name as-is', () => {
      expect(getPackageNameFromTypesRef('sizzle')).toBe('sizzle');
      expect(getPackageNameFromTypesRef('node')).toBe('node');
      expect(getPackageNameFromTypesRef('react')).toBe('react');
    });
  });
});
