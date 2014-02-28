package com.abssoft.constructor.common;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Набор строк (класса Row). Хранит информацию о результатах, возвращенных
 * запросом.
 * 
 * @author User
 */
public class RowsArr extends HashMap<Integer, Row> implements IsSerializable,
		HasActionStatus {

	private static final long serialVersionUID = -6017120529964851633L;

	/**
	 * Статус (ошибка/успешно)...
	 */
	private ActionStatus status = new ActionStatus();
	private int totalRows;

	/**
	 * @param totalRows
	 *            the totalRows to set
	 */
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	/**
	 * @return the totalRows
	 */
	public int getTotalRows() {
		return totalRows;
	}

	public void setStatus(ActionStatus status) {
		this.status = status;
	}

	public ActionStatus getStatus() {
		return status;
	}

}
