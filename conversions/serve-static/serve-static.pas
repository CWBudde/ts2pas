unit Serve_static;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: serve-static
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  function serveStatic(root: String; options?: serveStatic.ServeStaticOptions<R>): serveStatic.RequestHandler<R>;

  ServeStaticOptions = interface
    property acceptRanges: Boolean;
    property cacheControl: Boolean;
    property dotfiles: String;
    property etag: Boolean;
    property extensions: Variant;
    property fallthrough: Boolean;
    property immutable: Boolean;
    property index: Variant;
    property lastModified: Boolean;
    property maxAge: Variant;
    property redirect: Boolean;
    property setHeaders: function: Variant;
  end;

  RequestHandler = interface
  end;

  RequestHandlerConstructor = interface
    property mime: Variant;
  end;

implementation



end.
