unit Fs_extra;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: fs-extra
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  function copy(src: String; dest: String; options?: CopyOptions): Variant;

  procedure copy(src: String; dest: String; callback: NoParamCallbackWithUndefined);

  procedure copy(src: String; dest: String; options: CopyOptions; callback: NoParamCallbackWithUndefined);

  procedure copySync(src: String; dest: String; options?: CopyOptionsSync);

  function move(src: String; dest: String; options?: MoveOptions): Variant;

  procedure move(src: String; dest: String; callback: NoParamCallbackWithUndefined);

  procedure move(src: String; dest: String; options: MoveOptions; callback: NoParamCallbackWithUndefined);

  procedure moveSync(src: String; dest: String; options?: MoveOptions);

  function ensureFile(file: String): Variant;

  procedure ensureFile(file: String; callback: NoParamCallbackWithUndefined);

  procedure ensureFileSync(file: String);

  function ensureLink(src: String; dest: String): Variant;

  procedure ensureLink(src: String; dest: String; callback: fs.NoParamCallback);

  procedure ensureLinkSync(src: String; dest: String);

  function ensureSymlink(src: String; dest: String; type?: SymlinkType): Variant;

  procedure ensureSymlink(src: String; dest: String; callback: fs.NoParamCallback);

  procedure ensureSymlink(src: String; dest: String; type: SymlinkType; callback: fs.NoParamCallback);

  procedure ensureSymlinkSync(src: String; dest: String; type?: SymlinkType);

  function ensureDir(path: String; options?: Variant): Variant;

  procedure ensureDir(path: String; callback: fs.NoParamCallback);

  procedure ensureDir(path: String; options: Variant; callback: fs.NoParamCallback);

  procedure ensureDirSync(path: String; options?: Variant);

  function outputFile(file: String; data: Variant; options?: fs.WriteFileOptions): Variant;

  procedure outputFile(file: String; data: Variant; callback: fs.NoParamCallback);

  procedure outputFile(file: String; data: Variant; options: fs.WriteFileOptions; callback: fs.NoParamCallback);

  procedure outputFileSync(file: String; data: Variant; options?: fs.WriteFileOptions);

  function outputJson(file: String; data: Variant; options?: JsonOutputOptions): Variant;

  procedure outputJson(file: String; data: Variant; options: JsonOutputOptions; callback: fs.NoParamCallback);

  procedure outputJson(file: String; data: Variant; callback: fs.NoParamCallback);

  procedure outputJsonSync(file: String; data: Variant; options?: JsonOutputOptions);

  function remove(dir: String): Variant;

  procedure remove(dir: String; callback: fs.NoParamCallback);

  procedure removeSync(dir: String);

  function emptyDir(path: String): Variant;

  procedure emptyDir(path: String; callback: fs.NoParamCallback);

  procedure emptyDirSync(path: String);

  function pathExists(path: String): Boolean;

  procedure pathExists(path: String; callback: procedure);

  function pathExistsSync(path: String): Boolean;

  NoParamCallbackWithUndefined = procedure;

  SymlinkType = fs.symlink.Type;

  CopyFilterSync = function: Boolean;

  CopyFilterAsync = function: Boolean;

  CopyOptions = interface
    property dereference: Boolean;
    property overwrite: Boolean;
    property preserveTimestamps: Boolean;
    property errorOnExist: Boolean;
    property filter: Variant;
  end;

  CopyOptionsSync = interface(CopyOptions)
    property filter: CopyFilterSync;
  end;

  EnsureDirOptions = interface
    property mode: Float;
  end;

  MoveOptions = interface
    property overwrite: Boolean;
    property dereference: Boolean;
  end;

  JsonOutputOptions = Variant;

implementation



end.
