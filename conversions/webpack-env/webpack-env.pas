unit Webpack_env;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: webpack-env
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ModuleId = Variant;

  RequireResolve = interface
  end;

  RequireContext = interface
    function keys: array of String;
    function resolve(id: String): String;
    property id: ModuleId;
  end;

  RequireFunction = interface
    procedure ensure(paths: array of String; callback: procedure; chunkName?: String);
    procedure ensure(paths: array of String; callback: procedure; errorCallback?: procedure; chunkName?: String);
    function context(path: String; deep?: Boolean; filter?: RegExp; mode?: String): RequireContext;
    property resolve: NodeJS.RequireResolve;
    function resolveWeak(path: String): ModuleId;
    procedure include(path: String);
    property cache: Variant;
  end;

  Module = interface
    property exports: Variant;
    property id: ModuleId;
    property filename: String;
    property loaded: Boolean;
    property parent: NodeJS.Module;
    property children: array of NodeJS.Module;
    property hot: Hot;
  end;

  HotNotifierInfo = interface
    property type: String;
    property moduleId: Float;
    property dependencyId: Float;
    property chain: array of Float;
    property parentId: Float;
    property outdatedModules: array of Float;
    property outdatedDependencies: Variant;
    property error: Error;
    property originalError: Error;
  end;

  Hot = interface
    procedure accept(dependencies: array of String; callback?: procedure; errorHandler?: procedure);
    procedure accept(dependency: String; callback?: procedure; errorHandler?: procedure);
    procedure accept(errHandler?: procedure);
    procedure decline(dependencies: array of String);
    procedure decline(dependency: String);
    procedure decline;
    procedure dispose(callback: procedure);
    procedure addDisposeHandler(callback: procedure);
    procedure removeDisposeHandler(callback: procedure);
    function check(autoApply?: Boolean): array of ModuleId;
    function apply(options?: AcceptOptions): array of ModuleId;
    function status: String;
    procedure status(callback: procedure);
    procedure addStatusHandler(callback: procedure);
    procedure removeStatusHandler(callback: procedure);
    property active: Boolean;
    property data: Variant;
  end;

  AcceptOptions = interface
    property ignoreUnaccepted: Boolean;
    property ignoreDeclined: Boolean;
    property ignoreErrored: Boolean;
    property onDeclined: procedure;
    property onUnaccepted: procedure;
    property onAccepted: procedure;
    property onDisposed: procedure;
    property onErrored: procedure;
    property autoApply: Boolean;
  end;

  NodeProcess = interface
    property env: Variant;
  end;

  __Require1 = function: Variant;

  __Require2 = function: T;

  RequireLambda = Variant;

  Module = Variant;

  Require = Variant;

  ImportMeta = interface
    property url: String;
    property webpack: Float;
    property webpackHot: __WebpackModuleApi.Hot;
    property webpackContext: function: __WebpackModuleApi.RequireContext;
  end;

  Module = interface(__WebpackModuleApi.Module)
  end;

  Require = interface(__WebpackModuleApi.RequireFunction)
  end;

  RequireResolve = interface(__WebpackModuleApi.RequireResolve)
  end;

  Process = interface(__WebpackModuleApi.NodeProcess)
  end;

  NodeModule = interface(__WebpackModuleApi.__NodeGlobalInterfacePolyfill.Module)
  end;

  NodeRequire = interface(__WebpackModuleApi.__NodeGlobalInterfacePolyfill.Require)
  end;

implementation



end.
