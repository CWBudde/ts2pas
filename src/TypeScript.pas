unit TypeScript;

interface

uses
  NodeJS.Core;

{$R 'typescript.js'}

type 
  TSyntaxKind = Integer;
  TSyntaxKindHelper = strict helper for TSyntaxKind
    const Unknown = 0;
    const EndOfFileToken = 1;
    const SingleLineCommentTrivia = 2;
    const MultiLineCommentTrivia = 3;
    const NewLineTrivia = 4;
    const WhitespaceTrivia = 5;
    const ShebangTrivia = 6;
    const ConflictMarkerTrivia = 7;
    const NumericLiteral = 8;
    const StringLiteral = 9;
    const RegularExpressionLiteral = 10;
    const NoSubstitutionTemplateLiteral = 11;
    const TemplateHead = 12;
    const TemplateMiddle = 13;
    const TemplateTail = 14;
    const OpenBraceToken = 15;
    const CloseBraceToken = 16;
    const OpenParenToken = 17;
    const CloseParenToken = 18;
    const OpenBracketToken = 19;
    const CloseBracketToken = 20;
    const DotToken = 21;
    const DotDotDotToken = 22;
    const SemicolonToken = 23;
    const CommaToken = 24;
    const LessThanToken = 25;
    const LessThanSlashToken = 26;
    const GreaterThanToken = 27;
    const LessThanEqualsToken = 28;
    const GreaterThanEqualsToken = 29;
    const EqualsEqualsToken = 30;
    const ExclamationEqualsToken = 31;
    const EqualsEqualsEqualsToken = 32;
    const ExclamationEqualsEqualsToken = 33;
    const EqualsGreaterThanToken = 34;
    const PlusToken = 35;
    const MinusToken = 36;
    const AsteriskToken = 37;
    const AsteriskAsteriskToken = 38;
    const SlashToken = 39;
    const PercentToken = 40;
    const PlusPlusToken = 41;
    const MinusMinusToken = 42;
    const LessThanLessThanToken = 43;
    const GreaterThanGreaterThanToken = 44;
    const GreaterThanGreaterThanGreaterThanToken = 45;
    const AmpersandToken = 46;
    const BarToken = 47;
    const CaretToken = 48;
    const ExclamationToken = 49;
    const TildeToken = 50;
    const AmpersandAmpersandToken = 51;
    const BarBarToken = 52;
    const QuestionToken = 53;
    const ColonToken = 54;
    const AtToken = 55;
    const EqualsToken = 56;
    const PlusEqualsToken = 57;
    const MinusEqualsToken = 58;
    const AsteriskEqualsToken = 59;
    const AsteriskAsteriskEqualsToken = 60;
    const SlashEqualsToken = 61;
    const PercentEqualsToken = 62;
    const LessThanLessThanEqualsToken = 63;
    const GreaterThanGreaterThanEqualsToken = 64;
    const GreaterThanGreaterThanGreaterThanEqualsToken = 65;
    const AmpersandEqualsToken = 66;
    const BarEqualsToken = 67;
    const CaretEqualsToken = 68;
    const Identifier = 69;
    const BreakKeyword = 70;
    const CaseKeyword = 71;
    const CatchKeyword = 72;
    const ClassKeyword = 73;
    const ConstKeyword = 74;
    const ContinueKeyword = 75;
    const DebuggerKeyword = 76;
    const DefaultKeyword = 77;
    const DeleteKeyword = 78;
    const DoKeyword = 79;
    const ElseKeyword = 80;
    const EnumKeyword = 81;
    const ExportKeyword = 82;
    const ExtendsKeyword = 83;
    const FalseKeyword = 84;
    const FinallyKeyword = 85;
    const ForKeyword = 86;
    const FunctionKeyword = 87;
    const IfKeyword = 88;
    const ImportKeyword = 89;
    const InKeyword = 90;
    const InstanceOfKeyword = 91;
    const NewKeyword = 92;
    const NullKeyword = 93;
    const ReturnKeyword = 94;
    const SuperKeyword = 95;
    const SwitchKeyword = 96;
    const ThisKeyword = 97;
    const ThrowKeyword = 98;
    const TrueKeyword = 99;
    const TryKeyword = 100;
    const TypeOfKeyword = 101;
    const VarKeyword = 102;
    const VoidKeyword = 103;
    const WhileKeyword = 104;
    const WithKeyword = 105;
    const ImplementsKeyword = 106;
    const InterfaceKeyword = 107;
    const LetKeyword = 108;
    const PackageKeyword = 109;
    const PrivateKeyword = 110;
    const ProtectedKeyword = 111;
    const PublicKeyword = 112;
    const StaticKeyword = 113;
    const YieldKeyword = 114;
    const AbstractKeyword = 115;
    const AsKeyword = 116;
    const AnyKeyword = 117;
    const AsyncKeyword = 118;
    const AwaitKeyword = 119;
    const BooleanKeyword = 120;
    const ConstructorKeyword = 121;
    const DeclareKeyword = 122;
    const GetKeyword = 123;
    const IsKeyword = 124;
    const ModuleKeyword = 125;
    const NamespaceKeyword = 126;
    const RequireKeyword = 127;
    const NumberKeyword = 128;
    const SetKeyword = 129;
    const StringKeyword = 130;
    const SymbolKeyword = 131;
    const TypeKeyword = 132;
    const FromKeyword = 133;
    const OfKeyword = 134;
    const QualifiedName = 135;
    const ComputedPropertyName = 136;
    const TypeParameter = 137;
    const Parameter = 138;
    const Decorator = 139;
    const PropertySignature = 140;
    const PropertyDeclaration = 141;
    const MethodSignature = 142;
    const MethodDeclaration = 143;
    const &Constructor = 144;
    const GetAccessor = 145;
    const SetAccessor = 146;
    const CallSignature = 147;
    const ConstructSignature = 148;
    const IndexSignature = 149;
    const TypePredicate = 150;
    const TypeReference = 151;
    const FunctionType = 152;
    const ConstructorType = 153;
    const TypeQuery = 154;
    const TypeLiteral = 155;
    const ArrayType = 156;
    const TupleType = 157;
    const UnionType = 158;
    const IntersectionType = 159;
    const ParenthesizedType = 160;
    const ObjectBindingPattern = 161;
    const ArrayBindingPattern = 162;
    const BindingElement = 163;
    const ArrayLiteralExpression = 164;
    const ObjectLiteralExpression = 165;
    const PropertyAccessExpression = 166;
    const ElementAccessExpression = 167;
    const CallExpression = 168;
    const NewExpression = 169;
    const TaggedTemplateExpression = 170;
    const TypeAssertionExpression = 171;
    const ParenthesizedExpression = 172;
    const FunctionExpression = 173;
    const ArrowFunction = 174;
    const DeleteExpression = 175;
    const TypeOfExpression = 176;
    const VoidExpression = 177;
    const AwaitExpression = 178;
    const PrefixUnaryExpression = 179;
    const PostfixUnaryExpression = 180;
    const BinaryExpression = 181;
    const ConditionalExpression = 182;
    const TemplateExpression = 183;
    const YieldExpression = 184;
    const SpreadElementExpression = 185;
    const ClassExpression = 186;
    const OmittedExpression = 187;
    const ExpressionWithTypeArguments = 188;
    const AsExpression = 189;
    const TemplateSpan = 190;
    const SemicolonClassElement = 191;
    const Block = 192;
    const VariableStatement = 193;
    const EmptyStatement = 194;
    const ExpressionStatement = 195;
    const IfStatement = 196;
    const DoStatement = 197;
    const WhileStatement = 198;
    const ForStatement = 199;
    const ForInStatement = 200;
    const ForOfStatement = 201;
    const ContinueStatement = 202;
    const BreakStatement = 203;
    const ReturnStatement = 204;
    const WithStatement = 205;
    const SwitchStatement = 206;
    const LabeledStatement = 207;
    const ThrowStatement = 208;
    const TryStatement = 209;
    const DebuggerStatement = 210;
    const VariableDeclaration = 211;
    const VariableDeclarationList = 212;
    const FunctionDeclaration = 213;
    const ClassDeclaration = 214;
    const InterfaceDeclaration = 215;
    const TypeAliasDeclaration = 216;
    const EnumDeclaration = 217;
    const ModuleDeclaration = 218;
    const ModuleBlock = 219;
    const CaseBlock = 220;
    const ImportEqualsDeclaration = 221;
    const ImportDeclaration = 222;
    const ImportClause = 223;
    const NamespaceImport = 224;
    const NamedImports = 225;
    const ImportSpecifier = 226;
    const ExportAssignment = 227;
    const ExportDeclaration = 228;
    const NamedExports = 229;
    const ExportSpecifier = 230;
    const MissingDeclaration = 231;
    const ExternalModuleReference = 232;
    const JsxElement = 233;
    const JsxSelfClosingElement = 234;
    const JsxOpeningElement = 235;
    const JsxText = 236;
    const JsxClosingElement = 237;
    const JsxAttribute = 238;
    const JsxSpreadAttribute = 239;
    const JsxExpression = 240;
    const CaseClause = 241;
    const DefaultClause = 242;
    const HeritageClause = 243;
    const CatchClause = 244;
    const PropertyAssignment = 245;
    const ShorthandPropertyAssignment = 246;
    const EnumMember = 247;
    const SourceFile = 248;
    const JSDocTypeExpression = 249;
    const JSDocAllType = 250;
    const JSDocUnknownType = 251;
    const JSDocArrayType = 252;
    const JSDocUnionType = 253;
    const JSDocTupleType = 254;
    const JSDocNullableType = 255;
    const JSDocNonNullableType = 256;
    const JSDocRecordType = 257;
    const JSDocRecordMember = 258;
    const JSDocTypeReference = 259;
    const JSDocOptionalType = 260;
    const JSDocFunctionType = 261;
    const JSDocVariadicType = 262;
    const JSDocConstructorType = 263;
    const JSDocThisType = 264;
    const JSDocComment = 265;
    const JSDocTag = 266;
    const JSDocParameterTag = 267;
    const JSDocReturnTag = 268;
    const JSDocTypeTag = 269;
    const JSDocTemplateTag = 270;
    const SyntaxList = 271;
    const Count = 272;
    const FirstAssignment = 56;
    const LastAssignment = 68;
    const FirstReservedWord = 70;
    const LastReservedWord = 105;
    const FirstKeyword = 70;
    const LastKeyword = 134;
    const FirstFutureReservedWord = 106;
    const LastFutureReservedWord = 114;
    const FirstTypeNode = 151;
    const LastTypeNode = 160;
    const FirstPunctuation = 15;
    const LastPunctuation = 68;
    const FirstToken = 0;
    const LastToken = 134;
    const FirstTriviaToken = 2;
    const LastTriviaToken = 7;
    const FirstLiteralToken = 8;
    const LastLiteralToken = 11;
    const FirstTemplateToken = 11;
    const LastTemplateToken = 14;
    const FirstBinaryOperator = 25;
    const LastBinaryOperator = 68;
    const FirstNode = 135;
  end;

  TNodeFlags = Integer;
  TNodeFlagsHelper = strict helper for TNodeFlags
    const &Export = 1;
    const Ambient = 2;
    const &Public = 16;
    const &Private = 32;
    const &Protected = 64;
    const Static = 128;
    const &Abstract = 256;
    const Async = 512;
    const &Default = 1024;
    const MultiLine = 2048;
    const Synthetic = 4096;
    const DeclarationFile = 8192;
    const Let = 16384;
    const &Const = 32768;
    const OctalLiteral = 65536;
    const Namespace = 131072;
    const ExportContext = 262144;
    const Modifier = 2035;
    const AccessibilityModifier = 112;
    const BlockScoped = 49152;
  end;

  TJsxFlags = Integer;
  TJsxFlagsHelper = strict helper for TJsxFlags
    const None = 0;
    const IntrinsicNamedElement = 1;
    const IntrinsicIndexedElement = 2;
    const ClassElement = 4;
    const UnknownElement = 8;
    const IntrinsicElement = 3;
  end;

  TTypeFormatFlags = Integer;
  TTypeFormatFlagsHelper = strict helper for TTypeFormatFlags
    const None = 0;
    const WriteArrayAsGenericType = 1;
    const UseTypeOfFunction = 2;
    const NoTruncation = 4;
    const WriteArrowStyleSignature = 8;
    const WriteOwnNameForAnyLike = 16;
    const WriteTypeArgumentsOfSignature = 32;
    const InElementType = 64;
    const UseFullyQualifiedType = 128;
  end;

  TSymbolFormatFlags = Integer;
  TSymbolFormatFlagsHelper = strict helper for TSymbolFormatFlags
    const None = 0;
    const WriteTypeParametersOrArguments = 1;
    const UseOnlyExternalAliasing = 2;
  end;

  TSymbolFlags = Integer;
  TSymbolFlagsHelper = strict helper for TSymbolFlags
    const None = 0;
    const FunctionScopedVariable = 1;
    const BlockScopedVariable = 2;
    const &Property = 4;
    const EnumMember = 8;
    const &Function = 16;
    const &Class = 32;
    const &Interface = 64;
    const ConstEnum = 128;
    const RegularEnum = 256;
    const ValueModule = 512;
    const NamespaceModule = 1024;
    const TypeLiteral = 2048;
    const ObjectLiteral = 4096;
    const Method = 8192;
    const &Constructor = 16384;
    const GetAccessor = 32768;
    const SetAccessor = 65536;
    const Signature = 131072;
    const TypeParameter = 262144;
    const TypeAlias = 524288;
    const ExportValue = 1048576;
    const ExportType = 2097152;
    const ExportNamespace = 4194304;
    const Alias = 8388608;
    const Instantiated = 16777216;
    const Merged = 33554432;
    const Transient = 67108864;
    const Prototype = 134217728;
    const SyntheticProperty = 268435456;
    const Optional = 536870912;
    const ExportStar = 1073741824;
    const Enum = 384;
    const Variable = 3;
    const Value = 107455;
    const &Type = 793056;
    const Namespace = 1536;
    const Module = 1536;
    const Accessor = 98304;
    const FunctionScopedVariableExcludes = 107454;
    const BlockScopedVariableExcludes = 107455;
    const ParameterExcludes = 107455;
    const PropertyExcludes = 107455;
    const EnumMemberExcludes = 107455;
    const FunctionExcludes = 106927;
    const ClassExcludes = 899519;
    const InterfaceExcludes = 792960;
    const RegularEnumExcludes = 899327;
    const ConstEnumExcludes = 899967;
    const ValueModuleExcludes = 106639;
    const NamespaceModuleExcludes = 0;
    const MethodExcludes = 99263;
    const GetAccessorExcludes = 41919;
    const SetAccessorExcludes = 74687;
    const TypeParameterExcludes = 530912;
    const TypeAliasExcludes = 793056;
    const AliasExcludes = 8388608;
    const ModuleMember = 8914931;
    const ExportHasLocal = 944;
    const HasExports = 1952;
    const HasMembers = 6240;
    const BlockScoped = 418;
    const PropertyOrAccessor = 98308;
    const &Export = 7340032;
  end;

  TTypeFlags = Integer;
  TTypeFlagsHelper = strict helper for TTypeFlags
    const Any = 1;
    const &String = 2;
    const Number = 4;
    const Boolean = 8;
    const Void = 16;
    const Undefined = 32;
    const Null = 64;
    const Enum = 128;
    const StringLiteral = 256;
    const TypeParameter = 512;
    const &Class = 1024;
    const &Interface = 2048;
    const Reference = 4096;
    const Tuple = 8192;
    const Union = 16384;
    const Intersection = 32768;
    const Anonymous = 65536;
    const Instantiated = 131072;
    const ObjectLiteral = 524288;
    const ESSymbol = 16777216;
    const StringLike = 258;
    const NumberLike = 132;
    const ObjectType = 80896;
    const UnionOrIntersection = 49152;
    const StructuredType = 130048;
  end;

  TSignatureKind = Integer;
  TSignatureKindHelper = strict helper for TSignatureKind
    const Call = 0;
    const Construct = 1;
  end;

  TIndexKind = Integer;
  TIndexKindHelper = strict helper for TIndexKind
    const &String = 0;
    const Number = 1;
  end;

  TModuleResolutionKind = Integer;
  TModuleResolutionKindHelper = strict helper for TModuleResolutionKind
    const Classic = 1;
    const NodeJs = 2;
  end;

  TModuleKind = Integer;
  TModuleKindHelper = strict helper for TModuleKind
    const None = 0;
    const CommonJS = 1;
    const AMD = 2;
    const UMD = 3;
    const System = 4;
  end;

  TJsxEmit = Integer;
  TJsxEmitHelper = strict helper for TJsxEmit
    const None = 0;
    const Preserve = 1;
    const React = 2;
  end;

  TNewLineKind = Integer;
  TNewLineKindHelper = strict helper for TNewLineKind
    const CarriageReturnLineFeed = 0;
    const LineFeed = 1;
  end;

  TScriptTarget = Integer;
  TScriptTargetHelper = strict helper for TScriptTarget
    const ES3 = 0;
    const ES5 = 1;
    const ES6 = 2;
    const Latest = 2;
    const ES2015 = 2;
  end;

  TLanguageVariant = Integer;
  TLanguageVariantHelper = strict helper for TLanguageVariant
    const Standard = 0;
    const JSX = 1;
  end;


  JOperationCanceledException = class external 'OperationCanceledException'
  end;

  JTextRange = class external 'TextRange'
    pos: Integer;
    &end: Integer;
  end;

  JNode = class external 'Node' (JTextRange)
    kind: TSyntaxKind;
    flags: TNodeFlags;
