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
    function ReadConstructorDeclaration: TConstructorDeclaration;
    function ReadPropertyMemberDeclaration: TPropertyMemberDeclaration;
    function ReadIndexMemberDeclaration: TIndexMemberDeclaration;
    function ReadMethodDeclaration: TMethodDeclaration;
    function ReadFunctionParameter: TFunctionParameter;
    function ReadFunctionType: TFunctionType;
    function ReadConstructorType: TConstructorType;
    function ReadFunctionDeclaration: TFunctionDeclaration;
    function ReadImportDeclaration: TImportDeclaration;
    function ReadInterfaceDeclaration: TInterfaceDeclaration;
    function ReadClassMember: TCustomTypeMember;
    procedure ReadClassMembers(const Declaration: TClassDeclaration);
    function ReadClassDeclaration: TClassDeclaration;
    function ReadNamespaceDeclaration: TNamespaceDeclaration;
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
    function ReadTupleType: TTupleType;
    function ReadConstructorSignature: TConstructorDeclaration;
    function ReadIndexSignature: TIndexSignature;

    function ReadAmbientVariableDeclaration: TAmbientVariableDeclaration;
    procedure ReadAmbientBindingList(const AmbientBindingList: array of TAmbientBinding);
    function ReadAmbientBinding: TAmbientBinding;

    function ReadAmbientFunctionDeclaration: TAmbientFunctionDeclaration;
    function ReadAmbientClassDeclaration: TAmbientClassDeclaration;
    function ReadAmbientClassBodyElement: TAmbientBodyElement;
    function ReadAmbientConstructorDeclaration: TAmbientConstructorDeclaration;
    function ReadAmbientPropertyMemberDeclarationProperty: TAmbientPropertyMemberDeclarationProperty;
    function ReadAmbientPropertyMemberDeclarationMethod: TAmbientPropertyMemberDeclarationMethod;
    function ReadAmbientPropertyMemberDeclaration: TAmbientPropertyMemberDeclaration;
    function ReadAmbientEnumDeclaration: TEnumerationDeclaration;
    function ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
    function ReadAmbientNamespaceDeclaration: TAmbientNamespaceDeclaration;


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
    property UnitOutputName: String;
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

function TTranslator.ReadEnumerationItem: TEnumerationItem;
var
  IgnoreKeywords: array of TSyntaxKind = [TSyntaxKind.EnumKeyword,
    TSyntaxKind.DefaultKeyword, TSyntaxKind.DeleteKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.SwitchKeyword];
begin
  // ensure we are at an identifier
  AssumeIdentifier(IgnoreKeywords);

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

  AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadEnumerationDeclaration: TEnumerationDeclaration;
var
  IgnoreKeywords: array of TSyntaxKind = [TSyntaxKind.EnumKeyword,
    TSyntaxKind.DefaultKeyword, TSyntaxKind.DeleteKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.SwitchKeyword];
begin
  // ensure we are at an enum token
  AssumeToken(TSyntaxKind.EnumKeyword);

  // create an enumeration
  Result := TEnumerationDeclaration.Create(Self as IDeclarationOwner);

  // read name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  // read open brace
  ReadToken(TSyntaxKind.OpenBraceToken, True);

  // read enumeration items
  ReadIdentifier([TSyntaxKind.CloseBraceToken] + IgnoreKeywords, True);
  if CurrentToken <> TSyntaxKind.CloseBraceToken then
    repeat
      Result.Items.Add(ReadEnumerationItem);
      if CurrentToken = TSyntaxKind.CloseBraceToken then
        break;
    until not ReadIdentifier(IgnoreKeywords);

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
  ReadToken([TSyntaxKind.OpenParenToken{, TSyntaxKind.LessThanToken}], True);

(*
  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      {TypeParameters.Add(}ReadTypeParameter{);}
    until CurrentToken <> TSyntaxKind.CommaToken;

    ReadToken([TSyntaxKind.OpenParenToken], True);
  end;
*)

  Result.&Type := ReadFunctionType;
end;

