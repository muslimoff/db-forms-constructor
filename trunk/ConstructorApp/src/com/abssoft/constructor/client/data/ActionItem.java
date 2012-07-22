package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
import com.smartgwt.client.widgets.menu.MenuItemStringFunction;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class ActionItem extends MenuItem {
	private FormActionMD formActionMD;
	private IButton button = null;
	private MainFormPane mainFormPane;
	private FormAction formAction;

	public FormAction getFormAction() {
		return formAction;
	}

	public void setFormAction(FormAction formAction) {
		this.formAction = formAction;
	}

	public void doActionWithConfirm(Integer recordIndex) {
		formAction.doActionWithConfirm(recordIndex);
	}

	public ActionItem(final MainFormPane mainFormPane, FormActionMD formActionMD) {
		this.setFormActionMD(formActionMD);
		this.mainFormPane = mainFormPane;
		String iconPath = ConstructorApp.menus.getIcons().get(formActionMD.getIconId());
		this.setIcon(iconPath);
		String displayName = formActionMD.getDisplayName();
		this.setTitle(displayName);
		String hotKey = formActionMD.getHotKey();
		if (null != hotKey) {
			KeyIdentifier key = new KeyIdentifier(hotKey);
			hotKey = key.getTitle();
			this.setKeys(key);
			this.setKeyTitle(hotKey);
			// Подсказка хоткея для кнопки
			displayName = displayName + " (" + hotKey + ")";
		}
		setFormAction(new FormAction(mainFormPane, formActionMD));
		this.addClickHandler(new ClickHandler() {
			@Override
			public void onClick(MenuItemClickEvent event) {
				//Так надо - по всем строкам.
				//doActionWithConfirm(mainFormPane.getSelectedRow());
				//TODO - теперь проблема - не выполняется openUrl
				doActionWithConfirm(null);
			}
		});
		if (formActionMD.getDisplayOnToolbar()) {
			button = new IButton(formActionMD.getDisplayName());
			button.setShowDisabledIcon(false);
			button.setPrompt(displayName);
			button.setIcon(iconPath);
			button.addClickHandler(new com.smartgwt.client.widgets.events.ClickHandler() {
				@Override
				public void onClick(ClickEvent event) {
					//doActionWithConfirm(mainFormPane.getSelectedRow());
					doActionWithConfirm(null);
				}
			});
		}
		this.setDynamicTitleFunction(new MenuItemStringFunction() {
			@Override
			public String execute(Canvas target, Menu menu, MenuItem item) {
				String title = ActionItem.this.getFormActionMD().getDisplayName();
				try {
					title = Utils.replaceBindVariables(mainFormPane, title);
				} catch (Exception e) {
					e.printStackTrace();
				}
				return title;
			}
		});

		this.setEnableIfCondition(new MenuItemIfFunction() {

			@Override
			public boolean execute(Canvas target, Menu menu, MenuItem item) {
				Boolean result = true;
				try {
					String actionType = ActionItem.this.formActionMD.getType();
					ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
					int currRow = mainFormPane.getMainForm().getSelectedRecord();
					if ("2".equals(actionType)) {
						result = currRow == grid.getEditRow() || 0 != grid.getAllEditRows().length;
					}
					if ("5".equals(actionType)) {
						result = 0 != currRow;
					}
					if ("6".equals(actionType)) {
						result = (1 + currRow) != grid.getTotalRows();
					}
				} catch (Exception e) {
					// e.printStackTrace();
				}
				return result;
			}
		});
	}

	public IButton getButton() {
		return button;
	}

	public FormActionMD getFormActionMD() {
		return formActionMD;
	}

	public void setActionStatus() throws Exception {
		String actionType = formActionMD.getType();
		ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		int currRow = mainFormPane.getSelectedRow();
		if ("1".equals(actionType)) {
		} else if ("2".equals(actionType)) {
			// TODO ошибка в редакторе - невозможно сохранить строку
			// this.setEnabled(currRow == grid.getEditRow() || 0 != grid.getAllEditRows().length);
		} else if ("5".equals(actionType)) {
			this.setEnabled(0 != currRow);
		} else if ("6".equals(actionType)) {
			this.setEnabled((1 + currRow) != grid.getTotalRows());
		}
	}

	public void setButton(IButton button) {
		this.button = button;
	}

	public void setEnabled(boolean enabled) {
		// super.setEnabled(enabled);
		if (null != button) {
			button.setDisabled(!enabled);
		}
	}

	public void setFormActionMD(FormActionMD formActionMD) {
		this.formActionMD = formActionMD;
	}

}