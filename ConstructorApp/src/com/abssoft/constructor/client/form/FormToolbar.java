package com.abssoft.constructor.client.form;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormPane.FormValuesManager;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.util.BooleanCallback;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.grid.ListGrid;

public class FormToolbar extends DynamicForm {
	private MainFormPane mainFormPane;

	public FormToolbar(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		setWidth("*");
		setNumCols(4);
	}

	public void createButtons() {
		FormActionsArr formActionsArr = mainFormPane.getFormMetadata().getActions();

		final int bCnt = formActionsArr.size();
		ToolbarItem t = new ToolbarItem();
		IButton[] btns = new IButton[bCnt];
		for (int i = 0; i < formActionsArr.size(); i++) {
			FormActionMD m = formActionsArr.get(i);
			btns[i] = new IButton(m.getDisplayName());
			btns[i].setPrompt(m.getDisplayName());
			btns[i].setIcon(ConstructorApp.menus.getIcons().get(m.getIconId()));
			btns[i].addClickHandler(new ActionButtonClickHandler(m));
		}

		t.setButtons(btns);
		t.setStartRow(false);

		String formName = mainFormPane.getFormMetadata().getFormName();
		formName = null != formName ? formName : mainFormPane.getFormCode();

		TextItem formNameItem = new TextItem();
		formNameItem.setValue(formName);
		formNameItem.setDisabled(true);
		formNameItem.setEndRow(false);
		formNameItem.setWidth("200");
		formNameItem.setShowTitle(false);
		setItems(formNameItem, t);
	}

	class ActionButtonClickHandler implements com.smartgwt.client.widgets.events.ClickHandler {
		private FormActionMD m;

		ActionButtonClickHandler(final FormActionMD m) {
			this.m = m;
		}

		@Override
		public void onClick(com.smartgwt.client.widgets.events.ClickEvent event) {
			String confirmText = m.getConfirmText();
			if (null != confirmText) {
				// if (confirmText.contains(":"))
				{
					Utils.debug("ActionButtonClickHandler. Replace: " + confirmText);
					FormColumnsArr fca = mainFormPane.getFormMetadata().getColumns();
					Utils.debug("z1");
					Iterator<Integer> itr = fca.keySet().iterator();
					Utils.debug("z2");
					while (itr.hasNext()) {
						Utils.debug("z3");
						String columnName = fca.get(itr.next()).getName();
						try {
							Utils.debug("z4");
							String columnValue = mainFormPane.getMainForm().getTreeGrid().getSelectedRecord().getAttribute(columnName);
							Utils.debug("z5");
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
				Utils.debug("$$1>> defVal:" + defVal);
				if (null != defVal) {
					if (null != mainFormPane.getParentFormPane()) {
						Criteria cc = mainFormPane.getParentFormPane().getInitialFilter();
						for (String s : cc.getAttributes()) {
							String attrVal = cc.getAttribute(s);
							attrVal = (null == attrVal) ? "" : attrVal;
							Utils.debug("$$2>> " + s + " : " + attrVal);
							try {
								defVal = defVal.replaceAll("&" + s.toLowerCase() + "&", attrVal);
							} catch (Exception e) {
								e.printStackTrace();
								Utils.debug("Err: >>>>>>>>>>>" + e.getMessage());
							}
							Utils.debug("$$3>> " + s);
						}
						Utils.debug("$$4>> ");
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
}
