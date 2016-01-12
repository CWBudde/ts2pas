unit ts2pas.Expressions;

interface

const
  CRLF = #13#10;

type
  TVisibility = (vPublic, vProtected, vPrivate);

  IExpressionOwner = interface
  end;

  TCustomExpression = class
  private
    FOwner: IExpressionOwner;
    class var IndentionLevel: Integer;
  protected
    function GetAsCode: String; virtual; abstract;

    class procedure BeginIndention;
    class procedure EndIndention;
    class function GetIndentionString: String;
  public
    constructor Create(Owner: IExpressionOwner); virtual;

    property AsCode: String read GetAsCode;
  end;

  TNamedExpression = class(TCustomExpression)
  public
    property Name: String;
  end;

  TCustomType = class(TCustomExpression)
  protected
    function GetName: String; virtual; abstract;
    function GetAsCode: String; override;
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

  TFunctionParameter = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TCustomType;
    property Nullable: Boolean;
  end;

  TFunctionType = class(TCustomType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
  public
    property Name: String read GetName;
    property ResultType: TCustomType;
    property Parameters: array of TFunctionParameter;
  end;

  TObjectType = class(TCustomType)
  protected
    function GetName: String; override;
    function GetAsCode: String; override;
  end;

  TNamedType = class(TCustomType)
  private
    FName: String;
  protected
    function GetName: String; override;
  public
    constructor Create(Owner: IExpressionOwner; AName: String); reintroduce;
    property Name: String read GetName;
  end;

  TDefinitionExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  end;

  TEnumerationItem = class(TCustomExpression)
  protected
    function GetAsCode: String; override;
  public
    property Name: String;
    property Value: String;
  end;

  TEnumerationExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property Items: array of TEnumerationItem;
  end;

  TFunctionExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TFunctionType;
  end;

  TCustomStructureMember = class(TNamedExpression)
  public
    constructor Create(Owner: IExpressionOwner); override;

    property Visibility: TVisibility;
    property IsStatic: Boolean;
  end;

  TFieldExpression = class(TCustomStructureMember)
  protected
    function GetAsCode: String; override;
  public
    property Nullable: Boolean;
    property &Type: TCustomType;
  end;

  TMethodExpression = class(TCustomStructureMember)
  protected
    function GetAsCode: String; override;
  public
    property &Type: TFunctionType;
  end;

  TStructureExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property Extends: array of String;
    property Implements: array of String;
    property Members: array of TCustomStructureMember;
  end;

  TInterfaceExpression = class(TStructureExpression);
  TClassExpression = class(TStructureExpression);

  TImportExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
  end;

  TVariableExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
  end;

  TModuleExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property Classes: array of TClassExpression;
    property Interfaces: array of TInterfaceExpression;
    property Variables: array of TVariableExpression;
  end;

  TDeclarationExpression = class(TNamedExpression)
  protected
    function GetAsCode: String; override;
  public
    property Classes: array of TClassExpression;
    property Functions: array of TFunctionExpression;
    property Interfaces: array of TInterfaceExpression;
    property Modules: array of TModuleExpression;
    property Variables: array of TVariableExpression;
  end;

implementation

uses
  NodeJS.Core;


{ TCustomExpression }

constructor TCustomExpression.Create(Owner: IExpressionOwner);
begin
  FOwner := Owner;
end;

class procedure TCustomExpression.BeginIndention;
begin
  Inc(IndentionLevel);
end;

class procedure TCustomExpression.EndIndention;
begin
  Dec(IndentionLevel);
end;

class function TCustomExpression.GetIndentionString: String;
begin
  Result := DupeString('  ', IndentionLevel);
end;


{ TCustomType }

function TCustomType.GetAsCode: String;
begin
  Result := Name;
  if isArray then
    Result := 'array of ' + Result;
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

constructor TNamedType.Create(Owner: IExpressionOwner; AName: String);
begin
  inherited Create(Owner);

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

function TObjectType.GetAsCode: String;
begin
  Result := '{ object definition placeholder }';
end;


{ TDeclarationExpression }

function TDeclarationExpression.GetAsCode: String;
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


{ TDefinitionExpression }

function TDefinitionExpression.GetAsCode: String;
begin

end;


{ TEnumerationItem }

function TEnumerationItem.GetAsCode: String;
begin

end;


{ TEnumerationExpression }

function TEnumerationExpression.GetAsCode: String;
begin

end;


{ TFunctionExpression }

function TFunctionExpression.GetAsCode: String;
begin
  Result := &Type.AsCode;
end;


{ TFieldExpression }

function TFieldExpression.GetAsCode: String;
begin
  Result := GetIndentionString + Name + ': ' + &Type.AsCode + ';';
  if Nullable then
    Result += ' // nullable';

  // line break
  Result += CRLF;
end;


{ TMethodExpression }

function TMethodExpression.GetAsCode: String;
begin
  Result := GetIndentionString + 'function ' + Name;

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


{ TCustomStructureMember }

constructor TCustomStructureMember.Create(Owner: IExpressionOwner);
begin
  inherited Create(Owner);
  Visibility := vPublic;
end;


{ TStructureExpression }

function TStructureExpression.GetAsCode: String;
begin
  Result := GetIndentionString;
  Result += 'J' + Name + ' = class external ''' + Name + '''';
  for var Extend in Extends do
    Result += ' // extends ' + Extend;

  Result += CRLF;
  BeginIndention;
  for var Member in Members do
    Result += Member.AsCode;
  EndIndention;
  Result += GetIndentionString + 'end;';

  // line breaks
  Result += CRLF + CRLF;
end;


{ TImportExpression }

function TImportExpression.GetAsCode: String;
begin

end;


{ TVariableExpression }

function TVariableExpression.GetAsCode: String;
begin

end;


{ TModuleExpression }

function TModuleExpression.GetAsCode: String;
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

end.
