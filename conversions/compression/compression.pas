unit Compression;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: compression
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Response = interface
    procedure flush;
  end;

  function compression(options?: compression.CompressionOptions): express.RequestHandler;

  function filter(req: express.Request; res: express.Response): Boolean;

  CompressionFilter = interface
  end;

  CompressionOptions = interface
    property chunkSize: Float;
    property filter: CompressionFilter;
    property brotli: zlib.BrotliOptions;
    property enforceEncoding: String;
    property level: Float;
    property memLevel: Float;
    property strategy: Float;
    property threshold: Variant;
    property windowBits: Float;
  end;

implementation



end.
