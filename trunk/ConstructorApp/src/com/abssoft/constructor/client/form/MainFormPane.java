package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.FormDataSource;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.abssoft.constructor.client.widgets.MyRichTextItem;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.Orientation;
import com.smartgwt.client.types.VisibilityMode;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.ValuesManager;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.HeaderItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.layout.HLayout;
import com.smartgwt.client.widgets.layout.SectionStack;
import com.smartgwt.client.widgets.layout.SectionStackSection;
import com.smartgwt.client.widgets.tree.TreeGrid;

public class MainFormPane extends Canvas {
	public class FormValuesManager extends ValuesManager {

		public native void setValue(String fieldName, java.util.Date value)
		/*-{
			var self = this.@com.smartgwt.client.core.BaseClass::getOrCreateJsObj()();
			var valueJS = @com.smartgwt.client.util.JSOHelper::convertToJavaScriptDate(Ljava/util/Date;)(value);
			self.setValue(fieldName, valueJS);
		}-*/;

		// TODO Походу все заработало, кроме richTextItem????
		// @Override
		public void editRecord3(Record record) {
			try {
				super.editRecord(record);
			} catch (Exception e) {
				Utils.logException(e, "MainFormPane.FormValuesManager.editRecord() 1");
			}
			// Пробежка по CanvasItem c HTMLPane
			try {
				for (DynamicForm d : this.getMembers()) {
					for (FormItem f : d.getFields()) {
						String fieldName = f.getFieldName();
						String fieldValue = record.getAttribute(fieldName);

						// вот так вот потому что:
						// http://code.google.com/p/smartgwt/issues/detail?id=266
						FormItem ff = d.getField(fieldName);
						if (ff instanceof HTMLPaneItem) {
							((HTMLPaneItem) ff).setValue(fieldValue);
						}
						// В SmartGWT 1.3 поломали super.editRecord для
						// HeaderItem
						if (ff instanceof HeaderItem) {
							((HeaderItem) ff).setValue(fieldValue);
						}
						if (ff instanceof MyRichTextItem) {
							((MyRichTextItem) ff).setValue(fieldValue);
						}
					}
				}
			} catch (Exception e) {
				Utils.logException(e, "MainFormPane.FormValuesManager.editRecord() 2");
			}

		}

		public void editRecord2() {
			if (0 != this.getMembers().length) {
				// Установка редактированных ранее значений из строки грида
				Record record = Utils.getEditedRow(MainFormPane.this);
				this.editRecord(record);
			}

		}
	}

	private String formCode;
	private DetailFormsContainer bottomDetailFormsContainer;
	private DetailFormsContainer sideDetailFormsContainer;
	private MainFormPane parentFormPane;
	private FormMD formMetadata;
	private FormColumns formColumns;
	private MainForm mainForm;
	private Criteria initialFilter = null;
	private boolean isMasterForm;
	private MainFormContainer mainFormContainer;
	private FormToolbar buttonsToolBar;
	private int selectedRow = -999;
	private Boolean isMainFormHiden = false;
	private boolean forceFetch = false;
	private FormValuesManager valuesManager = new FormValuesManager();
	private FormDataSource dataSource;
	private FormActionMD currentAction = new FormActionMD();
	private FormInstanceIdentifier instanceIdentifier = new FormInstanceIdentifier(ConstructorApp.sessionId);
	private boolean fromUrl = false;
	private Integer warnButtonIdx = null;

	// private Integer warnButtonIdx = null;

	public MainFormPane() {
	}

