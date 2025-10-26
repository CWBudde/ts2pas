unit React_modal;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-modal
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Styles = interface
    property content: React.CSSProperties;
    property overlay: React.CSSProperties;
  end;

  Classes = interface
    property base: String;
    property afterOpen: String;
    property beforeClose: String;
  end;

  Aria = interface
    property labelledby: String;
    property describedby: String;
    property modal: Variant;
  end;

  OnAfterOpenCallbackOptions = interface
    property overlayEl: Element;
    property contentEl: HTMLDivElement;
  end;

  OnAfterOpenCallback = interface
  end;

  Props = interface
    property children: React.ReactNode;
    property isOpen: Boolean;
    property style: Styles;
    property portalClassName: String;
    property bodyOpenClassName: String;
    property htmlOpenClassName: String;
    property className: Variant;
    property overlayClassName: Variant;
    property appElement: Variant;
    property onAfterOpen: OnAfterOpenCallback;
    procedure onAfterClose;
    procedure onRequestClose(event: Variant);
    property closeTimeoutMS: Float;
    property ariaHideApp: Boolean;
    property shouldFocusAfterRender: Boolean;
    property shouldCloseOnOverlayClick: Boolean;
    property shouldCloseOnEsc: Boolean;
    property shouldReturnFocusAfterClose: Boolean;
    property preventScroll: Boolean;
    function parentSelector: HTMLElement;
    property aria: Aria;
    property data: Variant;
    property role: String;
    property contentLabel: String;
    property contentRef: procedure;
    property overlayRef: procedure;
    property overlayElement: function: React.ReactElement;
    property contentElement: function: React.ReactElement;
    property testId: String;
    property id: String;
  end;

  ReactModal = class(React.Component) external
    property defaultStyles: ReactModal.Styles;
    procedure setAppElement(appElement: Variant); static
    property portal: Variant;
  end;

implementation



end.
