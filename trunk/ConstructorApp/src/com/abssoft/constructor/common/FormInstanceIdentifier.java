package com.abssoft.constructor.common;

import com.google.gwt.user.client.rpc.IsSerializable;

public class FormInstanceIdentifier implements IsSerializable {
	private String formCode;
	private int gridHashCode = -999;
	private Boolean isDebugEnabled = false;

	// Для форм, открываемых действиями в новом окне или табе
	// TODO 20130512 Заменить на код действия
	private Boolean isDrillDownForm = false;

	// Для форм-лукапов (FORM_COLUMNS.LOOKUP_CODE и тип=9)
	private Boolean isLookupForm = false;

	private String parentFormCode;

	private String parentFormTabCode;
	private int sessionId;

	public FormInstanceIdentifier() {
	}

	public FormInstanceIdentifier(int sessionId, String formCode, Boolean isDebugEnabled, Boolean isLookupForm, Boolean isDrillDownForm,
			String parentFormCode, String parentFormTabCode) {
		this();
		this.sessionId = sessionId;
		this.isDebugEnabled = isDebugEnabled;
		this.isLookupForm = isLookupForm;
		this.formCode = formCode;
		this.isDrillDownForm = isDrillDownForm;
		this.parentFormCode = parentFormCode;
		this.parentFormTabCode = parentFormTabCode;

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

	public Boolean getIsDebugEnabled() {
		return isDebugEnabled;
	}

	public Boolean getIsDrillDownForm() {
		return isDrillDownForm;
	}

	public Boolean getIsLookupForm() {
		return isLookupForm;
	}

	public String getKey() {
		String res = formCode + "." + parentFormCode + (isLookupForm ? ".Y." : ".N.")
				+ (isDrillDownForm ? ".Y." : ".N." + parentFormTabCode);
		// System.out.println("FormInstanceIdentifier key:" + res);
		return res;
	}

	public String getParentFormCode() {
		return parentFormCode;
	}

	public String getParentFormTabCode() {
		return parentFormTabCode;
	}

	public int getSessionId() {
		return sessionId;
	}

	// Разрешена установка после конструктора
	public void setGridHashCode(int gridHashCode) {
		this.gridHashCode = gridHashCode;
	}

	public void setIsDebugEnabled(Boolean isDebugEnabled) {
		this.isDebugEnabled = isDebugEnabled;
	}
}
