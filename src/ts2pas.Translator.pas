unit ts2pas.Translator;

interface

uses
  TypeScript, ts2pas.Declarations;

type
  TTranslator = class(IDeclarationOwner)
  private
    FScanner: JScanner;
    FSourceFile: JSourceFile;

    FDeclarations: array of TAmbientDeclaration;
    FModules: array of TModuleDeclaration;
    FImports: array of TImportDeclaration;
    FInterfaces: array of TInterfaceDeclaration;

    function ReadAmbientDeclaration: TAmbientDeclaration;
    function ReadEnumerationItem: TEnumerationItem;
    function ReadEnumerationDeclaration: TEnumerationDeclaration;
    function ReadExportDeclaration: TExportDeclaration;
    function ReadCallbackInterface: TCallbackDeclaration;
    function ReadFieldDeclaration: TFieldDeclaration;
    function ReadConstructorDeclaration: TConstructorDeclaration;
    function ReadMethodDeclaration: TMethodDeclaration;
    function ReadFunctionParameter: TFunctionParameter;
    function ReadFunctionType: TFunctionType;
    function ReadConstructorType: TConstructorType;
    function ReadFunctionDeclaration: TFunctionDeclaration;
    function ReadImportDeclaration: TImportDeclaration;
    function ReadInterfaceDeclaration: TInterfaceDeclaration;
    function ReadClassMember: TCustomTypeMember;
    function ReadClassDeclaration: TClassDeclaration;
    function ReadModuleDeclaration: TModuleDeclaration;
    function ReadIdentifierPath: String;

    function ReadPrimaryType: TCustomType;
    function ReadType: TCustomType;
    function ReadVariableDeclaration: TVariableDeclaration;


    function ReadTypeAliasDeclaration: TTypeAlias;
    function ReadTypeMember: TCustomTypeMember;
    function ReadParameter: TParameter;
    function ReadTypeAnnotation: TCustomType;
    function ReadTypeParameter: TTypeParameter;
    function ReadTypeArgument: TTypeArgument;
    function ReadTypeReference: TTypeReference;
    function ReadCallSignature: TCallSignature;
    function ReadObjectType: TObjectType;
    function ReadConstructorSignature: TConstructorDeclaration;
    function ReadIndexSignature: TIndexDeclaration;

    function ReadAmbientVariableDeclaration: TAmbientVariableDeclaration;
    procedure ReadAmbientBindingList(const AmbientBindingList: array of TAmbientBinding);
    function ReadAmbientBinding: TAmbientBinding;

    function ReadAmbientFunctionDeclaration: TAmbientFunctionDeclaration;
    function ReadAmbientClassDeclaration: TAmbientClassDeclaration;
    function ReadAmbientClassMember: TCustomTypeMember;
    function ReadAmbientEnumDeclaration: TEnumerationDeclaration;
    function ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
    function ReadAmbientNamespaceDeclaration: TNamespaceDeclaration;


    procedure HandleScanError(Expected: TSyntaxKind = TSyntaxKind.Unknown);

    procedure AssumeIdentifier(AdditionalToken: array of TSyntaxKind = []);
    procedure AssumeToken(Token: TSyntaxKind); overload;
    procedure AssumeToken(Tokens: array of TSyntaxKind); overload;
    function ReadIdentifier(Required: Boolean = False): Boolean; overload;
    function ReadIdentifier(AdditionalToken: array of TSyntaxKind; Required: Boolean = False): Boolean; overload;
    function ReadToken: TSyntaxKind; overload;
    function ReadToken(Token: TSyntaxKind; Required: Boolean = False): Boolean; overload;
    function ReadToken(Tokens: array of TSyntaxKind; Required: Boolean = False): Boolean; overload;
  protected
    procedure ReadDefinition; virtual;
    function BuildPascalHeader: String; virtual;

    property CurrentToken: TSyntaxKind read (FScanner.getToken);
    property CurrentTokenText: String read (FScanner.getTokenText);
  public
    constructor Create;

    function Translate(Source: String): String;

    property Name: String;
    property NeedsSemicolon: Boolean;
  end;

implementation

uses
  NodeJS.Core;


{ TTranslator }

constructor TTranslator.Create;
begin
  NeedsSemicolon := False;
end;

procedure TTranslator.AssumeIdentifier(AdditionalToken: array of TSyntaxKind = []);
begin
  if not (FScanner.isIdentifier or (CurrentToken in AdditionalToken)) then
    HandleScanError;
end;

procedure TTranslator.AssumeToken(Token: TSyntaxKind);
begin
  if CurrentToken <> Token then
    HandleScanError(Token);
end;

procedure TTranslator.AssumeToken(Tokens: array of TSyntaxKind);
begin
  if not (CurrentToken in Tokens) then
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
    HandleScanError(Token);
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
    HandleScanError(TSyntaxKind.Identifier);
end;

function TTranslator.ReadIdentifier(AdditionalToken: array of TSyntaxKind; Required: Boolean = False): Boolean;
begin
  ReadToken;
  Result := FScanner.isIdentifier or (CurrentToken in AdditionalToken);
  if not Result and Required then
    HandleScanError;
end;

