package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.grid.ListGrid;

public class FormToolbar extends DynamicForm {
	private MainFormPane mainFormPane;

	public FormToolbar(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		setWidth("*");
		setNumCols(16);
	}

	public void createButtons() {
		FormActionsArr formActionsArr = mainFormPane.getFormMetadata().getActions();

		final int bCnt = formActionsArr.size();
		ToolbarItem t = new ToolbarItem();
		IButton[] btns = new IButton[bCnt + 2];
		for (int i = 0; i < formActionsArr.size(); i++) {
			FormActionMD m = formActionsArr.get(i);
			btns[i] = new IButton(m.getDisplayName());
			btns[i].setPrompt(m.getDisplayName());
			btns[i].setIcon(ConstructorApp.menus.getIcons().get(m.getIconId()));
			btns[i].addClickHandler(new ButtonClickHandler(m));
		}

		// Refresh
		IButton refreshBtn = new IButton(mainFormPane.getFormCode());
		refreshBtn.setIcon("[SKIN]actions/refresh.png");
		refreshBtn.addClickHandler(new com.smartgwt.client.widgets.events.ClickHandler() {
			@Override
			public void onClick(com.smartgwt.client.widgets.events.ClickEvent event) {
				mainFormPane.filterData();
			}
		});

		// next record button
		IButton nextBtn = new IButton("1");
		nextBtn.setIcon("[SKIN]actions/next.png");
		nextBtn.setPrompt("next record");
		nextBtn.addClickHandler(new com.smartgwt.client.widgets.events.ClickHandler() {
			@Override
			public void onClick(com.smartgwt.client.widgets.events.ClickEvent event) {
				ListGrid g = mainFormPane.getMainForm().getTreeGrid();
				int currRecSelected = g.getRecordIndex(g.getSelectedRecord());
				g.selectSingleRecord(++currRecSelected);
				mainFormPane.filterDetailData(g.getRecord(currRecSelected), g);
				((IButton) event.getSource()).setTitle((currRecSelected + 1) + "");
			}
		});
		btns[bCnt] = refreshBtn;
		btns[bCnt + 1] = nextBtn;
		t.setButtons(btns);
		setItems(t);
	}

	class ButtonClickHandler implements com.smartgwt.client.widgets.events.ClickHandler {
		private FormActionMD m;

		ButtonClickHandler(FormActionMD m) {
			this.m = m;
		}

		@Override
		public void onClick(com.smartgwt.client.widgets.events.ClickEvent event) {
			ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
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
				grid.saveAllEdits();
			} else if ("1".equals(m.getType())) {
				mainFormPane.setCurrentActionCode(m.getCode());
				grid.startEditingNew();

			} else if ("3".equals(m.getType())) {
				mainFormPane.setCurrentActionCode(m.getCode());
				grid.removeSelectedData();
			}

		}
	}
}
