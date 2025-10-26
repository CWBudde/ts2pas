unit Json_schema;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: json-schema
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  JSONSchema4TypeName = String;

  JSONSchema4Type = Variant;

  JSONSchema4Object = interface
  end;

  JSONSchema4Array = interface(Array)
  end;

  JSONSchema4Version = String;

  JSONSchema4 = interface
    property id: String;
    property $ref: String;
    property $schema: JSONSchema4Version;
    property title: String;
    property description: String;
    property default: JSONSchema4Type;
    property multipleOf: Float;
    property maximum: Float;
    property exclusiveMaximum: Boolean;
    property minimum: Float;
    property exclusiveMinimum: Boolean;
    property maxLength: Float;
    property minLength: Float;
    property pattern: String;
    property additionalItems: Variant;
    property items: Variant;
    property maxItems: Float;
    property minItems: Float;
    property uniqueItems: Boolean;
    property maxProperties: Float;
    property minProperties: Float;
    property required: Variant;
    property additionalProperties: Variant;
    property definitions: Variant;
    property properties: Variant;
    property patternProperties: Variant;
    property dependencies: Variant;
    property enum: array of JSONSchema4Type;
    property type: Variant;
    property allOf: array of JSONSchema4;
    property anyOf: array of JSONSchema4;
    property oneOf: array of JSONSchema4;
    property not: JSONSchema4;
    property extends: Variant;
    property format: String;
  end;

  JSONSchema6TypeName = String;

  JSONSchema6Type = Variant;

  JSONSchema6Object = interface
  end;

  JSONSchema6Array = interface(Array)
  end;

  JSONSchema6Version = String;

  JSONSchema6Definition = Variant;

  JSONSchema6 = interface
    property $id: String;
    property $ref: String;
    property $schema: JSONSchema6Version;
    property multipleOf: Float;
    property maximum: Float;
    property exclusiveMaximum: Float;
    property minimum: Float;
    property exclusiveMinimum: Float;
    property maxLength: Float;
    property minLength: Float;
    property pattern: String;
    property items: Variant;
    property additionalItems: JSONSchema6Definition;
    property maxItems: Float;
    property minItems: Float;
    property uniqueItems: Boolean;
    property contains: JSONSchema6Definition;
    property maxProperties: Float;
    property minProperties: Float;
    property required: array of String;
    property properties: Variant;
    property patternProperties: Variant;
    property additionalProperties: JSONSchema6Definition;
    property dependencies: Variant;
    property propertyNames: JSONSchema6Definition;
    property enum: array of JSONSchema6Type;
    property const: JSONSchema6Type;
    property type: Variant;
    property allOf: array of JSONSchema6Definition;
    property anyOf: array of JSONSchema6Definition;
    property oneOf: array of JSONSchema6Definition;
    property not: JSONSchema6Definition;
    property definitions: Variant;
    property title: String;
    property description: String;
    property default: JSONSchema6Type;
    property examples: array of JSONSchema6Type;
    property format: String;
  end;

  JSONSchema7TypeName = String;

  JSONSchema7Type = Variant;

  JSONSchema7Object = interface
  end;

  JSONSchema7Array = interface(Array)
  end;

  JSONSchema7Version = String;

  JSONSchema7Definition = Variant;

  JSONSchema7 = interface
    property $id: String;
    property $ref: String;
    property $schema: JSONSchema7Version;
    property $comment: String;
    property $defs: Variant;
    property type: Variant;
    property enum: array of JSONSchema7Type;
    property const: JSONSchema7Type;
    property multipleOf: Float;
    property maximum: Float;
    property exclusiveMaximum: Float;
    property minimum: Float;
    property exclusiveMinimum: Float;
    property maxLength: Float;
    property minLength: Float;
    property pattern: String;
    property items: Variant;
    property additionalItems: JSONSchema7Definition;
    property maxItems: Float;
    property minItems: Float;
    property uniqueItems: Boolean;
    property contains: JSONSchema7Definition;
    property maxProperties: Float;
    property minProperties: Float;
    property required: array of String;
    property properties: Variant;
    property patternProperties: Variant;
    property additionalProperties: JSONSchema7Definition;
    property dependencies: Variant;
    property propertyNames: JSONSchema7Definition;
    property if: JSONSchema7Definition;
    property then: JSONSchema7Definition;
    property else: JSONSchema7Definition;
    property allOf: array of JSONSchema7Definition;
    property anyOf: array of JSONSchema7Definition;
    property oneOf: array of JSONSchema7Definition;
    property not: JSONSchema7Definition;
    property format: String;
    property contentMediaType: String;
    property contentEncoding: String;
    property definitions: Variant;
    property title: String;
    property description: String;
    property default: JSONSchema7Type;
    property readOnly: Boolean;
    property writeOnly: Boolean;
    property examples: JSONSchema7Type;
  end;

  ValidationResult = interface
    property valid: Boolean;
    property errors: array of ValidationError;
  end;

  ValidationError = interface
    property property: String;
    property message: String;
  end;

  function validate(instance: Variant; schema: Variant): ValidationResult;

  function checkPropertyChange(value: Variant; schema: Variant; property: String): ValidationResult;

  procedure mustBeValid(result: ValidationResult);

implementation



end.
