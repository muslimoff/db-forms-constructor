package com.abssoft.constructor.client.app;

import java.util.Iterator;
import java.util.LinkedHashMap;

import com.abssoft.constructor.client.common.Constants;
import com.google.gwt.user.client.Cookies;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class SkinSelectorMenu extends MenuItem {
	public SkinSelectorMenu() {
		LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
		valueMap.put("Enterprise", "Enterprise");
		valueMap.put("EnterpriseBlue", "Enterprise Blue");
		valueMap.put("SilverWave", "Silver Wave");
		valueMap.put("BlackOps", "Black Ops");
		valueMap.put("TreeFrog", "Tree Frog");
		valueMap.put("fleet", "Fleet");
		valueMap.put("Cupertino", "Cupertino");
		valueMap.put("standard", "Standard");
		valueMap.put("ToolSkin", "ToolSkin");
		final Menu skinsSM = new Menu();
		String currentSkin = Cookies.getCookie("skin");
		if (currentSkin == null) {
			currentSkin = "EnterpriseBlue";
			Cookies.setCookie("skin", currentSkin);
		}
		Iterator<String> menuIterator = valueMap.keySet().iterator();
		int formsCount = valueMap.size();
		MenuItem[] menuItems = new MenuItem[formsCount];
		int i = 0;
		while (menuIterator.hasNext()) {
			String itrVal = menuIterator.next();
			final MenuItem mi = new MenuItem(valueMap.get(itrVal));
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
		this.setTitle("Skins");
		this.setIcon(Constants.clientIconURL + "layers.png");
	}

}
