/**
 * TypeScript Parser Module
 *
 * Responsible for parsing TypeScript definition files using the TypeScript Compiler API
 */

import * as ts from 'typescript';

/**
 * Options for parsing TypeScript definitions
 */
export interface ParserOptions {
  /** File name for the source (used in error messages) */
  fileName?: string;
  /** TypeScript compiler options */
  compilerOptions?: ts.CompilerOptions;
  /** Whether to include JSDoc comments */
  includeJsDoc?: boolean;
}

/**
 * Result of parsing a TypeScript definition file
 */
export interface ParseResult {
  /** The parsed source file */
  sourceFile: ts.SourceFile;
  /** Extracted declarations */
  declarations: ParsedDeclaration[];
  /** Any diagnostics/errors from parsing */
  diagnostics: ts.Diagnostic[];
}

/**
 * Represents a parsed TypeScript declaration
 */
export interface ParsedDeclaration {
  /** The kind of declaration */
  kind: DeclarationKind;
  /** The name of the declaration */
  name: string;
  /** The original TypeScript node */
  node: ts.Node;
  /** Whether this is exported */
  isExported: boolean;
  /** JSDoc comment if available */
  jsDoc?: string;
  /** Additional metadata specific to declaration type */
  metadata?: Record<string, unknown>;
}

/**
 * Types of declarations we can parse
 */
export enum DeclarationKind {
  Class = 'class',
  Interface = 'interface',
  Function = 'function',
  Variable = 'variable',
  TypeAlias = 'type-alias',
  Enum = 'enum',
  Namespace = 'namespace',
  Module = 'module',
  Import = 'import',
  Export = 'export',
}

/**
 * Parse a TypeScript definition file
 *
 * @param content - TypeScript file content
 * @param options - Parser options
 * @returns Parse result with AST and extracted declarations
 */
export function parseTypeScriptDefinition(
  content: string,
  options: ParserOptions = {}
): ParseResult {
  const { fileName = 'temp.d.ts', compilerOptions = {}, includeJsDoc = true } = options;

  // Create source file
  const sourceFile = ts.createSourceFile(
    fileName,
    content,
    ts.ScriptTarget.Latest,
    true,
    ts.ScriptKind.TS
  );

  // Extract declarations
  const declarations: ParsedDeclaration[] = [];
  const visitor = new DeclarationExtractor(sourceFile, includeJsDoc);

  ts.forEachChild(sourceFile, (node) => {
    const decl = visitor.visit(node);
    if (decl) {
      declarations.push(decl);
    }
  });

  // Get diagnostics
  const diagnostics = getDiagnostics(sourceFile, compilerOptions);

  return {
    sourceFile,
    declarations,
    diagnostics,
  };
}

/**
 * Get diagnostics for a source file
 */
function getDiagnostics(
  sourceFile: ts.SourceFile,
  compilerOptions: ts.CompilerOptions
): ts.Diagnostic[] {
  // Create a program to get semantic diagnostics
  const host = ts.createCompilerHost(compilerOptions);
  const originalGetSourceFile = host.getSourceFile;

  host.getSourceFile = (fileName, languageVersion) => {
    if (fileName === sourceFile.fileName) {
      return sourceFile;
    }
    return originalGetSourceFile.call(host, fileName, languageVersion);
  };

  const program = ts.createProgram([sourceFile.fileName], compilerOptions, host);

  const syntacticDiagnostics = program.getSyntacticDiagnostics(sourceFile);
  const semanticDiagnostics = program.getSemanticDiagnostics(sourceFile);

  return [...syntacticDiagnostics, ...semanticDiagnostics];
}

/**
 * Declaration extractor visitor
 */
class DeclarationExtractor {
  constructor(
    private sourceFile: ts.SourceFile,
    private includeJsDoc: boolean
  ) {}

  /**
   * Visit a node and extract declaration information
   */
  visit(node: ts.Node): ParsedDeclaration | null {
    // Check if this is a declaration we care about
    if (ts.isClassDeclaration(node)) {
      return this.extractClass(node);
    } else if (ts.isInterfaceDeclaration(node)) {
      return this.extractInterface(node);
    } else if (ts.isFunctionDeclaration(node)) {
      return this.extractFunction(node);
    } else if (ts.isVariableStatement(node)) {
      return this.extractVariable(node);
    } else if (ts.isTypeAliasDeclaration(node)) {
      return this.extractTypeAlias(node);
    } else if (ts.isEnumDeclaration(node)) {
      return this.extractEnum(node);
    } else if (ts.isModuleDeclaration(node)) {
      return this.extractModule(node);
    } else if (ts.isImportDeclaration(node)) {
      return this.extractImport(node);
    } else if (ts.isExportDeclaration(node)) {
      return this.extractExport(node);
    }

    return null;
  }

