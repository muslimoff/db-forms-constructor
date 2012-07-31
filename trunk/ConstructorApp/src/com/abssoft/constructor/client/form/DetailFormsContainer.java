package com.abssoft.constructor.client.form;

import java.util.HashMap;
import java.util.Iterator;

import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.FormTabsArr;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.FormTabMD;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.types.Orientation;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.events.CloseClickHandler;
import com.smartgwt.client.widgets.tab.events.TabCloseClickEvent;

public class DetailFormsContainer extends TabSet {
	class DetailTabsArr extends HashMap<String, MainFormPane> {
		private static final long serialVersionUID = -6202855546066039640L;
	}

	class DynamicDetailTab {
		private MainFormContainer detailTab;
		private DetailTabsArr dynSingleDetailTabsArr = new DetailTabsArr();
		private FormTab.TabType tabType;
		private String title;

		private int iconId;

		DynamicDetailTab(FormTab.TabType tabType, MainFormContainer singleDetailTab, String title, int iconId) {
			this.tabType = tabType;
			this.detailTab = singleDetailTab;
			this.title = title;
			this.iconId = iconId;
		}

		/**
		 * @return the DetailTab
		 */
		public MainFormContainer getDetailTab() {
			return detailTab;
		}

		/**
		 * @return the dynSingleDetailTabsArr
		 */
		public DetailTabsArr getDynSingleDetailTabsArr() {
			return dynSingleDetailTabsArr;
		}

		/**
		 * @return the iconId
		 */
		public int getIconId() {
			return iconId;
		}

		/**
		 * @return the tabType
		 */
		public FormTab.TabType getTabType() {
			return tabType;
		}

		/**
		 * @return the title
		 */
		public String getTitle() {
			return title;
		}

		/**
		 * @param singleDetailTab
		 *            the singleDetailTab to set
		 */
		public void setDetailTab(MainFormContainer detailTab) {
			this.detailTab = detailTab;
		}

		/**
		 * @param dynSingleDetailTabsArr
		 *            the dynSingleDetailTabsArr to set
		 */
		public void setDynSingleDetailTabsArr(DetailTabsArr dynSingleDetailTabsArr) {
			this.dynSingleDetailTabsArr = dynSingleDetailTabsArr;
		}

		/**
		 * @param iconId
		 *            the iconId to set
		 */
		public void setIconId(int iconId) {
			this.iconId = iconId;
		}

		/**
		 * @param tabType
		 *            the tabType to set
		 */
		public void setTabType(FormTab.TabType tabType) {
			this.tabType = tabType;
		}

		/**
		 * @param title
		 *            the title to set
		 */
		public void setTitle(String title) {
			this.title = title;
		}
	}

	private final String defTabPrefix = "GEN_TAB_";
	private MainFormPane mainFormPane;
	Orientation orientation;
	private int tabCounter = 0;
	private DetailTabsArr dynMultiDetailTabsArr = new DetailTabsArr();

	private FormMD formMetadata;

	private HashMap<String, DynamicDetailTab> dynamicDetailTabs = new HashMap<String, DynamicDetailTab>();

