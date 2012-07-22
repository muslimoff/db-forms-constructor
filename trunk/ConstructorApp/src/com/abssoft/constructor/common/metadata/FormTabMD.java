package com.abssoft.constructor.common.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class FormTabMD implements IsSerializable {
	private String formCode;
	private String tabCode;
	private String childFormCode;
	private String tabPosition;
	private String tabName;
	private Integer numberOfColumns;
	private Integer iconId;
	private String tabType;

	/**
	 * @return the formCode
	 */
	public String getFormCode() {
		return formCode;
	}

	/**
	 * @param formCode
	 *            the formCode to set
	 */
	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	/**
	 * @return the tabCode
	 */
	public String getTabCode() {
		return tabCode;
	}

	/**
	 * @param tabCode
	 *            the tabCode to set
	 */
	public void setTabCode(String tabCode) {
		this.tabCode = tabCode;
	}

	/**
	 * @return the childFormCode
	 */
	public String getChildFormCode() {
		return childFormCode;
	}

	/**
	 * @param childFormCode
	 *            the childFormCode to set
	 */
	public void setChildFormCode(String childFormCode) {
		this.childFormCode = childFormCode;
	}

	/**
	 * @return the tabPosition
	 */
	public String getTabPosition() {
		return tabPosition;
	}

	/**
	 * @param tabPosition
	 *            the tabPosition to set
	 */
	public void setTabPosition(String tabPosition) {
		this.tabPosition = tabPosition;
	}

	/**
	 * @return the tabName
	 */
	public String getTabName() {
		return tabName;
	}

	/**
	 * @param tabName
	 *            the tabName to set
	 */
	public void setTabName(String tabName) {
		this.tabName = tabName;
	}

	/**
	 * @return the numberOfColumns
	 */
	public Integer getNumberOfColumns() {
		return numberOfColumns;
	}

	/**
	 * @param numberOfColumns
	 *            the numberOfColumns to set
	 */
	public void setNumberOfColumns(Integer numberOfColumns) {
		this.numberOfColumns = numberOfColumns;
	}

	/**
	 * @return the iconId
	 */
	public Integer getIconId() {
		return iconId;
	}

	/**
	 * @param iconId
	 *            the iconId to set
	 */
	public void setIconId(Integer iconId) {
		this.iconId = iconId;
	}

	/**
	 * @param tabType
	 *            the tabType to set
	 */
	public void setTabType(String tabType) {
		this.tabType = tabType;
	}

	/**
	 * @return the tabType
	 */
	public String getTabType() {
		return tabType;
	}

}
