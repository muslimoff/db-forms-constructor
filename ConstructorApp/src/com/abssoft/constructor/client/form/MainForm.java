package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.ActionItem;
import com.abssoft.constructor.client.data.DMLProcExecution;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.ResultSet;
import com.smartgwt.client.types.AnimationEffect;
import com.smartgwt.client.types.EditCompletionEvent;
import com.smartgwt.client.types.ListGridComponent;
import com.smartgwt.client.types.ListGridEditEvent;
import com.smartgwt.client.types.RowEndEditAction;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.ResizedEvent;
import com.smartgwt.client.widgets.events.ResizedHandler;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.DataArrivedEvent;
import com.smartgwt.client.widgets.grid.events.DataArrivedHandler;
import com.smartgwt.client.widgets.grid.events.EditorEnterEvent;
import com.smartgwt.client.widgets.grid.events.EditorEnterHandler;
import com.smartgwt.client.widgets.grid.events.EditorExitEvent;
import com.smartgwt.client.widgets.grid.events.EditorExitHandler;
import com.smartgwt.client.widgets.grid.events.RecordClickEvent;
import com.smartgwt.client.widgets.grid.events.RecordClickHandler;
import com.smartgwt.client.widgets.grid.events.RecordDoubleClickEvent;
import com.smartgwt.client.widgets.grid.events.RecordDoubleClickHandler;
import com.smartgwt.client.widgets.grid.events.RowContextClickEvent;
import com.smartgwt.client.widgets.grid.events.RowContextClickHandler;
import com.smartgwt.client.widgets.grid.events.RowEditorEnterEvent;
import com.smartgwt.client.widgets.grid.events.RowEditorEnterHandler;
import com.smartgwt.client.widgets.tree.Tree;
import com.smartgwt.client.widgets.tree.TreeGrid;
import com.smartgwt.client.widgets.tree.TreeNode;
import com.smartgwt.client.widgets.tree.events.FolderDropEvent;
import com.smartgwt.client.widgets.tree.events.FolderDropHandler;
import com.smartgwt.client.widgets.tree.events.FolderOpenedEvent;
import com.smartgwt.client.widgets.tree.events.FolderOpenedHandler;
import com.smartgwt.client.widgets.tree.events.NodeClickEvent;
import com.smartgwt.client.widgets.tree.events.NodeClickHandler;

//import com.smartgwt.client.widgets.ViewLoader;

public/*
	 * Грид с формой редактирования и верхней и нижней панельками
	 * 
	 * @author User
	 */
class MainForm extends Canvas {

	public class FormListGrid extends ListGrid {
		public FormListGrid() {
			this.setShowRowNumbers(true);
			// TODO Высота строки.. //
			this.setCellHeight(16);
			// TODO Группировка для больших записей
			this.setGroupByMaxRecords(10000);
			this.addEditorEnterHandler(new EditorEnterHandler() {

				@Override
				public void onEditorEnter(EditorEnterEvent event) {
					Utils.debug("FormListGrid.onEditorEnter started/ended...");

				}
			});
			this.addRowEditorEnterHandler(new RowEditorEnterHandler() {

				@Override
				public void onRowEditorEnter(RowEditorEnterEvent event) {
					Utils.debug("FormListGrid.onRowEditorEnter started/ended...");

				}
			});
		}

		// // 20121210 - косяк редактирования
		// public native Boolean startEditingInt(int rowNum, int colNum, Boolean suppressFocus) /*-{
		// $wnd.alert("1xxxxx "+rowNum+";"+colNum);
		// var self = this.@com.smartgwt.client.widgets.BaseWidget::getOrCreateJsObj()();
		// $wnd.alert("2xxxxx "+self);
		// var retVal =self.startEditing(rowNum, colNum, suppressFocus);
		// $wnd.alert("3xxxxx "+retVal);
		// if(retVal == null || retVal === undefined) {
		// return null;
		// } else {
		// return @com.smartgwt.client.util.JSOHelper::toBoolean(Z)(retVal);
		// }
		// }-*/;
		//
		// @Override
		// public Boolean startEditing(Integer rowNum, Integer colNum, Boolean suppressFocus) {
		// Utils.debug("FormListGrid.startEditing: " + this.getJsObj().toString());
		// // return super.startEditing(rowNum, colNum, suppressFocus);
		// // 20121210 - косяк редактирования - com.google.gwt.dev.shell.HostedModeException: invoke arguments: JS value of type Java
		// // Object com.google.gwt.dev.shell.JsValueOOPHM$DispatchObjectOOPHM, expected int
		// return startEditingInt(rowNum, colNum, suppressFocus);
		// }

