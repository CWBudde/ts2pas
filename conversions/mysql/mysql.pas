unit Mysql;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: mysql
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  EscapeFunctions = interface
    function escape(value: Variant; stringifyObjects?: Boolean; timeZone?: String): String;
    function escapeId(value: String; forbidQualified?: Boolean): String;
    function format(sql: String; values?: array of Variant; stringifyObjects?: Boolean; timeZone?: String): String;
  end;

  function escape(value: Variant; stringifyObjects?: Boolean; timeZone?: String): String;

  function escapeId(value: String; forbidQualified?: Boolean): String;

  function format(sql: String; values?: array of Variant; stringifyObjects?: Boolean; timeZone?: String): String;

  function createConnection(connectionUri: Variant): Connection;

  function createPool(config: Variant): Pool;

  function createPoolCluster(config?: PoolClusterConfig): PoolCluster;

  function raw(sql: String): Variant;

  Connection = interface(EscapeFunctions, events.EventEmitter)
    property config: ConnectionConfig;
    property state: Variant;
    property threadId: Float;
    property createQuery: QueryFunction;
    procedure connect(callback?: procedure);
    procedure connect(options: Variant; callback?: procedure);
    procedure changeUser(options: ConnectionOptions; callback?: procedure);
    procedure changeUser(callback: procedure);
    procedure beginTransaction(options?: QueryOptions; callback?: procedure);
    procedure beginTransaction(callback: procedure);
    procedure commit(options?: QueryOptions; callback?: procedure);
    procedure commit(callback: procedure);
    procedure rollback(options?: QueryOptions; callback?: procedure);
    procedure rollback(callback: procedure);
    property query: QueryFunction;
    procedure ping(options?: QueryOptions; callback?: procedure);
    procedure ping(callback: procedure);
    procedure statistics(options?: QueryOptions; callback?: procedure);
    procedure statistics(callback: procedure);
    procedure end(callback?: procedure);
    procedure end(options: Variant; callback: procedure);
    procedure destroy;
    procedure pause;
    procedure resume;
  end;

  PoolConnection = interface(Connection)
    procedure release;
    procedure end;
    procedure destroy;
  end;

  Pool = interface(EscapeFunctions, events.EventEmitter)
    property config: PoolActualConfig;
    procedure getConnection(callback: procedure);
    procedure acquireConnection(connection: PoolConnection; callback: procedure);
    procedure end(callback?: procedure);
    property query: QueryFunction;
  end;

  PoolCluster = interface(events.EventEmitter)
    property config: PoolClusterConfig;
    procedure add(config: PoolConfig);
    procedure add(id: String; config: PoolConfig);
    procedure end(callback?: procedure);
    function of(pattern: String; selector?: String): Pool;
    function of(pattern: Boolean; selector: String): Pool;
    procedure remove(pattern: String);
    procedure getConnection(callback: procedure);
    procedure getConnection(pattern: String; callback: procedure);
    procedure getConnection(pattern: String; selector: String; callback: procedure);
  end;

  packetCallback = procedure;

  Query = interface
    property sql: String;
    property values: array of String;
    property typeCast: TypeCast;
    property nestedTables: Boolean;
    procedure start;
    function determinePacket(byte: Float; parser: Variant): Variant;
    property OkPacket: packetCallback;
    property ErrorPacket: packetCallback;
    property ResultSetHeaderPacket: packetCallback;
    property FieldPacket: packetCallback;
    property EofPacket: packetCallback;
    procedure RowDataPacket(packet: Variant; parser: Variant; connection: Connection);
    function stream(options?: stream.ReadableOptions): stream.Readable;
    function on(ev: String; callback: procedure): Query;
  end;

  GeometryType = interface(Array)
    property x: Float;
    property y: Float;
  end;

  TypeCast = Variant;

  queryCallback = procedure;

  QueryFunction = interface
  end;

  QueryOptions = interface
    property sql: String;
    property values: Variant;
    property timeout: Float;
    property nestTables: Variant;
    property typeCast: TypeCast;
  end;

  ConnectionOptions = interface
    property user: String;
    property password: String;
    property database: String;
    property charset: String;
    property timeout: Float;
  end;

  ConnectionConfig = interface(ConnectionOptions)
    property host: String;
    property port: Float;
    property localAddress: String;
    property socketPath: String;
    property timezone: String;
    property connectTimeout: Float;
    property stringifyObjects: Boolean;
    property insecureAuth: Boolean;
    property typeCast: TypeCast;
    function queryFormat(query: String; values: Variant): String;
    property supportBigNumbers: Boolean;
    property bigNumberStrings: Boolean;
    property dateStrings: Variant;
    property debug: Variant;
    property trace: Boolean;
    property multipleStatements: Boolean;
    property flags: Variant;
    property ssl: String;
  end;

  PoolSpecificConfig = interface
    property acquireTimeout: Float;
    property waitForConnections: Boolean;
    property connectionLimit: Float;
    property queueLimit: Float;
  end;

  PoolConfig = interface(PoolSpecificConfig, ConnectionConfig)
  end;

  PoolActualConfig = interface(PoolSpecificConfig)
    property connectionConfig: ConnectionConfig;
  end;

  PoolClusterConfig = interface
    property canRetry: Boolean;
    property removeNodeErrorCount: Float;
    property restoreNodeTimeout: Float;
    property defaultSelector: String;
  end;

  MysqlError = interface(Error)
    property code: String;
    property errno: Float;
    property sqlStateMarker: String;
    property sqlState: String;
    property fieldCount: Float;
    property fatal: Boolean;
    property sql: String;
    property sqlMessage: String;
  end;

  OkPacket = interface
    property fieldCount: Float;
    property affectedRows: Float;
    property insertId: Float;
    property serverStatus: Float;
    property warningCount: Float;
    property message: String;
    property changedRows: Float;
    property protocol41: Boolean;
  end;

  Types = (
    DECIMAL,
    TINY,
    SHORT,
    LONG,
    FLOAT,
    DOUBLE,
    NULL,
    TIMESTAMP,
    LONGLONG,
    INT24,
    DATE,
    TIME,
    DATETIME,
    YEAR,
    NEWDATE,
    VARCHAR,
    BIT,
    TIMESTAMP2,
    DATETIME2,
    TIME2,
    JSON,
    NEWDECIMAL,
    ENUM,
    SET,
    TINY_BLOB,
    MEDIUM_BLOB,
    LONG_BLOB,
    BLOB,
    VAR_STRING,
    STRING,
    GEOMETRY
  );

  UntypedFieldInfo = interface
    property catalog: String;
    property db: String;
    property table: String;
    property orgTable: String;
    property name: String;
    property orgName: String;
    property charsetNr: Float;
    property length: Float;
    property flags: Float;
    property decimals: Float;
    property default: String;
    property zeroFill: Boolean;
    property protocol41: Boolean;
  end;

  FieldInfo = interface(UntypedFieldInfo)
    property type: Types;
  end;

implementation



end.
