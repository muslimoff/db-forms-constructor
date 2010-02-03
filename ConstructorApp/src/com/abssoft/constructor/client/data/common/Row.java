package com.abssoft.constructor.client.data.common;

import java.util.HashMap;

import com.abssoft.constructor.client.metadata.ActionStatus;
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
	private ActionStatus status = new ActionStatus();

	/**
	 * @param serverMessage
	 *            the status to set
	 */

	/**
	 * @return the status
	 */

	public void setStatus(ActionStatus status) {
		this.status = status;
	}

	public ActionStatus getStatus() {
		return status;
	}
}
