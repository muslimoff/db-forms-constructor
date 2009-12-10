package com.abssoft.constructor.client.data;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.types.DSDataFormat;
import com.smartgwt.client.types.DSProtocol;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

/**
 * Для SQL-Lookups
 * 
 * @author User
 * 
 */
public class LookupDataSource extends DataSource {
	private String lookupCode;
	private LinkedHashMap<String, TreeNode> values = new LinkedHashMap<String, TreeNode>();
	FormTreeGridField[] gridFields;
	private FormDataSourceField[] dsFields;
	TreeNode[] records;
	String valueFieldName = null;
	String displayFieldName = null;
	int valueFieldNum = 0;
	private MainFormPane parentFormPane;

	public LookupDataSource(final String lookupCode, final MainFormPane parentFormPane) {
		this.setParentFormPane(parentFormPane);
		setLookupCode(lookupCode);
		setDataProtocol(DSProtocol.CLIENTCUSTOM);
		setDataFormat(DSDataFormat.CUSTOM);
		setClientOnly(false);
		setAttribute("dataProtocol", "clientCustom", false);

		QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
		service.getFormMetaData(ConstructorApp.sessionId, lookupCode, new DSAsyncCallback<FormMD>() {
			public void onSuccess(FormMD result) {
				final MainFormPane mfp = new MainFormPane();
				mfp.setFormCode(lookupCode);
				mfp.setFormMetadata(result);
				mfp.setFormColumns(new FormColumns(mfp));
				dsFields = mfp.getFormColumns().getDSFields();
				LookupDataSource.this.setFields(dsFields);
				gridFields = mfp.getFormColumns().getGridFields();
				boolean showPickListHeader = false;
				valueFieldName = gridFields[0].getName();
				for (FormTreeGridField f : gridFields) {
					FormColumnMD colMD = f.getColumn();
					String fieldName = f.getName();
					if ("1".equals(colMD.getLookupFieldType())) {
						valueFieldName = fieldName;
						valueFieldNum = f.getColNum();
					} else if ("2".equals(colMD.getLookupFieldType())) {
						f.setHidden(false);
						displayFieldName = fieldName;
					} else if ("Y".equals(colMD.getShowOnGrid())) {
						showPickListHeader = true;
					}
				}
				ArrayList<GridComboBoxItem> list = parentFormPane.getLookupComboboxes().get(lookupCode);
				for (int i = 0; i < list.size(); i++) {
					GridComboBoxItem comboBoxItem = list.get(i);
					System.out.println("%%%%%Combobox%%%%" + comboBoxItem + "; " + comboBoxItem.getForm());
					comboBoxItem.setOptionDataSource(LookupDataSource.this);
					comboBoxItem.setValueField(valueFieldName);
					comboBoxItem.setDisplayField(displayFieldName);

					if (showPickListHeader) {
						try {
							comboBoxItem.setPickListWidth(Integer.decode(result.getWidth()));
						} catch (Exception e) {
						}
						comboBoxItem.setPickListFields(gridFields);
					}
					System.out.println("valueFieldName:" + valueFieldName + "; displayFieldName:" + displayFieldName + " *"
							+ showPickListHeader);
					FormTreeGridField formTreeGridField = comboBoxItem.getFormTreeGridField();
					if (null != formTreeGridField) {
						formTreeGridField.setEditorType(comboBoxItem);
						// if
						//(!"3".equals(formTreeGridField.getColumn().getFieldType
						// ()))
						formTreeGridField.setCellFormatter(new CellFormatter() {
							@Override
							public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
								return values.containsKey(value) ? values.get(value).getAttribute(displayFieldName) : (String) value;
							}
						});
					}
				}
				DSRequest request = new DSRequest();
				String requestId = request.getRequestId();
				DSResponse response = new DSResponse();
				response.setAttribute("clientContext", request.getAttributeAsObject("clientContext"));
				response.setStatus(0);
				executeFetch(requestId, request, response);
			}
		});
	}

	/**
	 * Executes request to server.
	 * 
	 * @param request
	 *            <code>DSRequest</code> being processed.
	 * @return <code>Object</code> data from original request.
	 */
	@Override
	protected Object transformRequest(DSRequest request) {
		String requestId = request.getRequestId();
		DSResponse response = new DSResponse();
		response.setAttribute("clientContext", request.getAttributeAsObject("clientContext"));
		// Asume success
		response.setStatus(0);
		switch (request.getOperationType()) {
		case FETCH:
			executeFetch(requestId, request, response);
			break;
		default:
			Utils.debug("Unimplemented operaion: " + request.getOperationType());
			break;
		}
		return request.getData();
	}

	/**
	 * Executed on <code>FETCH</code> operation.
	 * <code>processResponse (requestId, response)</code> should be called when
	 * operation completes (either successful or failure).
	 * 
	 * @param requestId
	 *            <code>String</code> extracted from
	 *            <code>DSRequest.getRequestId ()</code>.
	 * @param request
	 *            <code>DSRequest</code> being processed.
	 * @param response
	 *            <code>DSResponse</code>. <code>setData (list)</code> should be
	 *            called on successful execution of this method.
	 *            <code>setStatus (&lt;0)</code> should be called on failure.
	 */
	protected void executeFetch(final String requestId, DSRequest request, final DSResponse response) {
		System.out.println("ReadOnlyDataSource Fetch. Lookup:" + getLookupCode());
		if (1 == 1 || 0 == values.size()) {
			Map<?, ?> filterValues = request.getCriteria().getValues();
			QueryServiceAsync service = GWT.create(QueryService.class);
			service.fetch(ConstructorApp.sessionId, getLookupCode(), -999, request.getSortBy(), 0, 1000, filterValues, false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							System.out.println("ReadOnlyDataSource Fetch.onSuccess. Lookup:" + getLookupCode());
							records = new TreeNode[result.size()];
							values.clear();
							for (int r = 0; r < result.size(); r++) {
								System.out.println("##" + result.get(r));
								try {
									Row row = result.get(r);
									records[r] = Utils.getListGridRecordFromRow(dsFields, row);
									values.put(row.get(valueFieldNum), records[r]);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
							response.setData(records);
							processResponse(requestId, response);
						}
					});

		} else {
			// response.setData(records);
			// processResponse(requestId, response);
		}
	}

	public String getValue(String key) {
		System.out.println("BBBBBBB " + key);
		return null; // values.get(key);
	}

	public void setLookupCode(String lookupCode) {
		this.lookupCode = lookupCode;
	}

	public String getLookupCode() {
		return lookupCode;
	}

	/**
	 * @param parentFormPane
	 *            the parentFormPane to set
	 */
	public void setParentFormPane(MainFormPane parentFormPane) {
		this.parentFormPane = parentFormPane;
	}

	/**
	 * @return the parentFormPane
	 */
	public MainFormPane getParentFormPane() {
		return parentFormPane;
	}

}
