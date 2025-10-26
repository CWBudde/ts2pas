unit Mocha;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: mocha
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Mocha = class external
    property _growl: Variant;
    property _reporter: Variant;
    property _ui: Variant;
    procedure Create(options?: Mocha.MochaOptions);
    property suite: Mocha.Suite;
    property files: array of String;
    property options: Mocha.MochaInstanceOptions;
    function addFile(file: String): Variant;
    function bail(bail?: Boolean): Variant;
    function cleanReferencesAfterRun(clean?: Boolean): Variant;
    procedure dispose;
    function reporter(reporter: Mocha.Reporter; reporterOptions?: Variant): Variant;
    function reporter(reporter?: Variant; reporterOptions?: Variant): Variant;
    function ui(name: Mocha.Interface): Variant;
    function ui(name?: String): Variant;
    function fgrep(str: String): Variant;
    function grep(re: Variant): Variant;
    function dryRun(dryRun?: Boolean): Variant;
    function invert: Variant;
    function checkLeaks: Variant;
    function fullTrace: Variant;
    function growl: Variant;
    function globals(globals: String): Variant;
    function timeout(timeout: Variant): Variant;
    function retries(n: Float): Variant;
    function slow(slow: Variant): Variant;
    function asyncOnly: Variant;
    function noHighlighting: Variant;
    function allowUncaught: Boolean;
    function delay: Boolean;
    function failZero(failZero?: Boolean): Variant;
    function forbidOnly: Boolean;
    function forbidPending: Boolean;
    function run(fn?: procedure): Mocha.Runner;
    function loadFilesAsync: Variant;
    procedure loadFiles(fn?: procedure);
    function unloadFiles: Variant;
    function parallelMode(enabled?: Boolean): Variant;
    function rootHooks(hooks: Mocha.RootHookObject): Variant;
    property globalSetup: Mocha.HookFunction;
    property globalTeardown: Mocha.HookFunction;
    function hasGlobalSetupFixtures: Boolean;
    function hasGlobalTeardownFixtures: Boolean;
    function enableGlobalSetup(enabled: Boolean): Variant;
    function enableGlobalTeardown(enabled: Boolean): Variant;
  end;

  function slug(str: String): String;

  function clean(str: String): String;

  function highlight(js: String): String;

  function type(value: Variant): String;

  function stringify(value: Variant): String;

  function canonicalize(value: Variant; stack: array of Variant; typeHint: String): Variant;

  function undefinedError: Error;

  function getError(err: Error): Error;

  function stackTraceFilter: function: String;

  procedure bdd(suite: Suite);

  procedure tdd(suite: Suite);

  procedure qunit(suite: Suite);

  procedure exports(suite: Suite);

  HookFunction = interface
  end;

  SuiteFunction = interface
    property only: ExclusiveSuiteFunction;
    property skip: PendingSuiteFunction;
  end;

  ExclusiveSuiteFunction = interface
  end;

  PendingSuiteFunction = interface
  end;

  TestFunction = interface
    property only: ExclusiveTestFunction;
    property skip: PendingTestFunction;
    procedure retries(n: Float);
  end;

  ExclusiveTestFunction = interface
  end;

  PendingTestFunction = interface
  end;

  procedure run;

  Base = class external
    procedure Create(runner: Runner; options?: MochaOptions);
    property stats: Stats;
    property failures: array of Test;
    property runner: Runner;
    procedure epilogue;
    procedure done(failures: Float; fn?: procedure);
    property consoleLog: procedure;
  end;

  ColorMap = interface
    property pass: Float;
    property fail: Float;
    property pending: Float;
    property suite: Float;
    property checkmark: Float;
    property fast: Float;
    property medium: Float;
    property slow: Float;
    property green: Float;
    property light: Float;
    property progress: Float;
    property plane: Float;
    property runway: Float;
  end;

  SymbolMap = interface
    property ok: String;
    property err: String;
    property dot: String;
    property comma: String;
    property bang: String;
  end;

  function color(type: String; str: String): String;

  procedure hide;

  procedure show;

  procedure deleteLine;

  procedure beginningOfLine;

  procedure CR;

  function generateDiff(actual: String; expected: String): String;

  procedure list(failures: array of Test);

  Dot = class(Base) external
  end;

  Doc = class(Base) external
  end;

  TAP = class(Base) external
  end;

  JSON = class(Base) external
  end;

  HTML = class(Base) external
    function suiteURL(suite: Suite): String;
    function testURL(test: Test): String;
    procedure addCodeToggle(el: HTMLLIElement; contents: String);
  end;

  List = class(Base) external
  end;

  Min = class(Base) external
  end;

  Spec = class(Base) external
  end;

  Nyan = class(Base) external
    property colorIndex: Variant;
    property numberOfLines: Variant;
    property rainbowColors: Variant;
    property scoreboardWidth: Variant;
    property tick: Variant;
    property trajectories: Variant;
    property trajectoryWidthMax: Variant;
    property draw: Variant;
    property drawScoreboard: Variant;
    property appendRainbow: Variant;
    property drawRainbow: Variant;
    property drawNyanCat: Variant;
    property face: Variant;
    property cursorUp: Variant;
    property cursorDown: Variant;
    property generateColors: Variant;
    property rainbowify: Variant;
  end;

  XUnit = class(Base) external
    procedure Create(runner: Runner; options?: XUnit.MochaOptions);
    procedure done(failures: Float; fn: procedure);
    procedure write(line: String);
    procedure test(test: Test);
  end;

  MochaOptions = interface(Mocha.MochaOptions)
    property reporterOptions: ReporterOptions;
  end;

  ReporterOptions = interface
    property output: String;
    property suiteName: String;
  end;

  Markdown = class(Base) external
  end;

  Progress = class(Base) external
    procedure Create(runner: Runner; options?: Progress.MochaOptions);
  end;

  MochaOptions = interface(Mocha.MochaOptions)
    property reporterOptions: ReporterOptions;
  end;

  ReporterOptions = interface
    property open: String;
    property complete: String;
    property incomplete: String;
    property close: String;
    property verbose: Boolean;
  end;

  Landing = class(Base) external
  end;

  JSONStream = class(Base) external
  end;

  Runnable = class external
    property _slow: Variant;
    property _retries: Variant;
    property _currentRetry: Variant;
    property _timeout: Variant;
    property _timeoutError: Variant;
    procedure Create(title: String; fn?: Variant);
    property id: String;
    property title: String;
    property fn: Variant;
    property body: String;
    property async: Boolean;
    property sync: Boolean;
    property timedOut: Boolean;
    property pending: Boolean;
    property duration: Float;
    property parent: Suite;
    property state: Variant;
    property timer: Variant;
    property ctx: Context;
    property callback: Done;
    property allowUncaught: Boolean;
    property file: String;
    function timeout: Float;
    function timeout(ms: Variant): Variant;
    function slow: Float;
    function slow(ms: Variant): Variant;
    function skip: Variant;
    function isPending: Boolean;
    function isFailed: Boolean;
    function isPassed: Boolean;
    function retries: Float;
    procedure retries(n: Float);
    function currentRetry: Float;
    procedure currentRetry(n: Float);
    function fullTitle: String;
    function titlePath: array of String;
    procedure clearTimeout;
    function inspect: String;
    procedure resetTimeout;
    function globals: array of String;
    procedure globals(globals: Variant);
    procedure run(fn: Done);
  end;

  Runnable = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; error: Variant): Boolean;
  end;

  Runnable = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; args: array of Variant): Boolean;
  end;

  Context = class external
    property _runnable: Variant;
    property test: Runnable;
    property currentTest: Test;
    function runnable: Runnable;
    function runnable(runnable: Runnable): Variant;
    function timeout: Float;
    function timeout(ms: Variant): Variant;
    function slow: Float;
    function slow(ms: Variant): Variant;
    function skip: Variant;
    function retries: Float;
    function retries(n: Float): Variant;
  end;

  RunnerConstants = interface
    property EVENT_HOOK_BEGIN: String;
    property EVENT_HOOK_END: String;
    property EVENT_RUN_BEGIN: String;
    property EVENT_DELAY_BEGIN: String;
    property EVENT_DELAY_END: String;
    property EVENT_RUN_END: String;
    property EVENT_SUITE_BEGIN: String;
    property EVENT_SUITE_END: String;
    property EVENT_TEST_BEGIN: String;
    property EVENT_TEST_END: String;
    property EVENT_TEST_FAIL: String;
    property EVENT_TEST_PASS: String;
    property EVENT_TEST_PENDING: String;
    property EVENT_TEST_RETRY: String;
    property STATE_IDLE: String;
    property STATE_RUNNING: String;
    property STATE_STOPPED: String;
  end;

  RunnerOptions = interface
    property delay: Boolean;
    property dryRun: Boolean;
    property cleanReferencesAfterRun: Boolean;
  end;

  Runner = class external
    property _globals: Variant;
    property _abort: Variant;
    property _delay: Variant;
    property _defaultGrep: Variant;
    property next: Variant;
    property hookErr: Variant;
    property prevGlobalsLength: Variant;
    property nextSuite: Variant;
    property constants: RunnerConstants; read only
    procedure Create(suite: Suite; optionsOrDelay?: Variant);
    property suite: Suite;
    property started: Boolean;
    property total: Float;
    property failures: Float;
    property asyncOnly: Boolean;
    property allowUncaught: Boolean;
    property fullStackTrace: Boolean;
    property forbidOnly: Boolean;
    property forbidPending: Boolean;
    property checkLeaks: Boolean;
    property test: Test;
    property currentRunnable: Runnable;
    property stats: Stats;
    procedure dispose;
    function grep(re: RegExp; invert: Boolean): Variant;
    function grepTotal(suite: Suite): Float;
    function globals: array of String;
    function globals(arr: Variant): Variant;
    function run(fn?: procedure): Variant;
    function abort: Variant;
    procedure uncaught(err: Variant);
    procedure immediately(callback: Function); static
    function globalProps: array of String;
    procedure checkGlobals(test: Test);
    procedure fail(test: Test; err: Variant);
    procedure failHook(hook: Hook; err: Variant);
    procedure hook(name: String; fn: procedure);
    procedure hooks(name: String; suites: array of Suite; fn: procedure);
    procedure hookUp(name: String; fn: procedure);
    procedure hookDown(name: String; fn: procedure);
    function parents: array of Suite;
    function runTest(fn: Done): Variant;
    procedure runTests(suite: Suite; fn: procedure);
    procedure runSuite(suite: Suite; fn: procedure);
  end;

  Runner = interface
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; rootSuite: Suite): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; suite: Suite): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; suite: Suite): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test; err: Variant): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test): Boolean;
  end;

  Runner = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; args: array of Variant): Boolean;
  end;

  SuiteConstants = interface
    property EVENT_FILE_POST_REQUIRE: String;
    property EVENT_FILE_PRE_REQUIRE: String;
    property EVENT_FILE_REQUIRE: String;
    property EVENT_ROOT_SUITE_RUN: String;
    property HOOK_TYPE_AFTER_ALL: String;
    property HOOK_TYPE_AFTER_EACH: String;
    property HOOK_TYPE_BEFORE_ALL: String;
    property HOOK_TYPE_BEFORE_EACH: String;
    property EVENT_SUITE_ADD_HOOK_AFTER_ALL: String;
    property EVENT_SUITE_ADD_HOOK_AFTER_EACH: String;
    property EVENT_SUITE_ADD_HOOK_BEFORE_ALL: String;
    property EVENT_SUITE_ADD_HOOK_BEFORE_EACH: String;
    property EVENT_SUITE_ADD_SUITE: String;
    property EVENT_SUITE_ADD_TEST: String;
  end;

  Suite = class external
    property _beforeEach: Variant;
    property _beforeAll: Variant;
    property _afterEach: Variant;
    property _afterAll: Variant;
    property _timeout: Variant;
    property _slow: Variant;
    property _bail: Variant;
    property _retries: Variant;
    property _onlyTests: Variant;
    property _onlySuites: Variant;
    property constants: SuiteConstants; read only
    procedure Create(title: String; parentContext?: Context);
    property ctx: Context;
    property suites: array of Suite;
    property tests: array of Test;
    property pending: Boolean;
    property file: String;
    property root: Boolean;
    property delayed: Boolean;
    property parent: Suite;
    property title: String;
    function create(parent: Suite; title: String): Suite; static
    function clone: Suite;
    function timeout: Float;
    function timeout(ms: Variant): Variant;
    function retries: Float;
    function retries(n: Variant): Variant;
    function slow: Float;
    function slow(ms: Variant): Variant;
    function bail: Boolean;
    function bail(bail: Boolean): Variant;
    function isPending: Boolean;
    function beforeAll(fn?: Func): Variant;
    function beforeAll(fn?: AsyncFunc): Variant;
    function beforeAll(title: String; fn?: Func): Variant;
    function beforeAll(title: String; fn?: AsyncFunc): Variant;
    function afterAll(fn?: Func): Variant;
    function afterAll(fn?: AsyncFunc): Variant;
    function afterAll(title: String; fn?: Func): Variant;
    function afterAll(title: String; fn?: AsyncFunc): Variant;
    function beforeEach(fn?: Func): Variant;
    function beforeEach(fn?: AsyncFunc): Variant;
    function beforeEach(title: String; fn?: Func): Variant;
    function beforeEach(title: String; fn?: AsyncFunc): Variant;
    function afterEach(fn?: Func): Variant;
    function afterEach(fn?: AsyncFunc): Variant;
    function afterEach(title: String; fn?: Func): Variant;
    function afterEach(title: String; fn?: AsyncFunc): Variant;
    function addSuite(suite: Suite): Variant;
    function addTest(test: Test): Variant;
    procedure dispose;
    function fullTitle: String;
    function titlePath: array of String;
    function total: Float;
    function eachTest(fn: procedure): Variant;
    procedure run;
    function _createHook(title: String; fn?: Variant): Hook;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; hook: Hook): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; suite: Suite): Boolean;
  end;

  Suite = interface
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; test: Test): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; context: MochaGlobals; file: String; mocha: Mocha): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; module: Variant; file: String; mocha: Mocha): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; context: MochaGlobals; file: String; mocha: Mocha): Boolean;
  end;

  Suite = interface(NodeJS.EventEmitter)
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
    function prependListener(event: String; listener: procedure): Variant;
    function prependOnceListener(event: String; listener: procedure): Variant;
    function emit(name: String; args: array of Variant): Boolean;
  end;

  Hook = class(Runnable) external
    property _error: Variant;
    property type: String;
    property originalTitle: String;
    function error: Variant;
    procedure error(err: Variant);
  end;

  RootHookObject = interface
    property afterAll: Variant;
    property beforeAll: Variant;
    property afterEach: Variant;
    property beforeEach: Variant;
  end;

  Test = class(Runnable) external
    property type: String;
    property speed: Variant;
    property err: Error;
    function clone: Test;
  end;

  Stats = interface
    property suites: Float;
    property tests: Float;
    property passes: Float;
    property pending: Float;
    property failures: Float;
    property start: Date;
    property end: Date;
    property duration: Float;
  end;

  TestInterface = procedure;

  ReporterConstructor = interface
  end;

  Done = procedure;

  Func = procedure;

  AsyncFunc = function: PromiseLike<Variant>;

  MochaOptions = interface
    property allowUncaught: Boolean;
    property asyncOnly: Boolean;
    property bail: Boolean;
    property checkLeaks: Boolean;
    property color: Boolean;
    property delay: Boolean;
    property diff: Boolean;
    property dryRun: Boolean;
    property failZero: Boolean;
    property fgrep: String;
    property forbidOnly: Boolean;
    property forbidPending: Boolean;
    property fullTrace: Boolean;
    property globals: array of String;
    property grep: Variant;
    property growl: Boolean;
    property inlineDiffs: Boolean;
    property invert: Boolean;
    property noHighlighting: Boolean;
    property reporter: Variant;
    property reporterOptions: Variant;
    property retries: Float;
    property slow: Float;
    property timeout: Variant;
    property ui: Interface;
    property parallel: Boolean;
    property jobs: Float;
    property rootHooks: RootHookObject;
    property require: array of String;
    property isWorker: Boolean;
  end;

  MochaInstanceOptions = interface(MochaOptions)
    property files: array of String;
  end;

  MochaGlobals = interface
    property before: HookFunction;
    property after: HookFunction;
    property beforeEach: HookFunction;
    property afterEach: HookFunction;
    property describe: SuiteFunction;
    property context: SuiteFunction;
    property xdescribe: PendingSuiteFunction;
    property xcontext: PendingSuiteFunction;
    property it: TestFunction;
    property specify: TestFunction;
    property xit: PendingTestFunction;
    property xspecify: PendingTestFunction;
    property suiteSetup: HookFunction;
    property suiteTeardown: HookFunction;
    property setup: HookFunction;
    property teardown: HookFunction;
    property suite: SuiteFunction;
    property test: TestFunction;
    property run: Variant;
  end;

  ReporterContributions = interface
    property Base: Variant;
    property base: Variant;
    property Dot: Variant;
    property dot: Variant;
    property TAP: Variant;
    property tap: Variant;
    property JSON: Variant;
    property json: Variant;
    property HTML: Variant;
    property html: Variant;
    property List: Variant;
    property list: Variant;
    property Min: Variant;
    property min: Variant;
    property Spec: Variant;
    property spec: Variant;
    property Nyan: Variant;
    property nyan: Variant;
    property XUnit: Variant;
    property xunit: Variant;
    property Markdown: Variant;
    property markdown: Variant;
    property Progress: Variant;
    property progress: Variant;
    property Landing: Variant;
    property landing: Variant;
    property JSONStream: Variant;
  end;

  Reporter = Variant;

  InterfaceContributions = interface
    property bdd: Variant;
    property tdd: Variant;
    property qunit: Variant;
    property exports: Variant;
  end;

  Interface = Variant;

  procedure run;

  HTMLLIElement = interface
  end;

  Window = interface(Mocha.MochaGlobals)
  end;

  EventEmitter = interface
  end;

  Global = interface(Mocha.MochaGlobals)
  end;

  BrowserMocha = interface(Mocha)
    function throwError(err: Variant): Variant;
    function setup(opts?: Variant): Variant;
  end;

  procedure createStatsCollector(runner: Mocha.Runner);

  function common(suites: array of Mocha.Suite; context: Mocha.MochaGlobals; mocha: Mocha): common.CommonFunctions;

  CommonFunctions = interface
    function runWithSuite(suite: Mocha.Suite): procedure;
    procedure before(fn?: Variant);
    procedure before(name: String; fn?: Variant);
    procedure after(fn?: Variant);
    procedure after(name: String; fn?: Variant);
    procedure beforeEach(fn?: Variant);
    procedure beforeEach(name: String; fn?: Variant);
    procedure afterEach(fn?: Variant);
    procedure afterEach(name: String; fn?: Variant);
    property suite: SuiteFunctions;
    property test: TestFunctions;
  end;

  CreateOptions = interface
    property title: String;
    property fn: procedure;
    property pending: Boolean;
    property file: String;
    property isOnly: Boolean;
  end;

  SuiteFunctions = interface
    function only(opts: CreateOptions): Mocha.Suite;
    function skip(opts: CreateOptions): Mocha.Suite;
    function create(opts: CreateOptions): Mocha.Suite;
  end;

  TestFunctions = interface
    function only(mocha: Mocha; test: Mocha.Test): Mocha.Test;
    procedure skip(title: String);
    procedure retries(n: Float);
  end;

implementation



end.
