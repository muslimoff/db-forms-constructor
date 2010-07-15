package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.Iterator;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.types.Visibility;
import com.smartgwt.client.util.BooleanCallback;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.CloseClickHandler;
import com.smartgwt.client.widgets.events.CloseClientEvent;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;
import com.smartgwt.client.widgets.menu.MenuItemStringFunction;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;
import com.smartgwt.client.widgets.tab.Tab;

public class FormToolbar extends DynamicForm {
	class ActionItem extends MenuItem {
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
			this.addClickHandler(new ClickHandler() {
				@Override
				public void onClick(MenuItemClickEvent event) {
					doActionWithConfirm();
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
						doActionWithConfirm();
					}
				});
				//
				// button.setWidth(button.getHeight());
				// button.setTitle("");
			}
			this.setDynamicTitleFunction(new MenuItemStringFunction() {
				@Override
				public String execute(Canvas target, Menu menu, MenuItem item) {
					String title = ActionItem.this.getFormActionMD().getDisplayName();
					try {
						title = xxx(title);

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
						int currRow = 0;
						try {
							ListGridRecord r = grid.getSelectedRecord();
							currRow = grid.getRecordIndex(r);
						} catch (Exception e) {
							// e.printStackTrace();
						}
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
						e.printStackTrace();
					}
					return result;
				}
			});
		}

		public void doActionWithConfirm() {
			FormToolbar.this.doActionWithConfirm(getFormActionMD(), this);
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

	private ArrayList<MenuItem> actionMenuItemsArr = new ArrayList<MenuItem>();
	private ArrayList<IButton> actionButtonsArr = new ArrayList<IButton>();
	private MainFormPane mainFormPane;
	private Menu ctxMenu;
	private ToolbarItem btnToolbar = new ToolbarItem();
	private IButton[] btns;
	private ActionItem doubleClickActItem;

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
			if (formActionMD.getCode().equals(mainFormPane.getFormMetadata().getDoubleClickActionCode())) {
				doubleClickActItem = actionItem;
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

	public void doAction(final FormActionMD m, ActionItem item) {
		System.out.println("doAction-1");
		final ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		System.out.println("doAction-2");
		mainFormPane.setCurrentActionCode(m.getCode());
		System.out.println("doAction-3");
		String title = item.getFormActionMD().getDisplayName();
		System.out.println("doAction-4");
		try {
			title = xxx(title);

		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("doAction-5");
		// String xmlpUrl = GWT.getModuleBaseURL() + title;
		title = mainFormPane.getFormMetadata().getFormName() + " - " + title;
		System.out.println("doAction-6:" + m.getType());
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
		}
		// New Record
		else if ("1".equals(m.getType())) {
			System.out.println("doAction-7:1.1");
			grid.deselectAllRecords();
			System.out.println("doAction-7:1.2");
			grid.startEditingNew();
			System.out.println("doAction-7:1.3");
		}
		// Remove records
		else if ("3".equals(m.getType())) {
			try {
				grid.removeSelectedData();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mainFormPane.getValuesManager().clearValues();
		}// Refresh
		else if ("4".equals(m.getType())) {
			mainFormPane.filterData();
		} // prev record
		else if ("5".equals(m.getType())) {
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			if (currRecSelected > 0) {
				grid.selectSingleRecord(--currRecSelected);
				mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
			}
		} // next record
		else if ("6".equals(m.getType())) {
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			if (currRecSelected + 1 < grid.getTotalRows()) {
				grid.selectSingleRecord(++currRecSelected);
				mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
			}
		} // Custom PL/SQL
		else if ("7".equals(m.getType())) {
			System.out.println("Custom PL/SQL - start execution...");
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			grid.updateData(grid.getRecord(currRecSelected));
			System.out.println("Custom PL/SQL - end execution...");
		} // New Record
		else if ("8".equals(m.getType())) {
			System.out.println("New Record - start execution...");
			grid.startEditing(mainFormPane.getSelectedRow(), 0, false);
			System.out.println("New Record - end execution...");
		} // Filter
		else if ("9".equals(m.getType())) {
			grid.setShowFilterEditor(!grid.getShowFilterEditor());
		} // Form in new AppTabSet
		else if ("10".equals(m.getType())) {
			TabSet t = mainFormPane.getMainFormContainer().getParentTabSet();
			new MainFormContainer(FormTab.TabType.MAIN, t, m.getChildFormCode(), false, true, true, mainFormPane, title, mainFormPane
					.getFormMetadata().getIconId(), true);
		}// Form in new Window
		else if ("11".equals(m.getType())) {
			{
				final TabSet t = new TabSet();
				t.setTabBarPosition(Side.BOTTOM);
				new MainFormContainer(FormTab.TabType.MAIN, t, m.getChildFormCode(), false, false, true, mainFormPane, title, mainFormPane
						.getFormMetadata().getIconId(), true);
				final Window w = new Window();
				w.setWidth("80%");
				w.setHeight("80%");
				w.setTitle(title);
				w.setShowMinimizeButton(false);
				w.setShowMaximizeButton(true);
				w.setIsModal(true);
				w.setShowModalMask(true);
				w.setCanDragResize(true);
				w.centerInPage();
				w.addItem(t);

				w.addCloseClickHandler(new CloseClickHandler() {
					@Override
					public void onCloseClick(CloseClientEvent event) {
						try {
							for (Tab tab : t.getTabs()) {
								t.removeMainFormContainerTab(tab);
							}
						} catch (Exception e) {
							e.printStackTrace();
						}
						w.destroy();
					}
				});
				w.show();
			}
		} else if ("12".equals(m.getType())) {
			mainFormPane.getMainForm().exportGrid();
		} else if ("15".equals(m.getType())) {
			try {
				String xmlpUrl = GWT.getModuleBaseURL() + xxx(m.getSqlProcedureName(), ":");
				System.out.println(xmlpUrl);
				// com.google.gwt.user.client.Window.open(xmlpUrl, "_new",
				// "menubar=no,location=no,resizable=no,scrollbars=no,status=no,width=250,height=150,navigation=no");
				com.google.gwt.user.client.Window.open(xmlpUrl, "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public String xxx(String str) {
		return xxx(str, "&");
	}

	public String xxx(String str, String chr) {
		String result = str;
		try {
			FormColumnsArr fca = mainFormPane.getFormMetadata().getColumns();
			if (null != str && str.contains(chr)) {
				Iterator<Integer> itr = fca.keySet().iterator();
				while (itr.hasNext()) {
					String columnName = fca.get(itr.next()).getName();
					// String columnValue = mainFormPane.getMainForm().getTreeGrid().getSelectedRecord().getAttribute(columnName);
					ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
					try {
						String columnValue = grid.getSelectedRecord().getAttribute(columnName);
						result = result.replaceAll(chr + columnName.toLowerCase() + chr, columnValue);
						Utils.debug("columnName:" + columnName + "; columnValue:" + columnValue + "; result:" + result);
					} catch (Exception e) {
						Utils.debug("xxx1. Error:" + e.getMessage());
					}
				}
			}
		} catch (Exception e) {
			Utils.debug("xxx. Error:" + e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	public void doActionWithConfirm(final FormActionMD m, final ActionItem item) {
		if (!Visibility.HIDDEN.equals(mainFormPane.getVisibility())) {
			String confirmText = m.getConfirmText();
			if (null != confirmText) {
				Utils.debug("ActionButtonClickHandler. Replace: " + confirmText);
				SC.confirm("Подтверждение", xxx(m.getConfirmText()), new BooleanCallback() {
					public void execute(Boolean value) {
						if (null != value && value) {
							doAction(m, item);
						}
					}
				});
			} else {
				doAction(m, item);
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
	}

	public void setDoubleClickActItem(ActionItem doubleClickActItem) {
		this.doubleClickActItem = doubleClickActItem;
	}

	public ActionItem getDoubleClickActItem() {
		return doubleClickActItem;
	}
}
