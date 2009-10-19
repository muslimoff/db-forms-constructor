package com.abssoft.constructor.client.form;

import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.StaticTextItem;

public class FormBottomToolBar extends DynamicForm {
	private StaticTextItem statusItem = new StaticTextItem("Status", "Status");
	private StaticTextItem rowsCountItem = new StaticTextItem();

	FormBottomToolBar() {
		rowsCountItem.setTitle("Rows");
		rowsCountItem.setAlign(Alignment.LEFT);
		rowsCountItem.setValue(999999);
		this.setNumCols(10);
		this.setColWidths(30, 30, 40, "*");
		statusItem.setShowTitle(false);
		statusItem.setWidth("*");
		statusItem.setColSpan(7);
		statusItem.setAlign(Alignment.RIGHT);
		// statusItem.setWrap(false);
		this.setItems(rowsCountItem, statusItem);
		this.setCellBorder(1);
	}

	public void setStatus(String value) {
		statusItem.setValue(value);
	}

	public void setRowsCount(String value) {
		rowsCountItem.setValue(value);
	}

}