function TTranslator.ReadFunctionType: TFunctionType;
begin
  // sanity check
  AssumeToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken]);

  Result := TFunctionType.Create(Self as IDeclarationOwner);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

    ReadToken(TSyntaxKind.OpenParenToken, True);
  end;

  while ReadIdentifier([TSyntaxKind.DotDotDotToken]) do
  begin
    Result.ParameterList.Add(ReadFunctionParameter);

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
    Result.ParameterList.Add(ReadFunctionParameter);

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
  ParameterTokens: array of TSyntaxKind = [TSyntaxKind.QuestionToken,
    TSyntaxKind.CommaToken, TSyntaxKind.ColonToken,
    TSyntaxKind.CloseParenToken];
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.DotDotDotToken]);

  OpenArray := CurrentToken = TSyntaxKind.DotDotDotToken;
  if OpenArray then
    ReadIdentifier(True);

  Result := TFunctionParameter.Create(Self as IDeclarationOwner);
  Result.Name := CurrentTokenText;

  // either accept ? or : or )
  ReadToken(ParameterTokens, True);

  // check if type is nullable
  Result.IsOptional := CurrentToken = TSyntaxKind.QuestionToken;
  ParameterTokens -= [TSyntaxKind.QuestionToken];
  if Result.IsOptional then
    ReadToken(ParameterTokens, True);

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
    TSyntaxKind.TypeOfKeyword, TSyntaxKind.ThisKeyword,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.OpenParenToken,
    TSyntaxKind.OpenBracketToken, TSyntaxKind.ObjectKeyword,
    TSyntaxKind.NullKeyword];
begin
  // read type
  AssumeToken(PrimaryTypeTokens);

  case CurrentToken of
    TSyntaxKind.OpenParenToken:
      begin
        Result := ReadType;
        AssumeToken(TSyntaxKind.CloseParenToken);
        ReadToken;
      end;
    TSyntaxKind.Identifier, TSyntaxKind.ThisKeyword:
      begin
        Result := TNamedType.Create(Self as IDeclarationOwner, ReadIdentifierPath);
        if CurrentToken = TSyntaxKind.LessThanToken then
        begin
          repeat
            TNamedType(Result).Arguments.Add(ReadTypeArgument)
          until CurrentToken <> TSyntaxKind.CommaToken;
          AssumeToken(TSyntaxKind.GreaterThanToken);

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
    TSyntaxKind.OpenBracketToken:
      begin
        Result := ReadTupleType;
        ReadToken;
      end;
    TSyntaxKind.ObjectKeyword:
      begin
        Result := TJSObject.Create(Self as IDeclarationOwner);
        ReadToken;
      end;
    TSyntaxKind.NullKeyword:
      begin
        Result := TNullType.Create(Self as IDeclarationOwner);
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
    TSyntaxKind.TypeOfKeyword, TSyntaxKind.ThisKeyword,
    TSyntaxKind.NewKeyword, TSyntaxKind.LessThanToken,
    TSyntaxKind.OpenBraceToken, TSyntaxKind.OpenParenToken,
    TSyntaxKind.OpenBracketToken, TSyntaxKind.ObjectKeyword,
    TSyntaxKind.NullKeyword];
begin
  // store text position
  var TextPos := FScanner.TextPos;

  // read type
  ReadToken(TypeTokens, True);

  if CurrentToken = TSyntaxKind.OpenParenToken then
  begin
    var IsFunctionType := True;

    ReadIdentifier(TypeTokens + [TSyntaxKind.PublicKeyword,
      TSyntaxKind.ProtectedKeyword, TSyntaxKind.PrivateKeyword,
      TSyntaxKind.CloseParenToken, TSyntaxKind.DotDotDotToken], True);

    // check for accessibility modifiers
    if not (CurrentToken in [TSyntaxKind.PublicKeyword,
      TSyntaxKind.ProtectedKeyword, TSyntaxKind.PrivateKeyword,
      TSyntaxKind.CloseParenToken, TSyntaxKind.DotDotDotToken]) then
    begin
      // identifers require further scanning
      if FScanner.isIdentifier then
      begin
        ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.BarToken,
          TSyntaxKind.ColonToken, TSyntaxKind.CommaToken,
          TSyntaxKind.QuestionToken, TSyntaxKind.DotToken,
          TSyntaxKind.OpenBracketToken, TSyntaxKind.CloseParenToken], True);
        IsFunctionType := CurrentToken in [TSyntaxKind.ColonToken,
          TSyntaxKind.QuestionToken, TSyntaxKind.CommaToken,
          TSyntaxKind.CloseParenToken];
      end else
        IsFunctionType := not (CurrentToken in [TSyntaxKind.OpenParenToken]);
    end;

    // reset text position
    FScanner.TextPos := TextPos;

    // read type
    ReadToken(TypeTokens, True);

    //Console.Log('Assume ' + (if IsFunctionType then 'function' else 'primary') + ' type');

    if IsFunctionType then
      Exit(ReadFunctionType);
  end;

  if CurrentToken = TSyntaxKind.LessThanToken then
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

(*
function TTranslator.ReadCallbackInterface: TCallbackDeclaration;
begin
  AssumeToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken]);

  Result := TCallbackDeclaration.Create(Self as IDeclarationOwner);
  Result.Type := ReadFunctionType;

  AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;
*)

