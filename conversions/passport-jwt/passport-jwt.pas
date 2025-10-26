unit Passport_jwt;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: passport-jwt
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Strategy = class(PassportStrategy) external
    procedure Create(opt: StrategyOptionsWithoutRequest; verify: VerifyCallback);
    procedure Create(opt: StrategyOptionsWithRequest; verify: VerifyCallbackWithRequest);
    property name: String;
  end;

  SecretOrKeyProvider = interface
  end;

  BaseStrategyOptions = interface
    property jwtFromRequest: JwtFromRequestFunction;
    property issuer: Variant;
    property audience: Variant;
    property algorithms: array of Algorithm;
    property ignoreExpiration: Boolean;
    property jsonWebTokenOptions: VerifyOptions;
  end;

  WithSecretOrKeyProvider = interface(BaseStrategyOptions)
    property secretOrKeyProvider: SecretOrKeyProvider;
  end;

  WithSecretOrKey = interface(BaseStrategyOptions)
    property secretOrKey: Variant;
  end;

  StrategyOptionsWithSecret = Variant;

  StrategyOptionsWithRequest = Variant;

  StrategyOptionsWithoutRequest = Variant;

  StrategyOptions = Variant;

  VerifyCallback = procedure;

  VerifyCallbackWithRequest = procedure;

  VerifiedCallback = interface
  end;

  JwtFromRequestFunction = interface
  end;

  function fromHeader(header_name: String): JwtFromRequestFunction;

  function fromBodyField(field_name: String): JwtFromRequestFunction;

  function fromUrlQueryParameter(param_name: String): JwtFromRequestFunction;

  function fromAuthHeaderWithScheme(auth_scheme: String): JwtFromRequestFunction;

  function fromExtractors(extractors: array of JwtFromRequestFunction<T>): JwtFromRequestFunction<T>;

  function fromAuthHeaderAsBearerToken: JwtFromRequestFunction;

implementation



end.
