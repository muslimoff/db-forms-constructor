package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.ValuesManager;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

public class FormDataSource extends GwtRpcDataSource {

	private FormDataSourceField[] dsFields;
	private String formCode;
	private int gridHashCode;

	private MainFormPane mainFormPane;

	private Integer totalRows;

	public FormDataSource() {
	}

	public FormDataSourceField[] getFormDSFields() {
		return dsFields;
	}

	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		this.dsFields = mainFormPane.getFormColumns().createDSFields();
		this.formCode = mainFormPane.getFormCode();
		this.gridHashCode = mainFormPane.getInstanceIdentifier().getGridHashCode();
		System.out.println("setMainFormPane:" + formCode + "; ID:" + this.getID());
		setFields(dsFields);
	}

	/**
	 * @return the gridHashCode
	 */
	public int getGridHashCode() {
		return gridHashCode;
	}

	// TODO !!!!!! переделать executeFetch на DMLProcExecution
	@Override
	protected void executeFetch(final String requestId, final DSRequest request, final DSResponse response) {
		Utils.debug("........DS Fetch:" + formCode + "; ID: " + this.getID());
		final Integer startRow = (null == request.getStartRow()) ? 0 : request.getStartRow();
		final Integer endRow = (null == request.getEndRow()) ? 1000 : request.getEndRow();
		final ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		Utils.debug("ListGrid: " + grid);

		Criteria cr;
		// TODO Фильтры - передача на сервер так же строк вида "&field_name"="and field_name like 'Val%'"
		if (grid instanceof com.smartgwt.client.widgets.tree.TreeGrid) {
			Criteria treeCriteria = new Criteria();
			if (!mainFormPane.isForceFetch()) {
				int gridEventRow = (0 != grid.getTotalRows()) ? grid.getEventRow() : -2;
				if (-2 != gridEventRow) {
					treeCriteria = Utils.getCriteriaFromListGridRecord(mainFormPane, grid.getRecord(grid.getEventRow()), formCode);
				}
			}
			cr = request.getCriteria();
			treeCriteria.addCriteria(cr);
			cr = treeCriteria;
		} else {
			cr = request.getCriteria();
		}
		// TODO только для форм из урл
		if (mainFormPane.isMasterForm() && mainFormPane.isFromUrl()) {
			cr.addCriteria(ConstructorApp.urlParamsCriteria);
		}
		String sortBy = request.getAttribute("sortBy");
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.fetch(mainFormPane.getInstanceIdentifier(), sortBy, startRow, endRow, Utils.getHashMapFromCriteria(cr)//
				, mainFormPane.isForceFetch(), new DSAsyncCallback<RowsArr>(requestId, response, this) {
					@Override
					public void onSuccess(RowsArr result) {
						SC.clearPrompt();
						Utils.debug(formCode + "...............DataSource: " + FormDataSource.this.getID()
								+ " - before fetch...............");
						result.getStatus().showActionStatus();
						int rowsCount = result.size();
						ListGridRecord[] records = new ListGridRecord[rowsCount];
						Utils.debug("service.fetch. rowsCount: " + rowsCount);
						for (int r = 0; r < rowsCount; r++) {
							try {
								Row row = result.get(r);
								records[r] = Utils.getTreeNodeFromRow(dsFields, row);
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						totalRows = result.getTotalRows();
						response.setTotalRows(totalRows);
						response.setData(records);
						processResponse(requestId, response);
						mainFormPane.getMainForm().getBottomToolBar().setRowsCount(totalRows + "");
						ValuesManager vm = mainFormPane.getValuesManager();
						int dynFormsCount = vm.getMembers().length;
						if (0 != rowsCount) {
							if (0 == startRow) {
								mainFormPane.setInitialFilter(Utils.getCriteriaFromListGridRecord(mainFormPane, records[0], formCode));
								if (mainFormPane.isMasterForm()) {
									grid.focus();
								}
								grid.selectRecord(0);
								mainFormPane.setSelectedRow(0);
								// Refresh только для static detail
								mainFormPane.filterDetailData(grid.getSelectedRecord(), grid, 0, false, true, true);
								Utils.debug("vm.getMembers().length=" + dynFormsCount);
								if (0 != dynFormsCount) {
									vm.editRecord(records[0]);
								}

							}
							// if (mainFormPane.getMainForm().isExport) {
							// mainFormPane.getMainForm().exportData();
							// }
						} else {
							mainFormPane.filterDetailData(null, grid, -1);
							if (0 != dynFormsCount) {
								vm.editNewRecord();
							}
						}

						Utils.debug("...............DataSource: " + FormDataSource.this.getID() + " - after fetch...............");
						// В случае наличия ActionURL - открываем ее.
						FormActionMD formActionMD = mainFormPane.getCurrentAction();
						Utils.openURL(formActionMD, grid.getSelectedRecord(), mainFormPane);

					}
				});
	}

	// TODO При добавлении с АУТ-параметрами - исчезает запись.
	@Override
	protected void executeAdd(final String requestId, final DSRequest request, final DSResponse response) {
		Utils.debug("executeAdd1");
		DMLProcExecution addProcExec = new DMLProcExecution(DMLProcExecution.ExecutionType.ADD, this, mainFormPane, request, response);
		Utils.debug("executeAdd2");
		Row newRow = Utils.getRowFromRecord(dsFields, new TreeNode(request.getData()));
		Utils.debug("executeAdd3");
		Row oldRow = null;
		Utils.debug("executeAdd4");
		addProcExec.executeGlobal(oldRow, newRow);
		Utils.debug("executeAdd5");
	}

	@Override
	protected void executeRemove(final String requestId, final DSRequest request, final DSResponse response) {
		DMLProcExecution removeProcExec = new DMLProcExecution(DMLProcExecution.ExecutionType.DELETE, this, mainFormPane, request, response);
		Row newRow = null;
		Row oldRow = Utils.getRowFromRecord(dsFields, new Record(request.getData()));
		removeProcExec.executeGlobal(oldRow, newRow);
	}

	@Override
	protected void executeUpdate(final String requestId, final DSRequest request, final DSResponse response) {
		Utils.debug("executeUpdate1");
		// final ListGrid lGrid = mainFormPane.getMainForm().getTreeGrid();
		DMLProcExecution updateProcExec = new DMLProcExecution(DMLProcExecution.ExecutionType.UPDATE, this, mainFormPane, request, response) {
			@Override
			public void executeSuccessSubProc() {
				super.executeSuccessSubProc();
				// TODO Зачем делаем rs.setCriteria ?? Не помню. Может попытка побороть исчезновение записией?
				// 20110730 - попробовал убрать на...
				// try {
				// ResultSet rs = lGrid.getResultSet();
				// rs.setCriteria(new Criteria());
				// } catch (Exception e) {
				// e.printStackTrace();
				// }
				// 20110808 - перенес в DMLProcExecution - после success/warning/error subproc
				// ListGridRecord selectedRec = grid.getRecord(mainFormPane.getSelectedRow());
				// grid.selectRecord(selectedRec);
				// int selectedRecIdx = grid.getRecordIndex(selectedRec);
				// mainFormPane.filterDetailData(selectedRec, grid, selectedRecIdx);
			}
		};

		Record oldValues = request.getOldValues();
		Utils.debug("executeUpdate. oldRow");
		Row oldRow = (null != oldValues) ? Utils.getRowFromRecord(dsFields, oldValues) : null;

		Utils.debug("executeUpdate. newRow");
		Record listGridRec = new ListGridRecord(request.getData());
		int recordIndex = updateProcExec.grid.getRecordIndex(listGridRec);
		listGridRec = updateProcExec.grid.getEditedRecord(recordIndex);
		Row newRow = Utils.getRowFromRecord(dsFields, listGridRec);
		// Сохранение порядкового номера ListGridRecord для корректной передачи аттрибутов статуса действия
		updateProcExec.setRecordIndex(recordIndex);
		Utils.debug("executeUpdate. updateProcExec.executeGlobal.. recordIndex:" + recordIndex);
		updateProcExec.executeGlobal(oldRow, newRow);
	}

	/**
	 * @return the totalRows
	 */
	public Integer getTotalRows() {
		return totalRows;
	}

	/**
	 * @param totalRows
	 *            the totalRows to set
	 */
	public void setTotalRows(Integer totalRows) {
		this.totalRows = totalRows;
	}
}
