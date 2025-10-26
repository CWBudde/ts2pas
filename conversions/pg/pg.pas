unit Pg;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: pg
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  QueryConfigValues = Variant;

  ClientConfig = interface
    property user: String;
    property database: String;
    property password: Variant;
    property port: Float;
    property host: String;
    property connectionString: String;
    property keepAlive: Boolean;
    property stream: function: stream.Duplex;
    property statement_timeout: Variant;
    property ssl: Variant;
    property query_timeout: Float;
    property lock_timeout: Float;
    property keepAliveInitialDelayMillis: Float;
    property idle_in_transaction_session_timeout: Float;
    property application_name: String;
    property fallback_application_name: String;
    property connectionTimeoutMillis: Float;
    property types: CustomTypesConfig;
    property options: String;
    property client_encoding: String;
  end;

  ConnectionConfig = ClientConfig;

  Defaults = interface(ClientConfig)
    property poolSize: Float;
    property poolIdleTimeout: Float;
    property reapIntervalMillis: Float;
    property binary: Boolean;
    property parseInt8: Boolean;
    property parseInputDatesAsUTC: Boolean;
  end;

  PoolConfig = interface(ClientConfig)
    property max: Float;
    property min: Float;
    property idleTimeoutMillis: Float;
    property log: procedure;
    property Promise: PromiseConstructorLike;
    property allowExitOnIdle: Boolean;
    property maxUses: Float;
    property maxLifetimeSeconds: Float;
    property Client: ClientBase;
  end;

  QueryConfig = interface
    property name: String;
    property text: String;
    property values: QueryConfigValues<I>;
    property types: CustomTypesConfig;
  end;

  CustomTypesConfig = interface
    property getTypeParser: Variant;
  end;

  Submittable = interface
    property submit: procedure;
  end;

  QueryArrayConfig = interface(QueryConfig)
    property rowMode: String;
  end;

  FieldDef = interface
    property name: String;
    property tableID: Float;
    property columnID: Float;
    property dataTypeID: Float;
    property dataTypeSize: Float;
    property dataTypeModifier: Float;
    property format: String;
  end;

  QueryResultBase = interface
    property command: String;
    property rowCount: Float;
    property oid: Float;
    property fields: array of FieldDef;
  end;

  QueryResultRow = interface
  end;

  QueryResult = interface(QueryResultBase)
    property rows: array of R;
  end;

  QueryArrayResult = interface(QueryResultBase)
    property rows: array of R;
  end;

  Notification = interface
    property processId: Float;
    property channel: String;
    property payload: String;
  end;

  ResultBuilder = interface(QueryResult)
    procedure addRow(row: R);
  end;

  QueryParse = interface
    property name: String;
    property text: String;
    property types: array of String;
  end;

  ValueMapper = function: Variant;

  BindConfig = interface
    property portal: String;
    property statement: String;
    property binary: String;
    property values: array of Variant;
    property valueMapper: ValueMapper;
  end;

  ExecuteConfig = interface
    property portal: String;
    property rows: String;
  end;

  MessageConfig = interface
    property type: String;
    property name: String;
  end;

  function escapeIdentifier(str: String): String;

  function escapeLiteral(str: String): String;

  Connection = class(events.EventEmitter) external
    property stream: stream.Duplex; read only
    procedure Create(config?: ConnectionConfig);
    procedure bind(config: BindConfig; more: Boolean);
    procedure execute(config: ExecuteConfig; more: Boolean);
    procedure parse(query: QueryParse; more: Boolean);
    procedure query(text: String);
    procedure describe(msg: MessageConfig; more: Boolean);
    procedure close(msg: MessageConfig; more: Boolean);
    procedure flush;
    procedure sync;
    procedure end;
  end;

  PoolOptions = interface(PoolConfig)
    property max: Float;
    property maxUses: Float;
    property allowExitOnIdle: Boolean;
    property maxLifetimeSeconds: Float;
    property idleTimeoutMillis: Float;
  end;

  Pool = class(events.EventEmitter) external
    procedure Create(config?: PoolConfig);
    property totalCount: Float; read only
    property idleCount: Float; read only
    property waitingCount: Float; read only
    property expiredCount: Float; read only
    property ending: Boolean; read only
    property ended: Boolean; read only
    property options: PoolOptions;
    function connect: PoolClient;
    procedure connect(callback: procedure);
    function end: Variant;
    procedure end(callback: procedure);
    function query(queryStream: T): T;
    function query(queryConfig: QueryArrayConfig<I>; values?: QueryConfigValues<I>): QueryArrayResult<R>;
    function query(queryConfig: QueryConfig<I>): QueryResult<R>;
    function query(queryTextOrConfig: Variant; values?: QueryConfigValues<I>): QueryResult<R>;
    procedure query(queryConfig: QueryArrayConfig<I>; callback: procedure);
    procedure query(queryTextOrConfig: Variant; callback: procedure);
    procedure query(queryText: String; values: QueryConfigValues<I>; callback: procedure);
    function on(event: String; listener: procedure): Variant;
  end;

  ClientBase = class(events.EventEmitter) external
    procedure Create(config?: Variant);
    function connect: Variant;
    procedure connect(callback: procedure);
    function query(queryStream: T): T;
    function query(queryConfig: QueryArrayConfig<I>; values?: QueryConfigValues<I>): QueryArrayResult<R>;
    function query(queryConfig: QueryConfig<I>): QueryResult<R>;
    function query(queryTextOrConfig: Variant; values?: QueryConfigValues<I>): QueryResult<R>;
    procedure query(queryConfig: QueryArrayConfig<I>; callback: procedure);
    procedure query(queryTextOrConfig: Variant; callback: procedure);
    procedure query(queryText: String; values: QueryConfigValues<I>; callback: procedure);
    function copyFrom(queryText: String): stream.Writable;
    function copyTo(queryText: String): stream.Readable;
    procedure pauseDrain;
    procedure resumeDrain;
    property escapeIdentifier: Variant;
    property escapeLiteral: Variant;
    property setTypeParser: Variant;
    property getTypeParser: Variant;
    function on(event: String; listener: procedure): Variant;
  end;

  Client = class(ClientBase) external
    property user: String;
    property database: String;
    property port: Float;
    property host: String;
    property password: String;
    property ssl: Boolean;
    property connection: Connection; read only
    procedure Create(config?: Variant);
    function end: Variant;
    procedure end(callback: procedure);
  end;

  PoolClient = interface(ClientBase)
    procedure release(err?: Variant);
  end;

  Query = class(events.EventEmitter, Submittable) external
    procedure Create(queryTextOrConfig?: Variant; values?: QueryConfigValues<I>);
    property submit: procedure;
    function on(event: String; listener: procedure): Variant;
  end;

  Events = class(events.EventEmitter) external
    function on(event: String; listener: procedure): Variant;
  end;

  Result = class(QueryResult) external
    property command: String;
    property rowCount: Float;
    property oid: Float;
    property fields: array of FieldDef;
    property rows: array of R;
    procedure Create(rowMode: String; t: Variant);
  end;

implementation



end.
