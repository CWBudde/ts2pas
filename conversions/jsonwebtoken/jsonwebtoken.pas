unit Jsonwebtoken;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: jsonwebtoken
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  JsonWebTokenError = class(Error) external
    property inner: Error;
    procedure Create(message: String; error?: Error);
  end;

  TokenExpiredError = class(JsonWebTokenError) external
    property expiredAt: Date;
    procedure Create(message: String; expiredAt: Date);
  end;

  NotBeforeError = class(JsonWebTokenError) external
    property date: Date;
    procedure Create(message: String; date: Date);
  end;

  SignOptions = interface
    property algorithm: Algorithm;
    property keyid: String;
    property expiresIn: Variant;
    property notBefore: Variant;
    property audience: Variant;
    property subject: String;
    property issuer: String;
    property jwtid: String;
    property mutatePayload: Boolean;
    property noTimestamp: Boolean;
    property header: JwtHeader;
    property encoding: String;
    property allowInsecureKeySizes: Boolean;
    property allowInvalidAsymmetricKeyTypes: Boolean;
  end;

  VerifyOptions = interface
    property algorithms: array of Algorithm;
    property audience: Variant;
    property clockTimestamp: Float;
    property clockTolerance: Float;
    property complete: Boolean;
    property issuer: Variant;
    property ignoreExpiration: Boolean;
    property ignoreNotBefore: Boolean;
    property jwtid: String;
    property nonce: String;
    property subject: String;
    property maxAge: Variant;
    property allowInvalidAsymmetricKeyTypes: Boolean;
  end;

  DecodeOptions = interface
    property complete: Boolean;
    property json: Boolean;
  end;

  VerifyErrors = Variant;

  VerifyCallback = procedure;

  SignCallback = procedure;

  JwtHeader = interface
    property alg: Variant;
    property typ: String;
    property cty: String;
    property crit: array of Variant;
    property kid: String;
    property jku: String;
    property x5u: Variant;
    property x5t: String;
    property x5c: Variant;
  end;

  JwtPayload = interface
    property iss: String;
    property sub: String;
    property aud: Variant;
    property exp: Float;
    property nbf: Float;
    property iat: Float;
    property jti: String;
  end;

  Jwt = interface
    property header: JwtHeader;
    property payload: Variant;
    property signature: String;
  end;

  Algorithm = String;

  SigningKeyCallback = procedure;

  GetPublicKeyOrSecret = procedure;

  PublicKey = Variant;

  PrivateKey = Variant;

  Secret = Variant;

  function sign(payload: Variant; secretOrPrivateKey: Variant; options?: SignOptions): String;

  function sign(payload: Variant; secretOrPrivateKey: Variant; options?: Variant): String;

  procedure sign(payload: Variant; secretOrPrivateKey: Variant; callback: SignCallback);

  procedure sign(payload: Variant; secretOrPrivateKey: Variant; options: SignOptions; callback: SignCallback);

  procedure sign(payload: Variant; secretOrPrivateKey: Variant; options: Variant; callback: SignCallback);

  function verify(token: String; secretOrPublicKey: Variant; options: Variant): Jwt;

  function verify(token: String; secretOrPublicKey: Variant; options?: Variant): Variant;

  function verify(token: String; secretOrPublicKey: Variant; options?: VerifyOptions): Variant;

  procedure verify(token: String; secretOrPublicKey: Variant; callback?: VerifyCallback<Variant>);

  procedure verify(token: String; secretOrPublicKey: Variant; options: Variant; callback?: VerifyCallback<Jwt>);

  procedure verify(token: String; secretOrPublicKey: Variant; options?: Variant; callback?: VerifyCallback<Variant>);

  procedure verify(token: String; secretOrPublicKey: Variant; options?: VerifyOptions; callback?: VerifyCallback);

  function decode(token: String; options: Variant): Jwt;

  function decode(token: String; options: Variant): JwtPayload;

  function decode(token: String; options?: DecodeOptions): Variant;

implementation



end.
