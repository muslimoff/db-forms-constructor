package com.abssoft.constructor.client.form;

import java.util.HashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;

public class MainFormContainer extends FormTab {
	class DetailTabsArr extends HashMap<String, MainFormPane> {
		private static final long serialVersionUID = 8918652527892874206L;
	}

	DetailTabsArr detailTabsArr = new DetailTabsArr();
	private TabSet parentTabSet;
	private MainFormPane defaultFormPane;
	private String defaultTitle;

	public void select() {
		parentTabSet.selectTab(this);
	}

	public void updateTab(String formCode, MainFormPane parentFormPane) {
		// TODO Иконка и заголовок табика. не помню, в чем проблема.
		MainFormPane mfp;
		if (detailTabsArr.containsKey(formCode)) {
			mfp = detailTabsArr.get(formCode);
			if (null != formCode) {
				mfp.filterData();
			}
		} else {
			mfp = (null == formCode) ? defaultFormPane : new MainFormPane(formCode, false, false, parentFormPane, false);
			detailTabsArr.put(formCode, mfp);
		}

		this.setMainFormPane(mfp);
		parentTabSet.updateTab(this, mfp);
		parentTabSet.setTabTitle(this, defaultTitle);
		if (null != formCode) {
			parentTabSet.selectTab(this);
		}
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, final String formCode) {
		this(tabType, parentTabSet, formCode, true, true, true);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm, boolean canClose,
			boolean selectAfterCreation) {
		this(tabType, parentTabSet, formCode, isMasterForm, canClose, selectAfterCreation, null);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm, boolean canClose,
			boolean selectAfterCreation, MainFormPane parentFormPane) {
		this(tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane, false), formCode, isMasterForm,
				canClose, selectAfterCreation, parentFormPane, null, 0);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm, boolean canClose,
			boolean selectAfterCreation, MainFormPane parentFormPane, String title, int iconId, Boolean isDrillDownForm) {
		this(tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane, isDrillDownForm), formCode,
				isMasterForm, canClose, selectAfterCreation, parentFormPane, title, iconId);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, MainFormPane mainFormPane, String formCode,
			boolean isMasterForm, boolean canClose, boolean selectAfterCreation, MainFormPane parentFormPane, String title, int iconId) {
		super(tabType, formCode);
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
			if (selectAfterCreation)
				parentTabSet.selectTab(MainFormContainer.this);
		} else {
			// TODO Открытие не в табсете а в окне.
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