function TTranslator.ReadIndexMemberDeclaration: TIndexMemberDeclaration;
begin
  AssumeToken(TSyntaxKind.OpenBracketToken);

  Result := TIndexMemberDeclaration.Create(Self as IDeclarationOwner);
  Result.IndexSignature := ReadIndexSignature;

  if NeedsSemicolon then
    AssumeIdentifier([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken,
      TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadPropertyMemberDeclaration: TPropertyMemberDeclaration;
begin
  AssumeToken([TSyntaxKind.ColonToken, TSyntaxKind.SemicolonToken]);

  Result := TPropertyMemberDeclaration.Create(Self as IDeclarationOwner);

  // check if we're eventually already at a semicolon (no type provided)
  if CurrentToken = TSyntaxKind.SemicolonToken then
    Exit;

  // read type
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
  Result.CallSignature := ReadCallSignature;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadClassMember: TCustomTypeMember;
var
  TypeParameters: array of TTypeParameter;
  IgnoredKeywords: array of TSyntaxKind = [
    TSyntaxKind.CatchKeyword, TSyntaxKind.ContinueKeyword,
    TSyntaxKind.DebuggerKeyword, TSyntaxKind.DefaultKeyword,
    TSyntaxKind.DeleteKeyword, TSyntaxKind.ExportKeyword,
    TSyntaxKind.FinallyKeyword, TSyntaxKind.IfKeyword,
    TSyntaxKind.WithKeyword];
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.NewKeyword, TSyntaxKind.StringLiteral,
    TSyntaxKind.OpenBracketToken] + IgnoredKeywords);

  if CurrentToken = TSyntaxKind.OpenBracketToken then
    Exit(ReadIndexMemberDeclaration);

  // create a interface member
  var MemberName := CurrentTokenText;

  ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.QuestionToken,
    TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken,
    TSyntaxKind.SemicolonToken], True);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

    ReadToken([TSyntaxKind.QuestionToken, TSyntaxKind.ColonToken,
      TSyntaxKind.OpenParenToken, TSyntaxKind.SemicolonToken], True);
  end;

  // check if type is nullable
  var Nullable := CurrentToken = TSyntaxKind.QuestionToken;
  if Nullable then
    ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.SemicolonToken], True);

  case CurrentToken of
    TSyntaxKind.ColonToken, TSyntaxKind.SemicolonToken:
      begin
        Result := ReadPropertyMemberDeclaration;
        TPropertyMemberDeclaration(Result).Nullable := Nullable;
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
  Result.TypeParameters := TypeParameters;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken,
      TSyntaxKind.CloseBraceToken]);
end;

procedure TTranslator.ReadClassMembers(const Declaration: TClassDeclaration);
var
  ClassElementTokens: array of TSyntaxKind = [TSyntaxKind.NewKeyword,
    TSyntaxKind.StringLiteral, TSyntaxKind.ExportKeyword,
    TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken,
    TSyntaxKind.OpenBracketToken];
begin
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

    var Member := ReadClassMember;
    Member.Visibility := Visibility;
    Member.IsStatic := IsStatic;

    Declaration.Members.Add(Member);

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadIdentifier(ClassElementTokens);
  end;
end;

function TTranslator.ReadClassDeclaration: TClassDeclaration;
var
  ClassDeclarationTokens: array of TSyntaxKind = [TSyntaxKind.ExtendsKeyword,
    TSyntaxKind.ImplementsKeyword, TSyntaxKind.OpenBraceToken,
    TSyntaxKind.LessThanToken];
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  {$IFDEF DEBUG} Console.Log('Read class: ' + Result.Name); {$ENDIF}

  ReadToken(ClassDeclarationTokens, True);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ClassDeclarationTokens -= TSyntaxKind.LessThanToken;
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

    AssumeToken(TSyntaxKind.GreaterThanToken);
    ReadToken(ClassDeclarationTokens, True);
  end;

  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    ReadIdentifier(True);
    Result.Extends.Add(ReadTypeReference);
  end;

  if CurrentToken = TSyntaxKind.ImplementsKeyword then
  begin
    ReadIdentifier(True);
    Result.Implements.Add(ReadTypeReference);
    while CurrentToken = TSyntaxKind.CommaToken do
    begin
      ReadIdentifier(True);
      Result.Implements.Add(ReadTypeReference);
    end;
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadClassMembers(Result);
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
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

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

function TTranslator.ReadNamespaceDeclaration: TNamespaceDeclaration;
var
  NamespaceTokens: array of TSyntaxKind = [TSyntaxKind.AbstractKeyword,
    TSyntaxKind.ClassKeyword, TSyntaxKind.DeclareKeyword,
    TSyntaxKind.ExportKeyword, TSyntaxKind.EnumKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.FunctionKeyword,
    TSyntaxKind.InterfaceKeyword, TSyntaxKind.SemicolonToken,
    TSyntaxKind.CloseBraceToken];
