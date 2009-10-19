package com.abssoft.constructor.client.metadata;

import java.util.ArrayList;

public class FormActionsArr extends ArrayList<FormActionMD> {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5373960206497057754L;
	private boolean updateAllowed;
	private boolean insertAllowed;
	private boolean deleteAllowed;

	/**
	 * @return the updateAllowed
	 */
	public boolean isUpdateAllowed() {
		return updateAllowed;
	}

	/**
	 * @param updateAllowed
	 *            the updateAllowed to set
	 */
	public void setUpdateAllowed(boolean updateAllowed) {
		this.updateAllowed = updateAllowed;
	}

	/**
	 * @return the insertAllowed
	 */
	public boolean isInsertAllowed() {
		return insertAllowed;
	}

	/**
	 * @param insertAllowed
	 *            the insertAllowed to set
	 */
	public void setInsertAllowed(boolean insertAllowed) {
		this.insertAllowed = insertAllowed;
	}

	/**
	 * @return the deleteAllowed
	 */
	public boolean isDeleteAllowed() {
		return deleteAllowed;
	}

	/**
	 * @param deleteAllowed
	 *            the deleteAllowed to set
	 */
	public void setDeleteAllowed(boolean deleteAllowed) {
		this.deleteAllowed = deleteAllowed;
	}

}
