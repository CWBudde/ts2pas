/**
 * AST Transformation Module
 *
 * Transforms TypeScript AST nodes into Pascal AST nodes
 */

import * as ts from 'typescript';
import {
  PascalUnit,
  PascalClass,
  PascalInterface,
  PascalMethod,
  PascalProperty,
  PascalParameter,
  PascalTypeAlias,
  PascalMember,
  PascalDeclaration,
} from '../types.js';
import { TypeHandler } from '../parser/types.js';
import { hasModifier } from '../parser/index.js';

/**
 * Options for AST transformation
 */
export interface TransformOptions {
  /** Custom type mappings */
  typeMapping?: Record<string, string>;
  /** Whether to mark classes as external */
  externalClasses?: boolean;
  /** Output style */
  style?: 'dws' | 'pas2js';
}

/**
 * Transform TypeScript AST to Pascal AST
 */
export class TypeScriptToPascalTransformer {
  private sourceFile: ts.SourceFile;
  private typeHandler: TypeHandler;
  private options: Required<TransformOptions>;

  constructor(sourceFile: ts.SourceFile, options: TransformOptions = {}) {
    this.sourceFile = sourceFile;
    this.options = {
      typeMapping: options.typeMapping || {},
      externalClasses: options.externalClasses ?? true,
      style: options.style || 'dws',
    };

    // Initialize type handler
    const customMappings = new Map(Object.entries(this.options.typeMapping));
    this.typeHandler = new TypeHandler({ customMappings });
  }

  /**
   * Transform the entire source file to a Pascal unit
   */
  transform(): PascalUnit {
    const unitName = this.getUnitName();
    const declarations: PascalDeclaration[] = [];

    // Visit each top-level statement
    ts.forEachChild(this.sourceFile, (node) => {
      if (ts.isClassDeclaration(node) && node.name) {
        const pascalClass = this.transformClass(node);
        if (pascalClass) declarations.push(pascalClass);
      } else if (ts.isInterfaceDeclaration(node)) {
        const pascalInterface = this.transformInterface(node);
        if (pascalInterface) declarations.push(pascalInterface);
      } else if (ts.isTypeAliasDeclaration(node)) {
        const typeAlias = this.transformTypeAlias(node);
        if (typeAlias) declarations.push(typeAlias);
      } else if (ts.isFunctionDeclaration(node) && node.name) {
        const method = this.transformFunctionDeclaration(node);
        if (method) declarations.push(method);
      } else if (ts.isEnumDeclaration(node)) {
        const typeAlias = this.transformEnum(node);
        if (typeAlias) declarations.push(typeAlias);
      }
    });

    return new PascalUnit(unitName, [], declarations);
  }

  /**
   * Get the unit name from the source file name
   */
  private getUnitName(): string {
    const fileName = this.sourceFile.fileName.replace(/\.d\.ts$/, '').replace(/\.ts$/, '');
    const baseName = fileName.split('/').pop() || 'Converted';
    // Sanitize for Pascal identifier
    let name = baseName.replace(/[^a-zA-Z0-9_]/g, '_');
    // Capitalize first letter
    name = name.charAt(0).toUpperCase() + name.slice(1);
    return name;
  }

  /**
   * Transform a class declaration
   */
  transformClass(node: ts.ClassDeclaration): PascalClass | null {
    if (!node.name) return null;

    const name = node.name.text;
    const ancestors: string[] = [];
    const members: PascalMember[] = [];

    // Extract heritage (extends/implements)
    if (node.heritageClauses) {
      for (const clause of node.heritageClauses) {
        for (const type of clause.types) {
          const ancestorName = type.expression.getText(this.sourceFile);
          ancestors.push(ancestorName);
        }
      }
    }

    // Transform members
    for (const member of node.members) {
      if (ts.isMethodDeclaration(member) || ts.isMethodSignature(member)) {
        const method = this.transformMethod(member);
        if (method) members.push(method);
      } else if (ts.isPropertyDeclaration(member) || ts.isPropertySignature(member)) {
        const property = this.transformProperty(member);
        if (property) members.push(property);
      } else if (ts.isConstructorDeclaration(member)) {
        const constructor = this.transformConstructor(member);
        if (constructor) members.push(constructor);
      }
    }

    return new PascalClass(name, ancestors, members, this.options.externalClasses);
  }

  /**
   * Transform an interface declaration
   */
  transformInterface(node: ts.InterfaceDeclaration): PascalInterface | null {
    const name = node.name.text;
    const ancestors: string[] = [];
    const members: PascalMember[] = [];

    // Extract extends clauses
    if (node.heritageClauses) {
      for (const clause of node.heritageClauses) {
        for (const type of clause.types) {
          const ancestorName = type.expression.getText(this.sourceFile);
          ancestors.push(ancestorName);
        }
      }
    }

    // Transform members
    for (const member of node.members) {
      if (ts.isMethodSignature(member)) {
        const method = this.transformMethod(member);
        if (method) members.push(method);
      } else if (ts.isPropertySignature(member)) {
        const property = this.transformProperty(member);
        if (property) members.push(property);
      }
    }

    return new PascalInterface(name, ancestors, members);
  }

