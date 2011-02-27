package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.events.CloseClickHandler;
import com.smartgwt.client.widgets.tab.events.TabCloseClickEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedHandler;

public class TabSet extends com.smartgwt.client.widgets.tab.TabSet {
	public TabSet() {
		this.setAttribute("paneMargin", 0, false);
		addCloseClickHandler(new CloseClickHandler() {
			public void onCloseClick(TabCloseClickEvent event) {
				try {
					removeMainFormContainerTab(event.getTab());
				} catch (Exception e) {
					e.printStackTrace();
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

	public void removeMainFormContainerTab(Tab tab) {

		if (tab instanceof MainFormContainer) {
			MainFormContainer t = (MainFormContainer) tab;
			Utils.debug("OnClose Tab: " + t.getFormCode());
			t.getMainFormPane().doBeforeClose();
			// this.removeTab(tab.getID());
			try {
				// tab.getPane().destroy();
				this.removeTab(tab);
			} catch (Exception e) {
				e.printStackTrace();
			}
			ConstructorApp.mainToolBar.clear();
		}
	}

	public void hideTabBar() {
		System.out.println("@@############:" + this);
		for (Canvas c : this.getChildren()) { // System.out.println("!1xxxxxxxx>>" + c);
			if (c.toString().contains("tabBar")) {   System.out.println("!2yyyyy>>" + c);
				c.setHeight(0);
				c.hide();
				// c.removeFromParent();
			}
		}
	}
}
