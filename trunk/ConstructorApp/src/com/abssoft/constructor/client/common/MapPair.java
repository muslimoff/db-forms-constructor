package com.abssoft.constructor.client.common;

public class MapPair {
	private String key;
	private String value;

	public MapPair(String key, String value) {
		this.setKey(key);
		this.setValue(value);
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getKey() {
		return key;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
}
