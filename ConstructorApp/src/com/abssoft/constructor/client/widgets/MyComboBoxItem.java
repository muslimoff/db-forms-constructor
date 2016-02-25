package com.abssoft.constructor.client.widgets;

import java.util.Iterator;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.metadata.ColumnAction;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.StaticLookup;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.fields.DataSourceTextField;
import com.smartgwt.client.types.TextMatchStyle;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.events.ChangedEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangedHandler;
import com.smartgwt.client.widgets.grid.ListGridField;

public abstract class MyComboBoxItem extends ComboBoxItem {
	private Integer lookupWidth;
	private Integer lookupHeight;
	private StaticLookup valueMap = new StaticLookup();
	protected FormColumnMD parentColumnMD;
	protected MainFormPane parentFormPane;
	private DataSource lookupDataSource;
	protected FormInstanceIdentifier instanceIdentifier;

	public MyComboBoxItem(FormColumnMD parentColumnMD, MainFormPane parentFormPane) {
		super();
		this.parentColumnMD = parentColumnMD;
		this.parentFormPane = parentFormPane;

		this.addChangedHandler(new ChangedHandler() {

			@Override
			public void onChanged(ChangedEvent event) {
				FormItem item = event.getItem();
				Utils.debug("MyComboBoxItem.onChanged." + item.getName());
				// Определяем, введена ли пользователем часть значения для поиска (null=rec) или пользователь выбрал запись (null!=rec)
				// Такой способ нашел где-то на форуме
				Record rec = new ComboBoxItem(item.getJsObj()).getSelectedRecord();
				Utils.debugRecord(rec, "MyComboBoxItem.onChanged." + item.getName());
				if (null != rec) {
					onSelectValue(item, rec);
					doOnRecordSelectedAction();
				} else if (null == item.getValue()) {
					onClearValue(item);
				}

			}
		});
	}

	@SuppressWarnings("unchecked")
	protected void setEditValues(Record rec) {
		parentFormPane.setEditValues(JSOHelper.convertToMap(rec.getJsObj()));
	}

	public void doOnRecordSelectedAction() {
		//

		// Обработка действия 4 (послевыбора из списка)
		for (int j = 0; j < parentColumnMD.getColActions().size(); j++) {
			final ColumnAction ca = parentColumnMD.getColActions().get(j);
			String actionType = ca.getColActionTypeCode();
			if ("4".equals(actionType)) {
				try {
					parentFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode())
							.doActionWithConfirm(parentFormPane.getSelectedRow());
				} catch (Exception e) {
					e.printStackTrace();
					Utils.debug(e.getMessage());
				}
			}
		}

	}

	public void setLookupWidth(Integer lookupWidth) {
		if (null != lookupWidth) {
			this.lookupWidth = lookupWidth;
			this.setPickListWidth(this.lookupWidth);
		}
	}

	public Integer getLookupWidth() {
		return lookupWidth;
	}

	public void setLookupHeight(Integer lookupHeight) {
		if (null != lookupHeight) {
			this.lookupHeight = lookupHeight;
			this.setPickListHeight(this.lookupHeight);
		}
	}

	public Integer getLookupHeight() {
		return lookupHeight;
	}

	public void setLookupSize(Integer columnLookupWidth, Integer columnLookupHeight, Integer formLookupWidth, Integer formLookupHeight) {
		// Высота и ширина лукапа.
		// а) Устанавливаем из свойств формы. Пустые значения отсекаются
		// б) Если в колонках непусто - переопределяем из колонки.

		// а)
		this.setLookupWidth(formLookupWidth);
		this.setLookupHeight(formLookupHeight);
		// б)
		this.setLookupWidth(columnLookupWidth);
		this.setLookupHeight(columnLookupHeight);

	}

	public void setValueMap(String lookupCode) {
		valueMap = ConstructorApp.staticLookupsArr.get(lookupCode);
		lookupDataSource = new DataSource() {
			{
				DataSourceTextField key = new DataSourceTextField("key");
				DataSourceTextField val = new DataSourceTextField("val");
				setFields(key, val);
				setClientOnly(true);

				Record[] rs = new Record[valueMap.size()];
				Iterator<String> mmIt = valueMap.keySet().iterator();
				int i = 0;
				while (mmIt.hasNext()) {
					String key1 = mmIt.next();
					rs[i] = new Record();
					rs[i].setAttribute("key", key1);
					rs[i].setAttribute("val", valueMap.get(key1));
					i++;
				}
				this.setTestData(rs);
			}
		};
		this.setOptionDataSource(lookupDataSource);
		this.setValueField("key");
		this.setDisplayField("val");
		this.setTextMatchStyle(TextMatchStyle.SUBSTRING);
		this.setCompleteOnTab(true);
		this.setSortField("val");

		ListGridField keyField = new ListGridField("key", "Код", 50);

		ListGridField valField = new ListGridField("val", "Значение");
		if (!ConstructorApp.debugEnabled) {
			keyField.setHidden(true);
		}
		this.setPickListFields(valField, keyField);
	}

	public StaticLookup getValueMap() {
		return valueMap;
	}

	//public abstract void onSelectValue(FormItem item, Record rec);

	protected void closeFormInstance() {
		try {
			Utils.createQueryService(this.getClassName() + ".closeForm").closeFormInstance(instanceIdentifier, new DSAsyncCallback<Void>() {
				@Override
				public void onSuccess(Void result) {
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void onSelectValue(FormItem item, Record rec) {
		//setEditValues(rec);
		closeFormInstance();
	}

	protected abstract void onClearValue(FormItem item);
}