procedure TTranslator.ReadDefinition;
begin
  while ReadToken([TSyntaxKind.ExportKeyword, TSyntaxKind.DeclareKeyword,
    TSyntaxKind.InterfaceKeyword, TSyntaxKind.ModuleKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.EndOfFileToken], True) do
  begin
    // ignore export token (for now)
    case CurrentToken of
      TSyntaxKind.ExportKeyword:
        continue;
      TSyntaxKind.DeclareKeyword:
        FDeclarations.Add(ReadAmbientDeclaration);
      TSyntaxKind.InterfaceKeyword:
        FInterfaces.Add(ReadInterfaceDeclaration);
      TSyntaxKind.ModuleKeyword:
        FModules.Add(ReadModuleDeclaration);
      TSyntaxKind.ImportKeyword:
        FImports.Add(ReadImportDeclaration);
      TSyntaxKind.EndOfFileToken:
        break;
    end;
  end;
end;

function TTranslator.ReadEnumerationItem: TEnumerationItem;
begin
  // sanity check
  AssumeIdentifier;

  // create an enumeration
  Result := TEnumerationItem.Create(Self as IDeclarationOwner);

  // set item name
  Result.Name := CurrentTokenText;

  if ReadToken(TSyntaxKind.EqualsToken) then
  begin
    ReadToken(TSyntaxKind.NumericLiteral, True);
    Result.Value := CurrentTokenText;
    ReadToken;
  end;

  AssumeToken(TSyntaxKind.CommaToken);
end;

function TTranslator.ReadEnumerationDeclaration: TEnumerationDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.EnumKeyword);

  // create an enumeration
  Result := TEnumerationDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

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

function TTranslator.ReadFunctionDeclaration: TFunctionDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.FunctionKeyword);

  // create a function
  Result := TFunctionDeclaration.Create(Self as IDeclarationOwner);

  // read function name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  // next token must be an open paren
  ReadToken(TSyntaxKind.OpenParenToken, True);
  Result.&Type := ReadFunctionType;
end;

function TTranslator.ReadFunctionType: TFunctionType;
begin
  // sanity check
  AssumeToken(TSyntaxKind.OpenParenToken);

  Result := TFunctionType.Create(Self as IDeclarationOwner);

  while ReadIdentifier([TSyntaxKind.DotDotDotToken]) do
  begin
    Result.Parameters.Add(ReadFunctionParameter);

    AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

    // eventually break if a close paren has been found
    if CurrentToken in [TSyntaxKind.CloseParenToken] then
      break;
  end;

  // ensure that we are a close paren token
  AssumeToken([TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

  if ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.EqualsGreaterThanToken]) then
    Result.ResultType := ReadType;
end;

function TTranslator.ReadConstructorType: TConstructorType;
begin
  // sanity check
  AssumeToken(TSyntaxKind.NewKeyword);

  Result := TConstructorType.Create(Self as IDeclarationOwner);

  ReadToken(TSyntaxKind.OpenParenToken, True);

  while ReadIdentifier([TSyntaxKind.DotDotDotToken]) do
  begin
    Result.Parameters.Add(ReadFunctionParameter);

    AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

    // eventually break if a close paren has been found
    if CurrentToken in [TSyntaxKind.CloseParenToken] then
      break;
  end;

  // ensure that we are a close paren token
  AssumeToken([TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

  if ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.EqualsGreaterThanToken]) then
    Result.ResultType := ReadType;
end;

function TTranslator.ReadFunctionParameter: TFunctionParameter;
var
  OpenArray: Boolean;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.DotDotDotToken]);

  OpenArray := CurrentToken = TSyntaxKind.DotDotDotToken;
  if OpenArray then
    ReadIdentifier(True);

  Result := TFunctionParameter.Create(Self as IDeclarationOwner);
  Result.Name := CurrentTokenText;

  // either accept ? or : or )
  ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
    TSyntaxKind.CloseParenToken], True);

  // check if type is nullable
  Result.Nullable := CurrentToken = TSyntaxKind.QuestionToken;
  if Result.Nullable then
    ReadToken([TSyntaxKind.ColonToken], True);

  if CurrentToken = TSyntaxKind.ColonToken then
    Result.&Type := ReadType;
end;

function TTranslator.ReadExportDeclaration: TExportDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ExportKeyword);

  Result := TExportDeclaration.Create(Self as IDeclarationOwner);

  ReadIdentifier([TSyntaxKind.DefaultKeyword], True);

  Result.Default := (CurrentToken = TSyntaxKind.ExportKeyword) or
    (Lowercase(CurrentTokenText) = 'default');
  if Result.Default then
    ReadIdentifier(True);

  Result.Name := CurrentTokenText;

  ReadToken(TSyntaxKind.SemicolonToken, True);
end;

function TTranslator.ReadPrimaryType: TCustomType;
var
  PrimaryTypeTokens: array of TSyntaxKind = [TSyntaxKind.Identifier,
    TSyntaxKind.StringLiteral, TSyntaxKind.AnyKeyword,
    TSyntaxKind.NumberKeyword, TSyntaxKind.StringKeyword,
    TSyntaxKind.BooleanKeyword, TSyntaxKind.VoidKeyword,
    TSyntaxKind.TypeOfKeyword, TSyntaxKind.OpenBraceToken,
    TSyntaxKind.OpenParenToken];
begin
  // read type
  AssumeToken(PrimaryTypeTokens);

  case CurrentToken of
    TSyntaxKind.OpenParenToken:
      begin
