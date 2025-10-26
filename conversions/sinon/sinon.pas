unit Sinon;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: sinon
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Event = interface
  end;

  Document = interface
  end;

  MatchPartialArguments = Variant;

  DeepPartialOrMatcher = MatchPartialArguments<T>;

  MatchExactArguments = Variant;

  MatchArguments = MatchExactArguments<T>;

  SinonSpyCallApi = interface
    property args: TArgs;
    function calledOn(obj: Variant): Boolean;
    function calledWith(args: MatchPartialArguments<TArgs>): Boolean;
    function calledWithExactly(args: MatchExactArguments<TArgs>): Boolean;
    function calledWithNew: Boolean;
    function calledOnceWith(args: MatchPartialArguments<TArgs>): Boolean;
    function calledOnceWithExactly(args: MatchExactArguments<TArgs>): Boolean;
    function calledWithMatch(args: MatchPartialArguments<TArgs>): Boolean;
    function notCalledWith(args: MatchExactArguments<TArgs>): Boolean;
    function notCalledWithMatch(args: MatchPartialArguments<TArgs>): Boolean;
    function returned(value: Variant): Boolean;
    function threw: Boolean;
    function threw(type: String): Boolean;
    function threw(obj: Variant): Boolean;
    function callArg(pos: Float): array of Variant;
    function callArgOn(pos: Float; obj: Variant; args: array of Variant): array of Variant;
    function callArgWith(pos: Float; args: array of Variant): array of Variant;
    function callArgOnWith(pos: Float; obj: Variant; args: array of Variant): array of Variant;
    function yield(args: array of Variant): array of Variant;
    function yieldOn(obj: Variant; args: array of Variant): array of Variant;
    function yieldTo(property: String; args: array of Variant): array of Variant;
    function yieldToOn(property: String; obj: Variant; args: array of Variant): array of Variant;
  end;

  SinonSpyCall = interface(SinonSpyCallApi)
    property thisValue: Variant;
    property exception: Variant;
    property returnValue: TReturnValue;
    property callback: Function;
    property firstArg: Variant;
    property lastArg: Variant;
    function calledBefore(call: SinonSpyCall<Variant>): Boolean;
    function calledAfter(call: SinonSpyCall<Variant>): Boolean;
  end;

  SinonSpy = interface(Pick)
    property callCount: Float;
    property called: Boolean;
    property notCalled: Boolean;
    property calledOnce: Boolean;
    property calledTwice: Boolean;
    property calledThrice: Boolean;
    property firstCall: SinonSpyCall<TArgs, TReturnValue>;
    property secondCall: SinonSpyCall<TArgs, TReturnValue>;
    property thirdCall: SinonSpyCall<TArgs, TReturnValue>;
    property lastCall: SinonSpyCall<TArgs, TReturnValue>;
    property thisValues: array of Variant;
    property args: array of TArgs;
    property exceptions: array of Variant;
    property returnValues: array of TReturnValue;
    property wrappedMethod: function: TReturnValue;
    function calledBefore(anotherSpy: SinonSpy<Variant>): Boolean;
    function calledAfter(anotherSpy: SinonSpy<Variant>): Boolean;
    function calledImmediatelyBefore(anotherSpy: SinonSpy<Variant>): Boolean;
    function calledImmediatelyAfter(anotherSpy: SinonSpy<Variant>): Boolean;
    function withArgs(args: MatchPartialArguments<TArgs>): SinonSpy<TArgs, TReturnValue>;
    function alwaysCalledOn(obj: Variant): Boolean;
    function alwaysCalledWith(args: MatchExactArguments<TArgs>): Boolean;
    function alwaysCalledWithExactly(args: MatchExactArguments<TArgs>): Boolean;
    function alwaysCalledWithMatch(args: TArgs): Boolean;
    function neverCalledWith(args: MatchExactArguments<TArgs>): Boolean;
    function neverCalledWithMatch(args: TArgs): Boolean;
    function alwaysThrew: Boolean;
    function alwaysThrew(type: String): Boolean;
    function alwaysThrew(obj: Variant): Boolean;
    function alwaysReturned(obj: Variant): Boolean;
    procedure invokeCallback(args: TArgs);
    function named(name: String): SinonSpy<TArgs, TReturnValue>;
    function getCall(n: Float): SinonSpyCall<TArgs, TReturnValue>;
    function getCalls: array of SinonSpyCall<TArgs, TReturnValue>;
    procedure resetHistory;
    function printf(format: String; args: array of Variant): String;
    procedure restore;
  end;

  SinonSpyStatic = interface
  end;

  SinonSpiedInstance = Variant;

  SinonSpiedMember = Variant;

  SinonStub = interface(SinonSpy)
    procedure resetBehavior;
    procedure reset;
    function usingPromise(promiseLibrary: Variant): SinonStub<TArgs, TReturnValue>;
    function returns(obj: TReturnValue): SinonStub<TArgs, TReturnValue>;
    function returnsArg(index: Float): SinonStub<TArgs, TReturnValue>;
    function returnsThis: SinonStub<TArgs, TReturnValue>;
    function resolves(value?: Variant): SinonStub<TArgs, TReturnValue>;
    function resolvesArg(index: Float): SinonStub<TArgs, TReturnValue>;
    function resolvesThis: SinonStub<TArgs, TReturnValue>;
    function throws(type?: String): SinonStub<TArgs, TReturnValue>;
    function throws(obj: Variant): SinonStub<TArgs, TReturnValue>;
    function throwsArg(index: Float): SinonStub<TArgs, TReturnValue>;
    function throwsException(type?: String): SinonStub<TArgs, TReturnValue>;
    function throwsException(obj: Variant): SinonStub<TArgs, TReturnValue>;
    function rejects: SinonStub<TArgs, TReturnValue>;
    function rejects(errorType: String): SinonStub<TArgs, TReturnValue>;
    function rejects(value: Variant): SinonStub<TArgs, TReturnValue>;
    function callsArg(index: Float): SinonStub<TArgs, TReturnValue>;
    function callThrough: SinonStub<TArgs, TReturnValue>;
    function callsArgOn(index: Float; context: Variant): SinonStub<TArgs, TReturnValue>;
    function callsArgWith(index: Float; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function callsArgOnWith(index: Float; context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function callsArgAsync(index: Float): SinonStub<TArgs, TReturnValue>;
    function callsArgOnAsync(index: Float; context: Variant): SinonStub<TArgs, TReturnValue>;
    function callsArgWithAsync(index: Float; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function callsArgOnWithAsync(index: Float; context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function callsFake(func: function: TReturnValue): SinonStub<TArgs, TReturnValue>;
    function get(func: function: Variant): SinonStub<TArgs, TReturnValue>;
    function set(func: procedure): SinonStub<TArgs, TReturnValue>;
    function onCall(n: Float): SinonStub<TArgs, TReturnValue>;
    function onFirstCall: SinonStub<TArgs, TReturnValue>;
    function onSecondCall: SinonStub<TArgs, TReturnValue>;
    function onThirdCall: SinonStub<TArgs, TReturnValue>;
    function value(val: Variant): SinonStub<TArgs, TReturnValue>;
    function named(name: String): SinonStub<TArgs, TReturnValue>;
    function yields(args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsOn(context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsRight(args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsTo(property: String; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsToOn(property: String; context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsAsync(args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsOnAsync(context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsToAsync(property: String; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function yieldsToOnAsync(property: String; context: Variant; args: array of Variant): SinonStub<TArgs, TReturnValue>;
    function withArgs(args: MatchPartialArguments<TArgs>): SinonStub<TArgs, TReturnValue>;
  end;

  SinonStubStatic = interface
  end;

  SinonExpectation = interface(SinonStub)
    function atLeast(n: Float): SinonExpectation;
    function atMost(n: Float): SinonExpectation;
    function never: SinonExpectation;
    function once: SinonExpectation;
    function twice: SinonExpectation;
    function thrice: SinonExpectation;
    function exactly(n: Float): SinonExpectation;
    function withArgs(args: array of Variant): SinonExpectation;
    function withExactArgs(args: array of Variant): SinonExpectation;
    function on(obj: Variant): SinonExpectation;
    function verify: SinonExpectation;
    procedure restore;
  end;

  SinonExpectationStatic = interface
    function create(methodName?: String): SinonExpectation;
  end;

  SinonMock = interface
    function expects(method: String): SinonExpectation;
    procedure restore;
    procedure verify;
  end;

  SinonMockStatic = interface
  end;

  SinonFakeTimers = Variant;

  SinonFakeUploadProgress = interface
    property eventListeners: Variant;
    procedure addEventListener(event: String; listener: function: Variant);
    procedure removeEventListener(event: String; listener: function: Variant);
    procedure dispatchEvent(event: Event);
  end;

  SinonFakeXMLHttpRequest = interface
    property url: String;
    property method: String;
    property requestHeaders: Variant;
    property requestBody: String;
    property status: Float;
    property statusText: String;
    property async: Boolean;
    property username: String;
    property password: String;
    property withCredentials: Boolean;
    property upload: SinonFakeUploadProgress;
    property responseXML: Document;
    function getResponseHeader(header: String): String;
    function getAllResponseHeaders: Variant;
    procedure setResponseHeaders(headers: Variant);
    procedure setResponseBody(body: String);
    procedure respond(status: Float; headers: Variant; body: String);
    procedure autoRespond(ms: Float);
    procedure error;
    procedure onerror;
  end;

  SinonFakeXMLHttpRequestStatic = interface
    property useFilters: Boolean;
    procedure addFilter(filter: function: Boolean);
    procedure onCreate(xhr: SinonFakeXMLHttpRequest);
    procedure restore;
  end;

  SinonFakeServer = interface(SinonFakeServerOptions)
    function getHTTPMethod(request: SinonFakeXMLHttpRequest): String;
    property requests: array of SinonFakeXMLHttpRequest;
    procedure respondWith(body: String);
    procedure respondWith(response: array of Variant);
    procedure respondWith(fn: procedure);
    procedure respondWith(url: String; body: String);
    procedure respondWith(url: String; response: array of Variant);
    procedure respondWith(url: String; fn: procedure);
    procedure respondWith(method: String; url: String; body: String);
    procedure respondWith(method: String; url: String; response: array of Variant);
    procedure respondWith(method: String; url: String; fn: procedure);
    procedure respondWith(url: RegExp; body: String);
    procedure respondWith(url: RegExp; response: array of Variant);
    procedure respondWith(url: RegExp; fn: procedure);
    procedure respondWith(method: String; url: RegExp; body: String);
    procedure respondWith(method: String; url: RegExp; response: array of Variant);
    procedure respondWith(method: String; url: RegExp; fn: procedure);
    procedure respond;
    procedure restore;
  end;

  SinonFakeServerOptions = interface
    property autoRespond: Boolean;
    property autoRespondAfter: Float;
    property fakeHTTPMethods: Boolean;
    property respondImmediately: Boolean;
  end;

  SinonFakeServerStatic = interface
    function create(options?: SinonFakeServerOptions): SinonFakeServer;
  end;

  SinonExposeOptions = interface
    property prefix: String;
    property includeFail: Boolean;
  end;

  SinonAssert = interface
    property failException: String;
    procedure fail(message?: String);
    procedure pass(assertion: Variant);
    procedure notCalled(spy: SinonSpy<Variant>);
    procedure called(spy: SinonSpy<Variant>);
    procedure calledOnce(spy: SinonSpy<Variant>);
    procedure calledTwice(spy: SinonSpy<Variant>);
    procedure calledThrice(spy: SinonSpy<Variant>);
    procedure callCount(spy: SinonSpy<Variant>; count: Float);
    procedure callOrder(spies: array of SinonSpy<Variant>);
    procedure calledOn(spyOrSpyCall: Variant; obj: Variant);
    procedure alwaysCalledOn(spy: SinonSpy<Variant>; obj: Variant);
    procedure calledWith(spyOrSpyCall: Variant; args: MatchPartialArguments<TArgs>);
    procedure alwaysCalledWith(spy: SinonSpy<TArgs>; args: MatchPartialArguments<TArgs>);
    procedure neverCalledWith(spy: SinonSpy<TArgs>; args: MatchPartialArguments<TArgs>);
    procedure calledWithExactly(spyOrSpyCall: Variant; args: MatchExactArguments<TArgs>);
    procedure calledOnceWithExactly(spyOrSpyCall: Variant; args: MatchExactArguments<TArgs>);
    procedure alwaysCalledWithExactly(spy: SinonSpy<TArgs>; args: MatchExactArguments<TArgs>);
    procedure calledWithMatch(spyOrSpyCall: Variant; args: MatchPartialArguments<TArgs>);
    procedure calledOnceWithMatch(spyOrSpyCall: Variant; args: MatchPartialArguments<TArgs>);
    procedure alwaysCalledWithMatch(spy: SinonSpy<TArgs>; args: MatchPartialArguments<TArgs>);
    procedure neverCalledWithMatch(spy: SinonSpy<TArgs>; args: MatchPartialArguments<TArgs>);
    procedure calledWithNew(spyOrSpyCall: Variant);
    procedure threw(spyOrSpyCall: Variant);
    procedure threw(spyOrSpyCall: Variant; exception: String);
    procedure threw(spyOrSpyCall: Variant; exception: Variant);
    procedure alwaysThrew(spy: SinonSpy<Variant>);
    procedure alwaysThrew(spy: SinonSpy<Variant>; exception: String);
    procedure alwaysThrew(spy: SinonSpy<Variant>; exception: Variant);
    procedure match(actual: Variant; expected: Variant);
    procedure expose(obj: Variant; options?: SinonExposeOptions);
  end;

  SinonMatcher = interface
    function and(expr: SinonMatcher): SinonMatcher;
    function or(expr: SinonMatcher): SinonMatcher;
    function test(val: Variant): Boolean;
  end;

  SinonArrayMatcher = interface(SinonMatcher)
    function deepEquals(expected: array of Variant): SinonMatcher;
    function startsWith(expected: array of Variant): SinonMatcher;
    function endsWith(expected: array of Variant): SinonMatcher;
    function contains(expected: array of Variant): SinonMatcher;
  end;

  SimplifiedSet = interface
    function has(el: Variant): Boolean;
  end;

  SimplifiedMap = interface(SimplifiedSet)
    function get(key: Variant): Variant;
  end;

  SinonMapMatcher = interface(SinonMatcher)
    function deepEquals(expected: SimplifiedMap): SinonMatcher;
    function contains(expected: SimplifiedMap): SinonMatcher;
  end;

  SinonSetMatcher = interface(SinonMatcher)
    function deepEquals(expected: SimplifiedSet): SinonMatcher;
    function contains(expected: SimplifiedSet): SinonMatcher;
  end;

  SinonMatch = interface
    property any: SinonMatcher;
    property defined: SinonMatcher;
    property truthy: SinonMatcher;
    property falsy: SinonMatcher;
    property bool: SinonMatcher;
    property number: SinonMatcher;
    property string: SinonMatcher;
    property object: SinonMatcher;
    property func: SinonMatcher;
    property map: SinonMapMatcher;
    property set: SinonSetMatcher;
    property array: SinonArrayMatcher;
    property regexp: SinonMatcher;
    property date: SinonMatcher;
    property symbol: SinonMatcher;
    function in(allowed: array of Variant): SinonMatcher;
    function same(obj: Variant): SinonMatcher;
    function typeOf(type: String): SinonMatcher;
    function instanceOf(type: Variant): SinonMatcher;
    function has(property: String; expect?: Variant): SinonMatcher;
    function hasOwn(property: String; expect?: Variant): SinonMatcher;
    function hasNested(path: String; expect?: Variant): SinonMatcher;
    function every(matcher: SinonMatcher): SinonMatcher;
    function some(matcher: SinonMatcher): SinonMatcher;
  end;

  SinonSandboxConfig = interface
    property injectInto: Variant;
    property properties: array of String;
    property useFakeTimers: Variant;
    property useFakeServer: Variant;
    property assertOptions: Variant;
  end;

  StubbableType = Variant;

  SinonStubbedInstance = Variant;

  SinonStubbedMember = Variant;

  SinonStubbedFunction = Variant;

  SinonFake = interface
    function returns(val: TReturnValue): SinonSpy<TArgs, TReturnValue>;
    function throws(val: Variant): SinonSpy<TArgs, TReturnValue>;
    function resolves(val: Variant): SinonSpy<TArgs, TReturnValue>;
    function rejects(val: Variant): SinonSpy<TArgs, TReturnValue>;
    function yields(args: array of Variant): SinonSpy<TArgs, TReturnValue>;
    function yieldsAsync(args: array of Variant): SinonSpy<TArgs, TReturnValue>;
  end;

  SandboxReplace = interface
    function usingAccessor(obj: T; prop: TKey; replacement: R): R;
  end;

  SinonSandbox = interface
    property assert: SinonAssert;
    property clock: SinonFakeTimers;
    property requests: array of SinonFakeXMLHttpRequest;
    property server: SinonFakeServer;
    property match: SinonMatch;
    property spy: SinonSpyStatic;
    property stub: SinonStubStatic;
    property mock: SinonMockStatic;
    property fake: SinonFake;
    function useFakeTimers(config?: Variant): SinonFakeTimers;
    function useFakeXMLHttpRequest: SinonFakeXMLHttpRequestStatic;
    function useFakeServer: SinonFakeServer;
    procedure restore;
    procedure reset;
    procedure resetHistory;
    procedure resetBehavior;
    function usingPromise(promiseLibrary: Variant): SinonSandbox;
    procedure verify;
    procedure verifyAndRestore;
    property replace: SandboxReplace;
    function replaceGetter(obj: T; prop: TKey; replacement: function: Variant): function: Variant;
    function replaceSetter(obj: T; prop: TKey; replacement: procedure): procedure;
    function createStubInstance(constructor: StubbableType<TType>; overrides?: Variant): SinonStubbedInstance<TType>;
    procedure define(obj: Variant; key: PropertyKey; value: Variant);
  end;

  SinonPromise = Variant;

  SinonApi = interface
    property expectation: SinonExpectationStatic;
    property clock: Variant;
    property FakeXMLHttpRequest: SinonFakeXMLHttpRequestStatic;
    property fakeServer: SinonFakeServerStatic;
    property fakeServerWithClock: SinonFakeServerStatic;
    function createSandbox(config?: SinonSandboxConfig): SinonSandbox;
    property defaultConfig: SinonSandboxConfig;
    property addBehavior: procedure;
    property setFormatter: procedure;
    function promise(executor?: procedure): SinonPromise<T>;
  end;

  SinonStatic = Variant;

implementation



end.
