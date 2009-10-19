package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.events.CloseClickHandler;
import com.smartgwt.client.widgets.tab.events.TabCloseClickEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedHandler;

public class TabSet extends com.smartgwt.client.widgets.tab.TabSet {
	public TabSet() {
		super();
		addCloseClickHandler(new CloseClickHandler() {
			public void onCloseClick(TabCloseClickEvent event) {
				if (event.getTab() instanceof MainFormContainer) {
					MainFormContainer t = (MainFormContainer) event.getTab();
					Utils.debug("OnClose Tab: " + t.getFormCode());
					t.getMainFormPane().doBeforeClose();
					TabSet.this.removeTab(event.getTab().getID());
					ConstructorApp.mainToolBar.clear();
				}
			}
		});
		addTabSelectedHandler(new TabSelectedHandler() {

			@Override
			public void onTabSelected(TabSelectedEvent event) {
				if (event.getTab() instanceof FormTab) {
					Utils.debug(((FormTab) event.getTab()).getFormCode() + "<<");
					ConstructorApp.mainToolBar.setForm(((FormTab) event.getTab()).getMainFormPane());
				}
			}
		});
	}

	public void selectTab(MainFormPane mainFormPane) {
		for (Tab t : this.getTabs()) {
			if (t.getPane() instanceof MainFormPane && mainFormPane.equals(t.getPane())) {
				this.selectTab(t);
				break;
			}
		}
	}
}
