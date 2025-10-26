unit Cli_progress;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: cli-progress
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Params = interface
    property progress: Float;
    property eta: Float;
    property startTime: Float;
    property stopTime: Float;
    property total: Float;
    property value: Float;
    property maxWidth: Float;
  end;

  Options = interface
    property format: Variant;
    property formatBar: BarFormatter;
    property formatTime: TimeFormatter;
    property formatValue: ValueFormatter;
    property fps: Float;
    property stream: NodeJS.WritableStream;
    property stopOnComplete: Boolean;
    property clearOnComplete: Boolean;
    property barsize: Float;
    property align: Variant;
    property barCompleteString: String;
    property barIncompleteString: String;
    property barCompleteChar: String;
    property barIncompleteChar: String;
    property hideCursor: Boolean;
    property barGlue: String;
    property etaBuffer: Float;
    property etaAsynchronousUpdate: Boolean;
    property progressCalculationRelative: Boolean;
    property linewrap: Boolean;
    property synchronousUpdate: Boolean;
    property noTTYOutput: Boolean;
    property notTTYSchedule: Float;
    property emptyOnZero: Boolean;
    property forceRedraw: Boolean;
    property autopadding: Boolean;
    property autopaddingChar: String;
    property gracefulExit: Boolean;
  end;

  Preset = interface
    property barCompleteChar: String;
    property barIncompleteChar: String;
    property format: String;
  end;

  GenericBar = class(EventEmitter) external
    procedure Create(opt: Options; preset?: Preset);
    property isActive: Boolean;
    procedure render(forceRendering?: Boolean);
    procedure start(total: Float; startValue: Float; payload?: Variant);
    procedure stop;
    procedure update(current: Float; payload?: Variant);
    procedure update(payload: Variant);
    function getProgress: Float;
    procedure increment(step?: Float; payload?: Variant);
    procedure increment(payload: Variant);
    function getTotal: Float;
    procedure setTotal(total: Float);
    procedure updateETA;
  end;

  SingleBar = class(GenericBar) external
    procedure Create(opt: Options; preset?: Preset);
    procedure render;
    procedure update(current: Float; payload?: Variant);
    procedure update(payload: Variant);
    procedure start(total: Float; startValue: Float; payload?: Variant);
    procedure stop;
  end;

  MultiBar = class(EventEmitter) external
    procedure Create(opt: Options; preset?: Preset);
    property isActive: Boolean;
    function create(total: Float; startValue: Float; payload?: Variant; barOptions?: Options): SingleBar;
    function remove(bar: SingleBar): Boolean;
    procedure update;
    procedure stop;
    procedure log(data: String);
  end;

  GenericFormatter = interface
  end;

  TimeFormatter = interface
  end;

  ValueFormatter = interface
  end;

  BarFormatter = interface
  end;

  ValueType = String;

  Bar = class(SingleBar) external
  end;

implementation



end.