	public MainFormPane(final String formCode, boolean isMasterForm, final boolean isLookup, final MainFormPane parentFormPane,
			Boolean isDrillDownForm) {
		this.setFormCode(formCode);
		if (!ConstructorApp.formNameArr.containsKey(formCode)) {
			MenuMD menu = new MenuMD();
			menu.setFormCode(formCode);
			menu.setFormName(formCode);
			menu.setIconId(0);
			ConstructorApp.formIconArr.put(formCode, 0);
			ConstructorApp.formNameArr.put(formCode, formCode);
		}
		dataSource = new FormDataSource();
		System.out.println(formCode + " isLookup:" + isLookup);
		this.setParentFormPane(parentFormPane);
		this.setMasterForm(isMasterForm);
		this.buttonsToolBar = new FormToolbar(this);
		String parentFormCode = (null != parentFormPane) ? parentFormPane.getFormCode() : null;
		QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
		instanceIdentifier.setFormCode(formCode);
		instanceIdentifier.setParentFormCode(parentFormCode);
		instanceIdentifier.setGridHashCode(-999);
		instanceIdentifier.setIsDrillDownForm(isDrillDownForm);
		service.getFormMetaData(instanceIdentifier, new DSAsyncCallback<FormMD>() {
			public void onSuccess(FormMD result) {
				result.getStatus().showActionStatus();
				setFormMetadata(result);
				setFormColumns(new FormColumns(MainFormPane.this));
				if (!isLookup) {
					mainForm = new MainForm(MainFormPane.this, formColumns.hasSideTabsCount);
				}
				System.out.println("z1");
				if (!isLookup) {
					instanceIdentifier.setGridHashCode(mainForm.getHashCode());
				}
				dataSource.setMainFormPane(MainFormPane.this);
				System.out.println("z2:" + dataSource);
				if (!isLookup) {
					ListGrid grid = mainForm.getTreeGrid();
					grid.setDataSource(dataSource);
					valuesManager.setDataSource(dataSource);
					System.out.println(formCode + " 2isLookup:" + isLookup);
					grid.setFields(formColumns.createGridFields());
					System.out.println(formCode + " 3isLookup:" + isLookup);
					filterData();
					buttonsToolBar.createButtons();
					createDetailForms();
					if (isMasterForm()) {
						ConstructorApp.mainToolBar.setForm(MainFormPane.this);
					}
				}
				Utils.debug("MainFormPane created");
			}
		});

	}

	// public void hideTabBar() {
	// parentTabSet.hideTabBar();
	// }

	public void createDetailForms() {
		String fc = this.getFormCode();
		String formTitle = FormTab.getIconTitle(ConstructorApp.formNameArr.get(fc), ConstructorApp.formIconArr.get(fc));
		sideDetailFormsContainer = new DetailFormsContainer(this, Orientation.HORIZONTAL);
		bottomDetailFormsContainer = new DetailFormsContainer(this, Orientation.VERTICAL);

		HLayout gridAndFormLayout = new HLayout();
		gridAndFormLayout.setMargin(0);
		gridAndFormLayout.addMember(mainForm);
		gridAndFormLayout.addMember(sideDetailFormsContainer);
		gridAndFormLayout.setWidth100();
		SectionStack sections = new SectionStack();
		sections.setMargin(0);
		sections.setHeight100();
		gridAndFormLayout.setHeight(formMetadata.getHeight());
		sections.setVisibilityMode(VisibilityMode.MULTIPLE);
		SectionStackSection summarySection = new SectionStackSection(formTitle);
		SectionStackSection detailsSection = new SectionStackSection(formTitle + "-Подробности");
		summarySection.setExpanded(true);
		summarySection.setItems(gridAndFormLayout);
		if (0 == bottomDetailFormsContainer.getTabCounter()) {
			summarySection.setShowHeader(false);
			detailsSection.setShowHeader(false);
			detailsSection.setExpanded(false);
		} else {
			detailsSection.setItems(bottomDetailFormsContainer);
			detailsSection.setExpanded(true);
		}
		sections.setSections(summarySection, detailsSection);
		if ("0%".equals(getFormMetadata().getHeight()) || "0".equals(getFormMetadata().getHeight())) {
			summarySection.setShowHeader(false);
			detailsSection.setShowHeader(false);
		}
		sections.setHeight100();
		sections.setWidth100();
		this.setHeight100();
		this.setWidth100();
		this.addChild(sections);
		//
		if ("H".equals(formMetadata.getSideTabsPosition()))
			sideDetailFormsContainer.hideTabBar();
		if ("H".equals(formMetadata.getBottomTabsPosition()))
			bottomDetailFormsContainer.hideTabBar();
	}

