package com.abssoft.constructor.client.app;

import java.util.Iterator;
import java.util.LinkedHashMap;

import com.google.gwt.user.client.Cookies;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class SkinSelectorMenu extends MenuItem {
	private static LinkedHashMap<String, String> getSkinsList() {
		LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
		valueMap.put("Enterprise", "Enterprise");
		valueMap.put("EnterpriseBlue", "Enterprise Blue");
		valueMap.put("Graphite", "Graphite");
		valueMap.put("SilverWave", "Silver Wave");
		valueMap.put("BlackOps", "Black Ops");
		valueMap.put("TreeFrog", "Tree Frog");
		valueMap.put("fleet", "Fleet");
		valueMap.put("Cupertino", "Cupertino");
		valueMap.put("standard", "Standard");
		return valueMap;
	}

	public SkinSelectorMenu() {
		this(getSkinsList());
		// this.
	}

	public SkinSelectorMenu(LinkedHashMap<String, String> valueMap) {
		this.setTitle("Skins");
		this.setIcon("[ISOMORPHIC]/resources/icons/" + "layers.png");
		setItems(valueMap);
	}

	public void setItems(LinkedHashMap<String, String> valueMap) {
		LinkedHashMap<String, String> valueMapIntr = 0 == valueMap.size() ? getSkinsList() : valueMap;
		final Menu skinsSM = new Menu();
		String currentSkin = Cookies.getCookie("skin");
		if (currentSkin == null) {
			currentSkin = "Enterprise";
			Cookies.setCookie("skin", currentSkin);
		}
		Iterator<String> menuIterator = valueMapIntr.keySet().iterator();
		int formsCount = valueMapIntr.size();
		MenuItem[] menuItems = new MenuItem[formsCount];
		int i = 0;
		while (menuIterator.hasNext()) {
			String itrVal = menuIterator.next();
			final MenuItem mi = new MenuItem(valueMapIntr.get(itrVal));
			mi.setAttribute("skin#", itrVal);
			if (itrVal.equals(currentSkin))
				mi.setChecked(true);

			mi.setCheckIfCondition(new MenuItemIfFunction() {
				public boolean execute(Canvas target, Menu menu, MenuItem item) {
					return Cookies.getCookie("skin").equals(item.getAttribute("skin#"));
				}
			});
			mi.addClickHandler(new ClickHandler() {
				public void onClick(MenuItemClickEvent event) {
					for (MenuItem subMI : skinsSM.getItems()) {
						if (subMI == mi) {
							mi.setChecked(true);
							Cookies.setCookie("skin", mi.getAttribute("skin#"));
							com.google.gwt.user.client.Window.Location.reload();
						} else {
							mi.setChecked(false);
						}
					}
				}
			});
			menuItems[i++] = mi;
		}
		skinsSM.setItems(menuItems);
		this.setSubmenu(skinsSM);
	}
}