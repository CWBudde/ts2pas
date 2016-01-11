unit ts2pas.Translator;

interface

uses
  TypeScript;

type
  TCustomType = class
  protected
    function GetName: String; virtual; abstract;
  public
    property Name: String read GetName;
    property IsArray: Boolean;
  end;

  TVariantType = class(TCustomType)
  protected
    function GetName: String; override;
  end;

  TFloatType = class(TCustomType)
  protected
    function GetName: String; override;
  end;

  TStringType = class(TCustomType)
  protected
    function GetName: String; override;
  end;

  TBooleanType = class(TCustomType)
  protected
    function GetName: String; override;
  end;

  TFunctionParameter = class
    property Name: String;
    property &Type: TCustomType;
    property Nullable: Boolean;
  end;

  TFunctionType = class(TCustomType)
  protected
    function GetName: String; override;
  public
    property Name: String read GetName;
    property Result: TCustomType;
    property Parameters: array of TFunctionParameter;
  end;

  TObjectType = class(TCustomType)
  protected
    function GetName: String; override;
  end;

  TNamedType = class(TCustomType)
  private
    FName: String;
  protected
    function GetName: String; override;
  public
    constructor Create(AName: String);
    property Name: String read GetName;
  end;

  TDefinition = class
  public
    property Name: String;
  end;

  TEnumerationItem = class
  public
    property Name: String;
    property Value: String;
  end;

  TEnumeration = class
  public
    property Items: array of TEnumerationItem;
    property Name: String;
  end;

  TFunction = class
  public
    property Name: String;
    property &Type: TFunctionType;
  end;

  TCustomInterfaceMember = class
  public
    property Name: String;
  end;

  TField = class(TCustomInterfaceMember)
  public
    property Nullable: Boolean;
    property &Type: TCustomType;
  end;

  TMethod = class(TCustomInterfaceMember)
  public
    property &Type: TFunctionType;
  end;

  TInterface = class
  public
    property Name: String;
    property Extends: array of String;
    property Implements: array of String;
    property Members: array of TCustomInterfaceMember;
  end;

  TImport = class
  public
    property Name: String;
  end;

  TVariable = class
  public
    property Name: String;
  end;

  TModule = class
  public
    property Name: String;
    property Variables: array of TVariable;
  end;

  TDeclaration = class
  public
    property Name: String;
    property Functions: array of TFunction;
    property Variables: array of TVariable;
  end;

  TTranslator = class
  private
    FScanner: JScanner;

    FDeclarations: array of TDeclaration;
    FModules: array of TModule;

    function ReadDeclaration: TDeclaration;
    function ReadEnumerationItem: TEnumerationItem;
    function ReadEnumeration: TEnumeration;
    function ReadObjectType: TObjectType;
    function ReadField(Name: String; Nullable: Boolean): TField;
    function ReadMethod(Name: String): TMethod;
    function ReadFunctionParameter: TFunctionParameter;
    function ReadFunctionType: TFunctionType;
    function ReadFunction: TFunction;
    function ReadImport: TImport;
    function ReadInterface: TInterface;
    function ReadInterfaceMember: TCustomInterfaceMember;
    function ReadModule: TModule;
    function ReadScopedName: String;
    function ReadType: TCustomType;
    function ReadVariable: TVariable;
    procedure HandleScanError;

    procedure ReadDefinition;

    procedure AssumeIdentifier;
    procedure AssumeToken(Token: TSyntaxKind); overload;
    procedure AssumeToken(Tokens: array of TSyntaxKind); overload;
    function ReadIdentifier(Required: Boolean = False): Boolean;
    function ReadToken: TSyntaxKind; overload;
    function ReadToken(Token: TSyntaxKind; Required: Boolean = False): Boolean; overload;
    function ReadToken(Tokens: array of TSyntaxKind; Required: Boolean = False): Boolean; overload;
  public
    constructor Create;

    function Translate(Source: String): String;
  end;

implementation

uses
  NodeJS.Core;


