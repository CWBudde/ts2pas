unit React_beautiful_dnd;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-beautiful-dnd
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  Omit = Pick<T, Exclude<Variant, K>>;

  Position = interface
    property x: Float;
    property y: Float;
  end;

  BoxModel = interface
    property marginBox: Rect;
    property borderBox: Rect;
    property paddingBox: Rect;
    property contentBox: Rect;
    property border: Spacing;
    property padding: Spacing;
    property margin: Spacing;
  end;

  Rect = interface
    property top: Float;
    property right: Float;
    property bottom: Float;
    property left: Float;
    property width: Float;
    property height: Float;
    property x: Float;
    property y: Float;
    property center: Position;
  end;

  Spacing = interface
    property top: Float;
    property right: Float;
    property bottom: Float;
    property left: Float;
  end;

  Id = String;

  DraggableId = Id;

  DroppableId = Id;

  TypeId = Id;

  ContextId = Id;

  ElementId = Id;

  DroppableMode = String;

  DroppableDescriptor = interface
    property id: DroppableId;
    property type: TypeId;
    property mode: DroppableMode;
  end;

  DraggableDescriptor = interface
    property id: DraggableId;
    property index: Float;
    property droppableId: DroppableId;
    property type: TypeId;
  end;

  DraggableOptions = interface
    property canDragInteractiveElements: Boolean;
    property shouldRespectForcePress: Boolean;
    property isEnabled: Boolean;
  end;

  Direction = String;

  VerticalAxis = interface
    property direction: String;
    property line: String;
    property start: String;
    property end: String;
    property size: String;
    property crossAxisLine: String;
    property crossAxisStart: String;
    property crossAxisEnd: String;
    property crossAxisSize: String;
  end;

  HorizontalAxis = interface
    property direction: String;
    property line: String;
    property start: String;
    property end: String;
    property size: String;
    property crossAxisLine: String;
    property crossAxisStart: String;
    property crossAxisEnd: String;
    property crossAxisSize: String;
  end;

  Axis = Variant;

  ScrollSize = interface
    property scrollHeight: Float;
    property scrollWidth: Float;
  end;

  ScrollDifference = interface
    property value: Position;
    property displacement: Position;
  end;

  ScrollDetails = interface
    property initial: Position;
    property current: Position;
    property max: Position;
    property diff: ScrollDifference;
  end;

  Placeholder = interface
    property client: BoxModel;
    property tagName: String;
    property display: String;
  end;

  DraggableDimension = interface
    property descriptor: DraggableDescriptor;
    property placeholder: Placeholder;
    property client: BoxModel;
    property page: BoxModel;
    property displaceBy: Position;
  end;

  Scrollable = interface
    property pageMarginBox: Rect;
    property frameClient: BoxModel;
    property scrollSize: ScrollSize;
    property shouldClipSubject: Boolean;
    property scroll: ScrollDetails;
  end;

  PlaceholderInSubject = interface
    property increasedBy: Position;
    property placeholderSize: Position;
    property oldFrameMaxScroll: Position;
  end;

  DroppableSubject = interface
    property page: BoxModel;
    property withPlaceholder: PlaceholderInSubject;
    property active: Rect;
  end;

  DroppableDimension = interface
    property descriptor: DroppableDescriptor;
    property axis: Axis;
    property isEnabled: Boolean;
    property isCombineEnabled: Boolean;
    property client: BoxModel;
    property isFixedOnPage: Boolean;
    property page: BoxModel;
    property frame: Scrollable;
    property subject: DroppableSubject;
  end;

  DraggableLocation = interface
    property droppableId: DroppableId;
    property index: Float;
  end;

  DraggableIdMap = interface
  end;

  DroppableIdMap = interface
  end;

  DraggableDimensionMap = interface
  end;

  DroppableDimensionMap = interface
  end;

  Displacement = interface
    property draggableId: DraggableId;
    property shouldAnimate: Boolean;
  end;

  DisplacementMap = interface
  end;

  DisplacedBy = interface
    property value: Float;
    property point: Position;
  end;

  Combine = interface
    property draggableId: DraggableId;
    property droppableId: DroppableId;
  end;

  DisplacementGroups = interface
    property all: array of DraggableId;
    property visible: DisplacementMap;
    property invisible: DraggableIdMap;
  end;

  ReorderImpact = interface
    property type: String;
    property destination: DraggableLocation;
  end;

  CombineImpact = interface
    property type: String;
    property combine: Combine;
  end;

  ImpactLocation = Variant;

  Displaced = interface
    property forwards: DisplacementGroups;
    property backwards: DisplacementGroups;
  end;

  DragImpact = interface
    property displaced: DisplacementGroups;
    property displacedBy: DisplacedBy;
    property at: ImpactLocation;
  end;

  ClientPositions = interface
    property selection: Position;
    property borderBoxCenter: Position;
    property offset: Position;
  end;

  PagePositions = interface
    property selection: Position;
    property borderBoxCenter: Position;
    property offset: Position;
  end;

  MovementMode = String;

  DragPositions = interface
    property client: ClientPositions;
    property page: PagePositions;
  end;

  DraggableRubric = interface
    property draggableId: DraggableId;
    property type: TypeId;
    property source: DraggableLocation;
  end;

  BeforeCapture = interface
    property draggableId: DraggableId;
    property mode: MovementMode;
  end;

  DragStart = interface(DraggableRubric)
    property mode: MovementMode;
  end;

  DragUpdate = interface(DragStart)
    property destination: DraggableLocation;
    property combine: Combine;
  end;

  DropReason = String;

  DropResult = interface(DragUpdate)
    property reason: DropReason;
  end;

  ScrollOptions = interface
    property shouldPublishImmediately: Boolean;
  end;

  LiftRequest = interface
    property draggableId: DraggableId;
    property scrollOptions: ScrollOptions;
  end;

  Critical = interface
    property draggable: DraggableDescriptor;
    property droppable: DroppableDescriptor;
  end;

  Viewport = interface
    property frame: Rect;
    property scroll: ScrollDetails;
  end;

  LiftEffect = interface
    property inVirtualList: Boolean;
    property effected: DraggableIdMap;
    property displacedBy: DisplacedBy;
  end;

  DimensionMap = interface
    property draggables: DraggableDimensionMap;
    property droppables: DroppableDimensionMap;
  end;

  DroppablePublish = interface
    property droppableId: DroppableId;
    property scroll: Position;
  end;

  Published = interface
    property additions: array of DraggableDimension;
    property removals: array of DraggableId;
    property modified: array of DroppablePublish;
  end;

  CompletedDrag = interface
    property critical: Critical;
    property result: DropResult;
    property impact: DragImpact;
    property afterCritical: LiftEffect;
  end;

  IdleState = interface
    property phase: String;
    property completed: CompletedDrag;
    property shouldFlush: Boolean;
  end;

  DraggingState = interface
    property phase: String;
    property isDragging: Boolean;
    property critical: Critical;
    property movementMode: MovementMode;
    property dimensions: DimensionMap;
    property initial: DragPositions;
    property current: DragPositions;
    property impact: DragImpact;
    property viewport: Viewport;
    property afterCritical: LiftEffect;
    property onLiftImpact: DragImpact;
    property isWindowScrollAllowed: Boolean;
    property scrollJumpRequest: Position;
    property forceShouldAnimate: Boolean;
  end;

  CollectingState = interface(Omit)
    property phase: String;
  end;

  DropPendingState = interface(Omit)
    property phase: String;
    property isWaiting: Boolean;
    property reason: DropReason;
  end;

  DropAnimatingState = interface
    property phase: String;
    property completed: CompletedDrag;
    property newHomeClientOffset: Position;
    property dropDuration: Float;
    property dimensions: DimensionMap;
  end;

  State = Variant;

  StateWhenUpdatesAllowed = Variant;

  Announce = procedure;

  InOutAnimationMode = String;

  ResponderProvided = interface
    property announce: Announce;
  end;

  OnBeforeCaptureResponder = procedure;

  OnBeforeDragStartResponder = procedure;

  OnDragStartResponder = procedure;

  OnDragUpdateResponder = procedure;

  OnDragEndResponder = procedure;

  Responders = interface
    property onBeforeCapture: OnBeforeCaptureResponder;
    property onBeforeDragStart: OnBeforeDragStartResponder;
    property onDragStart: OnDragStartResponder;
    property onDragUpdate: OnDragUpdateResponder;
    property onDragEnd: OnDragEndResponder;
  end;

  StopDragOptions = interface
    property shouldBlockNextClick: Boolean;
  end;

  DragActions = interface
    property drop: procedure;
    property cancel: procedure;
    property isActive: function: Boolean;
    property shouldRespectForcePress: function: Boolean;
  end;

  FluidDragActions = interface(DragActions)
    property move: procedure;
  end;

  SnapDragActions = interface(DragActions)
    property moveUp: procedure;
    property moveDown: procedure;
    property moveRight: procedure;
    property moveLeft: procedure;
  end;

  PreDragActions = interface
    property isActive: function: Boolean;
    property shouldRespectForcePress: function: Boolean;
    property fluidLift: function: FluidDragActions;
    property snapLift: function: SnapDragActions;
    property abort: procedure;
  end;

  TryGetLockOptions = interface
    property sourceEvent: Event;
  end;

  TryGetLock = function: PreDragActions;

  SensorAPI = interface
    property tryGetLock: TryGetLock;
    property canGetLock: function: Boolean;
    property isLockClaimed: function: Boolean;
    property tryReleaseLock: procedure;
    property findClosestDraggableId: function: DraggableId;
    property findOptionsForDraggable: function: DraggableOptions;
  end;

  Sensor = procedure;

  DragDropContextProps = interface(Responders)
    property children: React.ReactNode;
    property dragHandleUsageInstructions: String;
    property nonce: String;
    property enableDefaultSensors: Boolean;
    property sensors: array of Sensor;
  end;

  DragDropContext = class(React.Component) external
  end;

  DroppableProvidedProps = interface
  end;

  DroppableProvided = interface
    property innerRef: procedure;
    property placeholder: React.ReactNode;
    property droppableProps: DroppableProvidedProps;
  end;

  DroppableStateSnapshot = interface
    property isDraggingOver: Boolean;
    property draggingOverWith: DraggableId;
    property draggingFromThisWith: DraggableId;
    property isUsingPlaceholder: Boolean;
  end;

  DroppableProps = interface
    property droppableId: DroppableId;
    property type: TypeId;
    property mode: DroppableMode;
    property isDropDisabled: Boolean;
    property isCombineEnabled: Boolean;
    property direction: Direction;
    property ignoreContainerClipping: Boolean;
    property renderClone: DraggableChildrenFn;
    property getContainerForClone: function: HTMLElement;
    function children(provided: DroppableProvided; snapshot: DroppableStateSnapshot): React.ReactElement<HTMLElement>;
  end;

  Droppable = class(React.Component) external
  end;

  DropAnimation = interface
    property duration: Float;
    property curve: String;
    property moveTo: Position;
    property opacity: Float;
    property scale: Float;
  end;

  NotDraggingStyle = interface
    property transform: String;
    property transition: String;
  end;

  DraggingStyle = interface
    property position: String;
    property top: Float;
    property left: Float;
    property boxSizing: String;
    property width: Float;
    property height: Float;
    property transition: String;
    property transform: String;
    property zIndex: Float;
    property opacity: Float;
    property pointerEvents: String;
  end;

  DraggableProvidedDraggableProps = interface
    property style: Variant;
    property onTransitionEnd: React.TransitionEventHandler<Variant>;
  end;

  DraggableProvidedDragHandleProps = interface
    property role: String;
    property tabIndex: Float;
    property draggable: Boolean;
    property onDragStart: React.DragEventHandler<Variant>;
  end;

  DraggableProvided = interface
    property innerRef: procedure;
    property draggableProps: DraggableProvidedDraggableProps;
    property dragHandleProps: DraggableProvidedDragHandleProps;
  end;

  DraggableStateSnapshot = interface
    property isDragging: Boolean;
    property isDropAnimating: Boolean;
    property isClone: Boolean;
    property dropAnimation: DropAnimation;
    property draggingOver: DroppableId;
    property combineWith: DraggableId;
    property combineTargetFor: DraggableId;
    property mode: MovementMode;
  end;

  DraggableChildrenFn = function: React.ReactElement<HTMLElement>;

  DraggableProps = interface
    property draggableId: DraggableId;
    property index: Float;
    property children: DraggableChildrenFn;
    property isDragDisabled: Boolean;
    property disableInteractiveElementBlocking: Boolean;
    property shouldRespectForcePress: Boolean;
  end;

  Draggable = class(React.Component) external
  end;

  procedure resetServerContext;

implementation



end.
