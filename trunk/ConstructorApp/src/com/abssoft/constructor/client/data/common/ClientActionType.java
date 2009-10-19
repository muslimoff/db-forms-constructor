package com.abssoft.constructor.client.data.common;

public enum ClientActionType {

	/**
	 * Add new Record
	 */
	ADD("1"),
	/**
	 * Update existing Record.
	 */
	UPD("2"),
	/**
	 * Remove Record
	 */
	DEL("3");

	private String value;

	ClientActionType(String value) {
		this.value = value;
	}

	public String getValue() {
		return this.value;
	}
}