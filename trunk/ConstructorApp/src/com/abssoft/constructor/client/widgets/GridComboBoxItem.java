package com.abssoft.constructor.client.widgets;

import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.DSDataFormat;
import com.smartgwt.client.types.DSOperationType;
import com.smartgwt.client.types.DSProtocol;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemValueFormatter;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FilterCriteriaFunction;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

public class GridComboBoxItem extends ComboBoxItem {
	public class LookupDataSource extends DataSource {
		private String lookupCode;
		public LinkedHashMap<String, TreeNode> values = new LinkedHashMap<String, TreeNode>();
		private FormDataSourceField[] dsFields;
		TreeNode[] records;
		private int valueFieldNum = 0;
		private String lookupDisplValFld;

		public int getValueFieldNum() {
			return valueFieldNum;
		}

		public void setValueFieldNum(int valueFieldNum) {
			this.valueFieldNum = valueFieldNum;
		}

		public void setFields(FormDataSourceField[] dsFields) {
			this.dsFields = dsFields;
			super.setFields(dsFields);
		}

		public LookupDataSource(final String lookupCode, String lookupDisplValFld) {
			this.lookupCode = lookupCode;
			this.lookupDisplValFld = lookupDisplValFld;
			setDataProtocol(DSProtocol.CLIENTCUSTOM);
			setDataFormat(DSDataFormat.CUSTOM);
			setClientOnly(false);
			setAttribute("dataProtocol", "clientCustom", false);
		}

		public DSRequest transformRequest(DSRequest request, final Boolean isInitialFetch) {
			String requestId = request.getRequestId();
			DSResponse response = new DSResponse();
			response.setAttribute("clientContext", request.getAttributeAsObject("clientContext"));
			response.setStatus(0);
			if (DSOperationType.FETCH.equals(request.getOperationType())) {
				executeFetch(requestId, request, response, isInitialFetch);
			}
			return request;
		}

		@Override
		protected Object transformRequest(DSRequest request) {
			DSRequest req = transformRequest(request, false);
			return req.getData();
		}

		public void initialFetch() {
			DSRequest request = new DSRequest();
			request.setOperationType(DSOperationType.FETCH);
			transformRequest(request, true);
		}

		protected void executeFetch(final String requestId, DSRequest request, final DSResponse response, final Boolean isInitialFetch) {
			Utils.debug("ReadOnlyDataSource Fetch. Lookup:" + lookupCode);
			Map<?, ?> filterValues = (new Criteria()).getValues();
			try {
				filterValues = request.getCriteria().getValues();
			} catch (Exception e) {
				Utils.debug("Exception on request.getCriteria().getValues():" + e.getMessage());
			}
			int startRow = 0;
			int endRow = 10000;
			// TODO request.getSortBy() не работает так, как описано.
			String sortBy = null;
			try {
				if (null != lookupDisplValFld) {
					startRow = request.getStartRow();
					endRow = request.getEndRow();
				}
				sortBy = request.getAttribute("sortBy");
			} catch (Exception e) {
				Utils.debug("Exception on request.getAttribute(\"sortBy\"):" + e.getMessage());
				e.printStackTrace();
			}
			System.out.println("startRow:" + startRow + "; endRow:" + endRow);
			QueryServiceAsync service = GWT.create(QueryService.class);
			// TODO вынести в XML параметров endRow - фактически размер лова.
			service.fetch(ConstructorApp.sessionId, lookupCode, -999, sortBy, startRow, endRow, filterValues, false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							records = new TreeNode[result.size()];
							values.clear();
							Utils.debug("LookupDataSource.fetch. valueFieldNum:" + valueFieldNum + "; result.size:" + result.size());
							for (int r = 0; r < result.size(); r++) {
								try {
									Row row = result.get(r);
									records[r] = Utils.getTreeNodeFromRow(dsFields, row);
									values.put(row.get(valueFieldNum).getAttribute(), records[r]);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
							if (!isInitialFetch) {
								Utils.debug("LookupDataSource.fetch. response.setTotalRows...");
								response.setTotalRows(result.getTotalRows());
								Utils.debug("LookupDataSource.fetch. response.setData...");
								response.setData(records);
								Utils.debug("LookupDataSource.fetch. processResponse...");
								try {
									processResponse(requestId, response);
								} catch (Exception e) {
									e.printStackTrace();
								}
								Utils.debug("LookupDataSource.fetch. ended...");
							}
						}
					});
		}
	}

