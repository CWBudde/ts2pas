unit Cookie_parser;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: cookie-parser
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Request = interface
    property secret: String;
    property cookies: Variant;
    property signedCookies: Variant;
  end;

  function cookieParser(secret?: Variant; options?: cookieParser.CookieParseOptions): express.RequestHandler;

  CookieParseOptions = interface
    function decode(val: String): String;
  end;

  function JSONCookie(jsonCookie: String): Variant;

  function JSONCookies(jsonCookies: T): Variant;

  function signedCookie(cookie: String; secret: Variant): Variant;

  function signedCookies(cookies: T; secret: Variant): Variant;

implementation



end.