  /**
   * Transform a method declaration or signature
   */
  transformMethod(
    node: ts.MethodDeclaration | ts.MethodSignature | ts.FunctionDeclaration
  ): PascalMethod | null {
    if (!node.name) return null;

    const name = ts.isIdentifier(node.name) ? node.name.text : node.name.getText(this.sourceFile);

    // Transform parameters
    const parameters: PascalParameter[] = [];
    for (const param of node.parameters) {
      const pascalParam = this.transformParameter(param);
      if (pascalParam) parameters.push(pascalParam);
    }

    // Get return type
    let returnType: string | undefined;
    if (node.type) {
      returnType = this.typeHandler.convertType(node.type, this.sourceFile);
      if (returnType === '') returnType = undefined; // void
    }

    // Check if static
    const isStatic = ts.isMethodDeclaration(node) && hasModifier(node, ts.SyntaxKind.StaticKeyword);

    // Get visibility
    let visibility: 'public' | 'private' | 'protected' = 'public';
    if (ts.isMethodDeclaration(node)) {
      if (hasModifier(node, ts.SyntaxKind.PrivateKeyword)) visibility = 'private';
      else if (hasModifier(node, ts.SyntaxKind.ProtectedKeyword)) visibility = 'protected';
    }

    return new PascalMethod(name, parameters, returnType, isStatic, visibility);
  }

  /**
   * Transform a function declaration (top-level)
   */
  transformFunctionDeclaration(node: ts.FunctionDeclaration): PascalMethod | null {
    return this.transformMethod(node);
  }

  /**
   * Transform a constructor declaration
   */
  transformConstructor(node: ts.ConstructorDeclaration): PascalMethod | null {
    const parameters: PascalParameter[] = [];
    for (const param of node.parameters) {
      const pascalParam = this.transformParameter(param);
      if (pascalParam) parameters.push(pascalParam);
    }

    return new PascalMethod('Create', parameters, undefined, false, 'public');
  }

  /**
   * Transform a property declaration or signature
   */
  transformProperty(
    node: ts.PropertyDeclaration | ts.PropertySignature
  ): PascalProperty | null {
    if (!node.name || !ts.isIdentifier(node.name)) return null;

    const name = node.name.text;

    // Get property type
    let propertyType = 'Variant';
    if (node.type) {
      propertyType = this.typeHandler.convertType(node.type, this.sourceFile);
    }

    // Check if readonly
    const isReadOnly =
      ts.isPropertyDeclaration(node) && hasModifier(node, ts.SyntaxKind.ReadonlyKeyword);

    // Get visibility
    let visibility: 'public' | 'private' | 'protected' = 'public';
    if (ts.isPropertyDeclaration(node)) {
      if (hasModifier(node, ts.SyntaxKind.PrivateKeyword)) visibility = 'private';
      else if (hasModifier(node, ts.SyntaxKind.ProtectedKeyword)) visibility = 'protected';
    }

    return new PascalProperty(name, propertyType, isReadOnly, visibility);
  }

  /**
   * Transform a parameter declaration
   */
  transformParameter(node: ts.ParameterDeclaration): PascalParameter | null {
    if (!node.name || !ts.isIdentifier(node.name)) return null;

    const name = node.name.text;

    // Get parameter type
    let paramType = 'Variant';
    if (node.type) {
      paramType = this.typeHandler.convertType(node.type, this.sourceFile);
    }

    // Check if optional
    const isOptional = !!node.questionToken;

    // Get default value
    let defaultValue: string | undefined;
    if (node.initializer) {
      defaultValue = node.initializer.getText(this.sourceFile);
    }

    return new PascalParameter(name, paramType, isOptional, defaultValue);
  }

  /**
   * Transform a type alias declaration
   */
  transformTypeAlias(node: ts.TypeAliasDeclaration): PascalTypeAlias | null {
    const name = node.name.text;
    const targetType = this.typeHandler.convertType(node.type, this.sourceFile);

    return new PascalTypeAlias(name, targetType);
  }

  /**
   * Transform an enum declaration
   */
  transformEnum(node: ts.EnumDeclaration): PascalTypeAlias | null {
    const name = node.name.text;

    // For now, represent enums as Integer type aliases
    // A more sophisticated approach would create actual Pascal enums
    return new PascalTypeAlias(name, 'Integer');
  }
}

/**
 * Helper function to transform a TypeScript source file
 */
export function transformSourceFile(
  sourceFile: ts.SourceFile,
  options: TransformOptions = {}
): PascalUnit {
  const transformer = new TypeScriptToPascalTransformer(sourceFile, options);
  return transformer.transform();
}
