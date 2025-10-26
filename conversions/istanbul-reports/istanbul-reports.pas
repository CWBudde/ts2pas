unit Istanbul_reports;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: istanbul-reports
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  function create(name: T; options?: Variant): ReportBase;

  FileOptions = interface
    property file: String;
  end;

  ProjectOptions = interface
    property projectRoot: String;
  end;

  ReportOptions = interface
    property clover: CloverOptions;
    property cobertura: CoberturaOptions;
    property html: HtmlOptions;
    property json: JsonOptions;
    property lcov: LcovOptions;
    property lcovonly: LcovOnlyOptions;
    property none: Variant;
    property teamcity: TeamcityOptions;
    property text: TextOptions;
  end;

  ReportType = Variant;

  CloverOptions = interface(FileOptions, ProjectOptions)
  end;

  CoberturaOptions = interface(FileOptions, ProjectOptions)
  end;

  HtmlSpaOptions = interface(HtmlOptions)
    property metricsToShow: array of String;
  end;

  HtmlOptions = interface
    property verbose: Boolean;
    property skipEmpty: Boolean;
    property subdir: String;
    property linkMapper: LinkMapper;
  end;

  JsonOptions = FileOptions;

  JsonSummaryOptions = FileOptions;

  LcovOptions = interface(FileOptions, ProjectOptions)
  end;

  LcovOnlyOptions = interface(FileOptions, ProjectOptions)
  end;

  TeamcityOptions = interface(FileOptions)
    property blockName: String;
  end;

  TextOptions = interface(FileOptions)
    property maxCols: Float;
    property skipEmpty: Boolean;
    property skipFull: Boolean;
  end;

  TextLcovOptions = ProjectOptions;

  TextSummaryOptions = FileOptions;

  LinkMapper = interface
    function getPath(node: Variant): String;
    function relativePath(source: Variant; target: Variant): String;
    function assetPath(node: Node; name: String): String;
  end;

implementation



end.
