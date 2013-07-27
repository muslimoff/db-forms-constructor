package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.FormDataSource;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.widgets.CodeEditorItem;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.abssoft.constructor.client.widgets.MyRichTextItem;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.MenuMD;
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

public class MainFormPane extends Canvas {
	public class FormValuesManager extends ValuesManager {
		public FormValuesManager() {
			super();
		}

		com.smartgwt.client.util.LogicalDate x;

		@Override
		public void setValue(String fieldName, String value) {
			super.setValue(fieldName, value);
			try {
				for (DynamicForm form : super.getMembers()) {
					FormItem field = form.getField(fieldName);
					if (field instanceof CodeEditorItem) {
						((CodeEditorItem) field).setValue(value);
					}
				}
			} catch (Exception e) {
			}
		}

		@Override
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
						// Window.alert("d:" + d + "; f:" + f);

						FormItem ff = d.getField(fieldName);
						// В SmartGWT 1.3 поломали super.editRecord еще и для HeaderItem
						if (ff instanceof HeaderItem) {
							((HeaderItem) ff).setValue(fieldValue);
						}

						// вот так вот потому что: Проблемы с CanvasItem
						// http://code.google.com/p/smartgwt/issues/detail?id=266
						// Updated: http://code.google.com/p/smartgwt/issues/detail?id=180#c10
						// Fixed for 3.1d from 5/19 onwards - see smartclient.com/builds. Please confirm.
						if (ff instanceof HTMLPaneItem) {
							((HTMLPaneItem) ff).setValue(fieldValue);
						}

						if (ff instanceof MyRichTextItem) {
							((MyRichTextItem) ff).setValue(fieldValue);
						}

