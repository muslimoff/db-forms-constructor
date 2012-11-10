package com.abssoft.constructor.common;

import java.util.Date;

import com.abssoft.constructor.server.Utils;
import com.google.gwt.user.client.rpc.IsSerializable;

public class Attribute implements IsSerializable {
	private Double doubleVal;
	private Date dateVal;
	private Boolean booleanVal;
	private String stringVal;
	private String dataType = "S";

	public Attribute() {
	}

	public Attribute(Object val) {
		if (val instanceof Boolean) {
			Boolean booleanVal = (Boolean) val;
			this.booleanVal = booleanVal;
			this.stringVal = booleanVal ? "Y" : "N";
			this.doubleVal = booleanVal ? 1.0 : 0;
			dataType = "B";
		} else if (val instanceof Date) {
			Date dateVal = (Date) val;
			this.dateVal = dateVal;
			//Utils.spoolOut("Attribute D:" + dateVal);
			dataType = "D";
		} else if (val instanceof Double) {
			Double doubleVal = (Double) val;
			this.doubleVal = doubleVal;
			this.booleanVal = null != doubleVal && 1.0 == doubleVal;
			dataType = "N";
		} else {
			String stringVal = (String) val;
			this.stringVal = stringVal;
			this.booleanVal = "1".equals(stringVal) || "Y".equals(stringVal);
			dataType = "S";
		}
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getAttribute() {
		String val = stringVal;
		if ("B".equals(dataType)) {
			val = null == booleanVal ? null : (booleanVal + "");
		} else if ("N".equals(dataType)) {
			val = null == doubleVal ? null : (doubleVal + "");
		} else if ("D".equals(dataType)) {
			val = null == dateVal ? null : (dateVal + "");
		}
		return val;
	}

	public Boolean getAttributeAsBoolean() {
		return booleanVal;
	}

	public Date getAttributeAsDate() {
		// System.out.println("tttt_srv-get:" + dateVal + "; timezone:" + dateVal.getTimezoneOffset());
		return dateVal;
	}

	public Double getAttributeAsDouble() {
		return doubleVal;
	}

	public Object getAttributeAsObject() {
		Object result;
		if ("N".equals(dataType)) {
			result = getAttributeAsDouble();
		} else if ("D".equals(dataType)) {
			result = getAttributeAsDate();
		} else if ("B".equals(dataType)) {
			result = getAttributeAsBoolean();
		} else {
			result = getAttribute();
		}
		return result;
	}

	public String getDataType() {
		return dataType;
	}
}