{ TVariantType }

function TVariantType.GetName: String;
begin
  Result := 'Variant';
end;


{ TFloatType }

function TFloatType.GetName: String;
begin
  Result := 'Float';
end;


{ TBooleanType }

function TBooleanType.GetName: String;
begin
  Result := 'Boolean';
end;


{ TStringType }

function TStringType.GetName: String;
begin
  Result := 'Boolean';
end;


{ TFunctionType }

function TFunctionType.GetName: String;
begin
  Result := 'function';
end;


{ TNamedType }

constructor TNamedType.Create(AName: String);
begin
  FName := AName
end;

function TNamedType.GetName: String;
begin
  Result := FName;
end;


{ TObjectType }

function TObjectType.GetName: String;
begin
  Result := 'record';
end;


{ TTranslator }

constructor TTranslator.Create;
begin

end;

procedure TTranslator.AssumeIdentifier;
begin
  if not FScanner.isIdentifier then
    HandleScanError;
end;

procedure TTranslator.AssumeToken(Token: TSyntaxKind);
begin
  if FScanner.GetToken <> Token then
    HandleScanError;
end;

procedure TTranslator.AssumeToken(Tokens: array of TSyntaxKind);
begin
  if not (FScanner.GetToken in Tokens) then
    HandleScanError;
end;

function TTranslator.ReadToken: TSyntaxKind;
begin
  Result := FScanner.Scan;
end;

function TTranslator.ReadToken(Token: TSyntaxKind; Required: Boolean = False): Boolean;
begin
  Result := ReadToken = Token;
  if not Result and Required then
    HandleScanError;
end;

function TTranslator.ReadToken(Tokens: array of TSyntaxKind; Required: Boolean = False): Boolean;
begin
  Result := ReadToken in Tokens;
  if not Result and Required then
    HandleScanError;
end;

function TTranslator.ReadIdentifier(Required: Boolean = False): Boolean;
begin
  ReadToken;
  Result := FScanner.isIdentifier;
  if not Result and Required then
    HandleScanError;
end;

procedure TTranslator.ReadDefinition;
begin
  while ReadToken > TSyntaxKind.Unknown do
  begin
    // ignore export token (for now)
    case FScanner.GetToken of
      TSyntaxKind.ExportKeyword:
        continue;
      TSyntaxKind.DeclareKeyword:
        FDeclarations.Add(ReadDeclaration);
      TSyntaxKind.InterfaceKeyword:
        ReadInterface;
      TSyntaxKind.ModuleKeyword:
        FModules.Add(ReadModule);
      TSyntaxKind.ImportKeyword:
        ReadImport;
      TSyntaxKind.EndOfFileToken:
        Exit;
      else
        HandleScanError;
    end;
  end;
end;

function TTranslator.ReadDeclaration: TDeclaration;
begin
  AssumeToken(TSyntaxKind.DeclareKeyword);

  Result := TDeclaration.Create;

  while ReadToken > TSyntaxKind.Unknown do
  begin
    case FScanner.GetToken of
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadVariable);
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadFunction);
      TSyntaxKind.ModuleKeyword:
        ReadModule;
      TSyntaxKind.InterfaceKeyword:
        ReadInterface;
      TSyntaxKind.ClassKeyword:
        ReadInterface;
      TSyntaxKind.EnumKeyword:
        ReadEnumeration;
      else
        HandleScanError;
    end;
  end;
end;

function TTranslator.ReadEnumerationItem: TEnumerationItem;
begin
  // sanity check
  AssumeIdentifier;

  // create an enumeration
  Result := TEnumerationItem.Create;

  // set item name
  Result.Name := FScanner.GetTokenText;

  if ReadToken(TSyntaxKind.EqualsToken) then
  begin
    ReadToken(TSyntaxKind.NumericLiteral, True);
    Result.Value := FScanner.GetTokenText;
    ReadToken;
  end;

  AssumeToken(TSyntaxKind.CommaToken);
end;