(*
    decorators: JNodeArray<Decorator>;
    modifiers: JModifiersArray;
*)
    parent: JNode;
  end;

  JLineAndCharacter = class external 'LineAndCharacter'
    line: Integer;
    character: Integer;
  end;

  TDiagnosticCategory = (
    Warning = 0,
    Error = 1,
    Message = 2
  );

  JDiagnosticMessage = class external
    key: string;
    category: TDiagnosticCategory;
    code: Integer;
  end;

  TErrorCallback = procedure(message: JDiagnosticMessage; _length: Integer);

  TDeclarationName = Variant;

  JDeclaration = class external 'Declaration' (JNode)
    name: TDeclarationName;
  end;

  JSourceFile = class external 'SourceFile' (JDeclaration)
(*
    statements: NodeArray<Statement>;
    endOfFileToken: Node;
    fileName: string;
    text: string;
    amdDependencies: {
      path: string;
      name: string;
    }[];
    referencedFiles: FileReference[];
*)
    moduleName: string;
    languageVariant: TLanguageVariant;
    hasNoDefaultLib: Boolean;
    languageVersion: TScriptTarget;
  end;


  JCommentRange = class external 'CommentRange' (JTextRange)
    hasTrailingNewLine: Boolean;
    kind: TSyntaxKind;
  end;

  JScanner = class external 'Scanner'
    function getStartPos: Integer;
    function getToken: TSyntaxKind;
    function getTextPos: Integer;
    function getTokenPos: Integer;
    function getTokenText: string;
    function getTokenValue: string;
    function hasExtendedUnicodeEscape: Boolean;
    function hasPrecedingLineBreak: Boolean;
    function isIdentifier: Boolean;
    function isReservedWord: Boolean;
    function isUnterminated: Boolean;
    function reScanGreaterToken: TSyntaxKind;
    function reScanSlashToken: TSyntaxKind;
    function reScanTemplateToken: TSyntaxKind;
    function scanJsxIdentifier: TSyntaxKind;
    function reScanJsxToken: TSyntaxKind;
    function scanJsxToken: TSyntaxKind;
    function scan: TSyntaxKind;

    procedure setText(text: string); overload;
    procedure setText(text: string; start: Integer); overload;
    procedure setText(text: string; start, _length: Integer); overload;
    procedure setOnError(onError: TErrorCallback);
    procedure setScriptTarget(scriptTarget: TScriptTarget);
    procedure setLanguageVariant(variant: TLanguageVariant);
    procedure setTextPos(textPos: Integer);
