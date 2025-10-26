unit React_dom;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-dom
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  CacheSignal = interface(AbortSignal)
  end;

  function createPortal(children: ReactNode; container: Variant; key?: Key): ReactPortal;

  function flushSync(fn: function: R): R;

  function unstable_batchedUpdates(callback: function: R; a: A): R;

  function unstable_batchedUpdates(callback: function: R): R;

  FormStatusNotPending = interface
    property pending: Boolean;
    property data: Variant;
    property method: Variant;
    property action: Variant;
  end;

  FormStatusPending = interface
    property pending: Boolean;
    property data: FormData;
    property method: String;
    property action: Variant;
  end;

  FormStatus = Variant;

  function useFormStatus: FormStatus;

  function useFormState(action: function: State; initialState: Awaited<State>; permalink?: String): array of Variant;

  function useFormState(action: function: State; initialState: Awaited<State>; permalink?: String): array of Variant;

  procedure prefetchDNS(href: String);

  PreconnectOptions = interface
    property crossOrigin: Variant;
  end;

  procedure preconnect(href: String; options?: PreconnectOptions);

  PreloadAs = String;

  PreloadOptions = interface
    property as: PreloadAs;
    property crossOrigin: Variant;
    property fetchPriority: Variant;
    property imageSizes: String;
    property imageSrcSet: String;
    property integrity: String;
    property type: String;
    property nonce: String;
    property referrerPolicy: ReferrerPolicy;
    property media: String;
  end;

  procedure preload(href: String; options?: PreloadOptions);

  PreloadModuleAs = RequestDestination;

  PreloadModuleOptions = interface
    property as: PreloadModuleAs;
    property crossOrigin: Variant;
    property integrity: String;
    property nonce: String;
  end;

  procedure preloadModule(href: String; options?: PreloadModuleOptions);

  PreinitAs = String;

  PreinitOptions = interface
    property as: PreinitAs;
    property crossOrigin: Variant;
    property fetchPriority: Variant;
    property precedence: String;
    property integrity: String;
    property nonce: String;
  end;

  procedure preinit(href: String; options?: PreinitOptions);

  PreinitModuleAs = String;

  PreinitModuleOptions = interface
    property as: PreinitModuleAs;
    property crossOrigin: Variant;
    property integrity: String;
    property nonce: String;
  end;

  procedure preinitModule(href: String; options?: PreinitModuleOptions);

  procedure requestFormReset(form: HTMLFormElement);

implementation



end.
