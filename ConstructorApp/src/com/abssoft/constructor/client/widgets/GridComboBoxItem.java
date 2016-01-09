package com.abssoft.constructor.client.widgets;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.TimeoutException;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemValueFormatter;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemCriteriaFunction;
import com.smartgwt.client.widgets.form.fields.FormItemFunctionContext;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

//TODO - Отображать при выборке записи до текущей... остальные фетчить по требованию
//TODO - Завязать на Debug показку "Прочие" меню
public class GridComboBoxItem extends MyComboBoxItem {
	private String userTypedValue = null;
	private String userSelectedValue = null;
	public static final String lookupUserTypedVarName = "p$lookup_entered_value"; // То,
																					// что
																					// вводит
																					// пользователь
																					// с
																					// клавиатуры
	public static final String lookupSelectedValueVarName = "p$lookup_selected_value"; // идентификатор
																						// того,
																						// что
																						// пользователь
																						// ввел/выбрал

	public class ComboBoxDataSource extends GwtRpcDataSource {
		private FormDataSourceField[] dsFields;
		TreeNode[] records;
		private int valueFieldNum = 0;

		protected void executeFetch(final String requestId, DSRequest request,
				final DSResponse response) throws TimeoutException {
			Utils.debug("ComboBoxDataSource.executeFetch 0. Lookup:"
					+ lookupCode + "; " + request);
			Criteria cr = (null != request && null != request.getCriteria()) ? request
					.getCriteria() : new Criteria();
			Utils.debug("ComboBoxDataSource.executeFetch 1");
			try {
				Utils.debug("ComboBoxDataSource.executeFetch 2");
				// cr.addCriteria(userTypedVarName, (String) userTypedValue);
				cr.addCriteria(getMainFormCriteria());
			} catch (Exception e) {
				Utils.debug("ComboBoxDataSource.executeFetch 3");
				Utils.debug("Exception on request.getCriteria().getValues():"
						+ e.getMessage());
			}

			int startRow = 0;
			int endRow = 1000;
			String sortBy = null;
			Utils.debug("ComboBoxDataSource.executeFetch 4");
			if (null != lookupDisplValFld && null != request) {
				Utils.debug("ComboBoxDataSource.executeFetch 5");
				try {
					Utils.debug("ComboBoxDataSource.executeFetch 6");
					startRow = request.getStartRow();
					endRow = request.getEndRow();
					Utils.debug("ComboBoxDataSource.executeFetch 7");
				} catch (Exception e) {
					Utils.debug("ComboBoxDataSource.executeFetch 8. request.getStartRow/getEndRow error: "
							+ e.getMessage());
				}
			}
			Utils.debug("ComboBoxDataSource.executeFetch 9; "
					+ getFilterWithValue());
			sortBy = request.getAttribute("sortBy");
			Utils.debug("ComboBoxDataSource.executeFetch 10:" + userTypedValue);
			LinkedHashMap<String, Object> crMap = Utils
					.getHashMapFromCriteria(cr);
			Utils.debug("ComboBoxDataSource.executeFetch 11");
			crMap.put(lookupUserTypedVarName, userTypedValue);
			Utils.debug("ComboBoxDataSource.executeFetch 12");
			crMap.put(lookupSelectedValueVarName, userSelectedValue);
			Utils.debug("ComboBoxDataSource.executeFetch 13");
			// TODO вынести в XML параметров endRow - фактически размер лова.
			Utils.createQueryService("GridComboBoxItem.fetch").fetch(
					instanceIdentifier, sortBy, startRow, endRow, crMap, false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							super.onSuccess(result);
							Utils.debug("ComboBoxDataSource.executeFetch 14");
							records = new TreeNode[result.size()];
							values.clear();
							Utils.debug("ComboBoxDataSource.executeFetch 15. valueFieldNum:"
									+ valueFieldNum
									+ "; result.size:"
									+ result.size());
							for (int r = 0; r < result.size(); r++) {
								try {
									Row row = result.get(r);
									records[r] = Utils.getTreeNodeFromRow(
											dsFields, row);
									Object key = row.get(valueFieldNum)
											.getAttributeAsObject();
									values.put(key, records[r]);
								} catch (Exception e) {
									Utils.debug("ComboBoxDataSource.executeFetch 16");
									e.printStackTrace();
								}
							}
							Utils.debug("ComboBoxDataSource.executeFetch 17");
							response.setTotalRows(result.getTotalRows());
							Utils.debug("ComboBoxDataSource.executeFetch 18");
							response.setData(records);
							Utils.debug("ComboBoxDataSource.executeFetch 19");
							try {
								Utils.debug("ComboBoxDataSource.executeFetch 20");
								processResponse(requestId, response);
								Utils.debug("ComboBoxDataSource.executeFetch 21");
							} catch (Exception e) {
								Utils.debug("ComboBoxDataSource.executeFetch 22");
								e.printStackTrace();
								Utils.debug(e.getMessage());
							}
							Utils.debug("ComboBoxDataSource.executeFetch 23. End of Fetch...");
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

	private String displayFieldName = null;
	private FormInstanceIdentifier instanceIdentifier;
	private String lookupCode;
	private String lookupDisplValFld;
	private String valueFieldName = null;
	public LinkedHashMap<Object, TreeNode> values = new LinkedHashMap<Object, TreeNode>();

	public GridComboBoxItem(FormColumnMD columnMD, MainFormPane mainFormPane) {
		this(columnMD, mainFormPane, null);
	}

	public GridComboBoxItem(final FormColumnMD parentColumnMD,
			final MainFormPane parentFormPane,
			FormTreeGridField formTreeGridField) {
		super(parentColumnMD, parentFormPane);
		this.parentColumnMD = parentColumnMD;
		this.parentFormPane = parentFormPane;
		lookupCode = parentColumnMD.getLookupCode();
		int gridHashCode = 10000 + GridComboBoxItem.this.parentColumnMD
				.getDisplayNum();
		instanceIdentifier = new FormInstanceIdentifier(
				ConstructorApp.sessionId, lookupCode,
				ConstructorApp.debugEnabled, true, false,
				this.parentFormPane.getFormCode(), null);
		instanceIdentifier.setGridHashCode(gridHashCode);
		lookupDisplValFld = parentColumnMD.getLookupDisplayValue();
		GridComboBoxItem.this.setShowOptionsFromDataSource(true);
		this.setFetchDelay(1000);
		this.setValidateOnChange(true);
		// TODO mm20120807 Посмотреть! - возможно пригодиццо при переделке
		// лукапов: this.setChangeOnKeypress(false);
		this.setRejectInvalidValueOnChange(true);
		this.setCompleteOnTab(true);
		// this.setHideEmptyPickList(true);
		FormMD fmd = parentFormPane.getFormMetadata().getLookupsArr()
				.get(instanceIdentifier.getKey());
		// Utils.debugAlert("GridComboBoxItem: "+fmd);
		final ComboBoxDataSource lookupDataSource = new ComboBoxDataSource();
		MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(fmd);
		mfp.setFormColumns(new FormColumns(mfp));
		FormTreeGridField[] gridFields = mfp.getFormColumns()
				.createGridFields();
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
		// try {
		// String lookupWidth = fmd.getLookupWidth();
		// lookupWidth = (null == lookupWidth || "".equals(lookupWidth)) ?
		// fmd.getWidth() : lookupWidth;
		// GridComboBoxItem.this.setPickListWidth(Integer.decode(lookupWidth));
		// String lookupHeight = fmd.getLookupHeight();
		// if (null != lookupHeight && !"".equals(lookupHeight)) {
		// GridComboBoxItem.this.setPickListHeight(Integer.decode(lookupHeight));
		// }

		// } catch (Exception e) {
		// }

		GridComboBoxItem.this.setLookupSize(parentColumnMD.getLookupWidth(),
				parentColumnMD.getLookupHeight(), fmd.getLookupWidth(),
				fmd.getLookupHeight());

		GridComboBoxItem.this.setPickListFields(gridFields);
		lookupDataSource.setValueFieldNum(valueFieldNum);
		lookupDataSource.setFields(mfp.getFormColumns().createDSFields());
		setOptionDataSource(lookupDataSource);

		// this.addDataArrivedHandler(new DataArrivedHandler() {
		//
		// @Override
		// public void onDataArrived(DataArrivedEvent event) {
		// // TODO Auto-generated method stub
		// Window.alert("onDataArrived(DataArrivedEvent:" + event);
		// }
		// });
		this.setPickListFilterCriteriaFunction(new FormItemCriteriaFunction() {

			@Override
			public Criteria getCriteria(FormItemFunctionContext itemContext) {
				// 11
				Criteria cr = getMainFormCriteria();
				// Criteria cr = new Criteria();
				// Добавляем введенные пользователем данные, если вводил
				// руками...
				Utils.debug("setPickListFilterCriteriaFunction 1");
				userTypedValue = null;
				userSelectedValue = null;
				// TODO - не работат... getFilterWithValue();
				Object internalEnteredValue = null;
				Object internalSelectedValue = null;
				// valueFieldName
				try {
					Utils.debug("setPickListFilterCriteriaFunction 2");
					internalEnteredValue = itemContext.getFormItem().getValue();
					// value = GridComboBoxItem.this.getValue();
					Utils.debug("setPickListFilterCriteriaFunction 3");
					ListGridRecord rec = new ComboBoxItem(itemContext
							.getFormItem().getJsObj()).getSelectedRecord();
					Utils.debug("setPickListFilterCriteriaFunction 4:" + rec
							+ "; displayedValue:" + internalEnteredValue);
					// 20120807 - Забанить фильтрацию по идентификатору. Или
					// наоборот добавить новую фильтрацию только по ID

					if (null != rec) {
						Utils.debug("setPickListFilterCriteriaFunction 5. rec:"
								+ rec.getAttribute(displayFieldName));
						internalEnteredValue = rec
								.getAttribute(displayFieldName);
						Utils.debug("setPickListFilterCriteriaFunction 6");
						internalSelectedValue = rec
								.getAttribute(valueFieldName);
						Utils.debug("setPickListFilterCriteriaFunction 7");
					}
				} catch (Exception e) {
					Utils.debug("setPickListFilterCriteriaFunction 8:"
							+ e.getMessage());
					// e.printStackTrace();
					ListGrid grid = parentFormPane.getMainForm().getTreeGrid();
					internalEnteredValue = grid.getEditedCell(
							grid.getEditRow(), parentColumnMD.getName());
					Utils.debug("setPickListFilterCriteriaFunction 9");
				}
				Utils.debug("setPickListFilterCriteriaFunction 10");
				userTypedValue = (null != internalEnteredValue) ? internalEnteredValue
						.toString() : null;
				Utils.debug("setPickListFilterCriteriaFunction 11");
				userSelectedValue = (null != internalSelectedValue) ? internalSelectedValue
						.toString() : null;
				Utils.debug("setPickListFilterCriteriaFunction 12. userTypedValue:"
						+ userTypedValue
						+ "; userSelectedValue:"
						+ userSelectedValue);
				return cr;
			}
		});

		// TODO Вынести в классы FormTreeGridField и FormRowEditorTab.createItem
		if (null == formTreeGridField) {
			this.setFetchMissingValues(true);
			if (null != lookupDisplValFld) {
				// b20121107
				this.setValueFormatter(new FormItemValueFormatter() {

					@Override
					public String formatValue(Object value, Record record,
							DynamicForm form, FormItem i) {
						// 20121107 String result = (String) value;
						String result = null == value ? null : ((String) value); // ""
																					// +
																					// value;
						try {
							int currRow = GridComboBoxItem.this.parentFormPane
									.getSelectedRow();
							ListGrid grig = GridComboBoxItem.this.parentFormPane
									.getMainForm().getTreeGrid();
							ListGridRecord rec = grig.getRecord(currRow);
							String colName = GridComboBoxItem.this.parentColumnMD
									.getName();
							if (null != value) {
								result = value.equals(rec.getAttribute(colName)) ? rec
										.getAttribute(lookupDisplValFld)
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
				// e20121107
				/*
				 * this.setEditorValueFormatter(new FormItemValueFormatter() {
				 * 
				 * @Override public String formatValue(Object value, Record
				 * record, DynamicForm form, FormItem i) { // 20121107 String
				 * result = (String) value; String result = null == value ? null
				 * : ((String) value); // "" + value; try { int currRow =
				 * GridComboBoxItem.this.mainFormPane.getSelectedRow(); ListGrid
				 * grig =
				 * GridComboBoxItem.this.mainFormPane.getMainForm().getTreeGrid
				 * (); ListGridRecord rec = grig.getRecord(currRow); String
				 * colName = GridComboBoxItem.this.columnMD.getName(); //
				 * System.out.println("##$@@" + result); if (null != value) {
				 * result = value.equals(rec.getAttribute(colName)) ?
				 * rec.getAttribute(lookupDisplValFld) : result; } else { result
				 * = null; } } catch (Exception e) {
				 * Utils.debug(e.getMessage()); e.printStackTrace(); } return
				 * result; } });
				 */
			}
		} else {
			//
			// this.setFetchMissingValues(null == lookupDisplValFld);
			this.setFetchMissingValues(true);
			formTreeGridField.setEditorProperties(GridComboBoxItem.this);
			formTreeGridField.setGridComboBoxItem(this);
			formTreeGridField.setAlign(Alignment.LEFT);
			// http://forums.smartclient.com/showthread.php?t=6427&highlight=pickList
			// formTreeGridField.addEditorEnterHandler(new EditorEnterHandler()
			// {
			// @Override
			// public void onEditorEnter(EditorEnterEvent event) {
			// LinkedHashMap<String, String> l = new LinkedHashMap<String,
			// String>();
			// l.put(event.getValue() + "", "sssssss");
			// // GridComboBoxItem.this.
			// setValueMap(l);
			// }
			// });
			if (null == lookupDisplValFld) {
				// !! lookupDataSource.fetchData();
				lookupDataSource.fetchData(null, null);
				formTreeGridField.setCellFormatter(new CellFormatter() {
					@Override
					public String format(Object value, ListGridRecord record,
							int rowNum, int colNum) {
						String result = null;
						if (null != value) {
							value = (value instanceof Integer) ? ((Integer) value)
									.doubleValue() : value;
							result = values.containsKey(value) ? values.get(
									value).getAttribute(displayFieldName)
									: value + "$";
						}
						return result;
					}
				});
			} else {
				// this.add
			}

			// TODO Сломалось редактирование в строках с лукапами по кнопке или
			// контекстному меню.
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

	@Override
	public String getDisplayFieldName() {
		return displayFieldName;
	}

	public LinkedHashMap<Object, TreeNode> getValues() {
		return values;
	}

	public Criteria getMainFormCriteria() {
		Utils.debug("getMainFormCriteria start");
		Record record = Utils
				.getEditedRecord(GridComboBoxItem.this.parentFormPane);
		Criteria criteria = Utils.getCriteriaFromListGridRecord2(
				GridComboBoxItem.this.parentFormPane, record
		// , "GridComboBoxItem:" + GridComboBoxItem.this.getName(), null
				);
		Map<String, String> lookupAttributes = parentColumnMD
				.getLookupAttributes();
		Iterator<String> attrs = lookupAttributes.keySet().iterator();
		while (attrs.hasNext()) {
			String attrName = attrs.next();
			criteria.addCriteria(attrName, lookupAttributes.get(attrName));
		}
		Utils.debug("getMainFormCriteria end");
		return criteria;
	}

	@Override
	public void onSelectValue(FormItem item, Record rec) {
		// TODO Auto-generated method stub
		Utils.createQueryService("GridComboBoxItem.closeForm")
				.closeFormInstance(instanceIdentifier,
						new DSAsyncCallback<Void>() {
							@Override
							public void onSuccess(Void result) {
							}
						});
	}

	@Override
	public void onClearValue(FormItem item) {
		// TODO Auto-generated method stub

	}

}
