package com.abssoft.constructor.common.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ServerInfoMD implements IsSerializable, Cloneable {
	private String displayName;
	private boolean isDefault;
	private boolean debug;
	private boolean allowUserChange;
	private boolean transferPassToClient;
	private String title;
	private int sessionTimeout;
	private int dbSessionTimeout;

	private String dbUsername;
	private String dbPassword;
	private String dbUrl;
	private String fcSchemaOwner;
	private String serverID;
	private String validationFN;

	private boolean showToolbar;
	private boolean showServiceMenu;

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
		result.setServerID(this.getServerID());
		result.setSessionTimeout(this.getSessionTimeout());
		result.setShowToolbar(this.isShowToolbar());
		result.setShowServiceMenu(this.isShowServiceMenu());
		return result;
	}

	public String getDbPassword() {
		return dbPassword;
	}

	public int getDbSessionTimeout() {
		return dbSessionTimeout;
	}

	public String getDbUrl() {
		return dbUrl;
	}

	public String getDbUsername() {
		return dbUsername;
	}

	public String getDisplayName() {
		return displayName;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	public String getServerID() {
		return serverID;
	}

	public int getSessionTimeout() {
		return sessionTimeout;
	}

	public String getTitle() {
		return title;
	}

	public String getValidationFN() {
		return validationFN;
	}

	public boolean isAllowUserChange() {
		return allowUserChange;
	}

	public boolean isDebug() {
		return debug;
	}

	public boolean isDefault() {
		return isDefault;
	}

	public boolean isShowServiceMenu() {
		return showServiceMenu;
	}

	public boolean isShowToolbar() {
		return showToolbar;
	}

	public boolean isTransferPassToClient() {
		return transferPassToClient;
	}

	public void setAllowUserChange(boolean allowUserChange) {
		this.allowUserChange = allowUserChange;
	}

	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}

	public void setDbSessionTimeout(int dbSessionTimeout) {
		this.dbSessionTimeout = dbSessionTimeout;
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

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public void setServerID(String serverID) {
		this.serverID = serverID;
	}

	public void setSessionTimeout(int sessionTimeout) {
		this.sessionTimeout = sessionTimeout;
	}

	public void setShowServiceMenu(boolean showServiceMenu) {
		this.showServiceMenu = showServiceMenu;
	}

	public void setShowToolbar(boolean showToolbar) {
		this.showToolbar = showToolbar;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setTransferPassToClient(boolean transferPassToClient) {
		this.transferPassToClient = transferPassToClient;
	}

	public void setValidationFN(String validationFN) {
		this.validationFN = validationFN;
	}
}