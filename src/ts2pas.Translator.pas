unit ts2pas.Translator;

interface

uses
  TypeScript, ts2pas.Expressions;

type
  TTranslator = class(IExpressionOwner)
  private
    FScanner: JScanner;

    FDeclarations: array of TDeclarationExpression;
    FModules: array of TModuleExpression;
    FInterfaces: array of TInterfaceExpression;

    function ReadDeclarationExpression: TDeclarationExpression;
    function ReadEnumerationItem: TEnumerationItem;
    function ReadEnumerationExpression: TEnumerationExpression;
    function ReadObjectType: TObjectType;
    function ReadFieldExpression: TFieldExpression;
    function ReadMethodExpression: TMethodExpression;
    function ReadFunctionParameter: TFunctionParameter;
    function ReadFunctionType: TFunctionType;
    function ReadFunctionExpression: TFunctionExpression;
    function ReadImportExpression: TImportExpression;
    function ReadStructureMember: TCustomStructureMember;
    function ReadInterfaceExpression: TInterfaceExpression;
    function ReadClassExpression: TClassExpression;
    function ReadModuleExpression: TModuleExpression;
    function ReadScopedName: String;
    function ReadType: TCustomType;
    function ReadVariableExpression: TVariableExpression;
    procedure HandleScanError;

    procedure AssumeIdentifier;
    procedure AssumeToken(Token: TSyntaxKind); overload;
    procedure AssumeToken(Tokens: array of TSyntaxKind); overload;
    function ReadIdentifier(Required: Boolean = False): Boolean;
    function ReadToken: TSyntaxKind; overload;
    function ReadToken(Token: TSyntaxKind; Required: Boolean = False): Boolean; overload;
    function ReadToken(Tokens: array of TSyntaxKind; Required: Boolean = False): Boolean; overload;
  protected
    procedure ReadDefinition; virtual;
    function BuildPascalHeader: String; virtual;
  public
    constructor Create;

    function Translate(Source: String): String;

    property Name: String;
  end;

implementation

uses
  NodeJS.Core;


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
        FDeclarations.Add(ReadDeclarationExpression);
      TSyntaxKind.InterfaceKeyword:
        FInterfaces.Add(ReadInterfaceExpression);
      TSyntaxKind.ModuleKeyword:
        FModules.Add(ReadModuleExpression);
      TSyntaxKind.ImportKeyword:
        ReadImportExpression;
      TSyntaxKind.EndOfFileToken:
        Exit;
      else
        HandleScanError;
    end;
  end;
end;

function TTranslator.ReadDeclarationExpression: TDeclarationExpression;
begin
  AssumeToken(TSyntaxKind.DeclareKeyword);

  Result := TDeclarationExpression.Create(Self as IExpressionOwner);

  while ReadToken > TSyntaxKind.Unknown do
  begin
    case FScanner.GetToken of
      TSyntaxKind.DeclareKeyword:
        continue;
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadVariableExpression);
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadFunctionExpression);
      TSyntaxKind.ModuleKeyword:
        Result.Modules.Add(ReadModuleExpression);
      TSyntaxKind.InterfaceKeyword:
        Result.Interfaces.Add(ReadInterfaceExpression);
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadClassExpression);
      TSyntaxKind.EnumKeyword:
        ReadEnumerationExpression;
      TSyntaxKind.EndOfFileToken:
        Exit;
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
  Result := TEnumerationItem.Create(Self as IExpressionOwner);

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

function TTranslator.ReadEnumerationExpression: TEnumerationExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.EnumKeyword);

  // create an enumeration
  Result := TEnumerationExpression.Create(Self as IExpressionOwner);

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

function TTranslator.ReadFunctionExpression: TFunctionExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.VarKeyword);

  // create a function
  Result := TFunctionExpression.Create(Self as IExpressionOwner);

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

  Result := TFunctionType.Create(Self as IExpressionOwner);
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
    Result.ResultType := ReadType;
end;

function TTranslator.ReadFunctionParameter: TFunctionParameter;
begin
  // sanity check
  AssumeIdentifier;

  Result := TFunctionParameter.Create(Self as IExpressionOwner);
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
  Result := TObjectType.Create(Self as IExpressionOwner);

  // skip for now
  while FScanner.Scan <> TSyntaxKind.CloseBraceToken do;
end;

