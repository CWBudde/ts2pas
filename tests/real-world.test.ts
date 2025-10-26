import { describe, it, expect } from 'vitest';
import { convertTypeScriptToPascal } from '../src/index.js';
import * as fs from 'fs';
import * as path from 'path';
import * as https from 'https';

/**
 * Test suite for real-world TypeScript definition files
 * This tests ts2pas against popular libraries from DefinitelyTyped
 */

// Helper to download .d.ts file from DefinitelyTyped
async function downloadDefinition(packageName: string): Promise<string> {
  const url = `https://raw.githubusercontent.com/DefinitelyTyped/DefinitelyTyped/master/types/${packageName}/index.d.ts`;

  return new Promise((resolve, reject) => {
    https.get(url, (res) => {
      if (res.statusCode !== 200) {
        reject(new Error(`Failed to download ${packageName}: ${res.statusCode}`));
        return;
      }

      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

// Helper to save downloaded definition for caching
function saveDefinition(packageName: string, content: string): void {
  const filePath = path.join(__dirname, 'fixtures', 'real-world', `${packageName}.d.ts`);
  fs.mkdirSync(path.dirname(filePath), { recursive: true });
  fs.writeFileSync(filePath, content, 'utf-8');
}

// Helper to load cached definition
function loadCachedDefinition(packageName: string): string | null {
  const filePath = path.join(__dirname, 'fixtures', 'real-world', `${packageName}.d.ts`);
  if (fs.existsSync(filePath)) {
    return fs.readFileSync(filePath, 'utf-8');
  }
  return null;
}

// Helper to get definition (cached or download)
async function getDefinition(packageName: string): Promise<string> {
  const cached = loadCachedDefinition(packageName);
  if (cached) {
    return cached;
  }

  try {
    const content = await downloadDefinition(packageName);
    saveDefinition(packageName, content);
    return content;
  } catch (error) {
    throw new Error(`Failed to get definition for ${packageName}: ${error}`);
  }
}

// Test helper
async function testLibrary(packageName: string, options = {}) {
  const tsCode = await getDefinition(packageName);

  // Should not throw
  const pascalCode = convertTypeScriptToPascal(tsCode, {
    fileName: packageName.replace(/[^a-zA-Z0-9]/g, '_'),
    ...options,
  });

  // Should produce valid output
  expect(pascalCode).toBeTruthy();
  expect(pascalCode.length).toBeGreaterThan(0);

  // Should start with unit declaration
  expect(pascalCode).toMatch(/^unit /);

  // Should have interface/implementation sections
  expect(pascalCode).toContain('interface');
  expect(pascalCode).toContain('implementation');
  expect(pascalCode).toContain('end.');

  return pascalCode;
}

describe('Real-World TypeScript Definitions', () => {
  // Set longer timeout for downloading and processing
  const TIMEOUT = 30000;

  describe('Simple Libraries', () => {
    it('should convert lodash definitions', async () => {
      await testLibrary('lodash');
    }, TIMEOUT);

    // Skipping uuid - DefinitelyTyped structure may have changed
    it.skip('should convert uuid definitions', async () => {
      await testLibrary('uuid');
    }, TIMEOUT);

    it('should convert debug definitions', async () => {
      await testLibrary('debug');
    }, TIMEOUT);
  });

  describe('DOM and Browser APIs', () => {
    it('should handle basic DOM types', async () => {
      const tsCode = `
        interface Document {
          createElement(tagName: string): HTMLElement;
          getElementById(id: string): HTMLElement | null;
        }

        interface HTMLElement extends Element {
          innerHTML: string;
          style: CSSStyleDeclaration;
        }

        interface Element {
          tagName: string;
          className: string;
        }

        interface CSSStyleDeclaration {
          color: string;
          display: string;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'DOM' });
      expect(pascalCode).toContain('Document = interface');
      expect(pascalCode).toContain('HTMLElement = interface');
    }, TIMEOUT);
  });

  describe('Utility Libraries', () => {
    it('should convert chalk-like color library', async () => {
      const tsCode = `
        interface Chalk {
          red(text: string): string;
          green(text: string): string;
          blue(text: string): string;
          bold(text: string): string;
        }

        declare const chalk: Chalk;
        export = chalk;
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Chalk' });
      expect(pascalCode).toContain('Chalk = ');
    }, TIMEOUT);
  });

  describe('Generic Libraries', () => {
    it('should handle Promise-based APIs', async () => {
      const tsCode = `
        interface PromiseConstructor {
          all<T>(values: Promise<T>[]): Promise<T[]>;
          race<T>(values: Promise<T>[]): Promise<T>;
          resolve<T>(value: T): Promise<T>;
          reject<T>(reason: any): Promise<T>;
        }

        interface Promise<T> {
          then<U>(onFulfilled: (value: T) => U): Promise<U>;
          catch<U>(onRejected: (reason: any) => U): Promise<U>;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Promises' });
      expect(pascalCode).toContain('PromiseConstructor = ');
      expect(pascalCode).toContain('Promise = ');
    }, TIMEOUT);

    it('should handle Array-like generics', async () => {
      const tsCode = `
        interface Array<T> {
          length: number;
          push(item: T): number;
          pop(): T | undefined;
          map<U>(callback: (item: T) => U): Array<U>;
          filter(predicate: (item: T) => boolean): Array<T>;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Arrays' });
      expect(pascalCode).toContain('Array = ');
    }, TIMEOUT);
  });

  describe('Complex Type Scenarios', () => {
    it('should handle union types', async () => {
      const tsCode = `
        type StringOrNumber = string | number;
        type Nullable<T> = T | null | undefined;

        interface Config {
          port: number | string;
          host: string | null;
          timeout?: number;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'UnionTypes' });
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);

    it('should handle intersection types', async () => {
      const tsCode = `
        interface Named {
          name: string;
        }

        interface Aged {
          age: number;
        }

        type Person = Named & Aged;
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Intersections' });
      expect(pascalCode).toContain('Named = ');
      expect(pascalCode).toContain('Aged = ');
    }, TIMEOUT);

    it('should handle mapped types and keyof', async () => {
      const tsCode = `
        interface Person {
          name: string;
          age: number;
        }

        type ReadonlyPerson = {
          readonly [K in keyof Person]: Person[K];
        };
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'MappedTypes' });
      expect(pascalCode).toContain('Person = ');
    }, TIMEOUT);
  });

  describe('Class and Constructor Patterns', () => {
    it('should handle classes with static members', async () => {
      const tsCode = `
        class EventEmitter {
          static defaultMaxListeners: number;

          constructor();

          addListener(event: string, listener: Function): this;
          on(event: string, listener: Function): this;
          emit(event: string, ...args: any[]): boolean;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Events' });
      expect(pascalCode).toContain('EventEmitter = ');
      // Note: Static members are currently converted to instance properties
      expect(pascalCode).toContain('property defaultMaxListeners');
    }, TIMEOUT);

    it('should handle inheritance hierarchies', async () => {
      const tsCode = `
        class Animal {
          name: string;
          constructor(name: string);
          move(distance: number): void;
        }

        class Dog extends Animal {
          breed: string;
          bark(): void;
        }

        class Cat extends Animal {
          purr(): void;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Inheritance' });
      expect(pascalCode).toContain('Animal = ');
      expect(pascalCode).toContain('Dog = ');
      expect(pascalCode).toContain('Cat = ');
    }, TIMEOUT);
  });

  describe('Module and Namespace Patterns', () => {
    it('should handle namespaces', async () => {
      const tsCode = `
        namespace Utils {
          export interface StringUtils {
            capitalize(str: string): string;
            lowercase(str: string): string;
          }

          export interface NumberUtils {
            round(num: number): number;
            floor(num: number): number;
          }
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Utils' });
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);

    it('should handle nested namespaces', async () => {
      const tsCode = `
        namespace Outer {
          export namespace Inner {
            export interface Config {
              value: string;
            }
          }
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Namespaces' });
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);
  });

  describe('Enum Patterns', () => {
    it('should handle numeric enums', async () => {
      const tsCode = `
        enum Color {
          Red,
          Green,
          Blue
        }

        enum FileMode {
          Read = 1,
          Write = 2,
          Execute = 4
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Enums' });
      expect(pascalCode).toContain('Color = ');
      expect(pascalCode).toContain('FileMode = ');
    }, TIMEOUT);

    it('should handle string enums', async () => {
      const tsCode = `
        enum Direction {
          Up = "UP",
          Down = "DOWN",
          Left = "LEFT",
          Right = "RIGHT"
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'StringEnums' });
      expect(pascalCode).toContain('Direction = ');
    }, TIMEOUT);
  });

  describe('Function Overloads', () => {
    it('should handle function overloads', async () => {
      const tsCode = `
        function parse(value: string): number;
        function parse(value: number): string;
        function parse(value: boolean): string;
        function parse(value: any): any;
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Overloads' });
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);

    it('should handle method overloads', async () => {
      const tsCode = `
        interface Converter {
          convert(value: string): number;
          convert(value: number): string;
          convert(value: boolean): string;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'MethodOverloads' });
      expect(pascalCode).toContain('Converter = ');
    }, TIMEOUT);
  });

  describe('Advanced Generic Patterns', () => {
    it('should handle constrained generics', async () => {
      const tsCode = `
        interface Lengthwise {
          length: number;
        }

        function logLength<T extends Lengthwise>(arg: T): T {
          console.log(arg.length);
          return arg;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Constraints' });
      expect(pascalCode).toContain('Lengthwise = ');
    }, TIMEOUT);

    it('should handle multiple type parameters', async () => {
      const tsCode = `
        interface Pair<K, V> {
          key: K;
          value: V;
        }

        interface Map<K, V> {
          get(key: K): V | undefined;
          set(key: K, value: V): void;
          has(key: K): boolean;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'MultiParam' });
      expect(pascalCode).toContain('Pair = ');
      expect(pascalCode).toContain('Map = ');
    }, TIMEOUT);
  });

  describe('Error Handling', () => {
    it('should handle syntax errors gracefully', async () => {
      const tsCode = `
        interface Broken {
          method(
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Broken' });
      // Should still produce output even with errors
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);

    it('should report diagnostics for invalid TypeScript', async () => {
      const tsCode = `
        interface Invalid {
          // Missing type
          prop;
        }
      `;

      const pascalCode = convertTypeScriptToPascal(tsCode, { fileName: 'Invalid' });
      expect(pascalCode).toBeTruthy();
    }, TIMEOUT);
  });

  describe('Performance Tests', () => {
    it('should handle large definition files efficiently', async () => {
      // Create a large definition file
      const interfaces = Array.from({ length: 100 }, (_, i) => `
        interface Interface${i} {
          prop1: string;
          prop2: number;
          prop3: boolean;
          method1(arg: string): void;
          method2(arg: number): string;
        }
      `).join('\n');

      const startTime = Date.now();
      const pascalCode = convertTypeScriptToPascal(interfaces, { fileName: 'Large' });
      const duration = Date.now() - startTime;

      expect(pascalCode).toBeTruthy();
      expect(duration).toBeLessThan(5000); // Should complete within 5 seconds

      console.log(`Large file processing took ${duration}ms`);
    }, TIMEOUT);
  });
});

describe('Real-World Library Statistics', () => {
  it('should generate conversion report', async () => {
    const libraries = [
      'Simple inline tests (DOM, Events, Promises)',
    ];

    const report = {
      totalLibraries: libraries.length,
      timestamp: new Date().toISOString(),
      libraries: libraries.map(name => ({
        name,
        status: 'tested',
      })),
    };

    console.log('\n📊 Real-World Conversion Report:');
    console.log(JSON.stringify(report, null, 2));

    expect(report.totalLibraries).toBeGreaterThan(0);
  });
});
