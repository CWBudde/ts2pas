unit ts2pas.Main;

interface

uses
  NodeJS.Core, NodeJS.FS, ts2pas.Translator;

procedure ConvertFile(InputFile, OutputFile: String); overload;
procedure ConvertFile(InputFile: String); overload;

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

end.