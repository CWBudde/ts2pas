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

  TVariantType = class(TCustomNamedType)
  protected
    function GetName: String; override;
  end;

  TFloatType = class(TCustomNamedType)
  protected
    function GetName: String; override;
  end;

  TStringType = class(TCustomNamedType)
  protected
    function GetName: String; override;
  end;

  TBooleanType = class(TCustomNamedType)
  protected
    function GetName: String; override;
  end;

  TEnumDeclaration = class(TNamedDeclaration)
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

  TParameter = class
    property AccessibilityModifier: TAccessibilityModifier;
    property BindingIdentifier: String;
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
    property Members: array of TCustomTypeMember;
  end;

  TClassDeclaration = class(TInterfaceDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Implements: array of String;
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



  TAmbientBinding  = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property BindingIdentifier: String;
    property &Type: TCustomType;
  end;

  TAmbientVariableDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property IsConst: Boolean;
    property AmbientBindingList: array of TAmbientBinding;
  end;

  TAmbientFunctionDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property BindingIdentifier: String;
    property CallSignature: TCallSignature;
  end;

  TAmbientClassDeclaration = class(TClassDeclaration)
  end;




  TAmbientModuleDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property IdentifierPath: String;
    property Variables: array of TAmbientVariableDeclaration;
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
    property Enums: array of TEnumDeclaration;
    property Modules: array of TAmbientModuleDeclaration;
    property Namespaces: array of TNamespaceDeclaration;
    property Variables: array of TAmbientVariableDeclaration;
  end;

implementation

uses
  NodeJS.Core;


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
  Result := Name;
end;


{ TTypeOfType }

function TTypeOfType.GetName: String;
begin
  Result := 'type of';
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
  Result := 'Boolean';
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
  begin
    Result += 'var' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      Result := Result + Variable.AsCode;
    EndIndention;
  end;
end;


{ TDefinitionDeclaration }

function TDefinitionDeclaration.GetAsCode: String;
begin

end;


{ TEnumerationItem }

function TEnumerationItem.GetAsCode: String;
begin

end;


{ TEnumerationDeclaration }

function TEnumerationDeclaration.GetAsCode: String;
begin

end;


{ TFunctionDeclaration }

function TFunctionDeclaration.GetAsCode: String;
begin
  Result := &Type.AsCode;
end;


{ TFieldDeclaration }

function TFieldDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + Name + ': ' + &Type.AsCode + ';';
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
  Result := Name + ': ';
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

end;


{ TVariableDeclaration }

function TVariableDeclaration.GetAsCode: String;
begin

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








{ TCallSignature }

function TCallSignature.GetAsCode: String;
begin

end;


{ TAmbientBinding }

function TAmbientBinding.GetAsCode: String;
begin

end;


{ TAmbientVariableDeclaration }

function TAmbientVariableDeclaration.GetAsCode: String;
begin
  Result := if IsConst then 'const ' else 'var ';
  for var AmbientBinding in AmbientBindingList do
    Result += AmbientBinding.AsCode;
end;


{ TAmbientFunctionDeclaration }

function TAmbientFunctionDeclaration.GetAsCode: String;
begin
  //Result := &Type.AsCode;
end;


{ TAmbientFunctionDeclaration }

function TAmbientModuleDeclaration.GetAsCode: String;
begin
  //Result := &Type.AsCode;
end;


{ TClassDeclaration }

function TClassDeclaration.GetAsCode: String;
begin

end;

{ TInterfaceDeclaration }

function TInterfaceDeclaration.GetAsCode: String;
begin

end;

{ TTypeParameter }

function TTypeParameter.GetAsCode: String;
begin

end;

{ TTypeArgument }

function TTypeArgument.GetAsCode: String;
begin

end;

end.
