unit React_table;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: react-table
   * Generator: ts2pas v1.0.0-alpha.1
   *)


  TableOptions = interface(UseTableOptions)
  end;

  TableInstance = interface(Omit, UseTableInstanceProps)
  end;

  TableState = interface
    property hiddenColumns: array of IdType<D>;
  end;

  Hooks = interface(UseTableHooks)
  end;

  Cell = interface(UseTableCellProps)
  end;

  ColumnInterface = interface(UseTableColumnOptions)
  end;

  ColumnInterfaceBasedOnValue = interface
    property Cell: Renderer<CellProps<D, V>>;
  end;

  ColumnGroupInterface = interface
    property columns: array of Column<D>;
  end;

  ColumnGroup = Variant;

  ValueOf = Variant;

  ColumnWithStrictAccessor = Variant;

  ColumnWithLooseAccessor = Variant;

  Column = Variant;

  ColumnInstance = interface(Omit, ColumnInterfaceBasedOnValue, UseTableColumnProps)
  end;

  HeaderGroup = interface(ColumnInstance, UseTableHeaderGroupProps)
  end;

  Row = interface(UseTableRowProps)
  end;

  TableCommonProps = interface
    property style: CSSProperties;
    property className: String;
    property role: String;
  end;

  TableProps = interface(TableCommonProps)
  end;

  TableBodyProps = interface(TableCommonProps)
  end;

  TableKeyedProps = interface(TableCommonProps)
    property key: React.Key;
  end;

  TableHeaderGroupProps = interface(TableKeyedProps)
  end;

  TableFooterGroupProps = interface(TableKeyedProps)
  end;

  TableHeaderProps = interface(TableKeyedProps)
  end;

  TableFooterProps = interface(TableKeyedProps)
  end;

  TableRowProps = interface(TableKeyedProps)
  end;

  TableCellProps = interface(TableKeyedProps)
  end;

  TableToggleCommonProps = interface(TableCommonProps)
    property onChange: procedure;
    property checked: Boolean;
    property title: String;
    property indeterminate: Boolean;
  end;

  MetaBase = interface
    property instance: TableInstance<D>;
    property userProps: Variant;
  end;

  Meta = Variant;

  function useTable(options: TableOptions<D>; plugins: array of PluginHook<D>): TableInstance<D>;

  UseTableOptions = Variant;

  PropGetter = Variant;

  TablePropGetter = PropGetter<D, TableProps>;

  TableBodyPropGetter = PropGetter<D, TableBodyProps>;

  HeaderPropGetter = PropGetter<D, TableHeaderProps, Variant>;

  FooterGroupPropGetter = PropGetter<D, TableFooterGroupProps, Variant>;

  HeaderGroupPropGetter = PropGetter<D, TableHeaderGroupProps, Variant>;

  FooterPropGetter = PropGetter<D, TableFooterProps, Variant>;

  RowPropGetter = PropGetter<D, TableRowProps, Variant>;

  CellPropGetter = PropGetter<D, TableCellProps, Variant>;

  ReducerTableState = interface(TableState, Record)
  end;

  UseTableHooks = interface(Record)
    property useOptions: array of function: TableOptions<D>;
    property stateReducers: array of function: ReducerTableState<D>;
    property columns: array of function: array of Column<D>;
    property columnsDeps: array of function: array of Variant;
    property allColumns: array of function: array of Column<D>;
    property allColumnsDeps: array of function: array of Variant;
    property visibleColumns: array of function: array of Column<D>;
    property visibleColumnsDeps: array of function: array of Variant;
    property headerGroups: array of function: array of HeaderGroup<D>;
    property headerGroupsDeps: array of function: array of Variant;
    property useInstanceBeforeDimensions: array of procedure;
    property useInstance: array of procedure;
    property prepareRow: array of procedure;
    property useControlledState: array of function: TableState<D>;
    property getTableProps: array of TablePropGetter<D>;
    property getTableBodyProps: array of TableBodyPropGetter<D>;
    property getHeaderGroupProps: array of HeaderGroupPropGetter<D>;
    property getFooterGroupProps: array of FooterGroupPropGetter<D>;
    property getHeaderProps: array of HeaderPropGetter<D>;
    property getFooterProps: array of FooterPropGetter<D>;
    property getRowProps: array of RowPropGetter<D>;
    property getCellProps: array of CellPropGetter<D>;
    property useFinalInstance: array of procedure;
  end;

  UseTableColumnOptions = interface
    property id: IdType<D>;
    property Header: Renderer<HeaderProps<D>>;
    property Footer: Renderer<FooterProps<D>>;
    property width: Variant;
    property minWidth: Float;
    property maxWidth: Float;
  end;

  UpdateHiddenColumns = function: array of IdType<D>;

  TableToggleHideAllColumnProps = interface(TableToggleCommonProps)
  end;

  UseTableInstanceProps = interface
    property state: TableState<D>;
    property plugins: array of PluginHook<D>;
    property dispatch: TableDispatch;
    property columns: array of ColumnInstance<D>;
    property allColumns: array of ColumnInstance<D>;
    property visibleColumns: array of ColumnInstance<D>;
    property headerGroups: array of HeaderGroup<D>;
    property footerGroups: array of HeaderGroup<D>;
    property headers: array of ColumnInstance<D>;
    property flatHeaders: array of ColumnInstance<D>;
    property rows: array of Row<D>;
    property rowsById: Variant;
    property getTableProps: function: TableProps;
    property getTableBodyProps: function: TableBodyProps;
    property prepareRow: procedure;
    property flatRows: array of Row<D>;
    property totalColumnsWidth: Float;
    property allColumnsHidden: Boolean;
    property toggleHideColumn: procedure;
    property setHiddenColumns: procedure;
    property toggleHideAllColumns: procedure;
    property getToggleHideAllColumnsProps: function: TableToggleHideAllColumnProps;
    property getHooks: function: Hooks<D>;
  end;

  UseTableHeaderGroupProps = interface
    property headers: array of HeaderGroup<D>;
    property getHeaderGroupProps: function: TableHeaderProps;
    property getFooterGroupProps: function: TableFooterProps;
    property totalHeaderCount: Float;
  end;

  UseTableColumnProps = interface
    property id: IdType<D>;
    property columns: array of ColumnInstance<D>;
    property isVisible: Boolean;
    property render: function: ReactNode;
    property totalLeft: Float;
    property totalWidth: Float;
    property getHeaderProps: function: TableHeaderProps;
    property getFooterProps: function: TableFooterProps;
    property toggleHidden: procedure;
    property parent: ColumnInstance<D>;
    property getToggleHiddenProps: function: Variant;
    property depth: Float;
    property placeholderOf: ColumnInstance;
  end;

  UseTableRowProps = interface
    property cells: array of Cell<D>;
    property allCells: array of Cell<D>;
    property values: Variant;
    property getRowProps: function: TableRowProps;
    property index: Float;
    property original: D;
    property id: String;
    property subRows: array of Row<D>;
  end;

  UseTableCellProps = interface
    property column: ColumnInstance<D>;
    property row: Row<D>;
    property value: CellValue<V>;
    property getCellProps: function: TableCellProps;
    property render: function: ReactNode;
  end;

  HeaderProps = Variant;

  FooterProps = Variant;

  CellProps = Variant;

  Accessor = function: CellValue;

  procedure useAbsoluteLayout(hooks: Hooks<D>);

  procedure useBlockLayout(hooks: Hooks<D>);

  procedure useColumnOrder(hooks: Hooks<D>);

  UseColumnOrderState = interface
    property columnOrder: array of IdType<D>;
  end;

  UseColumnOrderInstanceProps = interface
    property setColumnOrder: procedure;
  end;

  procedure useExpanded(hooks: Hooks<D>);

  TableExpandedToggleProps = interface(TableKeyedProps)
  end;

  UseExpandedOptions = Variant;

  UseExpandedHooks = interface
    property getToggleRowsExpandedProps: array of PropGetter<D, TableCommonProps>;
    property getToggleAllRowsExpandedProps: array of PropGetter<D, TableCommonProps>;
  end;

  UseExpandedState = interface
    property expanded: Variant;
  end;

  UseExpandedInstanceProps = interface
    property preExpandedRows: array of Row<D>;
    property expandedRows: array of Row<D>;
    property rows: array of Row<D>;
    property expandedDepth: Float;
    property isAllRowsExpanded: Boolean;
    property toggleRowExpanded: procedure;
    property toggleAllRowsExpanded: procedure;
  end;

  UseExpandedRowProps = interface
    property isExpanded: Boolean;
    property canExpand: Boolean;
    property subRows: array of Row<D>;
    property toggleRowExpanded: procedure;
    property getToggleRowExpandedProps: function: TableExpandedToggleProps;
    property depth: Float;
  end;

  procedure useFilters(hooks: Hooks<D>);

  UseFiltersOptions = Variant;

  UseFiltersState = interface
    property filters: Filters<D>;
  end;

  UseFiltersColumnOptions = Variant;

  UseFiltersInstanceProps = interface
    property preFilteredRows: array of Row<D>;
    property preFilteredFlatRows: array of Row<D>;
    property preFilteredRowsById: Variant;
    property filteredRows: array of Row<D>;
    property filteredFlatRows: array of Row<D>;
    property filteredRowsById: Variant;
    property rows: array of Row<D>;
    property flatRows: array of Row<D>;
    property rowsById: Variant;
    property setFilter: procedure;
    property setAllFilters: procedure;
  end;

  UseFiltersColumnProps = interface
    property canFilter: Boolean;
    property setFilter: procedure;
    property filterValue: FilterValue;
    property preFilteredRows: array of Row<D>;
    property filteredRows: array of Row<D>;
  end;

  FilterProps = HeaderProps<D>;

  FilterValue = Variant;

  Filters = array of Variant;

  FilterTypes = Variant;

  DefaultFilterTypes = String;

  FilterType = interface
    property autoRemove: function: Boolean;
  end;

  procedure useFlexLayout(hooks: Hooks<D>);

  procedure useGridLayout(hooks: Hooks<D>);

  procedure useGlobalFilter(hooks: Hooks<D>);

  UseGlobalFiltersOptions = Variant;

  UseGlobalFiltersState = interface
    property globalFilter: Variant;
  end;

  UseGlobalFiltersColumnOptions = Variant;

  UseGlobalFiltersInstanceProps = interface
    property preGlobalFilteredRows: array of Row<D>;
    property preGlobalFilteredFlatRows: array of Row<D>;
    property preGlobalFilteredRowsById: Variant;
    property globalFilteredRows: array of Row<D>;
    property globalFilteredFlatRows: array of Row<D>;
    property globalFilteredRowsById: Variant;
    property rows: array of Row<D>;
    property flatRows: array of Row<D>;
    property rowsById: Variant;
    property setGlobalFilter: procedure;
  end;

  procedure useGroupBy(hooks: Hooks<D>);

  TableGroupByToggleProps = interface
    property title: String;
    property style: CSSProperties;
    property onClick: procedure;
  end;

  UseGroupByOptions = Variant;

  UseGroupByHooks = interface
    property getGroupByToggleProps: array of HeaderGroupPropGetter<D>;
  end;

  UseGroupByState = interface
    property groupBy: array of IdType<D>;
  end;

  UseGroupByColumnOptions = Variant;

  UseGroupByInstanceProps = interface
    property preGroupedRows: array of Row<D>;
    property preGroupedFlatRows: array of Row<D>;
    property preGroupedRowsById: Variant;
    property groupedRows: array of Row<D>;
    property groupedFlatRows: array of Row<D>;
    property groupedRowsById: Variant;
    property onlyGroupedFlatRows: array of Row<D>;
    property onlyGroupedRowsById: Variant;
    property nonGroupedFlatRows: array of Row<D>;
    property nonGroupedRowsById: Variant;
    property rows: array of Row<D>;
    property flatRows: array of Row<D>;
    property rowsById: Variant;
    property toggleGroupBy: procedure;
  end;

  UseGroupByColumnProps = interface
    property canGroupBy: Boolean;
    property isGrouped: Boolean;
    property groupedIndex: Float;
    property toggleGroupBy: procedure;
    property getGroupByToggleProps: function: TableGroupByToggleProps;
  end;

  UseGroupByRowProps = interface
    property isGrouped: Boolean;
    property groupByID: IdType<D>;
    property groupByVal: String;
    property values: Variant;
    property subRows: array of Row<D>;
    property leafRows: array of Row<D>;
    property depth: Float;
    property id: String;
    property index: Float;
  end;

  UseGroupByCellProps = interface
    property isGrouped: Boolean;
    property isPlaceholder: Boolean;
    property isAggregated: Boolean;
  end;

  DefaultAggregators = String;

  AggregatorFn = function: AggregatedValue;

  Aggregator = Variant;

  AggregatedValue = Variant;

  procedure usePagination(hooks: Hooks<D>);

  UsePaginationOptions = Variant;

  UsePaginationState = interface
    property pageSize: Float;
    property pageIndex: Float;
  end;

  UsePaginationInstanceProps = interface
    property page: array of Row<D>;
    property pageCount: Float;
    property pageOptions: array of Float;
    property canPreviousPage: Boolean;
    property canNextPage: Boolean;
    property gotoPage: procedure;
    property previousPage: procedure;
    property nextPage: procedure;
    property setPageSize: procedure;
  end;

  procedure useResizeColumns(hooks: Hooks<D>);

  UseResizeColumnsOptions = interface
    property disableResizing: Boolean;
    property autoResetResize: Boolean;
  end;

  UseResizeColumnsState = interface
    property columnResizing: Variant;
  end;

  UseResizeColumnsColumnOptions = interface
    property disableResizing: Boolean;
  end;

  TableResizerProps = interface
  end;

  UseResizeColumnsColumnProps = interface
    property getResizerProps: function: TableResizerProps;
    property canResize: Boolean;
    property isResizing: Boolean;
  end;

  procedure useRowSelect(hooks: Hooks<D>);

  TableToggleAllRowsSelectedProps = interface(TableToggleCommonProps)
  end;

  TableToggleRowsSelectedProps = interface(TableToggleCommonProps)
  end;

  UseRowSelectOptions = Variant;

  UseRowSelectHooks = interface
    property getToggleRowSelectedProps: array of PropGetter<D, TableToggleRowsSelectedProps>;
    property getToggleAllRowsSelectedProps: array of PropGetter<D, TableToggleAllRowsSelectedProps>;
    property getToggleAllPageRowsSelectedProps: array of PropGetter<D, TableToggleAllRowsSelectedProps>;
  end;

  UseRowSelectState = interface
    property selectedRowIds: Variant;
  end;

  UseRowSelectInstanceProps = interface
    property toggleRowSelected: procedure;
    property toggleAllRowsSelected: procedure;
    property getToggleAllRowsSelectedProps: function: TableToggleAllRowsSelectedProps;
    property getToggleAllPageRowsSelectedProps: function: TableToggleAllRowsSelectedProps;
    property isAllRowsSelected: Boolean;
    property selectedFlatRows: array of Row<D>;
  end;

  UseRowSelectRowProps = interface
    property isSelected: Boolean;
    property isSomeSelected: Boolean;
    property toggleRowSelected: procedure;
    property getToggleRowSelectedProps: function: TableToggleRowsSelectedProps;
  end;

  procedure useRowState(hooks: Hooks<D>);

  UseRowStateOptions = Variant;

  UseRowStateState = interface
    property rowState: Variant;
  end;

  UseRowStateInstanceProps = interface
    property setRowState: procedure;
    property setCellState: procedure;
  end;

  UseRowStateRowProps = interface
    property state: UseRowStateLocalState<D>;
    property setState: procedure;
  end;

  UseRowStateCellProps = interface
    property state: UseRowStateLocalState<D>;
    property setState: procedure;
  end;

  UseRowUpdater = Variant;

  UseRowStateLocalState = Variant;

  procedure useSortBy(hooks: Hooks<D>);

  TableSortByToggleProps = interface
    property title: String;
    property style: CSSProperties;
    property onClick: procedure;
  end;

  UseSortByOptions = Variant;

  UseSortByHooks = interface
    property getSortByToggleProps: array of PropGetter<D, TableCommonProps>;
  end;

  UseSortByState = interface
    property sortBy: array of SortingRule<D>;
  end;

  UseSortByColumnOptions = Variant;

  UseSortByInstanceProps = interface
    property rows: array of Row<D>;
    property preSortedRows: array of Row<D>;
    property setSortBy: procedure;
    property toggleSortBy: procedure;
  end;

  UseSortByColumnProps = interface
    property canSort: Boolean;
    property toggleSortBy: procedure;
    property getSortByToggleProps: function: TableSortByToggleProps;
    property clearSortBy: procedure;
    property isSorted: Boolean;
    property sortedIndex: Float;
    property isSortedDesc: Boolean;
  end;

  OrderByFn = function: Float;

  SortByFn = function: Float;

  DefaultSortTypes = String;

  SortingRule = interface
    property id: IdType<D>;
    property desc: Boolean;
  end;

  ActionType = Variant;

  StringKey = Extract<Variant, String>;

  IdType = Variant;

  CellValue = V;

  Renderer = Variant;

  PluginHook = interface
    property pluginName: String;
  end;

  TableDispatch = procedure;

  function defaultOrderByFn(arr: array of Row<D>; funcs: array of OrderByFn<D>; dirs: array of Boolean): array of Row<D>;

  function defaultGroupByFn(rows: array of Row<D>; columnId: IdType<D>): Variant;

  function makePropGetter(hooks: Hooks; meta: array of Variant): Variant;

  function reduceHooks(hooks: Hooks; initial: T; args: array of Variant): T;

  procedure loopHooks(hooks: Hooks; args: array of Variant);

  procedure ensurePluginOrder(plugins: array of PluginHook<D>; befores: array of String; pluginName: String);

  function functionalUpdate(updater: Variant; old: TableState<D>): TableState<D>;

  function useGetLatest(obj: T): function: T;

  procedure safeUseLayoutEffect(effect: EffectCallback; deps?: DependencyList);

  procedure useMountedLayoutEffect(effect: EffectCallback; deps?: DependencyList);

  function useAsyncDebounce(defaultFn: F; defaultWait?: Float): F;

  function makeRenderer(instance: TableInstance; column: ColumnInstance; meta?: Variant): ReactElement;

implementation



end.
