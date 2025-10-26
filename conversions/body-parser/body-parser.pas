unit Body_parser;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: body-parser
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  BodyParser = interface
    function json(options?: OptionsJson): NextHandleFunction;
    function raw(options?: Options): NextHandleFunction;
    function text(options?: OptionsText): NextHandleFunction;
    function urlencoded(options?: OptionsUrlencoded): NextHandleFunction;
  end;

  Options = interface
    property inflate: Boolean;
    property limit: Variant;
    property type: Variant;
    procedure verify(req: http.IncomingMessage; res: http.ServerResponse; buf: Buffer; encoding: String);
  end;

  OptionsJson = interface(Options)
    function reviver(key: String; value: Variant): Variant;
    property strict: Boolean;
  end;

  OptionsText = interface(Options)
    property defaultCharset: String;
  end;

  OptionsUrlencoded = interface(Options)
    property extended: Boolean;
    property parameterLimit: Float;
  end;

implementation



end.
