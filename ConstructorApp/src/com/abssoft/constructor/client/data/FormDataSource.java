package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.ValuesManager;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeGrid;
import com.smartgwt.client.widgets.tree.TreeNode;

public class FormDataSource extends GwtRpcDataSource {

	private FormDataSourceField[] dsFields;
	private String formCode;
	// private String formTabCode;
	private int gridHashCode;
	private int editedRecordIndex = -1; // 20120319 Для масс-обновления...

	public int getEditedRecordIndex() {
		return editedRecordIndex;
	}

	public void setEditedRecordIndex(int editedRecordIndex) {
		this.editedRecordIndex = editedRecordIndex;
	}

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

		// try {
		// this.formTabCode = mainFormPane.getMainFormContainer().getTabMetaData().getTabCode();
		//
		// } catch (Exception e) {
		// this.formTabCode = e.getMessage();
		//
		// }

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
		// Utils.debug("ListGrid: " + grid);
		Criteria cr;
		// TODO Фильтры - передача на сервер так же строк вида "&field_name"="and field_name like 'Val%'"
		if (grid instanceof TreeGrid) {
			Criteria treeCriteria = new Criteria();
			if (!mainFormPane.isForceFetch()) {
				int gridEventRow = (0 != grid.getTotalRows()) ? grid.getEventRow() : -2;
				if (-2 != gridEventRow) {
					treeCriteria = Utils.getCriteriaFromListGridRecord2(mainFormPane, grid.getRecord(grid.getEventRow())
					// , formCode,formTabCode
							);
				}
			}
			cr = request.getCriteria();
			treeCriteria.addCriteria(cr);
			cr = treeCriteria;
		} else {
			cr = request.getCriteria();
		}
		// TODO только для форм из урл
		if ( // mainFormPane.isMasterForm()
		null == mainFormPane.getParentFormPane() && mainFormPane.isFromUrl()) {
			cr.addCriteria(ConstructorApp.urlParamsCriteria);
		}
		String sortBy = request.getAttribute("sortBy");
		Utils.createQueryService("FormDataSource.fetch").fetch(mainFormPane.getInstanceIdentifier(), sortBy, startRow, endRow,
				Utils.getHashMapFromCriteria(cr)//
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
						Utils.debug("BBBBBBBBBBBBBBBBBBBB>>>>>>" + mainFormPane.getFormCode());
						mainFormPane.getMainForm().getBottomToolBar().setRowsCount(totalRows + "");
						ValuesManager vm = mainFormPane.getValuesManager();
						int dynFormsCount = vm.getMembers().length;
						if (0 != rowsCount) {
							if (0 == startRow) {
								// Criteria thisFormCriteria = Utils.getCriteriaFromListGridRecord(mainFormPane, records[0]);
								// mainFormPane.setThisFormCriteria(thisFormCriteria);

								if ( // mainFormPane.isMasterForm()
								null == mainFormPane.getParentFormPane()) {
									// mainFormPane.isMasterForm();
									// grid.focus();
									mainFormPane.focus();
								}

								// 20130315 - Добавлена проверка выбранной ранее записи - для дерева актуально в случае развертывания узла.
								if (null == grid.getSelectedRecord()) {
									grid.selectRecord(0);
									mainFormPane.setSelectedRow(0);
									Utils.debug("FormDatasource.fetch. before mainFormPane.filterDetailData.1:" + grid.getSelectedRecord());
									// Refresh только для static detail
									mainFormPane.filterDetailData(records[0]// grid.getSelectedRecord()
											, grid, 0, false, true, true);
									Utils.debug("vm.getMembers().length=" + dynFormsCount + "; FormCode:" + mainFormPane.getFormCode());
									if (0 != dynFormsCount) {
										vm.editRecord(records[0]);
									}
								}

							}
							// if (mainFormPane.getMainForm().isExport) {
							// mainFormPane.getMainForm().exportData();
							// }
						} else {
							Utils.debug("FormDatasource.fetch. before mainFormPane.filterDetailData.2:");
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

		// ////////////////////////
		Record listGridRec = new TreeNode(request.getData());
		// int recordIndex = addProcExec.grid.getRecordIndex(listGridRec);
		// Utils.debug("executeAdd. recordIndex:" + recordIndex);
		// if (-1 == recordIndex && listGridRec.toMap().containsKey("_recIdx")) {
		// recordIndex = listGridRec.getAttributeAsInt("_recIdx");
		// }
		// listGridRec = addProcExec.grid.getEditedRecord(recordIndex);
		// addProcExec.setRecordIndex(recordIndex);
		// listGridRec.setAttribute("_recIdx", recordIndex);
		Utils.debugRecord(listGridRec, "listGridRec >>>>>>>>>>>>>>> 2");
		// /////////////////////

		Row newRow = Utils.getRowFromRecord(dsFields, listGridRec);
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

		Utils.debug("executeUpdate. oldRow");
		Record oldRecord = request.getOldValues();
		Utils.debugRecord(oldRecord, "oldRecord-1");
		Row oldRow = (null != oldRecord) ? Utils.getRowFromRecord(dsFields, oldRecord) : null;

		Utils.debug("executeUpdate. newRow");
		Record newRecord = new ListGridRecord(request.getData());
		Utils.debugRecord(newRecord, "newRecord-1");
		// Дополнение недостающими полями
		newRecord = Utils.getNewRecordWithOldValues(oldRecord, newRecord);
		Utils.debugRecord(newRecord, "newRecord-2");
		Row newRow = Utils.getRowFromRecord(dsFields, newRecord);

		// newRow = Utils.getEditedRow(dsFields, oldRow, newRow);

		Utils.debug("executeUpdate. updateProcExec.executeGlobal..");
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
