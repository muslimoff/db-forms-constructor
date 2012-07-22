package com.abssoft.constructor.common;

import com.google.gwt.user.client.rpc.IsSerializable;

public class FormInstanceIdentifier implements IsSerializable {
	private int sessionId;
	private String formCode;
	private String parentFormCode;
	private int gridHashCode;
	private Boolean isDrillDownForm = false;
	private Boolean isDebugEnabled = false;

	public FormInstanceIdentifier() {
	}

	public FormInstanceIdentifier(int sessionId, Boolean isDebugEnabled) {
		this();
		this.sessionId = sessionId;
		this.isDebugEnabled = isDebugEnabled;
	}

	public FormInstanceIdentifier(int sessionId, String formCode, String parentFormCode, int gridHashCode, Boolean isDebugEnabled) {
		// this.sessionId = sessionId;
		this(sessionId, isDebugEnabled);
		this.formCode = formCode;
		this.parentFormCode = parentFormCode;
		this.gridHashCode = gridHashCode;
	}

	public String getFormCode() {
		return formCode;
	}

	public int getGridHashCode() {
		return gridHashCode;
	}

	public String getInfo() {
		return "form " + formCode + " - gridHashCode:" + gridHashCode;
	}

	public Boolean getIsDrillDownForm() {
		return isDrillDownForm;
	}

	public String getKey() {
		return formCode + "." + parentFormCode + (isDrillDownForm ? ".Y" : "");
	}

	public String getParentFormCode() {
		return parentFormCode;
	}

	public int getSessionId() {
		return sessionId;
	}

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	public void setGridHashCode(int gridHashCode) {
		this.gridHashCode = gridHashCode;
	}

	public void setIsDrillDownForm(Boolean isDrillDownForm) {
		this.isDrillDownForm = isDrillDownForm;
	}

	public void setParentFormCode(String parentFormCode) {
		this.parentFormCode = parentFormCode;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public void setIsDebugEnabled(Boolean isDebugEnabled) {
		this.isDebugEnabled = isDebugEnabled;
	}

	public Boolean getIsDebugEnabled() {
		return isDebugEnabled;
	}

}
