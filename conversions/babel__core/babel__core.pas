unit Babel__core;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: babel__core
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Node = t.Node;

  ParseResult = ReturnType<Variant>;

  InputSourceMap = interface
    property version: Float;
    property sources: array of String;
    property names: array of String;
    property sourceRoot: String;
    property sourcesContent: array of String;
    property mappings: String;
    property file: String;
  end;

  TransformOptions = interface
    property assumptions: Variant;
    property ast: Boolean;
    property auxiliaryCommentAfter: String;
    property auxiliaryCommentBefore: String;
    property root: String;
    property rootMode: Variant;
    property configFile: Variant;
    property babelrc: Boolean;
    property babelrcRoots: Variant;
    property browserslistConfigFile: Boolean;
    property browserslistEnv: String;
    property cloneInputAst: Boolean;
    property envName: String;
    property exclude: Variant;
    property code: Boolean;
    property comments: Boolean;
    property compact: Variant;
    property cwd: String;
    property caller: TransformCaller;
    property env: Variant;
    property extends: String;
    property filename: String;
    property filenameRelative: String;
    property generatorOpts: GeneratorOptions;
    property getModuleId: function: String;
    property highlightCode: Boolean;
    property ignore: array of MatchPattern;
    property include: Variant;
    property inputSourceMap: InputSourceMap;
    property minified: Boolean;
    property moduleId: String;
    property moduleIds: Boolean;
    property moduleRoot: String;
    property only: array of MatchPattern;
    property overrides: array of TransformOptions;
    property parserOpts: ParserOptions;
    property plugins: array of PluginItem;
    property presets: array of PluginItem;
    property retainLines: Boolean;
    property shouldPrintComment: function: Boolean;
    property sourceFileName: String;
    property sourceMaps: Variant;
    property sourceRoot: String;
    property sourceType: Variant;
    property test: Variant;
    property targets: Variant;
    property wrapPluginVisitorMethod: function: procedure;
  end;

  TransformCaller = interface
    property name: String;
    property supportsStaticESM: Boolean;
    property supportsDynamicImport: Boolean;
    property supportsExportNamespaceFrom: Boolean;
    property supportsTopLevelAwait: Boolean;
  end;

  FileResultCallback = function: Variant;

  MatchPatternContext = interface
    property envName: String;
    property dirname: String;
    property caller: TransformCaller;
  end;

  MatchPattern = Variant;

  procedure transform(code: String; callback: FileResultCallback);

  procedure transform(code: String; opts: TransformOptions; callback: FileResultCallback);

  function transform(code: String; opts?: TransformOptions): BabelFileResult;

  function transformSync(code: String; opts?: TransformOptions): BabelFileResult;

  function transformAsync(code: String; opts?: TransformOptions): BabelFileResult;

  procedure transformFile(filename: String; callback: FileResultCallback);

  procedure transformFile(filename: String; opts: TransformOptions; callback: FileResultCallback);

  function transformFileSync(filename: String; opts?: TransformOptions): BabelFileResult;

  function transformFileAsync(filename: String; opts?: TransformOptions): BabelFileResult;

  procedure transformFromAst(ast: Node; code: String; callback: FileResultCallback);

  procedure transformFromAst(ast: Node; code: String; opts: TransformOptions; callback: FileResultCallback);

  function transformFromAstSync(ast: Node; code?: String; opts?: TransformOptions): BabelFileResult;

  function transformFromAstAsync(ast: Node; code?: String; opts?: TransformOptions): BabelFileResult;

  PluginObj = interface
    property name: String;
    procedure manipulateOptions(opts: Variant; parserOpts: Variant);
    procedure pre(this: S; file: BabelFile);
    property visitor: Visitor<S>;
    procedure post(this: S; file: BabelFile);
    property inherits: Variant;
  end;

  BabelFile = interface
    property ast: t.File;
    property opts: TransformOptions;
    property hub: Hub;
    property metadata: Variant;
    property path: NodePath<t.Program>;
    property scope: Scope;
    property inputMap: Variant;
    property code: String;
  end;

  PluginPass = interface
    property file: BabelFile;
    property key: String;
    property opts: Variant;
    property cwd: String;
    property filename: String;
    function get(key: Variant): Variant;
    procedure set(key: Variant; value: Variant);
  end;

  BabelFileResult = interface
    property ast: t.File;
    property code: String;
    property ignored: Boolean;
    property map: Variant;
    property metadata: BabelFileMetadata;
  end;

  BabelFileMetadata = interface
    property usedHelpers: array of String;
    property marked: array of Variant;
    property modules: BabelFileModulesMetadata;
  end;

  BabelFileModulesMetadata = interface
    property imports: array of Variant;
    property exports: Variant;
  end;

  FileParseCallback = function: Variant;

  procedure parse(code: String; callback: FileParseCallback);

  procedure parse(code: String; options: TransformOptions; callback: FileParseCallback);

  function parse(code: String; options?: TransformOptions): ParseResult;

  function parseSync(code: String; options?: TransformOptions): ParseResult;

  function parseAsync(code: String; options?: TransformOptions): ParseResult;

  function loadOptions(options?: TransformOptions): Variant;

  function loadPartialConfig(options?: TransformOptions): PartialConfig;

  function loadPartialConfigAsync(options?: TransformOptions): PartialConfig;

  PartialConfig = interface
    property options: TransformOptions;
    property babelrc: String;
    property babelignore: String;
    property config: String;
    property hasFilesystemConfig: function: Boolean;
  end;

  ConfigItem = interface
    property name: String;
    property value: function: Variant;
    property options: Boolean;
    property dirname: String;
    property file: Variant;
  end;

  PluginOptions = Boolean;

  PluginTarget = Variant;

  PluginItem = Variant;

  function resolvePlugin(name: String; dirname: String): String;

  function resolvePreset(name: String; dirname: String): String;

  CreateConfigItemOptions = interface
    property dirname: String;
    property type: Variant;
  end;

  function createConfigItem(value: Variant; options?: CreateConfigItemOptions): ConfigItem;

  ConfigAPI = interface
    property version: String;
    property cache: SimpleCacheConfigurator;
    property env: EnvFunction;
    function caller(callerCallback: function: T): T;
    function assertVersion(versionRange: Variant): Boolean;
  end;

  SimpleCacheConfigurator = interface
    procedure forever;
    procedure never;
    function using(callback: SimpleCacheCallback<T>): T;
    function invalidate(callback: SimpleCacheCallback<T>): T;
  end;

  SimpleCacheKey = Variant;

  SimpleCacheCallback = function: T;

  EnvFunction = interface
  end;

  ConfigFunction = function: TransformOptions;

implementation



end.
