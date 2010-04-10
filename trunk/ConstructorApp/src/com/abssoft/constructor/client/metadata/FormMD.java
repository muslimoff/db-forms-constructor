package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Хранит информацию о настройках формы - отображение для вьюшки FORMS_V
 * 
 * @author User
 * 
 */
public class FormMD implements IsSerializable {

	private String formCode;
	private String hotKey;
	private String formName;
	private String formType;
	private String showTreeRootNode;
	private Integer iconId;
	private String width;
	private String height;
	private String bottomTabsPosition;
	private String sideTabsPosition;
	private boolean showBottomToolBar;
	private FormColumnsArr columns;
	private FormTabsArr tabs;
	private FormActionsArr actions;
	private Integer objectVersionNumber;
	private FormsArr lookupsArr = new FormsArr();

	/**
	 * 
	 */
	public FormMD() {
	}

	/**
	 * @return the actions
	 */
	public FormActionsArr getActions() {
		return actions;
	}

	/**
	 * @return the bottomTabsPosition
	 */
	public String getBottomTabsPosition() {
		return bottomTabsPosition;
	}

	/**
	 * @return the columns
	 */
	public FormColumnsArr getColumns() {
		return columns;
	}

	public String getFormCode() {
		return formCode;
	}

	public String getFormName() {
		return formName;
	}

	/**
	 * @return the formType
	 */
	public String getFormType() {
		return formType;
	}

	public String getHeight() {
		return height;
	}

	public String getHotKey() {
		return hotKey;
	}

	public Integer getIconId() {
		return iconId;
	}

	public FormsArr getLookupsArr() {
		return lookupsArr;
	}

	/**
	 * @return the objectVersionNumber
	 */
	public Integer getObjectVersionNumber() {
		return objectVersionNumber;
	}

	/**
	 * @return the showTreeRootNode
	 */
	public String getShowTreeRootNode() {
		return showTreeRootNode;
	}

	/**
	 * @return the sideTabsPosition
	 */
	public String getSideTabsPosition() {
		return sideTabsPosition;
	}

	/**
	 * @return the tabs
	 */
	public FormTabsArr getTabs() {
		return tabs;
	}

	public String getWidth() {
		return width;
	}

	/**
	 * @return the showBottomToolBar
	 */
	public boolean isShowBottomToolBar() {
		return showBottomToolBar;
	}

	/**
	 * @param actions
	 *            the actions to set
	 */
	public void setActions(FormActionsArr actions) {
		this.actions = actions;
	}

	/**
	 * @param bottomTabsPosition
	 *            the bottomTabsPosition to set
	 */
	public void setBottomTabsPosition(String bottomTabsPosition) {
		this.bottomTabsPosition = bottomTabsPosition;
	}

	/**
	 * @param columns
	 *            the columns to set
	 */
	public void setColumns(FormColumnsArr columns) {
		this.columns = columns;
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
	 * @param formType
	 *            the formType to set
	 */
	public void setFormType(String formType) {
		this.formType = formType;
	}

	/**
	 * @param height
	 */
	public void setHeight(String height) {
		this.height = height;
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

	public void setLookupsArr(FormsArr lookupsArr) {
		this.lookupsArr = lookupsArr;
	}

	/**
	 * @param objectVersionNumber
	 *            the objectVersionNumber to set
	 */
	public void setObjectVersionNumber(Integer objectVersionNumber) {
		this.objectVersionNumber = objectVersionNumber;
	}

	/**
	 * @param showBottomToolBar
	 *            the showBottomToolBar to set
	 */
	public void setShowBottomToolBar(boolean showBottomToolBar) {
		this.showBottomToolBar = showBottomToolBar;
	}

	/**
	 * @param showTreeRootNode
	 *            the showTreeRootNode to set
	 */
	public void setShowTreeRootNode(String showTreeRootNode) {
		this.showTreeRootNode = showTreeRootNode;
	}

	/**
	 * @param sideTabsPosition
	 *            the sideTabsPosition to set
	 */
	public void setSideTabsPosition(String sideTabsPosition) {
		this.sideTabsPosition = sideTabsPosition;
	}

	/**
	 * @param tabs
	 *            the tabs to set
	 */
	public void setTabs(FormTabsArr tabs) {
		this.tabs = tabs;
	}

	/**
	 * @param width
	 */
	public void setWidth(String width) {
		this.width = width;
	}
}
