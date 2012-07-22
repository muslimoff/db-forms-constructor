package com.abssoft.constructor.common.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ColumnAction implements IsSerializable {
	public ColumnAction() {
	}

	private String actionCode;
	private String actionKeyCode;
	private String colActionTypeCode;

	public String getActionCode() {
		return actionCode;
	}

	public String getActionKeyCode() {
		return actionKeyCode;
	}

	public String getColActionTypeCode() {
		return colActionTypeCode;
	}

	public void setActionCode(String actionCode) {
		this.actionCode = actionCode;
	}

	public void setActionKeyCode(String actionKeyCode) {
		this.actionKeyCode = actionKeyCode;
	}

	public void setColActionTypeCode(String colActionTypeCode) {
		this.colActionTypeCode = colActionTypeCode;
	}
}