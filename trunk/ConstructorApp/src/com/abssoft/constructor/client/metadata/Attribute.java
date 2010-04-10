package com.abssoft.constructor.client.metadata;

import java.util.Date;

import com.google.gwt.user.client.rpc.IsSerializable;

public class Attribute implements IsSerializable {
	private Double doubleVal;
	private String stringVal;
	private Date dateVal;
	private Boolean booleanVal;
	private String dataType = "S";

	public Attribute() {
	}

	public Attribute(Double doubleVal) {
		this.doubleVal = doubleVal;
		this.booleanVal = null != doubleVal && 1.0 == doubleVal;
		dataType = "N";
	}

	public Attribute(String stringVal) {
		this.stringVal = stringVal;
		this.booleanVal = "1".equals(stringVal) || "Y".equals(stringVal);
		dataType = "S";
	}

	public Attribute(Date dateVal) {
		this.dateVal = dateVal;
		dataType = "D";
	}

	public Attribute(Boolean booleanVal) {
		this.booleanVal = booleanVal;
		this.stringVal = booleanVal ? "Y" : "N";
		this.doubleVal = booleanVal ? 1.0 : 0;
		dataType = "B";
	}

	public String getDataType() {
		return dataType;
	}

	public String getAttribute() {
		String val = stringVal;
		if ("B".equals(dataType)) {
			val = null == booleanVal ? null : (booleanVal + "");
		}
		if ("N".equals(dataType)) {
			val = null == doubleVal ? null : (doubleVal + "");
		}
		if ("D".equals(dataType)) {
			val = null == dateVal ? null : (dateVal + "");
		}
		return val;
	}

	public Double getAttributeAsDouble() {
		return doubleVal;
	}

	public Boolean getAttributeAsBoolean() {
		return booleanVal;
	}

	public Date getAttributeAsDate() {
		return dateVal;
	}
}
