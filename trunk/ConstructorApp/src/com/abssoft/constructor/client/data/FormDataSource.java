package com.abssoft.constructor.client.data;

import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.form.MainFormPane;
import com.google.gwt.core.client.GWT;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.ResultSet;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;

public class FormDataSource extends GwtRpcDataSource {

	private static void showActionStatus(String status) {
		if (null != status)
			Window.alert("Message from server: " + status);
	}

	private FormDataSourceField[] dsFields;
	private String formCode;
	private int gridHashCode;
	// Canvas c;

	private MainFormPane mainFormPane;

	private Integer totalRows;

	public FormDataSource(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		this.dsFields = mainFormPane.getFormColumns().getDSFields();
		this.formCode = mainFormPane.getFormCode();
		this.gridHashCode = mainFormPane.getMainForm().getHashCode();
		setFields(dsFields);
		setID(formCode + "_" + gridHashCode);
		Utils.debug("Datasource ID: " + getID());
	}

	@Override
	protected void executeAdd(final String requestId, final DSRequest request, final DSResponse response) {
		// Retrieve record which should be added.
		JavaScriptObject data = request.getData();
		ListGridRecord listGridRec = new ListGridRecord(data);
		Row newRow = Utils.getRowFromListGridRecord(dsFields, listGridRec);
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, newRow, mainFormPane.getCurrentActionCode(),
				ClientActionType.ADD, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ListGridRecord[] list = new ListGridRecord[1];
						list[0] = Utils.getListGridRecordFromRow(dsFields, result);
						response.setData(list);
						processResponse(requestId, response);
						showActionStatus(result.getServerMessage());
						totalRows = totalRows + 1;
					}
				});
	}

	@Override
	protected void executeFetch(final String requestId, final DSRequest request, final DSResponse response) {
		Utils.debug("DS Fetch");
		final Integer startRow = (null == request.getStartRow()) ? 0 : request.getStartRow();
		final Integer endRow = (null == request.getEndRow()) ? 1000 : request.getEndRow();
		Map<?, ?> filterValues;
		final ListGrid g = mainFormPane.getMainForm().getTreeGrid();
		if (g instanceof com.smartgwt.client.widgets.tree.TreeGrid) {
			Criteria treeCriteria = new Criteria();
			// Обработка Exception при g.getEventRow()
			// для дерева без замороженых столбцов
			// int gridEventRow = -2;
			// try {
			int gridEventRow = (0 != g.getTotalRows()) ? g.getEventRow() : -2;
			// } catch (Exception e) {
			// Utils.logException(e, "DS - g.getEventRow()");
			// }
			if (-2 != gridEventRow) {
				treeCriteria = Utils.getCriteriaFromListGridRecord(g.getRecord(g.getEventRow()), formCode);
			}
			treeCriteria.addCriteria(request.getCriteria());
			filterValues = treeCriteria.getValues();
		} else {
			filterValues = request.getCriteria().getValues();
		}
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.fetch(ConstructorApp.sessionId, formCode, gridHashCode, request.getSortBy(), startRow, endRow, filterValues,
				new DSAsyncCallback<RowsArr>(requestId, response, this) {
					public void onSuccess(RowsArr result) {
						Utils.debug("...............DataSource: " + FormDataSource.this.getID() + " - before fetch...............");
						showActionStatus(result.getStatus());
						int rowsCount = result.size();
						ListGridRecord[] records = new ListGridRecord[rowsCount];
						Utils.debug("service.fetch. rowsCount: " + rowsCount);
						for (int r = 0; r < rowsCount; r++) {
							try {
								Row row = result.get(r);
								records[r] = Utils.getListGridRecordFromRow(dsFields, row);
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
	protected void executeRemove(final String requestId, final DSRequest request, final DSResponse response) {
		// Retrieve record which should be removed.
		JavaScriptObject data = request.getData();
		final ListGridRecord listGridRec = new ListGridRecord(data);
		Row removedRec = Utils.getRowFromListGridRecord(dsFields, listGridRec);
		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, removedRec, mainFormPane.getCurrentActionCode(),
				ClientActionType.DEL, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ListGridRecord[] list = new ListGridRecord[1];
						// We do not receive removed record from server.
						// Return record from request.
						list[0] = listGridRec;
						response.setData(list);
						processResponse(requestId, response);
						totalRows = totalRows - 1;
						showActionStatus(result.getServerMessage());
					}
				});
	}

	@Override
	protected void executeUpdate(final String requestId, final DSRequest request, final DSResponse response) {
		Row changedRow = new Row();
		Canvas c = Canvas.getById(request.getComponentId());
		if (null != c) {
			if (c instanceof DynamicForm) {
				changedRow = Utils.getRowFromFormFields(((DynamicForm) c).getFields());
			} else {
				ListGridRecord listGridRec = new ListGridRecord(request.getData());
				ListGrid grid = (ListGrid) c;
				int index = grid.getRecordIndex(listGridRec);
				listGridRec = (ListGridRecord) grid.getEditedRecord(index);
				changedRow = Utils.getRowFromListGridRecord(dsFields, listGridRec);
			}
		} else {
			ListGridRecord listGridRec = new ListGridRecord();
			JSOHelper.apply(request.getData(), listGridRec.getJsObj());
			changedRow = Utils.getRowFromListGridRecord(dsFields, listGridRec);
		}

		QueryServiceAsync service = GWT.create(QueryService.class);
		service.executeDML(ConstructorApp.sessionId, formCode, gridHashCode, changedRow, mainFormPane.getCurrentActionCode(),
				ClientActionType.UPD, new DSAsyncCallback<Row>(requestId, response, this) {
					public void onSuccess(Row result) {
						ListGridRecord[] list = new ListGridRecord[1];
						ListGridRecord updRec = Utils.getListGridRecordFromRow(dsFields, result);
						list[0] = updRec;
						System.out.println(result);
						response.setData(list);
						ResultSet rs = mainFormPane.getMainForm().getTreeGrid().getResultSet();
						System.out.println("zz " + rs.getCriteria().getValues());
						rs.setCriteria(new Criteria());
						processResponse(requestId, response);
						showActionStatus(result.getServerMessage());
						mainFormPane.getMainForm().getTreeGrid().selectRecord(mainFormPane.getCurrentGridRowSelected());
						((MainFormPane.FormValuesManager) mainFormPane.getValuesManager()).editRecord2(updRec);
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
