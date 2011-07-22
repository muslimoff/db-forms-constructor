package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.ResultSet;
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
		// TODO только для фром из урл
		if (mainFormPane.isMasterForm() && mainFormPane.isFromUrl()) {
			cr.addCriteria(ConstructorApp.urlParamsCriteria);
		}
		String sortBy = request.getAttribute("sortBy");
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.fetch(mainFormPane.getInstanceIdentifier(), sortBy, startRow, endRow, Utils.getHashMapFromCriteria(cr), mainFormPane
				.isForceFetch(), new DSAsyncCallback<RowsArr>(requestId, response, this) {
			@Override
			public void onSuccess(RowsArr result) {
				SC.clearPrompt();
				Utils.debug(formCode + "...............DataSource: " + FormDataSource.this.getID() + " - before fetch...............");
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
			}
		});
	}

	// TODO При добавлении с АУТ-параметрами - исчезает запись.
	@Override
	protected void executeAdd(final String requestId, final DSRequest request, final DSResponse response) {
		DMLProcExecution addProcExec = new DMLProcExecution(mainFormPane) {
			@Override
			public void executeSuccessSubProc() {
				response.setData(new TreeNode[] { Utils.getTreeNodeFromRow(dsFields, this.getResultRow()) });
				processResponse(requestId, response);
				totalRows = totalRows + 1;
			}
		};
		// Retrieve record which should be added.
		Row newRow = Utils.getRowFromRecord(dsFields, new TreeNode(request.getData()));
		Row oldRow = null;
		addProcExec.executeGlobal(oldRow, newRow);
	}

	@Override
	protected void executeRemove(final String requestId, final DSRequest request, final DSResponse response) {
		DMLProcExecution removeProcExec = new DMLProcExecution(mainFormPane) {
			@Override
			public void executeSuccessSubProc() {
				// We do not receive removed record from server. Return record from request.
				response.setData(new ListGridRecord[] { new ListGridRecord(request.getData()) });
				processResponse(requestId, response);
				totalRows = totalRows - 1;
			}
		};
		// Retrieve record which should be removed.
		Row newRow = null;
		Row oldRow = Utils.getRowFromRecord(dsFields, new Record(request.getData()));
		removeProcExec.executeGlobal(oldRow, newRow);
	}

	@Override
	protected void executeUpdate(final String requestId, final DSRequest request, final DSResponse response) {
		final ListGrid lGrid = mainFormPane.getMainForm().getTreeGrid();

		DMLProcExecution updateProcExec = new DMLProcExecution(mainFormPane) {
			@Override
			public void executeSuccessSubProc() {
				System.out.println("executeUpdate.executeWarningSubProc");
				response.setData(new ListGridRecord[] { Utils.getTreeNodeFromRow(dsFields, getResultRow()) });
				try {
					ResultSet rs = lGrid.getResultSet();
					rs.setCriteria(new Criteria());
				} catch (Exception e) {
					e.printStackTrace();
				}
				processResponse(requestId, response);
				ListGridRecord selectedRec = lGrid.getRecord(mainFormPane.getSelectedRow());
				lGrid.selectRecord(selectedRec);
				int selectedRecIdx = lGrid.getRecordIndex(selectedRec);
				mainFormPane.filterDetailData(selectedRec, lGrid, selectedRecIdx);
			}

			@Override
			public void executeWarningSubProc() {
				System.out.println("executeUpdate.executeWarningSubProc");
			};
		};

		Record oldValues = request.getOldValues();
		Utils.debug("executeUpdate. oldRow");
		Row oldRow = (null != oldValues) ? Utils.getRowFromRecord(dsFields, oldValues) : null;

		Utils.debug("executeUpdate. newRow");
		Record listGridRec = new ListGridRecord(request.getData());
		listGridRec = lGrid.getEditedRecord(lGrid.getRecordIndex(listGridRec));
		Row newRow = Utils.getRowFromRecord(dsFields, listGridRec);

		Utils.debug("executeUpdate. updateProcExec.executeGlobal");
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
