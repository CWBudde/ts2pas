unit React_redux;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-redux
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  DefaultRootState = interface
  end;

  AnyIfEmpty = Variant;

  RootStateOrAny = AnyIfEmpty<DefaultRootState>;

  Omit = Pick<T, Exclude<Variant, K>>;

  DistributiveOmit = Variant;

  DispatchProp = interface
    property dispatch: Dispatch<A>;
  end;

  AdvancedComponentDecorator = function: NamedExoticComponent<TOwnProps>;

  Matching = Variant;

  Shared = Variant;

  GetProps = Variant;

  GetLibraryManagedProps = JSX.LibraryManagedAttributes<C, GetProps<C>>;

  ConnectedComponent = Variant;

  InferableComponentEnhancerWithProps = function: ConnectedComponent<C, Variant>;

  InferableComponentEnhancer = InferableComponentEnhancerWithProps<TInjectedProps, Variant>;

  InferThunkActionCreatorType = Variant;

  HandleThunkActionCreator = Variant;

  ResolveThunks = Variant;

  ResolveArrayThunks = Variant;

  Connect = interface
  end;

  ConnectedProps = Variant;

  MapStateToProps = function: TStateProps;

  MapStateToPropsFactory = function: MapStateToProps<TStateProps, TOwnProps, State>;

  MapStateToPropsParam = Variant;

  MapDispatchToPropsFunction = function: TDispatchProps;

  MapDispatchToProps = Variant;

  MapDispatchToPropsFactory = function: MapDispatchToPropsFunction<TDispatchProps, TOwnProps>;

  MapDispatchToPropsParam = Variant;

  MapDispatchToPropsNonObject = Variant;

  MergeProps = function: TMergedProps;

  Options = interface(ConnectOptions)
    property pure: Boolean;
    property areStatesEqual: function: Boolean;
    property areOwnPropsEqual: function: Boolean;
    property areStatePropsEqual: function: Boolean;
    property areMergedPropsEqual: function: Boolean;
    property forwardRef: Boolean;
  end;

  function connectAdvanced(selectorFactory: SelectorFactory<S, TProps, TOwnProps, TFactoryOptions>; connectOptions?: Variant): AdvancedComponentDecorator<TProps, TOwnProps>;

  SelectorFactory = function: Selector<S, TProps, TOwnProps>;

  Selector = Variant;

  ConnectOptions = interface
    property getDisplayName: function: String;
    property methodName: String;
    property renderCountProp: String;
    property shouldHandleStateChanges: Boolean;
    property storeKey: String;
    property withRef: Boolean;
    property context: Context<ReactReduxContextValue>;
  end;

  ReactReduxContextValue = interface
    property store: Store<SS, A>;
    property storeState: SS;
  end;

  ProviderProps = interface
    property store: Store<Variant, A>;
    property context: Context<ReactReduxContextValue>;
    property children: ReactNode;
  end;

  Provider = class(Component) external
  end;

  procedure batch(cb: procedure);

  function shallowEqual(left: T; right: Variant): Boolean;

  function useDispatch: TDispatch;

  function useDispatch: Dispatch<A>;

  function useSelector(selector: function: TSelected; equalityFn?: function: Boolean): TSelected;

  TypedUseSelectorHook = interface
  end;

  function useStore: Store<S, A>;

  function createSelectorHook(context?: Context<ReactReduxContextValue<S, A>>): function: Selected;

  function createStoreHook(context?: Context<ReactReduxContextValue<S, A>>): function: Store<S, A>;

  function createDispatchHook(context?: Context<ReactReduxContextValue<S, A>>): function: Dispatch<A>;

implementation



end.
