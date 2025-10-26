unit Cordova;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: cordova
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Cordova = interface
    procedure exec(success: function: Variant; fail: function: Variant; service: String; action: String; args?: array of Variant);
    property platformId: String;
    property version: String;
    procedure define(moduleName: String; factory: function: Variant);
    function require(moduleName: String): Variant;
    property plugins: CordovaPlugins;
  end;

  CordovaPlugins = interface
  end;

  Document = interface
    procedure addEventListener(type: String; listener: function: Variant; useCapture?: Boolean);
    procedure removeEventListener(type: String; listener: function: Variant; useCapture?: Boolean);
  end;

  Window = interface
    property cordova: Cordova;
  end;

  ArgsCheck = interface
    procedure checkArgs(argsSpec: String; functionName: String; args: array of Variant; callee?: Variant);
    function getValue(value?: Variant; defaultValue?: Variant): Variant;
    property enableChecks: Boolean;
  end;

  UrlUtil = interface
    function makeAbsolute(url: String): String;
  end;

  Navigator = interface
    property splashscreen: Variant;
  end;

implementation



end.
