package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class MenuMD implements IsSerializable {

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
	 * @return the hotKey
	 */
	public String getHotKey() {
		return hotKey;
	}

	/**
	 * @param hotKey
	 *            the hotKey to set
	 */
	public void setHotKey(String hotKey) {
		this.hotKey = hotKey;
	}

	/**
	 * @return the formName
	 */
	public String getFormName() {
		return formName;
	}

	/**
	 * @param formName
	 *            the formName to set
	 */
	public void setFormName(String formName) {
		this.formName = formName;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
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

	MenuMD() {
	}

	public MenuMD(String formCode, String hotKey, String formName, String description, Integer iconId) {
		setFormCode(formCode);
		setHotKey(hotKey);
		setFormName(formName);
		setDescription(description);
		setIconId(iconId);
	}

	private String formCode;
	private String hotKey;
	private String formName;
	private String description;
	private Integer iconId;

}
