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
					removeMainFormContainerTab(event.getTab(), true);
				} catch (Exception e) {
					e.printStackTrace();
					Utils.logException(e, "com.abssoft.constructor.client.common.TabSet.removeMainFormContainerTab");
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

	public void removeMainFormContainerTab(Tab tab, boolean isFromTabsetCloseClickEvent) {

		if (tab instanceof MainFormContainer) {
			MainFormContainer t = (MainFormContainer) tab;
			Utils.debug("TabSet.removeMainFormContainerTab. Tab: " + t.getFormCode());
			t.getMainFormPane().doBeforeClose();
			// this.removeTab(tab.getID());
			try {
				// tab.getPane().destroy();
				Utils.debug("TabSet.removeMainFormContainerTab. 1");

				// Uncaught JavaScript exception [_9 is undefined] in
				// http://127.0.0.1:8888/constructorapp/sc/modules/ISC_Containers.js?isc_version=8.2.js, line 471
				// Закоментировано удаление табика (работает нормально и так) в связи с ошибкой (выше) и некорректном
				// открытии новых форм после закрытия (новая форма встравивалась в низ предыдущей):
				// this.removeTab(tab);

				// 20120501 Добарываю косяк при переходе на 3.0 - в случае, если по событию из табсета - не вызываем. Из-за косяка выше
				if (!isFromTabsetCloseClickEvent) {
					this.removeTab(tab);
				}
				Utils.debug("TabSet.removeMainFormContainerTab. 2");
			} catch (Exception e) {
				e.printStackTrace();
				Utils.logException(e, "com.abssoft.constructor.client.common.TabSet.removeMainFormContainerTab");
			}
			Utils.debug("TabSet.removeMainFormContainerTab. 3");
			ConstructorApp.mainToolBar.clear();
			Utils.debug("TabSet.removeMainFormContainerTab. 4");
		}
	}

	public void hideTabBar() {
		System.out.println("@@############:" + this);
		for (Canvas c : this.getChildren()) { // System.out.println("!1xxxxxxxx>>" + c);
			if (c.toString().contains("tabBar")) {
				System.out.println("!2yyyyy>>" + c);
				c.setHeight(0);
				c.hide();
				// c.removeFromParent();
			}
		}
	}
}
