/**
 * Code Generation Module
 *
 * Generates formatted Pascal code from Pascal AST nodes
 */

import { PascalNode, PascalUnit } from '../types.js';

export interface CodeGenerationOptions {
  /** Indentation size in spaces */
  indentSize?: number;
  /** Output style */
  style?: 'dws' | 'pas2js';
  /** Line ending style */
  lineEnding?: '\n' | '\r\n';
}

/**
 * Generate Pascal code from a Pascal AST
 */
export class PascalCodeGenerator {
  private options: Required<CodeGenerationOptions>;

  constructor(options: CodeGenerationOptions = {}) {
    this.options = {
      indentSize: options.indentSize ?? 2,
      style: options.style ?? 'dws',
      lineEnding: options.lineEnding ?? '\n',
    };
  }

  /**
   * Generate code from a Pascal unit
   */
  generateUnit(unit: PascalUnit): string {
    const code = unit.toCode(0);
    return this.format(this.adjustIndentation(code));
  }

  /**
   * Generate code from any Pascal node
   */
  generate(node: PascalNode, indentation = 0): string {
    const code = node.toCode(indentation);
    return this.format(this.adjustIndentation(code));
  }

  /**
   * Adjust indentation to match configured indent size
   * The toCode methods use 2-space indentation by default
   */
  private adjustIndentation(code: string): string {
    if (this.options.indentSize === 2) {
      return code; // No adjustment needed
    }

    const lines = code.split('\n');
    return lines
      .map((line) => {
        // Count leading spaces (must be even, since default is 2-space)
        const match = line.match(/^( *)/);
        if (!match) return line;

        const leadingSpaces = match[1].length;
        if (leadingSpaces === 0) return line;

        // Calculate indent level (default 2-space increments)
        const indentLevel = leadingSpaces / 2;
        // Apply new indent size
        const newIndent = ' '.repeat(indentLevel * this.options.indentSize);
        return newIndent + line.slice(leadingSpaces);
      })
      .join('\n');
  }

  /**
   * Format the generated code
   */
  private format(code: string): string {
    // Normalize line endings
    let formatted = code.replace(/\r\n/g, '\n').replace(/\r/g, '\n');

    // Apply configured line endings
    if (this.options.lineEnding === '\r\n') {
      formatted = formatted.replace(/\n/g, '\r\n');
    }

    // Remove trailing whitespace
    formatted = formatted
      .split(this.options.lineEnding)
      .map((line) => line.trimEnd())
      .join(this.options.lineEnding);

    // Ensure single trailing newline
    formatted = formatted.trimEnd() + this.options.lineEnding;

    return formatted;
  }

  /**
   * Generate a comment block
   */
  generateComment(text: string, indentation = 0): string {
    const indent = ' '.repeat(indentation);
    const lines = text.split('\n');

    if (lines.length === 1) {
      return `${indent}// ${text}`;
    }

    let comment = `${indent}(*\n`;
    for (const line of lines) {
      comment += `${indent} * ${line}\n`;
    }
    comment += `${indent} *)`;

    return comment;
  }
}
