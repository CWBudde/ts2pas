/**
 * TypeScript Parser Module
 *
 * Responsible for parsing TypeScript definition files using the TypeScript Compiler API
 */

import * as ts from 'typescript';

/**
 * Parse a TypeScript definition file
 *
 * @param content - TypeScript file content
 * @param fileName - Optional file name (default: 'temp.d.ts')
 * @returns TypeScript SourceFile AST
 */
export function parseTypeScriptDefinition(content: string, fileName = 'temp.d.ts'): ts.SourceFile {
  return ts.createSourceFile(fileName, content, ts.ScriptTarget.Latest, true, ts.ScriptKind.TS);
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
