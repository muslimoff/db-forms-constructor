package com.abssoft.constructor.client.widgets;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemValueFormatter;
import com.smartgwt.client.widgets.form.fields.FilterCriteriaFunction;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.EditorEnterEvent;
import com.smartgwt.client.widgets.grid.events.EditorEnterHandler;
import com.smartgwt.client.widgets.tree.TreeNode;

//TODO - Отображать при выборке записи до текущей... остальные фетчить по требованию
//TODO - Завязать на Debug показку "Прочие" меню
public class GridComboBoxItem extends MyComboBoxItem {
	public class ComboBoxDataSource extends GwtRpcDataSource {
		private FormDataSourceField[] dsFields;
		TreeNode[] records;
		private int valueFieldNum = 0;

		protected void executeFetch(final String requestId, DSRequest request, final DSResponse response) {
			Utils.debug("ReadOnlyDataSource Fetch. Lookup:" + lookupCode + "; " + request);
			Criteria cr = (null != request && null != request.getCriteria()) ? request.getCriteria() : new Criteria();
			try {
				cr.addCriteria(getMainFormCriteria());
			} catch (Exception e) {
				Utils.debug("Exception on request.getCriteria().getValues():" + e.getMessage());
			}
			int startRow = 0;
			int endRow = 1000;
			String sortBy = null;

			if (null != lookupDisplValFld && null != request) {
				try {
					startRow = request.getStartRow();
					endRow = request.getEndRow();
				} catch (Exception e) {
					Utils.debug("ComboBoxDataSource.executeFetch. request.getStartRow/getEndRow error: " + e.getMessage());
				}
			}

			System.out.println("aaaaaaaaaaaaaaaaaaaaaaaa>>>>>>>>>>>>>>>>>>>>>>>>>>" + getFilterWithValue());
			sortBy = request.getAttribute("sortBy");
			QueryServiceAsync service = GWT.create(QueryService.class);
			// TODO вынести в XML параметров endRow - фактически размер лова.
			service.fetch(instanceIdentifier, sortBy, startRow, endRow, Utils.getHashMapFromCriteria(cr), false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							records = new TreeNode[result.size()];
							values.clear();
							Utils.debug("LookupDataSource.fetch. valueFieldNum:" + valueFieldNum + "; result.size:" + result.size());
							for (int r = 0; r < result.size(); r++) {
								try {
									Row row = result.get(r);
									records[r] = Utils.getTreeNodeFromRow(dsFields, row);
									Object key = row.get(valueFieldNum).getAttributeAsObject();
									values.put(key, records[r]);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
							response.setTotalRows(result.getTotalRows());
							response.setData(records);
							try {
								processResponse(requestId, response);
							} catch (Exception e) {
								e.printStackTrace();
							}
							Utils.debug("LookupDataSource.fetch. ended...");
						}
					});
		}

		public int getValueFieldNum() {
			return valueFieldNum;
		}

		public void setFields(FormDataSourceField[] dsFields) {
			this.dsFields = dsFields;
			super.setFields(dsFields);
		}

		public void setValueFieldNum(int valueFieldNum) {
			this.valueFieldNum = valueFieldNum;
		}
	}

	private FormColumnMD columnMD;

	private String displayFieldName = null;
	private FormInstanceIdentifier instanceIdentifier;
	private String lookupCode;
	private String lookupDisplValFld;
	private MainFormPane mainFormPane;
	private String valueFieldName = null;
	public LinkedHashMap<Object, TreeNode> values = new LinkedHashMap<Object, TreeNode>();

	public GridComboBoxItem(FormColumnMD columnMD, MainFormPane mainFormPane) {
		this(columnMD, mainFormPane, null);
	}

