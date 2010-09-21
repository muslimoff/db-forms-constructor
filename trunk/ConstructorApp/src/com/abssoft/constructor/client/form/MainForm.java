package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.DMLProcExecution;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.Row;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.ResultSet;
import com.smartgwt.client.data.events.DataArrivedEvent;
import com.smartgwt.client.data.events.DataArrivedHandler;
import com.smartgwt.client.types.EditCompletionEvent;
import com.smartgwt.client.types.ListGridEditEvent;
import com.smartgwt.client.types.RowEndEditAction;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.ResizedEvent;
import com.smartgwt.client.widgets.events.ResizedHandler;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridField;
import com.smartgwt.client.widgets.grid.ListGridRecord;
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
import com.smartgwt.client.widgets.layout.VLayout;
import com.smartgwt.client.widgets.tree.Tree;
import com.smartgwt.client.widgets.tree.TreeGrid;
import com.smartgwt.client.widgets.tree.TreeNode;
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
		}

	}

	public class FormTreeGrid extends TreeGrid {

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
						if (!t.getTitle(nn).equals("root"))
							titlePath = t.getTitle(nn) + "/" + titlePath;
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
		}
	}

	class GridRecordClickHandler implements RecordClickHandler {
		public void onRecordClick(RecordClickEvent event) {
			Record r = event.getRecord();
			if (null == r) {
				r = ((ListGrid) event.getSource()).getEditedRecord(event.getRecordNum());
			}
			if (treeGrid instanceof TreeGrid) {
				treeGrid.deselectAllRecords();
				treeGrid.selectRecord(event.getRecordNum());
			}
			mainFormPane.filterDetailData((ListGridRecord) r, treeGrid, event.getRecordNum());
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
			mainFormPane.filterDetailData((ListGridRecord) r, treeGrid, event.getRowNum(), false, false, false);
		}
	}

	private FormBottomToolBar bottomToolBar;
	private MainFormPane mainFormPane;
	private ListGrid treeGrid;

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
		}
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
		treeGrid.setGroupByText("Группировать по ${title}");
		treeGrid.setUngroupText("Убрать группировку");
		treeGrid.setSortFieldAscendingText("Сортировать по возрастанию");
		treeGrid.setSortFieldDescendingText("Сортировать по убыванию");
		treeGrid.setFreezeFieldText("Заморозить поле ${title}");
		treeGrid.setUnfreezeFieldText("Разморозить поле ${title}");
		treeGrid.setFieldVisibilitySubmenuTitle("Столбцы");
		{// Редактирование в гриде.
			treeGrid.setCanEdit(true);
			// treeGrid.setModalEditing(true);
			if (null != mainFormPane.getFormMetadata().getDoubleClickActionCode()) {
				treeGrid.setEditEvent(ListGridEditEvent.NONE);
				treeGrid.addRecordDoubleClickHandler(new RecordDoubleClickHandler() {
					@Override
					public void onRecordDoubleClick(RecordDoubleClickEvent event) {
						try {
							mainFormPane.getButtonsToolBar().getDoubleClickActItem().doActionWithConfirm();
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
		VLayout mainLayout = new VLayout();
		mainLayout.setWidth100();
		mainLayout.setHeight100();
		mainLayout.addMember(treeGrid);
		// /////////
		bottomToolBar = new FormBottomToolBar();
		bottomToolBar.setWidth100();
		mainLayout.addMember(bottomToolBar);
		if (!formMetadata.isShowBottomToolBar())
			bottomToolBar.hide();
		this.addChild(mainLayout);
		this.setHeight100();

		treeGrid.addEditorExitHandler(new EditorExitHandler() {
			@Override
			public void onEditorExit(EditorExitEvent event) {
				System.out.println("onEditorExit..");
				ListGrid grid = ((ListGrid) event.getSource());
				int rowNum = event.getRowNum();
				// Обработка выхода по клавише ESCAPE
				if (null == event.getRecord() && EditCompletionEvent.ESCAPE.equals(event.getEditCompletionEvent())) {
					int nextRecord = (0 == rowNum && null != grid.getRecord(rowNum + 1)) ? rowNum + 1 : rowNum - 1;
					System.out.println("rowNum:" + rowNum + "; nextRecord:" + nextRecord);
					// mainFormPane.getValuesManager().clearValues();
					grid.deselectAllRecords();
					grid.selectRecord(nextRecord);
					mainFormPane.setSelectedRow(nextRecord);
					mainFormPane.filterDetailData(grid.getRecord(nextRecord), treeGrid, nextRecord);
				}
			}
		});
		treeGrid.addRowEditorEnterHandler(new RowEditorEnterHandler() {
			@Override
			public void onRowEditorEnter(RowEditorEnterEvent event) {
				// System.out.println("RowEditorEnterHandler.getEditedRecord: 1");
				ListGrid grid = ((ListGrid) event.getSource());
				// System.out.println("RowEditorEnterHandler.getEditedRecord: 2");
				int rowNum = event.getRowNum();
				// System.out.println("RowEditorEnterHandler.getEditedRecord: 3");
				Record record = event.getRecord();
				// System.out.println("RowEditorEnterHandler.getEditedRecord: 4");
				Record newRec = grid.getEditedRecord(rowNum);
				// System.out.println("RowEditorEnterHandler.getEditedRecord: 5");
				// System.out.println("RowEditorEnterHandler.getEditedRecord: " + newRec);
				// System.out.println("RowEditorEnterHandler.getRowNum: " + rowNum);

				// Default Values для новой записи.
				if (null == record && 0 == newRec.getAttributes().length) {
					setNewRecDefaultValues(grid, rowNum);
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

	public void setNewRecDefaultValues(final ListGrid grid, final int rowNum) {
		FormActionMD actMD = mainFormPane.getCurrentAction();
		final FormDataSourceField[] dsFields = mainFormPane.getFormColumns().getDataSourceFields();
		Map<String, Object> rowMap = Utils.getRowDefaultValuesMap(mainFormPane);
		grid.setEditValues(rowNum, rowMap);
		if (null == actMD.getDmlProcText()) {
			mainFormPane.filterDetailData(null, treeGrid, rowNum);
		} else {
			DMLProcExecution procExec = new DMLProcExecution(mainFormPane) {
				@Override
				public void executeSubProc() {
					Map<String, Object> resultMap = Utils.getMapFromRow(dsFields, getResultRow());
					grid.setEditValues(rowNum, resultMap);
					mainFormPane.filterDetailData(null, treeGrid, rowNum);
				}
			};
			Row oldRow = null;
			Row newRow = Utils.getRowFromRecord(dsFields, (ListGridRecord) grid.getEditedRecord(rowNum));
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
		QueryServiceAsync queryService = (QueryServiceAsync) GWT.create(QueryService.class);
		final String formCode = mainFormPane.getFormCode();
		Utils.debug(formCode + ": mainForm.doBeforeClose(). sessionId = " + ConstructorApp.sessionId + "; gridHashCode = " + gridHashCode);
		FormMD formState = mainFormPane.getFormState();
		System.out.println("mainFormPane.FormState: " + formState);
		queryService.closeForm(mainFormPane.getInstanceIdentifier(), formState, new DSAsyncCallback<Void>() {
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

	class ExpField {
		private String name;
		private String title;

		ExpField() {
		}

		ExpField(String name, String title) {
			this.name = name;
			setTitle(name, title);
		}

		public void setTitle(String name, String title) {
			this.title = null != title ? title : name;
			this.title = "&nbsp;".equals(title) ? "_" : title;
		}

		public String getTitle() {
			return title;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getName() {
			return name;
		}
	}

	public String getCSVData(ArrayList<ExpField> flds, ResultSet rs, String header, String spr, int dataLen) {
		String rowsData = header;
		// Вывод значений полей
		try {
			for (Record r : rs.getRange(0, dataLen)) {
				for (int i = 0; i < flds.size(); i++) {
					ExpField f = flds.get(i);
					rowsData = rowsData + r.getAttribute(f.getName()) + spr;
				}
				rowsData = rowsData + "%0D%0A"; // "\n";
			}
			Utils.debug("@@@@@@@@@@@@@@@@@");
			System.out.println(rowsData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// application/vnd.ms-excel
		com.google.gwt.user.client.Window.open("data:text/plain;charset=utf-8, " + rowsData, "", "");
		return rowsData;
	}

	// TODO http://software.hixie.ch/utilities/cgi/data/data
	// data:text/html;charset=utf-8,1%0D%0A2%0D%0A3%0D%0A
	public void exportGrid() {
		final String spr = ";";
		// Получаем список экспортируемых полей
		final ArrayList<ExpField> flds = new ArrayList<ExpField>();
		for (ListGridField f : treeGrid.getAllFields()) {
			// System.out.println("@@@ " + f.getName() + "; " + f.getAttribute("showIf") + "; " + f.getTitle());
			// baseStyle; specialCol -- canExport; false
			if (!"false".equals(f.getAttribute("showIf")) && !"false".equals(f.getAttribute("canExport"))) {
				flds.add(new ExpField(f.getName(), f.getTitle()));
			}
		}
		// Вывод заголовков полей
		String result = "";
		for (int i = 0; i < flds.size(); i++) {
			ExpField f = flds.get(i);
			result = result + f.getTitle() + spr;
		}
		result = result + "%0D%0A"; // "\n";

		final ResultSet rs = treeGrid.getResultSet();
		// TODO least(100, dataLen)
		final int dataLen = rs.getLength(); // 100;
		final String header = result;
		if (!rs.rangeIsLoaded(0, dataLen)) {
			rs.getRange(0, dataLen);

			rs.addDataArrivedHandler(new DataArrivedHandler() {
				@Override
				public void onDataArrived(DataArrivedEvent event) {
					Utils.debug("@@@@@@@@@@@@@@@@@@@@@@@ onDataArrived start@@@@@@@@@@@@");
					getCSVData(flds, rs, header, spr, dataLen);
					Utils.debug("@@@@@@@@@@@@@@@@@@@@@@@ onDataArrived end @@@@@@@@@@@@");
				}
			});
		} else {
			getCSVData(flds, rs, header, spr, dataLen);
		}
	}
}
