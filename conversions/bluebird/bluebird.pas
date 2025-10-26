unit Bluebird;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: bluebird
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Constructor = E;

  CatchFilter = function: Boolean;

  Resolvable = Variant;

  IterateFunction = function: Resolvable<R>;

  PromisifyAllKeys = Variant;

  WithoutLast = Variant;

  Last = Variant;

  ExtractCallbackValueType = Variant;

  PromiseMethod = Variant;

  ExtractAsyncMethod = Variant;

  PromisifyAllItems = Variant;

  NonNeverValues = Variant;

  PromisifyAll = Variant;

  Bluebird = class(PromiseLike, Bluebird.Inspection) external
    procedure Create(callback: procedure);
    function then(onFulfill?: function: Resolvable<U>; onReject?: function: Resolvable<U>): Bluebird<U>;
    function then(onfulfilled?: function: Resolvable<TResult1>; onrejected?: function: Resolvable<TResult2>): Bluebird<Variant>;
    function catch(onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; filter4: Constructor<E4>; filter5: Constructor<E5>; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; filter5: Variant; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; filter4: Constructor<E4>; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Variant; filter2: Variant; filter3: Variant; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Constructor<E1>; filter2: Constructor<E2>; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Variant; filter2: Variant; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Constructor<E1>; onReject: function: Resolvable<U>): Bluebird<Variant>;
    function catch(filter1: Variant; onReject: function: Resolvable<U>): Bluebird<Variant>;
    property caught: Variant;
    function error(onReject: function: Resolvable<U>): Bluebird<U>;
    function finally(handler: function: Resolvable<Variant>): Bluebird<R>;
    property lastly: Variant;
    function bind(thisArg: Variant): Bluebird<R>;
    procedure done(onFulfilled?: function: Resolvable<U>; onRejected?: function: Resolvable<U>);
    function tap(onFulFill: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; filter4: Constructor<E4>; filter5: Constructor<E5>; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; filter5: Variant; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; filter4: Constructor<E4>; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Constructor<E1>; filter2: Constructor<E2>; filter3: Constructor<E3>; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Variant; filter2: Variant; filter3: Variant; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Constructor<E1>; filter2: Constructor<E2>; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Variant; filter2: Variant; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Constructor<E1>; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function tapCatch(filter1: Variant; onReject: function: Resolvable<Variant>): Bluebird<R>;
    function delay(ms: Float): Bluebird<R>;
    function timeout(ms: Float; message?: Variant): Bluebird<R>;
    function nodeify(callback: procedure; options?: Bluebird.SpreadOption): Variant;
    function nodeify(sink: array of Variant): Variant;
    function asCallback(callback: procedure; options?: Bluebird.SpreadOption): Variant;
    function asCallback(sink: array of Variant): Variant;
    function isFulfilled: Boolean;
    function isRejected: Boolean;
    function isPending: Boolean;
    function isCancelled: Boolean;
    function isResolved: Boolean;
    function value: R;
    function reason: Variant;
    function reflect: Bluebird<Bluebird.Inspection<R>>;
    function call(this: Bluebird<Q>; propertyName: U; args: array of Variant): Bluebird<Variant>;
    function get(key: U): Bluebird<Variant>;
    function return: Bluebird<>;
    function return(value: U): Bluebird<U>;
    function thenReturn: Bluebird<>;
    function thenReturn(value: U): Bluebird<U>;
    function throw(reason: Error): Bluebird<Variant>;
    function thenThrow(reason: Error): Bluebird<Variant>;
    function catchReturn(value: U): Bluebird<Variant>;
    function catchReturn(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; filter4: Constructor<Error>; filter5: Constructor<Error>; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; filter5: Variant; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; filter4: Constructor<Error>; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Variant; filter2: Variant; filter3: Variant; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Constructor<Error>; filter2: Constructor<Error>; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Variant; filter2: Variant; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Constructor<Error>; value: U): Bluebird<Variant>;
    function catchReturn(filter1: Variant; value: U): Bluebird<Variant>;
    function catchThrow(reason: Error): Bluebird<R>;
    function catchThrow(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; filter4: Constructor<Error>; filter5: Constructor<Error>; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; filter5: Variant; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; filter4: Constructor<Error>; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Variant; filter2: Variant; filter3: Variant; filter4: Variant; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Constructor<Error>; filter2: Constructor<Error>; filter3: Constructor<Error>; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Variant; filter2: Variant; filter3: Variant; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Constructor<Error>; filter2: Constructor<Error>; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Variant; filter2: Variant; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Constructor<Error>; reason: Error): Bluebird<R>;
    function catchThrow(filter1: Variant; reason: Error): Bluebird<R>;
    function toString: String;
    function toJSON: Variant;
    function spread(this: Bluebird<Variant>; fulfilledHandler: function: Resolvable<U>): Bluebird<U>;
    function all(this: Bluebird<array of Variant>): Bluebird<array of Variant>;
    function all(this: Bluebird<array of Resolvable<T1>>): Bluebird<array of T1>;
    function all(this: Bluebird<Iterable<Resolvable<R>>>): Bluebird<array of R>;
    function all: Bluebird<Variant>;
    function props(this: PromiseLike<Variant>): Bluebird<Variant>;
    function props(this: PromiseLike<Bluebird.ResolvableProps<T>>): Bluebird<T>;
    function any(this: Bluebird<Variant>): Bluebird<Q>;
    function any: Bluebird<Variant>;
    function some(this: Bluebird<Variant>; count: Float): Bluebird<R>;
    function some(count: Float): Bluebird<Variant>;
    function race(this: Bluebird<Variant>): Bluebird<Q>;
    function race: Bluebird<Variant>;
    function map(this: Bluebird<Variant>; mapper: IterateFunction<Q, U>; options?: Bluebird.ConcurrencyOption): Bluebird<array of U>;
    function reduce(this: Bluebird<Variant>; reducer: function: Resolvable<U>; initialValue?: Resolvable<U>): Bluebird<U>;
    function filter(this: Bluebird<Variant>; filterer: IterateFunction<Q, Boolean>; options?: Bluebird.ConcurrencyOption): Bluebird<R>;
    function each(this: Bluebird<Variant>; iterator: IterateFunction<Q, Variant>): Bluebird<R>;
    function mapSeries(this: Bluebird<Variant>; iterator: IterateFunction<Q, U>): Bluebird<array of U>;
    procedure cancel;
    procedure suppressUnhandledRejections;
    function try(fn: function: Resolvable<R>): Bluebird<R>; static
    function attempt(fn: function: Resolvable<R>): Bluebird<R>; static
    function method(fn: function: Resolvable<R>): function: Bluebird<R>; static
    function resolve: Bluebird<>; static
    function resolve(value: Resolvable<R>): Bluebird<R>; static
    function reject(reason: Variant): Bluebird<Variant>; static
    function defer: Bluebird.Resolver<R>; static
    function cast(value: Resolvable<R>): Bluebird<R>; static
    function bind(thisArg: Variant): Bluebird<>; static
    function is(value: Variant): Boolean; static
    procedure longStackTraces; static
    function delay(ms: Float; value: Resolvable<R>): Bluebird<R>; static
    function delay(ms: Float): Bluebird<>; static
    function promisify(func: procedure; options?: Bluebird.PromisifyOptions): function: Bluebird<T>; static
    function promisify(nodeFunction: procedure; options?: Bluebird.PromisifyOptions): function: Bluebird<Variant>; static
    function promisifyAll(target: T; options?: Bluebird.PromisifyAllOptions<T>): PromisifyAll<T>; static
    function fromNode(resolver: procedure; options?: Bluebird.FromNodeOptions): Bluebird<T>; static
    function fromCallback(resolver: procedure; options?: Bluebird.FromNodeOptions): Bluebird<T>; static
    function coroutine(generatorFunction: function: IterableIterator<Variant>; options?: Bluebird.CoroutineOptions): function: Bluebird<T>; static
    procedure onPossiblyUnhandledRejection(handler: function: Variant); static
    procedure onPossiblyUnhandledRejection(handler?: procedure); static
    function all(values: array of Variant): Bluebird<array of Variant>; static
    function all(values: array of Resolvable<T1>): Bluebird<array of T1>; static
    function all(values: Resolvable<Iterable<Resolvable<R>>>): Bluebird<array of R>; static
    function allSettled(values: array of Variant): Bluebird<array of Variant>; static
    function allSettled(values: array of Resolvable<T1>): Bluebird<array of Bluebird.Inspection<T1>>; static
    function allSettled(values: Resolvable<Iterable<Resolvable<R>>>): Bluebird<array of Bluebird.Inspection<R>>; static
    function props(map: Resolvable<Variant>): Bluebird<Variant>; static
    function props(object: PromiseLike<Bluebird.ResolvableProps<T>>): Bluebird<T>; static
    function props(object: Bluebird.ResolvableProps<T>): Bluebird<T>; static
    function any(values: Resolvable<Iterable<Resolvable<R>>>): Bluebird<R>; static
    function race(values: Resolvable<Iterable<Resolvable<R>>>): Bluebird<R>; static
    function some(values: Resolvable<Iterable<Resolvable<R>>>; count: Float): Bluebird<array of R>; static
    function join(arg1: Resolvable<A1>; handler: function: Resolvable<R>): Bluebird<R>; static
    function join(arg1: Resolvable<A1>; arg2: Resolvable<A2>; handler: function: Resolvable<R>): Bluebird<R>; static
    function join(arg1: Resolvable<A1>; arg2: Resolvable<A2>; arg3: Resolvable<A3>; handler: function: Resolvable<R>): Bluebird<R>; static
    function join(arg1: Resolvable<A1>; arg2: Resolvable<A2>; arg3: Resolvable<A3>; arg4: Resolvable<A4>; handler: function: Resolvable<R>): Bluebird<R>; static
    function join(arg1: Resolvable<A1>; arg2: Resolvable<A2>; arg3: Resolvable<A3>; arg4: Resolvable<A4>; arg5: Resolvable<A5>; handler: function: Resolvable<R>): Bluebird<R>; static
    function join(values: array of Resolvable<R>): Bluebird<array of R>; static
    function map(values: Resolvable<Iterable<Resolvable<R>>>; mapper: IterateFunction<R, U>; options?: Bluebird.ConcurrencyOption): Bluebird<array of U>; static
    function reduce(values: Resolvable<Iterable<Resolvable<R>>>; reducer: function: Resolvable<U>; initialValue?: Resolvable<U>): Bluebird<U>; static
    function filter(values: Resolvable<Iterable<Resolvable<R>>>; filterer: IterateFunction<R, Boolean>; option?: Bluebird.ConcurrencyOption): Bluebird<array of R>; static
    function each(values: Resolvable<Iterable<Resolvable<R>>>; iterator: IterateFunction<R, Variant>): Bluebird<array of R>; static
    function mapSeries(values: Resolvable<Iterable<Resolvable<R>>>; iterator: IterateFunction<R, U>): Bluebird<array of U>; static
    function disposer(disposeFn: function: Resolvable<>): Bluebird.Disposer<R>;
    function using(disposer: Bluebird.Disposer<R>; executor: function: PromiseLike<T>): Bluebird<T>; static
    function using(disposer: Bluebird.Disposer<R1>; disposer2: Bluebird.Disposer<R2>; executor: function: PromiseLike<T>): Bluebird<T>; static
    function using(disposer: Bluebird.Disposer<R1>; disposer2: Bluebird.Disposer<R2>; disposer3: Bluebird.Disposer<R3>; executor: function: PromiseLike<T>): Bluebird<T>; static
    procedure config(options: Variant); static
    property Promise: Variant;
    property version: String;
  end;

  ConcurrencyOption = interface
    property concurrency: Float;
  end;

  SpreadOption = interface
    property spread: Boolean;
  end;

  FromNodeOptions = interface
    property multiArgs: Boolean;
  end;

  PromisifyOptions = interface
    property context: Variant;
    property multiArgs: Boolean;
  end;

  PromisifyAllOptions = interface(PromisifyOptions)
    property suffix: String;
    function filter(name: String; func: function: Variant; target?: Variant; passesDefaultFilter?: Boolean): Boolean;
    function promisifier(this: T; originalMethod: function: Variant; defaultPromisifer: function: function: Bluebird<Variant>): function: PromiseLike<Variant>;
  end;

  CoroutineOptions = interface
    function yieldHandler(value: Variant): Variant;
  end;

  OperationalError = class(Error) external
  end;

  TimeoutError = class(Error) external
  end;

  CancellationError = class(Error) external
  end;

  AggregateError = class(Error, ArrayLike) external
    property length: Float;
    function join(separator?: String): String;
    function pop: Error;
    function push(errors: array of Error): Float;
    function shift: Error;
    function unshift(errors: array of Error): Float;
    function slice(begin?: Float; end?: Float): AggregateError;
    function filter(callback: function: Boolean; thisArg?: Variant): AggregateError;
    function forEach(callback: procedure; thisArg?: Variant): Variant;
    function some(callback: function: Boolean; thisArg?: Variant): Boolean;
    function every(callback: function: Boolean; thisArg?: Variant): Boolean;
    function map(callback: function: Boolean; thisArg?: Variant): AggregateError;
    function indexOf(searchElement: Error; fromIndex?: Float): Float;
    function lastIndexOf(searchElement: Error; fromIndex?: Float): Float;
    function reduce(callback: function: Variant; initialValue?: Variant): Variant;
    function reduceRight(callback: function: Variant; initialValue?: Variant): Variant;
    function sort(compareFunction?: function: Float): AggregateError;
    function reverse: AggregateError;
  end;

  Disposer = class external
  end;

  Thenable = PromiseLike<T>;

  ResolvableProps = Variant;

  Resolver = interface
    property promise: Bluebird<R>;
    procedure resolve(value: R);
    procedure resolve;
    procedure reject(reason: Variant);
    procedure callback(err: Variant; value: R; values: array of R);
  end;

  Inspection = interface
    function isFulfilled: Boolean;
    function isRejected: Boolean;
    function isCancelled: Boolean;
    function isPending: Boolean;
    function value: R;
    function reason: Variant;
  end;

  function getNewLibraryCopy: Variant;

  function noConflict: Variant;

  procedure setScheduler(scheduler: procedure);

implementation



end.