	public GridComboBoxItem(final FormColumnMD columnMD, final MainFormPane mainFormPane, FormTreeGridField formTreeGridField) {

		this.columnMD = columnMD;
		this.mainFormPane = mainFormPane;
		lookupCode = columnMD.getLookupCode();
		int gridHashCode = 10000 + GridComboBoxItem.this.columnMD.getDisplayNum();
		instanceIdentifier = new FormInstanceIdentifier(ConstructorApp.sessionId, lookupCode, null, gridHashCode);
		lookupDisplValFld = columnMD.getLookupDisplayValue();
		GridComboBoxItem.this.setShowOptionsFromDataSource(true);
		this.setFetchDelay(1000);
		this.setValidateOnChange(true);
		this.setRejectInvalidValueOnChange(true);
		this.setCompleteOnTab(true);
		// this.setHideEmptyPickList(true);
		FormMD fmd = mainFormPane.getFormMetadata().getLookupsArr().get(lookupCode);
		final ComboBoxDataSource lookupDataSource = new ComboBoxDataSource();
		MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(fmd);
		mfp.setFormColumns(new FormColumns(mfp));
		FormTreeGridField[] gridFields = mfp.getFormColumns().createGridFields();
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
				f.setHidden(false);
			} else {
				f.setHidden(true);
			}
			// Initial sort
			if ("1".equals(colMD.getDefaultOrderByNumber())) {
				GridComboBoxItem.this.setSortField(fieldName);
			}
		}
		GridComboBoxItem.this.setValueField(valueFieldName);
		GridComboBoxItem.this.setDisplayField(displayFieldName);
		try {
			String lookupWidth = fmd.getLookupWidth();
			lookupWidth = (null == lookupWidth || "".equals(lookupWidth)) ? fmd.getWidth() : lookupWidth;
			GridComboBoxItem.this.setPickListWidth(Integer.decode(lookupWidth));
		} catch (Exception e) {
		}
		GridComboBoxItem.this.setPickListFields(gridFields);
		lookupDataSource.setValueFieldNum(valueFieldNum);
		lookupDataSource.setFields(mfp.getFormColumns().createDSFields());
		setOptionDataSource(lookupDataSource);
		this.setPickListFilterCriteriaFunction(new FilterCriteriaFunction() {
			@Override
			public Criteria getCriteria() {
				Criteria cr = getMainFormCriteria();
				// Добавляем введенные пользователем данные, если вводил руками...
				Utils.debug("1setPickListFilterCriteriaFunction");
				String userTypedValue = null;
				// TODO - не работат... getFilterWithValue();
				Object value = null;
				try {
					value = GridComboBoxItem.this.getValue();
				} catch (Exception e) {
					e.printStackTrace();
					ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
					value = grid.getEditedCell(grid.getEditRow(), columnMD.getName());
				}
				String userTypedVarName = "p$lookup_entered_value";
				userTypedValue = (null != value) ? value.toString() : null;
				cr.addCriteria(userTypedVarName, userTypedValue);
				Utils.debug("2setPickListFilterCriteriaFunction" + userTypedValue);
				return cr;
			}
		});
		// TODO Вынести в классы FormTreeGridField и FormRowEditorTab.createItem
		if (null == formTreeGridField) {
			this.setFetchMissingValues(true);
			if (null != lookupDisplValFld) {
				this.setEditorValueFormatter(new FormItemValueFormatter() {
					@Override
					public String formatValue(Object value, Record record, DynamicForm form, FormItem i) {
						String result = (String) value;
						try {
							int currRow = GridComboBoxItem.this.mainFormPane.getSelectedRow();
							ListGrid grig = GridComboBoxItem.this.mainFormPane.getMainForm().getTreeGrid();
							ListGridRecord rec = grig.getRecord(currRow);
							String colName = GridComboBoxItem.this.columnMD.getName();
							// System.out.println("##$@@" + result);
							if (null != value) {
								result = value.equals(rec.getAttribute(colName)) ? rec.getAttribute(lookupDisplValFld) : result;
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
			//
			this.setFetchMissingValues(null == lookupDisplValFld);
			// this.setFetchMissingValues(true);
			formTreeGridField.setEditorType(GridComboBoxItem.this);
			formTreeGridField.setGridComboBoxItem(this);
			formTreeGridField.setAlign(Alignment.LEFT);
			// http://forums.smartclient.com/showthread.php?t=6427&highlight=pickList
			// formTreeGridField.addEditorEnterHandler(new EditorEnterHandler() {
			// @Override
			// public void onEditorEnter(EditorEnterEvent event) {
			// // TODO Auto-generated method stub
			// LinkedHashMap<String, String> l = new LinkedHashMap<String, String>();
			// l.put(event.getValue() + "", "sssssss");
			// // GridComboBoxItem.this.
			// setValueMap(l);
			// }
			// });
			if (null == lookupDisplValFld) {
				lookupDataSource.fetchData();
				formTreeGridField.setCellFormatter(new CellFormatter() {
					@Override
					public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
						String result = null;
						if (null != value) {
							value = (value instanceof Integer) ? ((Integer) value).doubleValue() : value;
							result = values.containsKey(value) ? values.get(value).getAttribute(displayFieldName) : value + "$";
						}
						return result;
					}
				});
			}

			// TODO Сломалось редактирование в строках с лукапами по кнопке или контекстному меню.
			// TODO Иконки - лукап
			// if (1 == 2 && "ICONS".equals(columnMD.getLookupCode())) {
			// // this.setValueIcons(ConstructorApp.menus.getIcons());
			// // this.setValueIcons(values);
			// Map<String, String> m = new HashMap<String, String>();
			// m.put("29", "/ConstructorApp/resources/icons/database_gear.png");
			// this.setValueIcons(m);
			// }
		}
	}

	public Criteria getMainFormCriteria() {
		Utils.debug("FilterCriteriaFunction");
		Record record = Utils.getEditedRow(GridComboBoxItem.this.mainFormPane);
		Criteria criteria = Utils.getCriteriaFromListGridRecord(GridComboBoxItem.this.mainFormPane, record, "GridComboBoxItem:"
				+ GridComboBoxItem.this.getName());
		HashMap<String, String> lookupAttributes = columnMD.getLookupAttributes();
		Iterator<String> attrs = lookupAttributes.keySet().iterator();
		while (attrs.hasNext()) {
			String attrName = attrs.next();
			criteria.addCriteria(attrName, lookupAttributes.get(attrName));
		}
		return criteria;
	}
}