function TTranslator.ReadType: TCustomType;
begin
  // read type
  ReadToken([TSyntaxKind.Identifier, TSyntaxKind.AnyKeyword,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.NumberKeyword,
    TSyntaxKind.StringKeyword, TSyntaxKind.BooleanKeyword,
    TSyntaxKind.VoidKeyword, TSyntaxKind.OpenParenToken], True);
  case FScanner.GetToken of
    TSyntaxKind.Identifier:
      Result := TNamedType.Create(Self as IExpressionOwner, ReadScopedName);
    TSyntaxKind.AnyKeyword:
      begin
        Result := TVariantType.Create(Self as IExpressionOwner);
        ReadToken;
      end;
    TSyntaxKind.NumberKeyword:
      begin
        Result := TFloatType.Create(Self as IExpressionOwner);
        ReadToken;
      end;
    TSyntaxKind.VoidKeyword:
      begin
        Result := nil;
        ReadToken;
      end;
    TSyntaxKind.StringKeyword:
      begin
        Result := TStringType.Create(Self as IExpressionOwner);
        ReadToken;
      end;
    TSyntaxKind.BooleanKeyword:
      begin
        Result := TBooleanType.Create(Self as IExpressionOwner);
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

function TTranslator.ReadFieldExpression: TFieldExpression;
begin
  Result := TFieldExpression.Create(Self as IExpressionOwner);
  Result.Type := ReadType;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadMethodExpression: TMethodExpression;
begin
  Result := TMethodExpression.Create(Self as IExpressionOwner);
  Result.Type := ReadFunctionType;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadStructureMember: TCustomStructureMember;
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
      begin
        Result := ReadFieldExpression;
        TFieldExpression(Result).Nullable := Nullable;
      end;
    TSyntaxKind.OpenParenToken:
      Result := ReadMethodExpression;
  end;

  Result.Name := MemberName;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadClassExpression: TClassExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TClassExpression.Create(Self as IExpressionOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := FScanner.getTokenText;

  Console.Log('Read class: ' + Result.Name);

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
  begin
    var Visibility := vPublic;
    case FScanner.getToken of
      TSyntaxKind.PublicKeyword:
        begin
          Visibility := vPublic;
          ReadIdentifier(True);
        end;
      TSyntaxKind.ProtectedKeyword:
        begin
          Visibility := vProtected;
          ReadIdentifier(True);
        end;
      TSyntaxKind.PrivateKeyword:
        begin
          Visibility := vPrivate;
          ReadIdentifier(True);
        end;
    end;

    var IsStatic := (FScanner.getToken = TSyntaxKind.StaticKeyword);
    if IsStatic then
      ReadIdentifier(True);

    var Member := ReadStructureMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Result.Members.Add(Member);
  end;
end;

function TTranslator.ReadInterfaceExpression: TInterfaceExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.InterfaceKeyword);

  // create a interface
  Result := TInterfaceExpression.Create(Self as IExpressionOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := FScanner.getTokenText;

  Console.Log('Read interface: ' + Result.Name);

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
    Result.Members.Add(ReadStructureMember);
end;

function TTranslator.ReadModuleExpression: TModuleExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TModuleExpression.Create(Self as IExpressionOwner);

  // read name
  ReadIdentifier(True);
  Result.Name := ReadScopedName;

  Console.Log('Read module: ' + Result.Name);

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadToken([TSyntaxKind.ClassKeyword, TSyntaxKind.ExportKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.InterfaceKeyword, TSyntaxKind.VarKeyword]) do
  begin
    case FScanner.GetToken of
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadClassExpression);
      TSyntaxKind.ExportKeyword:
        continue; // ignore export token (for now)
      TSyntaxKind.EnumKeyword:
        ReadEnumerationExpression;
      TSyntaxKind.ImportKeyword:
        ReadImportExpression;
      TSyntaxKind.InterfaceKeyword:
        Result.Interfaces.Add(ReadInterfaceExpression);
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadVariableExpression);
      else
        HandleScanError;
    end;
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
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

function TTranslator.ReadImportExpression: TImportExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ImportKeyword);

  // create a import
  Result := TImportExpression.Create(Self as IExpressionOwner);
end;

function TTranslator.ReadVariableExpression: TVariableExpression;
begin
  // sanity check
  AssumeToken(TSyntaxKind.FunctionKeyword);

  // create a variable
  Result := TVariableExpression.Create(Self as IExpressionOwner);

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

function TTranslator.BuildPascalHeader: String;
begin
  Result := 'unit ' + Name + ';' + CRLF + CRLF;
  Result += 'interface' + CRLF + CRLF;

  for var Declaration in FDeclarations do
    Result := Result + Declaration.AsCode;

  for var Module in FModules do
    Result := Result + Module.AsCode;

  for var &Interface in FInterfaces do
    Result := Result + &Interface.AsCode;
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

  Result := BuildPascalHeader;
end;

end.