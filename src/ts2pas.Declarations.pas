unit ts2pas.Declarations;

interface

const
  CRLF = #13#10;

type
  TVisibility = (vPublic, vProtected, vPrivate);

  TTypeParameters = string;

  IDeclarationOwner = interface
  end;

  TCustomDeclaration = class
  private
    FOwner: IDeclarationOwner;
    class var IndentionLevel: Integer;
  protected
    function GetAsCode: String; virtual; abstract;

    class procedure BeginIndention;
    class procedure EndIndention;
    class function GetIndentionString: String;
  public
    constructor Create(Owner: IDeclarationOwner); virtual;

    property AsCode: String read GetAsCode;
  end;

  TNamedDeclaration = class(TCustomDeclaration)
  public
    property Name: String;
  end;

  TCustomType = class(TCustomDeclaration);

  TArrayType = class(TCustomType)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;

  TUnionType = class(TCustomType)
  protected
    function GetAsCode: String; override;
  public
    property &Types: array of TCustomType;
  end;

  TCustomNamedType = class(TCustomType)
  protected
    function GetName: String; virtual; abstract;
    function GetAsCode: String; override;
  public
    property Name: String read GetName;
  end;

  TTypeOfType = class(TCustomNamedType)
  protected
    function GetName: String; override;
  public
    property &Type: TCustomType;
  end;

  TPredefinedType = class(TCustomNamedType)
  protected
    function GetAsCode: String; override;
  end;

  TVariantType = class(TPredefinedType)
  protected
    function GetName: String; override;
  end;

  TFloatType = class(TPredefinedType)
  protected
    function GetName: String; override;
  end;

  TStringType = class(TPredefinedType)
  protected
    function GetName: String; override;
  end;

  TBooleanType = class(TPredefinedType)
  protected
    function GetName: String; override;
  end;

  TFunctionParameter = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
    property Nullable: Boolean;
  end;

  TFunctionType = class(TCustomNamedType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
  public
    property Name: String read GetName;
    property ResultType: TCustomType;
    property Parameters: array of TFunctionParameter;
  end;

  TConstructorType = class(TCustomNamedType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
  public
    property Name: String read GetName;
    property ResultType: TCustomType;
    property Parameters: array of TFunctionParameter;
  end;

  TTypeArgument = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property &Type: TCustomType;
  end;

  TNamedType = class(TCustomNamedType)
  private
    FName: String;
  protected
    function GetName: String; override;
  public
    constructor Create(Owner: IDeclarationOwner; AName: String); reintroduce;
    property Name: String read GetName;
    property Arguments: array of TTypeArgument;
  end;

  TExportDeclaration = class(TNamedDeclaration)
  private
    FDefault: Boolean;
  protected
    function GetAsCode: String; override;
  public
    property Default: Boolean read FDefault write FDefault;
  end;

  TDefinitionDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  end;

  TEnumerationItem = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Value: String;
  end;

  TEnumerationDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Items: array of TEnumerationItem;
  end;

  TFunctionDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TFunctionType;
  end;

  TCustomTypeMember = class(TNamedDeclaration)
  public
    constructor Create(Owner: IDeclarationOwner); override;

    property Visibility: TVisibility;
    property IsStatic: Boolean;
  end;

  TObjectType = class(TCustomType)
  protected
    function GetAsCode: String; override;
  public
    property Members: array of TCustomTypeMember;
  end;

  TFieldDeclaration = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property Nullable: Boolean;
    property &Type: TCustomType;
  end;

  TAccessibilityModifier = (
    amPublic,
    amPrivate,
    amProtected
  );

  TParameter = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property AccessibilityModifier: TAccessibilityModifier;
    property &Type: TCustomType;
    property IsOptional: Boolean;
    property IsRest: Boolean;
    property DefaultValue: string;
  end;

  TTypeParameter = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property ExtendsType: TCustomType;
  end;

  TTypeReference = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Arguments: array of TTypeArgument;
  end;

  TConstructorDeclaration = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property &TypeParameters: TTypeParameters;
    property ParameterList: array of TParameter;
    property &Type: TCustomType;
  end;

  TIndexDeclaration = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property IsStringIndex: Boolean;
    property &Type: TCustomType;
  end;

  TMethodDeclaration = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TFunctionType;
  end;

  TCallbackDeclaration = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TFunctionType;
  end;

  TInterfaceDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Extends: array of TTypeReference;
    property &Type: TObjectType;
  end;

  TClassDeclaration = class(TInterfaceDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Implements: array of String;
    property Members: array of TCustomTypeMember;
  end;

  TImportDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
  end;


  TCallSignature = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &TypeParameters: TTypeParameters;
    property ParameterList: array of TParameter;
    property &Type: TCustomType;
  end;



  TAmbientBinding  = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;

  TAmbientVariableDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property IsConst: Boolean;
    property AmbientBindingList: array of TAmbientBinding;
  end;

  TAmbientFunctionDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property CallSignature: TCallSignature;
  end;

  TAmbientClassDeclaration = class(TClassDeclaration)
  end;


  TTypeAlias = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;


  TAmbientModuleDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property IdentifierPath: String;
    property Enums: array of TEnumerationDeclaration;
    property Variables: array of TAmbientVariableDeclaration;
    property TypeAliases: array of TTypeAlias;
    property Functions: array of TAmbientFunctionDeclaration;
    property Classes: array of TAmbientClassDeclaration;
    property Modules: array of TAmbientModuleDeclaration;
    property Interfaces: array of TInterfaceDeclaration;
  end;








  TVariableDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;

  TNamespaceDeclaration = class(TNamedDeclaration)
  end;

  TModuleDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Classes: array of TClassDeclaration;
    property Interfaces: array of TInterfaceDeclaration;
    property Functions: array of TFunctionDeclaration;
    property Exports: array of TExportDeclaration;
    property Variables: array of TVariableDeclaration;
    property Modules: array of TModuleDeclaration;
  end;

  TAmbientDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Classes: array of TClassDeclaration;
    property Functions: array of TAmbientFunctionDeclaration;
    property Enums: array of TEnumerationDeclaration;
    property Modules: array of TAmbientModuleDeclaration;
    property Namespaces: array of TNamespaceDeclaration;
    property Variables: array of TAmbientVariableDeclaration;
  end;

implementation

uses
  NodeJS.Core;


function Escape(Name: String): String;
begin
  case LowerCase(Name) of
    'type':
      Result := '&type';
    'export':
      Result := '&export';
    'label':
      Result := '&label';
    else
      Result := Name;
  end;
end;


{ TCustomDeclaration }

constructor TCustomDeclaration.Create(Owner: IDeclarationOwner);
begin
  FOwner := Owner;
end;

class procedure TCustomDeclaration.BeginIndention;
begin
  Inc(IndentionLevel);
end;

class procedure TCustomDeclaration.EndIndention;
begin
  Dec(IndentionLevel);
end;

class function TCustomDeclaration.GetIndentionString: String;
begin
  Result := DupeString('  ', IndentionLevel);
end;


{ TArrayType }

function TArrayType.GetAsCode: String;
begin
  Result := 'array of ' + &Type.AsCode;
end;


{ TUnionType }

function TUnionType.GetAsCode: String;
begin
  Result := 'Variant {';
  for var SubType in Types do
  begin
    Result += SubType.AsCode;
  end;
end;


{ TCustomNamedType }

function TCustomNamedType.GetAsCode: String;
begin
(*
  case LowerCase(Name) of
    'date':
      Result := 'JDate';
    else
      Result := Escape(Name);
  end;
*)
  Result := 'J' + Name;
end;


{ TTypeOfType }

function TTypeOfType.GetName: String;
begin
  Result := 'type of';
end;


{ TPredefinedType }

function TPredefinedType.GetAsCode: String;
begin
  Result := Name;
end;


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
  Result := 'String';
end;


{ TFunctionType }

function TFunctionType.GetName: String;
begin
  Result := 'function';
end;

function TFunctionType.GetAsCode: String;
begin
  if Parameters.Count > 0 then
  begin
    Result := '(' + Parameters[0].AsCode;
    for var Index := Low(Parameters) + 1 to High(Parameters) do
      Result += '; ' + Parameters[Index].AsCode;
    Result += ')';
  end;

  if Assigned(ResultType) then
    Result += ': ' + ResultType.AsCode;
end;


{ TConstructorType }

function TConstructorType.GetName: String;
begin
  Result := 'constructor';
end;

function TConstructorType.GetAsCode: String;
begin
  if Parameters.Count > 0 then
  begin
    Result := '(' + Parameters[0].AsCode;
    for var Index := Low(Parameters) + 1 to High(Parameters) do
      Result += '; ' + Parameters[Index].AsCode;
    Result += ')';
  end;

  if Assigned(ResultType) then
    Result += ': ' + ResultType.AsCode;
end;


{ TNamedType }

constructor TNamedType.Create(Owner: IDeclarationOwner; AName: String);
begin
  inherited Create(Owner);

  FName := AName
end;

function TNamedType.GetName: String;
begin
  Result := FName;
end;


{ TExportDeclaration }

function TExportDeclaration.GetAsCode: String;
begin
  Result := '';
end;


{ TAmbientDeclaration }

function TAmbientDeclaration.GetAsCode: String;
begin
  for var &Function in Functions do
    Result += &Function.AsCode;

  for var Module in Modules do
    Result += Module.AsCode;

  if Classes.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;
    for var &Class in Classes do
      Result := Result + &Class.AsCode;
    EndIndention;
  end;

  if Variables.Count > 0 then
    for var Variable in Variables do
      Result := Result + Variable.AsCode;
end;


{ TDefinitionDeclaration }

function TDefinitionDeclaration.GetAsCode: String;
begin
  Console.Log('not implemented: TDefinitionDeclaration.GetAsCode');
end;


{ TEnumerationItem }

function TEnumerationItem.GetAsCode: String;
begin
  Console.Log('not implemented: TEnumerationItem.GetAsCode');
end;


{ TEnumerationDeclaration }

function TEnumerationDeclaration.GetAsCode: String;
begin
  Console.Log('not implemented: TEnumerationDeclaration.GetAsCode');
end;


{ TFunctionDeclaration }

function TFunctionDeclaration.GetAsCode: String;
begin
  Result := &Type.AsCode;
end;


{ TFieldDeclaration }

function TFieldDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + Escape(Name) + ': ' + &Type.AsCode + ';';
  if Nullable then
    Result += ' // nullable';

  // line break
  Result += CRLF;
end;


{ TConstructorDeclaration }

function TConstructorDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + 'constructor Create';

  if Assigned(&Type) then
    Result += &Type.AsCode;

  // line break
  Result += ';' + CRLF;
end;


{ TIndexDeclaration }

function TIndexDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + '// ';
  Result += 'property Item[' + Name + ': ';
  Result += if IsStringIndex then 'String' else 'Integer';
  Result += ']: ' + &Type.AsCode;
end;


{ TMethodDeclaration }

function TMethodDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + 'function ' + Name;

  if Assigned(&Type) then
    Result += &Type.AsCode;

  // line break
  Result += ';' + CRLF;
end;


{ TCallbackDeclaration }

function TCallbackDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + 'callback ' + Name;

  if Assigned(&Type) then
    Result += &Type.AsCode;

  // line break
  Result += ';' + CRLF;
end;


{ TFunctionParameter }

function TFunctionParameter.GetAsCode: String;
begin
  Result := Escape(Name) + ': ';
  if Assigned(&Type) then
    Result += &Type.AsCode
  else
    Result += 'Variant';
end;


{ TCustomTypeMember }

constructor TCustomTypeMember.Create(Owner: IDeclarationOwner);
begin
  inherited Create(Owner);
  Visibility := vPublic;
end;


{ TObjectType }

function TObjectType.GetAsCode: String;
begin
(*
  Result +=
  for var Extend in Extends do
    Result += ' // extends ' + Extend;
*)

  BeginIndention;
  for var Member in Members do
    Result += Member.AsCode;
  EndIndention;
  Result += GetIndentionString + 'end;';

  // line breaks
  Result += CRLF + CRLF;
end;


{ TImportDeclaration }

function TImportDeclaration.GetAsCode: String;
begin
  Console.Log('not implemented: TImportDeclaration.GetAsCode');
end;


{ TVariableDeclaration }

function TVariableDeclaration.GetAsCode: String;
begin
  Console.Log('not implemented: TVariableDeclaration.GetAsCode');
end;


{ TModuleDeclaration }

function TModuleDeclaration.GetAsCode: String;
begin
(*
  Result := 'unit ' + Name + ';' + CRLF + CRLF;
  Result += 'interface' + CRLF + CRLF;
*)

  if Classes.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;
    for var &Class in Classes do
      Result := Result + &Class.AsCode;
    EndIndention;
  end;

  if Interfaces.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;
    for var &Interface in Interfaces do
      Result := Result + &Interface.AsCode;
    EndIndention;
  end;

  if Variables.Count > 0 then
  begin
    Result += 'var' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      Result := Result + Variable.AsCode;
    EndIndention;
  end;
end;








{ TParameter }

function TParameter.GetAsCode: String;
begin
  Result := Name + ': ' + &Type.AsCode;
  if DefaultValue <> '' then
    Result += ' = ' + DefaultValue;
end;


{ TCallSignature }

function TCallSignature.GetAsCode: String;
begin
  Result := '(';
  for var Parameter in ParameterList do
    Result += Parameter.AsCode;
  Result += ')';

  if Assigned(&Type) then
    Result += ': ' + &Type.AsCode;
end;


{ TAmbientBinding }

function TAmbientBinding.GetAsCode: String;
begin
  Result := Name + ': ' + &Type.AsCode;
end;


{ TAmbientVariableDeclaration }

function TAmbientVariableDeclaration.GetAsCode: String;
begin
  Result := if IsConst then 'const' else 'var';
  Result += ' ';
  for var AmbientBinding in AmbientBindingList do
    Result += AmbientBinding.AsCode;
  Result +=  ';' + CRLF;
end;


{ TAmbientFunctionDeclaration }

function TAmbientFunctionDeclaration.GetAsCode: String;
begin
  Result := if Assigned(CallSignature.&Type) then 'function' else 'procedure';
  Result += ' ' + Name + CallSignature.AsCode;
  Result +=  ';' + CRLF;
end;


{ TAmbientFunctionDeclaration }

function TAmbientModuleDeclaration.GetAsCode: String;
begin
  Result := '//' + IdentifierPath + CRLF + CRLF;
//    property IdentifierPath: String;
  for var Variable in Variables do
    Result += Variable.AsCode;

  for var &Function in Functions do
    Result += &Function.AsCode;

  for var &Class in Classes do
    Result += &Class.AsCode;

  for var Module in Modules do
    Result += Module.AsCode;

  for var &Interface in Interfaces do
    Result += Module.AsCode;
end;


{ TClassDeclaration }

function TClassDeclaration.GetAsCode: String;
begin
  Result := 'type' + CRLF;
  BeginIndention;
  Result += GetIndentionString + 'J' + Name + ' = class external ''' + Name + '''';
  if Extends.Count > 0 then
  begin
    Result += '(';
    Result += Extends[0].AsCode;
    for var Index := Low(Extends) + 1 to High(Extends) do
      Result += ', ' + Extends[Index].AsCode;
    Result += ')';
  end;
  Result += CRLF;

  BeginIndention;
  for var Member in Members do
    Result += Member.AsCode;
  EndIndention;

  Result += GetIndentionString + 'end;' + CRLF + CRLF;
  EndIndention;
end;

{ TInterfaceDeclaration }

function TInterfaceDeclaration.GetAsCode: String;
begin
  Result := 'type' + CRLF;
  BeginIndention;
  Result += GetIndentionString + Name + ' = class external';
  if Extends.Count > 0 then
  begin
    Result += '(';
    Result += Extends[0].AsCode;
    for var Index := Low(Extends) + 1 to High(Extends) do
      Result += ', ' + Extends[Index].AsCode;
    Result += ')';

  end;
  Result += CRLF;
  Result += &Type.AsCode;
  EndIndention;
end;

{ TTypeParameter }

function TTypeParameter.GetAsCode: String;
begin
  Console.Log('not implemented: TTypeParameter.GetAsCode');
end;

{ TTypeArgument }

function TTypeArgument.GetAsCode: String;
begin
  Console.Log('not implemented: TTypeArgument.GetAsCode');
end;

{ TTypeReference }

function TTypeReference.GetAsCode: String;
begin
  Result := Name;
  if Arguments.Length > 0 then
  begin
    Result += ' {' + Arguments[0].AsCode;
    for var Index := Low(Arguments) + 1 to High(Arguments) do
      Result += ', ' + Arguments[Index].AsCode;
    Result += '} ';
  end;
end;

function TTypeAlias.GetAsCode: String;
begin
  Console.Log('not implemented: TTypeAlias.GetAsCode');
end;

end.