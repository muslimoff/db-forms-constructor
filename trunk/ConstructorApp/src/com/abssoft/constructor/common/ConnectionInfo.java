package com.abssoft.constructor.common;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Хранит информацию о сессии и состоянии подключения
 * 
 * @author User
 * 
 */
public class ConnectionInfo implements IsSerializable {
	private String status;
	private String dbServerVersion;
	private int sessionId;

	// так надо - конструктор без параметров, чтобы не было такого:
	// [ERROR] Type XXXX was not serializable and has no concrete serializable
	// subtypes

	public ConnectionInfo() {
	}

	public ConnectionInfo(String status, int sessionId) {
		this.status = status;
		this.sessionId = sessionId;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStatus() {
		return status;
	}

	public void setSessionId(int sessionId) {
		this.sessionId = sessionId;
	}

	public int getSessionId() {
		return sessionId;
	}

	public void setDbServerVersion(String dbServerVersion) {
		this.dbServerVersion = dbServerVersion;
	}

	public String getDbServerVersion() {
		return dbServerVersion;
	}
}