	DetailFormsContainer(MainFormPane mainFormPane, Orientation orientation) {
		Utils.debug("DetailFormsContainer... orientation:" + orientation);
		this.setDestroyPanes(false);
		this.mainFormPane = mainFormPane;
		this.orientation = orientation;
		formMetadata = mainFormPane.getFormMetadata();
		String tabsOrientStr;
		if (Orientation.VERTICAL == orientation) {
			tabsOrientStr = formMetadata.getBottomTabsPosition();
		} else {
			tabsOrientStr = formMetadata.getSideTabsPosition();
		}
		Side tabsOrient;
		if (tabsOrientStr.equals("L"))
			tabsOrient = Side.LEFT;
		else if (tabsOrientStr.equals("R"))
			tabsOrient = Side.RIGHT;
		else if (tabsOrientStr.equals("B"))
			tabsOrient = Side.BOTTOM;
		else
			tabsOrient = Side.TOP;
		setTabBarPosition(tabsOrient);
		// обработку скрытия таббара (tabsOrientStr = "H") см в методе MainFormPane.createDetailForms, в самом конце

		FormTabsArr tabs = formMetadata.getTabs();
		// Цикл по табикам статических типов
		for (int i = 0; i < tabs.size(); i++) {
			FormTabMD m = tabs.get(i);
			String tabTypeMD = m.getTabType();
			if (orientation == (m.getTabPosition().equals("B") ? Orientation.VERTICAL : Orientation.HORIZONTAL)) {
				if (null != m.getChildFormCode() && FormTab.TabType.DETAIL.getValue().equals(tabTypeMD)) {
					new MainFormContainer(FormTab.TabType.DETAIL, this, m.getChildFormCode(), false, false, false, mainFormPane, m
							.getTabName(), m.getIconId(), false);
					tabCounter++;
				} else if (FormTab.TabType.EDITOR.getValue().equals(tabTypeMD)) {
					FormRowEditorTab t = new FormRowEditorTab(m, mainFormPane);
					this.addTab(t);
					tabCounter++;
				}
			}
		}
		// Цикл по полям динамических детейлов
		FormColumnsArr fc = formMetadata.getColumns();
		Iterator<Integer> columnIterator = fc.keySet().iterator();
		while (columnIterator.hasNext()) {
			FormColumnMD c = fc.get(columnIterator.next());
			if ("1".equals(c.getFieldType()) || "2".equals(c.getFieldType())) {
				FormTab.TabType tabType = "1".equals(c.getFieldType()) ? FormTab.TabType.DYNAMIC_DETAIL_SINGLE
						: FormTab.TabType.DYNAMIC_DETAIL_MULTI;
				String tabCode = defTabPrefix + c.getName();
				String tabPosition = "R";
				String tabName = null;
				int iconId = 0;

				// Внутренний цикл по табикам, описанным в колонках
				for (int i = 0; i < tabs.size(); i++) {
					FormTabMD m = tabs.get(i);
					if (m.getTabCode().equals(c.getEditorTabCode())) {
						tabCode = c.getEditorTabCode();
						tabPosition = m.getTabPosition();
						tabName = m.getTabName();
						iconId = m.getIconId();
					}
				}
				if (orientation == ("B".equals(tabPosition) ? Orientation.VERTICAL : Orientation.HORIZONTAL)) {
					MainFormContainer singleDetailTab = null;
					if (FormTab.TabType.DYNAMIC_DETAIL_SINGLE.equals(tabType)) {
						tabName = (null == tabName) ? c.getDisplayName() : tabName;
						tabName = (null == tabName) ? c.getName() : tabName;
						MainFormPane mfp = new MainFormPane();
						mfp.setContents(c.getDescription());
						mfp.setButtonsToolBar(new FormToolbar(mfp));
						singleDetailTab = new MainFormContainer(FormTab.TabType.DYNAMIC_DETAIL_SINGLE, this, (MainFormPane) mfp, tabCode,
								false, false, true, mainFormPane, tabName, iconId);
						singleDetailTab.setDefaultFormPane(mfp);
					}
					DynamicDetailTab dt = new DynamicDetailTab(tabType, singleDetailTab, tabName, iconId);
					dynamicDetailTabs.put(tabCode, dt);
					tabCounter++;
				}
			}
		}

		if (0 == tabCounter) {
			this.hide();
		}
		Utils.debug("before DetailFormsContainer.filterData()...");
		if (null != mainFormPane.getInitialFilter()) {

			filterData(true, true, true);
			Utils.debug("DetailFormsContainer.filterData() executed...");
		}

		addCloseClickHandler(new CloseClickHandler() {
			public void onCloseClick(TabCloseClickEvent event) {
				FormTab ft = (FormTab) event.getTab();
				if (ft.getTabType().equals(FormTab.TabType.DYNAMIC_DETAIL_MULTI)) {
					dynMultiDetailTabsArr.remove(ft.getFormCode());
				}
			}
		});
		// this.hideTabBar();
	}

