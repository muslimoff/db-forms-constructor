package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.form.MainForm;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.types.Visibility;
import com.smartgwt.client.util.BooleanCallback;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.CloseClickEvent;
import com.smartgwt.client.widgets.events.CloseClickHandler;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.EditorEnterEvent;
import com.smartgwt.client.widgets.grid.events.RowEditorEnterEvent;
import com.smartgwt.client.widgets.tab.Tab;

public class FormAction {

	private MainFormPane mainFormPane;
	private FormActionMD formActionMD;
	private ListGrid grid;

	FormAction(MainFormPane mainFormPane, FormActionMD formActionMD) {
		this.mainFormPane = mainFormPane;
		this.formActionMD = formActionMD;
		this.grid = mainFormPane.getMainForm().getTreeGrid();
	}

	/********************************************************************/
	// TODO Проблема при сохранении записи из контекстного меню в случае, если фокус не на данной форме.
	private void doSaveEditedData(Integer recordIndex) {
		Utils.debug("doSaveEditedData1");

		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		// int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		// TODO Проблема с DynamicForm.ItemChangedHandler в хроме - приходится сохранять данные RichTextItem не по событию, а по кнопке
		// сохранения
		if (Utils.isChrome()) {
			for (DynamicForm form : mainFormPane.getValuesManager().getMembers()) {
				Utils.debug("form: " + form);
				for (FormItem formItem : form.getFields()) {
					if (form.getItem(formItem.getName()) instanceof RichTextItem) {
						// System.out.println(formItem.getValue());
						// System.out.println("-------------------");
						// System.out.println();
					}
				}
			}
		}

		int[] editRowsArr = null != recordIndex ? new int[] { recordIndex } : grid.getAllEditRows();
		Utils.debug("doSaveEditedData2. editRowsArr.length:" + editRowsArr.length);
		// Если нет редактирванных строк - бежим по выбранным (Selected) строчкам. для объединения doSaveEditedData и doExecuteCustomPLSQL
		// TODO - перенести в методы классов FormTreeGrid и FormTreeGrid
		if (0 != editRowsArr.length) {
			for (int i = 0; i < editRowsArr.length; i++) {
				int rIdx = editRowsArr[i];
				Utils.debug("doSaveEditedData3. editRowsArr[" + i + "]=" + rIdx);
				mainFormPane.getDataSource().setEditedRecordIndex(rIdx);
				// 20120628
				// mainFormPane.getMainForm().getTreeGrid().endEditing();
				if (grid instanceof MainForm.FormListGrid) {
					((MainForm.FormListGrid) grid).saveAllEdits(new int[] { rIdx });
				} else if (grid instanceof MainForm.FormTreeGrid) {
					((MainForm.FormTreeGrid) grid).saveAllEdits(new int[] { rIdx });
				}

			}
		} else {
			// ///////////////////
			editRowsArr = new int[grid.getSelectedRecords().length];
			Utils.debug("doSaveEditedData2a. editRowsArr.length:" + editRowsArr.length);
			int rIdx = 0;
			for (ListGridRecord r : grid.getSelectedRecords()) {
				int idx = grid.getRecordIndex(r);
				editRowsArr[rIdx] = idx;
				Utils.debug("doSaveEditedData2b. editRowsArr[" + rIdx + "]:" + editRowsArr[rIdx]);
				rIdx++;
			}

			for (int i : editRowsArr) {
				Utils.debug("Custom PL/SQL - 4. idx:" + i);
				mainFormPane.getDataSource().setEditedRecordIndex(i);
				grid.updateData(grid.getRecord(i));
			}
			// ////////////
		}
		Utils.debug("doSaveEditedData4");
	}

	/********************************************************************/
	//Походу избавился от нее. Удалить после выгрузки в SVN 
	@SuppressWarnings("unused")
	private void doExecuteCustomPLSQL(Integer recordIndex) {
		Utils.debug("Custom PL/SQL - start execution...");
		// Если указан recordIndex - то обновляем только эту запись. Иначе - все подряд
		ListGridRecord[] selRecArr = (null != recordIndex && -1 != recordIndex) ? new ListGridRecord[] { grid.getRecord(recordIndex) }
				: grid.getSelectedRecords();
		Utils.debug("Custom PL/SQL - 1. selRecArr.length:" + selRecArr.length);
		for (ListGridRecord r : selRecArr) {
			int idx = grid.getRecordIndex(r);
			Utils.debug("Custom PL/SQL - 4. idx:" + idx);
			mainFormPane.getDataSource().setEditedRecordIndex(idx);
			grid.updateData(grid.getRecord(idx));
		}
		// if (null != recordIndex && -1 != recordIndex) {
		// Utils.debug("Custom PL/SQL - 1...");
		// grid.updateData(grid.getRecord(recordIndex));
		// Utils.debug("Custom PL/SQL - 2...");
		// } else {
		// Utils.debug("Custom PL/SQL - 3...");
		// for (ListGridRecord r : grid.getSelectedRecords()) {
		//
		// int idx = grid.getRecordIndex(r);
		//
		// Utils.debug("Custom PL/SQL - 4. idx:" + idx);
		// // mainFormPane.getDataSource().setEditedRecordIndex(idx);
		// grid.updateData(grid.getRecord(idx));
		// }
		// Utils.debug("Custom PL/SQL - 5...");
		// }
		Utils.debug("Custom PL/SQL - end execution...");
	}