		public native boolean saveAllEdits(int[] rows)
		/*-{
			var self = this.@com.smartgwt.client.widgets.BaseWidget::getOrCreateJsObj()();
			var rowsJS = rows == null ? null : @com.smartgwt.client.util.JSOHelper::convertToJavaScriptArray([I)(rows);
			return self.saveAllEdits(rowsJS);
		}-*/;

		// Пример добавления хендлера для эвентов. См. http://forums.smartclient.com/showthread.php?t=9923
		// @Override
		// public HandlerRegistration addRowEditorEnterHandler(RowEditorEnterHandler handler) {
		// Utils.debug("FormListGrid.Adding handler");
		// HandlerRegistration r = doAddHandler(handler, RowEditorEnterEvent.getType());
		// return r;
		// };

	}

	public class FormTreeGrid extends TreeGrid {

		public native boolean saveAllEdits(int[] rows)
		/*-{
			var self = this.@com.smartgwt.client.widgets.BaseWidget::getOrCreateJsObj()();
			var rowsJS = rows == null ? null : @com.smartgwt.client.util.JSOHelper::convertToJavaScriptArray([I)(rows);
			return self.saveAllEdits(rowsJS);
		}-*/;

		FormTreeGrid() {
			this.setShowConnectors(true);
			this.addNodeClickHandler(new NodeClickHandler() {

				public void onNodeClick(NodeClickEvent event) {
					Tree t = FormTreeGrid.this.getTree();
					TreeNode n = event.getNode();
					TreeNode[] parentNodes = t.getParents(n);
					String titlePath = "-";
					// Error Something other than a Java object was returned from JSNI method
					// '@com.smartgwt.client.widgets.tree.Tree::getTitle(Lcom/smartgwt/client/widgets/tree/TreeNode;)':JS value of type int,
					// expected java.lang.Object
					try {
						titlePath = t.getTitle(n);
					} catch (Exception e) {
						e.printStackTrace();
					}

					for (TreeNode nn : parentNodes) {
						String title = "";
						try {
							t.getTitle(nn);
						} catch (Exception e) {
							e.printStackTrace();
						}
						if (!"root".equals(title))
							titlePath = title + "/" + titlePath;
					}
					bottomToolBar.setStatus(titlePath);
				}

			});
			this.addFolderOpenedHandler(new FolderOpenedHandler() {

				@Override
				public void onFolderOpened(FolderOpenedEvent event) {
					Utils.debug("onFolderOpened>>>>" + event.getNode().getTitle());
					System.out.println("@@" + FormTreeGrid.this.getOpenState());
				}
			});
			this.setCanReorderRecords(true);
			this.setCanAcceptDroppedRecords(true);

			// this.setDragDataAction(DragDataAction.COPY);
			// this.setAttribute("dragRecategorize", false, false);
			// this.setCanDropOnLeaves(true);
			// this.setCanReparentNodes(true);
			// this.setDragDataAction(DragDataAction.MOVE) ;

			// { //Пытаюсь обработать out параметр isFolder
			// ResultTree configTree = new ResultTree();
			// configTree.setDefaultIsFolder(true);
			// configTree.setUpdateCacheFromRequest(true);
			// this.setDataProperties(configTree);
			// }

			{ // TODO - Дерево с возможностью частичного выбора
				// this.setSelectionAppearance(SelectionAppearance.CHECKBOX);
				// this.setShowSelectedStyle(false);
				// this.setShowPartialSelection(true);
				// this.setCascadeSelection(true);
			}

			this.addFolderDropHandler(new FolderDropHandler() {

				@Override
				public void onFolderDrop(FolderDropEvent event) {
					// Очищаем код действия формы в случае перетаскивания грида
					// Прийдется тут ловить действие, которое привязать к форме
					ActionItem dragAndDropActItem = mainFormPane.getButtonsToolBar().getDragAndDropActItem();
					FormActionMD faMD = (null != dragAndDropActItem) ? dragAndDropActItem.getFormActionMD() : new FormActionMD();
					mainFormPane.setCurrentAction(faMD);
				}
			});
			// this.startEditingNew();
		}
	}

