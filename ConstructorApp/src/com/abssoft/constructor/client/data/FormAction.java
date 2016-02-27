package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.form.MainForm;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormTabMD;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.DSCallback;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.rpc.RPCResponse;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.types.Visibility;
import com.smartgwt.client.util.BooleanCallback;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.CloseClickEvent;
import com.smartgwt.client.widgets.events.CloseClickHandler;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tree.TreeGrid;
import com.smartgwt.client.widgets.tree.TreeNode;

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

		// 20130514 - обнаружнен косяк - при создании новой записи - сброс сортировки в гриде
		mainFormPane.setSortState(grid.getSortState());

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
	private void doAddNewRecord() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		grid.deselectAllRecords();
		grid.startEditingNew();
		// TODO grid.getRecordList().addAt(record, pos);
	}

	private void doAddNewRecordInPos(int currRecSelected) {
		Utils.debugAlert("zz1: " + grid.getResultSet().getLength());
		final DataSource ds = grid.getDataSource(); // = mainFormPane.getDataSource();
		final Record prototypeRec = ds.copyRecord(grid.getRecord(currRecSelected));
		final Record r = new Record();
		JSOHelper.apply(prototypeRec.getJsObj(), r.getJsObj());
		r.setAttribute("NM", r.getAttribute("NM") + "#");
		Utils.debugRecord(prototypeRec, "XXXXXXXXXXXXXX");
		Utils.debugRecord(r, "XXXXXXXXXXXXXX");
		grid.addData(r, new DSCallback() {

			@Override
			public void execute(DSResponse response, Object rawData, DSRequest request) {
				response.setData(new Record[] { r });
				response.setStatus(RPCResponse.STATUS_VALIDATION_ERROR);
				// ds.processResponse(request.getRequestId(), response);
				doExistingRecordStartEditing(grid.getRecordIndex(r));
			}
		});
		Utils.debugAlert("zz2: " + grid.getResultSet().getLength() + "; r:" + r);
	}

	private void doAddNewRecordInPosLocalOld() {
		// ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		// grid.deselectAllRecords();
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		// Если нет записей - создаем по старому, как раньше.
		if (-1 == currRecSelected) {
			doAddNewRecord();
		} else {
			Utils.debugAlert("AAA1:" + currRecSelected);
			// 2012 12 09 - нифига не раобтает...
			// com.google.gwt.core.client.JavaScriptException: (TypeError): this.addAt is not a function
			// козлы - только для локальных (не результсетных операций.
			// Единственный пока вариант
			// а) PL/SQL для создания заготовки на сервере,
			// б) потом рефреш
			// в) потом - позиционирование на первую запись и редачиться.
			Record r = grid.getResultSet().addAt(grid.getRecord(currRecSelected), currRecSelected);
			grid.getRecordList().add(grid.getRecord(currRecSelected));
			Utils.debugAlert("AAA2:" + currRecSelected);
			// grid.getRecordList().addAt(((Record) grid.getRecord(currRecSelected)), currRecSelected);
		}
		Utils.debugAlert("AAA3:" + currRecSelected);

		// Создание новой записи (Record) для дальнейшего автозаполнения
		// TreeNode result = new TreeNode();
		//		
		// for (int c = 0; null != row && c < row.size(); c++) {
		//			
		// }
		// grid.startEditingNew();
		// TODO grid.getRecordList().addAt(record, pos);
	}

	/********************************************************************/
	private void doRemoveRecords(Integer recordIndex) {
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
		// mainFormPane.setPrevParentFormCriteria1();
		Utils.debug("FormAction.doRefreshFormData. Before filterData 1.");
		mainFormPane.filterData(mainFormPane.getParentFormCriteria(), true);
	}

	/********************************************************************/
	private void doGoToPrevRow() {
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		if (currRecSelected > 0) {
			grid.selectSingleRecord(--currRecSelected);
			Utils.debug("FormAction.doGoToPrevRow. Before mainFormPane.filterDetailData");
			mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
		}
	}

	/********************************************************************/
	private void doGoToNextRow() {
		int currRecSelected = mainFormPane.getMainForm().getSelectedRecord();
		if (currRecSelected + 1 < grid.getTotalRows()) {
			grid.selectSingleRecord(++currRecSelected);
			Utils.debug("FormAction.doGoToNextRow. Before mainFormPane.filterDetailData");
			mainFormPane.filterDetailData(grid.getRecord(currRecSelected), grid, currRecSelected);
		}
	}

	/********************************************************************/
	private void doExistingRecordStartEditing(int currRecSelected) {
		grid.startEditing(currRecSelected, Boolean.TRUE.equals(grid.getShowRowNumbers()) ? 1 : 0, false);
	}

	/********************************************************************/
	private void doShowHideFilter() {
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
		new MainFormContainer(mainFormPane.getThisFormCriteria(), new FormTabMD(), FormTab.TabType.MAIN, t, formActionMD.getChildFormCode() // ,
		// false
		, true, true, mainFormPane, title, mainFormPane.getFormMetadata().getIconId(), true);
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
		new MainFormContainer(mainFormPane.getThisFormCriteria(), new FormTabMD(), FormTab.TabType.MAIN, t, formActionMD.getChildFormCode() // ,
		// false
		, false, true, mainFormPane, title, mainFormPane.getFormMetadata().getIconId(), true);
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
		String actionUrl = null != formActionMD.getUrlText() ? formActionMD.getUrlText() : formActionMD.getSqlProcedureName();
		actionUrl = Utils.replaceBindVariables(mainFormPane, actionUrl, ":");
		actionUrl = null != actionUrl ? actionUrl
				: "xmlp?type=xslt" + "&ContentType=application/vnd.ms-excel" + "&contentDisposition=attachment" + "&filename=rep1.xls"
						+ "&template=EXP";
		mainFormPane.getMainForm().exportGrid(GWT.getModuleBaseURL() + actionUrl);

	}

	/********************************************************************/
	private void doRefreshTreeNode( // Integer recordIndex
	) {
		if (grid instanceof TreeGrid) {
			TreeGrid treeGrid = (TreeGrid) grid;
			for (ListGridRecord lr : treeGrid.getSelectedRecords()) {
				TreeNode node = (TreeNode) lr;
				// Boolean isOpen = treeGrid.getData().isOpen(node);
				//TODO. treeGrid.getData().reloadChildren(node);
				treeGrid.getData().unloadChildren(node);
				treeGrid.getData().closeFolder(node);
				// Нифига не заработало. Потом.
				// if (isOpen) {
				// 
				// // treeGrid.getTree().reloadChildren(treeNode);
				// // treeGrid.getTree().openFolder(treeNode);
				// treeGrid.getData().openFolder(node);
				// treeGrid.getData().reloadChildren(node);
				// }
			}
		}
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
			// doAddNewRecord();
			// doAddNewRecordInPos(currRecSelected);
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
			doExistingRecordStartEditing(currRecSelected);
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
			Canvas tabSetPrnt1 = tabSet.getParentElement();
			Canvas tabSetPrnt2 = null;
			if (null != tabSetPrnt1)
				tabSetPrnt2 = tabSet.getParentElement().getParentElement();
			boolean isWindow = (null != tabSetPrnt1) && (null != tabSetPrnt2) && (tabSetPrnt2 instanceof Window);

			// boolean isWindow = null != tabSet.getParentElement() && tabSet.getParentElement() instanceof Window;
			Utils.debug("Action 17.3;" + isWindow);
			if (isWindow || mainFormPane.getMainFormContainer().getCanClose()) {
				Utils.debug("Action 17.4");
				tabSet.removeMainFormContainerTab(mainFormPane.getMainFormContainer(), false);
				Utils.debug("Action 17.5");
				if (isWindow) {
					Utils.debug("Action 17.6");
					Utils.debug("Action 17.7" + tabSetPrnt1);
					Utils.debug("Action 17.8" + tabSetPrnt2);
					tabSetPrnt2.destroy();
					Utils.debug("Action 17.9");
				}
			}
		}
		// Refresh Tree Node
		else if ("18".equals(actionType)) {
			doRefreshTreeNode();
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
