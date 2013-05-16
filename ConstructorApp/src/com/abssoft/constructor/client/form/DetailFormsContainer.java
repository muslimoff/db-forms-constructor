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
import com.smartgwt.client.widgets.layout.SectionStack;
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
		private FormTabMD formTabMD;

		DynamicDetailTab(FormTabMD formTabMD, FormTab.TabType tabType, MainFormContainer singleDetailTab, String title, int iconId) {
			setFormTabMD(formTabMD);
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

		private void setFormTabMD(FormTabMD formTabMD) {
			this.formTabMD = formTabMD;
		}

		public FormTabMD getFormTabMD() {
			return formTabMD;
		}
	}

	private final String defTabPrefix = "GEN_TAB_";
	private MainFormPane mainFormPane;
	Orientation orientation;
	private int tabCounter = 0;
	private DetailTabsArr dynMultiDetailTabsArr = new DetailTabsArr();

	private FormMD formMetadata;

	private HashMap<String, DynamicDetailTab> dynamicDetailTabs = new HashMap<String, DynamicDetailTab>();

	// @Override
	// protected void setHideTabsetPanesButtonIcons(Side tabBarPosition) {
	// super.setHideTabsetPanesButtonIcons(tabBarPosition);
	// String icon;
	// String prevIcon;
	// switch (orientation) {
	// case HORIZONTAL:
	// icon = "right";
	// prevIcon = "left";
	// break;
	// default:
	// icon = "up";
	// prevIcon = "down";
	// }
	// currentHideTabsetPanesButtonIcon = hideTabsetPanesButtonIconTemplate.replace("&direction&", icon);
	// prevHideTabsetPanesButtonIcon = hideTabsetPanesButtonIconTemplate.replace("&direction&", prevIcon);
	// }

	@Override
	protected void showOrCollapse() {

		// MainFormContainer mfc = (MainFormContainer) this.getSelectedTab();
		// SectionStack s1 = mfc.getMainFormPane().sections;
		// s1.getSection(0).setExpanded(!isCollapsed());

		if (isCollapsed()) {
			doUpAction();
		} else {
			doDownAction();
		}
		// if (sections.)
		// .setExpanded(!isCollapsed())

		//
		// MainFormPane mfp1 = this.mainFormPane.getParentFormPane();
		// Window.alert("showOrCollapse:" + mfp1.getFormCode());
		// SectionStackSection s1 = this.mainFormPane.getParentFormPane().sections.getSection(1);
		// s1.setExpanded(!isCollapsed());

		// this.mainFormPane.sections.getSection(1).setExpanded(isCollapsed());
		// isCollapsed

		// Window.alert("showOrCollapse:" + this.getParent() + "; " + this.getParentElement() + "; "
		// // + (this.getParentElement() instanceof SectionStackSection ? 1 : 2));
		// + this.getSelectedTab());

		// switch (orientation) {
		// case HORIZONTAL:
		// // mainFormPane.get
		// ;
		// break;
		// default:
		// ;
		// }
	}

	protected void showOrCollapseReviewSuperclassPlease(boolean isExpanded) {
		Utils.debugAlert("1showOrCollapseReviewSuperclassPlease(boolean isExpanded=" + isExpanded + ")");
		MainFormPane mfp = null;
		if (this.getSelectedTab() instanceof FormTab) {
			Utils.debugAlert("2showOrCollapseReviewSuperclassPlease(boolean isExpanded=" + isExpanded + ")");
			mfp = ((FormTab) this.getSelectedTab()).getMainFormPane();
		}
		if (null != mfp) {
			SectionStack s1 = mfp.sections;
			if (null != s1 && null != s1.getSection(0) && s1.getSection(0).getAttributeAsBoolean("showHeader")) {
				Utils.debugAlert("3showOrCollapseReviewSuperclassPlease(boolean isExpanded=" + isExpanded + ")");
				s1.getSection(0).setExpanded(isExpanded);
			}
		}
	}

	@Override
	protected void doUpAction() {
		this.mainFormPane.getBottomDetailFormsContainer().setHeight100();
		showOrCollapseReviewSuperclassPlease(true);
	}

	@Override
	protected void doDownAction() {
		this.mainFormPane.getBottomDetailFormsContainer().setHeight(24);
		showOrCollapseReviewSuperclassPlease(false);

	}

	DetailFormsContainer(Criteria parentFormCriteria, MainFormPane mainFormPane, Orientation orientation) {
		Utils.debug("DetailFormsContainer... orientation:" + orientation);
		Utils.debug("DetailFormsContainer... parentFormCriteria:" + parentFormCriteria.getValues());
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
		if (tabsOrientStr.equals("L")) {
			tabsOrient = Side.LEFT;
		} else if (tabsOrientStr.equals("R")) {
			tabsOrient = Side.RIGHT;
		} else if (tabsOrientStr.equals("B")) {
			tabsOrient = Side.BOTTOM;
		} else {
			tabsOrient = Side.TOP;
		}
		Utils.debug("before DetailFormsContainer.setTabBarPosition...");
		setTabBarPosition(tabsOrient);
		Utils.debug("after DetailFormsContainer.setTabBarPosition...");
		// обработку скрытия таббара (tabsOrientStr = "H") см в методе MainFormPane.createDetailForms, в самом конце

		FormTabsArr tabs = formMetadata.getTabs();
		// Цикл по табикам статических типов
		for (int i = 0; i < tabs.size(); i++) {
			FormTabMD m = tabs.get(i);
			String tabTypeMD = m.getTabType();
			if (orientation == (m.getTabPosition().equals("B") ? Orientation.VERTICAL : Orientation.HORIZONTAL)) {
				if (null != m.getChildFormCode() && FormTab.TabType.DETAIL.getValue().equals(tabTypeMD)) {
					new MainFormContainer(parentFormCriteria, m, FormTab.TabType.DETAIL, this, m.getChildFormCode(), false, false, false,
							mainFormPane, m.getTabName(), m.getIconId(), false);
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

				FormTabMD m = null;
				// Внутренний цикл по табикам, описанным в колонках
				for (int i = 0; i < tabs.size(); i++) {
					if (tabs.get(i).getTabCode().equals(c.getEditorTabCode())) {
						m = tabs.get(i);
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
						singleDetailTab = new MainFormContainer(m, FormTab.TabType.DYNAMIC_DETAIL_SINGLE, this, (MainFormPane) mfp,
								tabCode, false, false, true, mainFormPane, tabName, iconId);
						singleDetailTab.setDefaultFormPane(mfp);
					}
					DynamicDetailTab dt = new DynamicDetailTab(m, tabType, singleDetailTab, tabName, iconId);
					dynamicDetailTabs.put(tabCode, dt);
					tabCounter++;
				}
			}
		}

		if (0 == tabCounter) {
			this.hide();
		} else {
			Utils.debug("DetailFormsContainer before filterDetailContainerData() start...");
			if (!mainFormPane.getThisFormCriteria().equals(MainFormPane.INTITAL_CRITERIA)) {
				filterDetailContainerData(mainFormPane.getThisFormCriteria(), true, true, true);
				Utils.debug("DetailFormsContainer. after filterDetailContainerData() execution...");
			}
		}

		addCloseClickHandler(new CloseClickHandler() {
			public void onCloseClick(TabCloseClickEvent event) {
				FormTab ft = (FormTab) event.getTab();
				if (ft.getTabType().equals(FormTab.TabType.DYNAMIC_DETAIL_MULTI)) {
					dynMultiDetailTabsArr.remove(ft.getFormCode());
				}
			}
		});
	}

	public void createDynamicDetails(Criteria parentFormCriteria, boolean filterDynamicMultiDetails, boolean filterDynamicSingleDetails) {
		Criteria criteria = mainFormPane.getThisFormCriteria();
		FormColumnsArr fc = formMetadata.getColumns();
		Iterator<Integer> columnIterator = fc.keySet().iterator();
		while (columnIterator.hasNext()) {
			FormColumnMD c = fc.get(columnIterator.next());
			String tabCode = (null != c.getEditorTabCode()) ? c.getEditorTabCode() : defTabPrefix + c.getName();
			String detFormCode = criteria.getAttribute(c.getName());
			// Для контекстного меню
			if (filterDynamicSingleDetails && "1".equals(c.getFieldType()) && dynamicDetailTabs.containsKey(tabCode)) {
				DynamicDetailTab dynamicDetailTab = dynamicDetailTabs.get(tabCode);
				dynamicDetailTab.getDetailTab().updateTab(parentFormCriteria, detFormCode, mainFormPane);
			}
			// Обновление/Создание множественных детейлов только в случае явного нажатия на запись родителя. При открытии родительской формы
			// не создавать.
			if (filterDynamicMultiDetails && "2".equals(c.getFieldType()) && dynamicDetailTabs.containsKey(tabCode)) {
				DynamicDetailTab dynamicDetailTab = dynamicDetailTabs.get(tabCode);
				createDynamicMultiDetails(parentFormCriteria, dynamicDetailTab, detFormCode);
			}
		}
	}

	public void createDynamicMultiDetails(Criteria parentFormCriteria, DynamicDetailTab dynamicDetailTab, String detFormCode) {
		Utils.debug("DetailFormsContainer.createDynamicMultiDetails. parentFormCriteria:"
				+ (null == parentFormCriteria ? null : parentFormCriteria.getValues()));
		dynMultiDetailTabsArr = dynamicDetailTab.getDynSingleDetailTabsArr();
		if (dynMultiDetailTabsArr.containsKey(detFormCode)) {
			// TODO - Как-то разрулить - не всегда необходимо переводить фокус на уже существующий детейл.
			// Например свойством в FORM_TABS для динамических детейлов (автофокус при выборе, по умолчанию "Да")
			// Т.к. в форме приказов переключается навязчиво
			this.selectTab(dynMultiDetailTabsArr.get(detFormCode));
		} else {
			if (null != detFormCode) {
				boolean isMasterForm = false; // true;
				MainFormPane mfp = new MainFormPane(detFormCode, isMasterForm, false, mainFormPane, false, dynamicDetailTab.getFormTabMD()
						.getTabCode(), parentFormCriteria
				// mainFormPane.getThisFormCriteria()
				);
				dynMultiDetailTabsArr.put(detFormCode, mfp);
				new MainFormContainer(dynamicDetailTab.getFormTabMD(), FormTab.TabType.DYNAMIC_DETAIL_MULTI, this, mfp, detFormCode,
						isMasterForm, true, true, mainFormPane, dynamicDetailTab.getTitle(), dynamicDetailTab.getIconId());
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
	public void filterDetailContainerData(Criteria parentFormCriteriaExt, boolean filterDynamicMultiDetails,
			boolean filterDynamicSingleDetails, boolean filterStaticDetails) {
		this.parentFormCriteriaIntrn = parentFormCriteriaExt;
		if (0 != tabCounter) {
			Utils.debug("DetailFormsContainer.filterDetailContainerData. tabCounter:" + tabCounter + "; parentFormCriteria:"
					+ this.parentFormCriteriaIntrn.getValues());
			Utils.debug("DetailFormsContainer[" + orientation + "] - filterData");
			for (Tab t : this.getTabs()) {
				Utils.debug("GridRecordClickHandler.onRecordClick. Tab: " + t.getID());
				FormTab ft = (FormTab) t;
				Utils.debug("Tab " + ft.getFormCode() + ": " + ft.getTabType() + "; " + ft.getClass());
				if (filterStaticDetails && ft.getTabType().equals(FormTab.TabType.DETAIL) && ft instanceof MainFormContainer) {
					MainFormPane mfp = ((MainFormContainer) ft).getMainFormPane();
					// TODO 20130512 -- InstanceIdentifier.setParentFormTabCode - почему здесь? А InstanceIdentifier.setParentFormCode в
					// конструкторе MainFormPane??
					// mfp.getInstanceIdentifier().setParentFormTabCode1(((MainFormContainer) ft).getTabMetaData().getTabCode());
					if (this.getSelectedTab().equals(t)) {
						// Utils.debugAlert("xxxxxxxx:" + parentFormCriteria.getValues());
						Utils.debug("DetailFormsContainer.filterDetailContainerData. Before filterData 1.");
						mfp.filterData(this.parentFormCriteriaIntrn, false);
					}
				}
				if (ft.getTabType().equals(FormTab.TabType.EDITOR) && ft instanceof FormRowEditorTab) {
					Utils.debug("FormRowEditorTab>>" + ((FormRowEditorTab) ft).getForm().getID());
				}
			}
			createDynamicDetails(this.parentFormCriteriaIntrn, filterDynamicMultiDetails, filterDynamicSingleDetails);
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
				// Utils.debugAlert(ft.get);
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