	class GridRecordClickHandler implements RecordClickHandler {
		@Override
		public void onRecordClick(RecordClickEvent event) {
			Record r = event.getRecord();
			Utils.debug("MainForm.GridRecordClickHandler.onRecordClick.1. r:" + r);
			if (null == r) {
				r = ((ListGrid) event.getSource()).getEditedRecord(event.getRecordNum());
				Utils.debug("MainForm.GridRecordClickHandler.onRecordClick.2. r:" + r);
			}
			// mainFormPane.setThisFormCriteria(r);
			mainFormPane.filterDetailData(r, treeGrid, event.getRecordNum());
		}
	}

	class GridRowContextClickHandler implements RowContextClickHandler {

		@Override
		public void onRowContextClick(RowContextClickEvent event) {
			// treeGrid.focus();
			Record r = event.getRecord();
			if (null == r) {
				r = ((ListGrid) event.getSource()).getEditedRecord(event.getRowNum());
			}
			// mainFormPane.setThisFormCriteria(r);
			mainFormPane.filterDetailData((ListGridRecord) r, treeGrid, event.getRowNum(), false, false, false);
		}
	}

	private FormBottomToolBar bottomToolBar;
	private MainFormPane mainFormPane;
	private ListGrid treeGrid;

	public int getSelectedRecord() {
		int currRow = mainFormPane.getSelectedRow();

		if (-999 == currRow) {
			try {
				ListGridRecord r = treeGrid.getSelectedRecord();
				currRow = treeGrid.getRecordIndex(r);
			} catch (Exception e) {
				currRow = treeGrid.getEventRow();
				Utils.debug("MainForm.getSelectedRecord error:" + e.getMessage() + "; currRow:" + currRow);
			}
		}
		return currRow;
	}

