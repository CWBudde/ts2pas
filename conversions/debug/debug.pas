unit Debug;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: debug
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Debug = interface
    property coerce: function: Variant;
    property disable: function: String;
    property enable: procedure;
    property enabled: function: Boolean;
    property formatArgs: procedure;
    property log: function: Variant;
    property selectColor: function: Variant;
    property humanize: Variant;
    property names: array of RegExp;
    property skips: array of RegExp;
    property formatters: Formatters;
    property inspectOpts: Variant;
  end;

  IDebug = Debug;

  Formatters = interface
  end;

  IDebugger = Debugger;

  Debugger = interface
    property color: String;
    property diff: Float;
    property enabled: Boolean;
    property log: function: Variant;
    property namespace: String;
    property destroy: function: Boolean;
    property extend: function: Debugger;
  end;

implementation



end.