(*
    function lookAhead<T>(callback:  => T): T;
    function tryScan<T>(callback:  => T): T;
*)
  end;

  JTypeScriptExport = class external
    function tokenToString(t: TSyntaxKind): string; external;
    function getPositionOfLineAndCharacter(sourceFile: JSourceFile; line, character: Integer): Integer; external;
    function getLineAndCharacterOfPosition(sourceFile: JSourceFile; position: Integer): JLineAndCharacter; external;
    function isWhiteSpace(ch: Integer): Boolean; external;
    function isLineBreak(ch: Integer): Boolean; external;
    function couldStartTrivia(text: string; pos: Integer): Boolean; external;
    function getLeadingCommentRanges(text: string; pos: Integer): array of JCommentRange; external;
    function getTrailingCommentRanges(text: string; pos: Integer): array of JCommentRange; external;

    // Optionally, get the shebang
    function getShebang(text: string): string; external;
    function isIdentifierStart(ch: Integer; languageVersion: TScriptTarget): Boolean; external;
    function isIdentifierPart(ch: Integer; languageVersion: TScriptTarget): Boolean; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean; languageVariant: TLanguageVariant): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean; languageVariant: TLanguageVariant; text: string): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean; languageVariant: TLanguageVariant; text: string; onError: TErrorCallback): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean; languageVariant: TLanguageVariant; text: string; onError: TErrorCallback; start: Integer): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean; languageVariant: TLanguageVariant; text: string; onError: TErrorCallback; start, _length: Integer): JScanner; overload; external;

    function createSourceFile(fileName, sourceText: String; languageVersion: TScriptTarget): JSourceFile; overload;
    function createSourceFile(fileName, sourceText: String; languageVersion: TScriptTarget; setParentNodes: Boolean): JSourceFile; overload;
  end;

var TypeScriptExport := JTypeScriptExport(RequireModule('typescript'));