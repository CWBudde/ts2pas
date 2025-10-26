unit Jest;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: jest
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ExtractEachCallbackArgs = Variant;

  FakeableAPI = String;

  FakeTimersConfig = interface
    property advanceTimers: Variant;
    property doNotFake: array of FakeableAPI;
    property now: Variant;
    property timerLimit: Float;
    property legacyFakeTimers: Boolean;
  end;

  LegacyFakeTimersConfig = interface
    property legacyFakeTimers: Boolean;
  end;

  procedure advanceTimersByTime(msToRun: Float);

  function advanceTimersByTimeAsync(msToRun: Float): Variant;

  procedure advanceTimersToNextFrame;

  procedure advanceTimersToNextTimer(step?: Float);

  function advanceTimersToNextTimerAsync(steps?: Float): Variant;

  function autoMockOff: Variant;

  function autoMockOn: Variant;

  function clearAllMocks: Variant;

  function createMockFromModule(moduleName: String): T;

  function resetAllMocks: Variant;

  function restoreAllMocks: Variant;

  procedure clearAllTimers;

  function getTimerCount: Float;

  procedure setSystemTime(now?: Variant);

  function getRealSystemTime: Float;

  function getSeed: Float;

  function now: Float;

  function deepUnmock(moduleName: String): Variant;

  function disableAutomock: Variant;

  function doMock(moduleName: String; factory?: function: T; options?: MockOptions): Variant;

  function dontMock(moduleName: String): Variant;

  function enableAutomock: Variant;

  function fn: Mock;

  function fn(implementation?: function: T): Mock<T, Y, C>;

  function isEnvironmentTornDown: Boolean;

  function isMockFunction(fn: Variant): Variant;

  function mock(moduleName: String; factory?: function: T; options?: MockOptions): Variant;

  function mocked(source: T; options?: Variant): MaybeMockedDeep<T>;

  function mocked(source: T; options: Variant): MaybeMocked<T>;

  function onGenerateMock(cb: function: T): Variant;

  function requireActual(moduleName: String): TModule;

  function requireMock(moduleName: String): TModule;

  function resetModules: Variant;

  function isolateModules(fn: procedure): Variant;

  function isolateModulesAsync(fn: function: Variant): Variant;

  function retryTimes(numRetries: Float; options?: Variant): Variant;

  function replaceProperty(obj: T; key: K; value: Variant): ReplaceProperty<Variant>;

  procedure runAllImmediates;

  procedure runAllTicks;

  procedure runAllTimers;

  function runAllTimersAsync: Variant;

  procedure runOnlyPendingTimers;

  function runOnlyPendingTimersAsync: Variant;

  function unstable_unmockModule(moduleName: String): Variant;

  function setMock(moduleName: String; moduleExports: T): Variant;

  function setTimeout(timeout: Float): Variant;

  function spyOn(object: T; method: Key; accessType: A): Variant;

  function spyOn(object: T; method: M): Variant;

  function spyOn(object: T; method: M): Variant;

  function unmock(moduleName: String): Variant;

  function useFakeTimers(config?: Variant): Variant;

  function useRealTimers: Variant;

  MockOptions = interface
    property virtual: Boolean;
  end;

  MockableFunction = function: Variant;

  MethodKeysOf = Variant;

  PropertyKeysOf = Variant;

  ArgumentsOf = Variant;

  ConstructorArgumentsOf = Variant;

  ConstructorReturnType = Variant;

  MockWithArgs = interface(MockInstance)
  end;

  MaybeMockedConstructor = Variant;

  MockedFn = Variant;

  MockedFunctionDeep = Variant;

  MockedObject = Variant;

  MockedObjectDeep = Variant;

  MaybeMockedDeep = Variant;

  MaybeMocked = Variant;

  EmptyFunction = procedure;

  ArgsType = Variant;

  Constructor = Variant;

  Func = function: Variant;

  ConstructorArgsType = Variant;

  RejectedValue = Variant;

  ResolvedValue = Variant;

  NonFunctionPropertyNames = Variant;

  GetAccessor = String;

  SetAccessor = String;

  PropertyAccessors = Variant;

  FunctionProperties = Variant;

  FunctionPropertyNames = Variant;

  RemoveIndex = Variant;

  ConstructorProperties = Variant;

  ConstructorPropertyNames = RemoveIndex<Variant>;

  DoneCallback = interface
    function fail(error?: String): Variant;
  end;

  ProvidesCallback = Variant;

  ProvidesHookCallback = Variant;

  Lifecycle = function: Variant;

  FunctionLike = interface
    property name: String;
  end;

  Each = interface
  end;

  It = interface
    property only: It;
    property failing: It;
    property skip: It;
    property todo: procedure;
    property concurrent: It;
    property each: Each;
  end;

  Describe = interface
    property only: Describe;
    property skip: Describe;
    property each: Each;
  end;

  EqualityTester = function: Boolean;

  MatcherUtils = Variant;

  ExpectExtendMap = interface
  end;

  MatcherContext = Variant;

  CustomMatcher = function: CustomMatcherResult;

  CustomMatcherResult = interface
    property pass: Boolean;
    property message: function: String;
  end;

  SnapshotSerializerPlugin = Variant;

  InverseAsymmetricMatchers = interface
    function arrayContaining(arr: Variant): Variant;
    function arrayOf(arr: E): Variant;
    function objectContaining(obj: E): Variant;
    function stringMatching(str: Variant): Variant;
    function stringContaining(str: String): Variant;
  end;

  MatcherState = Variant;

  Expect = interface
    function anything: Variant;
    function any(classType: Variant): Variant;
    function arrayContaining(arr: Variant): Variant;
    function arrayOf(arr: E): Variant;
    procedure assertions(num: Float);
    function closeTo(num: Float; numDigits?: Float): Variant;
    procedure hasAssertions;
    procedure extend(obj: ExpectExtendMap);
    procedure addSnapshotSerializer(serializer: SnapshotSerializerPlugin);
    function objectContaining(obj: E): Variant;
    function stringMatching(str: Variant): Variant;
    function stringContaining(str: String): Variant;
    property not: InverseAsymmetricMatchers;
    procedure setState(state: Variant);
    function getState: Variant;
  end;

  JestMatchers = JestMatchersShape<Matchers<, T>, Matchers<Variant, T>>;

  JestMatchersShape = Variant;

  AndNot = Variant;

  Matchers = interface
    function toBe(expected: E): R;
    function toBeCloseTo(expected: Float; numDigits?: Float): R;
    function toBeDefined: R;
    function toBeFalsy: R;
    function toBeGreaterThan(expected: Variant): R;
    function toBeGreaterThanOrEqual(expected: Variant): R;
    function toBeInstanceOf(expected: E): R;
    function toBeLessThan(expected: Variant): R;
    function toBeLessThanOrEqual(expected: Variant): R;
    function toBeNull: R;
    function toBeTruthy: R;
    function toBeUndefined: R;
    function toBeNaN: R;
    function toContain(expected: E): R;
    function toContainEqual(expected: E): R;
    function toEqual(expected: E): R;
    function toHaveBeenCalled: R;
    function toHaveBeenCalledTimes(expected: Float): R;
    function toHaveBeenCalledWith(params: E): R;
    function toHaveBeenNthCalledWith(nthCall: Float; params: E): R;
    function toHaveBeenLastCalledWith(params: E): R;
    function toHaveLastReturnedWith(expected?: E): R;
    function toHaveLength(expected: Float): R;
    function toHaveNthReturnedWith(nthCall: Float; expected?: E): R;
    function toHaveProperty(propertyPath: String; value?: E): R;
    function toHaveReturned: R;
    function toHaveReturnedTimes(expected: Float): R;
    function toHaveReturnedWith(expected?: E): R;
    function toMatch(expected: Variant): R;
    function toMatchObject(expected: E): R;
    function toMatchSnapshot(propertyMatchers: U; snapshotName?: String): R;
    function toMatchSnapshot(snapshotName?: String): R;
    function toMatchInlineSnapshot(propertyMatchers: U; snapshot?: String): R;
    function toMatchInlineSnapshot(snapshot?: String): R;
    function toStrictEqual(expected: E): R;
    function toThrow(error?: Variant): R;
    function toThrowErrorMatchingSnapshot(snapshotName?: String): R;
    function toThrowErrorMatchingInlineSnapshot(snapshot?: String): R;
  end;

  RemoveFirstFromTuple = Variant;

  AsymmetricMatcher = interface
    function asymmetricMatch(other: Variant): Boolean;
  end;

  NonAsyncMatchers = Variant;

  CustomAsyncMatchers = Variant;

  CustomAsymmetricMatcher = function: AsymmetricMatcher;

  CustomJestMatcher = function: TMatcherReturn;

  ExpectProperties = Variant;

  ExtendedMatchers = Variant;

  JestExtendedMatchers = JestMatchersShape<ExtendedMatchers<TMatchers, , TActual>, ExtendedMatchers<TMatchers, Variant, TActual>>;

  ExtendedExpectFunction = function: JestExtendedMatchers<TMatchers, TActual>;

  ExtendedExpect = Variant;

  NonPromiseMatchers = Omit<T, String>;

  PromiseMatchers = Omit<Variant, String>;

  Constructable = interface
  end;

  Mock = interface(Function, MockInstance)
  end;

  SpyInstance = interface(MockInstance)
  end;

  SpiedClass = SpyInstance<InstanceType<T>, ConstructorParameters<T>, Variant>;

  SpiedFunction = SpyInstance<ReturnType<T>, ArgsType<T>, Variant>;

  SpiedGetter = SpyInstance<T, array of undefined>;

  SpiedSetter = SpyInstance<, array of T>;

  Spied = Variant;

  MockedFunction = Variant;

  MockedClass = Variant;

  Mocked = Variant;

  MockInstance = interface
    function getMockName: String;
    property mock: MockContext<T, Y, C>;
    function mockClear: Variant;
    function mockReset: Variant;
    procedure mockRestore;
    function getMockImplementation: function: T;
    function mockImplementation(fn?: function: T): Variant;
    function mockImplementationOnce(fn: function: T): Variant;
    function withImplementation(fn: function: T; callback: function: Variant): Variant;
    procedure withImplementation(fn: function: T; callback: procedure);
    function mockName(name: String): Variant;
    function mockReturnThis: Variant;
    function mockReturnValue(value: T): Variant;
    function mockReturnValueOnce(value: T): Variant;
    function mockResolvedValue(value: ResolvedValue<T>): Variant;
    function mockResolvedValueOnce(value: ResolvedValue<T>): Variant;
    function mockRejectedValue(value: RejectedValue<T>): Variant;
    function mockRejectedValueOnce(value: RejectedValue<T>): Variant;
  end;

  MockResultReturn = interface
    property type: String;
    property value: T;
  end;

  MockResultIncomplete = interface
    property type: String;
    property value: Variant;
  end;

  MockResultThrow = interface
    property type: String;
    property value: Variant;
  end;

  MockResult = Variant;

  MockContext = interface
    property calls: array of Y;
    property contexts: array of C;
    property instances: array of T;
    property invocationCallOrder: array of Float;
    property lastCall: Y;
    property results: array of MockResult<T>;
  end;

  ReplaceProperty = interface
    procedure restore;
    function replaceValue(value: K): Variant;
  end;

  function spyOn(object: T; method: Variant): jasmine.Spy;

  procedure pending(reason?: String);

  function fail(error?: Variant): Variant;

  function clock: Clock;

  function any(aclass: Variant): Any;

  function anything: Any;

  function arrayContaining(sample: Variant): ArrayContaining;

  function objectContaining(sample: Variant): ObjectContaining;

  function createSpy(name?: String; originalFn?: function: Variant): Spy;

  function createSpyObj(baseName: String; methodNames: array of Variant): Variant;

  function createSpyObj(baseName: String; methodNames: array of Variant): T;

  function pp(value: Variant): String;

  procedure addCustomEqualityTester(equalityTester: CustomEqualityTester);

  function stringMatching(value: Variant): Any;

  Clock = interface
    procedure install;
    procedure uninstall;
    procedure tick(ms: Float);
    procedure mockDate(date?: Date);
  end;

  Any = interface
    function jasmineMatches(other: Variant): Boolean;
    function jasmineToString: String;
  end;

  ArrayContaining = interface
    function asymmetricMatch(other: Variant): Boolean;
    function jasmineToString: String;
  end;

  ObjectContaining = interface
    function jasmineMatches(other: Variant; mismatchKeys: array of Variant; mismatchValues: array of Variant): Boolean;
    function jasmineToString: String;
  end;

  Spy = interface
    property identity: String;
    property and: SpyAnd;
    property calls: Calls;
    property mostRecentCall: Variant;
    property argsForCall: array of Variant;
    property wasCalled: Boolean;
  end;

  SpyAnd = interface
    function callThrough: Spy;
    function returnValue(val: Variant): Spy;
    function returnValues(values: array of Variant): Spy;
    function callFake(fn: function: Variant): Spy;
    function throwError(msg: String): Spy;
    function stub: Spy;
  end;

  Calls = interface
    function any: Boolean;
    function count: Float;
    function argsFor(index: Float): array of Variant;
    function allArgs: array of Variant;
    function all: array of CallInfo;
    function mostRecent: CallInfo;
    function first: CallInfo;
    procedure reset;
  end;

  CallInfo = interface
    property object: Variant;
    property args: array of Variant;
    property returnValue: Variant;
  end;

  CustomMatcherFactories = interface
  end;

  CustomMatcherFactory = function: CustomMatcher;

  MatchersUtil = interface
    function equals(a: Variant; b: Variant; customTesters?: array of CustomEqualityTester): Boolean;
    function contains(haystack: Variant; needle: Variant; customTesters?: array of CustomEqualityTester): Boolean;
    function buildFailureMessage(matcherName: String; isNot: Boolean; actual: Variant; expected: array of Variant): String;
  end;

  CustomEqualityTester = function: Boolean;

  CustomMatcher = interface
    function compare(actual: T; expected: T; args: array of Variant): CustomMatcherResult;
    function compare(actual: Variant; expected: array of Variant): CustomMatcherResult;
  end;

  CustomMatcherResult = interface
    property pass: Boolean;
    property message: Variant;
  end;

  ArrayLike = interface
    property length: Float;
  end;

  ImportMeta = interface
    property jest: Variant;
  end;

implementation



end.
