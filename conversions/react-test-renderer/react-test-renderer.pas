unit React_test_renderer;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-test-renderer
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ReactTestRendererJSON = interface
    property type: String;
    property props: Variant;
    property children: array of ReactTestRendererNode;
  end;

  ReactTestRendererNode = Variant;

  ReactTestRendererTree = interface(ReactTestRendererJSON)
    property nodeType: String;
    property instance: Variant;
    property rendered: Variant;
  end;

  ReactTestInstance = interface
    property instance: Variant;
    property type: ElementType;
    property props: Variant;
    property parent: ReactTestInstance;
    property children: array of Variant;
    function find(predicate: function: Boolean): ReactTestInstance;
    function findByType(type: ElementType): ReactTestInstance;
    function findByProps(props: Variant): ReactTestInstance;
    function findAll(predicate: function: Boolean; options?: Variant): array of ReactTestInstance;
    function findAllByType(type: ElementType; options?: Variant): array of ReactTestInstance;
    function findAllByProps(props: Variant; options?: Variant): array of ReactTestInstance;
  end;

  ReactTestRenderer = interface
    function toJSON: Variant;
    function toTree: ReactTestRendererTree;
    procedure unmount(nextElement?: ReactElement);
    procedure update(nextElement: ReactElement);
    function getInstance: ReactTestInstance;
    property root: ReactTestInstance;
  end;

  TestRendererOptions = interface
    function createNodeMock(element: ReactElement): Variant;
  end;

  function create(nextElement: ReactElement; options?: TestRendererOptions): ReactTestRenderer;

  VoidOrUndefinedOnly = Variant;

  function act(callback: function: VoidOrUndefinedOnly): Variant;

  function act(callback: function: VoidOrUndefinedOnly): DebugPromiseLike;

  DebugPromiseLike = interface
    function then(onfulfilled: function: Variant; onrejected: function: Variant): Variant;
  end;

implementation



end.
