unit Styled_components;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: styled-components
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  ReadableStream = interface
  end;

  ShadowRoot = interface
  end;

  CSSProperties = CSS.Properties<Variant>;

  CSSPseudos = Variant;

  CSSObject = interface(CSSProperties, CSSPseudos)
  end;

  CSSKeyframes = Variant;

  ThemeProps = interface
    property theme: T;
  end;

  ThemedStyledProps = Variant;

  StyledProps = ThemedStyledProps<P, AnyIfEmpty<DefaultTheme>>;

  IntrinsicElementsKeys = Variant;

  Defaultize = Variant;

  ReactDefaultizedProps = Variant;

  MakeAttrsOptional = Variant;

  StyledComponentProps = Variant;

  StyledComponentPropsWithAs = Variant;

  FalseyValue = Boolean;

  Interpolation = Variant;

  FlattenInterpolation = array of Interpolation<P>;

  InterpolationValue = Variant;

  SimpleInterpolation = Variant;

  FlattenSimpleInterpolation = Variant;

  InterpolationFunction = function: Interpolation<P>;

  Attrs = Variant;

  ThemedGlobalStyledClassProps = Variant;

  GlobalStyleComponent = interface(React.ComponentClass)
  end;

  StyledComponentInterpolation = Variant;

  ForwardRefExoticBase = PickU<React.ForwardRefExoticComponent<P>, Variant>;

  StyledConfig = interface
    property componentId: String;
    property displayName: String;
    property shouldForwardProp: function: Boolean;
  end;

  ReactDefaultProps = Variant;

  AnyStyledComponent = Variant;

  StyledComponent = Variant;

  StyledComponentBase = interface(ForwardRefExoticBase)
    function withComponent(component: WithC): StyledComponent<StyledComponentInnerComponent<WithC>, T, Variant, Variant>;
    function withComponent(component: WithC): StyledComponent<WithC, T, O, A>;
  end;

  ThemedStyledFunctionBase = interface
  end;

  ThemedStyledFunction = interface(ThemedStyledFunctionBase)
    function attrs(attrs: Attrs<Variant, NewA, T>): ThemedStyledFunction<C, T, Variant, A>;
    property withConfig: function: ThemedStyledFunction<C, T, Props, A>;
  end;

  StyledFunction = ThemedStyledFunction<C, Variant>;

  ThemedStyledComponentFactories = Variant;

  StyledComponentInnerComponent = Variant;

  StyledComponentPropsWithRef = Variant;

  StyledComponentInnerOtherProps = Variant;

  StyledComponentInnerAttrs = Variant;

  ThemedBaseStyledInterface = interface(ThemedStyledComponentFactories)
  end;

  ThemedStyledInterface = ThemedBaseStyledInterface<AnyIfEmpty<T>>;

  StyledInterface = ThemedStyledInterface<DefaultTheme>;

  BaseThemedCssFunction = interface
  end;

  ThemedCssFunction = BaseThemedCssFunction<AnyIfEmpty<T>>;

  PickU = Variant;

  OmitU = Variant;

  WithOptionalTheme = Variant;

  AnyIfEmpty = Variant;

  ThemedStyledComponentsModule = interface
    property default: ThemedStyledInterface<T>;
    property css: ThemedCssFunction<T>;
    property keyframes: function: Keyframes;
    property createGlobalStyle: function: GlobalStyleComponent<P, T>;
    property withTheme: BaseWithThemeFnInterface<T>;
    property ThemeProvider: BaseThemeProviderComponent<T, U>;
    property ThemeConsumer: React.Consumer<T>;
    property ThemeContext: React.Context<T>;
    function useTheme: T;
    property isStyledComponent: Variant;
    property ServerStyleSheet: Variant;
    property StyleSheetManager: Variant;
  end;

  BaseWithThemeFnInterface = function: React.ForwardRefExoticComponent<WithOptionalTheme<React.JSX.LibraryManagedAttributes<C, React.ComponentPropsWithRef<C>>, T>>;

  WithThemeFnInterface = BaseWithThemeFnInterface<AnyIfEmpty<T>>;

  function useTheme: DefaultTheme;

  DefaultTheme = interface
  end;

  ThemeProviderProps = interface
    property children: React.ReactNode;
    property theme: Variant;
  end;

  BaseThemeProviderComponent = React.ComponentClass<ThemeProviderProps<T, U>>;

  ThemeProviderComponent = BaseThemeProviderComponent<AnyIfEmpty<T>, AnyIfEmpty<U>>;

  Keyframes = interface
    function getName: String;
  end;

  function keyframes(strings: Variant; interpolations: array of SimpleInterpolation): Keyframes;

  function createGlobalStyle(first: Variant; interpolations: array of Interpolation<ThemedStyledProps<P, DefaultTheme>>): GlobalStyleComponent<P, DefaultTheme>;

  function isStyledComponent(target: Variant): Variant;

  ServerStyleSheet = class external
    function collectStyles(tree: React.ReactNode): React.ReactElement<Variant>;
    function getStyleTags: String;
    function getStyleElement: array of React.ReactElement<Variant>;
    function interleaveWithNodeStream(readableStream: NodeJS.ReadableStream): NodeJS.ReadableStream;
    property instance: Variant; read only
    procedure seal;
    procedure clearTag;
  end;

  StylisPlugin = function: String;

  StyleSheetManagerProps = interface
    property children: React.ReactNode;
    property disableCSSOMInjection: Boolean;
    property disableVendorPrefixes: Boolean;
    property stylisPlugins: array of StylisPlugin;
    property sheet: ServerStyleSheet;
    property target: Variant;
  end;

  StyleSheetManager = class(React.Component) external
  end;

  CSSProp = Variant;

implementation



end.
