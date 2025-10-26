unit Chai;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: chai
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Message = Variant;

  ObjectProperty = Variant;

  PathInfo = interface
    property parent: Variant;
    property name: String;
    property value: Variant;
    property exists: Boolean;
  end;

  Constructor = interface
  end;

  ErrorConstructor = interface
  end;

  ChaiUtils = interface
    procedure addChainableMethod(ctx: Variant; name: String; method: procedure; chainingBehavior?: procedure);
    procedure overwriteChainableMethod(ctx: Variant; name: String; method: procedure; chainingBehavior?: procedure);
    procedure addLengthGuard(fn: Function; assertionName: String; isChainable: Boolean);
    procedure addMethod(ctx: Variant; name: String; method: Function);
    procedure addProperty(ctx: Variant; name: String; getter: function: Variant);
    procedure overwriteMethod(ctx: Variant; name: String; method: Function);
    procedure overwriteProperty(ctx: Variant; name: String; getter: function: Variant);
    function compareByInspect(a: Variant; b: Variant): Float;
    procedure expectTypes(obj: Variant; types: array of String);
    function flag(obj: Variant; key: String; value?: Variant): Variant;
    function getActual(obj: Variant; args: AssertionArgs): Variant;
    function getProperties(obj: Variant): array of String;
    function getEnumerableProperties(obj: Variant): array of String;
    function getOwnEnumerablePropertySymbols(obj: Variant): array of String;
    function getOwnEnumerableProperties(obj: Variant): array of String;
    function getMessage(errorLike: Variant): String;
    function getMessage(obj: Variant; args: AssertionArgs): String;
    function inspect(obj: Variant; showHidden?: Boolean; depth?: Float; colors?: Boolean): String;
    function isProxyEnabled: Boolean;
    procedure objDisplay(obj: Variant);
    function proxify(obj: Variant; nonChainableMethodName: String): Variant;
    function test(obj: Variant; args: AssertionArgs): Boolean;
    procedure transferFlags(assertion: Assertion; obj: Variant; includeAll?: Boolean);
    function compatibleInstance(thrown: Error; errorLike: Variant): Boolean;
    function compatibleConstructor(thrown: Error; errorLike: Variant): Boolean;
    function compatibleMessage(thrown: Error; errMatcher: Variant): Boolean;
    function getConstructorName(constructorFn: Function): String;
    function getFuncName(constructorFn: Function): String;
    function hasProperty(obj: Variant; name: ObjectProperty): Boolean;
    function getPathInfo(obj: Variant; path: String): PathInfo;
    function getPathValue(obj: Variant; path: String): Variant;
    property eql: Variant;
  end;

  ChaiPlugin = procedure;

  ChaiStatic = interface
    property expect: ExpectStatic;
    function should: Should;
    function use(fn: ChaiPlugin): ChaiStatic;
    property util: ChaiUtils;
    property assert: AssertStatic;
    property config: Config;
    property Assertion: AssertionStatic;
    property AssertionError: Variant;
    property version: String;
  end;

  ExpectStatic = interface
    function fail(message?: String): Variant;
    function fail(actual: Variant; expected: Variant; message?: String; operator?: Operator): Variant;
  end;

  AssertStatic = interface(Assert)
  end;

  AssertionArgs = array of Variant;

  AssertionPrototype = interface
    procedure assert(args: AssertionArgs);
    property _obj: Variant;
  end;

  AssertionStatic = interface(AssertionPrototype)
    property prototype: AssertionPrototype;
    property includeStack: Boolean;
    property showDiff: Boolean;
    procedure addProperty(name: String; getter: function: Variant);
    procedure addMethod(name: String; method: function: Variant);
    procedure addChainableMethod(name: String; method: procedure; chainingBehavior?: procedure);
    procedure overwriteProperty(name: String; getter: function: Variant);
    procedure overwriteMethod(name: String; method: function: Variant);
    procedure overwriteChainableMethod(name: String; method: procedure; chainingBehavior?: procedure);
  end;

  Operator = String;

  OperatorComparable = Variant;

  ShouldAssertion = interface
    procedure equal(value1: Variant; value2: Variant; message?: String);
    property Throw: ShouldThrow;
    property throw: ShouldThrow;
    procedure exist(value: Variant; message?: String);
  end;

  Should = interface(ShouldAssertion)
    property not: ShouldAssertion;
    function fail(message?: String): Variant;
    function fail(actual: Variant; expected: Variant; message?: String; operator?: Operator): Variant;
  end;

  ShouldThrow = interface
  end;

  Assertion = interface(LanguageChains, NumericComparison, TypeComparison)
    property not: Assertion;
    property deep: Deep;
    property ordered: Ordered;
    property nested: Nested;
    property own: Own;
    property any: KeyFilter;
    property all: KeyFilter;
    property a: Assertion;
    property an: Assertion;
    property include: Include;
    property includes: Include;
    property contain: Include;
    property contains: Include;
    property ok: Assertion;
    property true: Assertion;
    property false: Assertion;
    property null: Assertion;
    property undefined: Assertion;
    property NaN: Assertion;
    property exist: Assertion;
    property empty: Assertion;
    property arguments: Assertion;
    property Arguments: Assertion;
    property finite: Assertion;
    property equal: Equal;
    property equals: Equal;
    property eq: Equal;
    property eql: Equal;
    property eqls: Equal;
    property containSubset: ContainSubset;
    property property: Property;
    property ownProperty: Property;
    property haveOwnProperty: Property;
    property ownPropertyDescriptor: OwnPropertyDescriptor;
    property haveOwnPropertyDescriptor: OwnPropertyDescriptor;
    property length: Length;
    property lengthOf: Length;
    property match: Match;
    property matches: Match;
    function string(string: String; message?: String): Assertion;
    property keys: Keys;
    function key(string: String): Assertion;
    property throw: Throw;
    property throws: Throw;
    property Throw: Throw;
    property respondTo: RespondTo;
    property respondsTo: RespondTo;
    property itself: Assertion;
    property satisfy: Satisfy;
    property satisfies: Satisfy;
    property closeTo: CloseTo;
    property approximately: CloseTo;
    property members: Members;
    property increase: PropertyChange;
    property increases: PropertyChange;
    property decrease: PropertyChange;
    property decreases: PropertyChange;
    property change: PropertyChange;
    property changes: PropertyChange;
    property extensible: Assertion;
    property sealed: Assertion;
    property frozen: Assertion;
    property oneOf: OneOf;
  end;

  LanguageChains = interface
    property to: Assertion;
    property be: Assertion;
    property been: Assertion;
    property is: Assertion;
    property that: Assertion;
    property which: Assertion;
    property and: Assertion;
    property has: Assertion;
    property have: Assertion;
    property with: Assertion;
    property at: Assertion;
    property of: Assertion;
    property same: Assertion;
    property but: Assertion;
    property does: Assertion;
  end;

  NumericComparison = interface
    property above: NumberComparer;
    property gt: NumberComparer;
    property greaterThan: NumberComparer;
    property least: NumberComparer;
    property gte: NumberComparer;
    property greaterThanOrEqual: NumberComparer;
    property below: NumberComparer;
    property lt: NumberComparer;
    property lessThan: NumberComparer;
    property most: NumberComparer;
    property lte: NumberComparer;
    property lessThanOrEqual: NumberComparer;
    function within(start: Float; finish: Float; message?: String): Assertion;
    function within(start: Date; finish: Date; message?: String): Assertion;
  end;

  NumberComparer = interface
  end;

  TypeComparison = interface
    property instanceof: InstanceOf;
    property instanceOf: InstanceOf;
  end;

  InstanceOf = interface
  end;

  CloseTo = interface
  end;

  Nested = interface
    property include: Include;
    property includes: Include;
    property contain: Include;
    property contains: Include;
    property property: Property;
    property members: Members;
  end;

  Own = interface
    property include: Include;
    property includes: Include;
    property contain: Include;
    property contains: Include;
    property property: Property;
  end;

  Deep = interface(KeyFilter)
    property be: Assertion;
    property equal: Equal;
    property equals: Equal;
    property eq: Equal;
    property include: Include;
    property includes: Include;
    property contain: Include;
    property contains: Include;
    property property: Property;
    property ordered: Ordered;
    property nested: Nested;
    property oneOf: OneOf;
    property own: Own;
  end;

  Ordered = interface
    property members: Members;
  end;

  KeyFilter = interface
    property keys: Keys;
    property members: Members;
  end;

  Equal = interface
  end;

  ContainSubset = interface
  end;

  Property = interface
  end;

  OwnPropertyDescriptor = interface
  end;

  Length = interface(LanguageChains, NumericComparison)
  end;

  Include = interface
    property keys: Keys;
    property deep: Deep;
    property ordered: Ordered;
    property members: Members;
    property any: KeyFilter;
    property all: KeyFilter;
    property oneOf: OneOf;
  end;

  OneOf = interface
  end;

  Match = interface
  end;

  Keys = interface
  end;

  Throw = interface
  end;

  RespondTo = interface
  end;

  Satisfy = interface
  end;

  Members = interface
  end;

  PropertyChange = interface
  end;

  DeltaAssertion = interface(Assertion)
    function by(delta: Float; msg?: String): Assertion;
  end;

  Assert = interface
    function fail(message?: String): Variant;
    function fail(actual: T; expected: T; message?: String; operator?: Operator): Variant;
    function isOk(value: Variant; message?: String): Variant;
    function ok(value: Variant; message?: String): Variant;
    procedure isNotOk(value: T; message?: String);
    procedure notOk(value: T; message?: String);
    procedure equal(actual: T; expected: T; message?: String);
    procedure notEqual(actual: T; expected: T; message?: String);
    procedure strictEqual(actual: T; expected: T; message?: String);
    procedure notStrictEqual(actual: T; expected: T; message?: String);
    procedure deepEqual(actual: T; expected: T; message?: String);
    procedure notDeepEqual(actual: T; expected: T; message?: String);
    procedure deepStrictEqual(actual: T; expected: T; message?: String);
    procedure containSubset(val: Variant; exp: Variant; msg?: String);
    procedure containsSubset(val: Variant; exp: Variant; msg?: String);
    procedure doesNotContainSubset(val: Variant; exp: Variant; msg?: String);
    procedure isAbove(valueToCheck: Float; valueToBeAbove: Float; message?: String);
    procedure isAtLeast(valueToCheck: Float; valueToBeAtLeast: Float; message?: String);
    procedure isBelow(valueToCheck: Float; valueToBeBelow: Float; message?: String);
    procedure isAtMost(valueToCheck: Float; valueToBeAtMost: Float; message?: String);
    function isTrue(value: Variant; message?: String): Variant;
    function isFalse(value: Variant; message?: String): Variant;
    function isNotTrue(value: T; message?: String): Variant;
    function isNotFalse(value: T; message?: String): Variant;
    function isNull(value: Variant; message?: String): Variant;
    function isNotNull(value: T; message?: String): Variant;
    procedure isNaN(value: T; message?: String);
    procedure isNotNaN(value: T; message?: String);
    function exists(value: T; message?: String): Variant;
    function notExists(value: Variant; message?: String): Variant;
    function isUndefined(value: Variant; message?: String): Variant;
    function isDefined(value: T; message?: String): Variant;
    procedure isFunction(value: T; message?: String);
    procedure isNotFunction(value: T; message?: String);
    procedure isObject(value: T; message?: String);
    procedure isNotObject(value: T; message?: String);
    procedure isArray(value: T; message?: String);
    procedure isNotArray(value: T; message?: String);
    procedure isString(value: T; message?: String);
    procedure isNotString(value: T; message?: String);
    procedure isNumber(value: T; message?: String);
    procedure isNotNumber(value: T; message?: String);
    procedure isFinite(value: T; message?: String);
    procedure isBoolean(value: T; message?: String);
    procedure isNotBoolean(value: T; message?: String);
    procedure typeOf(value: T; name: String; message?: String);
    procedure notTypeOf(value: T; name: String; message?: String);
    function instanceOf(value: Variant; constructor: Constructor<T>; message?: String): Variant;
    function notInstanceOf(value: T; type: Constructor<U>; message?: String): Variant;
    procedure include(haystack: String; needle: String; message?: String);
    procedure include(haystack: Variant; needle: T; message?: String);
    procedure include(haystack: WeakSet<T>; needle: T; message?: String);
    procedure include(haystack: T; needle: T; message?: String);
    procedure notInclude(haystack: String; needle: String; message?: String);
    procedure notInclude(haystack: Variant; needle: T; message?: String);
    procedure notInclude(haystack: WeakSet<T>; needle: T; message?: String);
    procedure notInclude(haystack: T; needle: T; message?: String);
    procedure deepInclude(haystack: String; needle: String; message?: String);
    procedure deepInclude(haystack: Variant; needle: T; message?: String);
    procedure deepInclude(haystack: T; needle: Variant; message?: String);
    procedure notDeepInclude(haystack: String; needle: String; message?: String);
    procedure notDeepInclude(haystack: Variant; needle: T; message?: String);
    procedure notDeepInclude(haystack: T; needle: Variant; message?: String);
    procedure nestedInclude(haystack: Variant; needle: Variant; message?: String);
    procedure notNestedInclude(haystack: Variant; needle: Variant; message?: String);
    procedure deepNestedInclude(haystack: Variant; needle: Variant; message?: String);
    procedure notDeepNestedInclude(haystack: Variant; needle: Variant; message?: String);
    procedure ownInclude(haystack: Variant; needle: Variant; message?: String);
    procedure notOwnInclude(haystack: Variant; needle: Variant; message?: String);
    procedure deepOwnInclude(haystack: Variant; needle: Variant; message?: String);
    procedure notDeepOwnInclude(haystack: Variant; needle: Variant; message?: String);
    procedure match(value: String; regexp: RegExp; message?: String);
    procedure notMatch(expected: Variant; regexp: RegExp; message?: String);
    procedure property(object: T; property: String; message?: String);
    procedure notProperty(object: T; property: String; message?: String);
    procedure deepProperty(object: T; property: String; message?: String);
    procedure notDeepProperty(object: T; property: String; message?: String);
    procedure propertyVal(object: T; property: String; value: V; message?: String);
    procedure notPropertyVal(object: T; property: String; value: V; message?: String);
    procedure deepPropertyVal(object: T; property: String; value: V; message?: String);
    procedure notDeepPropertyVal(object: T; property: String; value: V; message?: String);
    procedure lengthOf(object: T; length: Float; message?: String);
    procedure throw(fn: procedure; errMsgMatcher?: Variant; ignored?: Variant; message?: String);
    procedure throw(fn: procedure; errorLike?: Variant; errMsgMatcher?: Variant; message?: String);
    procedure throws(fn: procedure; errMsgMatcher?: Variant; ignored?: Variant; message?: String);
    procedure throws(fn: procedure; errorLike?: Variant; errMsgMatcher?: Variant; message?: String);
    procedure Throw(fn: procedure; errMsgMatcher?: Variant; ignored?: Variant; message?: String);
    procedure Throw(fn: procedure; errorLike?: Variant; errMsgMatcher?: Variant; message?: String);
    procedure doesNotThrow(fn: procedure; errMsgMatcher?: Variant; ignored?: Variant; message?: String);
    procedure doesNotThrow(fn: procedure; errorLike?: Variant; errMsgMatcher?: Variant; message?: String);
    procedure operator(val1: OperatorComparable; operator: Operator; val2: OperatorComparable; message?: String);
    procedure closeTo(actual: Float; expected: Float; delta: Float; message?: String);
    procedure approximately(act: Float; exp: Float; delta: Float; message?: String);
    procedure sameMembers(set1: array of T; set2: array of T; message?: String);
    procedure sameDeepMembers(set1: array of T; set2: array of T; message?: String);
    procedure notSameDeepMembers(set1: array of T; set2: array of T; message?: String);
    procedure sameOrderedMembers(set1: array of T; set2: array of T; message?: String);
    procedure notSameOrderedMembers(set1: array of T; set2: array of T; message?: String);
    procedure sameDeepOrderedMembers(set1: array of T; set2: array of T; message?: String);
    procedure notSameDeepOrderedMembers(set1: array of T; set2: array of T; message?: String);
    procedure includeOrderedMembers(superset: array of T; subset: array of T; message?: String);
    procedure notIncludeOrderedMembers(superset: array of T; subset: array of T; message?: String);
    procedure includeDeepOrderedMembers(superset: array of T; subset: array of T; message?: String);
    procedure notIncludeDeepOrderedMembers(superset: array of T; subset: array of T; message?: String);
    procedure includeMembers(superset: array of T; subset: array of T; message?: String);
    procedure notIncludeMembers(superset: array of T; subset: array of T; message?: String);
    procedure includeDeepMembers(superset: array of T; subset: array of T; message?: String);
    procedure notIncludeDeepMembers(superset: array of T; subset: array of T; message?: String);
    procedure oneOf(inList: T; list: array of T; message?: String);
    procedure changes(modifier: Function; object: T; property: String; message?: String);
    procedure changesBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure changesBy(modifier: Function; object: T; change: Float; message?: String);
    procedure doesNotChange(modifier: Function; object: T; property: String; message?: String);
    procedure increases(modifier: Function; object: T; property: String; message?: String);
    procedure increasesBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure increasesBy(modifier: Function; object: T; change: Float; message?: String);
    procedure doesNotIncrease(modifier: Function; object: T; property: String; message?: String);
    procedure increasesButNotBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure increasesButNotBy(modifier: Function; object: T; change: Float; message?: String);
    procedure decreases(modifier: Function; object: T; property: String; message?: String);
    procedure decreasesBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure decreasesBy(modifier: Function; object: T; change: Float; message?: String);
    procedure doesNotDecrease(modifier: Function; object: T; property: String; message?: String);
    procedure doesNotDecreaseBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure doesNotDecreaseBy(modifier: Function; object: T; change: Float; message?: String);
    procedure decreasesButNotBy(modifier: Function; object: T; property: String; change: Float; message?: String);
    procedure decreasesButNotBy(modifier: Function; object: T; change: Float; message?: String);
    procedure ifError(object: T; message?: String);
    procedure isExtensible(object: T; message?: String);
    procedure extensible(object: T; message?: String);
    procedure isNotExtensible(object: T; message?: String);
    procedure notExtensible(object: T; message?: String);
    procedure isSealed(object: T; message?: String);
    procedure sealed(object: T; message?: String);
    procedure isNotSealed(object: T; message?: String);
    procedure notSealed(object: T; message?: String);
    procedure isFrozen(object: T; message?: String);
    procedure frozen(object: T; message?: String);
    procedure isNotFrozen(object: T; message?: String);
    procedure notFrozen(object: T; message?: String);
    procedure isEmpty(object: T; message?: String);
    procedure isNotEmpty(object: T; message?: String);
    procedure hasAnyKeys(object: T; keys: array of Variant; message?: String);
    procedure hasAllKeys(object: T; keys: array of Variant; message?: String);
    procedure containsAllKeys(object: T; keys: array of Variant; message?: String);
    procedure doesNotHaveAnyKeys(object: T; keys: array of Variant; message?: String);
    procedure doesNotHaveAllKeys(object: T; keys: array of Variant; message?: String);
    procedure hasAnyDeepKeys(object: T; keys: array of Variant; message?: String);
    procedure hasAllDeepKeys(object: T; keys: array of Variant; message?: String);
    procedure containsAllDeepKeys(object: T; keys: array of Variant; message?: String);
    procedure doesNotHaveAnyDeepKeys(object: T; keys: array of Variant; message?: String);
    procedure doesNotHaveAllDeepKeys(object: T; keys: array of Variant; message?: String);
    procedure nestedProperty(object: T; property: String; message?: String);
    procedure notNestedProperty(object: T; property: String; message?: String);
    procedure nestedPropertyVal(object: T; property: String; value: Variant; message?: String);
    procedure notNestedPropertyVal(object: T; property: String; value: Variant; message?: String);
    procedure deepNestedPropertyVal(object: T; property: String; value: Variant; message?: String);
    procedure notDeepNestedPropertyVal(object: T; property: String; value: Variant; message?: String);
  end;

  Config = interface
    property includeStack: Boolean;
    property showDiff: Boolean;
    property truncateThreshold: Float;
    property useProxy: Boolean;
    property proxyExcludedKeys: array of String;
    property deepEqual: procedure;
  end;

  function use(fn: Chai.ChaiPlugin): Chai.ChaiStatic;

  function should: Chai.Should;

  function Should: Chai.Should;

implementation



end.
