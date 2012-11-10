package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.ActionItem;
import com.abssoft.constructor.common.FormActionsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;

public class FormToolbar extends DynamicForm {

	private ArrayList<MenuItem> actionItemsArr = new ArrayList<MenuItem>();
	// private ArrayList<IButton> actionButtonsArr = new ArrayList<IButton>();
	// private ArrayList<MenuItem> actionMenuItemsArr = new ArrayList<MenuItem>();

	public LinkedHashMap<String, ActionItem> actionItemsMap = new LinkedHashMap<String, ActionItem>();
	private MainFormPane mainFormPane;
	private Menu ctxMenu;
	private ToolbarItem btnToolbar = new ToolbarItem();
	private IButton[] btns;
	private ActionItem doubleClickActItem;

	private class CtxMenu extends Menu {
		CtxMenu(ArrayList<MenuItem> menuItemsArr, MainFormPane mainFormPane) {
			String formTitle = mainFormPane.getFormMetadata().getFormName();
			String icon = ConstructorApp.menus.getIcons().get(mainFormPane.getFormMetadata().getIconId());

			int additionalMICount = 2;
			MenuItem[] menuItems = new MenuItem[menuItemsArr.size() + additionalMICount];
			// Title MenuItem
			menuItems[0] = new MenuItem(formTitle);
			menuItems[0].setEnabled(false);
			menuItems[0].set_baseStyle("bold");
			menuItems[0].setIcon(icon);
			// Separator
			menuItems[1] = new MenuItemSeparator();
			// Real menu items
			for (int i = 0; i < menuItemsArr.size(); i++) {
				menuItems[i + additionalMICount] = menuItemsArr.get(i);
			}
			this.setData(menuItems);
		}
	}

	public FormToolbar(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		setWidth("*");
		setNumCols(4);
	}

	public void createButtons() {
		ArrayList<MenuItem> actionMenuItemsArr = new ArrayList<MenuItem>();
		ArrayList<IButton> actionButtonsArr = new ArrayList<IButton>();

		String formName = mainFormPane.getFormMetadata().getFormName();
		formName = null != formName ? formName : mainFormPane.getFormCode();
		TextItem formNameItem = new TextItem();
		formNameItem.setValue(formName);
		formNameItem.setDisabled(true);
		formNameItem.setEndRow(false);
		formNameItem.setWidth("200");
		formNameItem.setShowTitle(false);

		FormActionsArr formActionsArr = mainFormPane.getFormMetadata().getActions();

		/*****************/
		for (int i = 0; i < formActionsArr.size(); i++) {
			FormActionMD formActionMD = formActionsArr.get(i);
			ActionItem actionItem = new ActionItem(mainFormPane, formActionMD);
			actionItemsArr.add(actionItem);
			if (formActionMD.getDisplayInContextMenu()) {
				actionMenuItemsArr.add(actionItem);
				// Если показываем разделитель меню
				if (formActionMD.getShowSeparatorBelow()) {
					actionMenuItemsArr.add(new MenuItemSeparator());
				}
			}
			// Если отображаем кнопку на панельке
			if (null != actionItem.getButton()) {
				actionButtonsArr.add(actionItem.getButton());
			}
			if (formActionMD.getCode().equals(mainFormPane.getFormMetadata().getDoubleClickActionCode())) {
				doubleClickActItem = actionItem;
			}
		}
		/*****************/
		ctxMenu = new CtxMenu(actionMenuItemsArr, mainFormPane);

		// Buttons
		btns = new IButton[actionButtonsArr.size()];
		for (int i = 0; i < actionButtonsArr.size(); i++) {
			btns[i] = actionButtonsArr.get(i);
		}
		btnToolbar.setButtons(btns);
		this.setContextMenu(ctxMenu);
		mainFormPane.setContextMenu(ctxMenu);
		if (null != mainFormPane.getMainFormContainer()) { //20120824 была ошибка для одиночных динамических форм
			mainFormPane.getMainFormContainer().setContextMenu(ctxMenu);
		}
		btnToolbar.setStartRow(false);
		setItems(formNameItem, btnToolbar);

		for (int i = 0; i < actionItemsArr.size(); i++) {
			MenuItem mi = actionItemsArr.get(i);
			if (mi instanceof ActionItem) {
				ActionItem ai = (ActionItem) mi;
				actionItemsMap.put(ai.getFormActionMD().getCode(), ai);
			}
		}
	}

	//
	public void setActionsStatuses() {
		for (int i = 0; i < actionItemsArr.size(); i++) {
			MenuItem mi = actionItemsArr.get(i);
			if (mi instanceof ActionItem) {
				try {
					((ActionItem) mi).setActionStatus();
				} catch (Exception e) {
					System.out.println("setActionsStatuses...Error " + e);
					e.printStackTrace();
				}
			}
		}
	}

	public void setDoubleClickActItem(ActionItem doubleClickActItem) {
		this.doubleClickActItem = doubleClickActItem;
	}

	public ActionItem getDoubleClickActItem() {
		return doubleClickActItem;
	}
}
