unit Jasmine;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: jasmine
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ImplementationCallback = jasmine.ImplementationCallback;

  procedure describe(description: String; specDefinitions: procedure);

  procedure fdescribe(description: String; specDefinitions: procedure);

  procedure xdescribe(description: String; specDefinitions: procedure);

  procedure it(expectation: String; assertion?: jasmine.ImplementationCallback; timeout?: Float);

  procedure fit(expectation: String; assertion?: jasmine.ImplementationCallback; timeout?: Float);

  procedure xit(expectation: String; assertion?: jasmine.ImplementationCallback; timeout?: Float);

  procedure pending(reason?: String);

  procedure setSpecProperty(key: String; value: Variant);

  procedure setSuiteProperty(key: String; value: Variant);

  procedure beforeEach(action: jasmine.ImplementationCallback; timeout?: Float);

  procedure afterEach(action: jasmine.ImplementationCallback; timeout?: Float);

  procedure beforeAll(action: jasmine.ImplementationCallback; timeout?: Float);

  procedure afterAll(action: jasmine.ImplementationCallback; timeout?: Float);

  function expect(spy: Variant): jasmine.FunctionMatchers<T>;

  function expect(actual: String): jasmine.Matchers<String>;

  function expect(actual: ArrayLike<T>): jasmine.ArrayLikeMatchers<T>;

  function expect(actual: T): jasmine.Matchers<T>;

  function expect: jasmine.NothingMatcher;

  function expectAsync(actual: Variant): jasmine.AsyncMatchers<T, U>;

  procedure fail(e?: Variant);

  DoneFn = interface(Function)
    property fail: procedure;
  end;

  function spyOn(object: T; method: Variant): jasmine.Spy<Variant>;

  function spyOnProperty(object: T; property: K; accessType?: String): jasmine.Spy<function: Variant>;

  function spyOnProperty(object: T; property: K; accessType: String): jasmine.Spy<procedure>;

  ThrowUnlessFailure = interface
    property matcherName: String;
    property message: String;
    property passed: Boolean;
    property expected: Variant;
    property actual: Variant;
  end;

  function throwUnless(spy: Variant): jasmine.FunctionMatchers<T>;

  function throwUnless(actual: ArrayLike<T>): jasmine.ArrayLikeMatchers<T>;

  function throwUnless(actual: T): jasmine.Matchers<T>;

  function throwUnlessAsync(actual: Variant): jasmine.AsyncMatchers<T, U>;

  function spyOnAllFunctions(object: T; includeNonEnumerable?: Boolean): jasmine.SpyObj<T>;

  Func = function: Variant;

  Constructor = Variant;

  ImplementationCallback = Variant;

  ExpectedRecursive = Variant;

  Expected = Variant;

  SpyObjMethodNames = Variant;

  SpyObjPropertyNames = Variant;

  Configuration = interface
    property random: Boolean;
    property seed: Variant;
    property stopOnSpecFailure: Boolean;
    property forbidDuplicateNames: Boolean;
    property failSpecWithNoExpectations: Boolean;
    property stopSpecOnExpectationFailure: Boolean;
    property specFilter: SpecFilter;
    property hideDisabled: Boolean;
    property Promise: Variant;
    property autoCleanClosures: Boolean;
  end;

  EnvConfiguration = Configuration;

  function clock: Clock;

  function DiffBuilder: DiffBuilder;

  function any(aclass: Variant): AsymmetricMatcher<Variant>;

  function anything: AsymmetricMatcher<Variant>;

  function truthy: AsymmetricMatcher<Variant>;

  function falsy: AsymmetricMatcher<Variant>;

  function empty: AsymmetricMatcher<Variant>;

  function notEmpty: AsymmetricMatcher<Variant>;

  function is(sample: Variant): AsymmetricMatcher<Variant>;

  function arrayContaining(sample: ArrayLike<T>): ArrayContaining<T>;

  function arrayWithExactContents(sample: ArrayLike<T>): ArrayContaining<T>;

  function objectContaining(sample: Variant): ObjectContaining<T>;

  function mapContaining(sample: Variant): AsymmetricMatcher<Variant>;

  function setContaining(sample: Variant): AsymmetricMatcher<Variant>;

  procedure setDefaultSpyStrategy(fn?: procedure);

  function spyOnGlobalErrorsAsync(fn?: function: Variant): Variant;

  procedure addSpyStrategy(name: String; factory: Fn);

  function createSpy(name?: String; originalFn?: Fn): Spy<Fn>;

  function createSpyObj(baseName: String; methodNames: SpyObjMethodNames; propertyNames?: SpyObjPropertyNames): Variant;

  function createSpyObj(baseName: String; methodNames: SpyObjMethodNames<T>; propertyNames?: SpyObjPropertyNames<T>): SpyObj<T>;

  function createSpyObj(methodNames: SpyObjMethodNames; propertyNames?: SpyObjPropertyNames): Variant;

  function createSpyObj(methodNames: SpyObjMethodNames<T>; propertyNames?: SpyObjPropertyNames<T>): SpyObj<T>;

  function getEnv: Env;

  procedure debugLog(msg: String);

  procedure addCustomEqualityTester(equalityTester: CustomEqualityTester);

  procedure addCustomObjectFormatter(formatter: CustomObjectFormatter);

  procedure addMatchers(matchers: CustomMatcherFactories);

  procedure addAsyncMatchers(matchers: CustomAsyncMatcherFactories);

  function stringMatching(str: Variant): AsymmetricMatcher<String>;

  function stringContaining(str: String): AsymmetricMatcher<String>;

  function formatErrorMsg(domain: String; usage: String): function: String;

  Any = interface(AsymmetricMatcher)
    function jasmineToString(prettyPrint: function: String): String;
  end;

  AsymmetricMatcher = interface
    function asymmetricMatch(other: TValue; matchersUtil?: MatchersUtil): Boolean;
    function jasmineToString(prettyPrint: function: String): String;
  end;

  ArrayLike = interface
    property length: Float;
  end;

  ArrayContaining = interface(AsymmetricMatcher)
    function new(sample: ArrayLike<T>): ArrayLike<T>;
    function jasmineToString(prettyPrint: function: String): String;
  end;

  ObjectContaining = interface(AsymmetricMatcher)
    function new(sample: Variant): Variant;
    function jasmineToString(prettyPrint: function: String): String;
  end;

  Clock = interface
    procedure autoTick;
    function install: Clock;
    procedure uninstall;
    procedure tick(ms: Float);
    procedure mockDate(date?: Date);
    procedure withMock(func: procedure);
  end;

  CustomEqualityTester = function: Boolean;

  CustomObjectFormatter = function: String;

  CustomMatcher = interface
    function compare(actual: T; expected: T; args: array of Variant): CustomMatcherResult;
    function compare(actual: Variant; expected: array of Variant): CustomMatcherResult;
    function negativeCompare(actual: T; expected: T; args: array of Variant): CustomMatcherResult;
    function negativeCompare(actual: Variant; expected: array of Variant): CustomMatcherResult;
  end;

  CustomAsyncMatcher = interface
    function compare(actual: T; expected: T; args: array of Variant): PromiseLike<CustomMatcherResult>;
    function compare(actual: Variant; expected: array of Variant): PromiseLike<CustomMatcherResult>;
    function negativeCompare(actual: T; expected: T; args: array of Variant): PromiseLike<CustomMatcherResult>;
    function negativeCompare(actual: Variant; expected: array of Variant): PromiseLike<CustomMatcherResult>;
  end;

  CustomMatcherFactory = function: CustomMatcher;

  CustomAsyncMatcherFactory = function: CustomAsyncMatcher;

  CustomMatcherFactories = interface
  end;

  CustomAsyncMatcherFactories = interface
  end;

  CustomMatcherResult = interface
    property pass: Boolean;
    property message: String;
  end;

  DiffBuilder = interface
    procedure setRoots(actual: Variant; expected: Variant);
    procedure recordMismatch(formatter?: function: String);
    procedure withPath(pathComponent: String; block: procedure);
    function getMessage: String;
  end;

  MatchersUtil = interface
    function equals(a: Variant; b: Variant): Boolean;
    function contains(haystack: Variant; needle: Variant): Boolean;
    function buildFailureMessage(matcherName: String; isNot: Boolean; actual: Variant; expected: array of Variant): String;
    function pp(value: Variant): String;
  end;

  Env = interface
    procedure addReporter(reporter: CustomReporter);
    procedure allowRespy(allow: Boolean);
    procedure clearReporters;
    function configuration: Configuration;
    procedure configure(configuration: Configuration);
    function execute(runnablesToRun?: array of Suite): JasmineDoneInfo;
    procedure provideFallbackReporter(reporter: CustomReporter);
    property setSpecProperty: Variant;
    property setSuiteProperty: Variant;
    function topSuite: Suite;
  end;

  HtmlReporter = interface
  end;

  HtmlSpecFilter = interface
  end;

  Result = interface
    property type: String;
  end;

  ExpectationResult = interface(Result)
    property matcherName: String;
    property message: String;
    property stack: String;
    property passed: Boolean;
    property expected: Variant;
    property actual: Variant;
  end;

  DeprecationWarning = interface(Result)
    property message: String;
    property stack: String;
  end;

  Order = interface
    property random: Boolean;
    property seed: Variant;
    function sort(items: array of T): array of T;
  end;

  ExpectationFailed = class(Error) external
    procedure Create;
    property stack: Variant;
  end;

  Matchers = interface
    procedure toBe(expected: Expected<T>);
    procedure toBe(expected: Expected<T>; expectationFailOutput: Variant);
    procedure toEqual(expected: Expected<T>);
    procedure toEqual(expected: Expected<T>; expectationFailOutput: Variant);
    procedure toMatch(expected: Variant);
    procedure toMatch(expected: Variant; expectationFailOutput: Variant);
    procedure toBeDefined;
    procedure toBeDefined(expectationFailOutput: Variant);
    procedure toBeUndefined;
    procedure toBeUndefined(expectationFailOutput: Variant);
    procedure toBeNull;
    procedure toBeNull(expectationFailOutput: Variant);
    procedure toBeNaN;
    procedure toBeTruthy;
    procedure toBeTruthy(expectationFailOutput: Variant);
    procedure toBeFalsy;
    procedure toBeFalsy(expectationFailOutput: Variant);
    procedure toBeTrue;
    procedure toBeFalse;
    procedure toHaveBeenCalled;
    procedure toHaveBeenCalledBefore(expected: Func);
    procedure toHaveBeenCalledWith(params: array of Variant);
    procedure toHaveBeenCalledOnceWith(params: array of Variant);
    procedure toHaveBeenCalledTimes(expected: Float);
    procedure toContain(expected: Variant);
    procedure toContain(expected: Variant; expectationFailOutput: Variant);
    procedure toBeLessThan(expected: Float);
    procedure toBeLessThan(expected: Float; expectationFailOutput: Variant);
    procedure toBeLessThanOrEqual(expected: Float);
    procedure toBeLessThanOrEqual(expected: Float; expectationFailOutput: Variant);
    procedure toBeGreaterThan(expected: Float);
    procedure toBeGreaterThan(expected: Float; expectationFailOutput: Variant);
    procedure toBeGreaterThanOrEqual(expected: Float);
    procedure toBeGreaterThanOrEqual(expected: Float; expectationFailOutput: Variant);
    procedure toBeCloseTo(expected: Float; precision?: Variant);
    procedure toBeCloseTo(expected: Float; precision: Variant; expectationFailOutput: Variant);
    procedure toThrow(expected?: Variant);
    procedure toThrowError(message?: Variant);
    procedure toThrowError(expected?: Error; message?: Variant);
    procedure toThrowMatching(predicate: function: Boolean);
    procedure toBeNegativeInfinity;
    procedure toBeNegativeInfinity(expectationFailOutput: Variant);
    procedure toBePositiveInfinity;
    procedure toBePositiveInfinity(expectationFailOutput: Variant);
    procedure toBeInstanceOf(expected: Constructor);
    procedure toHaveClass(expected: String);
    procedure toHaveClass(expected: String; expectationFailOutput: Variant);
    procedure toHaveSize(expected: Float);
    procedure toHaveSpyInteractions;
    function withContext(message: String): Matchers<T>;
    property not: Matchers<T>;
  end;

  ArrayLikeMatchers = interface(Matchers)
    procedure toBe(expected: Variant);
    procedure toBe(expected: Variant; expectationFailOutput: Variant);
    procedure toEqual(expected: Variant);
    procedure toEqual(expected: Variant; expectationFailOutput: Variant);
    procedure toContain(expected: Expected<T>);
    procedure toContain(expected: Expected<T>; expectationFailOutput: Variant);
    function withContext(message: String): ArrayLikeMatchers<T>;
    property not: ArrayLikeMatchers<T>;
  end;

  MatchableArgs = Variant;

  FunctionMatchers = interface(Matchers)
    procedure toHaveBeenCalledWith(params: MatchableArgs<Fn>);
    procedure toHaveBeenCalledOnceWith(params: MatchableArgs<Fn>);
    function withContext(message: String): FunctionMatchers<Fn>;
    property not: FunctionMatchers<Fn>;
  end;

  NothingMatcher = interface
    procedure nothing;
  end;

  AsyncMatchers = interface
    function toBePending: PromiseLike<>;
    function toBePending(expectationFailOutput: Variant): PromiseLike<>;
    function toBeResolved: PromiseLike<>;
    function toBeResolved(expectationFailOutput: Variant): PromiseLike<>;
    function toBeRejected: PromiseLike<>;
    function toBeRejected(expectationFailOutput: Variant): PromiseLike<>;
    function toBeResolvedTo(expected: Expected<T>): PromiseLike<>;
    function toBeRejectedWith(expected: Expected<U>): PromiseLike<>;
    function toBeRejectedWithError(expected?: Error; message?: Variant): PromiseLike<>;
    function toBeRejectedWithError(message?: Variant): PromiseLike<>;
    function withContext(message: String): AsyncMatchers<T, U>;
    property already: AsyncMatchers<T, U>;
    property not: AsyncMatchers<T, U>;
  end;

  JasmineStartedInfo = interface
    property totalSpecsDefined: Float;
    property order: Order;
  end;

  CustomReportExpectation = interface
    property matcherName: String;
    property message: String;
    property passed: Boolean;
    property stack: String;
  end;

  FailedExpectation = interface(CustomReportExpectation)
    property actual: String;
    property expected: String;
  end;

  PassedExpectation = interface(CustomReportExpectation)
  end;

  DeprecatedExpectation = interface
    property message: String;
  end;

  SuiteResult = interface
    property id: String;
    property description: String;
    property fullName: String;
    property filename: String;
    property failedExpectations: array of FailedExpectation;
    property deprecationWarnings: array of DeprecatedExpectation;
    property status: String;
    property duration: Float;
    property properties: Variant;
  end;

  SpecResult = interface(SuiteResult)
    property passedExpectations: array of PassedExpectation;
    property pendingReason: String;
    property debugLogs: array of DebugLogEntry;
  end;

  DebugLogEntry = interface
    property message: String;
    property timestamp: Float;
  end;

  JasmineDoneInfo = interface
    property overallStatus: String;
    property totalTime: Float;
    property incompleteReason: String;
    property order: Order;
    property failedExpectations: array of ExpectationResult;
    property deprecationWarnings: array of ExpectationResult;
  end;

  SuiteInfo = JasmineStartedInfo;

  CustomReporterResult = Variant;

  RunDetails = JasmineDoneInfo;

  CustomReporter = interface
    function jasmineStarted(suiteInfo: JasmineStartedInfo; done?: procedure): Variant;
    function suiteStarted(result: SuiteResult; done?: procedure): Variant;
    function specStarted(result: SpecResult; done?: procedure): Variant;
    function specDone(result: SpecResult; done?: procedure): Variant;
    function suiteDone(result: SuiteResult; done?: procedure): Variant;
    function jasmineDone(runDetails: JasmineDoneInfo; done?: procedure): Variant;
  end;

  SpecFilter = interface
  end;

  SpecFunction = procedure;

  Spec = interface
    property id: String;
    property env: Env;
    property description: String;
    function getFullName: String;
  end;

  Suite = interface(Spec)
    property parentSuite: Suite;
    property children: array of Variant;
  end;

  Spy = interface
    property and: SpyAnd<Fn>;
    property calls: Calls<Fn>;
    function withArgs(args: MatchableArgs<Fn>): Spy<Fn>;
  end;

  SpyObj = Variant;

  function isSpy(putativeSpy: Func): Variant;

  NonTypedSpyObj = SpyObj<Variant>;

  PromisedResolveType = Variant;

  PromisedRejectType = Variant;

  SpyAnd = interface
    property identity: String;
    function callThrough: Spy<Fn>;
    function returnValue(val: ReturnType<Fn>): Spy<Fn>;
    function returnValues(values: array of ReturnType<Fn>): Spy<Fn>;
    function callFake(fn: Fn): Spy<Fn>;
    function resolveTo(val?: PromisedResolveType<ReturnType<Fn>>): Spy<Fn>;
    function rejectWith(val?: PromisedRejectType<ReturnType<Fn>>): Spy<Fn>;
    function throwError(msg: Variant): Spy;
    function stub: Spy;
  end;

  Calls = interface
    function any: Boolean;
    function count: Float;
    function argsFor(index: Float): Parameters<Fn>;
    function allArgs: array of Parameters<Fn>;
    function all: array of CallInfo<Fn>;
    function mostRecent: CallInfo<Fn>;
    function first: CallInfo<Fn>;
    procedure reset;
    procedure saveArgumentsByValue;
    function thisFor(index: Float): ThisType<Fn>;
  end;

  CallInfo = interface
    property object: ThisType<Fn>;
    property args: Parameters<Fn>;
    property returnValue: ReturnType<Fn>;
  end;

  Util = interface
    function inherit(childClass: Function; parentClass: Function): Variant;
    function formatException(e: Variant): Variant;
    function htmlEscape(str: String): String;
    function argsToArray(args: Variant): Variant;
    function extend(destination: Variant; source: Variant): Variant;
  end;

  JsApiReporter = interface(CustomReporter)
    property started: Boolean;
    property finished: Boolean;
    property runDetails: JasmineDoneInfo;
    function status: String;
    function suiteResults(index: Float; length: Float): array of SuiteResult;
    function specResults(index: Float; length: Float): array of SpecResult;
    function suites: Variant;
    function specs: array of SpecResult;
    function executionTime: Float;
  end;

  Jasmine = interface
    property Spec: Spec;
    property clock: Clock;
    property util: Util;
  end;

  JasmineOptions = interface
    property projectBaseDir: String;
  end;

  JasmineConfig = interface
    property failSpecWithNoExpectations: Boolean;
    property helpers: array of String;
    property jsLoader: String;
    property random: Boolean;
    property requires: array of String;
    property spec_dir: String;
    property spec_files: array of String;
    property stopOnSpecFailure: Boolean;
    property stopSpecOnExpectationFailure: Boolean;
  end;

  DefaultReporterOptions = interface
    property timer: Variant;
    property print: procedure;
    property showColors: Boolean;
    property jasmineCorePath: String;
  end;

  jasmine = class external
    property jasmine: jasmine.Jasmine;
    property env: jasmine.Env;
    property reportersCount: Float;
    property reporter: jasmine.CustomReporter;
    property showingColors: Boolean;
    property projectBaseDir: String;
    property specDir: String;
    property specFiles: array of String;
    property helperFiles: array of String;
    property requires: array of String;
    property defaultReporterConfigured: Boolean;
    procedure Create(options?: jasmine.JasmineOptions);
    procedure addMatchers(matchers: jasmine.CustomMatcherFactories);
    procedure addReporter(reporter: jasmine.CustomReporter);
    procedure addSpecFile(filePath: String);
    procedure addMatchingSpecFiles(patterns: array of String);
    procedure addHelperFile(filePath: String);
    procedure addMatchingHelperFiles(patterns: array of String);
    procedure addRequires(files: array of String);
    procedure configureDefaultReporter(options: jasmine.DefaultReporterOptions);
    function execute(files?: array of String; filterString?: String): jasmine.JasmineDoneInfo;
    property exitOnCompletion: Boolean;
    procedure loadConfig(config: jasmine.JasmineConfig);
    procedure loadConfigFile(configFilePath?: String);
    function loadHelpers: Variant;
    function loadSpecs: Variant;
    procedure loadRequires;
    procedure provideFallbackReporter(reporter: jasmine.CustomReporter);
    procedure clearReporters;
    procedure randomizeTests(value: Boolean);
    procedure seed(value: Float);
    procedure showColors(value: Boolean);
    procedure stopSpecOnExpectationFailure(value: Boolean);
    procedure stopOnSpecFailure(value: Boolean);
    function ConsoleReporter: Variant; static
    function coreVersion: String;
  end;

implementation



end.