	private String valueFieldName = null;
	private String displayFieldName = null;
	private LookupDataSource lookupDataSource;
	private String lookupDisplValFld;

	public GridComboBoxItem(FormColumnMD columnMD, MainFormPane mainFormPane) {
		this(columnMD, mainFormPane, null);
	}

	public GridComboBoxItem(final FormColumnMD columnMD, final MainFormPane mainFormPane, final FormTreeGridField formTreeGridField) {
		String lookupCode = columnMD.getLookupCode();
		lookupDisplValFld = columnMD.getLookupDisplayValue();
		this.setFetchMissingValues(null == lookupDisplValFld);
		GridComboBoxItem.this.setShowOptionsFromDataSource(true);
		this.setPickListFilterCriteriaFunction(new FilterCriteriaFunction() {
			public Criteria getCriteria() {
				Record record = Utils.getEditedRow(mainFormPane);
				Criteria criteria = Utils.getCriteriaFromListGridRecord(record, "GridComboBoxItem:" + GridComboBoxItem.this.getName());
				return criteria;
			}
		});

		FormMD fmd = mainFormPane.getFormMetadata().getLookupsArr().get(lookupCode);
		lookupDataSource = new LookupDataSource(lookupCode, lookupDisplValFld);
		MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(fmd);
		mfp.setFormColumns(new FormColumns(mfp));
		FormTreeGridField[] gridFields = mfp.getFormColumns().createGridFields();
		boolean showPickListHeader = false;
		valueFieldName = gridFields[0].getName();
		int valueFieldNum = 0;
		for (FormTreeGridField f : gridFields) {
			FormColumnMD colMD = f.getColumnMD();
			String fieldName = f.getName();
			String lookupFieldType = colMD.getLookupFieldType();
			if ("1".equals(lookupFieldType)) {
				valueFieldName = fieldName;
				valueFieldNum = f.getColNum();
			} else if ("2".equals(lookupFieldType)) {
				f.setHidden(false);
				displayFieldName = fieldName;
			} else if ("3".equals(lookupFieldType)) {
				showPickListHeader = true;
				f.setHidden(false);
			} else {
				f.setHidden(true);
			}
		}
		GridComboBoxItem.this.setValueField(valueFieldName);
		GridComboBoxItem.this.setDisplayField(displayFieldName);
		if (showPickListHeader) {
			try {
				GridComboBoxItem.this.setPickListWidth(Integer.decode(fmd.getWidth()));
			} catch (Exception e) {
			}
			GridComboBoxItem.this.setPickListFields(gridFields);
		}
		lookupDataSource.setValueFieldNum(valueFieldNum);
		lookupDataSource.setFields(mfp.getFormColumns().createDSFields());
		GridComboBoxItem.this.setOptionDataSource(lookupDataSource);
		if (null == formTreeGridField) {
			if (null != columnMD.getLookupDisplayValue()) {
				this.setEditorValueFormatter(new FormItemValueFormatter() {

					@Override
					public String formatValue(Object value, Record record, DynamicForm form, FormItem i) {
						String result = (String) value;
						try {
							int currRow = mainFormPane.getCurrentGridRowSelected();
							ListGrid grig = mainFormPane.getMainForm().getTreeGrid();
							ListGridRecord rec = grig.getRecord(currRow);
							String colName = columnMD.getName();
							System.out.println("##$@@" + result);
							if (null != value) {
								result = value.equals(rec.getAttribute(colName)) ? rec.getAttribute(columnMD.getLookupDisplayValue())
										: result;
							} else {
								result = null;
							}
						} catch (Exception e) {
							Utils.debug(e.getMessage());
							e.printStackTrace();
						}
						return result;
					}
				});
			}
		} else {
			formTreeGridField.setEditorType(GridComboBoxItem.this);
			formTreeGridField.setGridComboBoxItem(this);
			formTreeGridField.setCellFormatter(new CellFormatter() {
				@Override
				public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
					// TODO Поле для отображения
					String result = null;
					if (null != value) {
						if (null != lookupDisplValFld) {
							result = record.getAttribute(lookupDisplValFld);
						} else {
							result = lookupDataSource.values.containsKey(value) ? lookupDataSource.values.get(value).getAttribute(
									displayFieldName) : value + "";
						}
					}
					return result;
				}
			});
		}

	}

	public void initialFetch() {
		if (null == lookupDisplValFld)
			lookupDataSource.initialFetch();
	}
}
