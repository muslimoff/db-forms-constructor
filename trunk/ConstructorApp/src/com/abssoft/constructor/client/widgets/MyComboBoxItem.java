package com.abssoft.constructor.client.widgets;

import com.google.gwt.core.client.JavaScriptObject;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;

public class MyComboBoxItem extends ComboBoxItem {
	private Integer lookupWidth;
	private Integer lookupHeight;

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
}