import { describe, it, expect } from 'vitest';
import {
  parseTypeScriptDefinition,
  DeclarationKind,
  type ParsedDeclaration,
} from '../src/parser/index.js';
import { TypeHandler } from '../src/parser/types.js';
import * as ts from 'typescript';

describe('TypeScript Parser', () => {
  describe('parseTypeScriptDefinition', () => {
    it('should parse an empty file', () => {
      const result = parseTypeScriptDefinition('');

      expect(result.sourceFile).toBeDefined();
      expect(result.declarations).toEqual([]);
      expect(result.diagnostics).toBeDefined();
    });

    it('should parse a simple interface', () => {
      const code = `
        export interface Person {
          name: string;
          age: number;
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.Interface);
      expect(result.declarations[0]?.name).toBe('Person');
      expect(result.declarations[0]?.isExported).toBe(true);
      expect(result.declarations[0]?.metadata?.members).toBe(2);
    });

    it('should parse a class declaration', () => {
      const code = `
        export class User {
          constructor(name: string, email: string);
          getName(): string;
          setName(name: string): void;
          static createDefault(): User;
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      const classDecl = result.declarations[0];
      expect(classDecl?.kind).toBe(DeclarationKind.Class);
      expect(classDecl?.name).toBe('User');
      expect(classDecl?.isExported).toBe(true);
      expect(classDecl?.metadata?.members).toBe(4); // constructor + 3 methods
    });

    it('should parse a function declaration', () => {
      const code = `
        export function greet(person: string): string;
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.Function);
      expect(result.declarations[0]?.name).toBe('greet');
      expect(result.declarations[0]?.metadata?.parameters).toBe(1);
      expect(result.declarations[0]?.metadata?.returnType).toBe('string');
    });

    it('should parse a type alias', () => {
      const code = `
        export type UserID = string | number;
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.TypeAlias);
      expect(result.declarations[0]?.name).toBe('UserID');
      expect(result.declarations[0]?.metadata?.type).toBe('string | number');
    });

    it('should parse an enum', () => {
      const code = `
        export enum Status {
          Active = 1,
          Inactive = 0,
          Pending = 2,
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.Enum);
      expect(result.declarations[0]?.name).toBe('Status');
      expect(result.declarations[0]?.metadata?.members).toBe(3);
    });

    it('should parse a namespace/module', () => {
      const code = `
        export namespace Utils {
          export function helper(): void;
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.Module);
      expect(result.declarations[0]?.name).toBe('Utils');
    });

    it('should parse imports', () => {
      const code = `
        import { Something } from 'some-module';
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      expect(result.declarations[0]?.kind).toBe(DeclarationKind.Import);
      expect(result.declarations[0]?.name).toBe('some-module');
    });

    it('should parse generic interfaces', () => {
      const code = `
        export interface Container<T> {
          value: T;
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      const decl = result.declarations[0];
      expect(decl?.kind).toBe(DeclarationKind.Interface);
      expect(decl?.metadata?.typeParameters).toEqual(['T']);
    });

    it('should parse class with heritage', () => {
      const code = `
        export class Admin extends User implements Privileged {
          // ...
        }
      `;

      const result = parseTypeScriptDefinition(code);

      expect(result.declarations).toHaveLength(1);
      const decl = result.declarations[0];
      expect(decl?.kind).toBe(DeclarationKind.Class);
      expect(decl?.metadata?.heritage).toBeDefined();
      expect((decl?.metadata?.heritage as string[]).length).toBeGreaterThan(0);
    });
  });

  describe('TypeHandler', () => {
    const createSourceFile = (code: string): ts.SourceFile => {
      return ts.createSourceFile('test.ts', code, ts.ScriptTarget.Latest, true);
    };

    const getFirstTypeNode = (code: string): ts.TypeNode => {
      const sourceFile = createSourceFile(code);
      let typeNode: ts.TypeNode | undefined;

      ts.forEachChild(sourceFile, (node) => {
        if (ts.isTypeAliasDeclaration(node)) {
          typeNode = node.type;
        } else if (ts.isInterfaceDeclaration(node)) {
          const prop = node.members[0];
          if (prop && ts.isPropertySignature(prop)) {
            typeNode = prop.type;
          }
        }
      });

      if (!typeNode) {
        throw new Error('No type node found');
      }

      return typeNode;
    };

    describe('primitive types', () => {
      it('should convert string type', () => {
        const handler = new TypeHandler();
        const code = 'type T = string;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('String');
      });

      it('should convert number type', () => {
        const handler = new TypeHandler();
        const code = 'type T = number;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Float');
      });

      it('should convert boolean type', () => {
        const handler = new TypeHandler();
        const code = 'type T = boolean;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Boolean');
      });

      it('should convert any type', () => {
        const handler = new TypeHandler();
        const code = 'type T = any;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Variant');
      });

      it('should convert void type', () => {
        const handler = new TypeHandler();
        const code = 'type T = void;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('');
      });
    });

    describe('array types', () => {
      it('should convert array type', () => {
        const handler = new TypeHandler();
        const code = 'type T = string[];';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('array of String');
      });

      it('should convert Array<T> generic', () => {
        const handler = new TypeHandler();
        const code = 'type T = Array<number>;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('array of Float');
      });

      it('should convert nested arrays', () => {
        const handler = new TypeHandler();
        const code = 'type T = string[][];';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('array of array of String');
      });
    });

    describe('union types', () => {
      it('should convert simple union to Variant', () => {
        const handler = new TypeHandler();
        const code = 'type T = string | number;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Variant');
      });

      it('should handle optional types (T | undefined)', () => {
        const handler = new TypeHandler();
        const code = 'type T = string | undefined;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Should return the non-undefined type
        expect(handler.convertType(typeNode, sourceFile)).toBe('String');
      });

      it('should handle nullable types (T | null)', () => {
        const handler = new TypeHandler();
        const code = 'type T = number | null;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Should return the non-null type
        expect(handler.convertType(typeNode, sourceFile)).toBe('Float');
      });
    });

    describe('generic types', () => {
      it('should convert generic type reference', () => {
        const handler = new TypeHandler();
        const code = 'type T = Container<string>;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Container<String>');
      });

      it('should convert Promise<T>', () => {
        const handler = new TypeHandler();
        const code = 'type T = Promise<string>;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Promises resolve to their value type
        expect(handler.convertType(typeNode, sourceFile)).toBe('String');
      });

      it('should handle Partial<T>', () => {
        const handler = new TypeHandler();
        const code = 'type T = Partial<User>;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Utility types return the underlying type
        expect(handler.convertType(typeNode, sourceFile)).toBe('User');
      });
    });

    describe('custom type mappings', () => {
      it('should use custom mappings', () => {
        const customMappings = new Map([['number', 'Integer']]);
        const handler = new TypeHandler({ customMappings });
        const code = 'type T = number;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Integer');
      });

      it('should use strict number mode', () => {
        const handler = new TypeHandler({ strictNumbers: true });
        const code = 'type T = number;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        expect(handler.convertType(typeNode, sourceFile)).toBe('Integer');
      });
    });

    describe('complex types', () => {
      it('should handle tuple types', () => {
        const handler = new TypeHandler();
        const code = 'type T = [string, number];';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Tuples become arrays
        const result = handler.convertType(typeNode, sourceFile);
        expect(result).toContain('array');
      });

      it('should handle function types', () => {
        const handler = new TypeHandler();
        const code = 'type T = (x: number) => string;';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        const result = handler.convertType(typeNode, sourceFile);
        expect(result).toContain('function');
      });

      it('should handle type literals', () => {
        const handler = new TypeHandler();
        const code = 'type T = { x: number; y: string };';
        const typeNode = getFirstTypeNode(code);
        const sourceFile = createSourceFile(code);

        // Type literals become Variant
        expect(handler.convertType(typeNode, sourceFile)).toBe('Variant');
      });
    });
  });
});
