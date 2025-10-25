/**
 * Type Node Handlers
 *
 * Functions for parsing and converting TypeScript type nodes
 */

import * as ts from 'typescript';

/**
 * Type mapping configuration
 */
export interface TypeMappingConfig {
  /** Custom type mappings */
  customMappings?: Map<string, string>;
  /** Whether to use strict number mapping (Integer vs Float) */
  strictNumbers?: boolean;
  /** Default type for unknown types */
  defaultType?: string;
}

/**
 * Type handler for converting TypeScript types to Pascal types
 */
export class TypeHandler {
  private typeMapping: Map<string, string>;
  private config: Required<TypeMappingConfig>;

  constructor(config: TypeMappingConfig = {}) {
    this.config = {
      customMappings: config.customMappings || new Map(),
      strictNumbers: config.strictNumbers ?? false,
      defaultType: config.defaultType ?? 'Variant',
    };

    this.typeMapping = new Map(this.config.customMappings);
    this.initializeDefaultMappings();
  }

  /**
   * Initialize default TypeScript to Pascal type mappings
   */
  private initializeDefaultMappings(): void {
    const defaults: [string, string][] = [
      ['string', 'String'],
      ['number', this.config.strictNumbers ? 'Integer' : 'Float'],
      ['boolean', 'Boolean'],
      ['any', 'Variant'],
      ['void', ''],
      ['null', 'Variant'],
      ['undefined', 'Variant'],
      ['object', 'Variant'],
      ['unknown', 'Variant'],
      ['never', 'Variant'],
      ['bigint', 'Int64'],
      ['symbol', 'String'],
    ];

    for (const [tsType, pascalType] of defaults) {
      if (!this.typeMapping.has(tsType)) {
        this.typeMapping.set(tsType, pascalType);
      }
    }
  }

  /**
   * Convert a TypeScript type node to Pascal type string
   */
  convertType(typeNode: ts.TypeNode, sourceFile: ts.SourceFile): string {
    if (ts.isTypeReferenceNode(typeNode)) {
      return this.convertTypeReference(typeNode, sourceFile);
    } else if (ts.isArrayTypeNode(typeNode)) {
      return this.convertArrayType(typeNode, sourceFile);
    } else if (ts.isUnionTypeNode(typeNode)) {
      return this.convertUnionType(typeNode, sourceFile);
    } else if (ts.isIntersectionTypeNode(typeNode)) {
      return this.convertIntersectionType(typeNode, sourceFile);
    } else if (ts.isTupleTypeNode(typeNode)) {
      return this.convertTupleType(typeNode, sourceFile);
    } else if (ts.isFunctionTypeNode(typeNode)) {
      return this.convertFunctionType(typeNode, sourceFile);
    } else if (ts.isConstructorTypeNode(typeNode)) {
      return this.convertConstructorType(typeNode, sourceFile);
    } else if (ts.isTypeLiteralNode(typeNode)) {
      return this.convertTypeLiteral(typeNode, sourceFile);
    } else if (ts.isParenthesizedTypeNode(typeNode)) {
      return this.convertType(typeNode.type, sourceFile);
    } else if (ts.isLiteralTypeNode(typeNode)) {
      return this.convertLiteralType(typeNode, sourceFile);
    } else if (ts.isIndexedAccessTypeNode(typeNode)) {
      return this.convertIndexedAccessType(typeNode, sourceFile);
    } else if (ts.isMappedTypeNode(typeNode)) {
      return this.convertMappedType(typeNode, sourceFile);
    } else if (ts.isConditionalTypeNode(typeNode)) {
      return this.convertConditionalType(typeNode, sourceFile);
    }

    // Handle keyword types
    switch (typeNode.kind) {
      case ts.SyntaxKind.StringKeyword:
        return this.typeMapping.get('string') || 'String';
      case ts.SyntaxKind.NumberKeyword:
        return this.typeMapping.get('number') || 'Float';
      case ts.SyntaxKind.BooleanKeyword:
        return this.typeMapping.get('boolean') || 'Boolean';
      case ts.SyntaxKind.VoidKeyword:
        return this.typeMapping.get('void') || '';
      case ts.SyntaxKind.AnyKeyword:
        return this.typeMapping.get('any') || 'Variant';
      case ts.SyntaxKind.UnknownKeyword:
        return this.typeMapping.get('unknown') || 'Variant';
      case ts.SyntaxKind.NullKeyword:
        return this.typeMapping.get('null') || 'Variant';
      case ts.SyntaxKind.UndefinedKeyword:
        return this.typeMapping.get('undefined') || 'Variant';
      case ts.SyntaxKind.ObjectKeyword:
        return this.typeMapping.get('object') || 'Variant';
      case ts.SyntaxKind.NeverKeyword:
        return this.typeMapping.get('never') || 'Variant';
      case ts.SyntaxKind.BigIntKeyword:
        return this.typeMapping.get('bigint') || 'Int64';
      case ts.SyntaxKind.SymbolKeyword:
        return this.typeMapping.get('symbol') || 'String';
      default:
        return this.config.defaultType;
    }
  }

