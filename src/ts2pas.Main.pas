unit ts2pas.Main;

interface

uses
  NodeJS.Core, NodeJS.FS, NodeJS.https, NodeJS.events, TypeScript,
  ts2pas.Translator;

function TranslateFile(InputFile, OutputFile: String): Boolean; overload;
function TranslateFile(InputFile: String): Boolean; overload;
procedure LoadAndTranslate(URL: String);
{$IFNDEF CommandLine}
procedure TranslateDirectory(Directory: String);
procedure OutputAst(InputFile: String);
procedure ProcesAllUrls;
{$ENDIF}

implementation

var FileSystem := fs;

{$IFNDEF CommandLine}
procedure TranslateDirectory(Directory: String);
var
  Success: array of String;
begin
  FileSystem.readdir(Directory, lambda(err: JError; files: array of string)
    for var File in files do
    begin
      // only consider files with .d.ts extension
      if not File.EndsWith('.d.ts') then
        continue;

      if TranslateFile(Directory + File) then
        Success.Add(File)
      else
//        Exit;
    end;
  end);
end;
{$ENDIF}

function TranslateFile(InputFile, OutputFile: String): Boolean; overload;
begin
  var InputName := InputFile.Before('.d.ts');
  if InputFile = InputName then
    InputFile += '.d.ts';

  var Data := FileSystem.readFileSync(InputFile);
  if not Assigned(data) then
    Exit;
  var InputText := data.toString('utf8');

  {$IFDEF DEBUG}
  Console.Log('Converting file ' + InputFile);
  {$ENDIF}

  var Translator := TTranslator.Create;
  Translator.Name := InputName;
  var OutputText := Translator.Translate(InputText);

  Result := OutputText <> '';

  if OutputText.Length > 5 then
    FileSystem.writeFileSync(OutputFile, OutputText);

  {$IFDEF DEBUG}
  Console.Log('Done!');
  Console.Log('');
  {$ENDIF}

  Translator := nil;
end;

function TranslateFile(InputFile: String): Boolean; overload;
begin
  Result := TranslateFile(InputFile, InputFile.Before('.d.ts') + '.pas');
end;

{$IFNDEF CommandLine}
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
  if InputFile = InputFile.Before('.d.ts') then
    InputFile += '.d.ts';

  FileSystem.readFile(InputFile, lambda(err: Variant; data: JNodeBuffer)
    var InputText := data.toString('utf8');

    var SourceFile := TypeScriptExport.createSourceFile(InputFile, InputText,
      TScriptTarget.ES6, true);

    delint(SourceFile);
  end);

end;
{$ENDIF}

procedure LoadAndTranslate(Url: String);
begin
  var Https := NodeJS.https.https;
  var Options := new JRequestOptions;
  Options.hostname := 'raw.githubusercontent.com';
  Options.path := Url;
  Console.Log('Fetching: ' + URL);

  var Translator := TTranslator.Create;

  var ClientRequest := Https.get(Options, lambda(EventEmitter: JNodeEventEmitter)
    var InputText := '';

    var URLParts := Url.Split('/');
    var InputName := URLParts[High(URLParts)].Before('.d.ts');
    var OutputFile := InputName + '.pas';

    // concat each chunk of data
    EventEmitter.on('data', lambda(ChunkText: Variant)
      InputText += ChunkText;
    end);

    // done
    EventEmitter.on('end', lambda
      Console.Log('Translating: ' + InputName);
      Translator.Name := InputName;
      var OutputText := Translator.Translate(InputText);

      Console.Log('Writing: ' + OutputFile);
      if OutputText.Length > 5 then
        FileSystem.writeFile(OutputFile, OutputText, lambda(Error: Variant)
          end);

      {$IFDEF DEBUG}
      Console.Log('Done!');
      Console.Log('');
      {$ENDIF}
    end);
  end);

  ClientRequest.on('error', lambda(Error: variant)
		 Console.Log('Error: ', Error);
  end);
end;

{$IFNDEF CommandLine}
procedure ProcesAllUrls;
begin
  var URLs = [
    'abs/abs.d.ts',
    'absolute/absolute.d.ts',
    'accounting/accounting.d.ts',
    'acc-wizard/acc-wizard.d.ts',
    'amazon-product-api/amazon-product-api.d.ts',
    'amcharts/AmCharts.d.ts',
    'amplifyjs/amplifyjs.d.ts',
    'box2d/box2dweb.d.ts',
    'browserify/browserify.d.ts',
    'd3/d3.d.ts',
    'devextreme/devextreme.d.ts',
    'dojo/dijit.d.ts',
    'dojo/dojo.d.ts',
    'easeljs/easeljs.d.ts',
    'ember/ember.d.ts',
    'express/express.d.ts',
    'fabricjs/fabricjs.d.ts',
    'gruntjs/gruntjs.d.ts',
    'hapi/hapi.d.ts',
    'jquery/jquery.d.ts',
    'jquerymobile/jquerymobile.d.ts',
    'kendo-ui/kendo-ui.d.ts',
    'leapmotionTS/LeapMotionTS.d.ts',
    'linq/linq.d.ts',
    'matter-js/matter-js.d.ts',
    'office-js/office-js.d.ts',
    'openlayers/openlayers.d.ts',
    'phantom/phantom.d.ts',
    'phantomjs/phantomjs.d.ts',
    'phonegap/phonegap.d.ts',
    'plottable/plottable.d.ts',
    'preloadjs/preloadjs.d.ts',
    'socket.io/socket.io.d.ts',
    'soundjs/soundjs.d.ts',
    'titanium/titanium.d.ts',
    'tweenjs/tweenjs.d.ts',
    'typescript/typescript.d.ts',
    'ui-grid/ui-grid.d.ts',
    'webix/webix.d.ts',
    'winjs/winjs.d.ts',
    'winrt/winrt.d.ts',
    'youtube/youtube.d.ts'

    ];

  for var URL in URLs do
    LoadAndTranslate('/DefinitelyTyped/DefinitelyTyped/master/' + URL);
end;
{$ENDIF}

end.