unit Express_session;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: express-session
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  SessionStore = Variant;

  Request = interface
    property session: Variant;
    property sessionID: String;
    property sessionStore: SessionStore;
  end;

  function session(options?: session.SessionOptions): express.RequestHandler;

  SessionOptions = interface
    property secret: Variant;
    function genid(req: express.Request): String;
    property name: String;
    property store: Store;
    property cookie: CookieOptions;
    property rolling: Boolean;
    property resave: Boolean;
    property proxy: Boolean;
    property saveUninitialized: Boolean;
    property unset: Variant;
  end;

  Session = class external
    procedure Create(request: Express.Request; data: SessionData);
    property id: String;
    property cookie: Cookie;
    function regenerate(callback: procedure): Variant;
    function destroy(callback: procedure): Variant;
    function reload(callback: procedure): Variant;
    function resetMaxAge: Variant;
    function save(callback?: procedure): Variant;
    function touch: Variant;
  end;

  SessionData = interface
    property cookie: Cookie;
  end;

  CookieOptions = interface
    property maxAge: Float;
    property partitioned: Boolean;
    property priority: Variant;
    property signed: Boolean;
    property expires: Date;
    property httpOnly: Boolean;
    property path: String;
    property domain: String;
    property secure: Variant;
    property encode: function: String;
    property sameSite: Variant;
  end;

  Cookie = class(CookieOptions) external
    property originalMaxAge: Float;
    property maxAge: Float;
    property signed: Boolean;
    property expires: Date;
    property httpOnly: Boolean;
    property path: String;
    property domain: String;
    property secure: Variant;
    property sameSite: Variant;
  end;

  Store = class(EventEmitter) external
    procedure regenerate(req: express.Request; callback: function: Variant);
    procedure load(sid: String; callback: function: Variant);
    function createSession(req: express.Request; session: SessionData): Variant;
    procedure get(sid: String; callback: procedure);
    procedure set(sid: String; session: SessionData; callback?: procedure);
    procedure destroy(sid: String; callback?: procedure);
    procedure all(callback: procedure);
    procedure length(callback: procedure);
    procedure clear(callback?: procedure);
    procedure touch(sid: String; session: SessionData; callback?: procedure);
  end;

  MemoryStore = class(Store) external
    procedure get(sid: String; callback: procedure);
    procedure set(sid: String; session: SessionData; callback?: procedure);
    procedure destroy(sid: String; callback?: procedure);
    procedure all(callback: procedure);
    procedure length(callback: procedure);
    procedure clear(callback?: procedure);
    procedure touch(sid: String; session: SessionData; callback?: procedure);
  end;

implementation



end.