  /**
   * Convert type reference (e.g., MyClass, Array<string>)
   */
  private convertTypeReference(node: ts.TypeReferenceNode, sourceFile: ts.SourceFile): string {
    const typeName = node.typeName.getText(sourceFile);

    // Check for mapped type first
    const mapped = this.typeMapping.get(typeName);
    if (mapped) {
      return mapped;
    }

    // Handle generic types
    if (node.typeArguments && node.typeArguments.length > 0) {
      const typeArgs = node.typeArguments.map((arg) => this.convertType(arg, sourceFile));

      // Special handling for common generic types
      if (typeName === 'Array' || typeName === 'ReadonlyArray') {
        return `array of ${typeArgs[0]}`;
      } else if (typeName === 'Promise') {
        // Promises in Pascal might just be the resolved type
        return typeArgs[0] || 'Variant';
      } else if (typeName === 'Partial' || typeName === 'Required' || typeName === 'Readonly') {
        // Utility types - just use the underlying type
        return typeArgs[0] || 'Variant';
      } else if (typeName === 'Record') {
        // Record<K, V> -> Variant or custom dictionary type
        return 'Variant'; // Could be improved with associative array support
      } else if (typeName === 'Map') {
        return 'Variant'; // Or custom map type
      } else if (typeName === 'Set') {
        return 'Variant'; // Or custom set type
      }

      // Generic class/interface reference
      return `${typeName}<${typeArgs.join(', ')}>`;
    }

    // Simple type reference
    return typeName;
  }

  /**
   * Convert array type (e.g., string[])
   */
  private convertArrayType(node: ts.ArrayTypeNode, sourceFile: ts.SourceFile): string {
    const elementType = this.convertType(node.elementType, sourceFile);
    return `array of ${elementType}`;
  }

  /**
   * Convert union type (e.g., string | number)
   */
  private convertUnionType(node: ts.UnionTypeNode, sourceFile: ts.SourceFile): string {
    const types = node.types.map((t) => this.convertType(t, sourceFile));

    // If all types are the same, just return one
    if (types.every((t) => t === types[0])) {
      return types[0] || this.config.defaultType;
    }

    // Check for optional types (T | undefined | null)
    const nonNullTypes = types.filter((t) => t !== 'Variant' && t !== '');
    if (nonNullTypes.length === 1) {
      return nonNullTypes[0] || this.config.defaultType;
    }

    // Return Variant for complex unions (Pascal doesn't have native union types)
    return 'Variant';
  }

  /**
   * Convert intersection type (e.g., A & B)
   */
  private convertIntersectionType(_node: ts.IntersectionTypeNode, _sourceFile: ts.SourceFile): string {
    // Pascal doesn't have native intersection types
    // Could create a new interface that combines both, but for now use Variant
    return 'Variant';
  }

  /**
   * Convert tuple type (e.g., [string, number])
   */
  private convertTupleType(node: ts.TupleTypeNode, sourceFile: ts.SourceFile): string {
    const elementTypes = node.elements.map((e) =>
      ts.isNamedTupleMember(e) ? this.convertType(e.type, sourceFile) : this.convertType(e, sourceFile)
    );

    // Pascal doesn't have native tuples
    // Could use a record with numbered fields, but for now use array of Variant
    if (elementTypes.every((t) => t === elementTypes[0])) {
      return `array of ${elementTypes[0]}`;
    }
    return 'array of Variant';
  }

