import { describe, it, expect } from 'vitest';
import * as ts from 'typescript';
import { transformSourceFile } from '../src/ast/index.js';
import { PascalEnum, PascalEnumMember } from '../src/types.js';
import { convertTypeScriptToPascal } from '../src/index.js';

describe('Enum Support', () => {
  const createSourceFile = (code: string): ts.SourceFile => {
    return ts.createSourceFile('test.ts', code, ts.ScriptTarget.Latest, true);
  };

  describe('Basic Enum Transformation', () => {
    it('should transform a simple enum', () => {
      const code = `
        export enum Color {
          Red,
          Green,
          Blue
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      expect(unit.interfaceDeclarations).toHaveLength(1);
      const enumDecl = unit.interfaceDeclarations[0];
      expect(enumDecl).toBeInstanceOf(PascalEnum);

      const pascalEnum = enumDecl as PascalEnum;
      expect(pascalEnum.name).toBe('Color');
      expect(pascalEnum.members).toHaveLength(3);
      expect(pascalEnum.members[0].name).toBe('Red');
      expect(pascalEnum.members[1].name).toBe('Green');
      expect(pascalEnum.members[2].name).toBe('Blue');
    });

    it('should transform enum with numeric values', () => {
      const code = `
        export enum Status {
          Active = 1,
          Inactive = 0,
          Pending = 2
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members[0].value).toBe(1);
      expect(pascalEnum.members[1].value).toBe(0);
      expect(pascalEnum.members[2].value).toBe(2);
    });

    it('should transform enum with string values', () => {
      const code = `
        export enum LogLevel {
          Error = "ERROR",
          Warning = "WARN",
          Info = "INFO"
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members[0].value).toBe('ERROR');
      expect(pascalEnum.members[1].value).toBe('WARN');
      expect(pascalEnum.members[2].value).toBe('INFO');
    });

    it('should handle const enums', () => {
      const code = `
        export const enum Direction {
          Up,
          Down,
          Left,
          Right
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.isConst).toBe(true);
      expect(pascalEnum.members).toHaveLength(4);
    });

    it('should handle enum with computed values', () => {
      const code = `
        export enum FileAccess {
          None = 0,
          Read = 1 << 1,
          Write = 1 << 2,
          ReadWrite = Read | Write
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members).toHaveLength(4);
      // Complex expressions are captured as text
      expect(pascalEnum.members[1].value).toBeDefined();
    });
  });

  describe('Enum Code Generation', () => {
    it('should generate inline format for few members', () => {
      const code = `
        export enum Color {
          Red,
          Green,
          Blue
        }
      `;

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });

      expect(result).toContain('Color = (Red, Green, Blue);');
    });

    it('should generate multiline format for many members', () => {
      const code = `
        export enum Day {
          Monday,
          Tuesday,
          Wednesday,
          Thursday,
          Friday,
          Saturday,
          Sunday
        }
      `;

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });

      expect(result).toContain('Day = (');
      expect(result).toContain('Monday,');
      expect(result).toContain('Tuesday,');
      expect(result).toContain('Sunday');
      expect(result).toContain(');');
    });

    it('should handle enum in interface section', () => {
      const code = `
        export enum Status {
          Active,
          Inactive
        }
      `;

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });

      expect(result).toContain('interface');
      expect(result).toContain('Status = (Active, Inactive);');
      expect(result).toContain('implementation');
    });
  });

  describe('Enum Member Generation', () => {
    it('should generate enum member without value', () => {
      const member = new PascalEnumMember('Red');
      const code = member.toCode(2);
      expect(code).toBe('  Red');
    });

    it('should generate enum member with numeric value', () => {
      const member = new PascalEnumMember('Active', 1);
      const code = member.toCode(2);
      expect(code).toBe('  Active = 1');
    });

    it('should generate enum member with string value', () => {
      const member = new PascalEnumMember('Error', 'ERROR');
      const code = member.toCode(2);
      expect(code).toBe('  Error = ERROR');
    });
  });

  describe('PascalEnum toCode', () => {
    it('should generate code for empty enum', () => {
      const pascalEnum = new PascalEnum('Empty', []);
      const code = pascalEnum.toCode(2);
      expect(code).toBe('  Empty = ();');
    });

    it('should generate code for single member', () => {
      const members = [new PascalEnumMember('Only')];
      const pascalEnum = new PascalEnum('Single', members);
      const code = pascalEnum.toCode(2);
      expect(code).toBe('  Single = (Only);');
    });

    it('should generate code for two members', () => {
      const members = [new PascalEnumMember('First'), new PascalEnumMember('Second')];
      const pascalEnum = new PascalEnum('Two', members);
      const code = pascalEnum.toCode(2);
      expect(code).toBe('  Two = (First, Second);');
    });

    it('should generate code for three members (inline)', () => {
      const members = [
        new PascalEnumMember('A'),
        new PascalEnumMember('B'),
        new PascalEnumMember('C'),
      ];
      const pascalEnum = new PascalEnum('Three', members);
      const code = pascalEnum.toCode(2);
      expect(code).toBe('  Three = (A, B, C);');
    });

    it('should generate multiline code for four members', () => {
      const members = [
        new PascalEnumMember('A'),
        new PascalEnumMember('B'),
        new PascalEnumMember('C'),
        new PascalEnumMember('D'),
      ];
      const pascalEnum = new PascalEnum('Four', members);
      const code = pascalEnum.toCode(2);

      expect(code).toContain('Four = (');
      expect(code).toContain('  A,');
      expect(code).toContain('  B,');
      expect(code).toContain('  C,');
      expect(code).toContain('  D');
      expect(code).toContain(');');
    });

    it('should handle different indentation levels', () => {
      const members = [new PascalEnumMember('Test')];
      const pascalEnum = new PascalEnum('Test', members);

      const code0 = pascalEnum.toCode(0);
      const code4 = pascalEnum.toCode(4);

      expect(code0).toBe('Test = (Test);');
      expect(code4).toBe('    Test = (Test);');
    });
  });

  describe('Mixed Declarations', () => {
    it('should handle enum with interface and class', () => {
      const code = `
        export enum Status {
          Active,
          Inactive
        }

        export interface IUser {
          status: Status;
        }

        export class User {
          constructor(status: Status);
        }
      `;

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });

      expect(result).toContain('Status = (Active, Inactive);');
      expect(result).toContain('IUser = interface');
      expect(result).toContain('User = class');
    });
  });

  describe('Edge Cases', () => {
    it('should handle enum with single member', () => {
      const code = `
        export enum Single {
          Only
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members).toHaveLength(1);

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });
      expect(result).toContain('Single = (Only);');
    });

    it('should handle enum with many members', () => {
      const code = `
        export enum Month {
          January, February, March, April, May, June,
          July, August, September, October, November, December
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members).toHaveLength(12);

      const result = convertTypeScriptToPascal(code, { fileName: 'Test' });
      expect(result).toContain('January,');
      expect(result).toContain('December');
    });

    it('should handle enum with mixed value types', () => {
      const code = `
        export enum Mixed {
          First = 1,
          Second = "two",
          Third = 3
        }
      `;

      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.members[0].value).toBe(1);
      expect(pascalEnum.members[1].value).toBe('two');
      expect(pascalEnum.members[2].value).toBe(3);
    });
  });

  describe('Enum Names', () => {
    it('should preserve enum name', () => {
      const code = `export enum MyEnum { A, B }`;
      const sourceFile = createSourceFile(code);
      const unit = transformSourceFile(sourceFile);

      const pascalEnum = unit.interfaceDeclarations[0] as PascalEnum;
      expect(pascalEnum.name).toBe('MyEnum');
      expect(pascalEnum.getName()).toBe('MyEnum');
    });
  });
});
