unit ts2pas.Translator;

interface

uses
  TypeScript, ts2pas.Expressions;

type
  TTranslator = class(IDeclarationOwner)
  private
    FScanner: JScanner;

    FDeclarations: array of TAmbientDeclaration;
    FModules: array of TModuleDeclaration;
    FInterfaces: array of TInterfaceDeclaration;

    function ReadAmbientDeclaration: TAmbientDeclaration;
    function ReadEnumerationItem: TEnumerationItem;
    function ReadEnumerationDeclaration: TEnumerationDeclaration;
    function ReadObjectType: TObjectType;
    function ReadExportDeclaration: TExportDeclaration;
    function ReadCallbackInterface: TCallbackDeclaration;
    function ReadFieldDeclaration: TFieldDeclaration;
    function ReadConstructorDeclaration: TConstructorDeclaration;
    function ReadMethodDeclaration: TMethodDeclaration;
    function ReadFunctionParameter: TFunctionParameter;
    function ReadFunctionType: TFunctionType;
    function ReadFunctionDeclaration: TFunctionDeclaration;
    function ReadImportDeclaration: TImportDeclaration;
    function ReadInterfaceMember: TCustomStructureMember;
    function ReadInterfaceDeclaration: TInterfaceDeclaration;
    function ReadClassMember: TCustomStructureMember;
    function ReadClassDeclaration: TClassDeclaration;
    function ReadModuleDeclaration: TModuleDeclaration;
    function ReadIdentifierPath: String;
    function ReadType: TCustomType;
    function ReadVariableDeclaration: TVariableDeclaration;


    function ReadParameter: TParameter;
    function ReadTypeAnnotation: TCustomType;
    function ReadCallSignature: TCallSignature;

    function ReadAmbientVariableDeclaration: TAmbientVariableDeclaration;
    function ReadAmbientBinding: TAmbientBinding;

    function ReadAmbientFunctionDeclaration: TAmbientFunctionDeclaration;

    function ReadAmbientClassDeclaration: TAmbientClassDeclaration;
    function ReadAmbientEnumDeclaration: TEnumDeclaration;
    function ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
    function ReadAmbientNamespaceDeclaration: TNamespaceDeclaration;



    procedure HandleScanError;

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
  end;

implementation

uses
  NodeJS.Core;


{ TTranslator }

constructor TTranslator.Create;
begin

end;

procedure TTranslator.AssumeIdentifier(AdditionalToken: array of TSyntaxKind = []);
begin
  if not (FScanner.isIdentifier or (CurrentToken in AdditionalToken)) then
    HandleScanError;
end;

procedure TTranslator.AssumeToken(Token: TSyntaxKind);
begin
  if CurrentToken <> Token then
    HandleScanError;
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

function TTranslator.ReadIdentifier(AdditionalToken: array of TSyntaxKind; Required: Boolean = False): Boolean;
begin
  ReadToken;
  Result := FScanner.isIdentifier or (CurrentToken in AdditionalToken);
  if not Result and Required then
    HandleScanError;
end;

procedure TTranslator.ReadDefinition;
begin
  while ReadToken > TSyntaxKind.Unknown do
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
        ReadImportDeclaration;
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

function TTranslator.ReadObjectType: TObjectType;
begin
  // sanity check
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // create an object type
  Result := TObjectType.Create(Self as IDeclarationOwner);

  // skip for now
  while FScanner.Scan <> TSyntaxKind.CloseBraceToken do;
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

