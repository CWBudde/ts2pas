unit ts2pas.Declarations;

interface

const
  CRLF = #13#10;

type
  TVisibility = (vPublic, vProtected, vPrivate);

  IDeclarationOwner = interface
  end;

  TCustomDeclaration = class
  private
    FOwner: IDeclarationOwner;
    class var FIndentionLevel: Integer;
    class var FNamespaces: array of String;
  protected
    function GetAsCode: String; virtual; abstract;

    class function GetIndentionString: String;
    class function GetNamespaceString: String;
  public
    constructor Create(Owner: IDeclarationOwner); virtual;

    class procedure BeginIndention;
    class procedure EndIndention;

    class procedure BeginNamespace(Value: String);
    class procedure EndNamespace;

    property AsCode: String read GetAsCode;
    property NamespaceString: String read GetNamespaceString;
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
    function GetAsCodeOmitType(OmitType: Boolean): String;
  public
    property &Type: TCustomType;
    property IsOptional: Boolean;
    property AsCode[OmitType: Boolean]: String read GetAsCodeOmitType;
  end;

  TFunctionType = class(TCustomNamedType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
    function GetAsCodeWithOptionalLevel(OptionalLevel: Integer): String; overload;
  public
    property Name: String read GetName;
    property ResultType: TCustomType;
    property ParameterList: array of TFunctionParameter;
    property AsCode[OptionalLevel: Integer]: String read GetAsCodeWithOptionalLevel;
  end;

  TConstructorType = class(TCustomNamedType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
  public
    property Name: String read GetName;
    property ResultType: TCustomType;
    property ParameterList: array of TFunctionParameter;
  end;

  TTypeArgument = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;

  TNamedType = class(TCustomNamedType)
  private
    FName: String;
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
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

  TTypeParameter = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property ExtendsType: TCustomType;
  end;

  TCustomTypeMember = class(TNamedDeclaration)
  public
    constructor Create(Owner: IDeclarationOwner); override;

    property Visibility: TVisibility;
    property IsStatic: Boolean;
    property TypeArguments: array of TTypeArgument;
    property TypeParameters: array of TTypeParameter;
  end;

  TObjectType = class(TCustomType)
  protected
    function GetAsCode: String; override;
  public
    property Members: array of TCustomTypeMember;
  end;

  TTupleType = class(TCustomType)
  protected
    function GetAsCode: String; override;
  public
    property Types: array of TCustomType;
  end;

  TIndexSignature = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property IsStringIndex: Boolean;
    property &Type: TCustomType;
  end;

  TClassTypeMember = class(TCustomTypeMember)
  public
    property Visibility: TVisibility;
    property IsStatic: Boolean;
  end;

  TIndexMemberDeclaration = class(TClassTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property IndexSignature: TIndexSignature;
  end;

  TPropertyMemberDeclaration = class(TClassTypeMember)
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
    function GetAsCodeOmitType(OmitType: Boolean): String;
  public
    property AccessibilityModifier: TAccessibilityModifier;
    property &Type: TCustomType;
    property IsOptional: Boolean;
    property IsRest: Boolean;
    property DefaultValue: string;
    property AsCode[OmitType: Boolean]: String read GetAsCodeOmitType;
  end;

  TCallSignature = class(TCustomTypeMember)
  protected
    function GetAsCode: String; override;
    function GetAsCodeWithOptionalLevel(OptionalLevel: Integer): String; overload;
  public
    property ParameterList: array of TParameter;
    property &Type: TCustomType;
    property TypeParameters: array of TTypeParameter;
    property AsCode[OptionalLevel: Integer]: String read GetAsCodeWithOptionalLevel;
  end;

  TTypeReference = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Arguments: array of TTypeArgument;
  end;

  TConstructorDeclaration = class(TClassTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property ParameterList: array of TParameter;
    property &Type: TCustomType;
  end;

  TMethodDeclaration = class(TClassTypeMember)
  protected
    function GetAsCode: String; override;
  public
    property CallSignature: TCallSignature;
  end;

  TInterfaceDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Extends: array of TTypeReference;
    property &Type: TObjectType;
    property TypeParameters: array of TTypeParameter;
  end;

  TClassDeclaration = class(TInterfaceDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Implements: array of TTypeReference;
    property Members: array of TCustomTypeMember;
  end;

  TImportDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Value: String;
  end;

  TTypeAlias = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
    property &TypeParameters: array of TTypeParameter;
  end;


  TNamespaceDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Enums: array of TEnumerationDeclaration;
    property TypeAliases: array of TTypeAlias;
    property Functions: array of TFunctionDeclaration;
    property Classes: array of TClassDeclaration;
    property Interfaces: array of TInterfaceDeclaration;
    property Namespaces: array of TNamespaceDeclaration;
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

  TAmbientBodyElement = class(TCustomDeclaration);

  TAmbientClassDeclaration = class(TCustomDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Extends: array of TTypeReference;
    property Implements: array of String;
    property Members: array of TAmbientBodyElement;
  end;

  TAmbientPropertyMemberDeclaration = class(TAmbientBodyElement)
  public
    property Visibility: TVisibility;
    property IsStatic: Boolean;
    property Name: string;
  end;

  TAmbientPropertyMemberDeclarationProperty = class(TAmbientPropertyMemberDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
  end;

  TAmbientPropertyMemberDeclarationMethod = class(TAmbientPropertyMemberDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property CallSignature: TCallSignature;
  end;

  TAmbientEnumerationDeclaration = class(TEnumerationDeclaration);

  TAmbientNamespaceDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property Enums: array of TAmbientEnumerationDeclaration;
    property Functions: array of TAmbientFunctionDeclaration;
    property Classes: array of TAmbientClassDeclaration;
    property Interfaces: array of TInterfaceDeclaration;
    property Variables: array of TAmbientVariableDeclaration;
    property Namespaces: array of TAmbientNamespaceDeclaration;
  end;

  TAmbientConstructorDeclaration = class(TAmbientBodyElement)
  protected
    function GetAsCode: String; override;
  public
    property ParameterList: array of TFunctionParameter;
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
    property Classes: array of TClassDeclaration;
    property Modules: array of TAmbientModuleDeclaration;
    property Namespaces: array of TNamespaceDeclaration;
    property Interfaces: array of TInterfaceDeclaration;
  end;




  TVariableDeclaration = class(TNamedDeclaration)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
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
    property Classes: array of TAmbientClassDeclaration;
    property Functions: array of TAmbientFunctionDeclaration;
    property Enums: array of TEnumerationDeclaration;
    property Modules: array of TAmbientModuleDeclaration;
    property Namespaces: array of TAmbientNamespaceDeclaration;
    property Variables: array of TAmbientVariableDeclaration;
  end;

implementation

uses
  NodeJS.Core;


function Escape(Name: String): String;
begin
  Result := Name;
  if LowerCase(Name) in ['abstract', 'class', 'const', 'constructor', 'default',
    'div', 'end', 'export', 'external', 'function', 'interface', 'label',
    'object', 'private', 'property', 'protected', 'public', 'string', 'type',
    'uses'] then
    Result := '&' + Result;
  if LowerCase(Name) in ['length', 'include', 'exclude'] then
    Result := '_' + Result;
end;


{ TCustomDeclaration }

constructor TCustomDeclaration.Create(Owner: IDeclarationOwner);
begin
  FOwner := Owner;
end;

class procedure TCustomDeclaration.BeginIndention;
begin
  Inc(FIndentionLevel);
end;

class procedure TCustomDeclaration.BeginNameSpace(Value: String);
begin
  FNamespaces.Push(Value);
end;

class procedure TCustomDeclaration.EndIndention;
begin
  Dec(FIndentionLevel);
end;

class procedure TCustomDeclaration.EndNamespace;
begin
  FNamespaces.Pop;
end;

class function TCustomDeclaration.GetIndentionString: String;
begin
  Result := DupeString('  ', FIndentionLevel);
end;

class function TCustomDeclaration.GetNamespaceString: String;
begin
  Result := '';
  if FNamespaces.Count > 0 then
  begin
    Result += FNamespaces[0];
    for var Index := Low(FNamespaces) + 1 to High(FNamespaces) do
      Result += '.' + FNamespaces[Index];
  end;
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

  for var Index := Low(Types) to High(Types) - 1 do
  begin
    Result += if Assigned(Types[Index]) then Types[Index].AsCode else 'void';
    Result += ' or ';
  end;

  var LastType := Types[High(Types)];
  Result += if Assigned(LastType) then LastType.AsCode else 'void';

  Result += '}';
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
  if ParameterList.Count > 0 then
  begin
    Result := '(' + ParameterList[0].AsCode[False];
    for var Index := Low(ParameterList) + 1 to High(ParameterList) do
      Result += '; ' + ParameterList[Index].AsCode[False];
    Result += ')';
  end;

  if Assigned(ResultType) then
    Result += ': ' + ResultType.AsCode;
end;

function IsIdenticalFunctionParameterType(A, B: TFunctionParameter): Boolean;
begin
  Result := Assigned(A.&Type) xor Assigned(A.&Type);
  if Result and Assigned(A.&Type) then
    Result := A.&Type.AsCode = B.&Type.AsCode;
end;

function TFunctionType.GetAsCodeWithOptionalLevel(OptionalLevel: Integer): String;
var
  CanOmitType: Boolean;
begin
  var CurrentOptionalLevel := 0;
  if ParameterList.Count > 0 then
  begin
    // check if the first parameter isn't optional and there is no budget
    if not (ParameterList[0].IsOptional and (OptionalLevel = 0)) then
    begin
      CurrentOptionalLevel += Integer(ParameterList[0].IsOptional);

      // ensure at least two parameter are available
      CanOmitType := (ParameterList.Count >= 2)

      // ensure that both have a type
        and IsIdenticalFunctionParameterType(ParameterList[0], ParameterList[1])

      // ensure that the current type is optional and that there is still some budget
        and (not ParameterList[0].IsOptional or (CurrentOptionalLevel < OptionalLevel));

      Result := '(' + ParameterList[0].AsCode[CanOmitType];

      for var Index := Low(ParameterList) + 1 to High(ParameterList) do
      begin
        // check if optional level is reached
        if ParameterList[Index].IsOptional and (CurrentOptionalLevel >= OptionalLevel) then
          break;

        // increase optional level
        CurrentOptionalLevel += Integer(ParameterList[Index].IsOptional);

        // add separator
        Result += if CanOmitType then ', ' else '; ';

        // check if current type is needed
        CanOmitType := (Index + 1 < ParameterList.Count) and
          IsIdenticalFunctionParameterType(ParameterList[0], ParameterList[1])
          and (not ParameterList[Index].IsOptional or (CurrentOptionalLevel < OptionalLevel));

        Result += ParameterList[Index].AsCode[CanOmitType];
      end;
      Result += ')';
    end;
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
  if ParameterList.Count > 0 then
  begin
    Result := '(' + ParameterList[0].AsCode[False];
    for var Index := Low(ParameterList) + 1 to High(ParameterList) do
      Result += '; ' + ParameterList[Index].AsCode[False];
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

function TNamedType.GetAsCode: String;
begin
  Result := inherited GetAsCode;
  if Arguments.Length > 0 then
  begin
    Result += '{<';
    for var Argument in Arguments do
      Result += Argument.AsCode;
    Result += '>}';
  end;
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
      Result += &Class.AsCode;
    EndIndention;
  end;

  if Variables.Count > 0 then
    for var Variable in Variables do
      Result += Variable.AsCode;

  for var Namespace in Namespaces do
    Result += Namespace.AsCode;
end;


{ TDefinitionDeclaration }

function TDefinitionDeclaration.GetAsCode: String;
begin
  Console.Log('not implemented: TDefinitionDeclaration.GetAsCode');
end;


{ TEnumerationItem }

function TEnumerationItem.GetAsCode: String;
begin
  Result := Name;
end;


{ TEnumerationDeclaration }

function TEnumerationDeclaration.GetAsCode: String;
begin
  Result += GetIndentionString + 'T' + Name + ' = Variant;' + CRLF;
  Result += GetIndentionString + 'T' + Name + 'Helper = strict helper for T' + Name + CRLF;
  BeginIndention;
  for var Item in Items do
  begin
    Result += GetIndentionString + 'const ' + Escape(Item.AsCode);
    if Item.Value <> '' then
    begin
      try
        Result += ' = ' + IntToStr(Item.Value.ToInteger) + ';' + CRLF;
      except
        Result += ' = ''' + Item.Value + ''';' + CRLF;
      end;
    end
    else
      Result += ' = ''' + Item.Name + ''';' + CRLF
  end;
(*
  for var Index := Low(Items) to High(Items) - 1 do
    Result +=  Items[Index].AsCode + ', ' + CRLF;
  Result +=  Items[High(Items)].AsCode + CRLF;
*)
  EndIndention;
  Result += GetIndentionString + 'end;' + CRLF;
  Result += CRLF;
end;


{ TFunctionDeclaration }

function TFunctionDeclaration.GetAsCode: String;
var
  Head: string;
  Foot: string;
begin
  var OptionalParameterCount := 0;
  for var Parameter in &Type.ParameterList do
    if Parameter.IsOptional then
      Inc(OptionalParameterCount);

  Head := GetIndentionString;
  Head += if Assigned(&Type.ResultType) then 'function' else 'procedure';
  Head += ' ' + Escape(Name);

  Foot := ';' + if OptionalParameterCount > 0 then ' overload;';
(*
  if NamespaceString <> '' then
    Foot += ' external ''' + NamespaceString + Escape(Name) + '''';
*)
  Foot += CRLF;

  Result := '';
  for var i := 0 to OptionalParameterCount do
    Result += Head + &Type.AsCode[i] + Foot;
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


{ TPropertyMemberDeclaration }

function TPropertyMemberDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + Escape(Name);

  if TypeArguments.Count > 0 then
  begin
    Result += '{<';
    for var Argument in TypeArguments do
      Result += Argument.AsCode;
    Result += '>}';
  end;

  Result += ': ';
  if Assigned(&Type) then
  begin
    if &Type is TObjectType then
      Result += 'record' + CRLF;
    Result += &Type.AsCode;
  end
  else
    Result += 'Variant';
  Result += ';';
  if Nullable then
    Result += ' // nullable';

  // line break
  Result += CRLF;
end;


{ TIndexMemberDeclaration }

function TIndexMemberDeclaration.GetAsCode: String;
begin
  Result := IndexSignature.GetAsCode + ';' + CRLF;
end;


{ TIndexSignature }

function TIndexSignature.GetAsCode: String;
begin
  Result := GetIndentionString + '// ';
  Result += 'property Item[' + Name + ': ';
  Result += if IsStringIndex then 'String' else 'Integer';
  Result += ']: ' + &Type.AsCode + ';' + CRLF;
end;


{ TMethodDeclaration }

function TMethodDeclaration.GetAsCode: String;
var
  Head: string;
  Foot: string;
begin
  var OptionalParameterCount := 0;
  for var Parameter in CallSignature.ParameterList do
    if Parameter.IsOptional then
      Inc(OptionalParameterCount);

  Head := GetIndentionString;
  Head += if Assigned(CallSignature.&Type) then 'function' else 'procedure';
  Head += ' ' + Name;

  Foot := if OptionalParameterCount > 0 then ' overload;';
  Foot += CRLF;

  Result := '';
  for var i := 0 to OptionalParameterCount do
    Result += Head + CallSignature.AsCode[i] + Foot;
end;


{ TFunctionParameter }

function TFunctionParameter.GetAsCode: String;
begin
  Result := Escape(Name) + ': ';
  if Assigned(&Type) then
  begin
    if &Type is TObjectType then
      Result += 'record' + CRLF;
    Result += &Type.AsCode
  end
  else
    Result += 'Variant';
end;

function TFunctionParameter.GetAsCodeOmitType(OmitType: Boolean): String;
begin
  Result := Escape(Name);
  if not OmitType then
  begin
    Result += ': ';
    if Assigned(&Type) then
    begin
      if &Type is TObjectType then
        Result += 'record' + CRLF;
      Result += &Type.AsCode
    end
    else
      Result += 'Variant';
  end;
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
    if Member is TCallSignature then
    begin
      Result += GetIndentionString;
      var ResType := TCallSignature(Member).&Type;
      Result += if Assigned(ResType) then 'function' else 'procedure';
      Result += Member.AsCode + CRLF
    end
    else
      Result += Member.AsCode;
  EndIndention;
  Result += GetIndentionString + 'end;';
end;


{ TTupleType }

function TTupleType.GetAsCode: String;
begin
  Result := 'TupletType';
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
  Result := '';

  // classes and interfaces
  if Classes.Count + Interfaces.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;

    for var &Class in Classes do
      Result := Result + &Class.AsCode;

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
  Result := Name + ': ';

  if Assigned(&Type) then
  begin
    if &Type is TObjectType then
      Result += 'record' + CRLF;

    Result += &Type.AsCode
  end
  else
    Result += 'Variant';

  if DefaultValue <> '' then
    Result += ' = ' + DefaultValue;

  if IsRest then
    Result += ' {...}';
end;

function TParameter.GetAsCodeOmitType(OmitType: Boolean): String;
begin
  Result := Escape(Name);
  if not OmitType then
  begin
    Result += ': ';
    if Assigned(&Type) then
    begin
      if &Type is TObjectType then
        Result += 'record' + CRLF;

      if &Type is TFunctionType then
      begin
        var ResType := TFunctionType(&Type).ResultType;
        Result += if Assigned(ResType) then 'function' else 'procedure';
      end;

      Result += &Type.AsCode
    end
    else
      Result += 'Variant';
  end;
end;


{ TCallSignature }

function TCallSignature.GetAsCode: String;
begin
  Result := '';
  if TypeParameters.Length > 0 then
  begin
    Result += '{<';
    for var TypeParameter in TypeParameters do
      Result += TypeParameter.AsCode;
    Result += '>}';
  end;

  if ParameterList.Length > 0 then
  begin
    Result += '(';
    for var Index := Low(ParameterList) to High(ParameterList) - 1 do
      Result += ParameterList[Index].AsCode[False] + '; ';
    Result += ParameterList[High(ParameterList)].AsCode[False] + ')';
  end;

  if Assigned(&Type) then
    Result += ': ' + &Type.AsCode;

  Result += ';';
end;

function IsIdenticalParameterType(A, B: TParameter): Boolean;
begin
  Result := Assigned(A.&Type) xor Assigned(A.&Type);
  if Result and Assigned(A.&Type) then
    Result := A.&Type.AsCode = B.&Type.AsCode;
end;

function TCallSignature.GetAsCodeWithOptionalLevel(OptionalLevel: Integer): String;
var
  CanOmitType: Boolean;
begin
  var CurrentOptionalLevel := 0;
  if ParameterList.Count > 0 then
  begin
    // check if the first parameter isn't optional and there is no budget
    if not (ParameterList[0].IsOptional and (OptionalLevel = 0)) then
    begin
      CurrentOptionalLevel += Integer(ParameterList[0].IsOptional);

      // ensure at least two parameter are available
      CanOmitType := (ParameterList.Count >= 2)

      // ensure that both have a type
        and IsIdenticalParameterType(ParameterList[0], ParameterList[1])

      // ensure that the current type is optional and that there is still some budget
        and (not ParameterList[0].IsOptional or (CurrentOptionalLevel < OptionalLevel));


      Result := '(' + ParameterList[0].AsCode[CanOmitType];

      for var Index := Low(ParameterList) + 1 to High(ParameterList) do
      begin
        // check if optional level is reached
        if ParameterList[Index].IsOptional and (CurrentOptionalLevel >= OptionalLevel) then
          break;

        // increase optional level
        CurrentOptionalLevel += Integer(ParameterList[Index].IsOptional);

        // add separator
        Result += if CanOmitType then ', ' else '; ';

        // check if current type is needed
        CanOmitType := (Index + 1 < ParameterList.Count) and
          IsIdenticalParameterType(ParameterList[Index], ParameterList[Index + 1])
          and (not ParameterList[Index].IsOptional or (CurrentOptionalLevel < OptionalLevel));

        Result += ParameterList[Index].AsCode[CanOmitType];
      end;
      Result += ')';
    end;
  end;

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
  for var AmbientBinding in AmbientBindingList do
    Result += GetIndentionString + AmbientBinding.AsCode;
  Result +=  ';' + CRLF;
end;


{ TAmbientFunctionDeclaration }

function TAmbientFunctionDeclaration.GetAsCode: String;
var
  Head: string;
  Foot: string;
begin
  var OptionalParameterCount := 0;
  for var Parameter in CallSignature.ParameterList do
    if Parameter.IsOptional then
      Inc(OptionalParameterCount);

  Head := GetIndentionString;
  Head += if Assigned(CallSignature.&Type) then 'function' else 'procedure';
  Head += ' ' + Escape(Name);

  Foot := ';' + if OptionalParameterCount > 0 then ' overload;';
  if NamespaceString <> '' then
    Foot += ' external ''' + NamespaceString + '.' + Name + '''';
  Foot += CRLF;

  Result := '';
  for var i := 0 to OptionalParameterCount do
    Result += Head + CallSignature.AsCode[i] + Foot;
end;


{ TAmbientFunctionDeclaration }

function TAmbientModuleDeclaration.GetAsCode: String;
begin
  Result := '//' + IdentifierPath + CRLF + CRLF;

  var Constants := 0;
  for var Variable in Variables do
    if Variable.IsConst then
      Inc(Constants);

  if Constants > 0 then
  begin
    Result += 'const' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      if Variable.IsConst then
        Result := Result + Variable.AsCode;
    EndIndention;
    Result += CRLF;
  end;

  if Enums.Count + Classes.Count + Interfaces.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;

    for var Enum in Enums do
      Result += Enum.AsCode;

    for var &Class in Classes do
      Result += &Class.AsCode;

    for var &Interface in Interfaces do
      Result += &Interface.AsCode;

    for var TypeAlias in TypeAliases do
      Result += TypeAlias.AsCode;

    EndIndention;
  end;

  for var Module in Modules do
    Result += Module.AsCode;

  if Functions.Count > 0 then
  begin
    for var &Function in Functions do
      Result += &Function.AsCode;
    Result += CRLF;
  end;

  if Variables.Count - Constants > 0 then
  begin
    Result += 'var' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      if not Variable.IsConst then
        Result := Result + Variable.AsCode;
    EndIndention;
    Result += CRLF;
  end;

  for var Namespace in Namespaces do
    Result += Namespace.AsCode;

  Result += CRLF;
end;


{ TClassDeclaration }

function TClassDeclaration.GetAsCode: String;
begin
  {$IFDEF DEBUG} Console.Log('Write interface: ' + Name); {$ENDIF}

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
end;

{ TInterfaceDeclaration }

function TInterfaceDeclaration.GetAsCode: String;
begin
  {$IFDEF DEBUG} Console.Log('Write interface: ' + Name); {$ENDIF}

  Result += GetIndentionString + 'J' + Name;

  if TypeParameters.Length > 0 then
  begin
    Result += '{<';
    for var TypeParameter in TypeParameters do
      Result += TypeParameter.AsCode;
    Result += '>}';
  end;

  Result += ' = class external';

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

  // line breaks
  Result += CRLF + CRLF;
end;


{ TTypeParameter }

function TTypeParameter.GetAsCode: String;
begin
  Result := Name;

  if Assigned(ExtendsType) then
    Result += ' extends ' + ExtendsType.AsCode;
end;


{ TTypeArgument }

function TTypeArgument.GetAsCode: String;
begin
  if Assigned(&Type) then
    Result := &Type.AsCode
  else
    Result := 'Variant';
end;


{ TTypeReference }

function TTypeReference.GetAsCode: String;
begin
  Result := 'J' + Name;
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
  Result := GetIndentionString + Name + ' = ' + &Type.AsCode + ';' + CRLF;
end;


{ TAmbientConstructorDeclaration }

function TAmbientConstructorDeclaration.GetAsCode: String;
begin
  Result := GetIndentionString + 'constructor Create';

  if ParameterList.Length > 0 then
  begin
    Result += '(';
    for var Index := Low(ParameterList) to High(ParameterList) - 1 do
      Result += ParameterList[Index].AsCode[False] + '; ';
    Result += ParameterList[High(ParameterList)].AsCode[False] + ')';
    Result += ')';
  end;

  Result += ';' + CRLF;
end;


{ TAmbientClassDeclaration }

function TAmbientClassDeclaration.GetAsCode: String;
begin
  {$IFDEF DEBUG} Console.Log('Write class: ' + Name); {$ENDIF}

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

  var LastVisibility := vPublic;

  BeginIndention;
  for var Member in Members do
  begin
    var CurrentVisibility := if Member is TAmbientPropertyMemberDeclaration then
      TAmbientPropertyMemberDeclaration(Member).Visibility else vPublic;
    if LastVisibility <> CurrentVisibility then
    begin
      EndIndention;
      Result += GetIndentionString;
      case CurrentVisibility of
        vPublic:
          Result += 'public' + CRLF;
        vProtected:
          Result += 'protected' + CRLF;
        vPrivate:
          Result += 'private' + CRLF;
      end;
      BeginIndention;

      LastVisibility := CurrentVisibility;
    end;
    Result += Member.AsCode;
  end;
  EndIndention;

  Result += GetIndentionString + 'end;' + CRLF + CRLF;
end;


{ TAmbientPropertyMemberDeclarationProperty }

function TAmbientPropertyMemberDeclarationProperty.GetAsCode: String;
begin
  Result := GetIndentionString;
  if IsStatic then
    Result += 'class var ';
  Result += Escape(Name);

  Result +=  ': ' + if Assigned(&Type) then &Type.AsCode else 'Variant';

  // line break
  Result += ';' + CRLF;
end;

{ TAmbientPropertyMemberDeclarationMethod }

function TAmbientPropertyMemberDeclarationMethod.GetAsCode: String;
var
  Head: string;
  Foot: string;
begin
  var OptionalParameterCount := 0;
  for var Parameter in CallSignature.ParameterList do
    if Parameter.IsOptional then
      Inc(OptionalParameterCount);

  Head := GetIndentionString;

  Head += if Assigned(CallSignature.&Type) then 'function' else 'procedure';
  Head += ' ' + Escape(Name);

  Foot := if OptionalParameterCount > 0 then ' overload;';
  Foot += CRLF;

  Result := '';
  for var i := 0 to OptionalParameterCount do
    Result += Head + CallSignature.AsCode[i] + Foot;
end;


{ TNamespaceDeclaration }

function TNamespaceDeclaration.GetAsCode: String;
begin
  BeginNamespace(Name);

  if Enums.Count + Classes.Count + Interfaces.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;

    for var Enum in Enums do
      Result += Enum.AsCode;

    for var &Class in Classes do
      Result += &Class.AsCode;

    for var &Interface in Interfaces do
      Result += &Interface.AsCode;

    EndIndention;
  end;

  if Functions.Count > 0 then
  begin
    for var &Function in Functions do
      Result += &Function.AsCode;
    Result += CRLF;
  end;

  for var Namespace in Namespaces do
    Result += Namespace.AsCode;

  Result += CRLF;

  EndNamespace;
end;

{ TAmbientNamespaceDeclaration }

function TAmbientNamespaceDeclaration.GetAsCode: String;
begin
  BeginNameSpace(Name);

  var Constants := 0;
  for var Variable in Variables do
    if Variable.IsConst then
      Inc(Constants);

  if Constants > 0 then
  begin
    Result += 'const' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      if Variable.IsConst then
        Result := Result + Variable.AsCode;
    EndIndention;
    Result += CRLF;
  end;

  if Enums.Count + Classes.Count + Interfaces.Count > 0 then
  begin
    Result += 'type' + CRLF;
    BeginIndention;

    for var Enum in Enums do
      Result += Enum.AsCode;

    for var &Class in Classes do
      Result += &Class.AsCode;

    for var &Interface in Interfaces do
      Result += &Interface.AsCode;

    EndIndention;
  end;

  if Functions.Count > 0 then
  begin
    for var &Function in Functions do
      Result += &Function.AsCode;
    Result += CRLF;
  end;

  if Variables.Count - Constants > 0 then
  begin
    Result += 'var' + CRLF;
    BeginIndention;
    for var Variable in Variables do
      if not Variable.IsConst then
        Result := Result + Variable.AsCode;
    EndIndention;
    Result += CRLF;
  end;

  for var Namespace in Namespaces do
    Result += Namespace.AsCode;

  Result += CRLF;

  EndNameSpace;
end;

end.