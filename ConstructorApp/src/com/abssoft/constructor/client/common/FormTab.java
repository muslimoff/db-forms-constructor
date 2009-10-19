package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.types.ValueEnum;
import com.smartgwt.client.widgets.Canvas;

public class FormTab extends com.smartgwt.client.widgets.tab.Tab {
	private MainFormPane mainFormPane;

	private String formCode;

	private TabType tabType;

	public enum TabType implements ValueEnum {
		/**
		 * Main form
		 */
		MAIN("0"),
		/**
		 * Editor for current ListGridRecord
		 */
		EDITOR("1"),
		/**
		 * Static Child Form
		 */
		DETAIL("2"),
		/**
		 * Dynamic Child multiple Forms
		 */
		DYNAMIC_DETAIL_MULTI("3"),
		/**
		 * Dynamic Child Single Form with refresh
		 */
		DYNAMIC_DETAIL_SINGLE("4");
		private String value;

		TabType(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	public static String getIconTitle(String title, int iconId) {
		String imgHTML = Canvas.imgHTML(ConstructorApp.menus.getIcons().get(iconId));
		String formTitle = "<span>" + imgHTML + "&nbsp;" + title + "</span>";
		return formTitle;
	}

	public FormTab() {
	}

	public FormTab(TabType tabType, String formCode) {
		super();
		this.tabType = tabType;
		this.formCode = formCode;

	}

	public FormTab(TabType tabType, String formCode, String title) {
		super(title);
		this.tabType = tabType;
		this.formCode = formCode;

	}

	public FormTab(TabType tabType, String formCode, String title, int iconId) {
		this(tabType, formCode);
		setTitle(getIconTitle(title, iconId));

	}

	/**
	 * @return the formCode
	 */
	public String getFormCode() {
		return formCode;
	}

	/**
	 * @return the mainFormPane
	 */
	public MainFormPane getMainFormPane() {
		return mainFormPane;
	}

	/**
	 * @return the tabType
	 */
	public TabType getTabType() {
		return tabType;
	}

	/**
	 * @param formCode
	 *            the formCode to set
	 */
	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}

	/**
	 * @param tabType
	 *            the tabType to set
	 */
	public void setTabType(TabType tabType) {
		this.tabType = tabType;
	}

}
