package com.abssoft.constructor.client.data.common;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Набор строк (класса Row). Хранит информацию о результатах, возвращенных запросом.
 * 
 * @author User
 */
public class RowsArr extends HashMap<Integer, Row> implements IsSerializable {

	private static final long serialVersionUID = -6017120529964851633L;
	/**
	 * Статус (ошибка/успешно)...
	 */
	private String status;
	private int totalRows;

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

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

}
