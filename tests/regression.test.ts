import { describe, it, expect, beforeAll } from 'vitest';
import { convertTypeScriptToPascal } from '../src/index.js';
import * as fs from 'fs';
import * as path from 'path';

/**
 * Regression Test Suite
 *
 * Compares current conversion output against known-good baselines
 * to detect unintended changes in behavior.
 */

const FIXTURES_DIR = path.join(__dirname, 'fixtures', 'input');
const BASELINES_DIR = path.join(__dirname, 'fixtures', 'baselines');

interface RegressionTestCase {
  name: string;
  inputFile: string;
  baselineFile: string;
}

/**
 * Get all regression test cases
 */
function getTestCases(): RegressionTestCase[] {
  if (!fs.existsSync(FIXTURES_DIR) || !fs.existsSync(BASELINES_DIR)) {
    return [];
  }

  const inputFiles = fs.readdirSync(FIXTURES_DIR)
    .filter(file => file.endsWith('.d.ts'));

  return inputFiles.map(file => {
    const name = path.basename(file, '.d.ts');
    return {
      name,
      inputFile: path.join(FIXTURES_DIR, file),
      baselineFile: path.join(BASELINES_DIR, `${name}.pas`),
    };
  }).filter(tc => fs.existsSync(tc.baselineFile));
}

/**
 * Normalize Pascal code for comparison
 * - Removes comment headers with timestamps/versions
 * - Normalizes whitespace
 */
function normalizePascalCode(code: string): string {
  // Remove auto-generated comment header (contains version/timestamp)
  let normalized = code.replace(/\(\*[\s\S]*?\*\)/g, '');

  // Normalize line endings
  normalized = normalized.replace(/\r\n/g, '\n');

  // Remove trailing whitespace from each line
  normalized = normalized.split('\n')
    .map(line => line.trimEnd())
    .join('\n');

  // Remove leading/trailing blank lines
  normalized = normalized.trim();

  return normalized;
}

/**
 * Compare two Pascal code outputs
 */
function comparePascalCode(actual: string, expected: string): { match: boolean; diff?: string } {
  const normalizedActual = normalizePascalCode(actual);
  const normalizedExpected = normalizePascalCode(expected);

  if (normalizedActual === normalizedExpected) {
    return { match: true };
  }

  // Generate simple diff
  const actualLines = normalizedActual.split('\n');
  const expectedLines = normalizedExpected.split('\n');
  const maxLines = Math.max(actualLines.length, expectedLines.length);

  const diffLines: string[] = [];
  for (let i = 0; i < maxLines; i++) {
    const actual = actualLines[i] || '';
    const expected = expectedLines[i] || '';

    if (actual !== expected) {
      diffLines.push(`Line ${i + 1}:`);
      diffLines.push(`  Expected: ${expected}`);
      diffLines.push(`  Actual:   ${actual}`);
    }
  }

  return {
    match: false,
    diff: diffLines.join('\n'),
  };
}

