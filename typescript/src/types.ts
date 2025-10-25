/**
 * Type definitions for ts2pas
 */

/**
 * Represents a Pascal AST node
 */
export abstract class PascalNode {
  /**
   * Generate Pascal code for this node
   * @param indentation - Current indentation level
   * @returns Generated Pascal code
   */
  abstract toCode(indentation: number): string;

  /**
   * Get the name of this node (if applicable)
   */
  getName(): string | undefined {
    return undefined;
  }
}

/**
 * Represents a Pascal unit (file)
 */
export class PascalUnit extends PascalNode {
  constructor(
    public name: string,
    public usesClause: string[] = [],
    public interfaceDeclarations: PascalDeclaration[] = [],
    public implementationCode: string = ''
  ) {
    super();
  }

  toCode(indentation = 0): string {
    const indent = ' '.repeat(indentation);
    let code = `${indent}unit ${this.name};\n\n`;

    if (this.usesClause.length > 0) {
      code += `${indent}uses\n`;
      code += this.usesClause.map((u) => `${indent}  ${u}`).join(',\n');
      code += ';\n\n';
    }

    code += `${indent}interface\n\n`;
    code += this.interfaceDeclarations.map((d) => d.toCode(indentation + 2)).join('\n\n');
    code += `\n\n${indent}implementation\n\n`;
    code += this.implementationCode;
    code += `\n\n${indent}end.\n`;

    return code;
  }

  getName(): string {
    return this.name;
  }
}

/**
 * Base class for Pascal declarations
 */
export abstract class PascalDeclaration extends PascalNode {
  constructor(public name: string) {
    super();
  }

  getName(): string {
    return this.name;
  }
}

/**
 * Represents a Pascal class declaration
 */
export class PascalClass extends PascalDeclaration {
  constructor(
    name: string,
    public ancestors: string[] = [],
    public members: PascalMember[] = [],
    public isExternal = true
  ) {
    super(name);
  }

  toCode(indentation: number): string {
    const indent = ' '.repeat(indentation);
    let code = `${indent}${this.name} = class`;

    if (this.ancestors.length > 0) {
      code += `(${this.ancestors.join(', ')})`;
    }

    if (this.isExternal) {
      code += ' external';
    }

    code += '\n';

    if (this.members.length > 0) {
      code += this.members.map((m) => m.toCode(indentation + 2)).join('\n');
      code += '\n';
    }

    code += `${indent}end;`;

    return code;
  }
}

/**
 * Represents a Pascal interface declaration
 */
export class PascalInterface extends PascalDeclaration {
  constructor(
    name: string,
    public ancestors: string[] = [],
    public members: PascalMember[] = []
  ) {
    super(name);
  }

  toCode(indentation: number): string {
    const indent = ' '.repeat(indentation);
    let code = `${indent}${this.name} = interface`;

    if (this.ancestors.length > 0) {
      code += `(${this.ancestors.join(', ')})`;
    }

    code += '\n';

    if (this.members.length > 0) {
      code += this.members.map((m) => m.toCode(indentation + 2)).join('\n');
      code += '\n';
    }

    code += `${indent}end;`;

    return code;
  }
}

/**
 * Base class for class/interface members
 */
export abstract class PascalMember extends PascalNode {
  constructor(
    public name: string,
    public visibility: 'public' | 'private' | 'protected' = 'public'
  ) {
    super();
  }

  getName(): string {
    return this.name;
  }
}

/**
 * Represents a method declaration
 */
export class PascalMethod extends PascalMember {
  constructor(
    name: string,
    public parameters: PascalParameter[] = [],
    public returnType?: string,
    public isStatic = false,
    visibility: 'public' | 'private' | 'protected' = 'public'
  ) {
    super(name, visibility);
  }

  toCode(indentation: number): string {
    const indent = ' '.repeat(indentation);
    const methodType = this.returnType ? 'function' : 'procedure';
    const params =
      this.parameters.length > 0
        ? `(${this.parameters.map((p) => p.toCode(0)).join('; ')})`
        : '';
    const returnTypePart = this.returnType ? `: ${this.returnType}` : '';
    const staticPart = this.isStatic ? ' static' : '';

    return `${indent}${methodType} ${this.name}${params}${returnTypePart};${staticPart}`;
  }
}

/**
 * Represents a property declaration
 */
export class PascalProperty extends PascalMember {
  constructor(
    name: string,
    public propertyType: string,
    public isReadOnly = false,
    visibility: 'public' | 'private' | 'protected' = 'public'
  ) {
    super(name, visibility);
  }

  toCode(indentation: number): string {
    const indent = ' '.repeat(indentation);
    const readOnlyPart = this.isReadOnly ? ' read only' : '';
    return `${indent}property ${this.name}: ${this.propertyType};${readOnlyPart}`;
  }
}

/**
 * Represents a method/function parameter
 */
export class PascalParameter extends PascalNode {
  constructor(
    public name: string,
    public paramType: string,
    public isOptional = false,
    public defaultValue?: string
  ) {
    super();
  }

  toCode(_indentation: number): string {
    const optionalPart = this.isOptional ? '?' : '';
    const defaultPart = this.defaultValue ? ` = ${this.defaultValue}` : '';
    return `${this.name}${optionalPart}: ${this.paramType}${defaultPart}`;
  }

  getName(): string {
    return this.name;
  }
}

/**
 * Represents a type alias
 */
export class PascalTypeAlias extends PascalDeclaration {
  constructor(
    name: string,
    public targetType: string
  ) {
    super(name);
  }

  toCode(indentation: number): string {
    const indent = ' '.repeat(indentation);
    return `${indent}${this.name} = ${this.targetType};`;
  }
}
