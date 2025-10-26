unit Passport_local;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: passport-local
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  IStrategyOptions = interface
    property usernameField: String;
    property passwordField: String;
    property session: Boolean;
    property passReqToCallback: Boolean;
  end;

  IStrategyOptionsWithRequest = interface
    property usernameField: String;
    property passwordField: String;
    property session: Boolean;
    property passReqToCallback: Boolean;
  end;

  IVerifyOptions = interface
    property message: String;
  end;

  VerifyFunctionWithRequest = interface
  end;

  VerifyFunction = interface
  end;

  Strategy = class(PassportStrategy) external
    procedure Create(options: IStrategyOptionsWithRequest; verify: VerifyFunctionWithRequest);
    procedure Create(options: IStrategyOptions; verify: VerifyFunction);
    procedure Create(verify: VerifyFunction);
    property name: String;
  end;

implementation



end.