function TTranslator.ReadType: TCustomType;
begin
  // read type
  ReadToken([TSyntaxKind.Identifier, TSyntaxKind.AnyKeyword,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.NumberKeyword,
    TSyntaxKind.StringKeyword, TSyntaxKind.BooleanKeyword,
    TSyntaxKind.VoidKeyword, TSyntaxKind.OpenParenToken], True);
  case CurrentToken of
    TSyntaxKind.Identifier:
      Result := TNamedType.Create(Self as IDeclarationOwner, ReadIdentifierPath);
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

  if CurrentToken = TSyntaxKind.OpenBracketToken then
  begin
    Result.IsArray := True;
    ReadToken(TSyntaxKind.CloseBracketToken, True);
    ReadToken;
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
  Result.Type.Add(ReadType);

  while CurrentToken = TSyntaxKind.BarToken do
  begin
    ReadToken(TSyntaxKind.OpenParenToken, True);
    Result.Type.Add(ReadType);
    AssumeToken(TSyntaxKind.CloseParenToken);
    ReadToken;
  end;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken,
    TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadConstructorDeclaration: TConstructorDeclaration;
begin
  Result := TConstructorDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadMethodDeclaration: TMethodDeclaration;
begin
  Result := TMethodDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadClassMember: TCustomStructureMember;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken,
    TSyntaxKind.StringLiteral]);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Result := ReadCallbackInterface
  else
  begin
    // create a interface member
    var MemberName := CurrentTokenText;

    ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

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

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken,
    TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadClassDeclaration: TClassDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  Console.Log('Read class: ' + Result.Name);

  ReadToken;
  while CurrentToken in [TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword] do
  begin
    var List := if CurrentToken = TSyntaxKind.ExtendsKeyword then
      Result.Extends else Result.Implements;

    ReadIdentifier(True);
    List.Add(ReadIdentifierPath);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      List.Add(ReadIdentifierPath);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.StringLiteral]) do
  begin
    var Visibility := vPublic;
    case FScanner.getToken of
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

    var Member := ReadClassMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Result.Members.Add(Member);
  end;
end;

function TTranslator.ReadInterfaceMember: TCustomStructureMember;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken]);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Result := ReadCallbackInterface
  else
  begin
    // create a interface member
    var MemberName := CurrentTokenText;

    ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

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
        Result := ReadMethodDeclaration;
    end;

    Result.Name := MemberName;
  end;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken,
    TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadInterfaceDeclaration: TInterfaceDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.InterfaceKeyword);

  // create a interface
  Result := TInterfaceDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  Console.Log('Read interface: ' + Result.Name);

  ReadToken;
  while CurrentToken in [TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword] do
  begin
    var List := if CurrentToken = TSyntaxKind.ExtendsKeyword then
      Result.Extends else Result.Implements;

    ReadIdentifier(True);
    List.Add(ReadIdentifierPath);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      List.Add(ReadIdentifierPath);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.OpenParenToken]) do
  begin
    Result.Members.Add(ReadInterfaceMember);

    // check if we're already at the close brace
    if CurrentToken = TSyntaxKind.CloseBraceToken then
      Break;
  end;

  // ensure the current token is a close brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadModuleDeclaration: TModuleDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TModuleDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier([TSyntaxKind.StringLiteral], True);
  Result.Name := ReadIdentifierPath;

  Console.Log('Read module: ' + Result.Name);

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadToken([TSyntaxKind.ClassKeyword, TSyntaxKind.ExportKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.ModuleKeyword, TSyntaxKind.FunctionKeyword,
    TSyntaxKind.InterfaceKeyword, TSyntaxKind.VarKeyword]) do
  begin
    case CurrentToken of
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadClassDeclaration);
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
      else
        HandleScanError;
    end;
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

  ReadIdentifier(True);

  ReadToken(TSyntaxKind.EqualsToken, True);

  ReadIdentifier(True);

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




function TTranslator.ReadParameter: TParameter;
begin
  // check we're a parameter (either required, optional or rest)
  AssumeIdentifier([TSyntaxKind.PublicKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword, TSyntaxKind.DotDotDotToken]);

  // create parameter
  Result := TParameter.Create;

  Result.IsRest := CurrentToken = TSyntaxKind.DotDotDotToken;
  if Result.IsRest then
  begin
    // handle rest parameter
    ReadIdentifier(True);

    Result.BindingIdentifier := CurrentTokenText;

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

