package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormPane.FormValuesManager;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.smartgwt.client.data.Criteria;
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
	private ArrayList<MenuItem> actionMenuItemsArr = new ArrayList<MenuItem>();
	private ArrayList<IButton> actionButtonsArr = new ArrayList<IButton>();

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
				button.setPrompt(displayName);
				button.setIcon(iconPath);
				button.addClickHandler(new ActionButtonClickHandler(formActionMD));
			}

		}

		public IButton getButton() {
			return button;
		}

		public FormActionMD getFormActionMD() {
			return formActionMD;
		}

		public void setButton(IButton button) {
			this.button = button;
		}

		public void setFormActionMD(FormActionMD formActionMD) {
			this.formActionMD = formActionMD;
		}

	}

	private MainFormPane mainFormPane;

	private Menu ctxMenu;

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
		ToolbarItem t = new ToolbarItem();
		IButton[] btns = new IButton[actionButtonsArr.size()];
		for (int i = 0; i < actionButtonsArr.size(); i++) {
			btns[i] = actionButtonsArr.get(i);
		}

		t.setButtons(btns);
		ctxMenu.setData(menuItems);
		this.setContextMenu(ctxMenu);
		mainFormPane.setContextMenu(ctxMenu);
		t.setStartRow(false);
		setItems(formNameItem, t);
	}

	public void doAction(final FormActionMD m) {
		final ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		mainFormPane.setCurrentActionCode(m.getCode());
		if ("2".equals(m.getType())) {
			// TODO Проблема с DynamicForm.ItemChangedHandler в хроме - приходится сохранять данные RichTextItem не по событию, а по кнопке
			// сохранения
			if (Utils.isChrome()) {
				for (DynamicForm form : mainFormPane.getValuesManager().getMembers()) {
					System.out.println("form: " + form);
					for (FormItem formItem : form.getFields()) {
						if (form.getItem(formItem.getName()) instanceof RichTextItem) {
							System.out.println(formItem.getValue());
							System.out.println("-------------------");
							System.out.println();
						}
					}
				}
			}
			grid.saveAllEdits();
		} else if ("1".equals(m.getType())) {
			Map<String, Object> defVals = new LinkedHashMap<String, Object>();
			for (FormDataSourceField dsf : mainFormPane.getDataSource().getFormDSFields()) {

				String defVal = dsf.getColumnMD().getDefaultValue();
				String dataType = dsf.getColumnMD().getDataType();
				if (null != defVal) {
					if (null != mainFormPane.getParentFormPane()) {
						Criteria cc = mainFormPane.getParentFormPane().getInitialFilter();
						for (String s : cc.getAttributes()) {
							String attrVal = cc.getAttribute(s);
							attrVal = (null == attrVal) ? "" : attrVal;
							try {
								defVal = defVal.replaceAll("&" + s.toLowerCase() + "&", attrVal);
							} catch (Exception e) {
								e.printStackTrace();
								Utils.debug("Err: >>>>>>>>>>>" + e.getMessage());
							}
						}
					}
					Utils.debug("$$5>> Default Value: After Bind variables replaced: " + dsf.getName() + " => " + defVal);
					System.out.println("$$$$$$$$ DataType:" + dsf.getColumnMD().getDataType());
					if ("B".equals(dataType)) {
						defVals.put(dsf.getName(), "1".equals(defVal) || "Y".equals(defVal));
					} else {
						defVals.put(dsf.getName(), defVal);
					}
				}
			}
			grid.startEditingNew(defVals);
			((FormValuesManager) mainFormPane.getValuesManager()).editRecord2();
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
			System.out.println("xxxxxxxxx");
			int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
			grid.updateData(grid.getRecord(currRecSelected));
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
}
