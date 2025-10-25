/**
 * AST Visitor Pattern
 *
 * Provides a structured way to visit and process TypeScript AST nodes
 */

import * as ts from 'typescript';

/**
 * Abstract visitor for traversing TypeScript AST
 *
 * Implement specific visit methods for nodes you want to handle
 */
export abstract class ASTVisitor {
  protected sourceFile!: ts.SourceFile;

  /**
   * Visit a source file
   */
  visitSourceFile(node: ts.SourceFile): void {
    this.sourceFile = node;
    this.visitNode(node);
  }

  /**
   * Visit any node - dispatches to specific visit methods
   */
  protected visitNode(node: ts.Node): void {
    // Dispatch to specific visitor methods based on node type
    if (ts.isClassDeclaration(node)) {
      this.visitClassDeclaration(node);
    } else if (ts.isInterfaceDeclaration(node)) {
      this.visitInterfaceDeclaration(node);
    } else if (ts.isFunctionDeclaration(node)) {
      this.visitFunctionDeclaration(node);
    } else if (ts.isMethodDeclaration(node)) {
      this.visitMethodDeclaration(node);
    } else if (ts.isPropertyDeclaration(node)) {
      this.visitPropertyDeclaration(node);
    } else if (ts.isPropertySignature(node)) {
      this.visitPropertySignature(node);
    } else if (ts.isMethodSignature(node)) {
      this.visitMethodSignature(node);
    } else if (ts.isConstructorDeclaration(node)) {
      this.visitConstructorDeclaration(node);
    } else if (ts.isParameter(node)) {
      this.visitParameter(node);
    } else if (ts.isTypeAliasDeclaration(node)) {
      this.visitTypeAliasDeclaration(node);
    } else if (ts.isEnumDeclaration(node)) {
      this.visitEnumDeclaration(node);
    } else if (ts.isEnumMember(node)) {
      this.visitEnumMember(node);
    } else if (ts.isModuleDeclaration(node)) {
      this.visitModuleDeclaration(node);
    } else if (ts.isVariableStatement(node)) {
      this.visitVariableStatement(node);
    } else if (ts.isVariableDeclaration(node)) {
      this.visitVariableDeclaration(node);
    } else if (ts.isImportDeclaration(node)) {
      this.visitImportDeclaration(node);
    } else if (ts.isExportDeclaration(node)) {
      this.visitExportDeclaration(node);
    } else if (ts.isTypeParameterDeclaration(node)) {
      this.visitTypeParameter(node);
    } else if (ts.isHeritageClause(node)) {
      this.visitHeritageClause(node);
    }

    // Continue traversing children
    ts.forEachChild(node, (child) => this.visitNode(child));
  }

  // Declaration visitors
  protected visitClassDeclaration(_node: ts.ClassDeclaration): void {}
  protected visitInterfaceDeclaration(_node: ts.InterfaceDeclaration): void {}
  protected visitFunctionDeclaration(_node: ts.FunctionDeclaration): void {}
  protected visitMethodDeclaration(_node: ts.MethodDeclaration): void {}
  protected visitPropertyDeclaration(_node: ts.PropertyDeclaration): void {}
  protected visitPropertySignature(_node: ts.PropertySignature): void {}
  protected visitMethodSignature(_node: ts.MethodSignature): void {}
  protected visitConstructorDeclaration(_node: ts.ConstructorDeclaration): void {}
  protected visitParameter(_node: ts.ParameterDeclaration): void {}
  protected visitTypeAliasDeclaration(_node: ts.TypeAliasDeclaration): void {}
  protected visitEnumDeclaration(_node: ts.EnumDeclaration): void {}
  protected visitEnumMember(_node: ts.EnumMember): void {}
  protected visitModuleDeclaration(_node: ts.ModuleDeclaration): void {}
  protected visitVariableStatement(_node: ts.VariableStatement): void {}
  protected visitVariableDeclaration(_node: ts.VariableDeclaration): void {}
  protected visitImportDeclaration(_node: ts.ImportDeclaration): void {}
  protected visitExportDeclaration(_node: ts.ExportDeclaration): void {}
  protected visitTypeParameter(_node: ts.TypeParameterDeclaration): void {}
  protected visitHeritageClause(_node: ts.HeritageClause): void {}
}

/**
 * Type node visitor for handling type expressions
 */