	/********************************************************************/
	private void doAddNewRecord() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		grid.deselectAllRecords();
		grid.startEditingNew();
//		TODO grid.getRecordList().addAt(record, pos);
	}

	/********************************************************************/
	private void doRemoveRecords(Integer recordIndex) {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		try {
			if (null != recordIndex) {
				grid.removeData(grid.getRecord(recordIndex));
			} else {
				grid.removeSelectedData();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		mainFormPane.getValuesManager().clearValues();
	}

	/********************************************************************/
	private void doRefreshFormData() {
		mainFormPane.filterData();
	}

	/********************************************************************/
	private void doGoToPrevRow() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		// int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
		if (currRecSelected > 0) {
			grid.selectSingleRecord(--currRecSelected);
			mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
		}
	}

	/********************************************************************/
	private void doGoToNextRow() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		// int currRecSelected = grid.getRecordIndex(grid.getSelectedRecord());
		if (currRecSelected + 1 < grid.getTotalRows()) {
			grid.selectSingleRecord(++currRecSelected);
			mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
		}
	}

	/********************************************************************/
	private void doExistingRecordStartEditing() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		// TODO - Смарты сломали редактирование в Режиме скрипта. В режиме хостед - все работает
		Utils.debug("New Record - start execution...");
		// /mm20110508 grid.startEditing(mainFormPane.getSelectedRow(), 0, false);
		{
			grid.fireEvent(new EditorEnterEvent(grid.getRecord(currRecSelected).getJsObj()));
			grid.fireEvent(new RowEditorEnterEvent(grid.getJsObj()));
			grid.startEditing(mainFormPane.getSelectedRow(), 0, false);
		}

		Utils.debug("New Record - end execution...");
	}

	/********************************************************************/
	private void doShowHideFilter() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		grid.setShowFilterEditor(!grid.getShowFilterEditor());
	}

	/********************************************************************/
	private void doOpenFormInTab() {
		FormActionMD formActionMD = mainFormPane.getCurrentAction();
		String title = formActionMD.getDisplayName();
		try {
			title = Utils.replaceBindVariables(mainFormPane, title);

		} catch (Exception e) {
			e.printStackTrace();
		}
		title = mainFormPane.getFormMetadata().getFormName() + " - " + title;
		TabSet t = mainFormPane.getMainFormContainer().getParentTabSet();
		new MainFormContainer(FormTab.TabType.MAIN, t, formActionMD.getChildFormCode(), false, true, true, mainFormPane, title,
				mainFormPane.getFormMetadata().getIconId(), true);
	}

	/********************************************************************/
	private void doOpenFormInSubwindow() {
		FormActionMD formActionMD = mainFormPane.getCurrentAction();
		String title = formActionMD.getDisplayName();
		try {
			title = Utils.replaceBindVariables(mainFormPane, title);

		} catch (Exception e) {
			e.printStackTrace();
		}
		title = mainFormPane.getFormMetadata().getFormName() + " - " + title;
		final TabSet t = new TabSet();
		t.setTabBarPosition(Side.BOTTOM);
		new MainFormContainer(FormTab.TabType.MAIN, t, formActionMD.getChildFormCode(), false, false, true, mainFormPane, title,
				mainFormPane.getFormMetadata().getIconId(), true);
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
			public void onCloseClick(CloseClickEvent event) {
				try {
					for (Tab tab : t.getTabs()) {
						t.removeMainFormContainerTab(tab, false);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				w.destroy();
			}
		});
		w.show();
	}

	/********************************************************************/
	private void doGridExport() {
		Utils.debug("doGridExport........");
		FormActionMD formActionMD = mainFormPane.getCurrentAction();
		// String actionUrl = formActionMD.getUrlText();
		String actionUrl = null != formActionMD.getUrlText() ? formActionMD.getUrlText() : formActionMD.getSqlProcedureName();
		actionUrl = Utils.replaceBindVariables(mainFormPane, actionUrl, ":");
		actionUrl = null != actionUrl ? actionUrl : "xmlp?type=xslt" + "&ContentType=application/vnd.ms-excel"
				+ "&contentDisposition=attachment" + "&filename=rep1.xls" + "&template=EXP";
		mainFormPane.getMainForm().exportGrid(GWT.getModuleBaseURL() + actionUrl);

	}

	/********************************************************************/
	private void doAction(Integer recordIndex) {
		final ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		mainFormPane.setCurrentAction(formActionMD);
		String title = formActionMD.getDisplayName();
		try {
			title = Utils.replaceBindVariables(mainFormPane, title);

		} catch (Exception e) {
			e.printStackTrace();
		}
		Utils.debug("doAction-5;" + grid.getEditRow() + ";"); // + mainFormPane.getWarnButtonIdx());
		// String xmlpUrl = GWT.getModuleBaseURL() + title;
		title = mainFormPane.getFormMetadata().getFormName() + " - " + title;
		Utils.debug("doAction-6");
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		Utils.debug("doAction-7");
		String actionType = formActionMD.getType();
		Utils.debug("doAction-8:" + actionType + "; currRecSelected:" + currRecSelected + "; recordIndex:" + recordIndex);
		// New Record
		if ("1".equals(actionType)) {
			doAddNewRecord();
		}
		// updateData/saveAllEdits
		else if ("2".equals(actionType)) {
			Utils.debug("updateData/saveAllEdits1");
			doSaveEditedData(recordIndex);
			Utils.debug("updateData/saveAllEdits2");
		}
		// Remove records
		else if ("3".equals(actionType)) {
			doRemoveRecords(recordIndex);
		}
		// Refresh
		else if ("4".equals(actionType)) {
			doRefreshFormData();
		}
		// Go to prev record
		else if ("5".equals(actionType)) {
			doGoToPrevRow();
		}
		// Go to next record
		else if ("6".equals(actionType)) {
			doGoToNextRow();
		}
		// Custom PL/SQL
		else if ("7".equals(actionType)) {
			// doExecuteCustomPLSQL(recordIndex);
			doSaveEditedData(recordIndex);
		}
		// StartEditingExistingRecord
		else if ("8".equals(actionType)) {
			doExistingRecordStartEditing();
		}
		// Filter
		else if ("9".equals(actionType)) {
			doShowHideFilter();
		}
		// Form in new AppTabSet
		else if ("10".equals(actionType)) {
			doOpenFormInTab();
		}
		// Form in new Window
		else if ("11".equals(actionType)) {
			doOpenFormInSubwindow();
		}
		// Export grid
		else if ("12".equals(actionType)) {
			doGridExport();
		} // Open Url
		else if ("15".equals(actionType)) {
			int recIdxInternal = null == recordIndex ? currRecSelected : recordIndex;
			Utils.openURL(formActionMD, grid.getRecord(recIdxInternal), mainFormPane);
			// Validation
		} else if ("16".equals(actionType)) {
			// 20121005 - алерты в процедуре валидации
			{
				int recIdxInternal = null == recordIndex ? currRecSelected : recordIndex;
				mainFormPane.getDataSource().setEditedRecordIndex(recIdxInternal);
			}
			mainFormPane.getMainForm().setNewRecDefaultValues(currRecSelected, false);
		}
		// Close FormTabset/Window
		else if ("17".equals(actionType)) {
			Utils.debug("Action 17.1");
			TabSet tabSet = mainFormPane.getMainFormContainer().getParentTabSet();
			Utils.debug("Action 17.2");
			boolean isWindow = null != tabSet.getParentElement() && null != tabSet.getParentElement().getParentElement()
					&& tabSet.getParentElement().getParentElement() instanceof Window;

			// boolean isWindow = null != tabSet.getParentElement() && tabSet.getParentElement() instanceof Window;
			Utils.debug("Action 17.3;" + isWindow);
			if (isWindow || mainFormPane.getMainFormContainer().getCanClose()) {
				Utils.debug("Action 17.4");
				tabSet.removeMainFormContainerTab(mainFormPane.getMainFormContainer(), false);
				Utils.debug("Action 17.5");
				if (isWindow) {
					Utils.debug("Action 17.6");
					Utils.debug("Action 17.7" + tabSet.getParentElement());
					Utils.debug("Action 17.8" + tabSet.getParentElement().getParentElement());
					tabSet.getParentElement().getParentElement().destroy();
					Utils.debug("Action 17.9");
				}
			}
		}
		// /TEST ACTION 99
		else if ("99".equals(actionType)) {
			// mainFormPane.hideTabBar();
		}
	}

	public void doActionWithConfirm(final Integer recordIndex) {
		if (!Visibility.HIDDEN.equals(mainFormPane.getVisibility())) {
			String confirmText = formActionMD.getConfirmText();
			if (null != confirmText) {
				Utils.debug("ActionButtonClickHandler. Replace: " + confirmText);
				SC.confirm("Подтверждение", Utils.replaceBindVariables(mainFormPane, formActionMD.getConfirmText()), new BooleanCallback() {
					public void execute(Boolean value) {
						if (null != value && value) {
							doAction(recordIndex);
						}
					}
				});
			} else {
				doAction(recordIndex);
			}
		}
	}
}