//        ReadToken(PrimaryTypeTokens, True);
        Result := ReadType;
        AssumeToken(TSyntaxKind.CloseParenToken);
        ReadToken;
      end;
    TSyntaxKind.Identifier:
      begin
        Result := TNamedType.Create(Self as IDeclarationOwner, ReadIdentifierPath);
        if CurrentToken = TSyntaxKind.LessThanToken then
        begin
          TNamedType(Result).Arguments.Add(ReadTypeArgument);
          ReadToken;
        end;
      end;
    TSyntaxKind.StringLiteral:
      begin
        Result := TNamedType.Create(Self as IDeclarationOwner, FScanner.getTokenValue);
        ReadToken;
      end;
    TSyntaxKind.AnyKeyword:
      begin
        Result := TVariantType.Create(Self as IDeclarationOwner);
        ReadToken;
      end;
    TSyntaxKind.NumberKeyword:
      begin
        Result := TFloatType.Create(Self as IDeclarationOwner);
        ReadToken;
      end;
    TSyntaxKind.VoidKeyword:
      begin
        Result := nil;
        ReadToken;
      end;
    TSyntaxKind.TypeOfKeyword:
      begin
        Result := TTypeOfType.Create(Self as IDeclarationOwner);
        TTypeOfType(Result).&Type := ReadType;
      end;
    TSyntaxKind.StringKeyword:
      begin
        Result := TStringType.Create(Self as IDeclarationOwner);
        ReadToken;
      end;
    TSyntaxKind.BooleanKeyword:
      begin
        Result := TBooleanType.Create(Self as IDeclarationOwner);
        ReadToken;
      end;
    TSyntaxKind.OpenBraceToken:
      begin
        Result := ReadObjectType;
        ReadToken;
      end;
  end;

  while CurrentToken = TSyntaxKind.OpenBracketToken do
  begin
    var OldType := Result;
    Result := TArrayType.Create(Self as IDeclarationOwner);
    TArrayType(Result).&Type := OldType;

    ReadToken(TSyntaxKind.CloseBracketToken, True);
    ReadToken;
  end;
end;

function TTranslator.ReadType: TCustomType;
var
  TypeTokens: array of TSyntaxKind = [TSyntaxKind.Identifier,
    TSyntaxKind.StringLiteral, TSyntaxKind.AnyKeyword,
    TSyntaxKind.NumberKeyword, TSyntaxKind.StringKeyword,
    TSyntaxKind.BooleanKeyword, TSyntaxKind.VoidKeyword,
    TSyntaxKind.TypeOfKeyword, TSyntaxKind.NewKeyword,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.OpenParenToken];
begin
  // read type
  ReadToken(TypeTokens, True);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Exit(ReadFunctionType);

  if CurrentToken = TSyntaxKind.NewKeyword then
    Exit(ReadConstructorType);

  Result := ReadPrimaryType;

  while CurrentToken = TSyntaxKind.BarToken do
  begin
    if not (Result is TUnionType) then
    begin
      var OldType := Result;
      Result := TUnionType.Create(Self as IDeclarationOwner);
      TUnionType(Result).&Types.Add(OldType);
    end;

    ReadToken(TypeTokens, True);
    TUnionType(Result).Types.Add(ReadPrimaryType);
  end;
end;

function TTranslator.ReadCallbackInterface: TCallbackDeclaration;
begin
  Result := TCallbackDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadFieldDeclaration: TFieldDeclaration;
begin
  Result := TFieldDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadType;

  if NeedsSemicolon then
    AssumeIdentifier([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken,
      TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadConstructorDeclaration: TConstructorDeclaration;
begin
  Result := TConstructorDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadMethodDeclaration: TMethodDeclaration;
begin
  Result := TMethodDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadClassMember: TCustomTypeMember;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken,
    TSyntaxKind.StringLiteral, TSyntaxKind.ExportKeyword]);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Result := ReadCallbackInterface
  else
  begin
    // create a interface member
    var MemberName := CurrentTokenText;

    ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.QuestionToken,
      TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

    if CurrentToken = TSyntaxKind.LessThanToken then
    begin
      ReadTypeParameter;

      ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
        TSyntaxKind.OpenParenToken], True);
    end;

    // check if type is nullable
    var Nullable := CurrentToken = TSyntaxKind.QuestionToken;
    if Nullable then
      ReadToken(TSyntaxKind.ColonToken, True);

    case CurrentToken of
      TSyntaxKind.ColonToken:
        begin
          Result := ReadFieldDeclaration;
          TFieldDeclaration(Result).Nullable := Nullable;
        end;
      TSyntaxKind.OpenParenToken:
        begin
          if LowerCase(MemberName) = 'constructor' then
            Result := ReadConstructorDeclaration
          else
            Result := ReadMethodDeclaration;
        end;
    end;

    Result.Name := MemberName;
  end;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken,
      TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadClassDeclaration: TClassDeclaration;
