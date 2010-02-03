package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.FormDataSource;
import com.abssoft.constructor.client.data.LookupDataSource;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
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
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.layout.HLayout;
import com.smartgwt.client.widgets.layout.SectionStack;
import com.smartgwt.client.widgets.layout.SectionStackSection;
import com.smartgwt.client.widgets.tree.TreeGrid;

public class MainFormPane extends Canvas {
	class FormHLayout extends SectionStack {
		public FormHLayout(String formTitle, Canvas topForm, DetailFormsContainer bottomForm) {
			//
			this.setHeight100();
			topForm.setHeight(formMetadata.getHeight());

			this.setVisibilityMode(VisibilityMode.MULTIPLE);
			SectionStackSection summarySection = new SectionStackSection(formTitle);
			summarySection.setExpanded(true);
			summarySection.setItems(topForm);
			SectionStackSection detailsSection = new SectionStackSection("Details");
			detailsSection.setItems(bottomForm);
			this.setSections(summarySection, detailsSection);
			detailsSection.setExpanded(true);
		}
	}

	public class FormValuesManager extends ValuesManager {
		@Override
		public void editRecord(Record record) {
			try {
				super.editRecord(record);
			} catch (Exception e) {
				Utils.logException(e, "MainFormPane.FormValuesManager.editRecord()");
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
					}
				}
			} catch (Exception e) {
				Utils.logException(e, "MainFormPane.FormValuesManager.editRecord()");
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
	private int currentGridRowSelected = -999;

	private boolean forceFetch = false;

	// String LookupDS, ComboboxesList
	private HashMap<String, ArrayList<GridComboBoxItem>> lookupComboboxes = new HashMap<String, ArrayList<GridComboBoxItem>>();

	Canvas tabPane;

	private ValuesManager valuesManager = new FormValuesManager();
	private FormDataSource dataSource;
	private String currentActionCode = "";

	public MainFormPane() {
	}

	public MainFormPane(final String formCode, boolean isMasterForm, final boolean isLookup, MainFormPane parentFormPane) {
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
		QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
		service.getFormMetaData(ConstructorApp.sessionId, formCode, new DSAsyncCallback<FormMD>() {
			public void onSuccess(FormMD result) {
				setFormMetadata(result);
				setFormColumns(new FormColumns(MainFormPane.this));
				if (!isLookup) {
					mainForm = new MainForm(MainFormPane.this, formColumns.hasSideTabsCount);
				}
				System.out.println("z1");
				dataSource.setMainFormPane(MainFormPane.this);
				System.out.println("z2:" + dataSource);
				if (!isLookup) {
					dataSource.setGridHashCode(mainForm.getHashCode());
					ListGrid grid = mainForm.getTreeGrid();
					grid.setDataSource(dataSource);
					valuesManager.setDataSource(dataSource);
					System.out.println(formCode + " 2isLookup:" + isLookup);
					grid.setFields(formColumns.getGridFields());
					System.out.println(formCode + " 3isLookup:" + isLookup);
					filterData();
					buttonsToolBar.createButtons();
					createLookups();
					createDetailForms();
					if (isMasterForm()) {
						ConstructorApp.mainToolBar.setForm(MainFormPane.this);
					}
					Utils.debug("Actions allowed on form: Ins:" + result.getActions().isInsertAllowed() + "; Upd:"
							+ result.getActions().isUpdateAllowed() + "; Del:" + result.getActions().isDeleteAllowed());
				}
				System.out.println("MainFormPane created");
			}
		});
	}

	public void createDetailForms() {
		String fc = this.getFormCode();

		String formTitle = FormTab.getIconTitle(ConstructorApp.formNameArr.get(fc), ConstructorApp.formIconArr.get(fc));
		sideDetailFormsContainer = new DetailFormsContainer(this, Orientation.HORIZONTAL);
		bottomDetailFormsContainer = new DetailFormsContainer(this, Orientation.VERTICAL);

		HLayout gridAndFormLayout = new HLayout();

		gridAndFormLayout.addMember(mainForm);
		gridAndFormLayout.addMember(sideDetailFormsContainer);
		gridAndFormLayout.setWidth100();

		if (0 == bottomDetailFormsContainer.getTabCounter()) {
			tabPane = gridAndFormLayout;
		} else {
			tabPane = new FormHLayout(formTitle, gridAndFormLayout, bottomDetailFormsContainer);
		}

		tabPane.setHeight100();
		tabPane.setWidth100();
		this.setHeight100();
		this.setWidth100();
		this.addChild(tabPane);
	}

	void createLookups() {
		Iterator<String> it = lookupComboboxes.keySet().iterator();
		while (it.hasNext()) {
			String lookupCode = it.next();
			System.out.println(">>>>>>>>>lookup<<<<<<: " + lookupCode);
			new LookupDataSource(lookupCode, this);
		}
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
	}

	public void filterData() {
		setForceFetch(true);
		System.out.println(this.formCode + " @@@@@@@@@ " + this.getMainForm());
		if (null != this.getMainForm()) {
			ListGrid g = this.getMainForm().getTreeGrid();
			// Отличие TreeGrid от ListGrid в том, что при TreeGrid.invalidateCache выполняется запрос к БД
			if (!(g instanceof TreeGrid)) {
				g.invalidateCache();
			}
			System.out.println("isMasterForm() => " + isMasterForm());
			if (isMasterForm()) {
				g.filterData();
			} else {
				if (null != getParentFormPane())
					g.filterData(getParentFormPane().getInitialFilter());
			}

		}
		setForceFetch(false);
	}

	/**
	 * @param record
	 */
	public void filterDetailData(ListGridRecord record, ListGrid treeGrid, boolean filterDynamicMultiDetails, int selectedRecordIndex) {
		System.out.println("filterDetailData.... record:" + record);
		setInitialFilter(Utils.getCriteriaFromListGridRecord(record, this.getFormCode()));
		getBottomDetailFormsContainer().filterData(filterDynamicMultiDetails);
		getSideDetailFormsContainer().filterData(filterDynamicMultiDetails);
		setCurrentGridRowSelected(selectedRecordIndex);
		((FormValuesManager) valuesManager).editRecord2();
	}

	public void filterDetailData(ListGridRecord record, ListGrid treeGrid, int selectedRecordIndex) {
		filterDetailData(record, treeGrid, true, selectedRecordIndex);
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
	public DynamicForm getButtonsToolBar() {
		return buttonsToolBar;
	}

	/**
	 * @return the currentActionCode
	 */
	public String getCurrentActionCode() {
		return currentActionCode;
	}

	/**
	 * @return the currentGridRowSelected
	 */
	public int getCurrentGridRowSelected() {
		System.out.println("currentGridRowSelected:  " + currentGridRowSelected);
		return currentGridRowSelected;
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

	/**
	 * @return the initialFilter
	 */
	public Criteria getInitialFilter() {
		Utils.debug("execute getInitialFilter..." + getFormCode());
		return initialFilter;
	}

	/**
	 * @return the lookupComboboxes
	 */
	public HashMap<String, ArrayList<GridComboBoxItem>> getLookupComboboxes() {
		return lookupComboboxes;
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
	 * @return the sideDetailFormsContainer
	 */
	public DetailFormsContainer getSideDetailFormsContainer() {
		return sideDetailFormsContainer;
	}

	public ValuesManager getValuesManager() {
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

	public void putLookup(String lookupCode, GridComboBoxItem comboBoxItem) {
		if (lookupComboboxes.containsKey(lookupCode)) {
			lookupComboboxes.get(lookupCode).add(comboBoxItem);
		} else {
			ArrayList<GridComboBoxItem> comboboxesList = new ArrayList<GridComboBoxItem>();
			comboboxesList.add(comboBoxItem);
			lookupComboboxes.put(lookupCode, comboboxesList);
		}
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
	public void setCurrentActionCode(String currentActionCode) {
		this.currentActionCode = currentActionCode;
	}

	/**
	 * @param currentGridRowSelected
	 *            the currentGridRowSelected to set
	 */
	public void setCurrentGridRowSelected(int currentGridRowSelected) {
		this.currentGridRowSelected = currentGridRowSelected;
		System.out.println("currentGridRowSelected set to " + currentGridRowSelected);
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
	 * @param sideDetailFormsContainer
	 *            the sideDetailFormsContainer to set
	 */
	public void setSideDetailFormsContainer(DetailFormsContainer sideDetailFormsContainer) {
		this.sideDetailFormsContainer = sideDetailFormsContainer;
	}

	/**
	 * @param valuesManager
	 */
	public void setValuesManager(ValuesManager valuesManager) {
		this.valuesManager = valuesManager;
	}
}
