package com.abssoft.constructor.client.widgets;

import com.google.gwt.core.client.JavaScriptObject;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;

public class MyComboBoxItem extends ComboBoxItem {
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
}