						// if (ff instanceof CodeEditorItem) {
						// ((CodeEditorItem) ff).setValue(fieldValue);
						// }
					}
				}
			} catch (Exception e) {
				Utils.logException(e, "MainFormPane.FormValuesManager.editRecord() 2");
			}

		}

		public void editRecord2() {
			if (0 != this.getMembers().length) {
				// Установка редактированных ранее значений из строки грида
				Record record = Utils.getEditedRecord(MainFormPane.this);
				// this.editRecord(record);

				this.editRecord3(record);// mm20120902 - съехали снова. Вернулся на editRecord3
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
	private MainFormContainer mainFormContainer;
	private FormToolbar buttonsToolBar;
	private int selectedRow = -999;
	private Boolean isMainFormHiden = false;
	private boolean forceFetch = false;
	private FormValuesManager valuesManager = new FormValuesManager();
	private FormDataSource dataSource;
	private FormActionMD currentAction = new FormActionMD();
	private FormInstanceIdentifier instanceIdentifier;
	private boolean fromUrl = false;
	private SectionStackSection summarySection;
	private SectionStackSection detailsSection;
	SectionStack sections;
	private int parentFormsCount = 0;

	public static final Criteria INTITAL_CRITERIA = new Criteria();
	// Сохранение предыдущего фильтра для определения автообновления табиков
	private Criteria prevParentFormCriteria = INTITAL_CRITERIA;
	private Criteria parentFormCriteria = INTITAL_CRITERIA;
	private Criteria thisFormCriteria = INTITAL_CRITERIA;

	// 20130514 - обнаружнен косяк - при создании новой записи - сброс сортировки в гриде
	private String sortState;

	public void setSortState(String sortState) {
		this.sortState = sortState;
	}

	public String getSortState() {
		return sortState;
	}

	public MainFormPane() {
	}

	public MainFormPane(final String formCode, final boolean isLookup, final MainFormPane parentFormPane, Boolean isDrillDownForm,
			String parentFormTabCode, final Criteria parentFormCriteria1) {
		this.setFormCode(formCode);

		setParentFormCriteria(parentFormCriteria1);
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
		this.parentFormPane = parentFormPane;
		this.parentFormsCount = null == parentFormPane ? 0 : parentFormPane.parentFormsCount + 1;
		this.buttonsToolBar = new FormToolbar(this);
		String parentFormCode = (null != parentFormPane) ? parentFormPane.getFormCode() : null;
		instanceIdentifier = new FormInstanceIdentifier(ConstructorApp.sessionId, formCode, ConstructorApp.debugEnabled, false // isLookupForm
				, isDrillDownForm, parentFormCode, parentFormTabCode);
		instanceIdentifier.setGridHashCode(-999);
		// Запрет вложенности форм более чем 20 и запрет зацикливания формы...
		if (20 >= this.parentFormsCount
				&& !instanceIdentifier.getKey().equals(null == parentFormPane ? "" : parentFormPane.getInstanceIdentifier().getKey())) {
			if (null != parentFormPane && parentFormPane.getFormMetadata().getChildForms().containsKey(instanceIdentifier.getKey())) {
				processFormMetadata(parentFormPane.getFormMetadata().getChildForms().get(instanceIdentifier.getKey()), isLookup,
						parentFormCriteria1, false);
			} else {
				Utils.createQueryService("MainFormPane.getFormMetaData").getFormMetaData(instanceIdentifier, new DSAsyncCallback<FormMD>() {
					public void onSuccess(FormMD result) {
						result.getStatus().showActionStatus();
						processFormMetadata(result, isLookup, parentFormCriteria1, true);
						// Utils.debug("MainFormPane.getFormMetaData. QueryService:" + result);
					}
				});
			}
		}

	}

	public void processFormMetadata(FormMD formMetaData, boolean isLookup, Criteria parentFormCriteria, boolean isAutoFetch) {
		setFormMetadata(formMetaData);
		setFormColumns(new FormColumns(MainFormPane.this));
		if (!isLookup) {
			mainForm = new MainForm(MainFormPane.this, formColumns.hasSideTabsCount);
			instanceIdentifier.setGridHashCode(mainForm.getHashCode());
		}
		dataSource.setMainFormPane(MainFormPane.this);
		if (!isLookup) {
			ListGrid grid = mainForm.getTreeGrid();
			grid.setDataSource(dataSource);
			valuesManager.setDataSource(dataSource);
			System.out.println(formCode + " 2isLookup:" + isLookup);
			grid.setFields(formColumns.createGridFields());
			System.out.println(formCode + " 3isLookup:" + isLookup);
			buttonsToolBar.createButtons();
			createDetailForms(parentFormCriteria);
			if (null == this.parentFormPane) {
				focus();
			}
			if (isAutoFetch) {
				Utils.debug("MainFormPane.processFormMetadata. Before filterData 1.");
				filterData(parentFormCriteria, true);
				Utils.debug("MainFormPane.processFormMetadata. Before filterData 3.");
			}
		}
		Utils.debug("MainFormPane created");
	}

	// public void hideTabBar() {
	// parentTabSet.hideTabBar();
	// }

	public void focus() {
		ConstructorApp.mainToolBar.setForm(MainFormPane.this);
		mainForm.getTreeGrid().focus();
	}

	public void createDetailForms(Criteria parentFormCriteria) {
		// System.out.println("createDetailForms... ###################################");
		String fc = this.getFormCode();
		String formTitle = FormTab.getIconTitle(ConstructorApp.formNameArr.get(fc), ConstructorApp.formIconArr.get(fc));

		// System.out.println("createDetailForms. sideDetailFormsContainer before: " + sideDetailFormsContainer);

		sideDetailFormsContainer = new DetailFormsContainer(parentFormCriteria, this, Orientation.HORIZONTAL);

		// System.out.println("createDetailForms. sideDetailFormsContainer: " + sideDetailFormsContainer);

		bottomDetailFormsContainer = new DetailFormsContainer(parentFormCriteria, this, Orientation.VERTICAL);

		// System.out.println("createDetailForms. bottomDetailFormsContainer: " + bottomDetailFormsContainer);

		HLayout gridAndFormLayout = new HLayout();
		gridAndFormLayout.setMargin(0);
		gridAndFormLayout.addMember(mainForm);
		gridAndFormLayout.addMember(sideDetailFormsContainer);
		gridAndFormLayout.setWidth100();
		sections = new SectionStack();
		sections.setMargin(0);
		sections.setHeight100();
		gridAndFormLayout.setHeight(formMetadata.getHeight());
		sections.setVisibilityMode(VisibilityMode.MULTIPLE);
		int sectionsHeaderHeigth = sections.getHeaderHeight();
		String summarySectionTitle = formTitle;
		String detailsSectionTitle = formTitle + "-Подробности";

		// TODO - вынести в настройки высоту SectionStack: sections.setHeaderHeight(1); По дефолту - 26
		sectionsHeaderHeigth = 5;
		sections.setHeaderHeight(sectionsHeaderHeigth);
		if (sectionsHeaderHeigth <= 10) // Если высота меньше 10px то не выводим наименования - все равно некрасиво тогда получится если
		// выводить наименования
		{
			summarySectionTitle = "";
			detailsSectionTitle = "";
		}
		summarySection = new SectionStackSection(summarySectionTitle);
		detailsSection = new SectionStackSection(detailsSectionTitle);
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
		DetailFormsContainer bottomCon = getBottomDetailFormsContainer();
		DetailFormsContainer sideCon = getSideDetailFormsContainer();
		// Utils.debug("MainFormPane.doBeforeClose. bottomCon:" + bottomCon + "; sideCon:" + sideCon);
		if (null != bottomCon) {
			bottomCon.doBeforeClose();
		}
		if (null != sideCon) {
			sideCon.doBeforeClose();
		}
		if (null != mainForm) {
			mainForm.doBeforeClose();
		}
		Utils.debug("MainFormPane. Form " + formCode + " closed...");
	}

	// public void filterData(boolean isRefresh) {
	// filterData(getParentFormCriteria(), isRefresh);
	// }

	public void filterData(Criteria parentFormCriteria, boolean isRefresh) {
		// this.parentFormCriteria = parentFormCriteria;
		Utils.debug("MainFormPane.filterData. 1" + parentFormCriteria.getValues());
		if (isRefresh || !getPrevParentFormCriteria().getValues().equals(parentFormCriteria.getValues())) {
			Utils.debug("MainFormPane.filterData. 2");
			setForceFetch(true);
			Utils.debug("MainFormPane.filterData. 3: " + this.formCode);
			if (null != this.getMainForm()) {
				Utils.debug("MainFormPane.filterData. 4");
				ListGrid grid = this.getMainForm().getTreeGrid();
				Utils.debug("MainFormPane.filterData. 5");
				try {
					grid.invalidateCache();
					Utils.debug("MainFormPane.filterData. 6");
				} catch (Exception e) {
					Utils.debug("MainFormPane.filterData. 7:" + e.getMessage());
					e.printStackTrace();
				}
				Utils.debug("MainFormPane.filterData. 8");
				grid.filterData(parentFormCriteria);
				Utils.debug("MainFormPane.filterData. 9");
				setParentFormCriteria(parentFormCriteria);
				Utils.debug("MainFormPane.filterData. 10");
			}
			Utils.debug("MainFormPane.filterData. 11");
			setForceFetch(false);
			Utils.debug("MainFormPane.filterData. 12");
			// this.setPrevParentFormCriteria(parentFormCriteria);
			setParentFormCriteria(parentFormCriteria);
			Utils.debug("MainFormPane.filterData. 13");
		}

	}

	public void filterDetailData(Record record, ListGrid treeGrid, int selectedRecordIndex) {
		Utils.debug("filterDetailData0.... record:" + record);
		filterDetailData(record, treeGrid, selectedRecordIndex, true, true, true);
	}

	public void filterDetailData(Record record, ListGrid treeGrid, int selectedRecordIndex, boolean filterDynamicMultiDetails,
			boolean filterDynamicSingleDetails, boolean filterStaticDetails) {
		Utils.debug("filterDetailData.... record:" + record);
		setSelectedRow(selectedRecordIndex);

		// Лишнее?
		// setThisFormCriteria(record);
		setThisFormCriteria(record);

		Utils.debug("filterDetailData.... BottomDetailFormsContainer:" + this.getThisFormCriteria().getValues()
		// + getBottomDetailFormsContainer()
				);
		Utils.debug("filterDetailData.... SideDetailFormsContainer:" // + getSideDetailFormsContainer()
				);
		getBottomDetailFormsContainer().filterDetailContainerData(getThisFormCriteria(), filterDynamicMultiDetails,
				filterDynamicSingleDetails, filterStaticDetails);
		getSideDetailFormsContainer().filterDetailContainerData(getThisFormCriteria(), filterDynamicMultiDetails,
				filterDynamicSingleDetails, filterStaticDetails);
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
		Utils.debug("z3:" + dataSource);
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
		Utils.debug("**************FORM: " + formCode + "*************************");
		FormMD form = new FormMD();
		form.setFormCode(formCode);
		Integer formWidth = mainForm.getWidth();
		Integer formHeight = mainForm.getHeight();
		Integer paneWidth = getWidth();
		Integer paneHeight = getHeight();
		Utils.debug("Border:" + this.getBorder());
		Utils.debug("FormWidth. new:" + formWidth + "; old:" + this.getFormMetadata().getWidth());
		Utils.debug("FormHeight. new:" + formHeight + "; old:" + this.getFormMetadata().getHeight());
		Utils.debug("TotalWidth. new:" + paneWidth);
		Utils.debug("TotalHeight. new:" + paneHeight);
		String formWidthStr = "" + (Math.round(formWidth.doubleValue() / paneWidth.doubleValue() * 20.0) * 5);
		String formHeightStr = "" + (Math.round(formHeight.doubleValue() / paneHeight.doubleValue() * 20.0) * 5);
		formWidthStr = (0 == this.getSideDetailFormsContainer().getTabCounter()) ? this.getFormMetadata().getWidth() : formWidthStr;
		formHeightStr = (0 == this.getBottomDetailFormsContainer().getTabCounter()) ? this.getFormMetadata().getHeight() : formHeightStr;
		Utils.debug("W%" + formWidthStr + "; H%" + formHeightStr);

		// Сохранение параметров (ширины и порядка) столбцов.
		Utils.debug("Columns before....");
		for (FormTreeGridField f : this.getFormColumns().getGridFields()) {
			if (!f.getColumnMD().getDisplaySize().equals(f.getWidth())) {
				Utils.debug(f.getName() + " Old width" + f.getColumnMD().getDisplaySize() + "New width:" + f.getWidth()
						+ "; getSortDirection:" + f.getSortDirection());
			}
		}
		Utils.debug("**************************************************");
		return form;
	}

	public FormInstanceIdentifier getInstanceIdentifier() {
		instanceIdentifier.setIsDebugEnabled(ConstructorApp.debugEnabled);
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

	// /**
	// * @return the isMasterForm
	// */
	// public boolean isMasterForm() {
	// return isMasterForm;
	// }

	public void releaseDetailsFocus() {
		// Utils.debug("MainFormPane.releaseDetailsFocus");
		if (null != this.getBottomDetailFormsContainer()) {
			this.getBottomDetailFormsContainer().releaseFocus();
			// Utils.debug("MainFormPane.BottomDetailFormsContainer.releaseFocus. Processed...");
		}
		if (null != this.getSideDetailFormsContainer()) {
			this.getSideDetailFormsContainer().releaseFocus();
			// Utils.debug("MainFormPane.SideDetailFormsContainer.releaseFocus. Processed...");
		}
	}

	public void setBorder(boolean showBorder) {
		// TODO mm20120110 - Закоментил - расползание границ формы после изменения версии в 2.5 - 3.0. Да и вообще - криво с этой рамочкой.
		// Что-то другое придумать.
		// Canvas cnv = this;
		// if (showBorder) {
		// cnv.setBorder("2px solid green");
		// } else {
		// cnv.setBorder("2px");
		// }
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

	// /**
	// * @param parentFormPane
	// * the parentFormPane to set
	// */
	// public void setParentFormPane1(MainFormPane parentFormPane) {
	// this.parentFormPane = parentFormPane;
	// }

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

	protected void setParentFormCriteria(Criteria parentFormCriteria) {
		setPrevParentFormCriteria(this.parentFormCriteria);
		this.parentFormCriteria = (null == parentFormCriteria) ? INTITAL_CRITERIA : parentFormCriteria;
	}

	private void setPrevParentFormCriteria(Criteria prevParentFormCriteria) {
		this.prevParentFormCriteria = (null == prevParentFormCriteria) ? INTITAL_CRITERIA : prevParentFormCriteria;
	}

	private void setThisFormCriteria(Criteria thisFormCriteria) {
		if (null == thisFormCriteria) {
			Utils.debugAlert("setThisFormCriteria: " + null);
			this.thisFormCriteria = INTITAL_CRITERIA;
		} else {
			Utils
					.debug("setThisFormCriteria formCode:" + this.formCode + "; crit:" + thisFormCriteria + ":"
							+ thisFormCriteria.getValues());
			this.thisFormCriteria = thisFormCriteria;
		}
	}

	public void setThisFormCriteria(Record record) {
		Criteria thisFormCriteria = Utils.getCriteriaFromListGridRecord(this, record);
		Utils.debug("setThisFormCriteria2 formCode:" + this.formCode + "; crit:" + thisFormCriteria + ":" + thisFormCriteria.getValues());
		this.setThisFormCriteria(thisFormCriteria);
	}

	public Criteria getParentFormCriteria() {
		return parentFormCriteria;
	}

	public Criteria getPrevParentFormCriteria() {
		return prevParentFormCriteria;
	}

	public Criteria getThisFormCriteria() {
		return thisFormCriteria;
	}
}
