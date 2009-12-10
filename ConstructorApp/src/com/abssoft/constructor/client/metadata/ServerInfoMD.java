package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ServerInfoMD implements IsSerializable {
	private String display_name;
	private boolean isDefault;
	private String dbUrl;

	public ServerInfoMD() {
	}

	public void setDisplay_name(String display_name) {
		this.display_name = display_name;
	}

	public String getDisplay_name() {
		return display_name;
	}

	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

	public boolean isDefault() {
		return isDefault;
	}

	public void setDbUrl(String dbUrl) {
		this.dbUrl = dbUrl;
	}

	public String getDbUrl() {
		return dbUrl;
	}
}