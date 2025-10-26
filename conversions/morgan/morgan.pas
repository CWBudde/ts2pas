unit Morgan;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: morgan
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Handler = procedure;

  FormatFn = function: String;

  TokenCallbackFn = function: String;

  TokenIndexer = interface
  end;

  Morgan = interface
    function token(name: String; callback: TokenCallbackFn<Request, Response>): Morgan<Request, Response>;
    function format(name: String; fmt: String): Morgan<Request, Response>;
    function format(name: String; fmt: FormatFn<Request, Response>): Morgan<Request, Response>;
    function compile(format: String): FormatFn<Request, Response>;
  end;

  function token(name: String; callback: TokenCallbackFn<Request, Response>): Morgan<Request, Response>;

  function format(name: String; fmt: String): Morgan<Request, Response>;

  function format(name: String; fmt: FormatFn<Request, Response>): Morgan<Request, Response>;

  function compile(format: String): FormatFn<Request, Response>;

  StreamOptions = interface
    procedure write(str: String);
  end;

  Options = interface
    property buffer: Boolean;
    property immediate: Boolean;
    function skip(req: Request; res: Response): Boolean;
    property stream: StreamOptions;
  end;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: String; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

  function morgan(format: morgan.FormatFn<Request, Response>; options?: morgan.Options<Request, Response>): Handler<Request, Response>;

implementation



end.
