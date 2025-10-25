import { describe, it, expect } from 'vitest';
import {
  PascalUnit,
  PascalClass,
  PascalInterface,
  PascalMethod,
  PascalProperty,
  PascalParameter,
  PascalTypeAlias,
  PascalEnum,
  PascalEnumMember,
} from '../src/types.js';
import { PascalCodeGenerator } from '../src/codegen/index.js';

describe('Code Generation', () => {
  describe('PascalCodeGenerator', () => {
    it('should create generator with default options', () => {
      const generator = new PascalCodeGenerator();
      expect(generator).toBeDefined();
    });

    it('should create generator with custom options', () => {
      const generator = new PascalCodeGenerator({
        indentSize: 4,
        style: 'pas2js',
      });
      expect(generator).toBeDefined();
    });

    it('should generate unit with proper structure', () => {
      const unit = new PascalUnit('TestUnit', [], []);
      const generator = new PascalCodeGenerator();
      const code = generator.generateUnit(unit);

      expect(code).toContain('unit TestUnit;');
      expect(code).toContain('interface');
      expect(code).toContain('implementation');
      expect(code).toContain('end.');
    });

    it('should respect indentation size', () => {
      const typeAlias = new PascalTypeAlias('MyType', 'String');
      const unit = new PascalUnit('Test', [], [typeAlias]);

      const generator2 = new PascalCodeGenerator({ indentSize: 2 });
      const code2 = generator2.generateUnit(unit);
      expect(code2).toContain('  MyType = String;');

      const generator4 = new PascalCodeGenerator({ indentSize: 4 });
      const code4 = generator4.generateUnit(unit);
      expect(code4).toContain('    MyType = String;');
    });
  });

  describe('Class Code Generation', () => {
    it('should generate simple class', () => {
      const pascalClass = new PascalClass('MyClass', [], [], true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('MyClass = class external');
      expect(code).toContain('end;');
    });

    it('should generate class with ancestors', () => {
      const pascalClass = new PascalClass('Child', ['Parent', 'IInterface'], [], true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('Child = class(Parent, IInterface) external');
    });

    it('should generate class with members', () => {
      const property = new PascalProperty('name', 'String', false, 'public');
      const method = new PascalMethod('getValue', [], 'String', false, 'public');
      const pascalClass = new PascalClass('MyClass', [], [property, method], true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('property name: String;');
      expect(code).toContain('function getValue: String;');
    });

    it('should generate non-external class', () => {
      const pascalClass = new PascalClass('MyClass', [], [], false);
      const code = pascalClass.toCode(2);

      expect(code).toContain('MyClass = class');
      expect(code).not.toContain('external');
    });
  });

  describe('Interface Code Generation', () => {
    it('should generate simple interface', () => {
      const pascalInterface = new PascalInterface('ITest', [], []);
      const code = pascalInterface.toCode(2);

      expect(code).toContain('ITest = interface');
      expect(code).toContain('end;');
    });

    it('should generate interface with ancestors', () => {
      const pascalInterface = new PascalInterface('IChild', ['IParent', 'IOther'], []);
      const code = pascalInterface.toCode(2);

      expect(code).toContain('IChild = interface(IParent, IOther)');
    });

    it('should generate interface with members', () => {
      const property = new PascalProperty('id', 'Integer', false, 'public');
      const method = new PascalMethod('execute', [], undefined, false, 'public');
      const pascalInterface = new PascalInterface('ICommand', [], [property, method]);
      const code = pascalInterface.toCode(2);

      expect(code).toContain('property id: Integer;');
      expect(code).toContain('procedure execute;');
    });
  });

  describe('Method Code Generation', () => {
    it('should generate procedure without parameters', () => {
      const method = new PascalMethod('doSomething', [], undefined, false, 'public');
      const code = method.toCode(4);

      expect(code).toBe('    procedure doSomething;');
    });

    it('should generate function with return type', () => {
      const method = new PascalMethod('getValue', [], 'Integer', false, 'public');
      const code = method.toCode(4);

      expect(code).toBe('    function getValue: Integer;');
    });

    it('should generate method with parameters', () => {
      const params = [
        new PascalParameter('a', 'String', false),
        new PascalParameter('b', 'Integer', false),
      ];
      const method = new PascalMethod('process', params, 'Boolean', false, 'public');
      const code = method.toCode(4);

      expect(code).toContain('function process(a: String; b: Integer): Boolean;');
    });

    it('should generate static method', () => {
      const method = new PascalMethod('create', [], 'MyClass', true, 'public');
      const code = method.toCode(4);

      expect(code).toContain('function create: MyClass;');
      expect(code).toContain('static');
    });

    it('should handle visibility modifiers', () => {
      const publicMethod = new PascalMethod('pub', [], undefined, false, 'public');
      const privateMethod = new PascalMethod('priv', [], undefined, false, 'private');
      const protectedMethod = new PascalMethod('prot', [], undefined, false, 'protected');

      expect(publicMethod.visibility).toBe('public');
      expect(privateMethod.visibility).toBe('private');
      expect(protectedMethod.visibility).toBe('protected');
    });
  });

  describe('Property Code Generation', () => {
    it('should generate simple property', () => {
      const property = new PascalProperty('name', 'String', false, 'public');
      const code = property.toCode(4);

      expect(code).toBe('    property name: String;');
    });

    it('should generate readonly property', () => {
      const property = new PascalProperty('id', 'Integer', true, 'public');
      const code = property.toCode(4);

      expect(code).toContain('property id: Integer;');
      expect(code).toContain('read only');
    });

    it('should handle different property types', () => {
      const stringProp = new PascalProperty('str', 'String', false, 'public');
      const boolProp = new PascalProperty('flag', 'Boolean', false, 'public');
      const arrayProp = new PascalProperty('items', 'array of String', false, 'public');

      expect(stringProp.toCode(0)).toContain(': String');
      expect(boolProp.toCode(0)).toContain(': Boolean');
      expect(arrayProp.toCode(0)).toContain(': array of String');
    });
  });

  describe('Parameter Code Generation', () => {
    it('should generate simple parameter', () => {
      const param = new PascalParameter('value', 'Integer', false);
      const code = param.toCode(0);

      expect(code).toBe('value: Integer');
    });

    it('should generate optional parameter', () => {
      const param = new PascalParameter('opt', 'String', true);
      const code = param.toCode(0);

      expect(code).toContain('opt?');
      expect(code).toContain(': String');
    });

    it('should generate parameter with default value', () => {
      const param = new PascalParameter('count', 'Integer', false, '42');
      const code = param.toCode(0);

      expect(code).toBe('count: Integer = 42');
    });

    it('should generate optional parameter with default value', () => {
      const param = new PascalParameter('name', 'String', true, '"default"');
      const code = param.toCode(0);

      expect(code).toContain('name?');
      expect(code).toContain('= "default"');
    });
  });

  describe('Type Alias Code Generation', () => {
    it('should generate type alias', () => {
      const alias = new PascalTypeAlias('StringAlias', 'String');
      const code = alias.toCode(2);

      expect(code).toBe('  StringAlias = String;');
    });

    it('should generate array type alias', () => {
      const alias = new PascalTypeAlias('StringArray', 'array of String');
      const code = alias.toCode(2);

      expect(code).toBe('  StringArray = array of String;');
    });

    it('should generate variant type alias', () => {
      const alias = new PascalTypeAlias('AnyType', 'Variant');
      const code = alias.toCode(2);

      expect(code).toBe('  AnyType = Variant;');
    });
  });

  describe('Unit Code Generation', () => {
    it('should generate empty unit', () => {
      const unit = new PascalUnit('EmptyUnit', [], []);
      const code = unit.toCode(0);

      expect(code).toContain('unit EmptyUnit;');
      expect(code).toContain('interface');
      expect(code).toContain('implementation');
      expect(code).toContain('end.');
    });

    it('should generate unit with uses clause', () => {
      const unit = new PascalUnit('TestUnit', ['System', 'SysUtils'], []);
      const code = unit.toCode(0);

      expect(code).toContain('uses');
      expect(code).toContain('System,');
      expect(code).toContain('SysUtils;');
    });

    it('should generate unit with declarations', () => {
      const typeAlias = new PascalTypeAlias('ID', 'Integer');
      const pascalClass = new PascalClass('MyClass', [], [], true);
      const unit = new PascalUnit('TestUnit', [], [typeAlias, pascalClass]);
      const code = unit.toCode(0);

      expect(code).toContain('ID = Integer;');
      expect(code).toContain('MyClass = class external');
    });

    it('should generate unit with implementation code', () => {
      const unit = new PascalUnit('TestUnit', [], [], '// Implementation code here');
      const code = unit.toCode(0);

      expect(code).toContain('implementation');
      expect(code).toContain('// Implementation code here');
    });
  });

  describe('Complex Scenarios', () => {
    it('should generate unit with multiple declaration types', () => {
      const typeAlias = new PascalTypeAlias('StringID', 'String');
      const enumDecl = new PascalEnum('Status', [
        new PascalEnumMember('Active'),
        new PascalEnumMember('Inactive'),
      ]);
      const property = new PascalProperty('name', 'String', false, 'public');
      const interfaceDecl = new PascalInterface('IPerson', [], [property]);
      const method = new PascalMethod('greet', [], 'String', false, 'public');
      const classDecl = new PascalClass('Person', ['IPerson'], [method], true);

      const unit = new PascalUnit('Complex', [], [typeAlias, enumDecl, interfaceDecl, classDecl]);
      const code = unit.toCode(0);

      expect(code).toContain('StringID = String;');
      expect(code).toContain('Status = (Active, Inactive);');
      expect(code).toContain('IPerson = interface');
      expect(code).toContain('Person = class(IPerson) external');
    });

    it('should handle nested structures', () => {
      const param1 = new PascalParameter('callback', 'function: String', false);
      const param2 = new PascalParameter('items', 'array of Integer', false);
      const method = new PascalMethod('process', [param1, param2], 'Boolean', false, 'public');
      const pascalClass = new PascalClass('Processor', [], [method], true);

      const code = pascalClass.toCode(2);

      expect(code).toContain('callback: function: String');
      expect(code).toContain('items: array of Integer');
    });
  });

  describe('Indentation and Formatting', () => {
    it('should apply correct indentation at different levels', () => {
      const property = new PascalProperty('value', 'Integer', false, 'public');

      const code0 = property.toCode(0);
      const code2 = property.toCode(2);
      const code4 = property.toCode(4);

      expect(code0).toBe('property value: Integer;');
      expect(code2).toBe('  property value: Integer;');
      expect(code4).toBe('    property value: Integer;');
    });

    it('should maintain consistent indentation in complex structures', () => {
      const members = [
        new PascalProperty('prop1', 'String', false, 'public'),
        new PascalMethod('method1', [], 'Integer', false, 'public'),
        new PascalProperty('prop2', 'Boolean', false, 'public'),
      ];
      const pascalClass = new PascalClass('Test', [], members, true);
      const code = pascalClass.toCode(2);

      const lines = code.split('\n');
      const memberLines = lines.filter((l) => l.includes('property') || l.includes('function'));

      // All member lines should have same indentation
      memberLines.forEach((line) => {
        expect(line.startsWith('    ')).toBe(true);
      });
    });
  });

  describe('Edge Cases', () => {
    it('should handle empty class', () => {
      const pascalClass = new PascalClass('Empty', [], [], true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('Empty = class external');
      expect(code).toContain('end;');
    });

    it('should handle class with only properties', () => {
      const properties = [
        new PascalProperty('a', 'String', false, 'public'),
        new PascalProperty('b', 'Integer', false, 'public'),
      ];
      const pascalClass = new PascalClass('Props', [], properties, true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('property a: String;');
      expect(code).toContain('property b: Integer;');
    });

    it('should handle class with only methods', () => {
      const methods = [
        new PascalMethod('method1', [], 'String', false, 'public'),
        new PascalMethod('method2', [], undefined, false, 'public'),
      ];
      const pascalClass = new PascalClass('Methods', [], methods, true);
      const code = pascalClass.toCode(2);

      expect(code).toContain('function method1: String;');
      expect(code).toContain('procedure method2;');
    });

    it('should handle special characters in names', () => {
      const property = new PascalProperty('_private', 'String', false, 'private');
      const code = property.toCode(2);

      expect(code).toContain('_private');
    });
  });
});
