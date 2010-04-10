package com.abssoft.constructor.client.metadata;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

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

	public String getHotKey() {
		return hotKey;
	}

	public void setHotKey(String hotKey) {
		this.hotKey = hotKey;
	}

	public Boolean getShowSeparatorBelow() {
		return showSeparatorBelow;
	}

	public void setShowSeparatorBelow(Boolean showSeparatorBelow) {
		this.showSeparatorBelow = showSeparatorBelow;
	}

	public Boolean getDisplayOnToolbar() {
		return displayOnToolbar;
	}

	public void setDisplayOnToolbar(Boolean displayOnToolbar) {
		this.displayOnToolbar = displayOnToolbar;
	}

	private HashMap<Integer, String> inputs = new HashMap<Integer, String>();
	private HashMap<Integer, String> outputs = new HashMap<Integer, String>();
	private HashMap<Integer, String> allArgs = new HashMap<Integer, String>();
	private HashMap<String, Integer> outputsByName = new HashMap<String, Integer>();

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @return the iconId
	 */
	public int getIconId() {
		return iconId;
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
	 * @param code
	 *            the code to set
	 */
	public void setCode(String code) {
		this.code = code;
	}

	/**
	 * @param displayName
	 *            the displayName to set
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/**
	 * @param iconId
	 *            the iconId to set
	 */
	public void setIconId(int iconId) {
		this.iconId = iconId;
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

	/**
	 * @param dmlProcText
	 *            the dmlProcText to set
	 */
	public void setDmlProcText(String dmlProcText) {
		this.dmlProcText = dmlProcText;
	}

	/**
	 * @return the dmlProcText
	 */
	public String getDmlProcText() {
		return dmlProcText;
	}

	/**
	 * @param inputs
	 *            the inputs to set
	 */
	public void setInputs(HashMap<Integer, String> inputs) {
		this.inputs = inputs;
	}

	/**
	 * @return the inputs
	 */
	public HashMap<Integer, String> getInputs() {
		return inputs;
	}

	/**
	 * @param outputs
	 *            the outputs to set
	 */
	public void setOutputs(HashMap<Integer, String> outputs) {
		this.outputs = outputs;
	}

	/**
	 * @return the outputs
	 */
	public HashMap<Integer, String> getOutputs() {
		return outputs;
	}

	/**
	 * @param allArgs
	 *            the allArgs to set
	 */
	public void setAllArgs(HashMap<Integer, String> allArgs) {
		this.allArgs = allArgs;
	}

	/**
	 * @return the allArgs
	 */
	public HashMap<Integer, String> getAllArgs() {
		return allArgs;
	}

	/**
	 * @param outputsByName
	 *            the outputsByName to set
	 */
	public void setOutputsByName(HashMap<String, Integer> outputsByName) {
		this.outputsByName = outputsByName;
	}

	/**
	 * @return the outputsByName
	 */
	public HashMap<String, Integer> getOutputsByName() {
		return outputsByName;
	}

	public void setConfirmText(String confirmText) {
		this.confirmText = confirmText;
	}

	public String getConfirmText() {
		return confirmText;
	}

}