begin
  AssumeToken(TSyntaxKind.NamespaceKeyword);

  ReadIdentifier([TSyntaxKind.StringLiteral], True);

  Result := TNamespaceDeclaration.Create(Self as IDeclarationOwner);
  Result.Name := ReadIdentifierPath;

  {$IFDEF DEBUG} Console.Log('Read namespace: ' + Result.Name); {$ENDIF}

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadToken(NamespaceTokens, True);
  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    var IsAbstract := CurrentToken = TSyntaxKind.AbstractKeyword;
    if IsAbstract then
      ReadToken([TSyntaxKind.ClassKeyword], True);

    case CurrentToken of
      TSyntaxKind.ClassKeyword:
        begin
          var ClassDeclaration := ReadClassDeclaration;
          ClassDeclaration.IsAbstract := IsAbstract;
          Result.Classes.Add(ClassDeclaration);
        end;
      TSyntaxKind.EnumKeyword:
        ReadEnumerationDeclaration;
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadFunctionDeclaration);
      TSyntaxKind.ImportKeyword:
        ReadImportDeclaration;
      TSyntaxKind.InterfaceKeyword:
        Result.Interfaces.Add(ReadInterfaceDeclaration);
    end;

    ReadToken(NamespaceTokens, True)
  end;

  // ensure that the next token is an open brace
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
    end;

    ReadToken(ModuleTokens, True)
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadIdentifierPath: String;
begin
  AssumeIdentifier([TSyntaxKind.StringLiteral, TSyntaxKind.ThisKeyword]);
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

        ReadIdentifier([TSyntaxKind.RequireKeyword], True);
        if CurrentToken = TSyntaxKind.RequireKeyword then
        begin
          ReadToken(TSyntaxKind.OpenParenToken);
          ReadToken(TSyntaxKind.StringLiteral);
          ReadToken(TSyntaxKind.CloseParenToken);
        end
        else
          Result.Value := ReadIdentifierPath;
      end;
  end;

  if NeedsSemicolon then
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

  ReadToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken], True);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

    ReadToken([TSyntaxKind.OpenParenToken], True);
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

function TTranslator.ReadIndexSignature: TIndexSignature;
begin
  AssumeToken(TSyntaxKind.OpenBracketToken);

  // create index declaration
  Result := TIndexSignature.Create(Self as IDeclarationOwner);

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
  TypeArguments: array of TTypeArgument;
  TypeTokens: array of TSyntaxKind = [TSyntaxKind.StringLiteral,
    TSyntaxKind.NumericLiteral, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.NewKeyword, TSyntaxKind.LessThanToken,
    TSyntaxKind.OpenParenToken, TSyntaxKind.OpenBracketToken];
  IgnoredKeywords: array of TSyntaxKind = [
    TSyntaxKind.CatchKeyword, TSyntaxKind.ClassKeyword,
    TSyntaxKind.ContinueKeyword, TSyntaxKind.DebuggerKeyword,
    TSyntaxKind.DefaultKeyword, TSyntaxKind.DeleteKeyword,
    TSyntaxKind.ExportKeyword, TSyntaxKind.ExtendsKeyword,
    TSyntaxKind.FinallyKeyword, TSyntaxKind.ForKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.InKeyword,
    TSyntaxKind.ReturnKeyword, TSyntaxKind.ThisKeyword,
    TSyntaxKind.ThrowKeyword, TSyntaxKind.TryKeyword,
    TSyntaxKind.FunctionKeyword];
begin
  // store text position
  var TextPos := FScanner.TextPos;

  AssumeIdentifier(TypeTokens + IgnoredKeywords);

  if CurrentToken = TSyntaxKind.NewKeyword then
  begin
    var IsConstructorType := not ReadToken([TSyntaxKind.QuestionToken,
      TSyntaxKind.ColonToken]);

    // reset text position
    FScanner.TextPos := TextPos - 3;
    FScanner.Scan;

    if IsConstructorType then
      Exit(ReadConstructorSignature);
  end;

  if CurrentToken in [TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken] then
    Exit(ReadCallSignature);

  if CurrentToken = TSyntaxKind.OpenBracketToken then
    Exit(ReadIndexSignature);

  if FScanner.IsIdentifier or (FScanner.getToken in ([TSyntaxKind.StringLiteral,
    TSyntaxKind.NumericLiteral, TSyntaxKind.NewKeyword] + IgnoredKeywords)) then
  begin
    var MemberName := CurrentTokenText;

    ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.QuestionToken,
      TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken], True);

    // check if type is nullable
    var Nullable := CurrentToken = TSyntaxKind.QuestionToken;
    if Nullable then
      ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken,
        TSyntaxKind.LessThanToken], True);

    case CurrentToken of
      TSyntaxKind.ColonToken:
        begin
          Result := ReadPropertyMemberDeclaration;
          TPropertyMemberDeclaration(Result).Nullable := Nullable;
        end;
      TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken:
        Result := ReadMethodDeclaration;
    end;

    Result.TypeArguments := TypeArguments;
    Result.Name := MemberName;
  end;
