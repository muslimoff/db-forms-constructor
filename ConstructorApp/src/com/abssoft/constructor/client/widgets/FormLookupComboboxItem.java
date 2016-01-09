package com.abssoft.constructor.client.widgets;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.Constants;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.TimeoutException;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.FormColumnLookupMappingMD;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemCriteriaFunction;
import com.smartgwt.client.widgets.form.fields.FormItemFunctionContext;
import com.smartgwt.client.widgets.tree.TreeNode;

//TODO 20130805
//1+. Меппинг лукап - поля грида. Решил, что всегда нужно делать явный меппинг
//2+. В меппинге - флаг "Показывать", + поле "DisplayField"
//3+. При очистке поля лукапа - очищать все смепленные поля
//4+. После выбора значения лукапа - вызывать действие по событию "после выхода из списка". Возможно перенести в MyComboboxItem
//		см. onRecordSelected
//5+. не работает invalidateCashe. при первом наборе строки поиска фильтруется нормально
//6-. Освободить на сервере память (кеш) после выбора из списка
//7+. Для новых записей не работает. См. MainFormPane.setEditValues (putAll)
//8-. Не работает переопределение порядка столбцов
public class FormLookupComboboxItem extends MyComboBoxItem {
	public static final String lookupUserTypedVarName = "p$lookup_entered_value"; // То,
																					// что
																					// вводит
																					// пользователь
																					// с
																					// клавиатуры
	// public static final String lookupSelectedValueVarName =
	// "p$lookup_selected_value"; // идентификатор того, что пользователь
	// ввел/выбрал

	private FormInstanceIdentifier instanceIdentifier;
	private String lookupCode;
	private ComboBoxDataSource lookupDataSource = new ComboBoxDataSource();
	// private DataSource lookupDataSource;
	private FormMD lookupFormMD;

	// implements JsObject
	public class ComboBoxDataSource extends GwtRpcDataSource {
		private FormDataSourceField[] dsFields;

		protected void executeFetch(final String requestId, DSRequest request,
				final DSResponse response) throws TimeoutException {
			Utils.debug("FormLookupComboboxItem.ComboBoxDataSource.executeFetch 1");

			Criteria cr = getDSRequestCriteria(request);
			int startRow = request.getStartRow();
			int endRow = request.getEndRow();
			String sortBy = request.getAttribute("sortBy");

			LinkedHashMap<String, Object> crMap = Utils
					.getHashMapFromCriteria(cr);
			Utils.createQueryService("GridComboBoxItem.fetch").fetch(
					instanceIdentifier, sortBy, startRow, endRow, crMap, false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							super.onSuccess(result);
							TreeNode[] records = new TreeNode[result.size()];
							for (int r = 0; r < result.size(); r++) {
								try {
									Row row = result.get(r);
									records[r] = Utils.getTreeNodeFromRow(
											dsFields, row);
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
								Utils.debug(e.getMessage());
							}
						}
					});
		}