var
  ClassElementTokens: array of TSyntaxKind = [TSyntaxKind.NewKeyword,
    TSyntaxKind.StringLiteral, TSyntaxKind.ExportKeyword,
    TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken];
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  Console.Log('Read class: ' + Result.Name);

  ReadToken([TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword,
    TSyntaxKind.OpenBraceToken], True);
  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    ReadIdentifier(True);
    Result.Extends.Add(ReadTypeReference);
  end;

  if CurrentToken = TSyntaxKind.ImplementsKeyword then
  begin
    ReadIdentifier(True);
    Result.Implements.Add(ReadIdentifierPath);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      Result.Implements.Add(ReadIdentifierPath);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadIdentifier(ClassElementTokens);
  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    var Visibility := vPublic;
    case CurrentToken of
      TSyntaxKind.PublicKeyword:
        begin
          Visibility := vPublic;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
      TSyntaxKind.ProtectedKeyword:
        begin
          Visibility := vProtected;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
      TSyntaxKind.PrivateKeyword:
        begin
          Visibility := vPrivate;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
    end;

    var IsStatic := (CurrentToken = TSyntaxKind.StaticKeyword);
    if IsStatic then
      ReadIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken], True);

    var Member := ReadAmbientClassMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Result.Members.Add(Member);

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadIdentifier(ClassElementTokens);
  end;
end;

function TTranslator.ReadInterfaceDeclaration: TInterfaceDeclaration;
begin
  // assume we're at the interface keyword
  AssumeToken(TSyntaxKind.InterfaceKeyword);

  // create a interface
  Result := TInterfaceDeclaration.Create(Self as IDeclarationOwner);

  // read type parameters or interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  {$IFDEF DEBUG} Console.Log('Read interface: ' + Result.Name); {$ENDIF}

  ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.ExtendsKeyword,
    TSyntaxKind.OpenBraceToken], True);
  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ReadTypeParameter;

    ReadToken([TSyntaxKind.ExtendsKeyword, TSyntaxKind.OpenBraceToken], True);
  end;

  // read class or interface type list
  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    ReadIdentifier(True);
    Result.Extends.Add(ReadTypeReference);

    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      Result.Extends.Add(ReadTypeReference);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // read object type
  Result.&Type := ReadObjectType;

  // ensure the current token is a close brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadModuleDeclaration: TModuleDeclaration;
var
  ModuleTokens: array of TSyntaxKind = [TSyntaxKind.ClassKeyword,
    TSyntaxKind.ExportKeyword, TSyntaxKind.EnumKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.ModuleKeyword,
    TSyntaxKind.FunctionKeyword, TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.VarKeyword, TSyntaxKind.SemicolonToken,
    TSyntaxKind.CloseBraceToken];
begin
  // sanity check
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TModuleDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier([TSyntaxKind.StringLiteral], True);
  Result.Name := ReadIdentifierPath;

  {$IFDEF DEBUG} Console.Log('Read module: ' + Result.Name); {$ENDIF}

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadToken(ModuleTokens, True);
  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    case CurrentToken of
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadAmbientClassDeclaration);
      TSyntaxKind.ExportKeyword:
        Result.Exports.Add(ReadExportDeclaration);
      TSyntaxKind.EnumKeyword:
        ReadEnumerationDeclaration;
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadFunctionDeclaration);
      TSyntaxKind.ImportKeyword:
        ReadImportDeclaration;
      TSyntaxKind.ModuleKeyword:
        Result.Modules.Add(ReadModuleDeclaration);
      TSyntaxKind.InterfaceKeyword:
        Result.Interfaces.Add(ReadInterfaceDeclaration);
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadVariableDeclaration);
    end;

    ReadToken(ModuleTokens, True)
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadIdentifierPath: String;
begin
  AssumeIdentifier([TSyntaxKind.StringLiteral]);
  Result := CurrentTokenText;

  while ReadToken(TSyntaxKind.DotToken) do
  begin
    ReadIdentifier(True);
    Result += '.' + CurrentTokenText;
  end;
end;

function TTranslator.ReadImportDeclaration: TImportDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ImportKeyword);

  // create a import
  Result := TImportDeclaration.Create(Self as IDeclarationOwner);

  ReadIdentifier([TSyntaxKind.AsteriskToken, TSyntaxKind.StringLiteral], True);

  case CurrentToken of
    TSyntaxKind.AsteriskToken:
      begin
        Result.Name := '*';
        ReadToken(TSyntaxKind.AsKeyword, True);

        ReadIdentifier(True);

        ReadToken(TSyntaxKind.FromKeyword, True);

        ReadToken(TSyntaxKind.StringLiteral, True);
      end;
    TSyntaxKind.StringLiteral:
      begin
        Result.Name := FScanner.GetTokenValue;
      end;
    else
      begin
        Result.Name := CurrentTokenText;

        ReadToken(TSyntaxKind.EqualsToken, True);

        ReadIdentifier(True);
      end;
  end;

  ReadToken(TSyntaxKind.SemicolonToken, True);
end;

function TTranslator.ReadVariableDeclaration: TVariableDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.VarKeyword);

  // create a variable
  Result := TVariableDeclaration.Create(Self as IDeclarationOwner);

  // read variable identified
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  // read colon
  ReadToken(TSyntaxKind.ColonToken, True);

  Result.&Type := ReadType;
end;



