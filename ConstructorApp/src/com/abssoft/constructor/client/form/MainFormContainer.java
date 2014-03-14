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

	public void updateTab(Criteria parentFormCriteria, String formCode,
			MainFormPane parentFormPane) {
		// TODO Иконка и заголовок табика. не помню, в чем проблема.
		MainFormPane mfp;
		Utils.debug("MainFormContainer.updateTab.1:formCode:" + formCode);
		Utils.debug("MainFormContainer.updateTab.2:parentFormCriteria:"
				+ (null == parentFormCriteria ? null : parentFormCriteria
						.getValues()));
		if (detailTabsArr.containsKey(formCode)) {
			mfp = detailTabsArr.get(formCode);
			if (null != formCode) {
				// mfp.setParentFormCriteria(parentFormCriteria);
				Utils.debug("MainFormContainer.updateTab.3. Before filterData 1.");
				mfp.filterData(parentFormCriteria, false);
				Utils.debug("MainFormContainer.updateTab.4. After filterData 1.");
			}
		} else {
			Utils.debug("MainFormContainer.updateTab.5");
			mfp = (null == formCode) ? defaultFormPane : new MainFormPane(
					formCode, false, parentFormPane, false, getTabMetaData()
							.getTabCode(), parentFormCriteria);
			Utils.debug("MainFormContainer.updateTab.6");
			detailTabsArr.put(formCode, mfp);
			Utils.debug("MainFormContainer.updateTab.7");
		}

		this.setMainFormPane(mfp);
		parentTabSet.updateTab(this, mfp);
		parentTabSet.setTabTitle(this, defaultTitle);
		if (null != formCode) {
			parentTabSet.selectTab(this);
		}
	}

	public MainFormContainer(Criteria parentFormCriteria,
			FormTabMD tabMetaData, FormTab.TabType tabType,
			TabSet parentTabSet, final String formCode) {
		this(parentFormCriteria, tabMetaData, tabType, parentTabSet, formCode,
				true, true);
	}

	public MainFormContainer(Criteria parentFormCriteria,
			FormTabMD tabMetaData, FormTab.TabType tabType,
			TabSet parentTabSet, String formCode, boolean canClose,
			boolean selectAfterCreation) {
		this(parentFormCriteria, tabMetaData, tabType, parentTabSet, formCode,
				canClose, selectAfterCreation, null);
	}

	public MainFormContainer(Criteria parentFormCriteria,
			FormTabMD tabMetaData, FormTab.TabType tabType,
			TabSet parentTabSet, String formCode, boolean canClose,
			boolean selectAfterCreation, MainFormPane parentFormPane) {
		this(tabMetaData, tabType, parentTabSet, new MainFormPane(formCode,
				false, parentFormPane, false, tabMetaData.getTabCode(),
				parentFormCriteria), formCode, canClose, selectAfterCreation,
				parentFormPane, null, 0);
	}

	public MainFormContainer(Criteria parentFormCriteria,
			FormTabMD tabMetaData, FormTab.TabType tabType,
			TabSet parentTabSet, String formCode, boolean canClose,
			boolean selectAfterCreation, final MainFormPane parentFormPane,
			String title, int iconId
			// TODO 20130512 Заменить на код действия
			, Boolean isDrillDownForm) {
		this(tabMetaData, tabType, parentTabSet, new MainFormPane(formCode,
				false, parentFormPane, isDrillDownForm,
				tabMetaData.getTabCode(), parentFormCriteria) {
		}, formCode, canClose, selectAfterCreation, parentFormPane, title,
				iconId);

	}

	public MainFormContainer(FormTabMD tabMetaData, FormTab.TabType tabType,
			TabSet parentTabSet, MainFormPane mainFormPane, String formCode,
			boolean canClose, boolean selectAfterCreation,
			MainFormPane parentFormPane, String title, int iconId) {
		super(tabMetaData, tabType, formCode);
		this.setTabMetaData(tabMetaData);
		this.setMainFormPane(mainFormPane);
		this.getMainFormPane().setMainFormContainer(this);
		this.setParentTabSet(parentTabSet);
		setPane(mainFormPane);
		// mainFormPane.addk
		setCanClose(canClose);
		String fc = this.getFormCode();
		if (ConstructorApp.formNameArr.containsKey(fc)) {
			defaultTitle = getIconTitle((null != title) ? title
					: ConstructorApp.formNameArr.get(fc),
					(0 != iconId) ? iconId : ConstructorApp.formIconArr.get(fc));
		} else {
			defaultTitle = getIconTitle((null != title) ? title : "xxx",
					(0 != iconId) ? iconId : 1);
		}
		setTitle(defaultTitle);
		if (null != parentTabSet) {
			parentTabSet.addTab(this);
			if (selectAfterCreation) {
				parentTabSet.selectTab(this);
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
