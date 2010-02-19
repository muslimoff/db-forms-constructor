package com.abssoft.constructor.client.data;

import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.ActionStatus;
import com.google.gwt.core.client.GWT;
import com.google.gwt.core.client.JavaScriptObject;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.ResultSet;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

public class FormDataSource extends GwtRpcDataSource {

	private FormDataSourceField[] dsFields;
	private String formCode;
	private int gridHashCode;
	// Canvas c;

	private MainFormPane mainFormPane;

	private Integer totalRows;

	public FormDataSource() {
	}

	public FormDataSourceField[] getFormDSFields() {
		return dsFields;
	}

	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		this.dsFields = mainFormPane.getFormColumns().getDSFields();
		this.formCode = mainFormPane.getFormCode();
		System.out.println("setMainFormPane:" + formCode + "; ID:" + this.getID());
		setFields(dsFields);
	}

	/**
	 * @return the gridHashCode
	 */
	public int getGridHashCode() {
		return gridHashCode;
	}

	/**
	 * @param gridHashCode
	 *            the gridHashCode to set
	 */
	public void setGridHashCode(int gridHashCode) {
		this.gridHashCode = gridHashCode;
		// setID(formCode + "_" + gridHashCode);
		// Utils.debug("Datasource ID: " + getID());
	}

	@Override
	protected void executeFetch(final String requestId, final DSRequest request, final DSResponse response) {
		Utils.debug("DS Fetch:" + formCode + "; ID: " + this.getID());
		final Integer startRow = (null == request.getStartRow()) ? 0 : request.getStartRow();

		final Integer endRow = (null == request.getEndRow()) ? 1000 : request.getEndRow();
		Map<?, ?> filterValues;
		final ListGrid g = mainFormPane.getMainForm().getTreeGrid();
		if (g instanceof com.smartgwt.client.widgets.tree.TreeGrid) {
			Criteria treeCriteria = new Criteria();
			if (!mainFormPane.isForceFetch()) {
				int gridEventRow = (0 != g.getTotalRows()) ? g.getEventRow() : -2;
				if (-2 != gridEventRow) {
					treeCriteria = Utils.getCriteriaFromListGridRecord(g.getRecord(g.getEventRow()), formCode);
				}
			}
			treeCriteria.addCriteria(request.getCriteria());
			filterValues = treeCriteria.getValues();
		} else {
			filterValues = request.getCriteria().getValues();
		}
		// TODO request.getSortBy() не работает так, как описано. отписался в форуме
		String sortBy = request.getAttribute("sortBy");
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.fetch(ConstructorApp.sessionId, formCode, gridHashCode, sortBy, startRow, endRow, filterValues,
				mainFormPane.isForceFetch(), new DSAsyncCallback<RowsArr>(requestId, response, this) {
					public void onSuccess(RowsArr result) {
						Utils.debug(formCode + "...............DataSource: " + FormDataSource.this.getID()
								+ " - before fetch...............");
						ActionStatus.showActionStatus(result.getStatus());
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
						if (0 == startRow && 0 != rowsCount) {
							mainFormPane.setInitialFilter(Utils.getCriteriaFromListGridRecord(records[0], formCode));
							g.focus();
							g.selectRecord(0);
							mainFormPane.setCurrentGridRowSelected(0);
							// Refresh только для static detail
							mainFormPane.filterDetailData(g.getSelectedRecord(), g, 0, false, true, true);
							Utils.debug("mainFormPane.getValuesManager().getMembers().length="
									+ mainFormPane.getValuesManager().getMembers().length);
							if (0 != mainFormPane.getValuesManager().getMembers().length) {
								mainFormPane.getValuesManager().editRecord(records[0]);
							}

						}
						if (0 == rowsCount) {
							if (0 != mainFormPane.getValuesManager().getMembers().length) {
								mainFormPane.getValuesManager().editNewRecord();
							}
						}
						Utils.debug("...............DataSource: " + FormDataSource.this.getID() + " - after fetch...............");
					}
				});
	}

	@Override
	protected void executeAdd(final String requestId, final DSRequest request, final DSResponse response) {
		// Retrieve record which should be added.
		JavaScriptObject data = request.getData();
		TreeNode listGridRec = new TreeNode(data);
		Row newRow = Utils.getRowFromRecord(dsFields, listGridRec);
		Row oldRow = null;
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, oldRow, newRow, mainFormPane.getCurrentActionCode(),
				ClientActionType.ADD, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ActionStatus.showActionStatus(result.getStatus());
						if (!ActionStatus.StatusType.ERROR.equals(result.getStatus().getStatusType())) {
							TreeNode[] list = new TreeNode[1];
							list[0] = Utils.getTreeNodeFromRow(dsFields, result);
							response.setData(list);
							processResponse(requestId, response);
							totalRows = totalRows + 1;
						}
					}
				});
	}

	@Override
	protected void executeRemove(final String requestId, final DSRequest request, final DSResponse response) {
		// Retrieve record which should be removed.

		Row oldRow = Utils.getRowFromRecord(dsFields, new Record(request.getData()));
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, oldRow, null, mainFormPane.getCurrentActionCode(),
				ClientActionType.DEL, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ActionStatus.showActionStatus(result.getStatus());
						// We do not receive removed record from server. Return record from request.
						if (!ActionStatus.StatusType.ERROR.equals(result.getStatus().getStatusType())) {
							response.setData(new ListGridRecord[] { new ListGridRecord(request.getData()) });
							processResponse(requestId, response);
							totalRows = totalRows - 1;
						}
					}
				});
	}

	@Override
	protected void executeUpdate(final String requestId, final DSRequest request, final DSResponse response) {
		Row newRow = new Row();
		/***************************/
		for (String s : request.getAttributes()) {
			System.out.println("xx>>>>>>> " + s + ": " + request.getAttribute(s));
		}
		Record r1 = Record.getOrCreateRef(request.getData());
		for (String s2 : r1.getAttributes()) {
			System.out.println("zz>>>>>>> " + s2 + ": " + request.getAttribute(s2));
		}
		/***************************/
		Row oldRow = null;
		Record oldValues = request.getOldValues();
		if (null != oldValues) {
			oldRow = Utils.getRowFromRecord(dsFields, oldValues);
		}
		Canvas c = Canvas.getById(request.getComponentId());
		if (null != c) {
			if (c instanceof DynamicForm) {
				newRow = Utils.getRowFromFormFields(((DynamicForm) c).getFields());
			} else {
				ListGridRecord listGridRec = new ListGridRecord(request.getData());
				ListGrid grid = (ListGrid) c;
				int index = grid.getRecordIndex(listGridRec);
				listGridRec = (ListGridRecord) grid.getEditedRecord(index);
				newRow = Utils.getRowFromRecord(dsFields, listGridRec);
			}
		} else {
			ListGridRecord listGridRec = new ListGridRecord();
			JSOHelper.apply(request.getData(), listGridRec.getJsObj());
			newRow = Utils.getRowFromRecord(dsFields, listGridRec);
		}

		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, oldRow, newRow, mainFormPane.getCurrentActionCode(),
				ClientActionType.UPD, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ActionStatus.showActionStatus(result.getStatus());
						if (!ActionStatus.StatusType.ERROR.equals(result.getStatus().getStatusType())) {
							response.setData(new ListGridRecord[] { Utils.getTreeNodeFromRow(dsFields, result) });
							try {
								ResultSet rs = mainFormPane.getMainForm().getTreeGrid().getResultSet();
								rs.setCriteria(new Criteria());
							} catch (Exception e) {
								e.printStackTrace();
							}
							processResponse(requestId, response);
							ListGridRecord selectedRec = mainFormPane.getMainForm().getTreeGrid().getRecord(
									mainFormPane.getCurrentGridRowSelected());
							mainFormPane.getMainForm().getTreeGrid().selectRecord(selectedRec);
							int selectedRecIdx = mainFormPane.getMainForm().getTreeGrid().getRecordIndex(selectedRec);
							mainFormPane.filterDetailData(selectedRec, mainFormPane.getMainForm().getTreeGrid(), selectedRecIdx);
						}
					}
				});
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
