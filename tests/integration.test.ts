import { describe, it, expect } from 'vitest';
import { readFile } from 'fs/promises';
import { resolve } from 'path';
import { convertTypeScriptToPascal } from '../src/index.js';
import { parseTypeScriptDefinition, DeclarationKind } from '../src/parser/index.js';

describe('Integration Tests', () => {
  describe('Sample TypeScript Definition', () => {
    it('should parse the sample.d.ts file', async () => {
      const filePath = resolve(__dirname, 'fixtures/input/sample.d.ts');
      const content = await readFile(filePath, 'utf-8');

      const result = parseTypeScriptDefinition(content, {
        fileName: 'sample.d.ts',
      });

      expect(result.declarations.length).toBeGreaterThan(0);

      // Check for expected declarations
      const names = result.declarations.map((d) => d.name);
      expect(names).toContain('Person');
      expect(names).toContain('User');
      expect(names).toContain('greet');
      expect(names).toContain('UserID');
      expect(names).toContain('Status');

      // Check declaration types
      const person = result.declarations.find((d) => d.name === 'Person');
      expect(person?.kind).toBe(DeclarationKind.Interface);
      expect(person?.isExported).toBe(true);

      const user = result.declarations.find((d) => d.name === 'User');
      expect(user?.kind).toBe(DeclarationKind.Class);
      expect(user?.isExported).toBe(true);

      const greet = result.declarations.find((d) => d.name === 'greet');
      expect(greet?.kind).toBe(DeclarationKind.Function);

      const userID = result.declarations.find((d) => d.name === 'UserID');
      expect(userID?.kind).toBe(DeclarationKind.TypeAlias);

      const status = result.declarations.find((d) => d.name === 'Status');
      expect(status?.kind).toBe(DeclarationKind.Enum);
    });

    it('should convert sample.d.ts to Pascal', async () => {
      const filePath = resolve(__dirname, 'fixtures/input/sample.d.ts');
      const content = await readFile(filePath, 'utf-8');

      const pascalCode = convertTypeScriptToPascal(content, {
        fileName: 'sample',
        indentSize: 2,
        style: 'dws',
        namespacePrefix: 'JS',
      });

      // Check that the output is valid Pascal structure
      expect(pascalCode).toContain('unit JS_Sample;');
      expect(pascalCode).toContain('interface');
      expect(pascalCode).toContain('implementation');
      expect(pascalCode).toContain('end.');

      // Check that declarations are mentioned
      expect(pascalCode).toContain('Person');
      expect(pascalCode).toContain('User');
      expect(pascalCode).toContain('greet');
      expect(pascalCode).toContain('UserID');
      expect(pascalCode).toContain('Status');

      // Check for header comment
      expect(pascalCode).toContain('Auto-generated');
      expect(pascalCode).toContain('ts2pas');
    });

    it('should handle verbose mode', async () => {
      const filePath = resolve(__dirname, 'fixtures/input/sample.d.ts');
      const content = await readFile(filePath, 'utf-8');

      // Capture console output
      const logs: string[] = [];
      const originalLog = console.log;
      console.log = (...args: any[]) => {
        logs.push(args.join(' '));
      };

      try {
        convertTypeScriptToPascal(content, {
          fileName: 'sample',
          verbose: true,
        });

        expect(logs.length).toBeGreaterThan(0);
        expect(logs.some((log) => log.includes('Parsed'))).toBe(true);
        expect(logs.some((log) => log.includes('declarations'))).toBe(true);
      } finally {
        console.log = originalLog;
      }
    });
  });

  describe('Complex TypeScript Features', () => {
    it('should handle generic classes', () => {
      const code = `
        export class Container<T> {
          value: T;
          getValue(): T;
        }
      `;

      const result = parseTypeScriptDefinition(code);
      const container = result.declarations.find((d) => d.name === 'Container');

      expect(container).toBeDefined();
      expect(container?.metadata?.typeParameters).toEqual(['T']);
    });

    it('should handle interfaces with extends', () => {
      const code = `
        export interface Animal {
          name: string;
        }
        export interface Dog extends Animal {
          bark(): void;
        }
      `;

      const result = parseTypeScriptDefinition(code);
      const dog = result.declarations.find((d) => d.name === 'Dog');

      expect(dog).toBeDefined();
      expect(dog?.metadata?.heritage).toBeDefined();
      expect((dog?.metadata?.heritage as string[]).length).toBeGreaterThan(0);
    });

    it('should handle namespaces', () => {
      const code = `
        export namespace Utils {
          export function helper(): void;
          export const constant = 42;
        }
      `;

      const result = parseTypeScriptDefinition(code);
      const utils = result.declarations.find((d) => d.name === 'Utils');

      expect(utils).toBeDefined();
      expect(utils?.kind).toBe(DeclarationKind.Module);
    });

    it('should handle const enums', () => {
      const code = `
        export const enum Direction {
          Up,
          Down,
          Left,
          Right,
        }
      `;

      const result = parseTypeScriptDefinition(code);
      const direction = result.declarations.find((d) => d.name === 'Direction');

      expect(direction).toBeDefined();
      expect(direction?.kind).toBe(DeclarationKind.Enum);
      expect(direction?.metadata?.isConst).toBe(true);
    });

    it('should handle abstract classes', () => {
      const code = `
        export abstract class Shape {
          abstract getArea(): number;
        }
      `;

      const result = parseTypeScriptDefinition(code);
      const shape = result.declarations.find((d) => d.name === 'Shape');

      expect(shape).toBeDefined();
      expect(shape?.metadata?.isAbstract).toBe(true);
    });
  });

  describe('Unit Name Generation', () => {
    it('should generate valid unit names', () => {
      const testCases = [
        { input: 'my-module.d.ts', expected: /unit JS_My_module;/ },
        { input: 'react.d.ts', expected: /unit JS_React;/ },
        { input: '123invalid.d.ts', expected: /unit JS_U_123invalid;/ },
        { input: 'CamelCase.d.ts', expected: /unit JS_CamelCase;/ },
      ];

      for (const { input, expected } of testCases) {
        const code = 'export interface Test {}';
        const result = convertTypeScriptToPascal(code, {
          fileName: input,
          namespacePrefix: 'JS',
        });

        expect(result).toMatch(expected);
      }
    });

    it('should handle file names without extensions', () => {
      const code = 'export interface Test {}';
      const result = convertTypeScriptToPascal(code, {
        fileName: 'MyModule',
        namespacePrefix: 'JS',
      });

      expect(result).toContain('unit JS_MyModule;');
    });
  });
});