	MainForm(final MainFormPane mainFormPane, final boolean showResizeBar) {
		Utils.debug("Constructor MainForm");
		this.setMargin(0);
		this.mainFormPane = mainFormPane;
		FormMD formMetadata = mainFormPane.getFormMetadata();
		String formWidth = formMetadata.getWidth();
		if ("0".equals(formWidth) || "0%".equals(formWidth)) {
			this.hide();
		} else {
			this.setShowResizeBar(showResizeBar);
			this.setResizeBarTarget("next");
			this.setWidth(formWidth);
		}
		if ("T".equals(formMetadata.getFormType())) {
			treeGrid = new FormTreeGrid();
		} else {
			treeGrid = new FormListGrid();
			// 20130604 - Для ListGrid добавлена возможность управления размером страницы. Для дерева не нужно - само умное
			Integer dataPageSize = formMetadata.getDataPageSize();
			if (null != dataPageSize && 0 != dataPageSize) {
				treeGrid.setDataPageSize(formMetadata.getDataPageSize());
			}
		}

		// 20130514 setSelectionColors(treeGrid);

		// 20120501 - См. TODO ниже
		bottomToolBar = new FormBottomToolBar();
		bottomToolBar.setWidth100();
		//
		if (formMetadata.isShowBottomToolBar()) {
			treeGrid.setGridComponents(new Object[] { ListGridComponent.HEADER, ListGridComponent.FILTER_EDITOR, ListGridComponent.BODY,
					bottomToolBar }); // ListGridComponent.SUMMARY_ROW
		}
		// 20110322
		treeGrid.setShowHeaderMenuButton(false);
		//
		treeGrid.setShowFilterEditor(false);
		treeGrid.setAlternateRecordStyles(true);
		treeGrid.setCanMultiSort(true);
		treeGrid.addRecordClickHandler(new GridRecordClickHandler());
		// Правая кнопка
		treeGrid.addRowContextClickHandler(new GridRowContextClickHandler());

		treeGrid.addClickHandler(new ClickHandler() {
			// не работает...

			@Override
			public void onClick(ClickEvent event) {
				Utils.debug("onClick");
				ConstructorApp.mainToolBar.setForm(mainFormPane);
			}
		});
		treeGrid.setWidth100();
		// TODO Вывести в глобальные настройки с последующим переводом
		// treeGrid.setGroupByText("Группировать по ${title}");
		// treeGrid.setUngroupText("Убрать группировку");
		// treeGrid.setSortFieldAscendingText("Сортировать по возрастанию");
		// treeGrid.setSortFieldDescendingText("Сортировать по убыванию");
		// treeGrid.setFreezeFieldText("Заморозить поле ${title}");
		// treeGrid.setUnfreezeFieldText("Разморозить поле ${title}");
		// treeGrid.setFieldVisibilitySubmenuTitle("Столбцы");
		{// Редактирование в гриде.
			treeGrid.setCanEdit(true);
			// treeGrid.setModalEditing(true);
			if (null != mainFormPane.getFormMetadata().getDoubleClickActionCode()) {
				treeGrid.setEditEvent(ListGridEditEvent.NONE);
				treeGrid.addRecordDoubleClickHandler(new RecordDoubleClickHandler() {
					@Override
					public void onRecordDoubleClick(RecordDoubleClickEvent event) {
						try {
							mainFormPane.getButtonsToolBar().getDoubleClickActItem().doActionWithConfirm(event.getRecordNum());
						} catch (Exception e) {
							e.printStackTrace();
							Window.alert("treeGrid.addRecordDoubleClickHandler: " + e.getMessage());
						}
					}
				});
			} else {
				treeGrid.setEditEvent(ListGridEditEvent.DOUBLECLICK);
			}
			treeGrid.setListEndEditAction(RowEndEditAction.NEXT);
			treeGrid.setAutoSaveEdits(false);
		}
		treeGrid.setHoverWidth(300);

		treeGrid.setInitialSort(mainFormPane.getFormColumns().getDefaultSort());
		// Utils.debugAlert("treeGrid.InitialSort:" + treeGrid.getInitialSort());
		{
			treeGrid.setHeight100();
			this.addChild(treeGrid);
		}

		this.setHeight100();

		treeGrid.addEditorExitHandler(new EditorExitHandler() {
			@Override
			public void onEditorExit(EditorExitEvent event) {
				Utils.debug("treeGrid.onEditorExit started...");
				ListGrid grid = ((ListGrid) event.getSource());
				int rowNum = event.getRowNum();
				// Обработка выхода по клавише ESCAPE
				if (null == event.getRecord() && EditCompletionEvent.ESCAPE_KEYPRESS.equals(event.getEditCompletionEvent())) {
					int nextRecord = (0 == rowNum && null != grid.getRecord(rowNum + 1)) ? rowNum + 1 : rowNum - 1;
					System.out.println("rowNum:" + rowNum + "; nextRecord:" + nextRecord);
					// mainFormPane.getValuesManager().clearValues();
					grid.deselectAllRecords();
					grid.selectRecord(nextRecord);
					mainFormPane.setSelectedRow(nextRecord);
					Utils.debug("treeGrid.onEditorExit. before mainFormPane.filterDetailData");
					mainFormPane.filterDetailData(grid.getRecord(nextRecord), treeGrid, nextRecord);
				}
				Utils.debug("treeGrid.onEditorExit ended...");
			}
		});

		// treeGrid.addRowEditorExitHandler(new RowEditorExitHandler() {
		// @Override
		// public void onRowEditorExit(RowEditorExitEvent event) {
		// Utils.debug("treeGrid.onRowEditorExit started...");
		// ListGrid grid = ((ListGrid) event.getSource());
		// int rowNum = event.getRowNum();
		// System.out.println("treeGrid.onRowEditorExit getEditCompletionEvent:" + event.getEditCompletionEvent());
		// // Обработка выхода по клавише ESCAPE при отказе от ввода новой записи
		// if (null == event.getRecord() && EditCompletionEvent.ESCAPE.equals(event.getEditCompletionEvent())) {
		// int nextRecord = (0 == rowNum && null != grid.getRecord(rowNum + 1)) ? rowNum + 1 : rowNum - 1;
		// System.out.println("rowNum:" + rowNum + "; nextRecord:" + nextRecord);
		// // mainFormPane.getValuesManager().clearValues();
		// grid.deselectAllRecords();
		// grid.selectRecord(nextRecord);
		// mainFormPane.setSelectedRow(nextRecord);
		// mainFormPane.filterDetailData(grid.getRecord(nextRecord), treeGrid, nextRecord);
		// }
		// Utils.debug("treeGrid.onRowEditorExit ended...");
		// }
		// });
		treeGrid.addRowEditorEnterHandler(new RowEditorEnterHandler() {
			// @Override
			// public void onRowEditorEnter2(RowEditorEnterEvent event) {
			// // TODO Auto-generated method stub
			//
			// }

			@Override
			public void onRowEditorEnter(RowEditorEnterEvent event) {
				Utils.debug("treeGrid.onRowEditorEnter started... event:" + event);
				ListGrid grid = ((ListGrid) event.getSource());
				Utils.debug("grid:" + grid);

				// int rowNum = event.getRowNum();
				int rowNum;
				try {
					rowNum = event.getRowNum();
				} catch (Exception e) {
					Utils.debug(e.getMessage());
					e.printStackTrace();
					rowNum = mainFormPane.getSelectedRow();
				}
				mainFormPane.setSelectedRow(rowNum);
				Record record = event.getRecord();
				Record newRec = grid.getEditedRecord(rowNum);
				// Default Values для новой записи.
				if (null == record && 0 == newRec.getAttributes().length) {
					setNewRecDefaultValues(rowNum, true);
				} else {
					// TODO Простановка DisplayValue для лукап-форм с DisplayFileds
					FormDataSourceField[] dsf = mainFormPane.getFormColumns().getDataSourceFields();
					for (FormDataSourceField f : dsf) {
						Utils.debug("treeGrid.onRowEditorEnter." + f.getColumnMD().getName() + ">>:"
								+ f.getColumnMD().getLookupDisplayValue());
					}
					Utils.debug("treeGrid.onRowEditorEnter.newRec.getAttributes():" + newRec.getAttributes());
				}
				Utils.debug("treeGrid.onRowEditorEnter ended...");
			}

		});

		// mm20110508 - for debug purposes
		// ////////////////////////////////////
		// treeGrid.addRowEditorExitHandler(new RowEditorExitHandler() {
		//
		// @Override
		// public void onRowEditorExit(RowEditorExitEvent event) {
		// Utils.debug("treeGrid.onRowEditorExit started/ended...");
		// }
		// });
		// treeGrid.addEditorEnterHandler(new EditorEnterHandler() {
		//
		// @Override
		// public void onEditorEnter(EditorEnterEvent event) {
		// Utils.debug("treeGrid.onEditorEnter started/ended...");
		//
		// }
		// });
		// ////////////////////////////////////
		treeGrid.addDataArrivedHandler(new DataArrivedHandler() {

			@Override
			public void onDataArrived(DataArrivedEvent event) {
				// Utils.debug("@@@@@@@@@@@@@@@@@@@@@@@ Grid onDataArrived start @@@@@@@@@@@@");
				if (isExport) {
					exportData();
				}
			}
		});

		// TODO Полезные методы - использовать
		// this.addResizedHandler(new MainFormResizedHandler());
		// treeGrid.setCanRemoveRecords(true);
		// treeGrid.setShowGroupSummary(true);
		// treeGrid.setShowGridSummary(true);
		// treeGrid.addEditFailedHandler(handler)

		// TODO SmartGWT 2.2. - сделали сохранение состояния грида и дерева
	}

