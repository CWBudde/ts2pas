unit Ws;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: ws
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  BufferLike = Variant;

  WebSocket = class(EventEmitter) external
    property CONNECTING: Float; read only
    property OPEN: Float; read only
    property CLOSING: Float; read only
    property CLOSED: Float; read only
    property binaryType: String;
    property bufferedAmount: Float; read only
    property extensions: String; read only
    property isPaused: Boolean; read only
    property protocol: String; read only
    property readyState: Variant; read only
    property url: String; read only
    property CONNECTING: Float; read only
    property OPEN: Float; read only
    property CLOSING: Float; read only
    property CLOSED: Float; read only
    property onopen: procedure;
    property onerror: procedure;
    property onclose: procedure;
    property onmessage: procedure;
    procedure Create(address: Variant);
    procedure Create(address: Variant; options?: Variant);
    procedure Create(address: Variant; protocols?: Variant; options?: Variant);
    procedure close(code?: Float; data?: Variant);
    procedure ping(data?: Variant; mask?: Boolean; cb?: procedure);
    procedure pong(data?: Variant; mask?: Boolean; cb?: procedure);
    procedure send(data: BufferLike; cb?: procedure);
    procedure send(data: BufferLike; options: Variant; cb?: procedure);
    procedure terminate;
    procedure pause;
    procedure resume;
    procedure addEventListener(type: K; listener: procedure; options?: WebSocket.EventListenerOptions);
    procedure removeEventListener(type: K; listener: procedure);
    function on(event: String; listener: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function off(event: String; listener: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
  end;

  WebSocketAlias = interface(WebSocket)
  end;

  RawData = Variant;

  Data = Variant;

  CertMeta = Variant;

  VerifyClientCallbackSync = function: Boolean;

  VerifyClientCallbackAsync = procedure;

  FinishRequestCallback = procedure;

  ClientOptions = interface(SecureContextOptions)
    property protocol: String;
    property followRedirects: Boolean;
    procedure generateMask(mask: Buffer);
    property handshakeTimeout: Float;
    property maxRedirects: Float;
    property perMessageDeflate: Variant;
    property localAddress: String;
    property protocolVersion: Float;
    property headers: Variant;
    property origin: String;
    property agent: Agent;
    property host: String;
    property family: Float;
    function checkServerIdentity(servername: String; cert: CertMeta): Boolean;
    property rejectUnauthorized: Boolean;
    property allowSynchronousEvents: Boolean;
    property autoPong: Boolean;
    property maxPayload: Float;
    property skipUTF8Validation: Boolean;
    property createConnection: Variant;
    property finishRequest: FinishRequestCallback;
  end;

  PerMessageDeflateOptions = interface
    property serverNoContextTakeover: Boolean;
    property clientNoContextTakeover: Boolean;
    property serverMaxWindowBits: Float;
    property clientMaxWindowBits: Float;
    property zlibDeflateOptions: Variant;
    property zlibInflateOptions: ZlibOptions;
    property threshold: Float;
    property concurrencyLimit: Float;
  end;

  Event = interface
    property type: String;
    property target: WebSocket;
  end;

  ErrorEvent = interface
    property error: Variant;
    property message: String;
    property type: String;
    property target: WebSocket;
  end;

  CloseEvent = interface
    property wasClean: Boolean;
    property code: Float;
    property reason: String;
    property type: String;
    property target: WebSocket;
  end;

  MessageEvent = interface
    property data: Data;
    property type: String;
    property target: WebSocket;
  end;

  WebSocketEventMap = interface
    property open: Event;
    property error: ErrorEvent;
    property close: CloseEvent;
    property message: MessageEvent;
  end;

  EventListenerOptions = interface
    property once: Boolean;
  end;

  ServerOptions = interface
    property host: String;
    property port: Float;
    property backlog: Float;
    property server: Variant;
    property verifyClient: Variant;
    property handleProtocols: function: Variant;
    property path: String;
    property noServer: Boolean;
    property allowSynchronousEvents: Boolean;
    property autoPong: Boolean;
    property clientTracking: Boolean;
    property perMessageDeflate: Variant;
    property maxPayload: Float;
    property skipUTF8Validation: Boolean;
    property WebSocket: U;
  end;

  AddressInfo = interface
    property address: String;
    property family: String;
    property port: Float;
  end;

  Server = class(EventEmitter) external
    property options: ServerOptions<T, U>;
    property path: String;
    property clients: Variant;
    procedure Create(options?: ServerOptions<T, U>; callback?: procedure);
    function address: Variant;
    procedure close(cb?: procedure);
    procedure handleUpgrade(request: InstanceType<U>; socket: Duplex; upgradeHead: Buffer; callback: procedure);
    function shouldHandle(request: InstanceType<U>): Boolean;
    function on(event: String; cb: procedure): Variant;
    function on(event: String; listener: procedure): Variant;
    function once(event: String; cb: procedure): Variant;
    function once(event: String; listener: procedure): Variant;
    function off(event: String; cb: procedure): Variant;
    function off(event: String; listener: procedure): Variant;
    function addListener(event: String; cb: procedure): Variant;
    function addListener(event: String; listener: procedure): Variant;
    function removeListener(event: String; cb: procedure): Variant;
    function removeListener(event: String; listener: procedure): Variant;
  end;

  WebSocketServer = interface(Server)
  end;

  WebSocket = interface(WebSocketAlias)
  end;

  function createWebSocketStream(websocket: WebSocket; options?: DuplexOptions): Duplex;

implementation



end.
