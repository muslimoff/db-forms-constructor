package com.abssoft.constructor.client.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.metadata.FormTabMD;
import com.smartgwt.client.types.ValueEnum;
import com.smartgwt.client.widgets.Canvas;

public class FormTab extends com.smartgwt.client.widgets.tab.Tab {
	protected MainFormPane mainFormPane;

	private FormTabMD tabMetaData;
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
		// TODO Rotate text: http://snook.ca/archives/html_and_css/css-text-rotation
		String imgHTML = Canvas.imgHTML(ConstructorApp.menus.getIcons().get(iconId));
		String formTitle = "<span>" + imgHTML + "&nbsp;" + title + "</span>";
		return formTitle;
	}

	public FormTab() {
	}

	public FormTab(FormTabMD tabMetaData, TabType tabType, String formCode) {
		super();
		this.tabType = tabType;
		this.formCode = formCode;
		this.tabMetaData = tabMetaData;

	}

	public FormTab(FormTabMD tabMetaData, TabType tabType, String formCode, String title) {
		super(title);
		this.tabType = tabType;
		this.formCode = formCode;
		this.tabMetaData = tabMetaData;

	}

	public FormTab(FormTabMD tabMetaData, TabType tabType, String formCode, String title, int iconId) {
		this(tabMetaData, tabType, formCode);
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

	protected void setTabMetaData(FormTabMD tabMetaData) {
		this.tabMetaData = tabMetaData;
	}

	public FormTabMD getTabMetaData() {
		return tabMetaData;
	}

}