function TTranslator.ReadConstructorSignature: TConstructorDeclaration;
begin
  // assume we're at a new keyword
  AssumeToken(TSyntaxKind.NewKeyword);

  // create constructor type
  Result := TConstructorDeclaration.Create(Self as IDeclarationOwner);

  if ReadIdentifier then
  begin
    // read type parameters
    ReadToken(TSyntaxKind.OpenParenToken);
  end;

  AssumeToken(TSyntaxKind.OpenParenToken);

  // ReadParameterList
  ReadIdentifier([TSyntaxKind.PublicKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword, TSyntaxKind.DotDotDotToken,
    TSyntaxKind.CloseParenToken], True);
  while CurrentToken <> TSyntaxKind.CloseParenToken do
  begin
    Result.ParameterList.Add(ReadParameter);

    if CurrentToken = TSyntaxKind.CommaToken then
      ReadIdentifier([TSyntaxKind.DotDotDotToken]);
  end;

  AssumeToken(TSyntaxKind.CloseParenToken);

  // a colon is expected
  ReadToken(TSyntaxKind.ColonToken, True);

  Result.&Type := ReadTypeAnnotation;
end;

function TTranslator.ReadIndexSignature: TIndexDeclaration;
begin
  AssumeToken(TSyntaxKind.OpenBracketToken);

  // create index declaration
  Result := TIndexDeclaration.Create(Self as IDeclarationOwner);

  // read index name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  ReadToken(TSyntaxKind.ColonToken, True);

  ReadToken([TSyntaxKind.StringKeyword, TSyntaxKind.NumberKeyword], True);
  Result.IsStringIndex := CurrentToken = TSyntaxKind.StringKeyword;

  ReadToken(TSyntaxKind.CloseBracketToken, True);
  ReadToken(TSyntaxKind.ColonToken, True);

  Result.&Type := ReadTypeAnnotation;
end;

function TTranslator.ReadTypeMember: TCustomTypeMember;
var
  TypeArgument: TTypeArgument;
begin
  AssumeIdentifier([TSyntaxKind.StringLiteral, TSyntaxKind.NumericLiteral,
    TSyntaxKind.PrivateKeyword, TSyntaxKind.NewKeyword,
    TSyntaxKind.DeleteKeyword, TSyntaxKind.OpenParenToken,
    TSyntaxKind.OpenBracketToken]);

  if CurrentToken = TSyntaxKind.NewKeyword then
    Exit(ReadConstructorSignature);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Exit(ReadCallbackInterface);

  if CurrentToken = TSyntaxKind.OpenBracketToken then
    Exit(ReadIndexSignature);

  if FScanner.IsIdentifier or (FScanner.getToken in [
    TSyntaxKind.StringLiteral, TSyntaxKind.NumericLiteral,
    TSyntaxKind.DeleteKeyword]) then
  begin
    var MemberName := CurrentTokenText;

    ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.QuestionToken,
      TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

    if CurrentToken = TSyntaxKind.LessThanToken then
    begin
      TypeArgument := ReadTypeArgument;

      ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
        TSyntaxKind.OpenParenToken], True);
    end;

    // check if type is nullable
    var Nullable := CurrentToken = TSyntaxKind.QuestionToken;
    if Nullable then
      ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

    case CurrentToken of
      TSyntaxKind.ColonToken:
        begin
          Result := ReadFieldDeclaration;
          TFieldDeclaration(Result).Nullable := Nullable;
        end;
      TSyntaxKind.OpenParenToken:
        Result := ReadMethodDeclaration;
    end;

    Result.Name := MemberName;
  end;
end;

function TTranslator.ReadObjectType: TObjectType;
var
  ObjectTokens: array of TSyntaxKind = [TSyntaxKind.StringLiteral,
    TSyntaxKind.NumericLiteral, TSyntaxKind.NewKeyword,
    TSyntaxKind.OpenParenToken, TSyntaxKind.DeleteKeyword,
    TSyntaxKind.OpenBracketToken, TSyntaxKind.CloseBraceToken];
begin
  // assume we're at an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // create an object type
  Result := TObjectType.Create(Self as IDeclarationOwner);

  ReadIdentifier(ObjectTokens, True);

  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    Result.Members.Add(ReadTypeMember);

    if CurrentToken in [TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken] then
      ReadIdentifier(ObjectTokens, True);
  end;

  // assume we're at a close brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadParameter: TParameter;
begin
  // check we're a parameter (either required, optional or rest)
  AssumeIdentifier([TSyntaxKind.PublicKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword, TSyntaxKind.DotDotDotToken]);

  // create parameter
  Result := TParameter.Create(Self as IDeclarationOwner);
  Result.Name := CurrentTokenText;

  Result.IsRest := CurrentToken = TSyntaxKind.DotDotDotToken;
  if Result.IsRest then
  begin
    // handle rest parameter
    ReadIdentifier(True);

    Result.Name := CurrentTokenText;

    // the next token must be a colon
    if ReadToken(TSyntaxKind.ColonToken) then
      Result.&Type := ReadTypeAnnotation;

    // the current token must be a close paren
    AssumeToken(TSyntaxKind.CloseParenToken);

    Exit;
  end;

  AssumeIdentifier([TSyntaxKind.PublicKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword]);

  case CurrentToken of
    TSyntaxKind.PublicKeyword:
      begin
        Result.AccessibilityModifier := amPublic;
        ReadIdentifier; // or pattern!
      end;
    TSyntaxKind.PrivateKeyword:
      begin
        Result.AccessibilityModifier := amPrivate;
        ReadIdentifier; // or pattern!
      end;
    TSyntaxKind.ProtectedKeyword:
      begin
        Result.AccessibilityModifier := amProtected;
        ReadIdentifier; // or pattern!
      end;
  end;

  // now we must be at an identifier
  AssumeIdentifier;

  // either accept ? or : or )
  ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
    TSyntaxKind.EqualsToken, TSyntaxKind.CommaToken,
    TSyntaxKind.CloseParenToken], True);

  // check if type is nullable
  Result.IsOptional := CurrentToken = TSyntaxKind.QuestionToken;
  if Result.IsOptional then
    ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.EqualsToken,
      TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken], True);

  if CurrentToken = TSyntaxKind.ColonToken then
    Result.&Type := ReadType;

  // assume we're only at an equal token (or at the end)
  AssumeToken([TSyntaxKind.EqualsToken, TSyntaxKind.CommaToken,
    TSyntaxKind.CloseParenToken]);

  // handle initializer
  if CurrentToken = TSyntaxKind.EqualsToken then
  begin
    ReadIdentifier(True);
    Result.DefaultValue := CurrentTokenText;
  end;

  // assume we're only at the end
  AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken]);
