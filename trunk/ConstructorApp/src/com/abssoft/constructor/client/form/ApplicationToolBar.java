package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.toolbar.ToolStrip;
 
public class ApplicationToolBar extends ToolStrip {
	private DynamicForm form;

	public ApplicationToolBar() {
		this.setWidth100();
		this.setHeight("22");
	}

	 
	/**
	 * @param mainFormPane
	 */
	public void setForm(MainFormPane mainFormPane) {
		DynamicForm form = mainFormPane.getButtonsToolBar();
		if (null != this.form)
			this.removeChild(this.form);
		this.form = form;
		this.addMember(form);
		Utils.debug("Path: " + mainFormPane.getPath());
		ConstructorApp.setPageTitle(mainFormPane.getPath());
	}

	/**
	 * @return the form
	 */
	public DynamicForm getForm() {
		return form;
	}

	public void clear() {
		this.removeMembers(this.getMembers());
		ConstructorApp.setPageTitle("");
	}
}
