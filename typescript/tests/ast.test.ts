import { describe, it, expect } from 'vitest';
import * as ts from 'typescript';
import { transformSourceFile } from '../src/ast/index.js';
import { PascalClass, PascalInterface, PascalEnum, PascalTypeAlias } from '../src/types.js';

describe('AST Transformation', () => {
  const createSourceFile = (code: string): ts.SourceFile => {
    return ts.createSourceFile('test.ts', code, ts.ScriptTarget.Latest, true);
  };

  describe('Class Transformation', () => {
    it('should transform a simple class', () => {
      const code = `
        export class MyClass {
          name: string;
          getValue(): number;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      expect(unit.interfaceDeclarations).toHaveLength(1);
      const classDecl = unit.interfaceDeclarations[0];
      expect(classDecl).toBeInstanceOf(PascalClass);

      const pascalClass = classDecl as PascalClass;
      expect(pascalClass.name).toBe('MyClass');
      expect(pascalClass.members).toHaveLength(2);
      expect(pascalClass.isExternal).toBe(true);
    });

    it('should transform class with constructor', () => {
      const code = `
        export class User {
          constructor(name: string, age: number);
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.members).toHaveLength(1);

      const constructor = pascalClass.members[0];
      expect(constructor.name).toBe('Create');
    });

    it('should transform class with static methods', () => {
      const code = `
        export class Helper {
          static getInstance(): Helper;
          normalMethod(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const staticMethod = pascalClass.members.find((m) => m.name === 'getInstance');
      const normalMethod = pascalClass.members.find((m) => m.name === 'normalMethod');

      expect(staticMethod).toBeDefined();
      expect((staticMethod as any).isStatic).toBe(true);
      expect(normalMethod).toBeDefined();
      expect((normalMethod as any).isStatic).toBe(false);
    });

    it('should transform class with heritage', () => {
      const code = `
        export class Child extends Parent implements IInterface {
          method(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.ancestors).toContain('Parent');
      expect(pascalClass.ancestors).toContain('IInterface');
    });

    it('should handle visibility modifiers', () => {
      const code = `
        export class MyClass {
          public publicMethod(): void;
          private privateMethod(): void;
          protected protectedMethod(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.members).toHaveLength(3);

      const publicM = pascalClass.members.find((m) => m.name === 'publicMethod');
      const privateM = pascalClass.members.find((m) => m.name === 'privateMethod');
      const protectedM = pascalClass.members.find((m) => m.name === 'protectedMethod');

      expect(publicM?.visibility).toBe('public');
      expect(privateM?.visibility).toBe('private');
      expect(protectedM?.visibility).toBe('protected');
    });

    it('should handle readonly properties', () => {
      const code = `
        export class MyClass {
          readonly readonlyProp: string;
          normalProp: number;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const readonlyProp = pascalClass.members.find((m) => m.name === 'readonlyProp');
      const normalProp = pascalClass.members.find((m) => m.name === 'normalProp');

      expect((readonlyProp as any).isReadOnly).toBe(true);
      expect((normalProp as any).isReadOnly).toBe(false);
    });
  });

  describe('Interface Transformation', () => {
    it('should transform a simple interface', () => {
      const code = `
        export interface IPerson {
          name: string;
          age: number;
          greet(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      expect(unit.interfaceDeclarations).toHaveLength(1);
      const interfaceDecl = unit.interfaceDeclarations[0];
      expect(interfaceDecl).toBeInstanceOf(PascalInterface);

      const pascalInterface = interfaceDecl as PascalInterface;
      expect(pascalInterface.name).toBe('IPerson');
      expect(pascalInterface.members).toHaveLength(3);
    });

    it('should transform interface with extends', () => {
      const code = `
        export interface IChild extends IParent, IOther {
          childMethod(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      expect(pascalInterface.ancestors).toContain('IParent');
      expect(pascalInterface.ancestors).toContain('IOther');
    });

    it('should handle interface with optional properties', () => {
      const code = `
        export interface IConfig {
          required: string;
          optional?: number;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      expect(pascalInterface.members).toHaveLength(2);
    });
  });

  describe('Method Transformation', () => {
    it('should transform method with parameters', () => {
      const code = `
        export class Test {
          method(a: string, b: number, c: boolean): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const method = pascalClass.members[0];

      expect(method.name).toBe('method');
      expect((method as any).parameters).toHaveLength(3);
      expect((method as any).parameters[0].name).toBe('a');
      expect((method as any).parameters[0].paramType).toBe('String');
      expect((method as any).parameters[1].paramType).toBe('Float');
      expect((method as any).parameters[2].paramType).toBe('Boolean');
    });

    it('should transform method with return type', () => {
      const code = `
        export class Test {
          getString(): string;
          getNumber(): number;
          noReturn(): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const getString = pascalClass.members.find((m) => m.name === 'getString');
      const getNumber = pascalClass.members.find((m) => m.name === 'getNumber');
      const noReturn = pascalClass.members.find((m) => m.name === 'noReturn');

      expect((getString as any).returnType).toBe('String');
      expect((getNumber as any).returnType).toBe('Float');
      expect((noReturn as any).returnType).toBeUndefined();
    });

    it('should transform method with optional parameters', () => {
      const code = `
        export class Test {
          method(required: string, optional?: number): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const method = pascalClass.members[0];
      const params = (method as any).parameters;

      expect(params[0].isOptional).toBe(false);
      expect(params[1].isOptional).toBe(true);
    });

    it('should transform method with default parameters', () => {
      const code = `
        export class Test {
          method(a: number = 42, b: string = "hello"): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      const method = pascalClass.members[0];
      const params = (method as any).parameters;

      expect(params[0].defaultValue).toBe('42');
      expect(params[1].defaultValue).toBe('"hello"');
    });
  });

  describe('Property Transformation', () => {
    it('should transform properties with correct types', () => {
      const code = `
        export interface Test {
          str: string;
          num: number;
          bool: boolean;
          arr: string[];
          obj: any;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      const str = pascalInterface.members.find((m) => m.name === 'str');
      const num = pascalInterface.members.find((m) => m.name === 'num');
      const bool = pascalInterface.members.find((m) => m.name === 'bool');
      const arr = pascalInterface.members.find((m) => m.name === 'arr');
      const obj = pascalInterface.members.find((m) => m.name === 'obj');

      expect((str as any).propertyType).toBe('String');
      expect((num as any).propertyType).toBe('Float');
      expect((bool as any).propertyType).toBe('Boolean');
      expect((arr as any).propertyType).toBe('array of String');
      expect((obj as any).propertyType).toBe('Variant');
    });
  });

  describe('Type Alias Transformation', () => {
    it('should transform simple type aliases', () => {
      const code = `
        export type StringAlias = string;
        export type NumberAlias = number;
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      expect(unit.interfaceDeclarations).toHaveLength(2);
      const stringAlias = unit.interfaceDeclarations[0] as PascalTypeAlias;
      const numberAlias = unit.interfaceDeclarations[1] as PascalTypeAlias;

      expect(stringAlias.name).toBe('StringAlias');
      expect(stringAlias.targetType).toBe('String');
      expect(numberAlias.name).toBe('NumberAlias');
      expect(numberAlias.targetType).toBe('Float');
    });

    it('should transform union type aliases', () => {
      const code = `
        export type ID = string | number;
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const alias = unit.interfaceDeclarations[0] as PascalTypeAlias;
      expect(alias.targetType).toBe('Variant');
    });

    it('should transform array type aliases', () => {
      const code = `
        export type StringArray = string[];
        export type NumberArray = Array<number>;
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const stringArray = unit.interfaceDeclarations[0] as PascalTypeAlias;
      const numberArray = unit.interfaceDeclarations[1] as PascalTypeAlias;

      expect(stringArray.targetType).toBe('array of String');
      expect(numberArray.targetType).toBe('array of Float');
    });
  });

  describe('Function Transformation', () => {
    it('should transform top-level functions', () => {
      const code = `
        export function add(a: number, b: number): number;
        export function greet(name: string): void;
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      expect(unit.interfaceDeclarations).toHaveLength(2);

      const add = unit.interfaceDeclarations[0];
      const greet = unit.interfaceDeclarations[1];

      expect(add.name).toBe('add');
      expect((add as any).parameters).toHaveLength(2);
      expect((add as any).returnType).toBe('Float');

      expect(greet.name).toBe('greet');
      expect((greet as any).parameters).toHaveLength(1);
      expect((greet as any).returnType).toBeUndefined();
    });
  });

  describe('Generic Types', () => {
    it('should handle generic classes', () => {
      const code = `
        export class Container<T> {
          value: T;
          getValue(): T;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.name).toBe('Container');
      // Generics are preserved in member types
      const value = pascalClass.members.find((m) => m.name === 'value');
      expect(value).toBeDefined();
    });

    it('should handle generic interfaces', () => {
      const code = `
        export interface IList<T> {
          items: T[];
          add(item: T): void;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      expect(pascalInterface.name).toBe('IList');
      expect(pascalInterface.members).toHaveLength(2);
    });
  });

  describe('Complex Types', () => {
    it('should handle nested arrays', () => {
      const code = `
        export interface Test {
          matrix: number[][];
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      const matrix = pascalInterface.members[0];
      expect((matrix as any).propertyType).toBe('array of array of Float');
    });

    it('should handle optional union types', () => {
      const code = `
        export interface Test {
          value: string | null | undefined;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      const value = pascalInterface.members[0];
      // Should extract the non-null type
      expect((value as any).propertyType).toBe('String');
    });
  });

  describe('External Classes', () => {
    it('should mark classes as external by default', () => {
      const code = `export class Test {}`;
      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.isExternal).toBe(true);
    });

    it('should respect externalClasses option', () => {
      const code = `export class Test {}`;
      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile, { externalClasses: false });

      const pascalClass = unit.interfaceDeclarations[0] as PascalClass;
      expect(pascalClass.isExternal).toBe(false);
    });
  });

  describe('Custom Type Mappings', () => {
    it('should use custom type mappings', () => {
      const code = `
        export interface Test {
          value: number;
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile, {
        typeMapping: { number: 'Integer' },
      });

      const pascalInterface = unit.interfaceDeclarations[0] as PascalInterface;
      const value = pascalInterface.members[0];
      expect((value as any).propertyType).toBe('Integer');
    });
  });
});