end;

function TTranslator.ReadTypeAnnotation: TCustomType;
begin
  // assume we're at a colon
  AssumeToken(TSyntaxKind.ColonToken);

  // read the type (including trailing token!)
  Result := ReadType;
end;

function TTranslator.ReadTypeAliasDeclaration: TTypeAlias;
begin
  AssumeToken(TSyntaxKind.TypeKeyword);

  Result := TTypeAlias.Create(Self as IDeclarationOwner);

  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.EqualsToken], True);
  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ReadTypeParameter;

    ReadToken(TSyntaxKind.EqualsToken, True);
  end;

  Result.&Type := ReadType;

  AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadTypeParameter: TTypeParameter;
begin
  AssumeToken(TSyntaxKind.LessThanToken);

  Result := TTypeParameter.Create(Self as IDeclarationOwner);

  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  ReadToken([TSyntaxKind.ExtendsKeyword, TSyntaxKind.GreaterThanToken], True);
  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    Result.ExtendsType := ReadType;
    AssumeToken(TSyntaxKind.GreaterThanToken);
  end;
end;

function TTranslator.ReadTypeArgument: TTypeArgument;
begin
  AssumeToken(TSyntaxKind.LessThanToken);

  Result := TTypeArgument.Create(Self as IDeclarationOwner);

  Result.&Type := ReadType;
  AssumeToken(TSyntaxKind.GreaterThanToken);
end;

function TTranslator.ReadTypeReference: TTypeReference;
begin
  AssumeIdentifier;

  Result := TTypeReference.Create(Self as IDeclarationOwner);
  Result.Name := ReadIdentifierPath;

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ReadTypeArgument;

    ReadToken;
  end;
end;

function TTranslator.ReadCallSignature: TCallSignature;
begin
  // create call signature
  Result := TCallSignature.Create(Self as IDeclarationOwner);

  ReadToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken], True);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ReadTypeParameter; // should be a list
    ReadToken(TSyntaxKind.OpenParenToken, True);
  end;

  AssumeToken(TSyntaxKind.OpenParenToken);

  ReadIdentifier([TSyntaxKind.PublicKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword, TSyntaxKind.DotDotDotToken,
    TSyntaxKind.CloseParenToken], True);
  while CurrentToken <> TSyntaxKind.CloseParenToken do
  begin
    Result.ParameterList.Add(ReadParameter);

    if CurrentToken = TSyntaxKind.CommaToken then
      ReadIdentifier([TSyntaxKind.DotDotDotToken]);
  end;

  // ensure that we are a close paren token
  AssumeToken([TSyntaxKind.CloseParenToken]);

  ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.SemicolonToken], True);
  if CurrentToken = TSyntaxKind.ColonToken then
    Result.&Type := ReadType;
end;




function TTranslator.ReadAmbientDeclaration: TAmbientDeclaration;
begin
  AssumeToken(TSyntaxKind.DeclareKeyword);

  Result := TAmbientDeclaration.Create(Self as IDeclarationOwner);

  ReadToken([
    TSyntaxKind.VarKeyword,
    TSyntaxKind.LetKeyword,
    TSyntaxKind.ConstKeyword,
    TSyntaxKind.FunctionKeyword,
    TSyntaxKind.ClassKeyword,
    TSyntaxKind.EnumKeyword,
    TSyntaxKind.ModuleKeyword,
    TSyntaxKind.NamespaceKeyword
    ], True);

  case CurrentToken of
    TSyntaxKind.VarKeyword,
    TSyntaxKind.LetKeyword,
    TSyntaxKind.ConstKeyword:
      Result.Variables.Add(ReadAmbientVariableDeclaration);

    TSyntaxKind.FunctionKeyword:
      Result.Functions.Add(ReadAmbientFunctionDeclaration);
    TSyntaxKind.ClassKeyword:
      Result.Classes.Add(ReadAmbientClassDeclaration);
    TSyntaxKind.EnumKeyword:
      Result.Enums.Add(ReadAmbientEnumDeclaration);
    TSyntaxKind.ModuleKeyword:
      Result.Modules.Add(ReadAmbientModuleDeclaration);
    TSyntaxKind.NamespaceKeyword:
      Result.Namespaces.Add(ReadAmbientNamespaceDeclaration);



