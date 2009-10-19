package com.abssoft.constructor.client.form;

import java.util.Iterator;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.FormDataSource;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenuMD;
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

public class MainFormPane extends Canvas {
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

	/**
	 * @param buttonsToolBar
	 *            the buttonsToolBar to set
	 */
	public void setButtonsToolBar(FormToolbar buttonsToolBar) {
		this.buttonsToolBar = buttonsToolBar;
	}

	Canvas tabPane;
	private ValuesManager valuesManager = new FormValuesManager();
	private FormDataSource dataSource;
	private String currentActionCode = "";

	public class FormValuesManager extends ValuesManager {
		public void editRecord2(ListGridRecord record) {
			if (0 != this.getMembers().length) {
				// Установка редактированных ранее значений из строки грида
				ListGridRecord r = new ListGridRecord(record.getJsObj());
				Map<?, ?> ev = MainFormPane.this.getMainForm().getTreeGrid().getEditValues(record);
				Iterator<?> it = ev.keySet().iterator();
				while (it.hasNext()) {
					String mapKey = (String) it.next();
					String value = (String) ev.get(mapKey);
					Utils.debug("Nonsaved Edit: " + mapKey + "=" + value);
					r.setAttribute(mapKey, value);
				}
				this.editRecord(r);
			}

		}

		@Override
		public void editRecord(Record record) {
			// Вместо просто super.editRecord(record) приходится так, потому
			// что: http://code.google.com/p/smartgwt/issues/detail?id=336
			try {
				if (Utils.isChrome() || Utils.isFirefox() || Utils.isMoz()) {
					super.editRecord(Utils.getTreeNodeFromRecordWithoutRef(formColumns.getDSFields(), record));
				} else {
					super.editRecord(record);

				}
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
						//http://code.google.com/p/smartgwt/issues/detail?id=266
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
	}

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

	public MainFormPane() {
	}

	public MainFormPane(final String formCode, boolean isMasterForm, MainFormPane parentFormPane) {
		this.setFormCode(formCode);
		this.setParentFormPane(parentFormPane);
		this.setMasterForm(isMasterForm);
		this.buttonsToolBar = new FormToolbar(this);
		QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
		service.getFormMetaData(ConstructorApp.sessionId, formCode, new DSAsyncCallback<FormMD>() {
			public void onSuccess(FormMD result) {
				setFormMetadata(result);
				setFormColumns(new FormColumns(MainFormPane.this));
				mainForm = new MainForm(MainFormPane.this, formColumns.hasSideTabsCount);
				System.out.println("2* mainForm: " + mainForm);
				dataSource = new FormDataSource(MainFormPane.this);
				ListGrid grid = mainForm.getTreeGrid();
				grid.setDataSource(dataSource);
				valuesManager.setDataSource(dataSource);
				grid.setFields(formColumns.getGridFields());
				filterData();
				buttonsToolBar.createButtons();
				createDetailForms();
				if (isMasterForm()) {
					ConstructorApp.mainToolBar.setForm(MainFormPane.this);
				}
				Utils.debug("Actions allowed on form: Ins:" + result.getActions().isInsertAllowed() + "; Upd:"
						+ result.getActions().isUpdateAllowed() + "; Del:" + result.getActions().isDeleteAllowed());
			}
		});
	}

	public void filterData() {
		ListGrid g = mainForm.getTreeGrid();
		g.invalidateCache();
		if (isMasterForm()) {
			g.filterData();
		} else {
			if (null != getParentFormPane())
				g.filterData(getParentFormPane().getInitialFilter());
		}
	}

	public void createDetailForms() {
		MenuMD menu = ConstructorApp.menus.get(this.getFormCode());
		String formTitle = FormTab.getIconTitle(menu.getFormName(), menu.getIconId());
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

	/**
	 * @param record
	 */
	public void filterDetailData(ListGridRecord record, ListGrid treeGrid) {
		System.out.println("filterDetailData.... record:" + record);
		setInitialFilter(Utils.getCriteriaFromListGridRecord(record, this.getFormCode()));
		getBottomDetailFormsContainer().filterData();
		getSideDetailFormsContainer().filterData();
		// System.out.println("SelectedRecordIndex: " +
		// treeGrid.getRecordIndex(treeGrid.getSelectedRecord()));
		setCurrentGridRowSelected(treeGrid.getRecordIndex(treeGrid.getSelectedRecord()));
		((FormValuesManager) valuesManager).editRecord2(record);
		// if (0 != valuesManager.getMembers().length) {
		// // Установка редактированных ранее значений из строки грида
		// ListGridRecord r = new ListGridRecord(record.getJsObj());
		// Map<?, ?> ev = treeGrid.getEditValues(record);
		// Iterator<?> it = ev.keySet().iterator();
		// while (it.hasNext()) {
		// String mapKey = (String) it.next();
		// String value = (String) ev.get(mapKey);
		// Utils.debug("Nonsaved Edit: " + mapKey + "=" + value);
		// r.setAttribute(mapKey, value);
		// }
		// valuesManager.editRecord(r);
		// }
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
	 * @return the dataSource
	 */
	public FormDataSource getDataSource() {
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
		while (null != mfp && ConstructorApp.menus.containsKey(mfp.getFormCode())) {
			path = ConstructorApp.menus.get(mfp.getFormCode()).getFormName() + "-" + path;
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

	/**
	 * @return the isMasterForm
	 */
	public boolean isMasterForm() {
		return isMasterForm;
	}

	/**
	 * @param bottomDetailFormsContainer
	 *            the bottomDetailFormsContainer to set
	 */
	public void setBottomDetailFormsContainer(DetailFormsContainer bottomDetailFormsContainer) {
		this.bottomDetailFormsContainer = bottomDetailFormsContainer;
	}

	/**
	 * @param dataSource
	 *            the dataSource to set
	 */
	public void setDataSource(FormDataSource dataSource) {
		this.dataSource = dataSource;
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

	/**
	 * @param currentActionCode
	 *            the currentActionCode to set
	 */
	public void setCurrentActionCode(String currentActionCode) {
		this.currentActionCode = currentActionCode;
	}

	/**
	 * @return the currentActionCode
	 */
	public String getCurrentActionCode() {
		return currentActionCode;
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
	 * @return the currentGridRowSelected
	 */
	public int getCurrentGridRowSelected() {
		System.out.println("currentGridRowSelected:  " + currentGridRowSelected);
		return currentGridRowSelected;
	}
}
