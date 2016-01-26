unit ts2pas.Main;

interface

uses
  NodeJS.Core, NodeJS.FS, ts2pas.Translator, TypeScript;

procedure ConvertFile(InputFile, OutputFile: String); overload;
procedure ConvertFile(InputFile: String); overload;
procedure OutputAst(InputFile: String);

implementation

var FileSystem := fs;

procedure ConvertFile(InputFile, OutputFile: String); overload;
begin
  if InputFile = InputFile.Split('.')[0] then
    InputFile += '.d.ts';

  FileSystem.readFile(InputFile, lambda(err: Variant; data: JNodeBuffer)
    var InputText := data.toString('utf8');

    {$IFDEF DEBUG}
    Console.Log('Converting file ' + InputFile);
    {$ENDIF}

    var Translator := TTranslator.Create;
    Translator.Name := InputFile.Split('.')[0];
    var OutputText := Translator.Translate(InputText);

    FileSystem.writeFile(OutputFile, OutputText, lambda(err: Variant)
      end);

    {$IFDEF DEBUG}
    Console.Log('Done!');
    Console.Log('');
    {$ENDIF}

    Translator := nil;
  end);
end;

procedure ConvertFile(InputFile: String); overload;
begin
  ConvertFile(InputFile, InputFile.Split('.')[0] + '.pas');
end;

function DelintNode(Node: JNode): Variant;
begin
  case Node.Kind of
    TSyntaxKind.StringLiteral:
      Console.Log(JIdentifier(Node).Text);
    TSyntaxKind.Identifier:
      Console.Log(JIdentifier(Node).Text);
    TSyntaxKind.TypeReference:
      Console.Log(JIdentifier(Node).Text);
    TSyntaxKind.DeclareKeyword:
      Console.Log('declare');
(*
    TSyntaxKind.ModuleBlock:
      Console.Log(JModuleBlock(Node).)
*)
    TSyntaxKind.QualifiedName:
      Console.Log(JQualifiedName(Node).left);
    else
      Console.Log(Node.Kind);
  end;
  TypeScriptExport.forEachChild(Node, @DelintNode);
end;

procedure Delint(SourceFile: JSourceFile);
begin
  DelintNode(SourceFile);
end;

procedure OutputAst(InputFile: String);
begin
  if InputFile = InputFile.Split('.')[0] then
    InputFile += '.d.ts';

  FileSystem.readFile(InputFile, lambda(err: Variant; data: JNodeBuffer)
    var InputText := data.toString('utf8');

    var SourceFile := TypeScriptExport.createSourceFile(InputFile, InputText,
      TScriptTarget.ES6, true);

    delint(SourceFile);
  end);

end;

end.