unit Yargs_parser;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: yargs-parser
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Arguments = interface
    property _: array of Variant;
  end;

  DetailedArguments = interface
    property argv: Arguments;
    property error: Error;
    property aliases: Variant;
    property newAliases: Variant;
    property configuration: Configuration;
  end;

  Configuration = interface
  end;

  Options = interface
    property alias: Variant;
    property array: Variant;
    property boolean: array of String;
    property config: Variant;
    property configuration: Configuration;
    property coerce: Variant;
    property count: array of String;
    property default: Variant;
    property envPrefix: String;
    property narg: Variant;
    property normalize: array of String;
    property string: array of String;
    property number: array of String;
  end;

  Parser = interface
    function detailed(argv: Variant; opts?: Options): DetailedArguments;
    function camelCase(str: String): String;
    function decamelize(str: String; joinString?: String): String;
    function looksLikeNumber(value: Variant): Boolean;
  end;

implementation



end.