export abstract class TypeVisitor {
  /**
   * Visit a type node
   */
  visitType(node: ts.TypeNode): string {
    if (ts.isTypeReferenceNode(node)) {
      return this.visitTypeReference(node);
    } else if (ts.isArrayTypeNode(node)) {
      return this.visitArrayType(node);
    } else if (ts.isUnionTypeNode(node)) {
      return this.visitUnionType(node);
    } else if (ts.isIntersectionTypeNode(node)) {
      return this.visitIntersectionType(node);
    } else if (ts.isTupleTypeNode(node)) {
      return this.visitTupleType(node);
    } else if (ts.isFunctionTypeNode(node)) {
      return this.visitFunctionType(node);
    } else if (ts.isConstructorTypeNode(node)) {
      return this.visitConstructorType(node);
    } else if (ts.isTypeLiteralNode(node)) {
      return this.visitTypeLiteral(node);
    } else if (ts.isParenthesizedTypeNode(node)) {
      return this.visitParenthesizedType(node);
    } else if (ts.isLiteralTypeNode(node)) {
      return this.visitLiteralType(node);
    } else if (node.kind === ts.SyntaxKind.StringKeyword) {
      return this.visitStringKeyword();
    } else if (node.kind === ts.SyntaxKind.NumberKeyword) {
      return this.visitNumberKeyword();
    } else if (node.kind === ts.SyntaxKind.BooleanKeyword) {
      return this.visitBooleanKeyword();
    } else if (node.kind === ts.SyntaxKind.VoidKeyword) {
      return this.visitVoidKeyword();
    } else if (node.kind === ts.SyntaxKind.AnyKeyword) {
      return this.visitAnyKeyword();
    } else if (node.kind === ts.SyntaxKind.UnknownKeyword) {
      return this.visitUnknownKeyword();
    } else if (node.kind === ts.SyntaxKind.NullKeyword) {
      return this.visitNullKeyword();
    } else if (node.kind === ts.SyntaxKind.UndefinedKeyword) {
      return this.visitUndefinedKeyword();
    } else if (node.kind === ts.SyntaxKind.ObjectKeyword) {
      return this.visitObjectKeyword();
    }

    return 'Variant'; // Fallback
  }

  // Type visitors - override these in subclasses
  protected abstract visitTypeReference(node: ts.TypeReferenceNode): string;
  protected abstract visitArrayType(node: ts.ArrayTypeNode): string;
  protected abstract visitUnionType(node: ts.UnionTypeNode): string;
  protected abstract visitIntersectionType(node: ts.IntersectionTypeNode): string;
  protected abstract visitTupleType(node: ts.TupleTypeNode): string;
  protected abstract visitFunctionType(node: ts.FunctionTypeNode): string;
  protected abstract visitConstructorType(node: ts.ConstructorTypeNode): string;
  protected abstract visitTypeLiteral(node: ts.TypeLiteralNode): string;
  protected abstract visitParenthesizedType(node: ts.ParenthesizedTypeNode): string;
  protected abstract visitLiteralType(node: ts.LiteralTypeNode): string;

  // Keyword type visitors
  protected visitStringKeyword(): string {
    return 'String';
  }
  protected visitNumberKeyword(): string {
    return 'Float';
  }
  protected visitBooleanKeyword(): string {
    return 'Boolean';
  }
  protected visitVoidKeyword(): string {
    return '';
  }
  protected visitAnyKeyword(): string {
    return 'Variant';
  }
  protected visitUnknownKeyword(): string {
    return 'Variant';
  }
  protected visitNullKeyword(): string {
    return 'Variant';
  }
  protected visitUndefinedKeyword(): string {
    return 'Variant';
  }
  protected visitObjectKeyword(): string {
    return 'Variant';
  }
}

/**
 * Collecting visitor that gathers nodes of specific types
 */
export class CollectingVisitor<T extends ts.Node> extends ASTVisitor {
  private collected: T[] = [];
  private predicate: (node: ts.Node) => node is T;

  constructor(predicate: (node: ts.Node) => node is T) {
    super();
    this.predicate = predicate;
  }

  protected visitNode(node: ts.Node): void {
    if (this.predicate(node)) {
      this.collected.push(node);
    }
    super.visitNode(node);
  }

  getCollected(): T[] {
    return this.collected;
  }

  static collect<T extends ts.Node>(
    sourceFile: ts.SourceFile,
    predicate: (node: ts.Node) => node is T
  ): T[] {
    const visitor = new CollectingVisitor(predicate);
    visitor.visitSourceFile(sourceFile);
    return visitor.getCollected();
  }
}

/**
 * Helper functions for node type checking
 */
export const NodePredicates = {
  isClass: (node: ts.Node): node is ts.ClassDeclaration => ts.isClassDeclaration(node),
  isInterface: (node: ts.Node): node is ts.InterfaceDeclaration =>
    ts.isInterfaceDeclaration(node),
  isFunction: (node: ts.Node): node is ts.FunctionDeclaration => ts.isFunctionDeclaration(node),
  isTypeAlias: (node: ts.Node): node is ts.TypeAliasDeclaration =>
    ts.isTypeAliasDeclaration(node),
  isEnum: (node: ts.Node): node is ts.EnumDeclaration => ts.isEnumDeclaration(node),
  isModule: (node: ts.Node): node is ts.ModuleDeclaration => ts.isModuleDeclaration(node),
};