function TTranslator.ReadEnumeration: TEnumeration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.EnumKeyword);

  // create an enumeration
  Result := TEnumeration.Create;

  // read name
  ReadIdentifier(True);
  Result.Name := FScanner.GetTokenText;

  // read open brace
  ReadToken(TSyntaxKind.OpenBraceToken, True);

  // read enumeration items
  ReadIdentifier(True);
  repeat
    Result.Items.Add(ReadEnumerationItem);
  until not ReadIdentifier;

  // assume close brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadFunction: TFunction;
begin
  // sanity check
  AssumeToken(TSyntaxKind.VarKeyword);

  // create a function
  Result := TFunction.Create;

  // read function name
  ReadIdentifier(True);
  Result.Name := FScanner.getTokenText;

  // next token must be an open paren
  ReadToken(TSyntaxKind.OpenParenToken, True);
  Result.&Type := ReadFunctionType;
end;

function TTranslator.ReadFunctionType: TFunctionType;
begin
  // sanity check
  AssumeToken(TSyntaxKind.OpenParenToken);

  Result := TFunctionType.Create;
  while ReadIdentifier do
  begin
    Result.Parameters.Add(ReadFunctionParameter);

    AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken]);

    // eventually break if a close paren has been found
    if FScanner.GetToken = TSyntaxKind.CloseParenToken then
      break;
  end;

  // ensure that we are a close paren token
  AssumeToken(TSyntaxKind.CloseParenToken);

  if ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.EqualsGreaterThanToken]) then
    Result.Result := ReadType;
end;

function TTranslator.ReadFunctionParameter: TFunctionParameter;
begin
  // sanity check
  AssumeIdentifier;

  Result := TFunctionParameter.Create;
  Result.Name := FScanner.GetTokenText;

  // either accept ? or : or )
  ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken, TSyntaxKind.CloseParenToken], True);

  // check if type is nullable
  Result.Nullable := FScanner.getToken = TSyntaxKind.QuestionToken;
  if Result.Nullable then
    ReadToken(TSyntaxKind.ColonToken, True);

  if FScanner.getToken = TSyntaxKind.ColonToken then
    Result.&Type := ReadType;
end;

function TTranslator.ReadObjectType: TObjectType;
begin
  // sanity check
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // create an object type
  Result := TObjectType.Create;

  // skip for now
  while FScanner.Scan <> TSyntaxKind.CloseBraceToken do;
end;

function TTranslator.ReadType: TCustomType;
begin
  // read type
  ReadToken([TSyntaxKind.Identifier, TSyntaxKind.AnyKeyword,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.NumberKeyword,
    TSyntaxKind.StringKeyword, TSyntaxKind.BooleanKeyword,
    TSyntaxKind.OpenParenToken], True);
  case FScanner.GetToken of
    TSyntaxKind.Identifier:
      Result := TNamedType.Create(ReadScopedName);
    TSyntaxKind.AnyKeyword:
      begin
        Result := TVariantType.Create;
        ReadToken;
      end;
    TSyntaxKind.NumberKeyword:
      begin
        Result := TFloatType.Create;
        ReadToken;
      end;
    TSyntaxKind.StringKeyword:
      begin
        Result := TStringType.Create;
        ReadToken;
      end;
    TSyntaxKind.BooleanKeyword:
      begin
        Result := TBooleanType.Create;
        ReadToken;
      end;
    TSyntaxKind.OpenParenToken:
      begin
        Result := ReadFunctionType;
        Exit; // array not possible here
      end;
    TSyntaxKind.OpenBraceToken:
      begin
        Result := ReadObjectType;
        ReadToken;
      end;
  end;

  if FScanner.getToken = TSyntaxKind.OpenBracketToken then
  begin
    Result.IsArray := True;
    ReadToken(TSyntaxKind.CloseBracketToken, True);
    ReadToken;
  end;
end;