	public void createDynamicDetails(boolean filterDynamicMultiDetails, boolean filterDynamicSingleDetails) {
		Criteria criteria = mainFormPane.getInitialFilter();
		FormColumnsArr fc = formMetadata.getColumns();
		Iterator<Integer> columnIterator = fc.keySet().iterator();
		while (columnIterator.hasNext()) {
			FormColumnMD c = fc.get(columnIterator.next());
			String tabCode = null != c.getEditorTabCode() ? c.getEditorTabCode() : defTabPrefix + c.getName();
			String detFormCode = criteria.getAttribute(c.getName());
			// Для контекстного меню
			if (filterDynamicSingleDetails && "1".equals(c.getFieldType()) && dynamicDetailTabs.containsKey(tabCode)) {
				DynamicDetailTab dynamicDetailTab = dynamicDetailTabs.get(tabCode);
				dynamicDetailTab.getDetailTab().updateTab(detFormCode, mainFormPane);
			}
			// Обновление/Создание множественных детейлов только в случае явного нажатия на запись родителя. При открытии родительской формы
			// не создавать.
			if (filterDynamicMultiDetails && "2".equals(c.getFieldType()) && dynamicDetailTabs.containsKey(tabCode)) {
				DynamicDetailTab dynamicDetailTab = dynamicDetailTabs.get(tabCode);
				createDynamicMultiDetails(dynamicDetailTab, detFormCode);
			}
		}
	}

	public void createDynamicMultiDetails(DynamicDetailTab dynamicDetailTab, String detFormCode) {
		dynMultiDetailTabsArr = dynamicDetailTab.getDynSingleDetailTabsArr();
		if (dynMultiDetailTabsArr.containsKey(detFormCode)) {
			// TODO - Как-то разрулить - не всегда необходимо переводить фокус на уже существующий детейл.
			// Например свойством в FORM_TABS для динамических детейлов (автофокус при выборе, по умолчанию "Да")
			// Т.к. в форме приказов переключается навязчиво
			this.selectTab(dynMultiDetailTabsArr.get(detFormCode));
		} else {
			if (null != detFormCode) {
				MainFormPane mfp = new MainFormPane(detFormCode, false, false, mainFormPane, false);
				dynMultiDetailTabsArr.put(detFormCode, mfp);
				new MainFormContainer(FormTab.TabType.DYNAMIC_DETAIL_MULTI, this, mfp, detFormCode, false, true, true, mainFormPane,
						dynamicDetailTab.getTitle(), dynamicDetailTab.getIconId());
			}
		}
	}

	public void doBeforeClose() {
		Utils.debug("DetailFormsContainer.doBeforeClose. orientation:" + orientation);
		for (Tab t : this.getTabs()) {
			FormTab ft = (FormTab) t;
			if (ft instanceof MainFormContainer) {
				try {
					((MainFormContainer) ft).getMainFormPane().doBeforeClose();
				} catch (Exception e) {
					Utils.logException(e, "DetailFormsContainer.doBeforeClose()");
				}
			}
		}
	}

	// @@@@ Не доделал
	public void filterData(boolean filterDynamicMultiDetails, boolean filterDynamicSingleDetails, boolean filterStaticDetails) {
		Utils.debug("tabCounter:" + tabCounter);
		if (0 != tabCounter) {
			Utils.debug("DetailFormsContainer[" + orientation + "] - filterData");
			for (Tab t : this.getTabs()) {
				Utils.debug("GridRecordClickHandler.onRecordClick. Tab: " + t.getID());
				FormTab ft = (FormTab) t;
				Utils.debug("Tab " + ft.getFormCode() + ": " + ft.getTabType() + "; " + ft.getClass());
				if (filterStaticDetails && ft.getTabType().equals(FormTab.TabType.DETAIL) && ft instanceof MainFormContainer) {
					((MainFormContainer) ft).getMainFormPane().filterData();
				}
				if (ft.getTabType().equals(FormTab.TabType.EDITOR) && ft instanceof FormRowEditorTab) {
					Utils.debug("FormRowEditorTab>>" + ((FormRowEditorTab) ft).getForm().getID());
				}
			}
			createDynamicDetails(filterDynamicMultiDetails, filterDynamicSingleDetails);
		}
	}

	/**
	 * @return the mainFormPane
	 */
	public MainFormPane getMainFormPane() {
		return mainFormPane;
	}

	/**
	 * @return the tabCounter
	 */
	public int getTabCounter() {
		return tabCounter;
	}

	public void releaseFocus() {
		for (Tab t : this.getTabs()) {
			FormTab ft = (FormTab) t;
			Utils.debug("DetailFormsContainer.releaseFocus tabFormCode:" + ft.getFormCode() + " >>" + ft);
			if (ft instanceof MainFormContainer) {
				MainFormPane mfp = ((MainFormContainer) ft).getMainFormPane();
				mfp.setBorder(false);
				mfp.releaseDetailsFocus();
			}
		}
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}
}