(*
    TSyntaxKind.NamespaceKeyword:
      begin
        ReadIdentifier;
      end;
    TSyntaxKind.FunctionKeyword:
      Result.Functions.Add(ReadFunctionDeclaration);
    TSyntaxKind.ModuleKeyword:
      Result.Modules.Add(ReadModuleDeclaration);
    TSyntaxKind.InterfaceKeyword:
      Result.Interfaces.Add(ReadInterfaceDeclaration);
    TSyntaxKind.ClassKeyword:
      Result.Classes.Add(ReadClassDeclaration);
    TSyntaxKind.EnumKeyword:
      ReadEnumerationDeclaration;
*)
  end;
end;

function TTranslator.ReadAmbientVariableDeclaration: TAmbientVariableDeclaration;
begin
  // assume we're at a var / let / const
  AssumeToken([TSyntaxKind.VarKeyword, TSyntaxKind.LetKeyword,
    TSyntaxKind.ConstKeyword]);

  // create the variable declaration
  Result := TAmbientVariableDeclaration.Create(Self as IDeclarationOwner);

  Result.IsConst := CurrentToken = TSyntaxKind.ConstKeyword;

  ReadIdentifier(True);
  ReadAmbientBindingList(Result.AmbientBindingList);
end;

procedure TTranslator.ReadAmbientBindingList(const AmbientBindingList: array of TAmbientBinding);
begin
  repeat
    AmbientBindingList.Add(ReadAmbientBinding);

    // check if we're already at the end of the binding (otherwise break)
    if CurrentToken = TSyntaxKind.SemicolonToken then
      break;

    // check if more bindings are about to follow (otherwise break)
    if CurrentToken <> TSyntaxKind.CommaToken then
      break;

    // try reading identifier
    if not ReadIdentifier then
      break;
  until (CurrentToken = TSyntaxKind.SemicolonToken) or (not FScanner.isIdentifier)
    or (not NeedsSemicolon and not FScanner.isIdentifier);
end;

function TTranslator.ReadAmbientBinding: TAmbientBinding;
begin
  // assume we're at an identifier
  AssumeIdentifier;

  Result := TAmbientBinding.Create(Self as IDeclarationOwner);
  Result.Name := CurrentTokenText;

  // eventually read type
  if ReadToken(TSyntaxKind.ColonToken) then
    Result.&Type := ReadTypeAnnotation;

  // assume we're at a semicolon or comma
  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadAmbientFunctionDeclaration: TAmbientFunctionDeclaration;
begin
  // assume we're at a function
  AssumeToken(TSyntaxKind.FunctionKeyword);

  // create a function
  Result := TAmbientFunctionDeclaration.Create(Self as IDeclarationOwner);

  // read function name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  // now read
  Result.CallSignature := ReadCallSignature;

  // assume we're at a semicolon
  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken]);
end;

function TTranslator.ReadAmbientClassMember: TCustomTypeMember;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken,
    TSyntaxKind.StringLiteral, TSyntaxKind.ExportKeyword]);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Result := ReadCallbackInterface
  else
  begin
    // create a interface member
    var MemberName := FScanner.getTokenValue;

    ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.QuestionToken,
      TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

    if CurrentToken = TSyntaxKind.LessThanToken then
    begin
      ReadTypeParameter;

      ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
        TSyntaxKind.OpenParenToken], True);
    end;

    // check if type is nullable
    var Nullable := CurrentToken = TSyntaxKind.QuestionToken;
    if Nullable then
      ReadToken(TSyntaxKind.ColonToken, True);

    case CurrentToken of
      TSyntaxKind.ColonToken:
        begin
          Result := ReadFieldDeclaration;
          TFieldDeclaration(Result).Nullable := Nullable;
        end;
      TSyntaxKind.OpenParenToken:
        begin
          if LowerCase(MemberName) = 'constructor' then
            Result := ReadConstructorDeclaration
          else
            Result := ReadMethodDeclaration;
        end;
    end;

    Result.Name := MemberName;
  end;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken,
      TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadAmbientClassDeclaration: TAmbientClassDeclaration;
var
  ClassElementTokens: array of TSyntaxKind = [TSyntaxKind.NewKeyword,
    TSyntaxKind.StringLiteral, TSyntaxKind.ExportKeyword,
    TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken];
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TAmbientClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  {$IFDEF DEBUG} Console.Log('Read class: ' + Result.Name); {$ENDIF}

  ReadToken([TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword,
    TSyntaxKind.OpenBraceToken], True);

  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    ReadIdentifier(True);
    Result.Extends.Add(ReadTypeReference);
  end;

  if CurrentToken = TSyntaxKind.ImplementsKeyword then
  begin
    ReadIdentifier(True);
    Result.Implements.Add(ReadIdentifierPath);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      Result.Implements.Add(ReadIdentifierPath);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadIdentifier(ClassElementTokens);
  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    var Visibility := vPublic;
    case CurrentToken of
      TSyntaxKind.PublicKeyword:
        begin
          Visibility := vPublic;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
      TSyntaxKind.ProtectedKeyword:
        begin
          Visibility := vProtected;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
      TSyntaxKind.PrivateKeyword:
        begin
          Visibility := vPrivate;
          ReadIdentifier([TSyntaxKind.NewKeyword], True);
        end;
    end;

    var IsStatic := (CurrentToken = TSyntaxKind.StaticKeyword);
    if IsStatic then
      ReadIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken], True);

    var Member := ReadAmbientClassMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Result.Members.Add(Member);

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadIdentifier(ClassElementTokens);
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadAmbientNamespaceDeclaration: TNamespaceDeclaration;
begin