	// 20130514 - Для выделения цветом выбранной записи. Не взлетело. Вызов закоменчен вверху.
	// TODO - вывести в настройки формы для возможности переопределения (BackgroundColor)
	public static void setSelectionColors(ListGrid listGrid) {

		listGrid.setBaseStyle("simpleCell");
		listGrid.setShowRollOverCanvas(true);
		listGrid.setAnimateRollUnder(true);

		Canvas rollUnderCanvasProperties = new Canvas();
		rollUnderCanvasProperties.setAnimateFadeTime(1000);
		rollUnderCanvasProperties.setAnimateShowEffect(AnimationEffect.FADE);
		rollUnderCanvasProperties.setBackgroundColor("#00ffff");
		rollUnderCanvasProperties.setOpacity(50);
		// can also override ListGrid.getRollUnderCanvas(int rowNum, int colNum)
		listGrid.setRollUnderCanvasProperties(rollUnderCanvasProperties);

		listGrid.setShowSelectionCanvas(true);
		listGrid.setAnimateSelectionUnder(true);

		Canvas selectionUnderCanvasProperties = new Canvas();
		selectionUnderCanvasProperties.setAnimateShowEffect(AnimationEffect.FADE);
		selectionUnderCanvasProperties.setAnimateFadeTime(1000);
		selectionUnderCanvasProperties.setBackgroundColor("#ffff40");
		listGrid.setSelectionUnderCanvasProperties(selectionUnderCanvasProperties);

	}