end;

function TTranslator.ReadObjectType: TObjectType;
var
  ObjectTokens: array of TSyntaxKind = [TSyntaxKind.StringLiteral,
    TSyntaxKind.NumericLiteral, TSyntaxKind.NewKeyword,
    TSyntaxKind.LessThanToken, TSyntaxKind.OpenParenToken,
    TSyntaxKind.OpenBracketToken, TSyntaxKind.CloseBraceToken];
  IgnoredKeywords: array of TSyntaxKind = [
    TSyntaxKind.CatchKeyword, TSyntaxKind.ClassKeyword,
    TSyntaxKind.ContinueKeyword, TSyntaxKind.DebuggerKeyword,
    TSyntaxKind.DefaultKeyword, TSyntaxKind.DeleteKeyword,
    TSyntaxKind.ExportKeyword, TSyntaxKind.ExtendsKeyword,
    TSyntaxKind.FinallyKeyword, TSyntaxKind.ForKeyword,
    TSyntaxKind.ImportKeyword, TSyntaxKind.InKeyword,
    TSyntaxKind.ReturnKeyword, TSyntaxKind.ThisKeyword,
    TSyntaxKind.ThrowKeyword, TSyntaxKind.TryKeyword];
begin
  // assume we're at an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  // create an object type
  Result := TObjectType.Create(Self as IDeclarationOwner);

  ReadIdentifier(ObjectTokens + IgnoredKeywords, True);

  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    Result.Members.Add(ReadTypeMember);

    if CurrentToken in [TSyntaxKind.SemicolonToken, TSyntaxKind.CommaToken] then
      ReadIdentifier(ObjectTokens + IgnoredKeywords, True);
  end;

  // assume we're at a close brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadTupleType: TTupleType;
begin
  // assume we're at an open bracket
  AssumeToken(TSyntaxKind.OpenBracketToken);

  Result := TTupleType.Create(Self as IDeclarationOwner);

  repeat
    Result.Types.Add(ReadType);
  until CurrentToken = TSyntaxKind.CloseBracketToken;

  // assume we're at a close bracket
  AssumeToken(TSyntaxKind.CloseBracketToken);
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

  {$IFDEF DEBUG} Console.Log('Read type: ' + Result.Name); {$ENDIF}

  ReadToken([TSyntaxKind.LessThanToken, TSyntaxKind.EqualsToken], True);
  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    Result.TypeParameters.Add(ReadTypeParameter);

    ReadToken(TSyntaxKind.EqualsToken, True);
  end;

  Result.&Type := ReadType;

  if NeedsSemicolon then
    AssumeToken(TSyntaxKind.SemicolonToken);
end;

function TTranslator.ReadTypeParameter: TTypeParameter;
begin
  AssumeToken([TSyntaxKind.LessThanToken, TSyntaxKind.CommaToken]);

  Result := TTypeParameter.Create(Self as IDeclarationOwner);

  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  ReadToken([TSyntaxKind.ExtendsKeyword, TSyntaxKind.GreaterThanToken,
    TSyntaxKind.CommaToken], True);
  if CurrentToken = TSyntaxKind.ExtendsKeyword then
  begin
    Result.ExtendsType := ReadType;
    AssumeToken([TSyntaxKind.GreaterThanToken, TSyntaxKind.CommaToken]);
  end;
end;

function TTranslator.ReadTypeArgument: TTypeArgument;
begin
  AssumeToken([TSyntaxKind.LessThanToken, TSyntaxKind.CommaToken]);

  Result := TTypeArgument.Create(Self as IDeclarationOwner);

  Result.&Type := ReadType;
  AssumeToken([TSyntaxKind.GreaterThanToken, TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadTypeReference: TTypeReference;
begin
  AssumeIdentifier;

  Result := TTypeReference.Create(Self as IDeclarationOwner);
  Result.Name := ReadIdentifierPath;

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      Result.Arguments.Add(ReadTypeArgument);
    until (CurrentToken <> TSyntaxKind.CommaToken);

    ReadToken;
  end;
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

function TTranslator.ReadCallSignature: TCallSignature;
begin
  AssumeToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken]);

  // create call signature
  Result := TCallSignature.Create(Self as IDeclarationOwner);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;
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

function TTranslator.ReadAmbientFunctionDeclaration: TAmbientFunctionDeclaration;
begin
  // assume we're at a function
  AssumeToken(TSyntaxKind.FunctionKeyword);

  // create a function
  Result := TAmbientFunctionDeclaration.Create(Self as IDeclarationOwner);

  // read function name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  // read open paren or
  ReadToken([TSyntaxKind.OpenParenToken, TSyntaxKind.LessThanToken], True);

  // now read
  Result.CallSignature := ReadCallSignature;

  // assume we're at a semicolon
  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken]);