  private extractClass(node: ts.ClassDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.Class,
      name: node.name?.text || 'AnonymousClass',
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        isAbstract: hasModifier(node, ts.SyntaxKind.AbstractKeyword),
        heritage: node.heritageClauses?.map((h) => h.getText(this.sourceFile)),
        members: node.members.length,
        typeParameters: node.typeParameters?.map((tp) => tp.name.text),
      },
    };
  }

  private extractInterface(node: ts.InterfaceDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.Interface,
      name: node.name.text,
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        heritage: node.heritageClauses?.map((h) => h.getText(this.sourceFile)),
        members: node.members.length,
        typeParameters: node.typeParameters?.map((tp) => tp.name.text),
      },
    };
  }

  private extractFunction(node: ts.FunctionDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.Function,
      name: node.name?.text || 'anonymousFunction',
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        parameters: node.parameters.length,
        returnType: node.type?.getText(this.sourceFile),
        typeParameters: node.typeParameters?.map((tp) => tp.name.text),
      },
    };
  }

  private extractVariable(node: ts.VariableStatement): ParsedDeclaration | null {
    const declaration = node.declarationList.declarations[0];
    if (!declaration?.name) return null;

    const name = ts.isIdentifier(declaration.name) ? declaration.name.text : 'variable';

    return {
      kind: DeclarationKind.Variable,
      name,
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        isConst: (node.declarationList.flags & ts.NodeFlags.Const) !== 0,
        type: declaration.type?.getText(this.sourceFile),
        hasInitializer: !!declaration.initializer,
      },
    };
  }

  private extractTypeAlias(node: ts.TypeAliasDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.TypeAlias,
      name: node.name.text,
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        type: node.type.getText(this.sourceFile),
        typeParameters: node.typeParameters?.map((tp) => tp.name.text),
      },
    };
  }

  private extractEnum(node: ts.EnumDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.Enum,
      name: node.name.text,
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        isConst: hasModifier(node, ts.SyntaxKind.ConstKeyword),
        members: node.members.length,
      },
    };
  }

  private extractModule(node: ts.ModuleDeclaration): ParsedDeclaration {
    return {
      kind: DeclarationKind.Module,
      name: node.name.text,
      node,
      isExported: isExported(node),
      jsDoc: this.getJsDoc(node),
      metadata: {
        isNamespace: (node.flags & ts.NodeFlags.Namespace) !== 0,
      },
    };
  }

  private extractImport(node: ts.ImportDeclaration): ParsedDeclaration {
    const moduleSpecifier = node.moduleSpecifier;
    const moduleName = ts.isStringLiteral(moduleSpecifier) ? moduleSpecifier.text : 'unknown';

    return {
      kind: DeclarationKind.Import,
      name: moduleName,
      node,
      isExported: false,
      jsDoc: this.getJsDoc(node),
    };
  }

  private extractExport(node: ts.ExportDeclaration): ParsedDeclaration {
    const moduleSpecifier = node.moduleSpecifier;
    const moduleName =
      moduleSpecifier && ts.isStringLiteral(moduleSpecifier)
        ? moduleSpecifier.text
        : 're-export';

    return {
      kind: DeclarationKind.Export,
      name: moduleName,
      node,
      isExported: true,
      jsDoc: this.getJsDoc(node),
    };
  }

  private getJsDoc(node: ts.Node): string | undefined {
    if (!this.includeJsDoc) return undefined;

    const jsDocTags = (node as any).jsDoc;
    if (!jsDocTags || jsDocTags.length === 0) return undefined;

    return jsDocTags[0]?.comment || undefined;
  }
}

/**
 * Visit all nodes in a TypeScript AST
 *
 * @param node - Root node to start visiting from
 * @param visitor - Visitor function called for each node
 */
export function visitAllNodes(node: ts.Node, visitor: (node: ts.Node) => void): void {
  visitor(node);
  ts.forEachChild(node, (child) => visitAllNodes(child, visitor));
}

/**
 * Get the text content of a node
 *
 * @param node - TypeScript node
 * @param sourceFile - Source file containing the node
 * @returns Text content of the node
 */
export function getNodeText(node: ts.Node, sourceFile: ts.SourceFile): string {
  return node.getText(sourceFile);
}

/**
 * Check if a node is exported
 *
 * @param node - TypeScript node
 * @returns True if the node has export modifier
 */
export function isExported(node: ts.Node): boolean {
  return (
    (ts.getCombinedModifierFlags(node as ts.Declaration) & ts.ModifierFlags.Export) !== 0 ||
    (!!node.parent && node.parent.kind === ts.SyntaxKind.SourceFile)
  );
}

/**
 * Check if a node has a specific modifier
 *
 * @param node - TypeScript node
 * @param kind - Modifier kind to check for
 * @returns True if the node has the modifier
 */
export function hasModifier(node: ts.Node, kind: ts.SyntaxKind): boolean {
  if (!ts.canHaveModifiers(node)) return false;
  const modifiers = ts.getModifiers(node);
  if (!modifiers) return false;
  return modifiers.some((mod) => mod.kind === kind);
}

/**
 * Get all modifiers of a node as strings
 *
 * @param node - TypeScript node
 * @returns Array of modifier strings
 */
export function getModifiers(node: ts.Node): string[] {
  if (!ts.canHaveModifiers(node)) return [];
  const modifiers = ts.getModifiers(node);
  if (!modifiers) return [];
  return modifiers.map((mod) => ts.SyntaxKind[mod.kind].toLowerCase());
}

/**
 * Check if a node is a declaration
 */
export function isDeclaration(node: ts.Node): node is ts.Declaration {
  return (
    ts.isVariableDeclaration(node) ||
    ts.isFunctionDeclaration(node) ||
    ts.isClassDeclaration(node) ||
    ts.isInterfaceDeclaration(node) ||
    ts.isTypeAliasDeclaration(node) ||
    ts.isEnumDeclaration(node) ||
    ts.isModuleDeclaration(node)
  );
}
