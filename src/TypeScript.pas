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
    const BigIntLiteral = 9;
    const StringLiteral = 10;
    const JsxText = 11;
    const JsxTextAllWhiteSpaces = 12;
    const RegularExpressionLiteral = 13;
    const NoSubstitutionTemplateLiteral = 14;
    const TemplateHead = 15;
    const TemplateMiddle = 16;
    const TemplateTail = 17;
    const OpenBraceToken = 18;
    const CloseBraceToken = 19;
    const OpenParenToken = 20;
    const CloseParenToken = 21;
    const OpenBracketToken = 22;
    const CloseBracketToken = 23;
    const DotToken = 24;
    const DotDotDotToken = 25;
    const SemicolonToken = 26;
    const CommaToken = 27;
    const QuestionDotToken = 28;
    const LessThanToken = 29;
    const LessThanSlashToken = 30;
    const GreaterThanToken = 31;
    const LessThanEqualsToken = 32;
    const GreaterThanEqualsToken = 33;
    const EqualsEqualsToken = 34;
    const ExclamationEqualsToken = 35;
    const EqualsEqualsEqualsToken = 36;
    const ExclamationEqualsEqualsToken = 37;
    const EqualsGreaterThanToken = 38;
    const PlusToken = 39;
    const MinusToken = 40;
    const AsteriskToken = 41;
    const AsteriskAsteriskToken = 42;
    const SlashToken = 43;
    const PercentToken = 44;
    const PlusPlusToken = 45;
    const MinusMinusToken = 46;
    const LessThanLessThanToken = 47;
    const GreaterThanGreaterThanToken = 48;
    const GreaterThanGreaterThanGreaterThanToken = 49;
    const AmpersandToken = 50;
    const BarToken = 51;
    const CaretToken = 52;
    const ExclamationToken = 53;
    const TildeToken = 54;
    const AmpersandAmpersandToken = 55;
    const BarBarToken = 56;
    const QuestionToken = 57;
    const ColonToken = 58;
    const AtToken = 59;
    const QuestionQuestionToken = 60;
    const BacktickToken = 61;
    const EqualsToken = 62;
    const PlusEqualsToken = 63;
    const MinusEqualsToken = 64;
    const AsteriskEqualsToken = 65;
    const AsteriskAsteriskEqualsToken = 66;
    const SlashEqualsToken = 67;
    const PercentEqualsToken = 68;
    const LessThanLessThanEqualsToken = 69;
    const GreaterThanGreaterThanEqualsToken = 70;
    const GreaterThanGreaterThanGreaterThanEqualsToken = 71;
    const AmpersandEqualsToken = 72;
    const BarEqualsToken = 73;
    const BarBarEqualsToken = 74;
    const AmpersandAmpersandEqualsToken = 75;
    const QuestionQuestionEqualsToken = 76;
    const CaretEqualsToken = 77;
    const Identifier = 78;
    const PrivateIdentifier = 79;
    const BreakKeyword = 80;
    const CaseKeyword = 81;
    const CatchKeyword = 82;
    const ClassKeyword = 83;
    const ConstKeyword = 84;
    const ContinueKeyword = 85;
    const DebuggerKeyword = 86;
    const DefaultKeyword = 87;
    const DeleteKeyword = 88;
    const DoKeyword = 89;
    const ElseKeyword = 90;
    const EnumKeyword = 91;
    const ExportKeyword = 92;
    const ExtendsKeyword = 93;
    const FalseKeyword = 94;
    const FinallyKeyword = 95;
    const ForKeyword = 96;
    const FunctionKeyword = 97;
    const IfKeyword = 98;
    const ImportKeyword = 99;
    const InKeyword = 100;
    const InstanceOfKeyword = 101;
    const NewKeyword = 102;
    const NullKeyword = 103;
    const ReturnKeyword = 104;
    const SuperKeyword = 105;
    const SwitchKeyword = 106;
    const ThisKeyword = 107;
    const ThrowKeyword = 108;
    const TrueKeyword = 109;
    const TryKeyword = 110;
    const TypeOfKeyword = 111;
    const VarKeyword = 112;
    const VoidKeyword = 113;
    const WhileKeyword = 114;
    const WithKeyword = 115;
    const ImplementsKeyword = 116;
    const InterfaceKeyword = 117;
    const LetKeyword = 118;
    const PackageKeyword = 119;
    const PrivateKeyword = 120;
    const ProtectedKeyword = 121;
    const PublicKeyword = 122;
    const StaticKeyword = 123;
    const YieldKeyword = 124;
    const AbstractKeyword = 125;
    const AsKeyword = 126;
    const AssertsKeyword = 127;
    const AnyKeyword = 128;
    const AsyncKeyword = 129;
    const AwaitKeyword = 130;
    const BooleanKeyword = 131;
    const ConstructorKeyword = 132;
    const DeclareKeyword = 133;
    const GetKeyword = 134;
    const InferKeyword = 135;
    const IntrinsicKeyword = 136;
    const IsKeyword = 137;
    const KeyOfKeyword = 138;
    const ModuleKeyword = 139;
    const NamespaceKeyword = 140;
    const NeverKeyword = 141;
    const ReadonlyKeyword = 142;
    const RequireKeyword = 143;
    const NumberKeyword = 144;
    const ObjectKeyword = 145;
    const SetKeyword = 146;
    const StringKeyword = 147;
    const SymbolKeyword = 148;
    const TypeKeyword = 149;
    const UndefinedKeyword = 150;
    const UniqueKeyword = 151;
    const UnknownKeyword = 152;
    const FromKeyword = 153;
    const GlobalKeyword = 154;
    const BigIntKeyword = 155;
    const OverrideKeyword = 156;
    const OfKeyword = 157;
    const QualifiedName = 158;
    const ComputedPropertyName = 159;
    const TypeParameter = 160;
    const Parameter = 161;
    const Decorator = 162;
    const PropertySignature = 163;
    const PropertyDeclaration = 164;
    const MethodSignature = 165;
    const MethodDeclaration = 166;
    const &Constructor = 167;
    const GetAccessor = 168;
    const SetAccessor = 169;
    const CallSignature = 170;
    const ConstructSignature = 171;
    const IndexSignature = 172;
    const TypePredicate = 173;
    const TypeReference = 174;
    const FunctionType = 175;
    const ConstructorType = 176;
    const TypeQuery = 177;
    const TypeLiteral = 178;
    const ArrayType = 179;
    const TupleType = 180;
    const OptionalType = 181;
    const RestType = 182;
    const UnionType = 183;
    const IntersectionType = 184;
    const ConditionalType = 185;
    const InferType = 186;
    const ParenthesizedType = 187;
    const ThisType = 188;
    const TypeOperator = 189;
    const IndexedAccessType = 190;
    const MappedType = 191;
    const LiteralType = 192;
    const NamedTupleMember = 193;
    const TemplateLiteralType = 194;
    const TemplateLiteralTypeSpan = 195;
    const ImportType = 196;
    const ObjectBindingPattern = 197;
    const ArrayBindingPattern = 198;
    const BindingElement = 199;
    const ArrayLiteralExpression = 200;
    const ObjectLiteralExpression = 201;
    const PropertyAccessExpression = 202;
    const ElementAccessExpression = 203;
    const CallExpression = 204;
    const NewExpression = 205;
    const TaggedTemplateExpression = 206;
    const TypeAssertionExpression = 207;
    const ParenthesizedExpression = 208;
    const FunctionExpression = 209;
    const ArrowFunction = 210;
    const DeleteExpression = 211;
    const TypeOfExpression = 212;
    const VoidExpression = 213;
    const AwaitExpression = 214;
    const PrefixUnaryExpression = 215;
    const PostfixUnaryExpression = 216;
    const BinaryExpression = 217;
    const ConditionalExpression = 218;
    const TemplateExpression = 219;
    const YieldExpression = 220;
    const SpreadElement = 221;
    const ClassExpression = 222;
    const OmittedExpression = 223;
    const ExpressionWithTypeArguments = 224;
    const AsExpression = 225;
    const NonNullExpression = 226;
    const MetaProperty = 227;
    const SyntheticExpression = 228;
    const TemplateSpan = 229;
    const SemicolonClassElement = 230;
    const Block = 231;
    const EmptyStatement = 232;
    const VariableStatement = 233;
    const ExpressionStatement = 234;
    const IfStatement = 235;
    const DoStatement = 236;
    const WhileStatement = 237;
    const ForStatement = 238;
    const ForInStatement = 239;
    const ForOfStatement = 240;
    const ContinueStatement = 241;
    const BreakStatement = 242;
    const ReturnStatement = 243;
    const WithStatement = 244;
    const SwitchStatement = 245;
    const LabeledStatement = 246;
    const ThrowStatement = 247;
    const TryStatement = 248;
    const DebuggerStatement = 249;
    const VariableDeclaration = 250;
    const VariableDeclarationList = 251;
    const FunctionDeclaration = 252;
    const ClassDeclaration = 253;
    const InterfaceDeclaration = 254;
    const TypeAliasDeclaration = 255;
    const EnumDeclaration = 256;
    const ModuleDeclaration = 257;
    const ModuleBlock = 258;
    const CaseBlock = 259;
    const NamespaceExportDeclaration = 260;
    const ImportEqualsDeclaration = 261;
    const ImportDeclaration = 262;
    const ImportClause = 263;
    const NamespaceImport = 264;
    const NamedImports = 265;
    const ImportSpecifier = 266;
    const ExportAssignment = 267;
    const ExportDeclaration = 268;
    const NamedExports = 269;
    const NamespaceExport = 270;
    const ExportSpecifier = 271;
    const MissingDeclaration = 272;
    const ExternalModuleReference = 273;
    const JsxElement = 274;
    const JsxSelfClosingElement = 275;
    const JsxOpeningElement = 276;
    const JsxClosingElement = 277;
    const JsxFragment = 278;
    const JsxOpeningFragment = 279;
    const JsxClosingFragment = 280;
    const JsxAttribute = 281;
    const JsxAttributes = 282;
    const JsxSpreadAttribute = 283;
    const JsxExpression = 284;
    const CaseClause = 285;
    const DefaultClause = 286;
    const HeritageClause = 287;
    const CatchClause = 288;
    const PropertyAssignment = 289;
    const ShorthandPropertyAssignment = 290;
    const SpreadAssignment = 291;
    const EnumMember = 292;
    const UnparsedPrologue = 293;
    const UnparsedPrepend = 294;
    const UnparsedText = 295;
    const UnparsedInternalText = 296;
    const UnparsedSyntheticReference = 297;
    const SourceFile = 298;
    const Bundle = 299;
    const UnparsedSource = 300;
    const InputFiles = 301;
    const JSDocTypeExpression = 302;
    const JSDocNameReference = 303;
    const JSDocAllType = 304;
    const JSDocUnknownType = 305;
    const JSDocNullableType = 306;
    const JSDocNonNullableType = 307;
    const JSDocOptionalType = 308;
    const JSDocFunctionType = 309;
    const JSDocVariadicType = 310;
    const JSDocNamepathType = 311;
    const JSDocComment = 312;
    const JSDocText = 313;
    const JSDocTypeLiteral = 314;
    const JSDocSignature = 315;
    const JSDocLink = 316;
    const JSDocTag = 317;
    const JSDocAugmentsTag = 318;
    const JSDocImplementsTag = 319;
    const JSDocAuthorTag = 320;
    const JSDocDeprecatedTag = 321;
    const JSDocClassTag = 322;
    const JSDocPublicTag = 323;
    const JSDocPrivateTag = 324;
    const JSDocProtectedTag = 325;
    const JSDocReadonlyTag = 326;
    const JSDocOverrideTag = 327;
    const JSDocCallbackTag = 328;
    const JSDocEnumTag = 329;
    const JSDocParameterTag = 330;
    const JSDocReturnTag = 331;
    const JSDocThisTag = 332;
    const JSDocTypeTag = 333;
    const JSDocTemplateTag = 334;
    const JSDocTypedefTag = 335;
    const JSDocSeeTag = 336;
    const JSDocPropertyTag = 337;
    const SyntaxList = 338;
    const NotEmittedStatement = 339;
    const PartiallyEmittedExpression = 340;
    const CommaListExpression = 341;
    const MergeDeclarationMarker = 342;
    const EndOfDeclarationMarker = 343;
    const SyntheticReferenceExpression = 344;
    const Count = 345;
    const FirstAssignment = 62;
    const LastAssignment = 77;
    const FirstCompoundAssignment = 63;
    const LastCompoundAssignment = 77;
    const FirstReservedWord = 80;
    const LastReservedWord = 115;
    const FirstKeyword = 80;
    const LastKeyword = 157;
    const FirstFutureReservedWord = 116;
    const LastFutureReservedWord = 124;
    const FirstTypeNode = 173;
    const LastTypeNode = 196;
    const FirstPunctuation = 18;
    const LastPunctuation = 77;
    const FirstToken = 0;
    const LastToken = 157;
    const FirstTriviaToken = 2;
    const LastTriviaToken = 7;
    const FirstLiteralToken = 8;
    const LastLiteralToken = 14;
    const FirstTemplateToken = 14;
    const LastTemplateToken = 17;
    const FirstBinaryOperator = 29;
    const LastBinaryOperator = 77;
    const FirstStatement = 233;
    const LastStatement = 249;
    const FirstNode = 158;
    const FirstJSDocNode = 302;
    const LastJSDocNode = 337;
    const FirstJSDocTagNode = 317;
    const LastJSDocTagNode = 337;
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

  TDiagnosticCategory = (
    Warning = 0,
    Error = 1,
    Message = 2
  );

  JOperationCanceledException = class external 'OperationCanceledException'
  end;

  JTextRange = class external 'TextRange'
    pos: Integer;
    &end: Integer;
  end;

  JNodeArray = class external({JArray,} JTextRange)
    hasTrailingComma: Boolean; // nullable
  end;

  JModifiersArray = class external(JNodeArray)
    flags: Integer;
  end;

  JNode = class external 'Node' (JTextRange)
    kind: TSyntaxKind;
    flags: TNodeFlags;