end;

function TTranslator.ReadAmbientConstructorDeclaration: TAmbientConstructorDeclaration;
begin
  // ensure we're at an open paren
  AssumeToken(TSyntaxKind.ConstructorKeyword);

  ReadToken(TSyntaxKind.OpenParenToken, True);

  Result := TAmbientConstructorDeclaration.Create(Self as IDeclarationOwner);
  while ReadIdentifier([TSyntaxKind.DotDotDotToken]) do
  begin
    Result.ParameterList.Add(ReadFunctionParameter);

    AssumeToken([TSyntaxKind.CommaToken, TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

    // eventually break if a close paren has been found
    if CurrentToken in [TSyntaxKind.CloseParenToken] then
      break;
  end;

  // ensure that we are a close paren token
  AssumeToken([TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken]);

  if CurrentToken <> TSyntaxKind.SemicolonToken then
    ReadToken(TSyntaxKind.SemicolonToken, True);
end;

function TTranslator.ReadAmbientPropertyMemberDeclarationProperty: TAmbientPropertyMemberDeclarationProperty;
begin
  Result := TAmbientPropertyMemberDeclarationProperty.Create(Self as IDeclarationOwner);

  if CurrentToken = TSyntaxKind.ColonToken then
    Result.Type := ReadType;
end;

function TTranslator.ReadAmbientPropertyMemberDeclarationMethod: TAmbientPropertyMemberDeclarationMethod;
begin
  AssumeToken(TSyntaxKind.OpenParenToken);

  Result := TAmbientPropertyMemberDeclarationMethod.Create(Self as IDeclarationOwner);
  Result.CallSignature := ReadCallSignature;

  // ensure that we are a close paren token
  AssumeToken([TSyntaxKind.CloseParenToken, TSyntaxKind.SemicolonToken,
    TSyntaxKind.PublicKeyword, TSyntaxKind.ProtectedKeyword,
    TSyntaxKind.PrivateKeyword]);

(*
  if CurrentToken <> TSyntaxKind.SemicolonToken then
    ReadToken(TSyntaxKind.SemicolonToken, True);
*)
end;

function TTranslator.ReadAmbientPropertyMemberDeclaration: TAmbientPropertyMemberDeclaration;
begin
  // ensure we're at an open paren
  AssumeIdentifier;

  var MemberName := CurrentTokenText;

  ReadToken([TSyntaxKind.ColonToken, TSyntaxKind.OpenParenToken,
    TSyntaxKind.SemicolonToken], True);

  if CurrentToken = TSyntaxKind.OpenParenToken then
    Result := ReadAmbientPropertyMemberDeclarationMethod
  else
    Result := ReadAmbientPropertyMemberDeclarationProperty;

  Result.Name := MemberName;

  if NeedsSemicolon then
    AssumeIdentifier([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken,
      TSyntaxKind.CommaToken]);
end;

function TTranslator.ReadAmbientClassBodyElement: TAmbientBodyElement;
begin
  // sanity check
  AssumeIdentifier([TSyntaxKind.ConstructorKeyword, TSyntaxKind.PrivateKeyword,
    TSyntaxKind.ProtectedKeyword, TSyntaxKind.PublicKeyword,
    TSyntaxKind.StaticKeyword]);

  if CurrentToken = TSyntaxKind.ConstructorKeyword then
    Exit(ReadAmbientConstructorDeclaration);

  var Visibility := vPublic;
  case CurrentToken of
    TSyntaxKind.PublicKeyword:
      begin
        Visibility := vPublic;
        ReadIdentifier([TSyntaxKind.StaticKeyword], True);
      end;
    TSyntaxKind.ProtectedKeyword:
      begin
        Visibility := vProtected;
        ReadIdentifier([TSyntaxKind.StaticKeyword], True);
      end;
    TSyntaxKind.PrivateKeyword:
      begin
        Visibility := vPrivate;
        ReadIdentifier([TSyntaxKind.StaticKeyword], True);
      end;
  end;

  var IsStatic := (CurrentToken = TSyntaxKind.StaticKeyword);
  if IsStatic then
    ReadIdentifier(True);

  Result := ReadAmbientPropertyMemberDeclaration;
  TAmbientPropertyMemberDeclaration(Result).IsStatic := IsStatic;
  TAmbientPropertyMemberDeclaration(Result).Visibility := Visibility;

  if NeedsSemicolon then
    AssumeToken([TSyntaxKind.SemicolonToken, TSyntaxKind.CloseBraceToken]);
end;

function TTranslator.ReadAmbientClassDeclaration: TAmbientClassDeclaration;
var
  ClassDeclarationTokens: array of TSyntaxKind = [TSyntaxKind.ExtendsKeyword,
    TSyntaxKind.ImplementsKeyword, TSyntaxKind.OpenBraceToken,
    TSyntaxKind.LessThanToken];
  ClassElementTokens: array of TSyntaxKind = [TSyntaxKind.ConstructorKeyword,
    TSyntaxKind.PrivateKeyword, TSyntaxKind.ProtectedKeyword,
    TSyntaxKind.PublicKeyword, TSyntaxKind.StaticKeyword,
    TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken];
begin
  // sanity check
  AssumeToken(TSyntaxKind.ClassKeyword);

  // create a interface
  Result := TAmbientClassDeclaration.Create(Self as IDeclarationOwner);

  // read interface name
  ReadIdentifier(True);
  Result.Name := CurrentTokenText;

  {$IFDEF DEBUG} Console.Log('Read ambient class: ' + Result.Name); {$ENDIF}

  ReadToken(ClassDeclarationTokens, True);

  if CurrentToken = TSyntaxKind.LessThanToken then
  begin
    ClassDeclarationTokens -= TSyntaxKind.LessThanToken;
    repeat
      Result.TypeParameters.Add(ReadTypeParameter);
    until CurrentToken <> TSyntaxKind.CommaToken;

    AssumeToken(TSyntaxKind.GreaterThanToken);
    ReadToken(ClassDeclarationTokens, True);
  end;

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
    Result.Members.Add(ReadAmbientClassBodyElement);

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadIdentifier(ClassElementTokens);
  end;

  // ensure the current token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadAmbientNamespaceDeclaration: TAmbientNamespaceDeclaration;
var
  AmbientNamespaceTokens: array of TSyntaxKind = [TSyntaxKind.ClassKeyword,
    TSyntaxKind.DeclareKeyword, TSyntaxKind.ExportKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.FunctionKeyword, TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.VarKeyword, TSyntaxKind.SemicolonToken,
    TSyntaxKind.TypeKeyword, TSyntaxKind.CloseBraceToken];
begin
  AssumeToken(TSyntaxKind.NamespaceKeyword);

  ReadIdentifier([TSyntaxKind.StringLiteral], True);

  Result := TAmbientNamespaceDeclaration.Create(Self as IDeclarationOwner);
  Result.Name := ReadIdentifierPath;

  {$IFDEF DEBUG} Console.Log('Read namespace: ' + Result.Name); {$ENDIF}

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.OpenBraceToken);

  ReadToken(AmbientNamespaceTokens, True);
  while CurrentToken <> TSyntaxKind.CloseBraceToken do
  begin
    var IsExport := CurrentToken = TSyntaxKind.ExportKeyword;
    if IsExport then
      ReadToken(AmbientNamespaceTokens, True);

    case CurrentToken of
      TSyntaxKind.ClassKeyword:
        Result.Classes.Add(ReadAmbientClassDeclaration);
      TSyntaxKind.EnumKeyword:
        ReadEnumerationDeclaration;
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadAmbientFunctionDeclaration);
      TSyntaxKind.ImportKeyword:
        ReadImportDeclaration;
      TSyntaxKind.TypeKeyword:
        Result.TypeAliases.Add(ReadTypeAliasDeclaration);
      TSyntaxKind.InterfaceKeyword:
        begin
          Result.Interfaces.Add(ReadInterfaceDeclaration);

          // we're at a closing brace, so we have to advance
          ReadToken(AmbientNamespaceTokens, True);
        end;
      TSyntaxKind.VarKeyword:
        Result.Variables.Add(ReadAmbientVariableDeclaration);
    end;

    if CurrentToken = TSyntaxKind.SemicolonToken then
      ReadToken(AmbientNamespaceTokens, True)
  end;

  // ensure that the next token is an open brace
  AssumeToken(TSyntaxKind.CloseBraceToken);
