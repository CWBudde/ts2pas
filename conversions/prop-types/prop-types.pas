unit Prop_types;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: prop-types
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ReactComponentLike = Variant;

  ReactElementLike = interface
    property type: ReactComponentLike;
    property props: Variant;
    property key: String;
  end;

  ReactNodeArray = interface(Iterable)
  end;

  AwaitedReactNodeLike = Variant;

  ReactNodeLike = Variant;

  IsOptional = Variant;

  RequiredKeys = Variant;

  OptionalKeys = Exclude<Variant, RequiredKeys<V>>;

  InferPropsInner = Variant;

  Validator = interface
  end;

  Requireable = interface(Validator)
    property isRequired: Validator<NonNullable<T>>;
  end;

  ValidationMap = Variant;

  WeakValidationMap = Variant;

  InferType = Variant;

  InferProps = Variant;

  function instanceOf(expectedClass: T): Requireable<T>;

  function oneOf(types: Variant): Requireable<T>;

  function oneOfType(types: array of T): Requireable<NonNullable<InferType<T>>>;

  function arrayOf(type: Validator<T>): Requireable<array of T>;

  function objectOf(type: Validator<T>): Requireable<Variant>;

  function shape(type: P): Requireable<InferProps<P>>;

  function exact(type: P): Requireable<InferProps<P>>;

  procedure checkPropTypes(typeSpecs: Variant; values: Variant; location: String; componentName: String; getStack?: function: Variant);

  procedure resetWarningCache;

implementation



end.
