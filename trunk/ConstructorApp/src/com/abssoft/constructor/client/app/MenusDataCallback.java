package com.abssoft.constructor.client.app;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.widgets.MenuWithHover;
import com.smartgwt.client.widgets.menu.MenuButton;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class MenusDataCallback extends DSAsyncCallback<MenusArr> {

	public class FormMenuItem extends MenuItem {
		private MenuMD menuMetadata;

		/**
		 * @return the menuMetadata
		 */
		public MenuMD getMenuMetadata() {
			return menuMetadata;
		}

		/**
		 * @param menuMetadata
		 *            the menuMetadata to set
		 */
		public void setMenuMetadata(MenuMD menuMetadata) {
			this.menuMetadata = menuMetadata;
		}

		public FormMenuItem(final MenuMD menuMetadata) {
			this.menuMetadata = menuMetadata;
			this.setTitle(menuMetadata.getFormName());
			this.setIcon(ConstructorApp.menus.getIcons().get(menuMetadata.getIconId()));
			String hotKey = menuMetadata.getHotKey();
			if (hotKey != null) {
				KeyIdentifier key = new KeyIdentifier(menuMetadata.getHotKey());
				this.setKeys(key);
				this.setKeyTitle(key.getTitle());
			}
			this.addClickHandler(new ClickHandler() {
				public void onClick(MenuItemClickEvent event) {
					Utils.debug("FormMenus onClick: " + menuMetadata.getFormCode());
					new MainFormContainer(FormTab.TabType.MAIN, ConstructorApp.tabSet, menuMetadata.getFormCode());
					Utils.debug("FormMenus onClick2: " + menuMetadata.getFormCode());
				}
			});

		}

		public MenuMD getFormMetadata() {
			return menuMetadata;
		}
	}

	public void onSuccess(MenusArr result) {
		ConstructorApp.menus = result;
		HashMap<String, MenuWithHover> menusHM = new HashMap<String, MenuWithHover>();
		System.out.println("menus size: " + result.size());
		final MenuWithHover menu = new MenuWithHover();
		menu.setShowShadow(true);
		menu.setShadowDepth(10);
		int formsCount = result.size();

		ArrayList<String> rootMenuCodes = new ArrayList<String>();
		ArrayList<String> rootMenuNames = new ArrayList<String>();
		for (int i = 0; i < formsCount; i++) {
			final MenuMD menuMD = result.get(i);
			String formCode = menuMD.getFormCode();
			String parentMenuCode = menuMD.getParentMenuCode();
			ConstructorApp.formIconArr.put(formCode, menuMD.getIconId());
			ConstructorApp.formNameArr.put(formCode, menuMD.getFormName());
			// ////////////////////////////////////////////
			// TODO - если в корневой менюшке висит форма - проблема - нужно так же проверять на кол-во дочерних, и если 0, то цеплять
			// действие на кнопку.
			// TODO - не работает HotKey для вложенных субменюшек.
			// TODO - переделать вместо null == parentMenuCode на lvl==1
			if (null == parentMenuCode) {
				// Корневые менюшки
				MenuWithHover smm = new MenuWithHover();
				menusHM.put(menuMD.getMenuCode(), smm);
				rootMenuCodes.add(menuMD.getMenuCode());
				rootMenuNames.add(menuMD.getMenuName());
			} else if (menusHM.containsKey(parentMenuCode)) {
				// Конечные менюшки - формочки
				FormMenuItem mi = new FormMenuItem(menuMD);
				if (0 != menuMD.getChildCount()) {
					// Субменюшки
					MenuWithHover submenu = new MenuWithHover();
					mi.setSubmenu(submenu);
					menusHM.put(menuMD.getMenuCode(), submenu);
					submenu.setHover();
				}
				MenuWithHover smm = menusHM.get(parentMenuCode);
				smm.addItem(mi);
			}
		}
		for (int i = 0; i < rootMenuCodes.size(); i++) {
			MenuButton mb = new MenuButton(rootMenuNames.get(i));
			MenuWithHover smm = menusHM.get(rootMenuCodes.get(i));
			mb.setMenu(smm);
			ConstructorApp.menuBar.addMembers(mb);
			smm.setHover();
		}
		openFormsFromURL();
	}

	public void openFormsFromURL() {
		List<String> formList = ConstructorApp.urlParams.get("app.form");
		if (null != formList) {
			for (int i = 0; i < formList.size(); i++) {
				String formCode = formList.get(i);
				Utils.debug("Form, that will be open (" + i + "): \"" + formCode + "\"");
				if (formCode != null && ConstructorApp.formNameArr.containsKey(formCode)) {
					Utils.debug("Form opening (" + i + "):" + formCode);
					MainFormContainer mfc = new MainFormContainer(FormTab.TabType.MAIN, ConstructorApp.tabSet, formCode, true, false, true);
					mfc.getMainFormPane().setFromUrl(true);
				}
			}
		}
	}
}