(*
    decorators: JNodeArray<Decorator>; // nullable
*)
    modifiers: JModifiersArray; // nullable
    parent: JNode; // nullable
  end;

  JDeclaration = class external(JNode)
    _declarationBrand: Variant;
    name: String; // nullable
  end;

  JSymbolTable = class external
    // property Item[index: String]: JSymbol;
  end;

  JSymbol = class external
    flags: TSymbolFlags;
    name: String;
    declarations: array of JDeclaration; // nullable
    valueDeclaration: JDeclaration; // nullable
    members: JSymbolTable; // nullable
    exports: JSymbolTable; // nullable
  end;

  JType = class external
    flags: TTypeFlags;
    symbol: JSymbol; // nullable
  end;

  JExpression = class external (JNode)
    _expressionBrand: Variant;
    contextualType: JType; // nullable
  end;

  JUnaryExpression = class external (JExpression)
    _unaryExpressionBrand: Variant;
  end;

  JPrefixUnaryExpression = class external(JUnaryExpression)
    &operator: TSyntaxKind;
    operand: JUnaryExpression;
  end;

  JPostfixExpression = class external(JUnaryExpression)
    _postfixExpressionBrand: Variant;
  end;

  JLeftHandSideExpression = class external(JPostfixExpression)
    _leftHandSideExpressionBrand: Variant;
  end;

  JPostfixUnaryExpression = class external(JPostfixExpression)
    operand: JLeftHandSideExpression;
    &operator: TSyntaxKind;
  end;

  JMemberExpression = class external(JLeftHandSideExpression)
    _memberExpressionBrand: Variant;
  end;

  JPrimaryExpression = class external(JMemberExpression)
    _primaryExpressionBrand: Variant;
  end;

  JIdentifier = class external(JPrimaryExpression)
    text: String;
    originalKeywordKind: TSyntaxKind; // nullable
  end;

  JQualifiedName = class external(JNode)
    left: String;
    right: JIdentifier;
  end;

  JLineAndCharacter = class external 'LineAndCharacter'
    line: Integer;
    character: Integer;
  end;

  JComputedPropertyName = class external(JNode)
    expression: JExpression;
  end;

  JTypeNode = class external(JNode)
    _typeNodeBrand: Variant;
  end;

  JTypeParameterDeclaration = class external(JDeclaration)
    name: JIdentifier;
    constraint: JTypeNode; // nullable
    expression: JExpression; // nullable
  end;

  JSignatureDeclaration = class external(JDeclaration)
    typeParameters: JNodeArray; // nullable
    parameters: JNodeArray;
    &type: JTypeNode; // nullable
  end;

  JVariableDeclarationList = class external(JNode)
    declarations: JNodeArray;
  end;

  JVariableDeclaration = class external(JDeclaration)
    parent: JVariableDeclarationList; // nullable
    name: Variant {JIdentifier or JBindingPattern};
    &type: JTypeNode; // nullable
    initializer: JExpression; // nullable
  end;

  JParameterDeclaration = class external(JDeclaration)
    dotDotDotToken: JNode; // nullable
    name: Variant {JIdentifier or JBindingPattern};
    questionToken: JNode; // nullable
    &type: JTypeNode; // nullable
    initializer: JExpression; // nullable
  end;

  JBindingElement = class external(JDeclaration)
    propertyName: JIdentifier; // nullable
    dotDotDotToken: JNode; // nullable
    name: Variant {JIdentifier or JBindingPattern};
    initializer: JExpression; // nullable
  end;

  JPropertyDeclaration = class external(JDeclaration{, JClassElement})
    name: String;
    questionToken: JNode; // nullable
    &type: JTypeNode; // nullable
    initializer: JExpression; // nullable
  end;

  JDiagnosticMessage = class external
    key: string;
    category: TDiagnosticCategory;
    code: Integer;
  end;

  JObjectLiteralElement = class external(JDeclaration)
    _objectLiteralBrandBrand: Variant;
  end;

  JPropertyAssignment = class external(JObjectLiteralElement)
    _propertyAssignmentBrand: Variant;
    name: String;
    questionToken: JNode; // nullable
    initializer: JExpression;
  end;

  JShorthandPropertyAssignment = class external(JObjectLiteralElement)
    name: JIdentifier;
    questionToken: JNode; // nullable
  end;

  JVariableLikeDeclaration = class external(JDeclaration)
    propertyName: JIdentifier; // nullable
    dotDotDotToken: JNode; // nullable
    name: String;
    questionToken: JNode; // nullable
    &type: JTypeNode; // nullable
    initializer: JExpression; // nullable
  end;

  JBindingPattern = class external(JNode)
    elements: JNodeArray;
  end;

  JFunctionLikeDeclaration = class external(JSignatureDeclaration)
    _functionLikeDeclarationBrand: Variant;
    asteriskToken: JNode; // nullable
    questionToken: JNode; // nullable
    body: Variant {JBlock or JExpression}; // nullable
  end;

  JStatement = class external(JNode)
    _statementBrand: Variant;
  end;

  JBlock = class external(JStatement)
    statements: JNodeArray;
  end;

  JFunctionDeclaration = class external(JFunctionLikeDeclaration{, JStatement})
    name: JIdentifier; // nullable
    body: JBlock; // nullable
  end;

  JMethodDeclaration = class external(JFunctionLikeDeclaration {, JClassElement, JObjectLiteralElement})
    body: JBlock; // nullable
  end;

  JConstructorDeclaration = class external(JFunctionLikeDeclaration {, JClassElement})
    body: JBlock; // nullable
  end;

  JClassElement = class external(JDeclaration)
    _classElementBrand: Variant;
  end;

  JInterfaceDeclaration = class external(JDeclaration{, JStatement})
    name: JIdentifier;
    typeParameters: JNodeArray; // nullable
    heritageClauses: JNodeArray; // nullable
    members: JNodeArray;
  end;

  JHeritageClause = class external(JNode)
    token: TSyntaxKind;
    types: JNodeArray; // nullable
  end;

  JTypeAliasDeclaration = class external(JDeclaration{, JStatement})
    name: JIdentifier;
    typeParameters: JNodeArray; // nullable
    &type: JTypeNode;
  end;

  JEnumMember = class external(JDeclaration)
    name: String;
    initializer: JExpression; // nullable
  end;

  JEnumDeclaration = class external(JDeclaration{, JStatement})
    name: JIdentifier;
    members: JNodeArray;
  end;

  JModuleDeclaration = class external(JDeclaration{, JStatement})
    name: Variant {JIdentifier or JLiteralExpression};
    body: Variant {JModuleBlock or JModuleDeclaration};
  end;

  JModuleBlock = class external(JNode{, JStatement})
    statements: JNodeArray;
  end;

  JSemicolonClassElement = class external(JClassElement)
    _semicolonClassElementBrand: Variant;
  end;

  JAccessorDeclaration = class external(JFunctionLikeDeclaration {, JClassElement, JObjectLiteralElement})
    _accessorDeclarationBrand: Variant;
    body: JBlock;
  end;

  JIndexSignatureDeclaration = class external(JSignatureDeclaration{, JClassElement})
    _indexSignatureDeclarationBrand: Variant;
  end;

  JImportEqualsDeclaration = class external(JDeclaration {, JStatement})
    name: JIdentifier;
    moduleReference: Variant {JEntityName or JExternalModuleReference};
  end;

  JExternalModuleReference = class external(JNode)
    expression: JExpression; // nullable
  end;

  JImportClause = class external(JDeclaration)
    name: JIdentifier; // nullable
    namedBindings: Variant {JNamespaceImport or JNamedImports}; // nullable
  end;

  JImportDeclaration = class external(JStatement)
    importClause: JImportClause; // nullable
    moduleSpecifier: JExpression;
  end;

  JNamespaceImport = class external(JDeclaration)
    name: JIdentifier;
  end;

  JExportDeclaration = class external(JDeclaration {, JStatement})
    //exportClause: JNamedExports; // nullable
    moduleSpecifier: JExpression; // nullable
  end;

  JNamedImportsOrExports = class external(JNode)
    elements: JNodeArray;
  end;

  JImportOrExportSpecifier = class external(JDeclaration)
    propertyName: JIdentifier; // nullable
    name: JIdentifier;
  end;

  JExportAssignment = class external(JDeclaration{, JStatement})
    isExportEquals: Boolean; // nullable
    expression: JExpression;
  end;

  JFileReference = class external(JTextRange)
    fileName: String;
  end;

  TErrorCallback = procedure(message: JDiagnosticMessage; _length: Integer);

  TDeclarationName = Variant;

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

  JSymbolDisplayPart = class external
    text: String;
    kind: String;
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
    property TextPos: Integer read getTextPos write setTextPos;
  end;

  JCompilerOptions = class external
    allowNonTsExtensions: Boolean; // nullable
    charset: String; // nullable
    declaration: Boolean; // nullable
    diagnostics: Boolean; // nullable
    emitBOM: Boolean; // nullable
    help: Boolean; // nullable
    init: Boolean; // nullable
    inlineSourceMap: Boolean; // nullable
    inlineSources: Boolean; // nullable
    jsx: TJsxEmit; // nullable
    listFiles: Boolean; // nullable
    locale: String; // nullable
    mapRoot: String; // nullable
    module: TModuleKind; // nullable
    newLine: TNewLineKind; // nullable
    noEmit: Boolean; // nullable
    noEmitHelpers: Boolean; // nullable
    noEmitOnError: Boolean; // nullable
    noErrorTruncation: Boolean; // nullable
    noImplicitAny: Boolean; // nullable
    noLib: Boolean; // nullable
    noResolve: Boolean; // nullable
    out: String; // nullable
    outFile: String; // nullable
    outDir: String; // nullable
    preserveConstEnums: Boolean; // nullable
    project: String; // nullable
    removeComments: Boolean; // nullable
    rootDir: String; // nullable
    sourceMap: Boolean; // nullable
    sourceRoot: String; // nullable
    suppressExcessPropertyErrors: Boolean; // nullable
    suppressImplicitAnyIndexErrors: Boolean; // nullable
    target: TScriptTarget; // nullable
    version: Boolean; // nullable
    watch: Boolean; // nullable
    isolatedModules: Boolean; // nullable
    experimentalDecorators: Boolean; // nullable
    experimentalAsyncFunctions: Boolean; // nullable
    emitDecoratorMetadata: Boolean; // nullable
    moduleResolution: TModuleResolutionKind; // nullable
    // property Item[option: String]: Variant {String or Integer or Boolean};
  end;

  JDiagnostic = class external
    file: JSourceFile;
    start: Integer;
    length: Integer;
    messageText: Variant {String or JDiagnosticMessageChain};
    category: TDiagnosticCategory;
    code: Integer;
  end;

  JTextSpan = class external
    start: Integer;
    length: Integer;
  end;

  JTextChangeRange = class external
    span: JTextSpan;
    newLength: Integer;
  end;

  JTextChange = class external 'TextChange'
    span: JTextSpan;
    newText: String;
  end;

  JIScriptSnapshot = class external
    function getText(start, &end: Integer): String;
    function getLength: Integer;
    function getChangeRange(oldSnapshot: JIScriptSnapshot): JTextChangeRange;
    procedure dispose;
  end;

  JTranspileOptions = class external
    compilerOptions: JCompilerOptions; // nullable
    fileName: String; // nullable
    reportDiagnostics: Boolean; // nullable
    moduleName: String; // nullable
    // renamedDependencies: JMap; // nullable
  end;

  JTranspileOutput = class external
    outputText: String;
    diagnostics: array of JDiagnostic; // nullable
    sourceMapText: String; // nullable
  end;

  JDocumentRegistry = class external
    function acquireDocument(fileName: String; compilationSettings: JCompilerOptions;
      scriptSnapshot: JIScriptSnapshot; version: String): JSourceFile;
    function updateDocument(fileName: String; compilationSettings: JCompilerOptions;
      scriptSnapshot: JIScriptSnapshot; version: String): JSourceFile;
    procedure releaseDocument(fileName: String; compilationSettings: JCompilerOptions);
    function reportStats: String;
  end;

  JPreProcessedFileInfo = class external
    referencedFiles: array of JFileReference;
    importedFiles: array of JFileReference;
    ambientExternalModules: array of String;
    isLibFile: Boolean;
  end;

  JHostCancellationToken = class external
    function isCancellationRequested: Boolean;
  end;

  JResolvedModule = class external
    resolvedFileName: String;
    isExternalLibraryImport: Boolean; // nullable
  end;

  JResolvedModuleWithFailedLookupLocations = class external
    resolvedModule: JResolvedModule;
    failedLookupLocations: array of String;
  end;

  JLanguageServiceHost = class external
    function getCompilationSettings: JCompilerOptions;
    function getNewLine: String;
    function getProjectVersion: String;
    function getScriptFileNames: array of String;
    function getScriptVersion(fileName: String): String;
    function getScriptSnapshot(fileName: String): JIScriptSnapshot;
    function getLocalizedDiagnosticMessages: Variant;
    function getCancellationToken: JHostCancellationToken;
    function getCurrentDirectory: String;
    function getDefaultLibFileName(options: JCompilerOptions): String;
    procedure log(s: String);
    procedure trace(s: String);
    procedure error(s: String);
    function useCaseSensitiveFileNames: Boolean;
    function resolveModuleNames(moduleNames: array of String; containingFile: String): array of JResolvedModule;
  end;

  TEndOfLineState = Integer;
  TEndOfLineStateHelper = strict helper for TEndOfLineState
    const None = 0;
    const InMultiLineCommentTrivia = 1;
    const InSingleQuoteStringLiteral = 2;
    const InDoubleQuoteStringLiteral = 3;
    const InTemplateHeadOrNoSubstitutionTemplate = 4;
    const InTemplateMiddleOrTail = 5;
    const InTemplateSubstitutionPosition = 6;
  end;

  TTokenClass = Integer;
  TTokenClassHelper = strict helper for TTokenClass
    const Punctuation = 0;
    const Keyword = 1;
    const &Operator = 2;
    const Comment = 3;
    const Whitespace = 4;
    const Identifier = 5;
    const NumberLiteral = 6;
    const StringLiteral = 7;
    const RegExpLiteral = 8;
  end;

  JClassifications = class external
    spans: array of Integer;
    endOfLineState: TEndOfLineState;
  end;

  JClassifiedSpan = class external
    textSpan: JTextSpan;
    classificationType: String;
  end;

  JCompletionEntry = class external
    name: String;
    kind: String;
    kindModifiers: String;
    sortText: String;
  end;

  JCompletionEntryDetails = class external
    name: String;
    kind: String;
    kindModifiers: String;
    displayParts: array of JSymbolDisplayPart;
    documentation: array of JSymbolDisplayPart;
  end;

  JCompletionInfo = class external
    isMemberCompletion: Boolean;
    isNewIdentifierLocation: Boolean;
    entries: array of JCompletionEntry;
  end;

  JQuickInfo = class external
    kind: String;
    kindModifiers: String;
    textSpan: JTextSpan;
    displayParts: array of JSymbolDisplayPart;
    documentation: array of JSymbolDisplayPart;
  end;

  JSignatureHelpParameter = class external
    name: String;
    documentation: array of JSymbolDisplayPart;
    displayParts: array of JSymbolDisplayPart;
    isOptional: Boolean;
  end;

  JSignatureHelpItem = class external
    isVariadic: Boolean;
    prefixDisplayParts: array of JSymbolDisplayPart;
    suffixDisplayParts: array of JSymbolDisplayPart;
    separatorDisplayParts: array of JSymbolDisplayPart;
    parameters: array of JSignatureHelpParameter;
    documentation: array of JSymbolDisplayPart;
  end;

  JSignatureHelpItems = class external
    items: array of JSignatureHelpItem;
    applicableSpan: JTextSpan;
    selectedItemIndex: Integer;
    argumentIndex: Integer;
    argumentCount: Integer;
  end;

  JRenameInfo = class external
    canRename: Boolean;
    localizedErrorMessage: String;
    displayName: String;
    fullDisplayName: String;
    kind: String;
    kindModifiers: String;
    triggerSpan: JTextSpan;
  end;

  JRenameLocation = class external
    textSpan: JTextSpan;
    fileName: String;
  end;

  JReferenceEntry = class external
    textSpan: JTextSpan;
    fileName: String;
    isWriteAccess: Boolean;
  end;

  JHighlightSpan = class external
    fileName: String; // nullable
    textSpan: JTextSpan;
    kind: String;
  end;

  JDocumentHighlights = class external
    fileName: String;
    highlightSpans: array of JHighlightSpan;
  end;

  JDefinitionInfo = class external
    fileName: String;
    textSpan: JTextSpan;
    kind: String;
    name: String;
    containerKind: String;
    containerName: String;
  end;

  JReferencedSymbol = class external
    definition: JDefinitionInfo;
    references: array of JReferenceEntry;
  end;

  JNavigateToItem = class external
    name: String;
    kind: String;
    kindModifiers: String;
    matchKind: String;
    isCaseSensitive: Boolean;
    fileName: String;
    textSpan: JTextSpan;
    containerName: String;
    containerKind: String;
  end;

  JOutliningSpan = class external
    textSpan: JTextSpan;
    hintSpan: JTextSpan;
    bannerText: String;
    autoCollapse: Boolean;
  end;

  JEditorOptions = class external
    IndentSize: Integer;
    TabSize: Integer;
    NewLineCharacter: String;
    ConvertTabsToSpaces: Boolean;
  end;

  JNavigationBarItem = class external
    text: String;
    kind: String;
    kindModifiers: String;
    spans: array of JTextSpan;
    childItems: array of JNavigationBarItem;
    indent: Integer;
    bolded: Boolean;
    grayed: Boolean;
  end;

  JTodoCommentDescriptor = class external
    text: String;
    priority: Integer;
  end;

  JTodoComment = class external
    descriptor: JTodoCommentDescriptor;
    message: String;
    position: Integer;
  end;

  JTextInsertion = class external
    newText: String;
    caretOffset: Integer;
  end;

  JFormatCodeOptions = class external(JEditorOptions)
    InsertSpaceAfterCommaDelimiter: Boolean;
    InsertSpaceAfterSemicolonInForStatements: Boolean;
    InsertSpaceBeforeAndAfterBinaryOperators: Boolean;
    InsertSpaceAfterKeywordsInControlFlowStatements: Boolean;
    InsertSpaceAfterFunctionKeywordForAnonymousFunctions: Boolean;
    InsertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis: Boolean;
    InsertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets: Boolean;
    PlaceOpenBraceOnNewLineForFunctions: Boolean;
    PlaceOpenBraceOnNewLineForControlBlocks: Boolean;
    // property Item[s: String]: Variant {Boolean or Integer or String};
  end;

  JOutputFile = class external
    name: String;
    writeByteOrderMark: Boolean;
    text: String;
  end;

  JEmitOutput = class external
    outputFiles: array of JOutputFile;
    emitSkipped: Boolean;
  end;

  JScriptReferenceHost = class external
    function getCompilerOptions: JCompilerOptions;
    function getSourceFile(fileName: String): JSourceFile;
    function getCurrentDirectory: String;
  end;

  TWriteFileCallback = procedure (fileName: String; data: String;
    writeByteOrderMark: Boolean; onError: procedure(message: String));

  JCancellationToken = class external
    function isCancellationRequested: Boolean;
    procedure throwIfCancellationRequested;
  end;

  JEmitResult = class external
    emitSkipped: Boolean;
    diagnostics: array of JDiagnostic;
  end;

  JTypeParameter = class external(JType)
    constraint: JType;
  end;

  JTypePredicate = class external
    parameterName: String;
    parameterIndex: Integer;
    &type: JType;
  end;

  JSignature = class external
    declaration: JSignatureDeclaration;
    typeParameters: array of JTypeParameter;
    parameters: array of JSymbol;
    typePredicate: JTypePredicate; // nullable
  end;

  JObjectType = class external(JType)
  end;

  JInterfaceType = class external(JObjectType)
    typeParameters: array of JTypeParameter;
    outerTypeParameters: array of JTypeParameter;
    localTypeParameters: array of JTypeParameter;
  end;

  JSymbolWriter = class external
    procedure writeKeyword(text: String);
    procedure writeOperator(text: String);
    procedure writePunctuation(text: String);
    procedure writeSpace(text: String);
    procedure writeStringLiteral(text: String);
    procedure writeParameter(text: String);
    procedure writeSymbol(text: String; symbol: JSymbol);
    procedure writeLine;
    procedure increaseIndent;
    procedure decreaseIndent;
    procedure clear;
    procedure trackSymbol(symbol: JSymbol); overload;
    procedure trackSymbol(symbol: JSymbol; enclosingDeclaration: JNode); overload;
    procedure trackSymbol(symbol: JSymbol; enclosingDeclaration: JNode;
      meaning: TSymbolFlags); overload;
  end;

  JSymbolDisplayBuilder = class external
    procedure buildTypeDisplay(&type: JType; writer: JSymbolWriter); overload;
    procedure buildTypeDisplay(&type: JType; writer: JSymbolWriter;
      enclosingDeclaration: JNode); overload;
    procedure buildTypeDisplay(&type: JType; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
    procedure buildSymbolDisplay(symbol: JSymbol; writer: JSymbolWriter); overload;
    procedure buildSymbolDisplay(symbol: JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode); overload;
    procedure buildSymbolDisplay(symbol: JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode; meaning: TSymbolFlags); overload;
    procedure buildSymbolDisplay(symbol: JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode; meaning: TSymbolFlags;
      flags: TSymbolFormatFlags); overload;
    procedure buildSignatureDisplay(signatures: JSignature; writer: JSymbolWriter); overload;
    procedure buildSignatureDisplay(signatures: JSignature; writer: JSymbolWriter;
      enclosingDeclaration: JNode); overload;
    procedure buildSignatureDisplay(signatures: JSignature; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
    procedure buildParameterDisplay(parameter: JSymbol; writer: JSymbolWriter); overload;
    procedure buildParameterDisplay(parameter: JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode); overload;
    procedure buildParameterDisplay(parameter: JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
    procedure buildTypeParameterDisplay(tp: JTypeParameter;
      writer: JSymbolWriter); overload;
    procedure buildTypeParameterDisplay(tp: JTypeParameter;
      writer: JSymbolWriter; enclosingDeclaration: JNode); overload;
    procedure buildTypeParameterDisplay(tp: JTypeParameter;
      writer: JSymbolWriter; enclosingDeclaration: JNode;
      flags: TTypeFormatFlags); overload;
    procedure buildTypeParameterDisplayFromSymbol(symbol: JSymbol; writer: JSymbolWriter); overload;
    procedure buildTypeParameterDisplayFromSymbol(symbol: JSymbol;
      writer: JSymbolWriter; enclosingDeclaraiton: JNode); overload;
    procedure buildTypeParameterDisplayFromSymbol(symbol: JSymbol;
      writer: JSymbolWriter; enclosingDeclaraiton: JNode;
      flags: TTypeFormatFlags); overload;
    procedure buildDisplayForParametersAndDelimiters(
      parameters: array of JSymbol; writer: JSymbolWriter); overload;
    procedure buildDisplayForParametersAndDelimiters(
      parameters: array of JSymbol; writer: JSymbolWriter; enclosingDeclaration: JNode); overload;
    procedure buildDisplayForParametersAndDelimiters(
      parameters: array of JSymbol; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
    procedure buildDisplayForTypeParametersAndDelimiters(
      typeParameters: array of JTypeParameter; writer: JSymbolWriter); overload;
    procedure buildDisplayForTypeParametersAndDelimiters(
      typeParameters: array of JTypeParameter; writer: JSymbolWriter; enclosingDeclaration: JNode); overload;
    procedure buildDisplayForTypeParametersAndDelimiters(
      typeParameters: array of JTypeParameter; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
    procedure buildReturnTypeDisplay(signature: JSignature; writer: JSymbolWriter); overload;
    procedure buildReturnTypeDisplay(signature: JSignature; writer: JSymbolWriter;
      enclosingDeclaration: JNode); overload;
    procedure buildReturnTypeDisplay(signature: JSignature; writer: JSymbolWriter;
      enclosingDeclaration: JNode; flags: TTypeFormatFlags); overload;
  end;

  JCallLikeExpression = Variant;
  JJsxOpeningLikeElement = Variant;

  JPropertyAccessExpression = class external(JMemberExpression)
    expression: JLeftHandSideExpression;
    dotToken: JNode;
    name: JIdentifier;
  end;

  JElementAccessExpression = class external(JMemberExpression)
    expression: JLeftHandSideExpression;
    argumentExpression: JExpression; // nullable
  end;

  JTypeChecker = class external
    function getTypeOfSymbolAtLocation(symbol: JSymbol; node: JNode): JType;
    function getDeclaredTypeOfSymbol(symbol: JSymbol): JType;
    function getPropertiesOfType(&type: JType): array of JSymbol;
    function getPropertyOfType(&type: JType; propertyName: String): JSymbol;
    function getSignaturesOfType(&type: JType; kind: TSignatureKind): array of JSignature;
    function getIndexTypeOfType(&type: JType; kind: TIndexKind): JType;
    function getBaseTypes(&type: JInterfaceType): array of JObjectType;
    function getReturnTypeOfSignature(signature: JSignature): JType;
    function getSymbolsInScope(location: JNode; meaning: TSymbolFlags): array of JSymbol;
    function getSymbolAtLocation(node: JNode): JSymbol;
    function getShorthandAssignmentValueSymbol(location: JNode): JSymbol;
    function getTypeAtLocation(node: JNode): JType;
    function typeToString(&type: JType): String; overload;
    function typeToString(&type: JType; enclosingDeclaration: JNode): String; overload;
    function typeToString(&type: JType; enclosingDeclaration: JNode; flags: TTypeFormatFlags): String; overload;
    function symbolToString(symbol: JSymbol): String; overload;
    function symbolToString(symbol: JSymbol; enclosingDeclaration: JNode): String; overload;
    function symbolToString(symbol: JSymbol; enclosingDeclaration: JNode; meaning: TSymbolFlags): String; overload;
    function getSymbolDisplayBuilder: JSymbolDisplayBuilder;
    function getFullyQualifiedName(symbol: JSymbol): String;
    function getAugmentedPropertiesOfType(&type: JType): array of JSymbol;
    function getRootSymbols(symbol: JSymbol): array of JSymbol;
    function getContextualType(node: JExpression): JType;
    function getResolvedSignature(node: JCallLikeExpression): JSignature; overload;
    function getResolvedSignature(node: JCallLikeExpression; candidatesOutArray: array of JSignature): JSignature; overload;
    function getSignatureFromDeclaration(declaration: JSignatureDeclaration): JSignature;
    function isImplementationOfOverload(node: JFunctionLikeDeclaration): Boolean;
    function isUndefinedSymbol(symbol: JSymbol): Boolean;
    function isArgumentsSymbol(symbol: JSymbol): Boolean;
    function getConstantValue(node: JEnumMember): Integer; overload;
    function getConstantValue(node: JPropertyAccessExpression): Integer; overload;
    function getConstantValue(node: JElementAccessExpression): Integer; overload;
    function isValidPropertyAccess(node: JPropertyAccessExpression; propertyName: String): Boolean; overload;
    function isValidPropertyAccess(node: JQualifiedName; propertyName: String): Boolean; overload;
    function getAliasedSymbol(symbol: JSymbol): JSymbol;
    function getExportsOfModule(moduleSymbol: JSymbol): array of JSymbol;
    function getJsxElementAttributesType(elementNode: JJsxOpeningLikeElement): JType;
    function getJsxIntrinsicTagNames: array of JSymbol;
    function isOptionalParameter(node: JParameterDeclaration): Boolean;
  end;

  JProgram = class external(JScriptReferenceHost)
    function getRootFileNames: array of String;
    function getSourceFiles: array of JSourceFile;
    function emit: JEmitResult; overload;
    function emit(targetSourceFile: JSourceFile): JEmitResult; overload;
    function emit(targetSourceFile: JSourceFile;
      writeFile: TWriteFileCallback): JEmitResult; overload;
    function emit(targetSourceFile: JSourceFile; writeFile: TWriteFileCallback;
      cancellationToken: JCancellationToken): JEmitResult; overload;
    function getOptionsDiagnostics: array of JDiagnostic; overload;
    function getOptionsDiagnostics(
      cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function getGlobalDiagnostics: array of JDiagnostic; overload;
    function getGlobalDiagnostics(
      cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function getSyntacticDiagnostics: array of JDiagnostic; overload;
    function getSyntacticDiagnostics(
      sourceFile: JSourceFile): array of JDiagnostic; overload;
    function getSyntacticDiagnostics(
      sourceFile: JSourceFile; cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function getSemanticDiagnostics: array of JDiagnostic; overload;
    function getSemanticDiagnostics(
      sourceFile: JSourceFile): array of JDiagnostic; overload;
    function getSemanticDiagnostics(sourceFile: JSourceFile;
      cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function getDeclarationDiagnostics: array of JDiagnostic; overload;
    function getDeclarationDiagnostics(sourceFile: JSourceFile): array of JDiagnostic; overload;
    function getDeclarationDiagnostics(sourceFile: JSourceFile;
      cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function getTypeChecker: JTypeChecker;
  end;

  JLanguageService = class external
    procedure cleanupSemanticCache;
    function getSyntacticDiagnostics(fileName: String): array of JDiagnostic;
    function getSemanticDiagnostics(fileName: String): array of JDiagnostic;
    function getCompilerOptionsDiagnostics: array of JDiagnostic;
    function getSyntacticClassifications(fileName: String;
      span: JTextSpan): array of JClassifiedSpan;
    function getSemanticClassifications(fileName: String;
      span: JTextSpan): array of JClassifiedSpan;
    function getEncodedSyntacticClassifications(fileName: String;
      span: JTextSpan): JClassifications;
    function getEncodedSemanticClassifications(fileName: String;
      span: JTextSpan): JClassifications;
    function getCompletionsAtPosition(fileName: String; position: Integer): JCompletionInfo;
    function getCompletionEntryDetails(fileName: String; position: Integer;
      entryName: String): JCompletionEntryDetails;
    function getQuickInfoAtPosition(fileName: String;
      position: Integer): JQuickInfo;
    function getNameOrDottedNameSpan(fileName: String; startPos,
      endPos: Integer): JTextSpan;
    function getBreakpointStatementAtPosition(fileName: String;
      position: Integer): JTextSpan;
    function getSignatureHelpItems(fileName: String;
      position: Integer): JSignatureHelpItems;
    function getRenameInfo(fileName: String; position: Integer): JRenameInfo;
    function findRenameLocations(fileName: String; position: Integer;
      findInStrings: Boolean; findInComments: Boolean): array of JRenameLocation;
    function getDefinitionAtPosition(fileName: String;
      position: Integer): array of JDefinitionInfo;
    function getTypeDefinitionAtPosition(fileName: String;
      position: Integer): array of JDefinitionInfo;
    function getReferencesAtPosition(fileName: String;
      position: Integer): array of JReferenceEntry;
    function findReferences(fileName: String;
      position: Integer): array of JReferencedSymbol;
    function getDocumentHighlights(fileName: String; position: Integer;
      filesToSearch: array of String): array of JDocumentHighlights;
    function getOccurrencesAtPosition(fileName: String;
      position: Integer): array of JReferenceEntry;
    function getNavigateToItems(searchValue: String;
      maxResultCount: Integer): array of JNavigateToItem;
    function getNavigationBarItems(fileName: String): array of JNavigationBarItem;
    function getOutliningSpans(fileName: String): array of JOutliningSpan;
    function getTodoComments(fileName: String;
      descriptors: array of JTodoCommentDescriptor): array of JTodoComment;
    function getBraceMatchingAtPosition(fileName: String;
      position: Integer): array of JTextSpan;
    function getIndentationAtPosition(fileName: String; position: Integer;
      options: JEditorOptions): Integer;
    function getFormattingEditsForRange(fileName: String; start,
      &end: Integer; options: JFormatCodeOptions): array of JTextChange;
    function getFormattingEditsForDocument(fileName: String;
      options: JFormatCodeOptions): array of JTextChange;
    function getFormattingEditsAfterKeystroke(fileName: String;
      position: Integer; key: String; options: JFormatCodeOptions): array of JTextChange;
    function getDocCommentTemplateAtPosition(fileName: String;
      position: Integer): JTextInsertion;
    function getEmitOutput(fileName: String): JEmitOutput;
    function getProgram: JProgram;
    function getSourceFile(fileName: String): JSourceFile;
    procedure dispose;
  end;

  JClassificationInfo = class external
    length: Integer;
    classification: TTokenClass;
  end;

  JClassificationResult = class external
    finalLexState: TEndOfLineState;
    entries: array of JClassificationInfo;
  end;

  JClassifier = class external
    function getClassificationsForLine(text: String; lexState: TEndOfLineState;
      syntacticClassifierAbsent: Boolean): JClassificationResult;
    function getEncodedLexicalClassifications(text: String;
      endOfLineState: TEndOfLineState;
      syntacticClassifierAbsent: Boolean): JClassifications;
  end;

  JModuleResolutionHost = class external
    function fileExists(fileName: String): Boolean;
    function readFile(fileName: String): String;
  end;

  TCompilerHostCallback = procedure(message: String);

  JCompilerHost = class external(JModuleResolutionHost)
    function getSourceFile(fileName: String; languageVersion: TScriptTarget;
      onError: TCompilerHostCallback): JSourceFile;
    function getCancellationToken: JCancellationToken;
    function getDefaultLibFileName(options: JCompilerOptions): String;
//    writeFile: TWriteFileCallback;
    function getCurrentDirectory: String;
    function getCanonicalFileName(fileName: String): String;
    function useCaseSensitiveFileNames: Boolean;
    function getNewLine: String;
    function resolveModuleNames(moduleNames: array of String;
      containingFile: String): array of JResolvedModule;
  end;

  TGetCanonicalFileName = function(fileName: String): String;
  TReadFileCallback = function(path: String): String;

  JParsedCommandLine = class external
    options: JCompilerOptions;
    fileNames: array of String;
    errors: array of JDiagnostic;
  end;

  TNodeCallback = function (node: JNode): Variant;
  TNodeArrayCallback = function (nodes: array of JNode): Variant;

  JDiagnosticMessageChain = class external
    messageText: String;
    category: TDiagnosticCategory;
    code: Integer;
    next: JDiagnosticMessageChain; // nullable
  end;

  TConfigFileResult = record
    config: Variant; // nullable
    error: JDiagnostic; // nullable
  end;

  TWatchFileCallback = procedure(path: String);

  JFileWatcher = class external
    procedure close;
  end;

  JSystem = class external
    args: array of String;
    newLine: String;
    useCaseSensitiveFileNames: Boolean;
    procedure write(s: String);
    function readFile(path: String): String; overload;
    function readFile(path: String; encoding: String): String; overload;
    procedure writeFile(path: String; data: String); overload;
    procedure writeFile(path: String; data: String; writeByteOrderMark: Boolean); overload;
    function watchFile(path: String; callback: TWatchFileCallback): JFileWatcher;
    function resolvePath(path: String): String;
    function fileExists(path: String): Boolean;
    function directoryExists(path: String): Boolean;
    procedure createDirectory(path: String);
    function getExecutingFilePath: String;
    function getCurrentDirectory: String;
    function readDirectory(path: String): array of String; overload;
    function readDirectory(path: String; extension: String): array of String; overload;
    function readDirectory(path: String; extension: String; _exclude: array of String): array of String; overload;
    function getMemoryUsage: Integer;
    procedure &exit; overload;
    procedure &exit(exitCode: Integer); overload;
  end;

  JTypeScriptExport = class external
    sys: JSystem;

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
    function createScanner(languageVersion: TScriptTarget;
      skipTrivia: Boolean): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean;
      languageVariant: TLanguageVariant): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean;
      languageVariant: TLanguageVariant; text: string): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean;
      languageVariant: TLanguageVariant; text: string;
      onError: TErrorCallback): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean;
      languageVariant: TLanguageVariant; text: string; onError: TErrorCallback;
      start: Integer): JScanner; overload; external;
    function createScanner(languageVersion: TScriptTarget; skipTrivia: Boolean;
      languageVariant: TLanguageVariant; text: string; onError: TErrorCallback;
      start, _length: Integer): JScanner; overload; external;

    function createSourceFile(fileName, sourceText: String;
      languageVersion: TScriptTarget): JSourceFile; overload;
    function createSourceFile(fileName, sourceText: String;
      languageVersion: TScriptTarget; setParentNodes: Boolean): JSourceFile; overload;

    function textSpanEnd(span: JTextSpan): Integer;
    function textSpanIsEmpty(span: JTextSpan): Boolean;
    function textSpanContainsPosition(span: JTextSpan; position: Integer): Boolean;
    function textSpanContainsTextSpan(span, other: JTextSpan): Boolean;
    function textSpanOverlapsWith(span, other: JTextSpan): Boolean;
    function textSpanOverlap(span1, span2: JTextSpan): JTextSpan;
    function textSpanIntersectsWithTextSpan(span, other: JTextSpan): Boolean;
    function textSpanIntersectsWith(span: JTextSpan; start, _length: Integer): Boolean;
    function decodedTextSpanIntersectsWith(start1, length1, length2: Integer): Boolean;
    function textSpanIntersectsWithPosition(span: JTextSpan; position: Integer): Boolean;
    function textSpanIntersection(span1, span2: JTextSpan): JTextSpan;
    function createTextSpan(start, _length: Integer): JTextSpan;
    function createTextSpanFromBounds(start, &end: Integer): JTextSpan;
    function textChangeRangeNewSpan(range: JTextChangeRange): JTextSpan;
    function textChangeRangeIsUnchanged(range: JTextChangeRange): Boolean;
    function createTextChangeRange(span: JTextSpan;
      newLength: Integer): JTextChangeRange;
    function collapseTextChangeRangesAcrossMultipleVersions(
      changes: array of JTextChangeRange): JTextChangeRange;
    function getTypeParameterOwner(d: JDeclaration): JDeclaration;

    function createNode(kind: TSyntaxKind): JNode;
    function forEachChild(node: JNode; cbNode: TNodeCallback): Variant; overload;
    function forEachChild(node: JNode; cbNode: TNodeCallback;
      cbNodeArray: TNodeArrayCallback): Variant; overload;
    function updateSourceFile(sourceFile: JSourceFile; newText: String;
      textChangeRange: JTextChangeRange): JSourceFile; overload;
    function updateSourceFile(sourceFile: JSourceFile; newText: String;
      textChangeRange: JTextChangeRange; aggressiveChecks: Boolean): JSourceFile; overload;

    function findConfigFile(searchPath: String): String;
    function resolveTripleslashReference(moduleName: String; containingFile: String): String;
    function resolveModuleName(moduleName: String; containingFile: String;
      compilerOptions: JCompilerOptions;
      host: JModuleResolutionHost): JResolvedModuleWithFailedLookupLocations;
    function nodeModuleNameResolver(moduleName: String; containingFile: String;
      host: JModuleResolutionHost): JResolvedModuleWithFailedLookupLocations;
    function classicNameResolver(moduleName: String; containingFile: String;
      compilerOptions: JCompilerOptions;
      host: JModuleResolutionHost): JResolvedModuleWithFailedLookupLocations;
    function createCompilerHost(options: JCompilerOptions;
      setParentNodes: Boolean): JCompilerHost; overload;
    function createCompilerHost(options: JCompilerOptions): JCompilerHost; overload;
    function getPreEmitDiagnostics(program: JProgram): array of JDiagnostic; overload;
    function getPreEmitDiagnostics(program: JProgram;
      sourceFile: JSourceFile): array of JDiagnostic; overload;
    function getPreEmitDiagnostics(program: JProgram; sourceFile: JSourceFile;
      cancellationToken: JCancellationToken): array of JDiagnostic; overload;
    function flattenDiagnosticMessageText(messageText: String;
      newLine: String): String; overload;
    function flattenDiagnosticMessageText(messageText: JDiagnosticMessageChain;
      newLine: String): String; overload;
    function createProgram(rootNames: array of String;
      options: JCompilerOptions): JProgram; overload;
    function createProgram(rootNames: array of String;
      options: JCompilerOptions; host: JCompilerHost): JProgram; overload;
    function createProgram(rootNames: array of String;
      options: JCompilerOptions; host: JCompilerHost;
      oldProgram: JProgram): JProgram; overload;

    function parseCommandLine(commandLine: array of String): JParsedCommandLine; overload;
    function parseCommandLine(commandLine: array of String;
      readFile: TReadFileCallback): JParsedCommandLine;  overload;
    function readConfigFile(fileName: String): TConfigFileResult;
    function parseConfigFileText(fileName: String;
      jsonText: String): TConfigFileResult;

    function displayPartsToString(
      displayParts: array of JSymbolDisplayPart): String;
    function getDefaultCompilerOptions: JCompilerOptions;
    function transpileModule(input: String;
      transpileOptions: JTranspileOptions): JTranspileOutput;
    function transpile(input: String): String; overload;
    function transpile(input: String; compilerOptions: JCompilerOptions): String; overload;
    function transpile(input: String; compilerOptions: JCompilerOptions;
      fileName: String): String; overload;
    function transpile(input: String; compilerOptions: JCompilerOptions;
      fileName: String; diagnostics: array of JDiagnostic): String; overload;
    function transpile(input: String; compilerOptions: JCompilerOptions;
      fileName: String; diagnostics: array of JDiagnostic; moduleName: String): String; overload;
//    function createLanguageServiceSourceFile(fileName: String; scriptSnapshot: JIScript; SnapshotscriptTarget: JScriptTargetversion: String; setNodeParents: Boolean): JSourceFile;
    function updateLanguageServiceSourceFile(sourceFile: JSourceFile;
      scriptSnapshot: JIScriptSnapshot; version: String;
      textChangeRange: JTextChangeRange; aggressiveChecks: Boolean): JSourceFile;
    function createGetCanonicalFileName(
      useCaseSensitivefileNames: Boolean): TGetCanonicalFileName;
    function createDocumentRegistry: JDocumentRegistry; overload;
    function createDocumentRegistry(
      useCaseSensitiveFileNames: Boolean): JDocumentRegistry; overload;
    function preProcessFile(sourceText: String): JPreProcessedFileInfo; overload;
    function preProcessFile(sourceText: String;
      readImportFiles: Boolean): JPreProcessedFileInfo; overload;
    function createLanguageService(host: JLanguageServiceHost): JLanguageService; overload;
    function createLanguageService(host: JLanguageServiceHost;
      documentRegistry: JDocumentRegistry): JLanguageService; overload;
    function createClassifier: JClassifier;

    (*
      Get the path of the default library files (lib.d.ts) as distributed with
      the typescript node package.
      The functionality is not supported if the ts module is consumed outside
      of a node module.
    *)
    function getDefaultLibFilePath(options: JCompilerOptions): String;
  end;

var TypeScriptExport := JTypeScriptExport(RequireModule('typescript'));