function TTranslator.ReadField(Name: String; Nullable: Boolean): TField;
begin
  Result := TField.Create;
  Result.Name := Name;
  Result.Nullable := Nullable;
  Result.Type := ReadType;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadMethod(Name: String): TMethod;
begin
  Result := TMethod.Create;
  Result.Type := ReadFunctionType;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadInterfaceMember: TCustomInterfaceMember;
begin
  // sanity check
  AssumeIdentifier;

  // create a interface member
  var MemberName := FScanner.getTokenText;

  ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

  // check if type is nullable
  var Nullable := FScanner.getToken = TSyntaxKind.QuestionToken;
  if Nullable then
    ReadToken(TSyntaxKind.ColonToken, True);

  case FScanner.getToken of
    TSyntaxKind.ColonToken:
      Result := ReadField(MemberName, Nullable);
    TSyntaxKind.OpenParenToken:
      Result := ReadMethod(MemberName);
  end;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadInterface: TInterface;
begin
  // sanity check
  AssumeToken(TSyntaxKind.InterfaceKeyword);

  // create a interface
  Result := TInterface.Create;

  // read interface name
  ReadIdentifier(True);
  Result.Name := FScanner.getTokenText;

  Console.Log('Read Interface: ' + Result.Name);

  ReadToken;
  while FScanner.getToken in [TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword] do
  begin
    var List := if FScanner.getToken = TSyntaxKind.ExtendsKeyword then
      Result.Extends else Result.Implements;

    ReadIdentifier(True);
    List.Add(ReadScopedName);
    while FScanner.getToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      List.Add(ReadScopedName);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadIdentifier do
    Result.Members.Add(ReadInterfaceMember);
end;

function TTranslator.ReadModule: TModule;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TModule.Create;

  // read name
  ReadIdentifier(True);
  Result.Name := FScanner.GetTokenText;

  // eventually read scoped name
  while ReadToken(TSyntaxKind.DotToken) do
  begin
    ReadIdentifier(True);
    Result.Name := Result.Name + '.' + FScanner.GetTokenText;
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadToken([TSyntaxKind.ClassKeyword, TSyntaxKind.ExportKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.InterfaceKeyword, TSyntaxKind.VarKeyword]) do
  begin
    // ignore export token (for now)
    case FScanner.GetToken of
      TSyntaxKind.ClassKeyword:
        ReadInterface;
      TSyntaxKind.ExportKeyword:
        continue;
      TSyntaxKind.EnumKeyword:
        ReadEnumeration;
      TSyntaxKind.ImportKeyword:
        ReadImport;
      TSyntaxKind.InterfaceKeyword:
        ReadInterface;
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadVariable);
      else
        HandleScanError;
    end;
  end;
end;

function TTranslator.ReadScopedName: String;
begin
  AssumeIdentifier;
  Result := FScanner.getTokenText;

  while ReadToken(TSyntaxKind.DotToken) do
  begin
    ReadIdentifier(True);
    Result += '.' + FScanner.GetTokenText;
  end;
end;

function TTranslator.ReadImport: TImport;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ImportKeyword);

  // create a import
  Result := TImport.Create;
end;

function TTranslator.ReadVariable: TVariable;
begin
  // sanity check
  AssumeToken(TSyntaxKind.FunctionKeyword);

  // create a variable
  Result := TVariable.Create;

  // read variable identified
  ReadIdentifier(True);
  Result.Name := FScanner.GetTokenText;

  // read colon
  ReadToken(TSyntaxKind.ColonToken, True);
end;

procedure TTranslator.HandleScanError;
begin

  raise Exception.Create(Format('Unknown token (%s) in this context. At pos %d',
    [FScanner.getTokenText, FScanner.getTokenPos]));
end;


function TTranslator.Translate(Source: String): String;
begin
  FScanner := TypeScriptExport.createScanner(TScriptTarget.ES3, True,
    TLanguageVariant.Standard, Source);

  try
    ReadDefinition;
  except
    on e: Exception do
      Console.Log(E.Message);
  end;

  Result := Source;
end;

end.