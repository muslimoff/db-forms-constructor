package com.abssoft.constructor.client.data;

public class TimeoutException extends Exception {
	public enum TimeoutType {
		APPLICATION, DB
	}

	private TimeoutType timeoutType;
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public TimeoutException() {

	}

	public TimeoutException(TimeoutType timeoutType) {
		this.timeoutType = timeoutType;

	}

	public TimeoutType getTimeoutType() {
		return timeoutType;
	}
}