	public void doBeforeClose() {
		if (null != getBottomDetailFormsContainer()) {
			getBottomDetailFormsContainer().doBeforeClose();
		}
		if (null != getSideDetailFormsContainer()) {
			getSideDetailFormsContainer().doBeforeClose();
		}
		if (null != mainForm) {
			mainForm.doBeforeClose();
		}
		Utils.debug("MainFormPane. Form " + formCode + " closed...");
	}

	public void filterData() {
		setForceFetch(true);
		System.out.println(this.formCode + " @@@@@@@@@ " + this.getMainForm());
		if (null != this.getMainForm()) {
			ListGrid grid = this.getMainForm().getTreeGrid();
			// Отличие TreeGrid от ListGrid в том, что при TreeGrid.invalidateCache выполняется запрос к БД
			if (!(grid instanceof TreeGrid)) {
				// TODO - Появилась ошибка в SmartGWT 2.2 от 11.06
				try {
					grid.invalidateCache();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			Criteria criteria = new Criteria();
			Utils.debug("isMasterForm() => " + isMasterForm());
			if (isMasterForm()) {
			} else {
				if (null != getParentFormPane())
					criteria = getParentFormPane().getInitialFilter();
			}
			grid.filterData(criteria);
		}
		setForceFetch(false);

	}

	public void filterDetailData(Record record, ListGrid treeGrid, int selectedRecordIndex) {
		filterDetailData(record, treeGrid, selectedRecordIndex, true, true, true);
	}

	public void filterDetailData(Record record, ListGrid treeGrid, int selectedRecordIndex, boolean filterDynamicMultiDetails,
			boolean filterDynamicSingleDetails, boolean filterStaticDetails) {
		Utils.debug("filterDetailData.... record:" + record);
		setSelectedRow(selectedRecordIndex);
		setInitialFilter(Utils.getCriteriaFromListGridRecord(this, record, this.getFormCode()));
		getBottomDetailFormsContainer().filterData(filterDynamicMultiDetails, filterDynamicSingleDetails, filterStaticDetails);
		getSideDetailFormsContainer().filterData(filterDynamicMultiDetails, filterDynamicSingleDetails, filterStaticDetails);
		valuesManager.editRecord2();
		buttonsToolBar.setActionsStatuses();
	}

	/**
	 * @return the bottomDetailFormsContainer
	 */
	public DetailFormsContainer getBottomDetailFormsContainer() {
		return bottomDetailFormsContainer;
	}

	/**
	 * @return the buttonsToolBar
	 */
	public FormToolbar getButtonsToolBar() {
		return buttonsToolBar;
	}

	/**
	 * @return the currentActionCode
	 */
	public FormActionMD getCurrentAction() {
		return currentAction;
	}

	/**
	 * @return the dataSource
	 */
	public FormDataSource getDataSource() {
		System.out.println("z3:" + dataSource);
		return dataSource;
	}

	/**
	 * @return the formCode
	 */
	public String getFormCode() {
		return formCode;
	}

	/**
	 * @return the formColumns
	 */
	public FormColumns getFormColumns() {
		return formColumns;
	}

	/**
	 * @return the formMetadata
	 */
	public FormMD getFormMetadata() {
		return formMetadata;
	}

	public FormMD getFormState() {
		// Сохранение параметров формы.
		System.out.println("**************FORM: " + formCode + "*************************");
		FormMD form = new FormMD();
		form.setFormCode(formCode);
		Integer formWidth = mainForm.getWidth();
		Integer formHeight = mainForm.getHeight();
		Integer paneWidth = getWidth();
		Integer paneHeight = getHeight();
		System.out.println("Border:" + this.getBorder());
		System.out.println("FormWidth. new:" + formWidth + "; old:" + this.getFormMetadata().getWidth());
		System.out.println("FormHeight. new:" + formHeight + "; old:" + this.getFormMetadata().getHeight());
		System.out.println("TotalWidth. new:" + paneWidth);
		System.out.println("TotalHeight. new:" + paneHeight);
		String formWidthStr = "" + (Math.round(formWidth.doubleValue() / paneWidth.doubleValue() * 20.0) * 5);
		String formHeightStr = "" + (Math.round(formHeight.doubleValue() / paneHeight.doubleValue() * 20.0) * 5);
		formWidthStr = (0 == this.getSideDetailFormsContainer().getTabCounter()) ? this.getFormMetadata().getWidth() : formWidthStr;
		formHeightStr = (0 == this.getBottomDetailFormsContainer().getTabCounter()) ? this.getFormMetadata().getHeight() : formHeightStr;
		System.out.println("W%" + formWidthStr + "; H%" + formHeightStr);

		// Сохранение параметров (ширины и порядка) столбцов.
		System.out.println("Columns before....");
		for (FormTreeGridField f : this.getFormColumns().getGridFields()) {
			if (!f.getColumnMD().getDisplaySize().equals(f.getWidth())) {
				System.out.println(f.getName() + " Old width" + f.getColumnMD().getDisplaySize() + "New width:" + f.getWidth()
						+ "; getSortDirection:" + f.getSortDirection());
			}
		}
		System.out.println("**************************************************");
		return form;
	}

	/**
	 * @return the initialFilter
	 */
	public Criteria getInitialFilter() {
		Utils.debug("execute getInitialFilter..." + getFormCode());
		return initialFilter;
	}

	public FormInstanceIdentifier getInstanceIdentifier() {
		return instanceIdentifier;
	}

	public Boolean getIsMainFormHiden() {
		return isMainFormHiden;
	}

	public MainForm getMainForm() {
		return mainForm;
	}

	/**
	 * @return the mainFormContainer
	 */
	public MainFormContainer getMainFormContainer() {
		return mainFormContainer;
	}

	/**
	 * @return the parentFormPane
	 */
	public MainFormPane getParentFormPane() {
		return parentFormPane;
	}

	public String getPath() {
		String path = "";
		MainFormPane mfp = this;
		while (null != mfp && ConstructorApp.formNameArr.containsKey(mfp.getFormCode())) {
			path = ConstructorApp.formNameArr.get(mfp.getFormCode()) + "-" + path;
			mfp = mfp.getParentFormPane();
		}
		return path;
	}

	/**
	 * @return the currentGridRowSelected
	 */
	public int getSelectedRow() {
		Utils.debug("currentGridRowSelected:  " + selectedRow);
		return selectedRow;
	}

	/**
	 * @return the sideDetailFormsContainer
	 */
	public DetailFormsContainer getSideDetailFormsContainer() {
		return sideDetailFormsContainer;
	}

	@Override
	public FormValuesManager getValuesManager() {
		return valuesManager;
	}

	public boolean isForceFetch() {
		return forceFetch;
	}

	/**
	 * @return the isMasterForm
	 */
	public boolean isMasterForm() {
		return isMasterForm;
	}

	public void releaseDetailsFocus() {
		if (null != this.getBottomDetailFormsContainer())
			this.getBottomDetailFormsContainer().releaseFocus();
		if (null != this.getSideDetailFormsContainer())
			this.getSideDetailFormsContainer().releaseFocus();
	}

	public void setBorder(boolean showBorder) {
		Canvas cnv = this;
		if (showBorder) {
			cnv.setBorder("2px solid green");
		} else {
			cnv.setBorder("2px");
		}
	}

	/**
	 * @param bottomDetailFormsContainer
	 *            the bottomDetailFormsContainer to set
	 */
	public void setBottomDetailFormsContainer(DetailFormsContainer bottomDetailFormsContainer) {
		this.bottomDetailFormsContainer = bottomDetailFormsContainer;
	}

	/**
	 * @param buttonsToolBar
	 *            the buttonsToolBar to set
	 */
	public void setButtonsToolBar(FormToolbar buttonsToolBar) {
		this.buttonsToolBar = buttonsToolBar;
	}

	/**
	 * @param currentActionCode
	 *            the currentActionCode to set
	 */
	public void setCurrentAction(FormActionMD currentAction) {
		this.currentAction = currentAction;
	}

	/**
	 * @param dataSource
	 *            the dataSource to set
	 */
	public void setDataSource(FormDataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void setFocus() {
		Utils.debug("Path: " + this.getPath());
		ConstructorApp.setPageTitle(this.getPath());

		MainFormPane parentFP = this.getParentFormPane();
		while (null != parentFP) {
			parentFP.setBorder(false);
			parentFP = parentFP.getParentFormPane();
		}
		this.setBorder(true);
		this.releaseDetailsFocus();

	}

	public void setForceFetch(boolean forceRefresh) {
		this.forceFetch = forceRefresh;
	}

	/**
	 * @param formCode
	 *            the formCode to set
	 */
	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	/**
	 * @param formColumns
	 *            the formColumns to set
	 */
	public void setFormColumns(FormColumns formColumns) {
		this.formColumns = formColumns;
	}

	/**
	 * @param formMetadata
	 *            the formMetadata to set
	 */
	public void setFormMetadata(FormMD formMetadata) {
		this.formMetadata = formMetadata;
	}

	/**
	 * @param initialFilter
	 *            the initialFilter to set
	 */
	public void setInitialFilter(Criteria initialFilter) {
		Utils.debug("setInitialFilter executed..." + getFormCode());
		this.initialFilter = initialFilter;
	}

	public void setInstanceIdentifier(FormInstanceIdentifier instanceIdentifier) {
		this.instanceIdentifier = instanceIdentifier;
	}

	public void setIsMainFormHiden(Boolean isMainFormHiden) {
		this.isMainFormHiden = isMainFormHiden;
	}

	/**
	 * @param mainForm
	 */
	public void setMainForm(MainForm mainForm) {
		this.mainForm = mainForm;
	}

	/**
	 * @param mainFormContainer
	 *            the mainFormContainer to set
	 */
	public void setMainFormContainer(MainFormContainer mainFormContainer) {
		this.mainFormContainer = mainFormContainer;
	}

	/**
	 * @param isMasterForm
	 *            the isMasterForm to set
	 */
	public void setMasterForm(boolean isMasterForm) {
		this.isMasterForm = isMasterForm;
	}

	/**
	 * @param parentFormPane
	 *            the parentFormPane to set
	 */
	public void setParentFormPane(MainFormPane parentFormPane) {
		this.parentFormPane = parentFormPane;
	}

	/**
	 * @param selectedRow
	 *            the selectedRow to set
	 */
	public void setSelectedRow(int selectedRow) {
		this.selectedRow = selectedRow;
		System.out.println("selectedRow set to " + selectedRow);
	}

	/**
	 * @param sideDetailFormsContainer
	 *            the sideDetailFormsContainer to set
	 */
	public void setSideDetailFormsContainer(DetailFormsContainer sideDetailFormsContainer) {
		this.sideDetailFormsContainer = sideDetailFormsContainer;
	}

	/**
	 * @param valuesManager
	 */
	public void setValuesManager(FormValuesManager valuesManager) {
		this.valuesManager = valuesManager;
	}

	public void setFromUrl(boolean fromUrl) {
		this.fromUrl = fromUrl;
	}

	public boolean isFromUrl() {
		return fromUrl;
	}

	public void setWarnButtonIdx(Integer warnButtonIdx) {
		this.warnButtonIdx = warnButtonIdx;
	}

	public Integer getWarnButtonIdx() {
		return warnButtonIdx;
	}

	// public void setWarnButtonIdx(Integer warnButtonIdx) {
	// this.warnButtonIdx = warnButtonIdx;
	// }
	//
	// public Integer getWarnButtonIdx() {
	// return warnButtonIdx;
	// }
}
