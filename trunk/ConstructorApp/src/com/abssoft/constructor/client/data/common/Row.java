package com.abssoft.constructor.client.data.common;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Для хранения данных одной строки запроса
 * 
 * @author User
 */
public class Row extends HashMap<Integer, String> implements IsSerializable {

	private static final long serialVersionUID = -1005056453151583048L;
	/**
	 * Статус (ошибка/успешно)...
	 */
	private String serverMessage;

	/**
	 * @param serverMessage
	 *            the status to set
	 */
	public void setServerMessage(String serverMessage) {
		this.serverMessage = serverMessage;
	}

	/**
	 * @return the status
	 */
	public String getServerMessage() {
		return serverMessage;
	}
}
