unit React_helmet;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-helmet
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  OtherElementAttributes = interface
  end;

  HtmlProps = Variant;

  BodyProps = Variant;

  LinkProps = Variant;

  MetaProps = Variant;

  HelmetTags = interface
    property baseTag: array of Variant;
    property linkTags: array of HTMLLinkElement;
    property metaTags: array of HTMLMetaElement;
    property noscriptTags: array of Variant;
    property scriptTags: array of HTMLScriptElement;
    property styleTags: array of HTMLStyleElement;
  end;

  HelmetProps = interface
    property async: Boolean;
    property base: Variant;
    property bodyAttributes: BodyProps;
    property children: React.ReactNode;
    property defaultTitle: String;
    property defer: Boolean;
    property encodeSpecialCharacters: Boolean;
    property htmlAttributes: HtmlProps;
    property onChangeClientState: procedure;
    property link: array of LinkProps;
    property meta: array of MetaProps;
    property noscript: array of Variant;
    property script: array of Variant;
    property style: array of Variant;
    property title: String;
    property titleAttributes: Variant;
    property titleTemplate: String;
  end;

  HelmetPropsToState = Variant;

  Helmet = class(React.Component) external
    function peek: HelmetPropsToState; static
    function rewind: HelmetData; static
    function renderStatic: HelmetData; static
    property canUseDOM: Boolean;
  end;

  HelmetData = interface
    property base: HelmetDatum;
    property bodyAttributes: HelmetHTMLBodyDatum;
    property htmlAttributes: HelmetHTMLElementDatum;
    property link: HelmetDatum;
    property meta: HelmetDatum;
    property noscript: HelmetDatum;
    property script: HelmetDatum;
    property style: HelmetDatum;
    property title: HelmetDatum;
    property titleAttributes: HelmetDatum;
  end;

  HelmetDatum = interface
    function toString: String;
    function toComponent: React.ReactElement;
  end;

  HelmetHTMLBodyDatum = interface
    function toString: String;
    function toComponent: React.HTMLAttributes<HTMLBodyElement>;
  end;

  HelmetHTMLElementDatum = interface
    function toString: String;
    function toComponent: React.HTMLAttributes<HTMLHtmlElement>;
  end;

implementation



end.
