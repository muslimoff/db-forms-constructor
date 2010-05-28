package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.Iterator;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.smartgwt.client.types.Visibility;
import com.smartgwt.client.util.BooleanCallback;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class FormToolbar extends DynamicForm {
	class ActionItem extends MenuItem {
		class ActionButtonClickHandler implements com.smartgwt.client.widgets.events.ClickHandler {
			private FormActionMD m;

			ActionButtonClickHandler(final FormActionMD m) {
				this.m = m;
			}

			@Override
			public void onClick(com.smartgwt.client.widgets.events.ClickEvent event) {
				doActionWithConfirm(m);
			}
		}

		class ActionCtxMenuClickHandler implements ClickHandler {
			private FormActionMD m;

			ActionCtxMenuClickHandler(final FormActionMD m) {
				this.m = m;
			}

			@Override
			public void onClick(MenuItemClickEvent event) {
				doActionWithConfirm(m);
			}
		}

		private FormActionMD formActionMD;
		private IButton button = null;

		ActionItem(FormActionMD formActionMD) {
			this.setFormActionMD(formActionMD);
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
			this.addClickHandler(new ActionCtxMenuClickHandler(formActionMD));
			if (formActionMD.getDisplayOnToolbar()) {
				button = new IButton(formActionMD.getDisplayName());
				button.setShowDisabledIcon(false);
				button.setPrompt(displayName);
				button.setIcon(iconPath);
				button.addClickHandler(new ActionButtonClickHandler(formActionMD));
				//
				// button.setWidth(button.getHeight());
				// button.setTitle("");
			}

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
			// System.out.println("^^currRow:" + currRow);
			// System.out.println("^^grid.getEditRow()" + grid.getEditRow());
			if ("1".equals(actionType)) {
			} else if ("2".equals(actionType)) {
				// TODO ошибка в редакторе - невозможно сохранить строку
				// this.setEnabled(currRow == grid.getEditRow() || 0 != grid.getAllEditRows().length);
			} else if ("3".equals(actionType)) {
			} else if ("4".equals(actionType)) {
			} else if ("5".equals(actionType)) {
				this.setEnabled(0 != currRow);
			} else if ("6".equals(actionType)) {
				this.setEnabled((1 + currRow) != grid.getTotalRows());
			} else if ("7".equals(actionType)) {
			}
		}

		public void setButton(IButton button) {
			this.button = button;
		}

		public void setEnabled(boolean enabled) {
			super.setEnabled(enabled);
			if (null != button) {
				button.setDisabled(!enabled);
			}
		}

		public void setFormActionMD(FormActionMD formActionMD) {
			this.formActionMD = formActionMD;
		}

	}

	private ArrayList<MenuItem> actionMenuItemsArr = new ArrayList<MenuItem>();
	private ArrayList<IButton> actionButtonsArr = new ArrayList<IButton>();
	private MainFormPane mainFormPane;
	private Menu ctxMenu;
	private ToolbarItem btnToolbar = new ToolbarItem();
	private IButton[] btns;

	public FormToolbar(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		setWidth("*");
		setNumCols(4);
	}

	public void createButtons() {

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
			ActionItem actionItem = new ActionItem(formActionMD);
			actionMenuItemsArr.add(actionItem);
			// Если показываем разделитель меню
			if (formActionMD.getShowSeparatorBelow()) {
				actionMenuItemsArr.add(new MenuItemSeparator());
			}
			// Если отображаем кнопку на панельке
			if (null != actionItem.getButton()) {
				actionButtonsArr.add(actionItem.getButton());
			}
		}
		/*****************/
		ctxMenu = new Menu();
		int additionalMICount = 2;
		MenuItem[] menuItems = new MenuItem[actionMenuItemsArr.size() + additionalMICount];
		// Title MenuItem
		menuItems[0] = new MenuItem(mainFormPane.getFormMetadata().getFormName());
		menuItems[0].setEnabled(false);
		menuItems[0].set_baseStyle("bold");
		menuItems[0].setIcon(ConstructorApp.menus.getIcons().get(mainFormPane.getFormMetadata().getIconId()));
		//
		menuItems[1] = new MenuItemSeparator();
		for (int i = 0; i < actionMenuItemsArr.size(); i++) {
			menuItems[i + additionalMICount] = actionMenuItemsArr.get(i);
		}
		// Buttons
		btns = new IButton[actionButtonsArr.size()];
		for (int i = 0; i < actionButtonsArr.size(); i++) {
			btns[i] = actionButtonsArr.get(i);
		}
		btnToolbar.setButtons(btns);
		ctxMenu.setData(menuItems);
		this.setContextMenu(ctxMenu);
		mainFormPane.setContextMenu(ctxMenu);
		btnToolbar.setStartRow(false);
		setItems(formNameItem, btnToolbar);
	}

	public void doAction(final FormActionMD m) {
		final ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		mainFormPane.setCurrentActionCode(m.getCode());
		// TODO Проблема при сохранении записи из контекстного меню в случае, если фокус не на данной форме.
		if ("2".equals(m.getType())) {
			// TODO Проблема с DynamicForm.ItemChangedHandler в хроме - приходится сохранять данные RichTextItem не по событию, а по кнопке
			// сохранения
			if (Utils.isChrome()) {
				for (DynamicForm form : mainFormPane.getValuesManager().getMembers()) {
					System.out.println("form: " + form);
					for (FormItem formItem : form.getFields()) {
						if (form.getItem(formItem.getName()) instanceof RichTextItem) {
							// System.out.println(formItem.getValue());
							// System.out.println("-------------------");
							// System.out.println();
						}
					}
				}
			}
			grid.saveAllEdits();
		} else if ("1".equals(m.getType())) {
			grid.deselectAllRecords();
			grid.startEditingNew();
		} else if ("3".equals(m.getType())) {
			try {
				grid.removeSelectedData();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mainFormPane.getValuesManager().clearValues();
		}
		// Refresh
		else if ("4".equals(m.getType())) {
			mainFormPane.filterData();
		}
		// prev record
		else if ("5".equals(m.getType())) {
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			if (currRecSelected > 0) {
				grid.selectSingleRecord(--currRecSelected);
				mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
			}
		}
		// next record
		else if ("6".equals(m.getType())) {
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			if (currRecSelected + 1 < grid.getTotalRows()) {
				grid.selectSingleRecord(++currRecSelected);
				mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
			}
		}
		// Custom PL/SQL
		else if ("7".equals(m.getType())) {
			System.out.println("Custom PL/SQL - start execution...");
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			grid.updateData(grid.getRecord(currRecSelected));
			System.out.println("Custom PL/SQL - end execution...");
		} else if ("8".equals(m.getType())) {
			grid.startEditing(mainFormPane.getSelectedRow(), 0, false);
		} else if ("9".equals(m.getType())) {
			grid.setShowFilterEditor(!grid.getShowFilterEditor());
		}

	}

	public void doActionWithConfirm(final FormActionMD m) {
		if (!Visibility.HIDDEN.equals(mainFormPane.getVisibility())) {
			String confirmText = m.getConfirmText();
			if (null != confirmText) {
				{
					Utils.debug("ActionButtonClickHandler. Replace: " + confirmText);
					FormColumnsArr fca = mainFormPane.getFormMetadata().getColumns();
					Iterator<Integer> itr = fca.keySet().iterator();
					while (itr.hasNext()) {
						String columnName = fca.get(itr.next()).getName();
						try {
							String columnValue = mainFormPane.getMainForm().getTreeGrid().getSelectedRecord().getAttribute(columnName);
							confirmText = confirmText.replaceAll("&" + columnName.toLowerCase() + "&", columnValue);
							Utils.debug(columnName + " => " + columnValue);
						} catch (Exception e) {
							e.printStackTrace();
							Utils.debug("Err: >>>>>>>>>>>" + e.getMessage());
						}
					}
				}
				Utils.debug("ActionButtonClickHandler. Replace completed...");
				SC.confirm("Подтверждение", confirmText, new BooleanCallback() {
					public void execute(Boolean value) {
						if (null != value && value) {
							doAction(m);
						}
					}
				});
			} else {
				doAction(m);
			}
		}
	}

	public void setActionsStatuses() {
		for (int i = 0; i < actionMenuItemsArr.size(); i++) {
			MenuItem mi = actionMenuItemsArr.get(i);
			if (mi instanceof ActionItem) {
				try {
					((ActionItem) mi).setActionStatus();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		// TODO не отображается изменение состояния действия Disabled/Enabled
		// ctxMenu.markForRedraw();
		ctxMenu.redraw();
	}
}
