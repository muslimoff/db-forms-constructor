package com.abssoft.constructor.common.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

public class FormColumnLookupMappingMD implements IsSerializable {

	private String lookupFormColumnCode;
	private String columnUserName;
	private String columnDisplaySize;
	private Integer columnDisplayNumber;
	private String showOnGrid;
	private String columnCodeToMapping;

	// private String formColumn_lookup_map_id
	// private String form_code
	// private String column_code
	// private String lookup_form_code

	// private String mappingType;
	// private String constantValue;

	public void setLookupFormColumnCode(String lookupFormColumnCode) {
		this.lookupFormColumnCode = lookupFormColumnCode;
	}

	public String getLookupFormColumnCode() {
		return lookupFormColumnCode;
	}

	public void setColumnUserName(String columnUserName) {
		this.columnUserName = columnUserName;
	}

	public String getColumnUserName() {
		return columnUserName;
	}

	public void setColumnDisplaySize(String columnDisplaySize) {
		this.columnDisplaySize = columnDisplaySize;
	}

	public String getColumnDisplaySize() {
		return columnDisplaySize;
	}

	public void setColumnDisplayNumber(Integer columnDisplayNumber) {
		this.columnDisplayNumber = columnDisplayNumber;
	}

	public Integer getColumnDisplayNumber() {
		return columnDisplayNumber;
	}

	public void setShowOnGrid(String showOnGrid) {
		this.showOnGrid = showOnGrid;
	}

	public String getShowOnGrid() {
		return showOnGrid;
	}

	public void setColumnCodeToMapping(String columnCodeToMapping) {
		this.columnCodeToMapping = columnCodeToMapping;
	}

	public String getColumnCodeToMapping() {
		return columnCodeToMapping;
	}

}
