package com.abssoft.constructor.common.metadata;

import org.simpleframework.xml.Default;
import org.simpleframework.xml.ElementList;
import org.simpleframework.xml.ElementMap;

import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.FormActionsArr;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.FormTabsArr;
import com.abssoft.constructor.common.FormsArr;
import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Хранит информацию о настройках формы - отображение для вьюшки FORMS_V
 * 
 * @author User
 * 
 */
@Default(required = false)
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
	private String doubleClickActionCode;
	private Integer lookupWidth;
	private Integer lookupHeight;

	@ElementMap(required = false, entry = "column", keyType = Integer.class, valueType = FormColumnMD.class)
	private FormColumnsArr columns;

	@ElementList(required = false, entry = "tab", type = FormTabMD.class)
	private FormTabsArr tabs = new FormTabsArr();

	@ElementList(required = false, entry = "action", type = FormActionMD.class)
	private FormActionsArr actions = new FormActionsArr();

	@ElementMap(required = false, entry = "formLookup", attribute = true, key = "lookupInstanceIdentifierKey", keyType = String.class, valueType = FormMD.class)
	private FormsArr lookupsArr = new FormsArr();

	@ElementMap(required = false, entry = "childForm", attribute = true, key = "childInstanceIdentifierKey", keyType = String.class, valueType = FormMD.class)
	private FormsArr childForms = new FormsArr();

	private Integer objectVersionNumber;

	// TODO вынести в интерфейс
	private ActionStatus status = new ActionStatus();
	private String dragAndDropActionCode;
	private FormInstanceIdentifier formInstanceIdentifier;

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

	public String getDoubleClickActionCode() {
		return doubleClickActionCode;
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

	public void setDoubleClickActionCode(String doubleClickActionCode) {
		this.doubleClickActionCode = doubleClickActionCode;
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

	public void setStatus(ActionStatus status) {
		this.status = status;
	}

	public ActionStatus getStatus() {
		return status;
	}

	public void setLookupWidth(Integer lookupWidth) {
		this.lookupWidth = lookupWidth;
	}

	public Integer getLookupWidth() {
		return lookupWidth;
	}

	public void setLookupHeight(Integer lookupHeight) {
		this.lookupHeight = lookupHeight;
	}

	public Integer getLookupHeight() {
		return lookupHeight;
	}

	public void setDragAndDropActionCode(String dragAndDropActionCode) {
		this.dragAndDropActionCode = dragAndDropActionCode;
	}

	public String getDragAndDropActionCode() {
		return dragAndDropActionCode;
	}

	public void setChildForms(FormsArr childForms) {
		this.childForms = childForms;
	}

	public FormsArr getChildForms() {
		return childForms;
	}

	public void setFormInstanceIdentifier(FormInstanceIdentifier formInstanceIdentifier) {
		this.formInstanceIdentifier = formInstanceIdentifier;
	}

	public FormInstanceIdentifier getFormInstanceIdentifier() {
		return formInstanceIdentifier;
	}

	// public void setMetadataComplete(boolean metadataComplete) {
	// this.metadataComplete = metadataComplete;
	// }
	//
	// public boolean isMetadataComplete() {
	// return metadataComplete;
	// }

}
