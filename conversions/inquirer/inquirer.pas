unit Inquirer;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: inquirer
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  LiteralUnion = T;

  PromptFunction = interface
  end;

  PromptModuleBase = interface(PromptFunction)
    procedure registerPrompt(name: String; prompt: inquirer.prompts.PromptConstructor);
    procedure restoreDefaultPrompts;
  end;

  RegisterFunction = Variant;

  RestoreFunction = Variant;

  ListQuestionOptionsBase = interface(Question)
    property choices: AsyncDynamicQuestionProperty<array of DistinctChoice<T, TChoiceMap>, T>;
    property pageSize: Float;
  end;

  function createPromptModule(opt?: StreamOptions): PromptModule;

  PromptModuleCreator = Variant;

  KeyUnion = LiteralUnion<Extract<Variant, String>>;

  UnionToIntersection = Variant;

  Answers = interface(Record)
  end;

  Validator = Variant;

  Transformer = Variant;

  DynamicQuestionProperty = Variant;

  AsyncDynamicQuestionProperty = DynamicQuestionProperty<T, TAnswers>;

  ChoiceBase = interface
    property type: String;
  end;

  ListChoiceOptions = interface(ChoiceOptions)
    property disabled: DynamicQuestionProperty<Variant, T>;
  end;

  CheckboxChoiceOptions = interface(ListChoiceOptions)
    property checked: Boolean;
  end;

  ExpandChoiceOptions = interface(ChoiceOptions)
    property key: String;
  end;

  SeparatorOptions = interface(ChoiceBase)
    property type: String;
    property line: String;
  end;

  ChoiceOptions = interface(ChoiceBase)
    property type: String;
    property name: String;
    property value: Variant;
    property short: String;
    property extra: Variant;
  end;

  BaseChoiceMap = interface
    property Choice: Choice<T>;
    property ChoiceOptions: ChoiceOptions;
    property Separator: Separator;
    property SeparatorOptions: SeparatorOptions;
  end;

  ListChoiceMap = interface(BaseChoiceMap)
    property ListChoiceOptions: ListChoiceOptions<T>;
  end;

  CheckboxChoiceMap = interface(BaseChoiceMap)
    property CheckboxChoiceOptions: CheckboxChoiceOptions<T>;
  end;

  ExpandChoiceMap = interface(BaseChoiceMap)
    property ExpandChoiceOptions: ExpandChoiceOptions;
  end;

  AllChoiceMap = interface
    property BaseChoiceMap: Variant;
    property ListChoiceMap: Variant;
    property CheckboxChoiceMap: Variant;
    property ExpandChoiceMap: Variant;
  end;

  DistinctChoice = String;

  ChoiceCollection = array of DistinctChoice<T, AllChoiceMap<T>>;

  Question = interface
    property type: String;
    property name: KeyUnion<T>;
    property message: AsyncDynamicQuestionProperty<String, T>;
    property default: AsyncDynamicQuestionProperty<Variant, T>;
    property prefix: String;
    property suffix: String;
    function filter(input: Variant; answers: T): Variant;
    property when: AsyncDynamicQuestionProperty<Boolean, T>;
    function validate(input: Variant; answers?: T): Variant;
    property askAnswered: Boolean;
  end;

  QuestionAnswer = Variant;

  InputQuestionOptions = interface(Question)
    function transformer(input: Variant; answers: T; flags: Variant): String;
  end;

  InputQuestion = interface(InputQuestionOptions)
    property type: String;
  end;

  NumberQuestionOptions = interface(InputQuestionOptions)
  end;

  NumberQuestion = interface(NumberQuestionOptions)
    property type: String;
  end;

  PasswordQuestionOptions = interface(InputQuestionOptions)
    property mask: String;
  end;

  PasswordQuestion = interface(PasswordQuestionOptions)
    property type: String;
  end;

  LoopableListQuestionOptionsBase = interface(ListQuestionOptionsBase)
    property loop: Boolean;
  end;

  ListQuestionOptions = interface(LoopableListQuestionOptionsBase)
  end;

  ListQuestion = interface(ListQuestionOptions)
    property type: String;
  end;

  RawListQuestionOptions = interface(ListQuestionOptions)
  end;

  RawListQuestion = interface(RawListQuestionOptions)
    property type: String;
  end;

  ExpandQuestionOptions = interface(ListQuestionOptionsBase)
  end;

  ExpandQuestion = interface(ExpandQuestionOptions)
    property type: String;
  end;

  CheckboxQuestionOptions = interface(LoopableListQuestionOptionsBase)
  end;

  CheckboxQuestion = interface(CheckboxQuestionOptions)
    property type: String;
  end;

  ConfirmQuestionOptions = interface(Question)
  end;

  ConfirmQuestion = interface(ConfirmQuestionOptions)
    property type: String;
  end;

  EditorQuestionOptions = interface(Question)
    property postfix: String;
  end;

  EditorQuestion = interface(EditorQuestionOptions)
    property type: String;
  end;

  QuestionMap = interface
    property input: InputQuestion<T>;
    property number: NumberQuestion<T>;
    property password: PasswordQuestion<T>;
    property list: ListQuestion<T>;
    property rawList: RawListQuestion<T>;
    property expand: ExpandQuestion<T>;
    property checkbox: CheckboxQuestion<T>;
    property confirm: ConfirmQuestion<T>;
    property editor: EditorQuestion<T>;
  end;

  DistinctQuestion = Variant;

  QuestionTypeName = Variant;

  QuestionCollection = Variant;

  StreamOptions = interface
    property input: NodeJS.ReadStream;
    property output: NodeJS.WriteStream;
    property skipTTYChecks: Boolean;
  end;

  PromptModule = interface(PromptModuleBase)
    property prompts: inquirer.prompts.PromptCollection;
    function registerPrompt(name: String; prompt: inquirer.prompts.PromptConstructor): Variant;
  end;

  PromptOptions = Variant;

  PromptState = LiteralUnion<String>;

  PromptBase = interface
    property status: PromptState;
    function run: Variant;
  end;

  PromptConstructor = interface
  end;

  PromptCollection = Variant;

  PromptStateData = interface
    property isValid: Variant;
  end;

  SuccessfulPromptStateData = interface(PromptStateData)
    property isValid: Boolean;
    property value: T;
  end;

  FailedPromptStateData = interface(PromptStateData)
    property isValid: Variant;
  end;

  PromptEventPipes = interface
    property success: Observable<SuccessfulPromptStateData<T>>;
    property error: Observable<FailedPromptStateData>;
  end;

  BottomBar = class(UI) external
    property log: ThroughStream;
    procedure Create(options?: BottomBarOptions);
    function updateBottomBar(text: String): Variant;
    function render: Variant;
    function clean: Variant;
    procedure write(message: String);
    function writeLog(data: Variant): Variant;
    function enforceLF(text: String): String;
  end;

  Prompt = class(UI) external
    property prompts: prompts.PromptCollection;
    property answers: T;
    property process: Observable<QuestionAnswer<T>>;
    procedure Create(prompts: prompts.PromptCollection; options?: StreamOptions);
    function run(questions: array of DistinctQuestion<T>): T;
    function onCompletion: T;
    function processQuestion(question: DistinctQuestion<T>): Observable<FetchedAnswer>;
    function fetchAnswer(question: FetchedQuestion<T>): Observable<FetchedAnswer>;
    function setDefaultType(question: DistinctQuestion<T>): Observable<DistinctQuestion<T>>;
    function filterIfRunnable(question: DistinctQuestion<T>): Observable<DistinctQuestion<T>>;
  end;

  BottomBarOptions = interface(StreamOptions)
    property bottomBar: String;
  end;

  FetchedQuestion = Variant;

  FetchedAnswer = interface
    property name: String;
    property answer: Variant;
  end;

  Separator = class(SeparatorOptions) external
    property type: String; read only
    property line: String;
    procedure Create(line?: String);
    function exclude(item: Variant): Boolean; static
  end;

implementation



end.
