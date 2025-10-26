unit Multer;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: multer
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  File = interface
    property fieldname: String;
    property originalname: String;
    property encoding: String;
    property mimetype: String;
    property size: Float;
    property stream: Readable;
    property destination: String;
    property filename: String;
    property path: String;
    property buffer: Buffer;
  end;

  Request = interface
    property file: Multer.File;
    property files: array of Multer.File;
  end;

  function multer(options?: multer.Options): multer.Multer;

  Multer = interface
    function single(fieldName: String): RequestHandler;
    function array(fieldName: String; maxCount?: Float): RequestHandler;
    function fields(fields: Variant): RequestHandler;
    function any: RequestHandler;
    function none: RequestHandler;
  end;

  function diskStorage(options: DiskStorageOptions): StorageEngine;

  function memoryStorage: StorageEngine;

  ErrorCode = String;

  MulterError = class(Error) external
    procedure Create(code: ErrorCode; field?: String);
    property name: String;
    property code: ErrorCode;
    property message: String;
    property field: String;
  end;

  FileFilterCallback = interface
  end;

  Options = interface
    property storage: StorageEngine;
    property dest: String;
    property limits: Variant;
    property preservePath: Boolean;
    procedure fileFilter(req: Request; file: Express.Multer.File; callback: FileFilterCallback);
  end;

  StorageEngine = interface
    procedure _handleFile(req: Request; file: Express.Multer.File; callback: procedure);
    procedure _removeFile(req: Request; file: Express.Multer.File; callback: procedure);
  end;

  DiskStorageOptions = interface
    property destination: Variant;
    procedure filename(req: Request; file: Express.Multer.File; callback: procedure);
  end;

  Field = interface
    property name: String;
    property maxCount: Float;
  end;

implementation



end.
