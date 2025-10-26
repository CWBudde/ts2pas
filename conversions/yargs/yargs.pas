unit Yargs;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: yargs
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  BuilderCallback = Variant;

  ParserConfigurationOptions = Variant;

  Argv = interface
    function alias(shortName: K1; longName: K2): Argv<Variant>;
    function alias(shortName: K2; longName: K1): Argv<Variant>;
    function alias(shortName: String; longName: String): Argv<T>;
    function alias(aliases: Variant): Argv<T>;
    property argv: Variant;
    function array(key: K): Argv<Variant>;
    function boolean(key: K): Argv<Variant>;
    function check(func: function: Variant; global?: Boolean): Argv<T>;
    function choices(key: K; values: C): Argv<Variant>;
    function choices(choices: C): Argv<Variant>;
    function coerce(key: K; func: function: V): Argv<Variant>;
    function coerce(opts: O): Argv<Variant>;
    function command(command: String; description: String; builder?: BuilderCallback<T, U>; handler?: function: Variant; middlewares?: array of MiddlewareFunction<U>; deprecated?: Variant): Argv<T>;
    function command(command: String; description: String; builder?: O; handler?: function: Variant; middlewares?: array of MiddlewareFunction<O>; deprecated?: Variant): Argv<T>;
    function command(command: String; description: String; module: CommandModule<T, U>): Argv<T>;
    function command(command: String; showInHelp: Boolean; builder?: BuilderCallback<T, U>; handler?: function: Variant; middlewares?: array of MiddlewareFunction<U>; deprecated?: Variant): Argv<T>;
    function command(command: String; showInHelp: Boolean; builder?: O; handler?: function: Variant): Argv<T>;
    function command(command: String; showInHelp: Boolean; module: CommandModule<T, U>): Argv<T>;
    function command(module: CommandModule<T, U>): Argv<T>;
    function command(modules: array of CommandModule<T, U>): Argv<T>;
    function commandDir(dir: String; opts?: RequireDirectoryOptions): Argv<T>;
    function completion: Argv<T>;
    function completion(cmd: String; func?: AsyncCompletionFunction): Argv<T>;
    function completion(cmd: String; func?: SyncCompletionFunction): Argv<T>;
    function completion(cmd: String; func?: PromiseCompletionFunction): Argv<T>;
    function completion(cmd: String; func?: FallbackCompletionFunction): Argv<T>;
    function completion(cmd: String; description?: Variant; func?: AsyncCompletionFunction): Argv<T>;
    function completion(cmd: String; description?: Variant; func?: SyncCompletionFunction): Argv<T>;
    function completion(cmd: String; description?: Variant; func?: PromiseCompletionFunction): Argv<T>;
    function completion(cmd: String; description?: Variant; func?: FallbackCompletionFunction): Argv<T>;
    function config: Argv<T>;
    function config(key: String; description?: String; parseFn?: function: Variant): Argv<T>;
    function config(key: String; parseFn: function: Variant): Argv<T>;
    function config(explicitConfigurationObject: Variant): Argv<T>;
    function conflicts(key: String; value: String): Argv<T>;
    function conflicts(conflicts: Variant): Argv<T>;
    function count(key: K): Argv<Variant>;
    function default(key: K; value: V; description?: String): Argv<Variant>;
    function default(defaults: D; description?: String): Argv<Variant>;
    function demand(key: K; msg?: Variant): Argv<Defined<T, K>>;
    function demand(key: K; msg?: Variant): Argv<Variant>;
    function demand(key: String; required?: Boolean): Argv<T>;
    function demand(positionals: Float; msg: String): Argv<T>;
    function demand(positionals: Float; required?: Boolean): Argv<T>;
    function demand(positionals: Float; max: Float; msg?: String): Argv<T>;
    function demandOption(key: K; msg?: Variant): Argv<Defined<T, K>>;
    function demandOption(key: K; msg?: Variant): Argv<Variant>;
    function demandOption(key: String; demand?: Boolean): Argv<T>;
    function demandCommand: Argv<T>;
    function demandCommand(min: Float; minMsg?: String): Argv<T>;
    function demandCommand(min: Float; max?: Float; minMsg?: String; maxMsg?: String): Argv<T>;
    function deprecateOption(option: String; msg?: String): Argv<T>;
    function describe(key: String; description: String): Argv<T>;
    function describe(descriptions: Variant): Argv<T>;
    function detectLocale(detect: Boolean): Argv<T>;
    function env: Argv<T>;
    function env(prefix: String): Argv<T>;
    function env(enable: Boolean): Argv<T>;
    function epilog(msg: String): Argv<T>;
    function epilogue(msg: String): Argv<T>;
    function example(command: String; description: String): Argv<T>;
    function example(command: array of array of Variant): Argv<T>;
    procedure exit(code: Float; err: Error);
    function exitProcess(enabled: Boolean): Argv<T>;
    function fail(func: Variant): Argv<T>;
    function getCompletion(args: Variant; done: procedure): Argv<T>;
    function getCompletion(args: Variant; done?: Variant): Variant;
    function getHelp: String;
    function global(key: String): Argv<T>;
    function group(key: String; groupName: String): Argv<T>;
    function hide(key: String): Argv<T>;
    function help: Argv<T>;
    function help(enableExplicit: Boolean): Argv<T>;
    function help(option: String; enableExplicit: Boolean): Argv<T>;
    function help(option: String; description?: String; enableExplicit?: Boolean): Argv<T>;
    function implies(key: String; value: String): Argv<T>;
    function implies(implies: Variant): Argv<T>;
    function locale: String;
    function locale(loc: String): Argv<T>;
    function middleware(callbacks: Variant; applyBeforeValidation?: Boolean): Argv<T>;
    function nargs(key: String; count: Float): Argv<T>;
    function nargs(nargs: Variant): Argv<T>;
    function normalize(key: K): Argv<Variant>;
    function number(key: K): Argv<Variant>;
    function onFinishCommand(func: procedure): Argv<T>;
    function option(key: K; options: O): Argv<Variant>;
    function option(options: O): Argv<Variant>;
    function options(key: K; options: O): Argv<Variant>;
    function options(options: O): Argv<Variant>;
    function parse: Variant;
    function parse(arg: String; context?: Variant; parseCallback?: ParseCallback<T>): Variant;
    function parseSync: Variant;
    function parseSync(arg: String; context?: Variant; parseCallback?: ParseCallback<T>): Variant;
    function parseAsync: Variant;
    function parseAsync(arg: String; context?: Variant; parseCallback?: ParseCallback<T>): Variant;
    property parsed: Variant;
    function parserConfiguration(configuration: ParserConfigurationOptions): Argv<T>;
    function pkgConf(key: String; cwd?: String): Argv<T>;
    function positional(key: K; opt: O): Argv<Variant>;
    function recommendCommands: Argv<T>;
    function require(key: K; msg?: Variant): Argv<Defined<T, K>>;
    function require(key: String; msg: String): Argv<T>;
    function require(key: String; required: Boolean): Argv<T>;
    function require(keys: Variant; msg: String): Argv<T>;
    function require(keys: Variant; required: Boolean): Argv<T>;
    function require(positionals: Float; required: Boolean): Argv<T>;
    function require(positionals: Float; msg: String): Argv<T>;
    function required(key: K; msg?: Variant): Argv<Defined<T, K>>;
    function required(key: String; msg: String): Argv<T>;
    function required(key: String; required: Boolean): Argv<T>;
    function required(keys: Variant; msg: String): Argv<T>;
    function required(keys: Variant; required: Boolean): Argv<T>;
    function required(positionals: Float; required: Boolean): Argv<T>;
    function required(positionals: Float; msg: String): Argv<T>;
    function requiresArg(key: String): Argv<T>;
    function scriptName($0: String): Argv<T>;
    function showCompletionScript: Argv<T>;
    function showHidden(option?: Variant): Argv<T>;
    function showHidden(option: String; description?: String): Argv<T>;
    function showHelp(consoleLevel?: String): Argv<T>;
    function showHelp(printCallback: procedure): Argv<T>;
    function showHelpOnFail(enable: Boolean; message?: String): Argv<T>;
    function showVersion(level?: Variant): Argv<T>;
    function skipValidation(key: String): Argv<T>;
    function strict: Argv<T>;
    function strict(enabled: Boolean): Argv<T>;
    function strictCommands: Argv<T>;
    function strictCommands(enabled: Boolean): Argv<T>;
    function strictOptions: Argv<T>;
    function strictOptions(enabled: Boolean): Argv<T>;
    function string(key: K): Argv<Variant>;
    function terminalWidth: Float;
    function updateLocale(obj: Variant): Argv<T>;
    function updateStrings(obj: Variant): Argv<T>;
    function usage(message: String): Argv<T>;
    function usage(command: String; description: String; builder?: function: Argv<U>; handler?: function: Variant): Argv<T>;
    function usage(command: String; showInHelp: Boolean; builder?: function: Argv<U>; handler?: function: Variant): Argv<T>;
    function usage(command: String; description: String; builder?: O; handler?: function: Variant): Argv<T>;
    function usage(command: String; showInHelp: Boolean; builder?: O; handler?: function: Variant): Argv<T>;
    function version: Argv<T>;
    function version(version: String): Argv<T>;
    function version(enable: Boolean): Argv<T>;
    function version(optionKey: String; version: String): Argv<T>;
    function version(optionKey: String; description: String; version: String): Argv<T>;
    function wrap(columns: Float): Argv<T>;
  end;

  Arguments = Variant;

  ArgumentsCamelCase = Variant;

  RequireDirectoryOptions = interface
    property recurse: Boolean;
    property extensions: Variant;
    property visit: function: Variant;
    property include: Variant;
    property exclude: Variant;
  end;

  Options = interface
    property alias: String;
    property array: Boolean;
    property boolean: Boolean;
    property choices: Choices;
    property coerce: function: Variant;
    property config: Boolean;
    property configParser: function: Variant;
    property conflicts: String;
    property count: Boolean;
    property default: Variant;
    property defaultDescription: String;
    property demand: Variant;
    property deprecate: Variant;
    property deprecated: Variant;
    property demandOption: Variant;
    property desc: String;
    property describe: String;
    property description: String;
    property global: Boolean;
    property group: String;
    property hidden: Boolean;
    property implies: String;
    property nargs: Float;
    property normalize: Boolean;
    property number: Boolean;
    property require: Variant;
    property required: Variant;
    property requiresArg: Boolean;
    property skipValidation: Boolean;
    property string: Boolean;
    property type: Variant;
  end;

  PositionalOptions = interface
    property alias: String;
    property array: Boolean;
    property choices: Choices;
    property coerce: function: Variant;
    property conflicts: String;
    property default: Variant;
    property demandOption: Variant;
    property desc: String;
    property describe: String;
    property description: String;
    property implies: String;
    property normalize: Boolean;
    property type: PositionalOptionsType;
  end;

  PascalCase = Variant;

  CamelCase = Variant;

  CamelCaseKey = Variant;

  Omit = Variant;

  Defined = Variant;

  ToArray = Variant;

  ToString = Extract<T, Variant>;

  ToNumber = Extract<T, Variant>;

  InferredOptionType = Variant;

  Alias = Variant;

  IsRequiredOrHasDefault = Variant;

  IsAny = Variant;

  IsUnknown = Variant;

  InferredOptionTypePrimitive = Variant;

  InferredOptionTypeInner = Variant;

  InferredOptionTypes = Variant;

  CommandModule = interface
    property aliases: String;
    property builder: CommandBuilder<T, U>;
    property command: String;
    property deprecated: Variant;
    property describe: Variant;
    property handler: function: Variant;
  end;

  ParseCallback = function: Variant;

  CommandBuilder = Variant;

  SyncCompletionFunction = function: array of String;

  AsyncCompletionFunction = procedure;

  PromiseCompletionFunction = function: array of String;

  FallbackCompletionFunction = procedure;

  MiddlewareFunction = function: Variant;

  Choices = array of Variant;

  PositionalOptionsType = String;

  CompletionCallback = procedure;

  BuilderArguments = Variant;

implementation



end.