function TTranslator.ReadCallSignature: TCallSignature;
begin
  ReadIdentifier([TSyntaxKind.OpenParenToken]);

  // create call signature
  Result := TCallSignature.Create(Self as IDeclarationOwner);

  if CurrentToken <> TSyntaxKind.OpenParenToken then
  begin
    // read optional TypeParameters here
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

  repeat
    Result.AmbientBindingList.Add(ReadAmbientBinding);
  until CurrentToken = TSyntaxKind.SemicolonToken;

end;

function TTranslator.ReadAmbientBinding: TAmbientBinding;
begin
  // read identifier
  ReadIdentifier(True);

  Result := TAmbientBinding.Create(Self as IDeclarationOwner);
  Result.BindingIdentifier := CurrentTokenText;

  // eventually read type
  if ReadToken(TSyntaxKind.ColonToken) then
    Result.&Type := ReadTypeAnnotation;

  // assume we're at a semicolon or comma
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
  Result.BindingIdentifier := CurrentTokenText;

  // now read
  Result.CallSignature := ReadCallSignature;

  // assume we're at a semicolon
  AssumeToken([TSyntaxKind.SemicolonToken]);
end;

function TTranslator.ReadAmbientClassDeclaration: TAmbientClassDeclaration;
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TAmbientClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  Console.Log('Read class: ' + Result.Name);

  ReadToken;
  while CurrentToken in [TSyntaxKind.ExtendsKeyword, TSyntaxKind.ImplementsKeyword] do
  begin
    var List := if CurrentToken = TSyntaxKind.ExtendsKeyword then
      Result.Extends else Result.Implements;

    ReadIdentifier(True);
    List.Add(ReadIdentifierPath);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      List.Add(ReadIdentifierPath);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.StringLiteral]) do
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

    var Member := ReadClassMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Result.Members.Add(Member);
  end;
end;

function TTranslator.ReadAmbientNamespaceDeclaration: TNamespaceDeclaration;
begin

end;

function TTranslator.ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
var
  IsExport: Boolean;
begin
  // assume we're at a module
  AssumeToken(TSyntaxKind.ModuleKeyword);

  // create a module
  Result := TAmbientModuleDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier([TSyntaxKind.StringLiteral], True);
  Result.IdentifierPath := ReadIdentifierPath;

  Console.Log('Read module: ' + Result.IdentifierPath);

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  while ReadToken([
    TSyntaxKind.ExportKeyword,
    TSyntaxKind.VarKeyword,
    TSyntaxKind.FunctionKeyword,
    TSyntaxKind.ClassKeyword,
    TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.EnumKeyword,
    TSyntaxKind.ModuleKeyword,
    TSyntaxKind.ImportKeyword]) do
  begin
    case CurrentToken of
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadAmbientVariableDeclaration);
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadAmbientFunctionDeclaration);
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadAmbientClassDeclaration);
      TSyntaxKind.ExportKeyword:
        IsExport := True;
      TSyntaxKind.ModuleKeyword:
        Result.Modules.Add(ReadAmbientModuleDeclaration);
      TSyntaxKind.InterfaceKeyword:
        Result.Interfaces.Add(ReadInterfaceDeclaration);
(*
      TSyntaxKind.EnumKeyword:
        ReadEnumerationDeclaration;
      TSyntaxKind.ImportKeyword:
        ReadImportDeclaration;
*)
      else
        HandleScanError;

      if CurrentToken <> TSyntaxKind.ExportKeyword then
      begin

        IsExport := False;
      end;
    end;



  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadAmbientEnumDeclaration: TEnumDeclaration;
begin

end;







procedure TTranslator.HandleScanError;
begin

  raise Exception.Create(Format('Unknown token "%s" in this context. At pos %d',
    [CurrentTokenText, FScanner.getTokenPos]));
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