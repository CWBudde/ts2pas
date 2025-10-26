unit Request;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: request
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  RequestAPI = interface
    function defaults(options: TOptions): RequestAPI<TRequest, TOptions, RequiredUriUrl>;
    function defaults(options: Variant): DefaultUriUrlRequestApi<TRequest, TOptions, OptionalUriUrl>;
    function get(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function get(uri: String; callback?: RequestCallback): TRequest;
    function get(options: Variant; callback?: RequestCallback): TRequest;
    function post(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function post(uri: String; callback?: RequestCallback): TRequest;
    function post(options: Variant; callback?: RequestCallback): TRequest;
    function put(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function put(uri: String; callback?: RequestCallback): TRequest;
    function put(options: Variant; callback?: RequestCallback): TRequest;
    function head(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function head(uri: String; callback?: RequestCallback): TRequest;
    function head(options: Variant; callback?: RequestCallback): TRequest;
    function patch(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function patch(uri: String; callback?: RequestCallback): TRequest;
    function patch(options: Variant; callback?: RequestCallback): TRequest;
    function del(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function del(uri: String; callback?: RequestCallback): TRequest;
    function del(options: Variant; callback?: RequestCallback): TRequest;
    function delete(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function delete(uri: String; callback?: RequestCallback): TRequest;
    function delete(options: Variant; callback?: RequestCallback): TRequest;
    function initParams(uri: String; options?: TOptions; callback?: RequestCallback): Variant;
    function initParams(uriOrOpts: String; callback?: RequestCallback): Variant;
    function forever(agentOptions: Variant; optionsArg: Variant): TRequest;
    function jar(store?: Variant): CookieJar;
    function cookie(str: String): Cookie;
    property debug: Boolean;
  end;

  DefaultUriUrlRequestApi = interface(RequestAPI)
    function defaults(options: TOptions): DefaultUriUrlRequestApi<TRequest, TOptions, OptionalUriUrl>;
    function get(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function get(uri: String; callback?: RequestCallback): TRequest;
    function get(options: Variant; callback?: RequestCallback): TRequest;
    function get(callback?: RequestCallback): TRequest;
    function post(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function post(uri: String; callback?: RequestCallback): TRequest;
    function post(options: Variant; callback?: RequestCallback): TRequest;
    function post(callback?: RequestCallback): TRequest;
    function put(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function put(uri: String; callback?: RequestCallback): TRequest;
    function put(options: Variant; callback?: RequestCallback): TRequest;
    function put(callback?: RequestCallback): TRequest;
    function head(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function head(uri: String; callback?: RequestCallback): TRequest;
    function head(options: Variant; callback?: RequestCallback): TRequest;
    function head(callback?: RequestCallback): TRequest;
    function patch(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function patch(uri: String; callback?: RequestCallback): TRequest;
    function patch(options: Variant; callback?: RequestCallback): TRequest;
    function patch(callback?: RequestCallback): TRequest;
    function del(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function del(uri: String; callback?: RequestCallback): TRequest;
    function del(options: Variant; callback?: RequestCallback): TRequest;
    function del(callback?: RequestCallback): TRequest;
    function delete(uri: String; options?: TOptions; callback?: RequestCallback): TRequest;
    function delete(uri: String; callback?: RequestCallback): TRequest;
    function delete(options: Variant; callback?: RequestCallback): TRequest;
    function delete(callback?: RequestCallback): TRequest;
  end;

  CoreOptions = interface
    property baseUrl: String;
    property callback: RequestCallback;
    property jar: Variant;
    property formData: Variant;
    property form: String;
    property auth: AuthOptions;
    property oauth: OAuthOptions;
    property aws: AWSOptions;
    property hawk: HawkOptions;
    property qs: Variant;
    property qsStringifyOptions: Variant;
    property qsParseOptions: Variant;
    property json: Variant;
    property jsonReviver: function: Variant;
    property jsonReplacer: function: Variant;
    property multipart: Variant;
    property agent: Variant;
    property agentOptions: Variant;
    property agentClass: Variant;
    property forever: Variant;
    property host: String;
    property port: Float;
    property method: String;
    property headers: Headers;
    property body: Variant;
    property family: Variant;
    property followRedirect: Variant;
    property followAllRedirects: Boolean;
    property followOriginalHttpMethod: Boolean;
    property maxRedirects: Float;
    property removeRefererHeader: Boolean;
    property encoding: String;
    property pool: PoolOptions;
    property timeout: Float;
    property localAddress: String;
    property proxy: Variant;
    property tunnel: Boolean;
    property strictSSL: Boolean;
    property rejectUnauthorized: Boolean;
    property time: Boolean;
    property gzip: Boolean;
    property preambleCRLF: Boolean;
    property postambleCRLF: Boolean;
    property withCredentials: Boolean;
    property key: Buffer;
    property cert: Buffer;
    property passphrase: String;
    property ca: Variant;
    property har: HttpArchiveRequest;
    property useQuerystring: Boolean;
  end;

  UriOptions = interface
    property uri: Variant;
  end;

  UrlOptions = interface
    property url: Variant;
  end;

  RequiredUriUrl = Variant;

  OptionalUriUrl = RequiredUriUrl;

  OptionsWithUri = Variant;

  OptionsWithUrl = Variant;

  Options = Variant;

  MultipartBody = Variant;

  RequestCallback = procedure;

  HttpArchiveRequest = interface
    property url: String;
    property method: String;
    property headers: array of NameValuePair;
    property postData: Variant;
  end;

  ExtraPoolOptions = interface
    property maxSockets: Float;
  end;

  PoolOptions = Variant;

  NameValuePair = interface
    property name: String;
    property value: String;
  end;

  Multipart = interface
    property chunked: Boolean;
    property data: array of Variant;
  end;

  RequestPart = interface
    property headers: Headers;
    property body: Variant;
  end;

  Request = interface(caseless.Httpified, stream.Stream)
    property readable: Boolean;
    property writable: Boolean;
    property explicitMethod: Boolean;
    procedure debug(args: array of Variant);
    procedure pipeDest(dest: Variant);
    function qs(q: Variant; clobber?: Boolean): Request;
    function form: FormData;
    function form(form: Variant): Request;
    function multipart(multipart: array of RequestPart): Request;
    function json(val: Variant): Request;
    function aws(opts: AWSOptions; now?: Boolean): Request;
    procedure hawk(opts: HawkOptions);
    function auth(username: String; password: String; sendImmediately?: Boolean; bearer?: String): Request;
    function oauth(oauth: OAuthOptions): Request;
    function jar(jar: CookieJar): Request;
    function on(event: String; listener: procedure): Variant;
    function write(buffer: Variant; cb?: procedure): Boolean;
    function write(str: String; encoding?: String; cb?: procedure): Boolean;
    function end(cb?: procedure): Variant;
    function end(chunk: Variant; cb?: procedure): Variant;
    function end(str: String; encoding?: String; cb?: procedure): Variant;
    procedure pause;
    procedure resume;
    procedure abort;
    procedure destroy;
    function toJSON: RequestAsJSON;
    property host: String;
    property port: Float;
    property followAllRedirects: Boolean;
    property followOriginalHttpMethod: Boolean;
    property maxRedirects: Float;
    property removeRefererHeader: Boolean;
    property encoding: String;
    property timeout: Float;
    property localAddress: String;
    property strictSSL: Boolean;
    property rejectUnauthorized: Boolean;
    property time: Boolean;
    property gzip: Boolean;
    property preambleCRLF: Boolean;
    property postambleCRLF: Boolean;
    property withCredentials: Boolean;
    property key: Buffer;
    property cert: Buffer;
    property passphrase: String;
    property ca: Variant;
    property har: HttpArchiveRequest;
    property headers: Headers;
    property method: String;
    property pool: PoolOptions;
    property dests: array of stream.Readable;
    property callback: RequestCallback;
    property uri: Variant;
    property proxy: Variant;
    property tunnel: Boolean;
    property setHost: Boolean;
    property path: String;
    property agent: Variant;
    property body: Variant;
    property timing: Boolean;
    property src: stream.Readable;
    property href: String;
    property startTime: Float;
    property startTimeNow: Float;
    property timings: Variant;
    property elapsedTime: Float;
    property response: Response;
  end;

  Response = interface(http.IncomingMessage)
    property statusCode: Float;
    property statusMessage: String;
    property request: Request;
    property body: Variant;
    property caseless: caseless.Caseless;
    function toJSON: ResponseAsJSON;
    property timingStart: Float;
    property elapsedTime: Float;
    property timings: Variant;
    property timingPhases: Variant;
  end;

  ResponseRequest = Request;

  RequestResponse = Response;

  Headers = interface
  end;

  AuthOptions = interface
    property user: String;
    property username: String;
    property pass: String;
    property password: String;
    property sendImmediately: Boolean;
    property bearer: Variant;
  end;

  OAuthOptions = interface
    property callback: String;
    property consumer_key: String;
    property consumer_secret: String;
    property token: String;
    property token_secret: String;
    property transport_method: Variant;
    property verifier: String;
    property body_hash: Variant;
  end;

  HawkOptions = interface
    property credentials: Variant;
  end;

  AWSOptions = interface
    property secret: String;
    property bucket: String;
  end;

  RequestAsJSON = interface
    property uri: Url;
    property method: String;
    property headers: Headers;
  end;

  ResponseAsJSON = interface
    property statusCode: Float;
    property body: Variant;
    property headers: Headers;
    property request: RequestAsJSON;
  end;

  Cookie = tough.Cookie;

  CookieJar = interface
    procedure setCookie(cookieOrStr: Variant; uri: Variant; options?: tough.CookieJar.SetCookieOptions);
    function getCookieString(uri: Variant): String;
    function getCookies(uri: Variant): array of Cookie;
  end;

implementation



end.