  /**
   * Convert function type (e.g., (x: number) => string)
   */
  private convertFunctionType(node: ts.FunctionTypeNode, sourceFile: ts.SourceFile): string {
    const returnType = node.type ? this.convertType(node.type, sourceFile) : '';

    if (returnType) {
      return `function: ${returnType}`;
    } else {
      return 'procedure';
    }
  }

  /**
   * Convert constructor type (e.g., new () => MyClass)
   */
  private convertConstructorType(node: ts.ConstructorTypeNode, sourceFile: ts.SourceFile): string {
    const returnType = node.type ? this.convertType(node.type, sourceFile) : 'Variant';
    return returnType;
  }

  /**
   * Convert type literal (e.g., { x: number; y: string })
   */
  private convertTypeLiteral(_node: ts.TypeLiteralNode, _sourceFile: ts.SourceFile): string {
    // Type literals would need to be converted to interfaces or records
    // For now, use Variant
    return 'Variant';
  }

  /**
   * Convert literal type (e.g., "hello" | 42 | true)
   */
  private convertLiteralType(node: ts.LiteralTypeNode, sourceFile: ts.SourceFile): string {
    const literal = node.literal;

    if (ts.isStringLiteral(literal)) {
      return 'String';
    } else if (ts.isNumericLiteral(literal)) {
      return this.config.strictNumbers ? 'Integer' : 'Float';
    } else if (literal.kind === ts.SyntaxKind.TrueKeyword || literal.kind === ts.SyntaxKind.FalseKeyword) {
      return 'Boolean';
    } else if (literal.kind === ts.SyntaxKind.NullKeyword) {
      return 'Variant';
    }

    return this.config.defaultType;
  }

  /**
   * Convert indexed access type (e.g., T[K])
   */
  private convertIndexedAccessType(_node: ts.IndexedAccessTypeNode, _sourceFile: ts.SourceFile): string {
    return 'Variant';
  }

  /**
   * Convert mapped type (e.g., { [K in keyof T]: T[K] })
   */
  private convertMappedType(_node: ts.MappedTypeNode, _sourceFile: ts.SourceFile): string {
    return 'Variant';
  }

  /**
   * Convert conditional type (e.g., T extends U ? X : Y)
   */
  private convertConditionalType(_node: ts.ConditionalTypeNode, _sourceFile: ts.SourceFile): string {
    return 'Variant';
  }

  /**
   * Check if a type is optional (includes undefined or null)
   */
  isOptionalType(typeNode: ts.TypeNode): boolean {
    if (ts.isUnionTypeNode(typeNode)) {
      return typeNode.types.some(
        (t) =>
          t.kind === ts.SyntaxKind.UndefinedKeyword || t.kind === ts.SyntaxKind.NullKeyword
      );
    }
    return false;
  }

  /**
   * Remove optional markers from a union type
   */
  removeOptionalFromType(typeNode: ts.TypeNode, sourceFile: ts.SourceFile): string {
    if (ts.isUnionTypeNode(typeNode)) {
      const nonOptionalTypes = typeNode.types.filter(
        (t) =>
          t.kind !== ts.SyntaxKind.UndefinedKeyword && t.kind !== ts.SyntaxKind.NullKeyword
      );

      if (nonOptionalTypes.length === 1) {
        return this.convertType(nonOptionalTypes[0]!, sourceFile);
      } else if (nonOptionalTypes.length > 1) {
        const unionType: ts.UnionTypeNode = {
          ...typeNode,
          types: ts.factory.createNodeArray(nonOptionalTypes),
        };
        return this.convertUnionType(unionType, sourceFile);
      }
    }

    return this.convertType(typeNode, sourceFile);
  }
}

/**
 * Extract type parameters from a declaration
 */
export function extractTypeParameters(
  node: ts.ClassDeclaration | ts.InterfaceDeclaration | ts.FunctionDeclaration | ts.TypeAliasDeclaration
): string[] {
  if (!node.typeParameters) return [];
  return node.typeParameters.map((tp) => tp.name.text);
}

/**
 * Format type parameters for Pascal output
 */
export function formatTypeParameters(typeParams: string[]): string {
  if (typeParams.length === 0) return '';
  return `<${typeParams.join(', ')}>`;
}
