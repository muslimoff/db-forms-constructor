package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.FormMD;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.ListGridEditEvent;
import com.smartgwt.client.types.RowEndEditAction;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.ResizedEvent;
import com.smartgwt.client.widgets.events.ResizedHandler;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.RecordClickEvent;
import com.smartgwt.client.widgets.grid.events.RecordClickHandler;
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

	}

	public class FormTreeGrid extends TreeGrid {

		FormTreeGrid() {
			this.setShowConnectors(true);
			this.addNodeClickHandler(new NodeClickHandler() {

				public void onNodeClick(NodeClickEvent event) {
					Tree t = FormTreeGrid.this.getTree();
					TreeNode n = event.getNode();
					TreeNode[] parentNodes = t.getParents(n);
					String titlePath = t.getTitle(n);
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
				}
			});
		}
	}

	class GridRecordClickHandler implements RecordClickHandler {
		public void onRecordClick(RecordClickEvent event) {
			System.out.println("************** 1: " + event.getRecordNum());
			mainFormPane.setCurrentGridRowSelected(event.getRecordNum());
			System.out.println("************** 2: " + mainFormPane.getCurrentGridRowSelected());
			System.out.println("************** 2: " + event.getSource());
			System.out.println("************** 3: " + ((ListGrid) event.getSource()).getEditedRecord(event.getRecordNum()));
			System.out.println("************** 3: " + ((ListGrid) event.getSource()).getRecord(event.getRecordNum()));
			System.out.println("************** 4: " + event.getRecord());

			// System.out.println(FormTreeGrid.this.getEditedRecord(event.getRecordNum()));
			Record r = event.getRecord();
			if (null == r) {
				r = ((ListGrid) event.getSource()).getEditedRecord(event.getRecordNum());
			}
			// ((ListGrid) event.getSource()).selectRecord(event.getRecordNum());
			System.out.println("************** 5: " + r);
			mainFormPane.setCurrentGridRowSelected(event.getRecordNum());
			mainFormPane.filterDetailData((ListGridRecord) r, treeGrid, event.getRecordNum());
			System.out.println("************** 6 ");
		}
	}

	private FormBottomToolBar bottomToolBar;

	private MainFormPane mainFormPane;

	private ListGrid treeGrid;

	MainForm(final MainFormPane mainFormPane, final boolean showResizeBar) {
		Utils.debug("Constructor MainForm");
		// this.addResizedHandler(new MainFormResizedHandler());
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
		// bottomToolBar.setWidth(formMetadata.getWidth());
		if ("T".equals(formMetadata.getFormType())) {
			treeGrid = new FormTreeGrid();
		} else {
			treeGrid = new FormListGrid();
		}
		treeGrid.setAlternateRecordStyles(true);
		treeGrid.setCanMultiSort(true);
		treeGrid.addRecordClickHandler(new GridRecordClickHandler());
		// treeGrid.setCanRemoveRecords(true);
		// treeGrid.setShowFilterEditor(true);

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
			treeGrid.setEditEvent(ListGridEditEvent.DOUBLECLICK);
			treeGrid.setListEndEditAction(RowEndEditAction.NEXT);
			treeGrid.setAutoSaveEdits(false);
		}
		treeGrid.setHoverWidth(300);

		treeGrid.setCellHeight(16);
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
		queryService.closeForm(ConstructorApp.sessionId, formCode, gridHashCode, new DSAsyncCallback<Void>() {
			@Override
			public void onSuccess(Void result) {
				Utils.debug("Tab: " + formCode + "; gridHashCode :" + gridHashCode);
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
}
