package com.abssoft.constructor.client.form;

import java.util.HashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.metadata.MenuMD;

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
		// TODO Иконка и заголовок табика
		MainFormPane mfp;
		if (detailTabsArr.containsKey(formCode)) {
			mfp = detailTabsArr.get(formCode);
			if (null != formCode) {
				mfp.filterData();
			}
		} else {
			mfp = (null == formCode) ? defaultFormPane : new MainFormPane(formCode, false, false, parentFormPane);
			detailTabsArr.put(formCode, mfp);
		}

		this.setMainFormPane(mfp);
		parentTabSet.updateTab(this, mfp);
		parentTabSet.setTabTitle(this, defaultTitle);
		parentTabSet.selectTab(this);
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
		this(tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane), formCode, isMasterForm, canClose,
				selectAfterCreation, parentFormPane, null, 0);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, String formCode, boolean isMasterForm, boolean canClose,
			boolean selectAfterCreation, MainFormPane parentFormPane, String title, int iconId) {
		this(tabType, parentTabSet, new MainFormPane(formCode, isMasterForm, false, parentFormPane), formCode, isMasterForm, canClose,
				selectAfterCreation, parentFormPane, title, iconId);
	}

	public MainFormContainer(FormTab.TabType tabType, TabSet parentTabSet, MainFormPane mainFormPane, String formCode,
			boolean isMasterForm, boolean canClose, boolean selectAfterCreation, MainFormPane parentFormPane, String title, int iconId) {
		super(tabType, formCode);
		this.setMainFormPane(mainFormPane);
		this.getMainFormPane().setMainFormContainer(this);
		this.setParentTabSet(parentTabSet);
		setPane(mainFormPane);
		setCanClose(canClose);
		MenuMD menu = ConstructorApp.menus.get(this.getFormCode());
		if (null != menu) {
			defaultTitle = getIconTitle((null != title) ? title : menu.getFormName(), (0 != iconId) ? iconId : menu.getIconId());
		} else {
			defaultTitle = getIconTitle((null != title) ? title : "xxx", (0 != iconId) ? iconId : 1);
		}
		setTitle(defaultTitle);
		if (null != parentTabSet) {
			parentTabSet.addTab(MainFormContainer.this);
			if (selectAfterCreation)
				parentTabSet.selectTab(MainFormContainer.this);
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