	public void setNewRecDefaultValues(final int rowNum, boolean isFromDefaultVals) {
		FormActionMD actMD = mainFormPane.getCurrentAction();
		final FormDataSourceField[] dsFields = mainFormPane.getFormColumns().getDataSourceFields();
		if (isFromDefaultVals) {
			Map<String, Object> rowMap = Utils.getRowDefaultValuesMap(mainFormPane);
			treeGrid.setEditValues(rowNum, rowMap);
		}
		if (null == actMD.getDmlProcText()) {
			Utils.debug("MainForm.setNewRecDefaultValues. Before mainFormPane.filterDetailData 1");
			mainFormPane.filterDetailData(null, treeGrid, rowNum);
		} else {
			DMLProcExecution procExec = new DMLProcExecution(mainFormPane) {
				@Override
				public void executeSuccessSubProc() {
					Utils.debug("MainForm.setNewRecDefaultValues: DMLProcExecution.executeSuccessSubProc() start...");
					Map<String, Object> resultMap = Utils.getMapFromRow(dsFields, getResultRow());
					treeGrid.setEditValues(rowNum, resultMap);
					Utils.debug("MainForm.setNewRecDefaultValues. Before mainFormPane.filterDetailData 2");
					mainFormPane.filterDetailData(null, treeGrid, rowNum);
				}
			};
			Row oldRow = null;
			Row newRow = Utils.getRowFromRecord(dsFields, treeGrid.getEditedRecord(rowNum));
			procExec.executeGlobal(oldRow, newRow);
		}
	}

	/**
	 * @return the bottomToolBar
	 */
	public FormBottomToolBar getBottomToolBar() {
		return bottomToolBar;
	}

	/**
	 * @return the treeGrid
	 */
	public ListGrid getTreeGrid() {
		return treeGrid;
	}

	/**
	 * @param bottomToolBar
	 *            the bottomToolBar to set
	 */
	public void setBottomToolBar(FormBottomToolBar bottomToolBar) {
		this.bottomToolBar = bottomToolBar;
	}

	/**
	 * @param treeGrid
	 *            the treeGrid to set
	 */
	public void setTreeGrid(ListGrid treeGrid) {
		this.treeGrid = treeGrid;
	}

	public int getHashCode() {
		return treeGrid.getJsObj().hashCode();
	}

	public void doBeforeClose() {
		final int gridHashCode = getHashCode();
		final String formCode = mainFormPane.getFormCode();
		Utils.debug(formCode + ": mainForm.doBeforeClose(). sessionId = " + ConstructorApp.sessionId + "; gridHashCode = " + gridHashCode);
		FormMD formState = mainFormPane.getFormState();
		Utils.debug("mainFormPane.FormState: " + formState);
		Utils.createQueryService("MainForm.closeForm").closeForm(mainFormPane.getInstanceIdentifier(), formState,
				new DSAsyncCallback<Void>() {
					@Override
					public void onSuccess(Void result) {
						Utils.debug("MainForm. Form " + formCode + "(" + gridHashCode + ")" + " closed...");
					}
				});
	}

	class MainFormResizedHandler implements ResizedHandler {

