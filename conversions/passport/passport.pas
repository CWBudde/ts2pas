unit Passport;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: passport
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  AuthInfo = interface
  end;

  User = interface
  end;

  Request = interface
    property authInfo: AuthInfo;
    property user: User;
    procedure login(user: User; done: procedure);
    procedure login(user: User; options: passport.LogInOptions; done: procedure);
    procedure logIn(user: User; done: procedure);
    procedure logIn(user: User; options: passport.LogInOptions; done: procedure);
    procedure logout(options: passport.LogOutOptions; done: procedure);
    procedure logout(done: procedure);
    procedure logOut(options: passport.LogOutOptions; done: procedure);
    procedure logOut(done: procedure);
    function isAuthenticated: Variant;
    function isUnauthenticated: Variant;
  end;

  AuthenticatedRequest = interface(Request)
    property user: User;
  end;

  UnauthenticatedRequest = interface(Request)
    property user: Variant;
  end;

  DoneCallback = procedure;

  DeserializeUserFunction = procedure;

  AuthenticateCallback = function: Variant;

  AuthorizeCallback = AuthenticateCallback;

  AuthenticateOptions = interface
    property authInfo: Boolean;
    property assignProperty: String;
    property failureFlash: Variant;
    property failureMessage: Variant;
    property failureRedirect: String;
    property failWithError: Boolean;
    property keepSessionInfo: Boolean;
    property session: Boolean;
    property scope: Variant;
    property successFlash: Variant;
    property successMessage: Variant;
    property successRedirect: String;
    property successReturnToOrRedirect: String;
    property state: String;
    property pauseStream: Boolean;
    property userProperty: String;
    property passReqToCallback: Boolean;
    property prompt: String;
  end;

  InitializeOptions = interface
    property userProperty: String;
    property compat: Boolean;
  end;

  SessionOptions = interface
    property pauseStream: Boolean;
  end;

  SessionStrategyOptions = interface
    property key: String;
  end;

  LogInOptions = interface(LogOutOptions)
    property session: Boolean;
  end;

  LogOutOptions = interface
    property keepSessionInfo: Boolean;
  end;

  StrategyFailure = interface
    property message: String;
  end;

  Authenticator = interface
    function use(strategy: Strategy): Variant;
    function use(name: String; strategy: Strategy): Variant;
    function unuse(name: String): Variant;
    function framework(fw: Framework<X, Y, Z>): Authenticator<X, Y, Z>;
    function initialize(options?: InitializeOptions): InitializeRet;
    function session(options?: SessionOptions): AuthenticateRet;
    function authenticate(strategy: Variant; callback?: Variant): AuthenticateRet;
    function authenticate(strategy: Variant; options: AuthenticateOptions; callback?: Variant): AuthenticateRet;
    function authorize(strategy: Variant; callback?: Variant): AuthorizeRet;
    function authorize(strategy: Variant; options: AuthorizeOptions; callback?: Variant): AuthorizeRet;
    procedure serializeUser(fn: procedure);
    procedure serializeUser(user: User; req: Request; done: function: Variant);
    procedure serializeUser(user: User; done: function: Variant);
    procedure deserializeUser(fn: procedure);
    procedure deserializeUser(serializedUser: NonNullable<Variant>; req: Request; done: function: Variant);
    procedure deserializeUser(serializedUser: NonNullable<Variant>; done: function: Variant);
    procedure transformAuthInfo(fn: procedure);
    procedure transformAuthInfo(info: Variant; req: Request; done: function: Variant);
    procedure transformAuthInfo(info: Variant; done: function: Variant);
  end;

  PassportStatic = interface(Authenticator)
    property Authenticator: Variant;
    property Passport: Variant;
    property Strategy: Variant;
    property strategies: Variant;
  end;

  Strategy = interface
    property name: String;
    function authenticate(this: StrategyCreated<Variant>; req: express.Request; options?: Variant): Variant;
  end;

  SessionStrategy = interface(Strategy)
    property name: String;
    procedure authenticate(req: IncomingMessage; options?: Pick<AuthenticateOptions, String>);
  end;

  StrategyCreatedStatic = interface
    procedure success(user: Express.User; info?: Variant);
    procedure fail(challenge?: Variant; status?: Float);
    procedure redirect(url: String; status?: Float);
    procedure pass;
    procedure error(err: Variant);
  end;

  StrategyCreated = Variant;

  Profile = interface
    property provider: String;
    property id: String;
    property displayName: String;
    property username: String;
    property name: Variant;
    property emails: array of Variant;
    property photos: array of Variant;
  end;

  Framework = interface
    function initialize(passport: Authenticator<InitializeRet, AuthenticateRet, AuthorizeRet>; options?: Variant): function: InitializeRet;
    function authenticate(passport: Authenticator<InitializeRet, AuthenticateRet, AuthorizeRet>; name: String; options?: Variant; callback?: function: Variant): function: AuthenticateRet;
    function authorize(passport: Authenticator<InitializeRet, AuthenticateRet, AuthorizeRet>; name: String; options?: Variant; callback?: function: Variant): function: AuthorizeRet;
  end;

implementation



end.
