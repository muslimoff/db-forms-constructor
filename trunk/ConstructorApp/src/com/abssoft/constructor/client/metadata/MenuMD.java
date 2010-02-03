package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class MenuMD implements IsSerializable {

	private String formCode;
	private String formName;
	private Integer iconId;
	private String hotKey;
	private String description;
	private String lvl;
	private String menuCode;
	private String parentMenuCode;
	private String menuPosition;
	private String showInNavigator;
	private String menuName;
	private int childCount;

	public MenuMD() {
	}

	public int getChildCount() {
		return childCount;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @return the formCode
	 */
	public String getFormCode() {
		return formCode;
	}

	/**
	 * @return the formName
	 */
	public String getFormName() {
		return formName;
	}

	/**
	 * @return the hotKey
	 */
	public String getHotKey() {
		return hotKey;
	}

	/**
	 * @return the iconId
	 */
	public Integer getIconId() {
		return iconId;
	}

	public String getLvl() {
		return lvl;
	}

	public String getMenuCode() {
		return menuCode;
	}

	public String getMenuName() {
		return menuName;
	}

	public String getMenuPosition() {
		return menuPosition;
	}

	public String getParentMenuCode() {
		return parentMenuCode;
	}

	public String getShowInNavigator() {
		return showInNavigator;
	}

	public void setChildCount(int childCount) {
		this.childCount = childCount;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @param formCode
	 *            the formCode to set
	 */
	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	/**
	 * @param formName
	 *            the formName to set
	 */
	public void setFormName(String formName) {
		this.formName = formName;
	}

	/**
	 * @param hotKey
	 *            the hotKey to set
	 */
	public void setHotKey(String hotKey) {
		this.hotKey = hotKey;
	}

	/**
	 * @param iconId
	 *            the iconId to set
	 */
	public void setIconId(Integer iconId) {
		this.iconId = iconId;
	}

	public void setLvl(String lvl) {
		this.lvl = lvl;
	}

	public void setMenuCode(String menuCode) {
		this.menuCode = menuCode;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public void setMenuPosition(String menuPosition) {
		this.menuPosition = menuPosition;
	}

	public void setParentMenuCode(String parentMenuCode) {
		this.parentMenuCode = parentMenuCode;
	}

	public void setShowInNavigator(String showInNavigator) {
		this.showInNavigator = showInNavigator;
	}

}
