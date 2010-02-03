package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ServerInfoMD implements IsSerializable, Cloneable {
	private String displayName;
	private boolean isDefault;
	private boolean debug;
	private boolean allowUserChange;
	private boolean transferPassToClient;
	private String title;

	private String dbUsername;
	private String dbPassword;
	private String dbUrl;
	private String fcSchemaOwner;

	public ServerInfoMD() {
	}

	public ServerInfoMD clone() {
		ServerInfoMD result = new ServerInfoMD();
		result.setDisplayName(this.getDisplayName());
		result.setDefault(this.isDefault());
		result.setDebug(this.isDebug());
		result.setAllowUserChange(this.isAllowUserChange());
		result.setTransferPassToClient(this.isTransferPassToClient());
		result.setTitle(this.getTitle());
		result.setDbUsername(this.getDbUsername());
		result.setDbPassword(this.getDbPassword());
		result.setDbUrl(this.getDbUrl());
		result.setFcSchemaOwner(this.getFcSchemaOwner());
		return result;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public String getDbUrl() {
		return dbUrl;
	}

	public String getDbUsername() {
		return dbUsername;
	}

	public String getTitle() {
		return title;
	}

	public boolean isDebug() {
		return debug;
	}

	public boolean isDefault() {
		return isDefault;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public void setDbUrl(String dbUrl) {
		this.dbUrl = dbUrl;
	}

	public void setDbUsername(String dbUsername) {
		this.dbUsername = dbUsername;
	}

	public void setDebug(boolean debug) {
		this.debug = debug;
	}

	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setAllowUserChange(boolean allowUserChange) {
		this.allowUserChange = allowUserChange;
	}

	public boolean isAllowUserChange() {
		return allowUserChange;
	}

	public void setTransferPassToClient(boolean transferPassToClient) {
		this.transferPassToClient = transferPassToClient;
	}

	public boolean isTransferPassToClient() {
		return transferPassToClient;
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}
}