end;

function TTranslator.ReadAmbientModuleDeclaration: TAmbientModuleDeclaration;
var
  ModuleTokens: array of TSyntaxKind = [TSyntaxKind.ExportKeyword,
    TSyntaxKind.VarKeyword, TSyntaxKind.LetKeyword, TSyntaxKind.ConstKeyword,
    TSyntaxKind.TypeKeyword, TSyntaxKind.FunctionKeyword,
    TSyntaxKind.ClassKeyword, TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.EnumKeyword, TSyntaxKind.ModuleKeyword,
    TSyntaxKind.NamespaceKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken,
    TSyntaxKind.AbstractKeyword, TSyntaxKind.TypeKeyword];
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

        ReadIdentifier([TSyntaxKind.ClassKeyword], True);

        if CurrentToken <> TSyntaxKind.ClassKeyword then
          ReadToken(ModuleTokens, True);
      end;

      if CurrentToken = TSyntaxKind.EqualsToken then
      begin
        // handle this directly
        IsExport := False;
        ReadIdentifier;

        ReadIdentifierPath;

        // ReadToken(ModuleTokens, True); // do no scan for further tokens here
        continue;
      end;
    end;

    var IsAbstract := CurrentToken = TSyntaxKind.AbstractKeyword;

    if IsAbstract then
      ReadToken([TSyntaxKind.ClassKeyword], True);

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
        end;
      TSyntaxKind.TypeKeyword:
        Result.TypeAliases.Add(ReadTypeAliasDeclaration);
      TSyntaxKind.FunctionKeyword:
        Result.Functions.Add(ReadAmbientFunctionDeclaration);
      TSyntaxKind.NamespaceKeyword:
        begin
          Result.Namespaces.Add(ReadNamespaceDeclaration);
          ReadToken(ModuleTokens, True);
        end;
      TSyntaxKind.ClassKeyword:
        begin
          var NewClass := ReadClassDeclaration;
          NewClass.IsAbstract := IsAbstract;

          Result.Classes.Add(NewClass);

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

