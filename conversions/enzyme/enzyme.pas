unit Enzyme;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: enzyme
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  HTMLAttributes = Variant;

  ElementClass = class(Component) external
  end;

  ComponentClass = interface
  end;

  FunctionComponent = function: JSX.Element;

  ComponentType = Variant;

  EnzymePropSelector = interface
  end;

  EnzymeSelector = Variant;

  Intercepter = procedure;

  CommonWrapper = interface
    function filterWhere(predicate: function: Boolean): Variant;
    function contains(node: Variant): Boolean;
    function containsMatchingElement(node: Variant): Boolean;
    function containsAllMatchingElements(nodes: Variant): Boolean;
    function containsAnyMatchingElements(nodes: Variant): Boolean;
    function equals(node: ReactElement): Boolean;
    function matchesElement(node: ReactElement): Boolean;
    function hasClass(className: Variant): Boolean;
    function invoke(invokePropName: K): Variant;
    function is(selector: EnzymeSelector): Boolean;
    function isEmpty: Boolean;
    function exists(selector?: EnzymeSelector): Boolean;
    function not(selector: EnzymeSelector): Variant;
    function text: String;
    function html: String;
    function get(index: Float): ReactElement;
    function getNode: ReactElement;
    function getNodes: array of ReactElement;
    function getElement: ReactElement;
    function getElements: array of ReactElement;
    function getDOMNode: T;
    function at(index: Float): Variant;
    function first: Variant;
    function last: Variant;
    function slice(begin?: Float; end?: Float): Variant;
    function tap(intercepter: Intercepter<Variant>): Variant;
    function state: S;
    function state(key: K): Variant;
    function state(key: String): T;
    function context: Variant;
    function context(key: String): T;
    function props: P;
    function prop(key: K): Variant;
    function prop(key: String): T;
    function key: String;
    function simulate(event: String; args: array of Variant): Variant;
    function simulateError(error: Variant): Variant;
    function setState(state: Pick<S, K>; callback?: procedure): Variant;
    function setProps(props: Pick<P, K>; callback?: procedure): Variant;
    function setContext(context: Variant): Variant;
    function instance: C;
    function update: Variant;
    function debug(options?: Variant): String;
    function name: String;
    function forEach(fn: function: Variant): Variant;
    function map(fn: function: V): array of V;
    function reduce(fn: function: R; initialValue?: R): R;
    function reduceRight(fn: function: R; initialValue?: R): R;
    function some(selector: EnzymeSelector): Boolean;
    function someWhere(fn: function: Boolean): Boolean;
    function every(selector: EnzymeSelector): Boolean;
    function everyWhere(fn: function: Boolean): Boolean;
    function isEmptyRender: Boolean;
    function render: cheerio.Cheerio;
    function type: Variant;
    property length: Float;
  end;

  Parameters = Variant;

  ShallowWrapper = interface(CommonWrapper)
  end;

  ShallowWrapper = class external
    procedure Create(nodes: Variant; root?: ShallowWrapper<Variant, Variant>; options?: ShallowRendererProps);
    function shallow(options?: ShallowRendererProps): ShallowWrapper<P, S>;
    function unmount: Variant;
    function find(statelessComponent: FunctionComponent<P2>): ShallowWrapper<P2, Variant>;
    function find(component: ComponentType<P2>): ShallowWrapper<P2, Variant>;
    function find(componentClass: ComponentClass<Variant>): ShallowWrapper<Variant, Variant, C2>;
    function find(props: EnzymePropSelector): ShallowWrapper<Variant, Variant>;
    function find(selector: String): ShallowWrapper<HTMLAttributes, Variant>;
    function filter(statelessComponent: FunctionComponent<P2>): ShallowWrapper<P2, Variant>;
    function filter(component: ComponentType<P2>): ShallowWrapper<P2, Variant>;
    function filter(props: Variant): ShallowWrapper<P, S>;
    function findWhere(predicate: function: Boolean): ShallowWrapper<Variant, Variant>;
    function children(statelessComponent: FunctionComponent<P2>): ShallowWrapper<P2, Variant>;
    function children(component: ComponentType<P2>): ShallowWrapper<P2, Variant>;
    function children(selector: String): ShallowWrapper<HTMLAttributes, Variant>;
    function children(props?: EnzymePropSelector): ShallowWrapper<Variant, Variant>;
    function childAt(index: Float): ShallowWrapper<Variant, Variant>;
    function childAt(index: Float): ShallowWrapper<P2, S2>;
    function dive(options?: ShallowRendererProps): ShallowWrapper<P2, S2, C2>;
    function dive(options?: ShallowRendererProps): ShallowWrapper<P2, S2>;
    function hostNodes: ShallowWrapper<HTMLAttributes>;
    function parents(statelessComponent: FunctionComponent<P2>): ShallowWrapper<P2, Variant>;
    function parents(component: ComponentType<P2>): ShallowWrapper<P2, Variant>;
    function parents(selector: String): ShallowWrapper<HTMLAttributes, Variant>;
    function parents(props?: EnzymePropSelector): ShallowWrapper<Variant, Variant>;
    function closest(statelessComponent: FunctionComponent<P2>): ShallowWrapper<P2, Variant>;
    function closest(component: ComponentType<P2>): ShallowWrapper<P2, Variant>;
    function closest(props: EnzymePropSelector): ShallowWrapper<Variant, Variant>;
    function closest(selector: String): ShallowWrapper<HTMLAttributes, Variant>;
    function parent: ShallowWrapper<Variant, Variant>;
    function renderProp(prop: PropName): function: ShallowWrapper<Variant, Variant>;
    property getWrappingComponent: function: ShallowWrapper;
  end;

  ReactWrapper = interface(CommonWrapper)
  end;

  ReactWrapper = class external
    procedure Create(nodes: Variant; root?: ReactWrapper<Variant, Variant>; options?: MountRendererProps);
    function unmount: Variant;
    function mount: Variant;
    function ref(refName: String): ReactWrapper<Variant, Variant>;
    function ref(refName: String): ReactWrapper<P2, S2>;
    procedure detach;
    function hostNodes: ReactWrapper<HTMLAttributes>;
    function find(statelessComponent: FunctionComponent<P2>): ReactWrapper<P2, Variant>;
    function find(component: ComponentType<P2>): ReactWrapper<P2, Variant>;
    function find(componentClass: ComponentClass<Variant>): ReactWrapper<Variant, Variant, C2>;
    function find(props: EnzymePropSelector): ReactWrapper<Variant, Variant>;
    function find(selector: String): ReactWrapper<HTMLAttributes, Variant>;
    function findWhere(predicate: function: Boolean): ReactWrapper<Variant, Variant>;
    function filter(statelessComponent: FunctionComponent<P2>): ReactWrapper<P2, Variant>;
    function filter(component: ComponentType<P2>): ReactWrapper<P2, Variant>;
    function filter(props: Variant): ReactWrapper<P, S>;
    function children(statelessComponent: FunctionComponent<P2>): ReactWrapper<P2, Variant>;
    function children(component: ComponentType<P2>): ReactWrapper<P2, Variant>;
    function children(selector: String): ReactWrapper<HTMLAttributes, Variant>;
    function children(props?: EnzymePropSelector): ReactWrapper<Variant, Variant>;
    function childAt(index: Float): ReactWrapper<Variant, Variant>;
    function childAt(index: Float): ReactWrapper<P2, S2>;
    function parents(statelessComponent: FunctionComponent<P2>): ReactWrapper<P2, Variant>;
    function parents(component: ComponentType<P2>): ReactWrapper<P2, Variant>;
    function parents(selector: String): ReactWrapper<HTMLAttributes, Variant>;
    function parents(props?: EnzymePropSelector): ReactWrapper<Variant, Variant>;
    function closest(statelessComponent: FunctionComponent<P2>): ReactWrapper<P2, Variant>;
    function closest(component: ComponentType<P2>): ReactWrapper<P2, Variant>;
    function closest(props: EnzymePropSelector): ReactWrapper<Variant, Variant>;
    function closest(selector: String): ReactWrapper<HTMLAttributes, Variant>;
    function parent: ReactWrapper<Variant, Variant>;
    function renderProp(prop: PropName): function: ReactWrapper<Variant, Variant>;
    property getWrappingComponent: function: ReactWrapper;
  end;

  Lifecycles = interface
    property componentDidUpdate: Variant;
    property getDerivedStateFromProps: Boolean;
    property getChildContext: Variant;
    property setState: Variant;
  end;

  ShallowRendererProps = interface
    property disableLifecycleMethods: Boolean;
    property lifecycleExperimental: Boolean;
    property context: Variant;
    property enableComponentDidUpdateOnSetState: Boolean;
    property supportPrevContextArgumentOfComponentDidUpdate: Boolean;
    property lifecycles: Lifecycles;
    property wrappingComponent: ComponentType<Variant>;
    property wrappingComponentProps: Variant;
    property suspenseFallback: Boolean;
    property adapter: EnzymeAdapter;
    property attachTo: Variant;
    property hydrateIn: Variant;
    property PROVIDER_VALUES: Variant;
  end;

  MountRendererProps = interface
    property context: Variant;
    property attachTo: HTMLElement;
    property childContextTypes: Variant;
    property wrappingComponent: ComponentType<Variant>;
    property wrappingComponentProps: Variant;
  end;

  function shallow(node: ReactElement<P>; options?: ShallowRendererProps): ShallowWrapper<P, S, C>;

  function shallow(node: ReactElement<P>; options?: ShallowRendererProps): ShallowWrapper<P, Variant>;

  function shallow(node: ReactElement<P>; options?: ShallowRendererProps): ShallowWrapper<P, S>;

  function mount(node: ReactElement<P>; options?: MountRendererProps): ReactWrapper<P, S, C>;

  function mount(node: ReactElement<P>; options?: MountRendererProps): ReactWrapper<P, Variant>;

  function mount(node: ReactElement<P>; options?: MountRendererProps): ReactWrapper<P, S>;

  function render(node: ReactElement<P>; options?: Variant): cheerio.Cheerio;

  EnzymeAdapter = class external
    property wrapWithWrappingComponent: function: Variant;
  end;

  procedure configure(options: Variant);

implementation



end.