end;

function TTranslator.ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
var
  ModuleTokens: array of TSyntaxKind = [TSyntaxKind.ExportKeyword,
    TSyntaxKind.VarKeyword, TSyntaxKind.LetKeyword, TSyntaxKind.ConstKeyword,
    TSyntaxKind.TypeKeyword, TSyntaxKind.FunctionKeyword,
    TSyntaxKind.ClassKeyword, TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ModuleKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.CloseBraceToken,
    TSyntaxKind.SemicolonToken];
begin
  // assume we're at a module
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TAmbientModuleDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier([TSyntaxKind.StringLiteral], True);
  Result.IdentifierPath := ReadIdentifierPath;

  {$IFDEF DEBUG} Console.Log('Read ambient module: ' + Result.IdentifierPath); {$ENDIF}

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // read token
  ReadToken(ModuleTokens, True);

  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    var IsExport := CurrentToken = TSyntaxKind.ExportKeyword;
    if IsExport then
    begin
      ReadToken(ModuleTokens + [TSyntaxKind.DefaultKeyword,
        TSyntaxKind.EqualsToken], True);

      if CurrentToken = TSyntaxKind.DefaultKeyword then
      begin
        // handle this directly
        IsExport := False;
        ReadIdentifier;

        ReadToken(TSyntaxKind.SemicolonToken);

        ReadToken(ModuleTokens, True);
      end;

      if CurrentToken = TSyntaxKind.EqualsToken then
      begin
        // handle this directly
        IsExport := False;
        ReadIdentifier;

        ReadToken(TSyntaxKind.SemicolonToken);

        ReadToken(ModuleTokens, True);
      end;
    end;

    case CurrentToken of
      TSyntaxKind.VarKeyword, TSyntaxKind.LetKeyword:
        Result.Variables.Add(ReadAmbientVariableDeclaration);
      TSyntaxKind.ConstKeyword:
        begin
          ReadIdentifier([TSyntaxKind.EnumKeyword]);
          if CurrentToken = TSyntaxKind.EnumKeyword then
            Result.Enums.Add(ReadAmbientEnumDeclaration)
          else
          begin
            // create the variable declaration
            var Variable := TAmbientVariableDeclaration.Create(Self as IDeclarationOwner);
            Variable.IsConst := True;

            ReadAmbientBindingList(Variable.AmbientBindingList);

            Result.Variables.Add(Variable);
          end;
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.TypeKeyword:
        begin
          Result.TypeAliases.Add(ReadTypeAliasDeclaration);
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadAmbientFunctionDeclaration);
      TSyntaxKind.ClassKeyword:
        begin
          Result.Classes.Add(ReadAmbientClassDeclaration);
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.ModuleKeyword:
        begin
          Result.Modules.Add(ReadAmbientModuleDeclaration);
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.InterfaceKeyword:
        begin
          Result.Interfaces.Add(ReadInterfaceDeclaration);
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.ImportKeyword:
        begin
          ReadImportDeclaration;
          if not NeedsSemicolon then
            ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.EnumKeyword:
        begin
          ReadEnumerationDeclaration;
          ReadToken(ModuleTokens, True);
        end;
    end;

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadToken(ModuleTokens, True);
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadAmbientEnumDeclaration: TEnumerationDeclaration;
begin
  Result := ReadEnumerationDeclaration;
end;







procedure TTranslator.HandleScanError(Expected: TSyntaxKind = TSyntaxKind.Unknown);
begin
  var LineChar := TypeScriptExport.getLineAndCharacterOfPosition(
    FSourceFile, FScanner.getTokenPos);

  var Text := Format('Unknown token "%s" in this context (%d:%d)',
    [CurrentTokenText, LineChar.line + 1, LineChar.character + 1]);

  if Expected > TSyntaxKind.Unknown then
    Text += Format('; Expected (%d)', [Expected]);

  Console.Trace('');

  raise Exception.Create(Text);
end;

function TTranslator.BuildPascalHeader: String;
begin
  Result := 'unit ' + Name + ';' + CRLF + CRLF;
  Result += 'interface' + CRLF + CRLF;

  for var Import in FImports do
    Result := Result + Import.AsCode;

  for var Module in FModules do
    Result := Result + Module.AsCode;

  for var &Interface in FInterfaces do
    Result := Result + &Interface.AsCode;

  for var Declaration in FDeclarations do
    Result := Result + Declaration.AsCode;
end;

function TTranslator.Translate(Source: String): String;
begin
  FScanner := TypeScriptExport.createScanner(TScriptTarget.ES3, True,
    TLanguageVariant.Standard, Source);

  FSourceFile := TypeScriptExport.createSourceFile('main', Source,
    TScriptTarget.ES3);

  try
    ReadDefinition;
  except
    on e: Exception do
    begin
      Console.Error(E.Message);
    end;
  end;

  Result := BuildPascalHeader;
end;

end.