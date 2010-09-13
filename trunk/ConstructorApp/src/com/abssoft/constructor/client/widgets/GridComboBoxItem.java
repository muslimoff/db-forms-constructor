package com.abssoft.constructor.client.widgets;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

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
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FilterCriteriaFunction;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

//TODO Выести ширину лукапа как отдельную настройку формы (вместо FORM_WIDTH нужно LOOKUP_FORM_WIDTH)
//TODO - Отображать при выборке записи до текущей... остальные фетчить по требованию
//TODO - Завязать на Debug показку "Прочие" меню
public class GridComboBoxItem extends ComboBoxItem {
	private FormInstanceIdentifier instanceIdentifier;

	public class ComboBoxDataSource extends GwtRpcDataSource {
		private String lookupCode;
		private FormDataSourceField[] dsFields;
		TreeNode[] records;
		private int valueFieldNum = 0;
		private String lookupDisplValFld;

		public ComboBoxDataSource(String lookupCode, String lookupDisplValFld) {
			this.lookupCode = lookupCode;
			this.lookupDisplValFld = lookupDisplValFld;
		}

		protected void executeFetch(final String requestId, DSRequest request, final DSResponse response) {
			Utils.debug("ReadOnlyDataSource Fetch. Lookup:" + lookupCode + "; " + request);
			Criteria cr = new Criteria();
			try {
				cr.addCriteria(getMainFormCriteria());
				cr.addCriteria(request.getCriteria());
			} catch (Exception e) {
				Utils.debug("Exception on request.getCriteria().getValues():" + e.getMessage());
			}
			int startRow = 0;
			int endRow = 10000;
			String sortBy = null;
			if (null != lookupDisplValFld) {
				startRow = request.getStartRow();
				endRow = request.getEndRow();
			}
			sortBy = request.getAttribute("sortBy");
			System.out.println("startRow:" + startRow + "; endRow:" + endRow);
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

	public LinkedHashMap<Object, TreeNode> values = new LinkedHashMap<Object, TreeNode>();
	private String valueFieldName = null;
	private String displayFieldName = null;
	private String lookupDisplValFld;
	private MainFormPane mainFormPane;
	private FormColumnMD columnMD;

	public GridComboBoxItem(FormColumnMD columnMD, MainFormPane mainFormPane) {
		this(columnMD, mainFormPane, null);
	}

	public GridComboBoxItem(FormColumnMD columnMD, MainFormPane mainFormPane, FormTreeGridField formTreeGridField) {

		this.columnMD = columnMD;
		this.mainFormPane = mainFormPane;
		final String lookupCode = columnMD.getLookupCode();
		int gridHashCode = 10000 + GridComboBoxItem.this.columnMD.getDisplayNum();
		instanceIdentifier = new FormInstanceIdentifier(ConstructorApp.sessionId, lookupCode, null, gridHashCode);

		// this.formTreeGridField = formTreeGridField;

		lookupDisplValFld = columnMD.getLookupDisplayValue();
		GridComboBoxItem.this.setShowOptionsFromDataSource(true);
		this.setPickListFilterCriteriaFunction(new FilterCriteriaFunction() {
			public Criteria getCriteria() {
				return getMainFormCriteria();
			}
		});

		FormMD fmd = mainFormPane.getFormMetadata().getLookupsArr().get(lookupCode);
		final ComboBoxDataSource lookupDataSource = new ComboBoxDataSource(lookupCode, lookupDisplValFld);
		MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(fmd);
		mfp.setFormColumns(new FormColumns(mfp));
		FormTreeGridField[] gridFields = mfp.getFormColumns().createGridFields();
		// TODO Пока всегда отображаем шапку у лукапа
		boolean showPickListHeader = false;
		// boolean showPickListHeader = true;
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

			// Initial sort
			if ("1".equals(colMD.getDefaultOrderByNumber())) {
				GridComboBoxItem.this.setSortField(fieldName);
			}
		}
		GridComboBoxItem.this.setValueField(valueFieldName);
		GridComboBoxItem.this.setDisplayField(displayFieldName);
		{
			// TODO Всегда показывать заголовок для возможности пользовательской сортировки
			showPickListHeader = true;
		}
		if (showPickListHeader) {
			try {
				String lookupWidth = fmd.getLookupWidth();
				lookupWidth = (null == lookupWidth || "".equals(lookupWidth)) ? fmd.getWidth() : lookupWidth;
				GridComboBoxItem.this.setPickListWidth(Integer.decode(lookupWidth));
			} catch (Exception e) {
			}
			GridComboBoxItem.this.setPickListFields(gridFields);
		}
		lookupDataSource.setValueFieldNum(valueFieldNum);
		lookupDataSource.setFields(mfp.getFormColumns().createDSFields());
		setOptionDataSource(lookupDataSource);
		// TODO Вынести в классы FormTreeGridField и FormRowEditorTab.createItem
		if (null == formTreeGridField) {
			this.setFetchMissingValues(true);
			if (null != columnMD.getLookupDisplayValue()) {
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
								result = value.equals(rec.getAttribute(colName)) ? rec.getAttribute(GridComboBoxItem.this.columnMD
										.getLookupDisplayValue()) : result;
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
			this.setFetchMissingValues(null == lookupDisplValFld);
			formTreeGridField.setEditorType(GridComboBoxItem.this);
			formTreeGridField.setGridComboBoxItem(this);
			formTreeGridField.setAlign(Alignment.LEFT);
			if (null == lookupDisplValFld) {
				lookupDataSource.fetchData();
			}
			// TODO Сломалось редактирование в строках с лукапами по кнопке или контекстному меню.
			// TODO Иконки - лукап
			if (1 == 2 && "ICONS".equals(columnMD.getLookupCode())) {
				// this.setValueIcons(ConstructorApp.menus.getIcons());
				// this.setValueIcons(values);
				Map<String, String> m = new HashMap<String, String>();
				m.put("29", "/ConstructorApp/resources/icons/database_gear.png");
				this.setValueIcons(m);
			} else {
				formTreeGridField.setCellFormatter(new CellFormatter() {
					@Override
					public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
						String result = null;
						if (null != value) {
							if (null != lookupDisplValFld) {
								result = record.getAttribute(lookupDisplValFld);
							} else {
								// System.out.println(lookupCode + " >>>" + value + " <<>>" + value.getClass());
								value = (value instanceof Integer) ? ((Integer) value).doubleValue() : value;
								result = values.containsKey(value) ? values.get(value).getAttribute(displayFieldName) : value + "$";
							}
						}
						return result;
					}
				});
			}
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
		// System.out.println("############## lookupAttributes: " + lookupAttributes);
		return criteria;
	}
}