		public void setFields(FormDataSourceField[] dsFields) {
			this.dsFields = dsFields;
			super.setFields(dsFields);
		}
	}

	// Отрабатывает в момент запроса (ComboBoxDataSource.executeFetch)
	public Criteria getDSRequestCriteria(DSRequest request) {
		Criteria cr = getMainFormCriteria(parentFormPane);
		// try {
		if (null != request && null != request.getCriteria()) {
			cr.addCriteria(request.getCriteria());
		}
		// } catch (Exception e) {}
		return cr;
	}

	// Отрабатывает после набора части наименования в поле
	public Criteria getPickListFilterCriteria(
			FormItemFunctionContext itemContext) {
		Utils.debug("FormLookupComboboxItem.getPickListFilterCriteria start");
		Criteria cr = getMainFormCriteria(parentFormPane);

		// Object value = getValue();// Для грида не работает корректно. нужно
		// всегда itemContext
		Object value = itemContext.getFormItem().getValue();
		String strValue = (null != value) ? value.toString() : null;

		// Для совместимости с разработанными ранее лукапами:
		// lookupUserTypedVarName
		cr.addCriteria(lookupUserTypedVarName, strValue);
		cr.addCriteria(parentColumnMD.getName(), strValue);
		Utils.debug("FormLookupComboboxItem.getPickListFilterCriteria end");
		return cr;
	}

	//
	public Criteria getMainFormCriteria(MainFormPane mainFormPane) {
		Utils.debug("FormLookupComboboxItem.getMainFormCriteria start");
		Record record = Utils.getEditedRecord(mainFormPane);
		Criteria cr = Utils
				.getCriteriaFromListGridRecord2(mainFormPane, record);
		// Добавление атрибутов колонки
		Map<String, String> lookupAttributes = parentColumnMD
				.getLookupAttributes();
		Iterator<String> attrs = lookupAttributes.keySet().iterator();
		while (attrs.hasNext()) {
			String attrName = attrs.next();
			cr.addCriteria(attrName, lookupAttributes.get(attrName));
		}
		Utils.debug("FormLookupComboboxItem.getMainFormCriteria end");
		return cr;
	}

	public FormLookupComboboxItem(FormColumnMD parentColumnMD,
			MainFormPane parentFormPane) {
		super(parentColumnMD, parentFormPane);
		lookupDataSource = new ComboBoxDataSource();
		lookupCode = parentColumnMD.getLookupCode(); // + "_" +
														// columnMD.getName();
		int gridHashCode = 10000 + FormLookupComboboxItem.this.parentColumnMD
				.getDisplayNum();
		instanceIdentifier = new FormInstanceIdentifier(
				ConstructorApp.sessionId, lookupCode,
				ConstructorApp.debugEnabled, true, false,
				this.parentFormPane.getFormCode(), null);
		instanceIdentifier.setGridHashCode(gridHashCode);
		lookupFormMD = parentFormPane.getFormMetadata().getLookupsArr()
				.get(instanceIdentifier.getKey());

		{// mm20130929 меппинг полей лукапа
			ArrayList<FormColumnLookupMappingMD> mappingArr = parentColumnMD
					.getColumnLookupMappingArr();
			if (mappingArr.size() > 0) {
				lookupFormMD = lookupFormMD.clone();
				FormColumnsArr x = lookupFormMD.getColumns();
				for (int i = 0; i < mappingArr.size(); i++) {
					FormColumnLookupMappingMD mmd = mappingArr.get(i);
					String oldName = mmd.getLookupFormColumnCode(); // это
																	// откуда
					int idx = x.getColIndex(oldName);
					FormColumnMD cmd = x.get(idx);

					String newName = mmd.getColumnCodeToMapping(); // это куда
					// newName = (null == newName) ? oldName : newName;
					newName = (null == newName) ? "$$"
							+ Constants.lokupWithoutMappingPrefix + oldName
							: newName;
					cmd.setName(newName);
					// Переопределение видимости, наименований и др.
					// характеристик для лукапа
					cmd.setDisplayName(mmd.getColumnUserName());
					cmd.setDisplaySize(mmd.getColumnDisplaySize());
					cmd.setShowOnGrid(mmd.getShowOnGrid());

					// TODO - 8. не работает переопределение порядка столбцов
					cmd.setDisplayNum(mmd.getColumnDisplayNumber());

					x.put(idx, cmd);

				}
			}
		}

		MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(lookupFormMD);

		mfp.setFormColumns(new FormColumns(mfp));
		FormTreeGridField[] gridFields = mfp.getFormColumns()
				.createGridFields();

		this.setLookupSize(parentColumnMD.getLookupWidth(),
				parentColumnMD.getLookupHeight(),
				lookupFormMD.getLookupWidth(), lookupFormMD.getLookupHeight());
		this.setPickListFields(gridFields);
		lookupDataSource.setFields(mfp.getFormColumns().createDSFields());
		this.setShowOptionsFromDataSource(true);
		this.setOptionDataSource(lookupDataSource);
		this.setFetchDelay(1000);
		this.setCompleteOnTab(true);
		this.setCachePickListResults(false);
		// this.setUseClientFiltering(false);

		// Отрабатывает после набора части наименования в поле
		this.setPickListFilterCriteriaFunction(new FormItemCriteriaFunction() {
			@Override
			public Criteria getCriteria(FormItemFunctionContext itemContext) {
				return getPickListFilterCriteria(itemContext);
			}
		});

	}

	@SuppressWarnings("unchecked")
	private void setEditValues(Record rec) {
		parentFormPane.setEditValues(JSOHelper.convertToMap(rec.getJsObj()));
	}

	@Override
	public void onSelectValue(FormItem item, Record rec) {
		try {
			setEditValues(rec);
			Utils.createQueryService("FormLookupComboboxItem.closeForm")
					.closeFormInstance(instanceIdentifier,
							new DSAsyncCallback<Void>() {
								@Override
								public void onSuccess(Void result) {
								}
							});
		} catch (Exception e) {
			e.printStackTrace();
		}
		// TODO - 6. освободить на сервере память (кеш), т.е. для лукапа
	}

	@Override
	public void onClearValue(FormItem item) {
		setEditValues(lookupDataSource.copyRecord(new Record()));
	}

}
