package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.toolbar.ToolStrip;

public class ApplicationToolBar extends ToolStrip {
	private DynamicForm form;
	// public static QueryServiceAsync queryService; // = (QueryServiceAsync) GWT.create(QueryService.class);
	// private static ServiceDefTarget queryServiceDefTarget = (ServiceDefTarget) queryService;
	private boolean showToolbar = false;
	public boolean showToolbarButtonNames = false;

	public ApplicationToolBar() {
		// TODO - Что-то вдруг тулбар стал вылазить за пределы окна при 100% размере
		this.setWidth("90%");
		this.setHeight("28");
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
		mainFormPane.setFocus();
		ConstructorApp.getActionsMenuBtn().setSubmenu(mainFormPane.getContextMenu());
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

	public String getBackgroundColor() {
		return getAttribute("backgroundColor");

	}

	public void showOrHide(boolean showToolbar) {
		this.showToolbar = showToolbar;
		if (showToolbar) {
			this.show();
		} else {
			this.hide();
		}
		//ConstructorApp.showToolbar = !ConstructorApp.showToolbar;
		//this.getParentElement().redraw();
	}

	public void showOrHide() {
		showOrHide(showToolbar);

	}

	public boolean isShowToolbar() {
		return showToolbar;
	}

}
