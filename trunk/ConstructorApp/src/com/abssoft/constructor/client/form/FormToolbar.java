package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.ButtonItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.events.ClickEvent;
import com.smartgwt.client.widgets.form.fields.events.ClickHandler;
import com.smartgwt.client.widgets.grid.ListGrid;

public class FormToolbar extends DynamicForm {
	private FormItem[] formItems;
	private MainFormPane mainFormPane;

	public FormToolbar(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		setWidth("*");
		setNumCols(16);
	}

	public void createButtons() {
		FormActionsArr formActionsArr = mainFormPane.getFormMetadata().getActions();
		int btnCnt = formActionsArr.size();
		formItems = new FormItem[1 + 1 + btnCnt];
		for (int i = 0; i < btnCnt; i++) {
			FormActionMD m = formActionsArr.get(i);
			formItems[i] = new ButtonItem(m.getDisplayName());
			((ButtonItem) formItems[i]).setIcon(ConstructorApp.menus.getIcons().get(m.getIconId()));
			formItems[i].setHeight(18);
			formItems[i].setStartRow(false);
			formItems[i].setEndRow(false);
			formItems[i].addClickHandler(new ButtonClickHandler(m));
		}
		// Refresh
		{
			formItems[btnCnt] = new ButtonItem(mainFormPane.getFormCode());
			formItems[btnCnt].setHeight(18);
			formItems[btnCnt].setStartRow(false);
			formItems[btnCnt].setEndRow(false);
			((ButtonItem) formItems[btnCnt]).setIcon("[SKIN]actions/refresh.png");

			// Временно Refresh повесил...
			formItems[btnCnt].addClickHandler(new ClickHandler() {
				@Override
				public void onClick(ClickEvent event) {
					mainFormPane.filterData();
				}
			});
		}

		{ // next record button
			btnCnt++;
			formItems[btnCnt] = new ButtonItem("1");
			formItems[btnCnt].setHeight(18);
			((ButtonItem) formItems[btnCnt]).setIcon("[SKIN]actions/next.png");
			formItems[btnCnt].setPrompt("next record");
			formItems[btnCnt].setStartRow(false);
			formItems[btnCnt].setEndRow(false);
			formItems[btnCnt].addClickHandler(new ClickHandler() {
				@Override
				public void onClick(ClickEvent event) {
					ListGrid g = mainFormPane.getMainForm().getTreeGrid();
					int currRecSelected = g.getRecordIndex(g.getSelectedRecord());
					g.selectSingleRecord(++currRecSelected);
					mainFormPane.filterDetailData(g.getRecord(currRecSelected), g);
					event.getItem().setTitle((currRecSelected + 1) + "");
				}
			});
		}

		setItems(formItems);
	}

	class ButtonClickHandler implements ClickHandler {
		private FormActionMD m;

		ButtonClickHandler(FormActionMD m) {
			this.m = m;
		}

		@Override
		public void onClick(ClickEvent event) {
			if ("2".equals(m.getType())) {
				mainFormPane.setCurrentActionCode(m.getCode());
				// TODO Проблема с DynamicForm.ItemChangedHandler в хроме -
				// приходится сохранять данные RichTextItem не по событию, а по
				// кнопке сохранения
				if (1 == 1 || Utils.isChrome()) {
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
				mainFormPane.getMainForm().getTreeGrid().saveAllEdits();
			}
		}
	}
}