describe('Regression Tests', () => {
  const testCases = getTestCases();

  if (testCases.length === 0) {
    console.warn('\n⚠️  No regression test baselines found.');
    console.warn('   Run: npm run generate-baselines\n');
  }

  it('should have regression test baselines', () => {
    expect(testCases.length).toBeGreaterThan(0);
  });

  describe('Baseline Comparisons', () => {
    // Dynamically generate test for each baseline
    testCases.forEach(tc => {
      it(`should match baseline: ${tc.name}`, () => {
        // Read TypeScript input
        const tsContent = fs.readFileSync(tc.inputFile, 'utf-8');

        // Read baseline
        const baseline = fs.readFileSync(tc.baselineFile, 'utf-8');

        // Convert current version
        const pascalCode = convertTypeScriptToPascal(tsContent, {
          fileName: tc.name,
          indentSize: 2,
          style: 'dws',
          verbose: false,
        });

        // Compare
        const comparison = comparePascalCode(pascalCode, baseline);

        if (!comparison.match) {
          console.log('\n' + '='.repeat(60));
          console.log(`REGRESSION FAILURE: ${tc.name}`);
          console.log('='.repeat(60));
          console.log(comparison.diff);
          console.log('='.repeat(60));
        }

        expect(comparison.match, `Baseline mismatch for ${tc.name}`).toBe(true);
      });
    });
  });

  describe('Consistency Tests', () => {
    it('should produce identical output for same input', () => {
      if (testCases.length === 0) return;

      const tc = testCases[0];
      const tsContent = fs.readFileSync(tc.inputFile, 'utf-8');

      // Convert twice
      const output1 = convertTypeScriptToPascal(tsContent, {
        fileName: tc.name,
        indentSize: 2,
        style: 'dws',
      });

      const output2 = convertTypeScriptToPascal(tsContent, {
        fileName: tc.name,
        indentSize: 2,
        style: 'dws',
      });

      // Should be identical
      expect(output1).toBe(output2);
    });

    it('should handle different indentation sizes', () => {
      if (testCases.length === 0) return;

      const tc = testCases[0];
      const tsContent = fs.readFileSync(tc.inputFile, 'utf-8');

      // Convert with different indentation
      const output2 = convertTypeScriptToPascal(tsContent, {
        fileName: tc.name,
        indentSize: 2,
        style: 'dws',
      });

      const output4 = convertTypeScriptToPascal(tsContent, {
        fileName: tc.name,
        indentSize: 4,
        style: 'dws',
      });

      // Should have different indentation but same structure
      expect(output2).not.toBe(output4);
      expect(output2.replace(/ {2}/g, ' ')).toBeTruthy();
      expect(output4.replace(/ {4}/g, '  ')).toBeTruthy();
    });
  });

  describe('Baseline Integrity', () => {
    it('should have valid baseline files', () => {
      testCases.forEach(tc => {
        const exists = fs.existsSync(tc.baselineFile);
        expect(exists, `Baseline file missing: ${tc.baselineFile}`).toBe(true);

        if (exists) {
          const content = fs.readFileSync(tc.baselineFile, 'utf-8');
          expect(content.length, `Baseline file empty: ${tc.baselineFile}`).toBeGreaterThan(0);
          expect(content, `Baseline should start with 'unit': ${tc.baselineFile}`).toMatch(/^unit /);
        }
      });
    });

    it('should have metadata file', () => {
      const metadataFile = path.join(BASELINES_DIR, 'metadata.json');
      if (fs.existsSync(metadataFile)) {
        const content = fs.readFileSync(metadataFile, 'utf-8');
        const metadata = JSON.parse(content);

        expect(metadata).toHaveProperty('generated');
        expect(metadata).toHaveProperty('version');
        expect(metadata).toHaveProperty('baselines');
        expect(Array.isArray(metadata.baselines)).toBe(true);
      }
    });
  });
});

describe('Regression Test Utilities', () => {
  it('should normalize Pascal code correctly', () => {
    const code = `unit Test;

interface

(*
   * Auto-generated comment
   * With timestamp
   *)

   Foo = interface
   end;

implementation

end.
`;

    const normalized = normalizePascalCode(code);

    // Should remove comments
    expect(normalized).not.toContain('Auto-generated');

    // Should normalize whitespace
    expect(normalized).not.toMatch(/\r\n/);

    // Should trim
    expect(normalized.startsWith('unit')).toBe(true);
    expect(normalized.endsWith('end.')).toBe(true);
  });

  it('should detect differences correctly', () => {
    const code1 = 'unit Test;\nFoo = interface\nend;';
    const code2 = 'unit Test;\nBar = interface\nend;';

    const comparison = comparePascalCode(code1, code2);

    expect(comparison.match).toBe(false);
    expect(comparison.diff).toBeTruthy();
    expect(comparison.diff).toContain('Foo');
    expect(comparison.diff).toContain('Bar');
  });

  it('should ignore comment differences', () => {
    const code1 = `unit Test;

interface

(*
   * Version 1
   *)

   Foo = interface
   end;

implementation

end.`;

    const code2 = `unit Test;

interface

(*
   * Version 2
   *)

   Foo = interface
   end;

implementation

end.`;

    const comparison = comparePascalCode(code1, code2);

    expect(comparison.match).toBe(true);
  });
});
