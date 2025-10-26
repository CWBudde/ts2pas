unit React;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  NativeAnimationEvent = AnimationEvent;

  NativeClipboardEvent = ClipboardEvent;

  NativeCompositionEvent = CompositionEvent;

  NativeDragEvent = DragEvent;

  NativeFocusEvent = FocusEvent;

  NativeInputEvent = InputEvent;

  NativeKeyboardEvent = KeyboardEvent;

  NativeMouseEvent = MouseEvent;

  NativeTouchEvent = TouchEvent;

  NativePointerEvent = PointerEvent;

  NativeToggleEvent = ToggleEvent;

  NativeTransitionEvent = TransitionEvent;

  NativeUIEvent = UIEvent;

  NativeWheelEvent = WheelEvent;

  Booleanish = Variant;

  CrossOrigin = Variant;

  AwaitedReactNode = Variant;

  Destructor = function: Variant;

  VoidOrUndefinedOnly = Variant;

  ElementType = ComponentType<P>;

  ComponentType = Variant;

  JSXElementConstructor = Variant;

  RefObject = interface
    property current: T;
  end;

  DO_NOT_USE_OR_YOU_WILL_BE_FIRED_CALLBACK_REF_RETURN_VALUES = interface
  end;

  RefCallback = Variant;

  Ref = Variant;

  LegacyRef = Ref<T>;

  ElementRef = ComponentRef<C>;

  ComponentState = Variant;

  Key = Variant;

  Attributes = interface
    property key: Key;
  end;

  RefAttributes = interface(Attributes)
    property ref: Ref<T>;
  end;

  ClassAttributes = interface(RefAttributes)
  end;

  ReactElement = interface
    property type: T;
    property props: P;
    property key: String;
  end;

  ReactComponentElement = interface(ReactElement)
  end;

  FunctionComponentElement = interface(ReactElement)
    property ref: Variant;
  end;

  CElement = ComponentElement<P, T>;

  ComponentElement = interface(ReactElement)
    property ref: Ref<T>;
  end;

  ClassicElement = CElement<P, ClassicComponent<P, ComponentState>>;

  DOMElement = interface(ReactElement)
    property ref: Ref<T>;
  end;

  ReactHTMLElement = interface(DetailedReactHTMLElement)
  end;

  DetailedReactHTMLElement = interface(DOMElement)
    property type: HTMLElementType;
  end;

  ReactSVGElement = interface(DOMElement)
    property type: SVGElementType;
  end;

  ReactPortal = interface(ReactElement)
    property children: ReactNode;
  end;

  DO_NOT_USE_OR_YOU_WILL_BE_FIRED_EXPERIMENTAL_REACT_NODES = interface
  end;

  ReactNode = Variant;

  function createElement(type: String; props?: Variant; children: array of ReactNode): DetailedReactHTMLElement<InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>;

  function createElement(type: HTMLElementType; props?: Variant; children: array of ReactNode): DetailedReactHTMLElement<P, T>;

  function createElement(type: SVGElementType; props?: Variant; children: array of ReactNode): ReactSVGElement;

  function createElement(type: String; props?: Variant; children: array of ReactNode): DOMElement<P, T>;

  function createElement(type: FunctionComponent<P>; props?: Variant; children: array of ReactNode): FunctionComponentElement<P>;

  function createElement(type: ClassType<P, T, C>; props?: Variant; children: array of ReactNode): CElement<P, T>;

  function createElement(type: Variant; props?: Variant; children: array of ReactNode): ReactElement<P>;

  function cloneElement(element: DetailedReactHTMLElement<P, T>; props?: P; children: array of ReactNode): DetailedReactHTMLElement<P, T>;

  function cloneElement(element: ReactHTMLElement<T>; props?: P; children: array of ReactNode): ReactHTMLElement<T>;

  function cloneElement(element: ReactSVGElement; props?: P; children: array of ReactNode): ReactSVGElement;

  function cloneElement(element: DOMElement<P, T>; props?: Variant; children: array of ReactNode): DOMElement<P, T>;

  function cloneElement(element: FunctionComponentElement<P>; props?: Variant; children: array of ReactNode): FunctionComponentElement<P>;

  function cloneElement(element: CElement<P, T>; props?: Variant; children: array of ReactNode): CElement<P, T>;

  function cloneElement(element: ReactElement<P>; props?: Variant; children: array of ReactNode): ReactElement<P>;

  ProviderProps = interface
    property value: T;
    property children: ReactNode;
  end;

  ConsumerProps = interface
    property children: function: ReactNode;
  end;

  ExoticComponent = interface
    property $$typeof: String;
  end;

  NamedExoticComponent = interface(ExoticComponent)
    property displayName: String;
  end;

  ProviderExoticComponent = interface(ExoticComponent)
  end;

  ContextType = Variant;

  Provider = ProviderExoticComponent<ProviderProps<T>>;

  Consumer = ExoticComponent<ConsumerProps<T>>;

  Context = interface(Provider)
    property Provider: Provider<T>;
    property Consumer: Consumer<T>;
    property displayName: String;
  end;

  function createContext(defaultValue: T): Context<T>;

  function isValidElement(object: Variant): Variant;

  FragmentProps = interface
    property children: React.ReactNode;
  end;

  SuspenseProps = interface
    property children: ReactNode;
    property fallback: ReactNode;
    property name: String;
  end;

  ProfilerOnRenderCallback = procedure;

  ProfilerProps = interface
    property children: ReactNode;
    property id: String;
    property onRender: ProfilerOnRenderCallback;
  end;

  ReactInstance = Variant;

  Component = interface(ComponentLifecycle)
  end;

  Component = class external
    property contextType: Context<Variant>;
    property propTypes: Variant;
    property context: Variant;
    procedure Create(props: P);
    procedure Create(props: P; context: Variant);
    procedure setState(state: function: Variant; callback?: procedure);
    procedure forceUpdate(callback?: procedure);
    function render: ReactNode;
    property props: P; read only
    property state: S;
  end;

  PureComponent = class(Component) external
  end;

  ClassicComponent = interface(Component)
    procedure replaceState(nextState: S; callback?: procedure);
    function isMounted: Boolean;
    function getInitialState: S;
  end;

  FC = FunctionComponent<P>;

  FunctionComponent = interface
    property propTypes: Variant;
    property displayName: String;
  end;

  ForwardedRef = Variant;

  ForwardRefRenderFunction = interface
    property displayName: String;
    property propTypes: Variant;
  end;

  ComponentClass = interface(StaticLifecycle)
    property propTypes: Variant;
    property contextType: Context<Variant>;
    property defaultProps: P;
    property displayName: String;
  end;

  ClassicComponentClass = interface(ComponentClass)
    function getDefaultProps: P;
  end;

  ClassType = Variant;

  ComponentLifecycle = interface(NewLifecycle, DeprecatedLifecycle)
    procedure componentDidMount;
    function shouldComponentUpdate(nextProps: P; nextState: S; nextContext: Variant): Boolean;
    procedure componentWillUnmount;
    procedure componentDidCatch(error: Error; errorInfo: ErrorInfo);
  end;

  StaticLifecycle = interface
    property getDerivedStateFromProps: GetDerivedStateFromProps<P, S>;
    property getDerivedStateFromError: GetDerivedStateFromError<P, S>;
  end;

  GetDerivedStateFromProps = function: S;

  GetDerivedStateFromError = function: S;

  NewLifecycle = interface
    function getSnapshotBeforeUpdate(prevProps: P; prevState: S): SS;
    procedure componentDidUpdate(prevProps: P; prevState: S; snapshot?: SS);
  end;

  DeprecatedLifecycle = interface
    procedure componentWillMount;
    procedure UNSAFE_componentWillMount;
    procedure componentWillReceiveProps(nextProps: P; nextContext: Variant);
    procedure UNSAFE_componentWillReceiveProps(nextProps: P; nextContext: Variant);
    procedure componentWillUpdate(nextProps: P; nextState: S; nextContext: Variant);
    procedure UNSAFE_componentWillUpdate(nextProps: P; nextState: S; nextContext: Variant);
  end;

  function createRef: RefObject<T>;

  ForwardRefExoticComponent = interface(NamedExoticComponent)
    property propTypes: Variant;
  end;

  function forwardRef(render: ForwardRefRenderFunction<T, PropsWithoutRef<P>>): ForwardRefExoticComponent<Variant>;

  PropsWithoutRef = Variant;

  PropsWithRef = Props;

  PropsWithChildren = Variant;

  ComponentProps = Variant;

  ComponentPropsWithRef = Variant;

  CustomComponentPropsWithRef = Variant;

  ComponentPropsWithoutRef = PropsWithoutRef<ComponentProps<T>>;

  ComponentRef = Variant;

  MemoExoticComponent = Variant;

  function memo(Component: FunctionComponent<P>; propsAreEqual?: function: Boolean): NamedExoticComponent<P>;

  function memo(Component: T; propsAreEqual?: function: Boolean): MemoExoticComponent<T>;

  LazyExoticComponent = interface(ExoticComponent)
    property _result: T;
  end;

  function lazy(load: function: Variant): LazyExoticComponent<T>;

  SetStateAction = Variant;

  Dispatch = procedure;

  DispatchWithoutAction = procedure;

  AnyActionArg = Variant;

  ActionDispatch = procedure;

  Reducer = function: S;

  ReducerWithoutAction = function: S;

  ReducerState = Variant;

  DependencyList = Variant;

  EffectCallback = function: Destructor;

  MutableRefObject = interface
    property current: T;
  end;

  function useContext(context: Context<T>): T;

  function useState(initialState: Variant): array of Variant;

  function useState: array of Variant;

  function useReducer(reducer: function: S; initialState: S): array of Variant;

  function useReducer(reducer: function: S; initialArg: I; init: function: S): array of Variant;

  function useRef(initialValue: T): RefObject<T>;

  function useRef(initialValue: T): RefObject<T>;

  function useRef(initialValue: T): RefObject<T>;

  procedure useLayoutEffect(effect: EffectCallback; deps?: DependencyList);

  procedure useEffect(effect: EffectCallback; deps?: DependencyList);

  function useEffectEvent(callback: T): T;

  procedure useImperativeHandle(ref: Ref<T>; init: function: R; deps?: DependencyList);

  function useCallback(callback: T; deps: DependencyList): T;

  function useMemo(factory: function: T; deps: DependencyList): T;

  procedure useDebugValue(value: T; format?: function: Variant);

  TransitionFunction = function: VoidOrUndefinedOnly;

  TransitionStartFunction = interface
  end;

  function useDeferredValue(value: T; initialValue?: T): T;

  function useTransition: array of Variant;

  procedure startTransition(scope: TransitionFunction);

  procedure act(callback: function: VoidOrUndefinedOnly);

  function act(callback: function: T): T;

  function useId: String;

  procedure useInsertionEffect(effect: EffectCallback; deps?: DependencyList);

  function useSyncExternalStore(subscribe: function: procedure; getSnapshot: function: Snapshot; getServerSnapshot?: function: Snapshot): Snapshot;

  function useOptimistic(passthrough: State): array of Variant;

  function useOptimistic(passthrough: State; reducer: function: State): array of Variant;

  Usable = Variant;

  function use(usable: Usable<T>): T;

  function useActionState(action: function: State; initialState: Awaited<State>; permalink?: String): array of Variant;

  function useActionState(action: function: State; initialState: Awaited<State>; permalink?: String): array of Variant;

  function cache(fn: CachedFunction): CachedFunction;

  CacheSignal = interface
  end;

  function cacheSignal: CacheSignal;

  ActivityProps = interface
    property mode: Variant;
    property name: String;
    property children: ReactNode;
  end;

  function captureOwnerStack: String;

  BaseSyntheticEvent = interface
    property nativeEvent: E;
    property currentTarget: C;
    property target: T;
    property bubbles: Boolean;
    property cancelable: Boolean;
    property defaultPrevented: Boolean;
    property eventPhase: Float;
    property isTrusted: Boolean;
    procedure preventDefault;
    function isDefaultPrevented: Boolean;
    procedure stopPropagation;
    function isPropagationStopped: Boolean;
    procedure persist;
    property timeStamp: Float;
    property type: String;
  end;

  SyntheticEvent = interface(BaseSyntheticEvent)
  end;

  ClipboardEvent = interface(SyntheticEvent)
    property clipboardData: DataTransfer;
  end;

  CompositionEvent = interface(SyntheticEvent)
    property data: String;
  end;

  DragEvent = interface(MouseEvent)
    property dataTransfer: DataTransfer;
  end;

  PointerEvent = interface(MouseEvent)
    property pointerId: Float;
    property pressure: Float;
    property tangentialPressure: Float;
    property tiltX: Float;
    property tiltY: Float;
    property twist: Float;
    property width: Float;
    property height: Float;
    property pointerType: String;
    property isPrimary: Boolean;
  end;

  FocusEvent = interface(SyntheticEvent)
    property relatedTarget: Variant;
    property target: Variant;
  end;

  FormEvent = interface(SyntheticEvent)
  end;

  InvalidEvent = interface(SyntheticEvent)
    property target: Variant;
  end;

  ChangeEvent = interface(SyntheticEvent)
    property target: Variant;
  end;

  InputEvent = interface(SyntheticEvent)
    property data: String;
  end;

  ModifierKey = String;

  KeyboardEvent = interface(UIEvent)
    property altKey: Boolean;
    property charCode: Float;
    property ctrlKey: Boolean;
    property code: String;
    function getModifierState(key: ModifierKey): Boolean;
    property key: String;
    property keyCode: Float;
    property locale: String;
    property location: Float;
    property metaKey: Boolean;
    property repeat: Boolean;
    property shiftKey: Boolean;
    property which: Float;
  end;

  MouseEvent = interface(UIEvent)
    property altKey: Boolean;
    property button: Float;
    property buttons: Float;
    property clientX: Float;
    property clientY: Float;
    property ctrlKey: Boolean;
    function getModifierState(key: ModifierKey): Boolean;
    property metaKey: Boolean;
    property movementX: Float;
    property movementY: Float;
    property pageX: Float;
    property pageY: Float;
    property relatedTarget: EventTarget;
    property screenX: Float;
    property screenY: Float;
    property shiftKey: Boolean;
  end;

  TouchEvent = interface(UIEvent)
    property altKey: Boolean;
    property changedTouches: TouchList;
    property ctrlKey: Boolean;
    function getModifierState(key: ModifierKey): Boolean;
    property metaKey: Boolean;
    property shiftKey: Boolean;
    property targetTouches: TouchList;
    property touches: TouchList;
  end;

  UIEvent = interface(SyntheticEvent)
    property detail: Float;
    property view: AbstractView;
  end;

  WheelEvent = interface(MouseEvent)
    property deltaMode: Float;
    property deltaX: Float;
    property deltaY: Float;
    property deltaZ: Float;
  end;

  AnimationEvent = interface(SyntheticEvent)
    property animationName: String;
    property elapsedTime: Float;
    property pseudoElement: String;
  end;

  ToggleEvent = interface(SyntheticEvent)
    property oldState: String;
    property newState: String;
  end;

  TransitionEvent = interface(SyntheticEvent)
    property elapsedTime: Float;
    property propertyName: String;
    property pseudoElement: String;
  end;

  EventHandler = Variant;

  ReactEventHandler = EventHandler<SyntheticEvent<T>>;

  ClipboardEventHandler = EventHandler<ClipboardEvent<T>>;

  CompositionEventHandler = EventHandler<CompositionEvent<T>>;

  DragEventHandler = EventHandler<DragEvent<T>>;

  FocusEventHandler = EventHandler<FocusEvent<T>>;

  FormEventHandler = EventHandler<FormEvent<T>>;

  ChangeEventHandler = EventHandler<ChangeEvent<T>>;

  InputEventHandler = EventHandler<InputEvent<T>>;

  KeyboardEventHandler = EventHandler<KeyboardEvent<T>>;

  MouseEventHandler = EventHandler<MouseEvent<T>>;

  TouchEventHandler = EventHandler<TouchEvent<T>>;

  PointerEventHandler = EventHandler<PointerEvent<T>>;

  UIEventHandler = EventHandler<UIEvent<T>>;

  WheelEventHandler = EventHandler<WheelEvent<T>>;

  AnimationEventHandler = EventHandler<AnimationEvent<T>>;

  ToggleEventHandler = EventHandler<ToggleEvent<T>>;

  TransitionEventHandler = EventHandler<TransitionEvent<T>>;

  HTMLProps = interface(AllHTMLAttributes, ClassAttributes)
  end;

  DetailedHTMLProps = Variant;

  SVGProps = interface(SVGAttributes, ClassAttributes)
  end;

  SVGLineElementAttributes = interface(SVGProps)
  end;

  SVGTextElementAttributes = interface(SVGProps)
  end;

  DOMAttributes = interface
    property children: ReactNode;
    property dangerouslySetInnerHTML: Variant;
    property onCopy: ClipboardEventHandler<T>;
    property onCopyCapture: ClipboardEventHandler<T>;
    property onCut: ClipboardEventHandler<T>;
    property onCutCapture: ClipboardEventHandler<T>;
    property onPaste: ClipboardEventHandler<T>;
    property onPasteCapture: ClipboardEventHandler<T>;
    property onCompositionEnd: CompositionEventHandler<T>;
    property onCompositionEndCapture: CompositionEventHandler<T>;
    property onCompositionStart: CompositionEventHandler<T>;
    property onCompositionStartCapture: CompositionEventHandler<T>;
    property onCompositionUpdate: CompositionEventHandler<T>;
    property onCompositionUpdateCapture: CompositionEventHandler<T>;
    property onFocus: FocusEventHandler<T>;
    property onFocusCapture: FocusEventHandler<T>;
    property onBlur: FocusEventHandler<T>;
    property onBlurCapture: FocusEventHandler<T>;
    property onChange: FormEventHandler<T>;
    property onChangeCapture: FormEventHandler<T>;
    property onBeforeInput: InputEventHandler<T>;
    property onBeforeInputCapture: FormEventHandler<T>;
    property onInput: FormEventHandler<T>;
    property onInputCapture: FormEventHandler<T>;
    property onReset: FormEventHandler<T>;
    property onResetCapture: FormEventHandler<T>;
    property onSubmit: FormEventHandler<T>;
    property onSubmitCapture: FormEventHandler<T>;
    property onInvalid: FormEventHandler<T>;
    property onInvalidCapture: FormEventHandler<T>;
    property onLoad: ReactEventHandler<T>;
    property onLoadCapture: ReactEventHandler<T>;
    property onError: ReactEventHandler<T>;
    property onErrorCapture: ReactEventHandler<T>;
    property onKeyDown: KeyboardEventHandler<T>;
    property onKeyDownCapture: KeyboardEventHandler<T>;
    property onKeyPress: KeyboardEventHandler<T>;
    property onKeyPressCapture: KeyboardEventHandler<T>;
    property onKeyUp: KeyboardEventHandler<T>;
    property onKeyUpCapture: KeyboardEventHandler<T>;
    property onAbort: ReactEventHandler<T>;
    property onAbortCapture: ReactEventHandler<T>;
    property onCanPlay: ReactEventHandler<T>;
    property onCanPlayCapture: ReactEventHandler<T>;
    property onCanPlayThrough: ReactEventHandler<T>;
    property onCanPlayThroughCapture: ReactEventHandler<T>;
    property onDurationChange: ReactEventHandler<T>;
    property onDurationChangeCapture: ReactEventHandler<T>;
    property onEmptied: ReactEventHandler<T>;
    property onEmptiedCapture: ReactEventHandler<T>;
    property onEncrypted: ReactEventHandler<T>;
    property onEncryptedCapture: ReactEventHandler<T>;
    property onEnded: ReactEventHandler<T>;
    property onEndedCapture: ReactEventHandler<T>;
    property onLoadedData: ReactEventHandler<T>;
    property onLoadedDataCapture: ReactEventHandler<T>;
    property onLoadedMetadata: ReactEventHandler<T>;
    property onLoadedMetadataCapture: ReactEventHandler<T>;
    property onLoadStart: ReactEventHandler<T>;
    property onLoadStartCapture: ReactEventHandler<T>;
    property onPause: ReactEventHandler<T>;
    property onPauseCapture: ReactEventHandler<T>;
    property onPlay: ReactEventHandler<T>;
    property onPlayCapture: ReactEventHandler<T>;
    property onPlaying: ReactEventHandler<T>;
    property onPlayingCapture: ReactEventHandler<T>;
    property onProgress: ReactEventHandler<T>;
    property onProgressCapture: ReactEventHandler<T>;
    property onRateChange: ReactEventHandler<T>;
    property onRateChangeCapture: ReactEventHandler<T>;
    property onSeeked: ReactEventHandler<T>;
    property onSeekedCapture: ReactEventHandler<T>;
    property onSeeking: ReactEventHandler<T>;
    property onSeekingCapture: ReactEventHandler<T>;
    property onStalled: ReactEventHandler<T>;
    property onStalledCapture: ReactEventHandler<T>;
    property onSuspend: ReactEventHandler<T>;
    property onSuspendCapture: ReactEventHandler<T>;
    property onTimeUpdate: ReactEventHandler<T>;
    property onTimeUpdateCapture: ReactEventHandler<T>;
    property onVolumeChange: ReactEventHandler<T>;
    property onVolumeChangeCapture: ReactEventHandler<T>;
    property onWaiting: ReactEventHandler<T>;
    property onWaitingCapture: ReactEventHandler<T>;
    property onAuxClick: MouseEventHandler<T>;
    property onAuxClickCapture: MouseEventHandler<T>;
    property onClick: MouseEventHandler<T>;
    property onClickCapture: MouseEventHandler<T>;
    property onContextMenu: MouseEventHandler<T>;
    property onContextMenuCapture: MouseEventHandler<T>;
    property onDoubleClick: MouseEventHandler<T>;
    property onDoubleClickCapture: MouseEventHandler<T>;
    property onDrag: DragEventHandler<T>;
    property onDragCapture: DragEventHandler<T>;
    property onDragEnd: DragEventHandler<T>;
    property onDragEndCapture: DragEventHandler<T>;
    property onDragEnter: DragEventHandler<T>;
    property onDragEnterCapture: DragEventHandler<T>;
    property onDragExit: DragEventHandler<T>;
    property onDragExitCapture: DragEventHandler<T>;
    property onDragLeave: DragEventHandler<T>;
    property onDragLeaveCapture: DragEventHandler<T>;
    property onDragOver: DragEventHandler<T>;
    property onDragOverCapture: DragEventHandler<T>;
    property onDragStart: DragEventHandler<T>;
    property onDragStartCapture: DragEventHandler<T>;
    property onDrop: DragEventHandler<T>;
    property onDropCapture: DragEventHandler<T>;
    property onMouseDown: MouseEventHandler<T>;
    property onMouseDownCapture: MouseEventHandler<T>;
    property onMouseEnter: MouseEventHandler<T>;
    property onMouseLeave: MouseEventHandler<T>;
    property onMouseMove: MouseEventHandler<T>;
    property onMouseMoveCapture: MouseEventHandler<T>;
    property onMouseOut: MouseEventHandler<T>;
    property onMouseOutCapture: MouseEventHandler<T>;
    property onMouseOver: MouseEventHandler<T>;
    property onMouseOverCapture: MouseEventHandler<T>;
    property onMouseUp: MouseEventHandler<T>;
    property onMouseUpCapture: MouseEventHandler<T>;
    property onSelect: ReactEventHandler<T>;
    property onSelectCapture: ReactEventHandler<T>;
    property onTouchCancel: TouchEventHandler<T>;
    property onTouchCancelCapture: TouchEventHandler<T>;
    property onTouchEnd: TouchEventHandler<T>;
    property onTouchEndCapture: TouchEventHandler<T>;
    property onTouchMove: TouchEventHandler<T>;
    property onTouchMoveCapture: TouchEventHandler<T>;
    property onTouchStart: TouchEventHandler<T>;
    property onTouchStartCapture: TouchEventHandler<T>;
    property onPointerDown: PointerEventHandler<T>;
    property onPointerDownCapture: PointerEventHandler<T>;
    property onPointerMove: PointerEventHandler<T>;
    property onPointerMoveCapture: PointerEventHandler<T>;
    property onPointerUp: PointerEventHandler<T>;
    property onPointerUpCapture: PointerEventHandler<T>;
    property onPointerCancel: PointerEventHandler<T>;
    property onPointerCancelCapture: PointerEventHandler<T>;
    property onPointerEnter: PointerEventHandler<T>;
    property onPointerLeave: PointerEventHandler<T>;
    property onPointerOver: PointerEventHandler<T>;
    property onPointerOverCapture: PointerEventHandler<T>;
    property onPointerOut: PointerEventHandler<T>;
    property onPointerOutCapture: PointerEventHandler<T>;
    property onGotPointerCapture: PointerEventHandler<T>;
    property onGotPointerCaptureCapture: PointerEventHandler<T>;
    property onLostPointerCapture: PointerEventHandler<T>;
    property onLostPointerCaptureCapture: PointerEventHandler<T>;
    property onScroll: UIEventHandler<T>;
    property onScrollCapture: UIEventHandler<T>;
    property onScrollEnd: UIEventHandler<T>;
    property onScrollEndCapture: UIEventHandler<T>;
    property onWheel: WheelEventHandler<T>;
    property onWheelCapture: WheelEventHandler<T>;
    property onAnimationStart: AnimationEventHandler<T>;
    property onAnimationStartCapture: AnimationEventHandler<T>;
    property onAnimationEnd: AnimationEventHandler<T>;
    property onAnimationEndCapture: AnimationEventHandler<T>;
    property onAnimationIteration: AnimationEventHandler<T>;
    property onAnimationIterationCapture: AnimationEventHandler<T>;
    property onToggle: ToggleEventHandler<T>;
    property onBeforeToggle: ToggleEventHandler<T>;
    property onTransitionCancel: TransitionEventHandler<T>;
    property onTransitionCancelCapture: TransitionEventHandler<T>;
    property onTransitionEnd: TransitionEventHandler<T>;
    property onTransitionEndCapture: TransitionEventHandler<T>;
    property onTransitionRun: TransitionEventHandler<T>;
    property onTransitionRunCapture: TransitionEventHandler<T>;
    property onTransitionStart: TransitionEventHandler<T>;
    property onTransitionStartCapture: TransitionEventHandler<T>;
  end;

  CSSProperties = interface(CSS.Properties)
  end;

  AriaAttributes = interface
  end;

  AriaRole = Variant;

  HTMLAttributes = interface(AriaAttributes, DOMAttributes)
    property defaultChecked: Boolean;
    property defaultValue: Variant;
    property suppressContentEditableWarning: Boolean;
    property suppressHydrationWarning: Boolean;
    property accessKey: String;
    property autoCapitalize: Variant;
    property autoFocus: Boolean;
    property className: String;
    property contentEditable: Variant;
    property contextMenu: String;
    property dir: String;
    property draggable: Booleanish;
    property enterKeyHint: Variant;
    property hidden: Boolean;
    property id: String;
    property lang: String;
    property nonce: String;
    property slot: String;
    property spellCheck: Booleanish;
    property style: CSSProperties;
    property tabIndex: Float;
    property title: String;
    property translate: Variant;
    property radioGroup: String;
    property role: AriaRole;
    property about: String;
    property content: String;
    property datatype: String;
    property inlist: Variant;
    property prefix: String;
    property property: String;
    property rel: String;
    property resource: String;
    property rev: String;
    property typeof: String;
    property vocab: String;
    property autoCorrect: String;
    property autoSave: String;
    property color: String;
    property itemProp: String;
    property itemScope: Boolean;
    property itemType: String;
    property itemID: String;
    property itemRef: String;
    property results: Float;
    property security: String;
    property unselectable: Variant;
    property popover: Variant;
    property popoverTargetAction: Variant;
    property popoverTarget: String;
    property inert: Boolean;
    property inputMode: Variant;
    property is: String;
    property exportparts: String;
    property part: String;
  end;

  DO_NOT_USE_OR_YOU_WILL_BE_FIRED_EXPERIMENTAL_FORM_ACTIONS = interface
  end;

  AllHTMLAttributes = interface(HTMLAttributes)
    property accept: String;
    property acceptCharset: String;
    property action: Variant;
    property allowFullScreen: Boolean;
    property allowTransparency: Boolean;
    property alt: String;
    property as: String;
    property async: Boolean;
    property autoComplete: String;
    property autoPlay: Boolean;
    property capture: Variant;
    property cellPadding: Variant;
    property cellSpacing: Variant;
    property charSet: String;
    property challenge: String;
    property checked: Boolean;
    property cite: String;
    property classID: String;
    property cols: Float;
    property colSpan: Float;
    property controls: Boolean;
    property coords: String;
    property crossOrigin: CrossOrigin;
    property data: String;
    property dateTime: String;
    property default: Boolean;
    property defer: Boolean;
    property disabled: Boolean;
    property download: Variant;
    property encType: String;
    property form: String;
    property formAction: Variant;
    property formEncType: String;
    property formMethod: String;
    property formNoValidate: Boolean;
    property formTarget: String;
    property frameBorder: Variant;
    property headers: String;
    property height: Variant;
    property high: Float;
    property href: String;
    property hrefLang: String;
    property htmlFor: String;
    property httpEquiv: String;
    property integrity: String;
    property keyParams: String;
    property keyType: String;
    property kind: String;
    property label: String;
    property list: String;
    property loop: Boolean;
    property low: Float;
    property manifest: String;
    property marginHeight: Float;
    property marginWidth: Float;
    property max: Variant;
    property maxLength: Float;
    property media: String;
    property mediaGroup: String;
    property method: String;
    property min: Variant;
    property minLength: Float;
    property multiple: Boolean;
    property muted: Boolean;
    property name: String;
    property noValidate: Boolean;
    property open: Boolean;
    property optimum: Float;
    property pattern: String;
    property placeholder: String;
    property playsInline: Boolean;
    property poster: String;
    property preload: String;
    property readOnly: Boolean;
    property required: Boolean;
    property reversed: Boolean;
    property rows: Float;
    property rowSpan: Float;
    property sandbox: String;
    property scope: String;
    property scoped: Boolean;
    property scrolling: String;
    property seamless: Boolean;
    property selected: Boolean;
    property shape: String;
    property size: Float;
    property sizes: String;
    property span: Float;
    property src: String;
    property srcDoc: String;
    property srcLang: String;
    property srcSet: String;
    property start: Float;
    property step: Variant;
    property summary: String;
    property target: String;
    property type: String;
    property useMap: String;
    property value: Variant;
    property width: Variant;
    property wmode: String;
    property wrap: String;
  end;

  HTMLAttributeReferrerPolicy = String;

  HTMLAttributeAnchorTarget = Variant;

  AnchorHTMLAttributes = interface(HTMLAttributes)
    property download: Variant;
    property href: String;
    property hrefLang: String;
    property media: String;
    property ping: String;
    property target: HTMLAttributeAnchorTarget;
    property type: String;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
  end;

  AudioHTMLAttributes = interface(MediaHTMLAttributes)
  end;

  AreaHTMLAttributes = interface(HTMLAttributes)
    property alt: String;
    property coords: String;
    property download: Variant;
    property href: String;
    property hrefLang: String;
    property media: String;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
    property shape: String;
    property target: String;
  end;

  BaseHTMLAttributes = interface(HTMLAttributes)
    property href: String;
    property target: String;
  end;

  BlockquoteHTMLAttributes = interface(HTMLAttributes)
    property cite: String;
  end;

  ButtonHTMLAttributes = interface(HTMLAttributes)
    property disabled: Boolean;
    property form: String;
    property formAction: Variant;
    property formEncType: String;
    property formMethod: String;
    property formNoValidate: Boolean;
    property formTarget: String;
    property name: String;
    property type: Variant;
    property value: Variant;
  end;

  CanvasHTMLAttributes = interface(HTMLAttributes)
    property height: Variant;
    property width: Variant;
  end;

  ColHTMLAttributes = interface(HTMLAttributes)
    property span: Float;
    property width: Variant;
  end;

  ColgroupHTMLAttributes = interface(HTMLAttributes)
    property span: Float;
  end;

  DataHTMLAttributes = interface(HTMLAttributes)
    property value: Variant;
  end;

  DetailsHTMLAttributes = interface(HTMLAttributes)
    property open: Boolean;
    property name: String;
  end;

  DelHTMLAttributes = interface(HTMLAttributes)
    property cite: String;
    property dateTime: String;
  end;

  DialogHTMLAttributes = interface(HTMLAttributes)
    property closedby: Variant;
    property onCancel: ReactEventHandler<T>;
    property onClose: ReactEventHandler<T>;
    property open: Boolean;
  end;

  EmbedHTMLAttributes = interface(HTMLAttributes)
    property height: Variant;
    property src: String;
    property type: String;
    property width: Variant;
  end;

  FieldsetHTMLAttributes = interface(HTMLAttributes)
    property disabled: Boolean;
    property form: String;
    property name: String;
  end;

  FormHTMLAttributes = interface(HTMLAttributes)
    property acceptCharset: String;
    property action: Variant;
    property autoComplete: String;
    property encType: String;
    property method: String;
    property name: String;
    property noValidate: Boolean;
    property target: String;
  end;

  HtmlHTMLAttributes = interface(HTMLAttributes)
    property manifest: String;
  end;

  IframeHTMLAttributes = interface(HTMLAttributes)
    property allow: String;
    property allowFullScreen: Boolean;
    property allowTransparency: Boolean;
    property frameBorder: Variant;
    property height: Variant;
    property loading: Variant;
    property marginHeight: Float;
    property marginWidth: Float;
    property name: String;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
    property sandbox: String;
    property scrolling: String;
    property seamless: Boolean;
    property src: String;
    property srcDoc: String;
    property width: Variant;
  end;

  DO_NOT_USE_OR_YOU_WILL_BE_FIRED_EXPERIMENTAL_IMG_SRC_TYPES = interface
  end;

  ImgHTMLAttributes = interface(HTMLAttributes)
    property alt: String;
    property crossOrigin: CrossOrigin;
    property decoding: Variant;
    property fetchPriority: String;
    property height: Variant;
    property loading: Variant;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
    property sizes: String;
    property src: String;
    property srcSet: String;
    property useMap: String;
    property width: Variant;
  end;

  InsHTMLAttributes = interface(HTMLAttributes)
    property cite: String;
    property dateTime: String;
  end;

  HTMLInputTypeAttribute = Variant;

  AutoFillAddressKind = String;

  AutoFillBase = String;

  AutoFillContactField = String;

  AutoFillContactKind = String;

  AutoFillCredentialField = String;

  AutoFillNormalField = String;

  OptionalPrefixToken = String;

  OptionalPostfixToken = String;

  AutoFillField = AutoFillNormalField;

  AutoFillSection = Variant;

  AutoFill = AutoFillBase;

  HTMLInputAutoCompleteAttribute = AutoFill;

  InputHTMLAttributes = interface(HTMLAttributes)
    property accept: String;
    property alt: String;
    property autoComplete: HTMLInputAutoCompleteAttribute;
    property capture: Variant;
    property checked: Boolean;
    property disabled: Boolean;
    property form: String;
    property formAction: Variant;
    property formEncType: String;
    property formMethod: String;
    property formNoValidate: Boolean;
    property formTarget: String;
    property height: Variant;
    property list: String;
    property max: Variant;
    property maxLength: Float;
    property min: Variant;
    property minLength: Float;
    property multiple: Boolean;
    property name: String;
    property pattern: String;
    property placeholder: String;
    property readOnly: Boolean;
    property required: Boolean;
    property size: Float;
    property src: String;
    property step: Variant;
    property type: HTMLInputTypeAttribute;
    property value: Variant;
    property width: Variant;
    property onChange: ChangeEventHandler<T>;
  end;

  KeygenHTMLAttributes = interface(HTMLAttributes)
    property challenge: String;
    property disabled: Boolean;
    property form: String;
    property keyType: String;
    property keyParams: String;
    property name: String;
  end;

  LabelHTMLAttributes = interface(HTMLAttributes)
    property form: String;
    property htmlFor: String;
  end;

  LiHTMLAttributes = interface(HTMLAttributes)
    property value: Variant;
  end;

  LinkHTMLAttributes = interface(HTMLAttributes)
    property as: String;
    property blocking: String;
    property crossOrigin: CrossOrigin;
    property fetchPriority: String;
    property href: String;
    property hrefLang: String;
    property integrity: String;
    property media: String;
    property imageSrcSet: String;
    property imageSizes: String;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
    property sizes: String;
    property type: String;
    property charSet: String;
    property precedence: String;
  end;

  MapHTMLAttributes = interface(HTMLAttributes)
    property name: String;
  end;

  MenuHTMLAttributes = interface(HTMLAttributes)
    property type: String;
  end;

  DO_NOT_USE_OR_YOU_WILL_BE_FIRED_EXPERIMENTAL_MEDIA_SRC_TYPES = interface
  end;

  MediaHTMLAttributes = interface(HTMLAttributes)
    property autoPlay: Boolean;
    property controls: Boolean;
    property controlsList: String;
    property crossOrigin: CrossOrigin;
    property loop: Boolean;
    property mediaGroup: String;
    property muted: Boolean;
    property playsInline: Boolean;
    property preload: String;
    property src: String;
  end;

  MetaHTMLAttributes = interface(HTMLAttributes)
    property charSet: String;
    property content: String;
    property httpEquiv: String;
    property media: String;
    property name: String;
  end;

  MeterHTMLAttributes = interface(HTMLAttributes)
    property form: String;
    property high: Float;
    property low: Float;
    property max: Variant;
    property min: Variant;
    property optimum: Float;
    property value: Variant;
  end;

  QuoteHTMLAttributes = interface(HTMLAttributes)
    property cite: String;
  end;

  ObjectHTMLAttributes = interface(HTMLAttributes)
    property classID: String;
    property data: String;
    property form: String;
    property height: Variant;
    property name: String;
    property type: String;
    property useMap: String;
    property width: Variant;
    property wmode: String;
  end;

  OlHTMLAttributes = interface(HTMLAttributes)
    property reversed: Boolean;
    property start: Float;
    property type: Variant;
  end;

  OptgroupHTMLAttributes = interface(HTMLAttributes)
    property disabled: Boolean;
    property label: String;
  end;

  OptionHTMLAttributes = interface(HTMLAttributes)
    property disabled: Boolean;
    property label: String;
    property selected: Boolean;
    property value: Variant;
  end;

  OutputHTMLAttributes = interface(HTMLAttributes)
    property form: String;
    property htmlFor: String;
    property name: String;
  end;

  ParamHTMLAttributes = interface(HTMLAttributes)
    property name: String;
    property value: Variant;
  end;

  ProgressHTMLAttributes = interface(HTMLAttributes)
    property max: Variant;
    property value: Variant;
  end;

  SlotHTMLAttributes = interface(HTMLAttributes)
    property name: String;
  end;

  ScriptHTMLAttributes = interface(HTMLAttributes)
    property async: Boolean;
    property blocking: String;
    property charSet: String;
    property crossOrigin: CrossOrigin;
    property defer: Boolean;
    property fetchPriority: Variant;
    property integrity: String;
    property noModule: Boolean;
    property referrerPolicy: HTMLAttributeReferrerPolicy;
    property src: String;
    property type: String;
  end;

  SelectHTMLAttributes = interface(HTMLAttributes)
    property autoComplete: String;
    property disabled: Boolean;
    property form: String;
    property multiple: Boolean;
    property name: String;
    property required: Boolean;
    property size: Float;
    property value: Variant;
    property onChange: ChangeEventHandler<T>;
  end;

  SourceHTMLAttributes = interface(HTMLAttributes)
    property height: Variant;
    property media: String;
    property sizes: String;
    property src: String;
    property srcSet: String;
    property type: String;
    property width: Variant;
  end;

  StyleHTMLAttributes = interface(HTMLAttributes)
    property blocking: String;
    property media: String;
    property scoped: Boolean;
    property type: String;
    property href: String;
    property precedence: String;
  end;

  TableHTMLAttributes = interface(HTMLAttributes)
    property align: Variant;
    property bgcolor: String;
    property border: Float;
    property cellPadding: Variant;
    property cellSpacing: Variant;
    property frame: Boolean;
    property rules: Variant;
    property summary: String;
    property width: Variant;
  end;

  TextareaHTMLAttributes = interface(HTMLAttributes)
    property autoComplete: String;
    property cols: Float;
    property dirName: String;
    property disabled: Boolean;
    property form: String;
    property maxLength: Float;
    property minLength: Float;
    property name: String;
    property placeholder: String;
    property readOnly: Boolean;
    property required: Boolean;
    property rows: Float;
    property value: Variant;
    property wrap: String;
    property onChange: ChangeEventHandler<T>;
  end;

  TdHTMLAttributes = interface(HTMLAttributes)
    property align: Variant;
    property colSpan: Float;
    property headers: String;
    property rowSpan: Float;
    property scope: String;
    property abbr: String;
    property height: Variant;
    property width: Variant;
    property valign: Variant;
  end;

  ThHTMLAttributes = interface(HTMLAttributes)
    property align: Variant;
    property colSpan: Float;
    property headers: String;
    property rowSpan: Float;
    property scope: String;
    property abbr: String;
  end;

  TimeHTMLAttributes = interface(HTMLAttributes)
    property dateTime: String;
  end;

  TrackHTMLAttributes = interface(HTMLAttributes)
    property default: Boolean;
    property kind: String;
    property label: String;
    property src: String;
    property srcLang: String;
  end;

  VideoHTMLAttributes = interface(MediaHTMLAttributes)
    property height: Variant;
    property playsInline: Boolean;
    property poster: String;
    property width: Variant;
    property disablePictureInPicture: Boolean;
    property disableRemotePlayback: Boolean;
    property onResize: ReactEventHandler<T>;
    property onResizeCapture: ReactEventHandler<T>;
  end;

  SVGAttributes = interface(AriaAttributes, DOMAttributes)
    property suppressHydrationWarning: Boolean;
    property className: String;
    property color: String;
    property height: Variant;
    property id: String;
    property lang: String;
    property max: Variant;
    property media: String;
    property method: String;
    property min: Variant;
    property name: String;
    property style: CSSProperties;
    property target: String;
    property type: String;
    property width: Variant;
    property role: AriaRole;
    property tabIndex: Float;
    property crossOrigin: CrossOrigin;
    property accentHeight: Variant;
    property accumulate: Variant;
    property additive: Variant;
    property alignmentBaseline: Variant;
    property allowReorder: Variant;
    property alphabetic: Variant;
    property amplitude: Variant;
    property arabicForm: Variant;
    property ascent: Variant;
    property attributeName: String;
    property attributeType: String;
    property autoReverse: Booleanish;
    property azimuth: Variant;
    property baseFrequency: Variant;
    property baselineShift: Variant;
    property baseProfile: Variant;
    property bbox: Variant;
    property begin: Variant;
    property bias: Variant;
    property by: Variant;
    property calcMode: Variant;
    property capHeight: Variant;
    property clip: Variant;
    property clipPath: String;
    property clipPathUnits: Variant;
    property clipRule: Variant;
    property colorInterpolation: Variant;
    property colorInterpolationFilters: Variant;
    property colorProfile: Variant;
    property colorRendering: Variant;
    property contentScriptType: Variant;
    property contentStyleType: Variant;
    property cursor: Variant;
    property cx: Variant;
    property cy: Variant;
    property d: String;
    property decelerate: Variant;
    property descent: Variant;
    property diffuseConstant: Variant;
    property direction: Variant;
    property display: Variant;
    property divisor: Variant;
    property dominantBaseline: Variant;
    property dur: Variant;
    property dx: Variant;
    property dy: Variant;
    property edgeMode: Variant;
    property elevation: Variant;
    property enableBackground: Variant;
    property end: Variant;
    property exponent: Variant;
    property externalResourcesRequired: Booleanish;
    property fill: String;
    property fillOpacity: Variant;
    property fillRule: Variant;
    property filter: String;
    property filterRes: Variant;
    property filterUnits: Variant;
    property floodColor: Variant;
    property floodOpacity: Variant;
    property focusable: Variant;
    property fontFamily: String;
    property fontSize: Variant;
    property fontSizeAdjust: Variant;
    property fontStretch: Variant;
    property fontStyle: Variant;
    property fontVariant: Variant;
    property fontWeight: Variant;
    property format: Variant;
    property fr: Variant;
    property from: Variant;
    property fx: Variant;
    property fy: Variant;
    property g1: Variant;
    property g2: Variant;
    property glyphName: Variant;
    property glyphOrientationHorizontal: Variant;
    property glyphOrientationVertical: Variant;
    property glyphRef: Variant;
    property gradientTransform: String;
    property gradientUnits: String;
    property hanging: Variant;
    property horizAdvX: Variant;
    property horizOriginX: Variant;
    property href: String;
    property ideographic: Variant;
    property imageRendering: Variant;
    property in2: Variant;
    property in: String;
    property intercept: Variant;
    property k1: Variant;
    property k2: Variant;
    property k3: Variant;
    property k4: Variant;
    property k: Variant;
    property kernelMatrix: Variant;
    property kernelUnitLength: Variant;
    property kerning: Variant;
    property keyPoints: Variant;
    property keySplines: Variant;
    property keyTimes: Variant;
    property lengthAdjust: Variant;
    property letterSpacing: Variant;
    property lightingColor: Variant;
    property limitingConeAngle: Variant;
    property local: Variant;
    property markerEnd: String;
    property markerHeight: Variant;
    property markerMid: String;
    property markerStart: String;
    property markerUnits: Variant;
    property markerWidth: Variant;
    property mask: String;
    property maskContentUnits: Variant;
    property maskUnits: Variant;
    property mathematical: Variant;
    property mode: Variant;
    property numOctaves: Variant;
    property offset: Variant;
    property opacity: Variant;
    property operator: Variant;
    property order: Variant;
    property orient: Variant;
    property orientation: Variant;
    property origin: Variant;
    property overflow: Variant;
    property overlinePosition: Variant;
    property overlineThickness: Variant;
    property paintOrder: Variant;
    property panose1: Variant;
    property path: String;
    property pathLength: Variant;
    property patternContentUnits: String;
    property patternTransform: Variant;
    property patternUnits: String;
    property pointerEvents: Variant;
    property points: String;
    property pointsAtX: Variant;
    property pointsAtY: Variant;
    property pointsAtZ: Variant;
    property preserveAlpha: Booleanish;
    property preserveAspectRatio: String;
    property primitiveUnits: Variant;
    property r: Variant;
    property radius: Variant;
    property refX: Variant;
    property refY: Variant;
    property renderingIntent: Variant;
    property repeatCount: Variant;
    property repeatDur: Variant;
    property requiredExtensions: Variant;
    property requiredFeatures: Variant;
    property restart: Variant;
    property result: String;
    property rotate: Variant;
    property rx: Variant;
    property ry: Variant;
    property scale: Variant;
    property seed: Variant;
    property shapeRendering: Variant;
    property slope: Variant;
    property spacing: Variant;
    property specularConstant: Variant;
    property specularExponent: Variant;
    property speed: Variant;
    property spreadMethod: String;
    property startOffset: Variant;
    property stdDeviation: Variant;
    property stemh: Variant;
    property stemv: Variant;
    property stitchTiles: Variant;
    property stopColor: String;
    property stopOpacity: Variant;
    property strikethroughPosition: Variant;
    property strikethroughThickness: Variant;
    property string: Variant;
    property stroke: String;
    property strokeDasharray: Variant;
    property strokeDashoffset: Variant;
    property strokeLinecap: Variant;
    property strokeLinejoin: Variant;
    property strokeMiterlimit: Variant;
    property strokeOpacity: Variant;
    property strokeWidth: Variant;
    property surfaceScale: Variant;
    property systemLanguage: Variant;
    property tableValues: Variant;
    property targetX: Variant;
    property targetY: Variant;
    property textAnchor: Variant;
    property textDecoration: Variant;
    property textLength: Variant;
    property textRendering: Variant;
    property to: Variant;
    property transform: String;
    property u1: Variant;
    property u2: Variant;
    property underlinePosition: Variant;
    property underlineThickness: Variant;
    property unicode: Variant;
    property unicodeBidi: Variant;
    property unicodeRange: Variant;
    property unitsPerEm: Variant;
    property vAlphabetic: Variant;
    property values: String;
    property vectorEffect: Variant;
    property version: String;
    property vertAdvY: Variant;
    property vertOriginX: Variant;
    property vertOriginY: Variant;
    property vHanging: Variant;
    property vIdeographic: Variant;
    property viewBox: String;
    property viewTarget: Variant;
    property visibility: Variant;
    property vMathematical: Variant;
    property widths: Variant;
    property wordSpacing: Variant;
    property writingMode: Variant;
    property x1: Variant;
    property x2: Variant;
    property x: Variant;
    property xChannelSelector: String;
    property xHeight: Variant;
    property xlinkActuate: String;
    property xlinkArcrole: String;
    property xlinkHref: String;
    property xlinkRole: String;
    property xlinkShow: String;
    property xlinkTitle: String;
    property xlinkType: String;
    property xmlBase: String;
    property xmlLang: String;
    property xmlns: String;
    property xmlnsXlink: String;
    property xmlSpace: String;
    property y1: Variant;
    property y2: Variant;
    property y: Variant;
    property yChannelSelector: String;
    property z: Variant;
    property zoomAndPan: String;
  end;

  WebViewHTMLAttributes = interface(HTMLAttributes)
    property allowFullScreen: Boolean;
    property allowpopups: Boolean;
    property autosize: Boolean;
    property blinkfeatures: String;
    property disableblinkfeatures: String;
    property disableguestresize: Boolean;
    property disablewebsecurity: Boolean;
    property guestinstance: String;
    property httpreferrer: String;
    property nodeintegration: Boolean;
    property partition: String;
    property plugins: Boolean;
    property preload: String;
    property src: String;
    property useragent: String;
    property webpreferences: String;
  end;

  HTMLElementType = String;

  SVGElementType = String;

  AbstractView = interface
    property styleMedia: StyleMedia;
    property document: Document;
  end;

  Touch = interface
    property identifier: Float;
    property target: EventTarget;
    property screenX: Float;
    property screenY: Float;
    property clientX: Float;
    property clientY: Float;
    property pageX: Float;
    property pageY: Float;
  end;

  TouchList = interface
    property length: Float;
    function item(index: Float): Touch;
    function identifiedTouch(identifier: Float): Touch;
  end;

  ErrorInfo = interface
    property componentStack: String;
    property digest: String;
  end;

  ElementType = Variant;

  Element = interface(React.ReactElement)
  end;

  ElementClass = interface(React.Component)
    function render: React.ReactNode;
  end;

  ElementAttributesProperty = interface
    property props: Variant;
  end;

  ElementChildrenAttribute = interface
    property children: Variant;
  end;

  LibraryManagedAttributes = Variant;

  IntrinsicAttributes = interface(React.Attributes)
  end;

  IntrinsicClassAttributes = interface(React.ClassAttributes)
  end;

  IntrinsicElements = interface
    property a: React.DetailedHTMLProps<React.AnchorHTMLAttributes<HTMLAnchorElement>, HTMLAnchorElement>;
    property abbr: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property address: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property area: React.DetailedHTMLProps<React.AreaHTMLAttributes<HTMLAreaElement>, HTMLAreaElement>;
    property article: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property aside: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property audio: React.DetailedHTMLProps<React.AudioHTMLAttributes<HTMLAudioElement>, HTMLAudioElement>;
    property b: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property base: React.DetailedHTMLProps<React.BaseHTMLAttributes<HTMLBaseElement>, HTMLBaseElement>;
    property bdi: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property bdo: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property big: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property blockquote: React.DetailedHTMLProps<React.BlockquoteHTMLAttributes<HTMLQuoteElement>, HTMLQuoteElement>;
    property body: React.DetailedHTMLProps<React.HTMLAttributes<HTMLBodyElement>, HTMLBodyElement>;
    property br: React.DetailedHTMLProps<React.HTMLAttributes<HTMLBRElement>, HTMLBRElement>;
    property button: React.DetailedHTMLProps<React.ButtonHTMLAttributes<HTMLButtonElement>, HTMLButtonElement>;
    property canvas: React.DetailedHTMLProps<React.CanvasHTMLAttributes<HTMLCanvasElement>, HTMLCanvasElement>;
    property caption: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property center: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property cite: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property code: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property col: React.DetailedHTMLProps<React.ColHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
    property colgroup: React.DetailedHTMLProps<React.ColgroupHTMLAttributes<HTMLTableColElement>, HTMLTableColElement>;
    property data: React.DetailedHTMLProps<React.DataHTMLAttributes<HTMLDataElement>, HTMLDataElement>;
    property datalist: React.DetailedHTMLProps<React.HTMLAttributes<HTMLDataListElement>, HTMLDataListElement>;
    property dd: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property del: React.DetailedHTMLProps<React.DelHTMLAttributes<HTMLModElement>, HTMLModElement>;
    property details: React.DetailedHTMLProps<React.DetailsHTMLAttributes<HTMLDetailsElement>, HTMLDetailsElement>;
    property dfn: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property dialog: React.DetailedHTMLProps<React.DialogHTMLAttributes<HTMLDialogElement>, HTMLDialogElement>;
    property div: React.DetailedHTMLProps<React.HTMLAttributes<HTMLDivElement>, HTMLDivElement>;
    property dl: React.DetailedHTMLProps<React.HTMLAttributes<HTMLDListElement>, HTMLDListElement>;
    property dt: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property em: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property embed: React.DetailedHTMLProps<React.EmbedHTMLAttributes<HTMLEmbedElement>, HTMLEmbedElement>;
    property fieldset: React.DetailedHTMLProps<React.FieldsetHTMLAttributes<HTMLFieldSetElement>, HTMLFieldSetElement>;
    property figcaption: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property figure: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property footer: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property form: React.DetailedHTMLProps<React.FormHTMLAttributes<HTMLFormElement>, HTMLFormElement>;
    property h1: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property h2: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property h3: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property h4: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property h5: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property h6: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadingElement>, HTMLHeadingElement>;
    property head: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHeadElement>, HTMLHeadElement>;
    property header: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property hgroup: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property hr: React.DetailedHTMLProps<React.HTMLAttributes<HTMLHRElement>, HTMLHRElement>;
    property html: React.DetailedHTMLProps<React.HtmlHTMLAttributes<HTMLHtmlElement>, HTMLHtmlElement>;
    property i: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property iframe: React.DetailedHTMLProps<React.IframeHTMLAttributes<HTMLIFrameElement>, HTMLIFrameElement>;
    property img: React.DetailedHTMLProps<React.ImgHTMLAttributes<HTMLImageElement>, HTMLImageElement>;
    property input: React.DetailedHTMLProps<React.InputHTMLAttributes<HTMLInputElement>, HTMLInputElement>;
    property ins: React.DetailedHTMLProps<React.InsHTMLAttributes<HTMLModElement>, HTMLModElement>;
    property kbd: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property keygen: React.DetailedHTMLProps<React.KeygenHTMLAttributes<HTMLElement>, HTMLElement>;
    property label: React.DetailedHTMLProps<React.LabelHTMLAttributes<HTMLLabelElement>, HTMLLabelElement>;
    property legend: React.DetailedHTMLProps<React.HTMLAttributes<HTMLLegendElement>, HTMLLegendElement>;
    property li: React.DetailedHTMLProps<React.LiHTMLAttributes<HTMLLIElement>, HTMLLIElement>;
    property link: React.DetailedHTMLProps<React.LinkHTMLAttributes<HTMLLinkElement>, HTMLLinkElement>;
    property main: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property map: React.DetailedHTMLProps<React.MapHTMLAttributes<HTMLMapElement>, HTMLMapElement>;
    property mark: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property menu: React.DetailedHTMLProps<React.MenuHTMLAttributes<HTMLElement>, HTMLElement>;
    property menuitem: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property meta: React.DetailedHTMLProps<React.MetaHTMLAttributes<HTMLMetaElement>, HTMLMetaElement>;
    property meter: React.DetailedHTMLProps<React.MeterHTMLAttributes<HTMLMeterElement>, HTMLMeterElement>;
    property nav: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property noindex: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property noscript: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property object: React.DetailedHTMLProps<React.ObjectHTMLAttributes<HTMLObjectElement>, HTMLObjectElement>;
    property ol: React.DetailedHTMLProps<React.OlHTMLAttributes<HTMLOListElement>, HTMLOListElement>;
    property optgroup: React.DetailedHTMLProps<React.OptgroupHTMLAttributes<HTMLOptGroupElement>, HTMLOptGroupElement>;
    property option: React.DetailedHTMLProps<React.OptionHTMLAttributes<HTMLOptionElement>, HTMLOptionElement>;
    property output: React.DetailedHTMLProps<React.OutputHTMLAttributes<HTMLOutputElement>, HTMLOutputElement>;
    property p: React.DetailedHTMLProps<React.HTMLAttributes<HTMLParagraphElement>, HTMLParagraphElement>;
    property param: React.DetailedHTMLProps<React.ParamHTMLAttributes<HTMLParamElement>, HTMLParamElement>;
    property picture: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property pre: React.DetailedHTMLProps<React.HTMLAttributes<HTMLPreElement>, HTMLPreElement>;
    property progress: React.DetailedHTMLProps<React.ProgressHTMLAttributes<HTMLProgressElement>, HTMLProgressElement>;
    property q: React.DetailedHTMLProps<React.QuoteHTMLAttributes<HTMLQuoteElement>, HTMLQuoteElement>;
    property rp: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property rt: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property ruby: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property s: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property samp: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property search: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property slot: React.DetailedHTMLProps<React.SlotHTMLAttributes<HTMLSlotElement>, HTMLSlotElement>;
    property script: React.DetailedHTMLProps<React.ScriptHTMLAttributes<HTMLScriptElement>, HTMLScriptElement>;
    property section: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property select: React.DetailedHTMLProps<React.SelectHTMLAttributes<HTMLSelectElement>, HTMLSelectElement>;
    property small: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property source: React.DetailedHTMLProps<React.SourceHTMLAttributes<HTMLSourceElement>, HTMLSourceElement>;
    property span: React.DetailedHTMLProps<React.HTMLAttributes<HTMLSpanElement>, HTMLSpanElement>;
    property strong: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property style: React.DetailedHTMLProps<React.StyleHTMLAttributes<HTMLStyleElement>, HTMLStyleElement>;
    property sub: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property summary: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property sup: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property table: React.DetailedHTMLProps<React.TableHTMLAttributes<HTMLTableElement>, HTMLTableElement>;
    property template: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTemplateElement>, HTMLTemplateElement>;
    property tbody: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
    property td: React.DetailedHTMLProps<React.TdHTMLAttributes<HTMLTableDataCellElement>, HTMLTableDataCellElement>;
    property textarea: React.DetailedHTMLProps<React.TextareaHTMLAttributes<HTMLTextAreaElement>, HTMLTextAreaElement>;
    property tfoot: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
    property th: React.DetailedHTMLProps<React.ThHTMLAttributes<HTMLTableHeaderCellElement>, HTMLTableHeaderCellElement>;
    property thead: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTableSectionElement>, HTMLTableSectionElement>;
    property time: React.DetailedHTMLProps<React.TimeHTMLAttributes<HTMLTimeElement>, HTMLTimeElement>;
    property title: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTitleElement>, HTMLTitleElement>;
    property tr: React.DetailedHTMLProps<React.HTMLAttributes<HTMLTableRowElement>, HTMLTableRowElement>;
    property track: React.DetailedHTMLProps<React.TrackHTMLAttributes<HTMLTrackElement>, HTMLTrackElement>;
    property u: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property ul: React.DetailedHTMLProps<React.HTMLAttributes<HTMLUListElement>, HTMLUListElement>;
    property video: React.DetailedHTMLProps<React.VideoHTMLAttributes<HTMLVideoElement>, HTMLVideoElement>;
    property wbr: React.DetailedHTMLProps<React.HTMLAttributes<HTMLElement>, HTMLElement>;
    property webview: React.DetailedHTMLProps<React.WebViewHTMLAttributes<HTMLWebViewElement>, HTMLWebViewElement>;
    property svg: React.SVGProps<SVGSVGElement>;
    property animate: React.SVGProps<SVGElement>;
    property animateMotion: React.SVGProps<SVGElement>;
    property animateTransform: React.SVGProps<SVGElement>;
    property circle: React.SVGProps<SVGCircleElement>;
    property clipPath: React.SVGProps<SVGClipPathElement>;
    property defs: React.SVGProps<SVGDefsElement>;
    property desc: React.SVGProps<SVGDescElement>;
    property ellipse: React.SVGProps<SVGEllipseElement>;
    property feBlend: React.SVGProps<SVGFEBlendElement>;
    property feColorMatrix: React.SVGProps<SVGFEColorMatrixElement>;
    property feComponentTransfer: React.SVGProps<SVGFEComponentTransferElement>;
    property feComposite: React.SVGProps<SVGFECompositeElement>;
    property feConvolveMatrix: React.SVGProps<SVGFEConvolveMatrixElement>;
    property feDiffuseLighting: React.SVGProps<SVGFEDiffuseLightingElement>;
    property feDisplacementMap: React.SVGProps<SVGFEDisplacementMapElement>;
    property feDistantLight: React.SVGProps<SVGFEDistantLightElement>;
    property feDropShadow: React.SVGProps<SVGFEDropShadowElement>;
    property feFlood: React.SVGProps<SVGFEFloodElement>;
    property feFuncA: React.SVGProps<SVGFEFuncAElement>;
    property feFuncB: React.SVGProps<SVGFEFuncBElement>;
    property feFuncG: React.SVGProps<SVGFEFuncGElement>;
    property feFuncR: React.SVGProps<SVGFEFuncRElement>;
    property feGaussianBlur: React.SVGProps<SVGFEGaussianBlurElement>;
    property feImage: React.SVGProps<SVGFEImageElement>;
    property feMerge: React.SVGProps<SVGFEMergeElement>;
    property feMergeNode: React.SVGProps<SVGFEMergeNodeElement>;
    property feMorphology: React.SVGProps<SVGFEMorphologyElement>;
    property feOffset: React.SVGProps<SVGFEOffsetElement>;
    property fePointLight: React.SVGProps<SVGFEPointLightElement>;
    property feSpecularLighting: React.SVGProps<SVGFESpecularLightingElement>;
    property feSpotLight: React.SVGProps<SVGFESpotLightElement>;
    property feTile: React.SVGProps<SVGFETileElement>;
    property feTurbulence: React.SVGProps<SVGFETurbulenceElement>;
    property filter: React.SVGProps<SVGFilterElement>;
    property foreignObject: React.SVGProps<SVGForeignObjectElement>;
    property g: React.SVGProps<SVGGElement>;
    property image: React.SVGProps<SVGImageElement>;
    property line: React.SVGLineElementAttributes<SVGLineElement>;
    property linearGradient: React.SVGProps<SVGLinearGradientElement>;
    property marker: React.SVGProps<SVGMarkerElement>;
    property mask: React.SVGProps<SVGMaskElement>;
    property metadata: React.SVGProps<SVGMetadataElement>;
    property mpath: React.SVGProps<SVGElement>;
    property path: React.SVGProps<SVGPathElement>;
    property pattern: React.SVGProps<SVGPatternElement>;
    property polygon: React.SVGProps<SVGPolygonElement>;
    property polyline: React.SVGProps<SVGPolylineElement>;
    property radialGradient: React.SVGProps<SVGRadialGradientElement>;
    property rect: React.SVGProps<SVGRectElement>;
    property set: React.SVGProps<SVGSetElement>;
    property stop: React.SVGProps<SVGStopElement>;
    property switch: React.SVGProps<SVGSwitchElement>;
    property symbol: React.SVGProps<SVGSymbolElement>;
    property text: React.SVGTextElementAttributes<SVGTextElement>;
    property textPath: React.SVGProps<SVGTextPathElement>;
    property tspan: React.SVGProps<SVGTSpanElement>;
    property use: React.SVGProps<SVGUseElement>;
    property view: React.SVGProps<SVGViewElement>;
  end;

  InexactPartial = Variant;

  Defaultize = Variant;

  ReactManagedAttributes = Variant;

implementation



end.
