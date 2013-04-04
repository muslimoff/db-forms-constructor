package com.abssoft.constructor.client.form;

import java.util.HashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.common.metadata.FormTabMD;
import com.smartgwt.client.data.Criteria;

public class MainFormContainer extends FormTab {
	class DetailTabsArr extends HashMap<String, MainFormPane> {
		private static final long serialVersionUID = 8918652527892874206L;
	}

	DetailTabsArr detailTabsArr = new DetailTabsArr();
	private TabSet parentTabSet;
	private MainFormPane defaultFormPane;
	private String defaultTitle;

	// private FormTabMD tabMetaData;

	// public void select() {
	// parentTabSet.selectTab(this);
	// }

	public void updateTab(Criteria parentFormCriteria, String formCode, MainFormPane parentFormPane) {
		// TODO Иконка и заголовок табика. не помню, в чем проблема.
		MainFormPane mfp;
		Utils.debug("updateTab start: " + parentFormCriteria + "; formCode:" + formCode);
		if (detailTabsArr.containsKey(formCode)) {
			mfp = detailTabsArr.get(formCode);
			if (null != formCode) {
				mfp.setParentFormCriteria(parentFormCriteria);
				mfp.filterData();
			}
		} else {
			mfp = (null == formCode) ? defaultFormPane : new MainFormPane(formCode, false, false, parentFormPane, false, getTabMetaData()
					.getTabCode());
			detailTabsArr.put(formCode, mfp);
		}

		this.setMainFormPane(mfp);
		parentTabSet.updateTab(this, mfp);
		parentTabSet.setTabTitle(this, defaultTitle);
		if (null != formCode) {
			parentTabSet.selectTab(this);
		}
	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType, TabSet parentTabSet, final String formCode) {
		this(tabMetaData, tabType, parentTabSet, formCode, true, true, true);
	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm,
			boolean canClose, boolean selectAfterCreation) {
		this(tabMetaData, tabType, parentTabSet, formCode, isMasterForm, canClose, selectAfterCreation, null);
	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm,
			boolean canClose, boolean selectAfterCreation, MainFormPane parentFormPane) {
		this(tabMetaData, tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane, false, tabMetaData
				.getTabCode()), formCode, isMasterForm, canClose, selectAfterCreation, parentFormPane, null, 0);
	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm,
			boolean canClose, boolean selectAfterCreation, MainFormPane parentFormPane, String title, int iconId, Boolean isDrillDownForm) {
		this(tabMetaData, tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane, isDrillDownForm,
				tabMetaData.getTabCode()), formCode, isMasterForm, canClose, selectAfterCreation, parentFormPane, title, iconId);
	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType, TabSet parentTabSet, MainFormPane mainFormPane,
			String formCode, boolean isMasterForm, boolean canClose, boolean selectAfterCreation, MainFormPane parentFormPane,
			String title, int iconId) {
		super(tabMetaData, tabType, formCode);
		this.setTabMetaData(tabMetaData);
		this.setMainFormPane(mainFormPane);
		this.getMainFormPane().setMainFormContainer(this);
		this.setParentTabSet(parentTabSet);
		setPane(mainFormPane);
		setCanClose(canClose);
		String fc = this.getFormCode();
		if (ConstructorApp.formNameArr.containsKey(fc)) {
			defaultTitle = getIconTitle((null != title) ? title : ConstructorApp.formNameArr.get(fc), (0 != iconId) ? iconId
					: ConstructorApp.formIconArr.get(fc));
		} else {
			defaultTitle = getIconTitle((null != title) ? title : "xxx", (0 != iconId) ? iconId : 1);
		}
		setTitle(defaultTitle);
		if (null != parentTabSet) {
			parentTabSet.addTab(MainFormContainer.this);
			if (selectAfterCreation) {
				parentTabSet.selectTab(MainFormContainer.this);
			}
			// parentTabSet.hideTabBar();
			// parentTabSet.setTabSetContextMenu(this);

			// mainFormPane.getInstanceIdentifier().setParentFormTabCode(getTabMetaData().getTabCode());
		}
	}

	public MainFormContainer() {
		super();
	}

	/**
	 * @return the parentTabSet
	 */
	public TabSet getParentTabSet() {
		return parentTabSet;
	}

	/**
	 * @param parentTabSet
	 *            the parentTabSet to set
	 */
	public void setParentTabSet(TabSet parentTabSet) {
		this.parentTabSet = parentTabSet;
	}

	/**
	 * @param defaultFormPane
	 *            the defaultFormPane to set
	 */
	public void setDefaultFormPane(MainFormPane defaultFormPane) {
		this.defaultFormPane = defaultFormPane;
	}

	/**
	 * @return the defaultFormPane
	 */
	public MainFormPane getDefaultFormPane() {
		return defaultFormPane;
	}
}