		@Override
		public void onResized(ResizedEvent event) {
			MainForm mf = (MainForm) event.getSource();
			TabSet pts = mainFormPane.getMainFormContainer().getParentTabSet();
			int hCnt = 0;
			int vCnt = 0;
			try {
				hCnt = mainFormPane.getSideDetailFormsContainer().getTabs().length;
				vCnt = mainFormPane.getBottomDetailFormsContainer().getTabs().length;
			} catch (Exception e) {
				System.err.println("MainForm.MainFormResizedHandler.onResized(ResizedEvent event) error:");
				e.printStackTrace();
			}
			// Horizontal
			if (0 != hCnt) {
				Utils.debug("New Width for " + mainFormPane.getFormCode() + ": "
						+ (Math.round(mf.getWidth().floatValue() / pts.getWidth().floatValue() * 100)));
			}
			// Vertical
			if (0 != vCnt) {
				Utils.debug("New Height for " + mainFormPane.getFormCode() + ": "
						+ (Math.round(mf.getHeight().floatValue() / pts.getHeight().floatValue() * 100)));
			}
		}

	}

	public ExportData createExportData() {
		ExportData exportData = new ExportData();
		String title = mainFormPane.getFormMetadata().getFormName();
		title = "".equals(title) ? mainFormPane.getFormMetadata().getFormCode() : title;
		exportData.setTitle(title);

		for (FormTreeGridField f : mainFormPane.getFormColumns().getGridFields()) {
			if ((!"false".equals(f.getAttribute("showIf")) && !"false".equals(f.getAttribute("canExport")))
					|| null != f.getColumnMD().getEditorTabCode()) {
				exportData.getHeaderNames().add(f.getName());
				exportData.getHeaderTitles().add(f.getTitle());
				String displayField = (f instanceof FormTreeGridField) ? f.getColumnMD().getLookupDisplayValue() : null;
				exportData.getHeaderDisplFldNames().add(displayField);

				String hdrType = "String";
				if ("N".equals(f.getColumnMD().getDataType()) && null == f.getColumnMD().getLookupCode()) {
					hdrType = "Number";
				}
				exportData.getHeaderTypes().add(hdrType);
			}
		}
		return exportData;
	}

	public void exportData() {
		// ResultSet rs = treeGrid.getResultSet();
		ExportData exportData = createExportData();
		try {
			MainFormPane pfp = mainFormPane.getParentFormPane();
			if (null != pfp) {
				ExportData parentRowData = pfp.getMainForm().createExportData();
				exportData.setParamNames(parentRowData.getHeaderTitles());
				Record r = pfp.getMainForm().getTreeGrid().getRecord(pfp.getSelectedRow());
				ArrayList<String> row = Utils.createArrayListFromRecord(r, pfp, parentRowData.getHeaderNames(), parentRowData
						.getHeaderDisplFldNames());
				exportData.setParamVals(row);
			}
		} catch (Exception e) {
			Utils.debug("MainForm.exportData.Params!!!  " + e.getMessage());
		}
		ResultSet rs = treeGrid.getResultSet();
		int dataLen = rs.getLength();
		// Чтение значений полей
		try {
			for (Record r : rs.getRange(0, dataLen)) {
				ArrayList<String> row = Utils.createArrayListFromRecord(r, mainFormPane, exportData.getHeaderNames(), exportData
						.getHeaderDisplFldNames());
				exportData.getData().add(row);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		Utils.createQueryService("MainForm.setExportData").setExportData(mainFormPane.getInstanceIdentifier(), exportData,
				new DSAsyncCallback<Integer>() {
					@Override
					public void onSuccess(Integer result) {
						String fullUrl = ExportUrl + "&dataClobId=" + result;
						System.out.println("fullUrl:" + fullUrl);
						com.google.gwt.user.client.Window.open(fullUrl, "", "");
						isExport = false;
						ExportUrl = "";
					}
				});
	}

	public boolean isExport = false;
	private String ExportUrl = "";

	public void exportGrid(final String url) {
		isExport = true;
		this.ExportUrl = url;
		ResultSet rs = treeGrid.getResultSet();
		// TODO least(100, dataLen)
		int dataLen = rs.getLength(); // 100;
		// TODO - Проблема в Firefox - для больших диапазонов (данных более 32К) падает с ошибкой
		if (!rs.rangeIsLoaded(0, dataLen)) {
			rs.getRange(0, dataLen);
		} else {
			exportData();
		}
	}
}
