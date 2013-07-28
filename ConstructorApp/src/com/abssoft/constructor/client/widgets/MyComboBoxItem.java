package com.abssoft.constructor.client.widgets;

import java.util.Collections;
import java.util.Iterator;
import java.util.Vector;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.common.metadata.StaticLookup;
import com.google.gwt.core.client.JavaScriptObject;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.fields.DataSourceTextField;
import com.smartgwt.client.types.TextMatchStyle;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.grid.ListGridField;

public class MyComboBoxItem extends ComboBoxItem {
	private Integer lookupWidth;
	private Integer lookupHeight;
	private StaticLookup valueMap = new StaticLookup();

	public MyComboBoxItem() {
		setType("ComboBoxItem");
	}

	public MyComboBoxItem(final JavaScriptObject jsObj) {
		super(jsObj);
	}

	public MyComboBoxItem(final String name) {
		setName(name);
		setType("ComboBoxItem");
	}

	public native Boolean isRecordSelected()
	/*-{
		var self = this.@com.smartgwt.client.core.DataClass::getJsObj()();
		var isRecordSelected =  ( self.getSelectedRecord() ) ? true : false;
		return @com.smartgwt.client.util.JSOHelper::toBoolean(Z)(isRecordSelected);
	}-*/;

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
		DataSource ds = new DataSource() {
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
		this.setOptionDataSource(ds);
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
}