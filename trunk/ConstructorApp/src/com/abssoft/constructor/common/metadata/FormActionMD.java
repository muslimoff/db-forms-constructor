package com.abssoft.constructor.common.metadata;

import java.util.HashMap;

import org.simpleframework.xml.Default;
import org.simpleframework.xml.ElementMap;

import com.google.gwt.user.client.rpc.IsSerializable;

@Default(required = false)
public class FormActionMD implements IsSerializable {

	private String code;
	private String displayName;
	private int iconId;
	private String type;
	private String sqlProcedureName;
	private String dmlProcText;
	private String confirmText;
	private String hotKey;
	private Boolean showSeparatorBelow;
	private Boolean displayOnToolbar;
	private String childFormCode;
	private String urlText;
	private String parentActionCode;
	private Boolean displayInContextMenu;
	private Boolean autoCommit;
	private String statusButtonParam;
	private String statusMsgLevelParam;
	private String statusMsgTxtParam;

	@ElementMap(inline = true, entry = "inputs", required = false, keyType = Integer.class, valueType = String.class)
	private HashMap<Integer, String> inputs = new HashMap<Integer, String>();

	@ElementMap(inline = true, entry = "outputs", required = false, keyType = Integer.class, valueType = String.class)
	private HashMap<Integer, String> outputs = new HashMap<Integer, String>();

	@ElementMap(inline = true, entry = "allArgs", required = false, keyType = Integer.class, valueType = String.class)
	private HashMap<Integer, String> allArgs = new HashMap<Integer, String>();

	@ElementMap(inline = true, entry = "allDataTypes", required = false, keyType = Integer.class, valueType = String.class)
	private HashMap<Integer, String> allDataTypes = new HashMap<Integer, String>();

	@ElementMap(inline = true, entry = "outputsByName", required = false, keyType = String.class, valueType = Integer.class)
	private HashMap<String, Integer> outputsByName = new HashMap<String, Integer>();

	public HashMap<Integer, String> getAllArgs() {
		return allArgs;
	}

	public String getChildFormCode() {
		return childFormCode;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	public String getConfirmText() {
		return confirmText;
	}

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	public Boolean getDisplayOnToolbar() {
		return displayOnToolbar;
	}

	/**
	 * @return the dmlProcText
	 */
	public String getDmlProcText() {
		return dmlProcText;
	}

	public String getHotKey() {
		return hotKey;
	}

	/**
	 * @return the iconId
	 */
	public int getIconId() {
		return iconId;
	}

	/**
	 * @return the inputs
	 */
	public HashMap<Integer, String> getInputs() {
		return inputs;
	}

	/**
	 * @return the outputs
	 */
	public HashMap<Integer, String> getOutputs() {
		return outputs;
	}

	/**
	 * @return the outputsByName
	 */
	public HashMap<String, Integer> getOutputsByName() {
		return outputsByName;
	}

	public Boolean getShowSeparatorBelow() {
		return showSeparatorBelow;
	}

	/**
	 * @return the sqlProcedureName
	 */
	public String getSqlProcedureName() {
		return sqlProcedureName;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param allArgs
	 *            the allArgs to set
	 */
	public void setAllArgs(HashMap<Integer, String> allArgs) {
		this.allArgs = allArgs;
	}

	public void setChildFormCode(String childFormCode) {
		this.childFormCode = childFormCode;
	}

	/**
	 * @param code
	 *            the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	public void setConfirmText(String confirmText) {
		this.confirmText = confirmText;
	}

	/**
	 * @param displayName
	 *            the displayName to set
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public void setDisplayOnToolbar(Boolean displayOnToolbar) {
		this.displayOnToolbar = displayOnToolbar;
	}

	/**
	 * @param dmlProcText
	 *            the dmlProcText to set
	 */
	public void setDmlProcText(String dmlProcText) {
		this.dmlProcText = dmlProcText;
	}

	public void setHotKey(String hotKey) {
		this.hotKey = hotKey;
	}

	/**
	 * @param iconId
	 *            the iconId to set
	 */
	public void setIconId(int iconId) {
		this.iconId = iconId;
	}

	/**
	 * @param inputs
	 *            the inputs to set
	 */
	public void setInputs(HashMap<Integer, String> inputs) {
		this.inputs = inputs;
	}

	/**
	 * @param outputs
	 *            the outputs to set
	 */
	public void setOutputs(HashMap<Integer, String> outputs) {
		this.outputs = outputs;
	}

	/**
	 * @param outputsByName
	 *            the outputsByName to set
	 */
	public void setOutputsByName(HashMap<String, Integer> outputsByName) {
		this.outputsByName = outputsByName;
	}

	public void setShowSeparatorBelow(Boolean showSeparatorBelow) {
		this.showSeparatorBelow = showSeparatorBelow;
	}

	/**
	 * @param sqlProcedureName
	 *            the sqlProcedureName to set
	 */
	public void setSqlProcedureName(String sqlProcedureName) {
		this.sqlProcedureName = sqlProcedureName;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	public void setAllDataTypes(HashMap<Integer, String> allDataTypes) {
		this.allDataTypes = allDataTypes;
	}

	public HashMap<Integer, String> getAllDataTypes() {
		return allDataTypes;
	}

	public void setUrlText(String urlText) {
		this.urlText = urlText;
	}

	public String getUrlText() {
		return urlText;
		// mm20110722 - обратная совместимость - раньше URL хранился в sqlProcedureName для действий 12 и 15
		// String actionUrl = (null == urlText) ? sqlProcedureName : urlText;
		// return actionUrl;
	}

	public void setParentActionCode(String parentActionCode) {
		this.parentActionCode = parentActionCode;
	}

	public String getParentActionCode() {
		return parentActionCode;
	}

	public void setDisplayInContextMenu(Boolean displayInContextMenu) {
		this.displayInContextMenu = displayInContextMenu;
	}

	public Boolean getDisplayInContextMenu() {
		return displayInContextMenu;
	}

	public void setAutoCommit(Boolean autoCommit) {
		this.autoCommit = autoCommit;
	}

	public Boolean getAutoCommit() {
		return autoCommit;
	}

	public void setStatusButtonParam(String statusButtonParam) {
		this.statusButtonParam = statusButtonParam;
	}

	public String getStatusButtonParam() {
		return statusButtonParam;
	}

	public void setStatusMsgLevelParam(String statusMsgLevelParam) {
		this.statusMsgLevelParam = statusMsgLevelParam;
	}

	public String getStatusMsgLevelParam() {
		return statusMsgLevelParam;
	}

	public void setStatusMsgTxtParam(String statusMsgTxtParam) {
		this.statusMsgTxtParam = statusMsgTxtParam;
	}

	public String getStatusMsgTxtParam() {
		return statusMsgTxtParam;
	}

}