procedure TTranslator.ReadDefinition;
var
  DefinitionTokens: array of TSyntaxKind = [TSyntaxKind.ExportKeyword,
    TSyntaxKind.DeclareKeyword, TSyntaxKind.InterfaceKeyword,
    TSyntaxKind.ModuleKeyword, TSyntaxKind.ImportKeyword,
    TSyntaxKind.EndOfFileToken];
begin
  ReadToken(DefinitionTokens, True);
  while CurrentToken <> TSyntaxKind.EndOfFileToken do
  begin
    var IsExport := CurrentToken = TSyntaxKind.ExportKeyword;
    if IsExport then
    begin
      var ExportTokens := DefinitionTokens;
      ExportTokens -= TSyntaxKind.ExportKeyword;
      ReadToken(ExportTokens, True);
    end;

    // ignore export token (for now)
    case CurrentToken of
      TSyntaxKind.DeclareKeyword:
        FDeclarations.Add(ReadAmbientDeclaration);
      TSyntaxKind.InterfaceKeyword:
        begin
          var &Interface := ReadInterfaceDeclaration;
          &Interface.IsExport := IsExport;
          FInterfaces.Add(&Interface);

          // advance to next definition
          AssumeToken(TSyntaxKind.CloseBraceToken);
          ReadToken(DefinitionTokens, True);
        end;
      TSyntaxKind.ModuleKeyword:
        FModules.Add(ReadModuleDeclaration);
      TSyntaxKind.ImportKeyword:
        FImports.Add(ReadImportDeclaration);
    end;

    if CurrentToken in [TSyntaxKind.CloseBraceToken, TSyntaxKind.SemicolonToken] then // do not use TSyntaxKind.CloseBraceToken
      ReadToken(DefinitionTokens, True);
  end;
end;

procedure TTranslator.HandleScanError(Expected: TSyntaxKind = TSyntaxKind.Unknown);
begin
  var LineChar := TypeScriptExport.getLineAndCharacterOfPosition(
    FSourceFile, FScanner.getTokenPos);

  var Text := Format('Unknown token "%s" in this context (%d:%d)',
    [CurrentTokenText, LineChar.line + 1, LineChar.character + 1]);

  if Expected > TSyntaxKind.Unknown then
    Text += Format('; Expected (%d)', [Expected]);

  Console.Trace('Error in ' + Name);

  raise Exception.Create(Text);
end;

function GetUnitName(FileName: String): String;
begin
  if FileName.Length = 0 then
    Exit('Unknown');
  var Items := FileName.Split('\');
  Result := Items[High(Items)];
  Items := Result.Split('/');
  Result := Items[High(Items)];
  Result := Result.Replace('-', '_');
  Result[1] := Uppercase(Result[1]);
end;

function TTranslator.BuildPascalHeader: String;
begin
  Result := '';

  // eventually omit writing header for empty translations
  if FImports.Count + FModules.Count + FInterfaces.Count + FDeclarations.Count = 0 then
    Exit;

  var OutputName := Name;

  if UnitOutputName.Length > 0 then
    OutputName := UnitOutputName;

  Result := 'unit ' + GetUnitName(OutputName) + ';' + CRLF + CRLF;
  Result += 'interface' + CRLF + CRLF;

  for var Import in FImports do
    Result := Result + Import.AsCode;

  for var Module in FModules do
    Result := Result + Module.AsCode;

  if FInterfaces.Length > 0 then
  begin
    Result += 'type' + CRLF;
    TCustomDeclaration.BeginIndention;
    for var &Interface in FInterfaces do
      Result := Result + &Interface.AsCode;
    TCustomDeclaration.EndIndention;
  end;

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
