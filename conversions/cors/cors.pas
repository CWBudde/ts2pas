unit Cors;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: cors
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  StaticOrigin = Variant;

  CustomOrigin = procedure;

  CorsRequest = interface
    property method: String;
    property headers: IncomingHttpHeaders;
  end;

  CorsOptions = interface
    property origin: Variant;
    property methods: Variant;
    property allowedHeaders: Variant;
    property exposedHeaders: Variant;
    property credentials: Boolean;
    property maxAge: Float;
    property preflightContinue: Boolean;
    property optionsSuccessStatus: Float;
  end;

  CorsOptionsDelegate = procedure;

  function e(options?: Variant): procedure;

implementation



end.
