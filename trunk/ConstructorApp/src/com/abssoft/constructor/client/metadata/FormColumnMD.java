package com.abssoft.constructor.client.metadata;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Информация о поле формы - отображение вьюшки FORM_COLUMNS_V
 * 
 * @author User
 * 
 */
public class FormColumnMD implements IsSerializable {
	private String dataType;
	private String description;
	private String displayName;
	private int displayNum;
	private String displaySize;
	private String EditorTabCode;
	private String fieldType;
	private boolean isFrozen;
	private boolean isPrimaryKey;
	private String lookupCode;
	private String name;
	private boolean showHover;
	private String showOnGrid;
	private String treeFieldType;
	private String treeInitializationValue;
	private String hoverСolumnСode;
	private String editorHeight;

	public FormColumnMD() {
	}

	/**
	 * @return the dataType
	 */
	public String getDataType() {
		return dataType;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @return the displayName
	 */
	public String getDisplayName() {
		return displayName;
	}

	/**
	 * @return the displayNum
	 */
	public int getDisplayNum() {
		return displayNum;
	}

	/**
	 * @return the displaySize
	 */
	public String getDisplaySize() {
		return displaySize;
	}

	/**
	 * @return the editorTabCode
	 */
	public String getEditorTabCode() {
		return EditorTabCode;
	}

	/**
	 * @return the fieldType
	 */
	public String getFieldType() {
		return fieldType;
	}

	/**
	 * @return the lookupCode
	 */
	public String getLookupCode() {
		return lookupCode;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the showOnGrid
	 */
	public String getShowOnGrid() {
		return showOnGrid;
	}

	/**
	 * @return the treeFieldType
	 */
	public String getTreeFieldType() {
		return treeFieldType;
	}

	/**
	 * @return the treeInitializationValue
	 */
	public String getTreeInitializationValue() {
		return treeInitializationValue;
	}

	/**
	 * @return the isFrozen
	 */
	public boolean isFrozen() {
		return isFrozen;
	}

	/**
	 * @return the isPrimaryKey
	 */
	public boolean isPrimaryKey() {
		return isPrimaryKey;
	}

	/**
	 * @return the showHover
	 */
	public boolean isShowHover() {
		return showHover;
	}

	/**
	 * @param dataType
	 *            the dataType to set
	 */
	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @param displayName
	 *            the displayName to set
	 */
	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	/**
	 * @param displayNum
	 *            the displayNum to set
	 */
	public void setDisplayNum(int displayNum) {
		this.displayNum = displayNum;
	}

	/**
	 * @param displaySize
	 *            the displaySize to set
	 */
	public void setDisplaySize(String displaySize) {
		this.displaySize = displaySize;
	}

	/**
	 * @param editorTabCode
	 *            the editorTabCode to set
	 */
	public void setEditorTabCode(String editorTabCode) {
		EditorTabCode = editorTabCode;
	}

	/**
	 * @param fieldType
	 *            the fieldType to set
	 */
	public void setFieldType(String fieldType) {
		this.fieldType = fieldType;
	}

	/**
	 * @param isFrozen
	 *            the isFrozen to set
	 */
	public void setFrozen(boolean isFrozen) {
		this.isFrozen = isFrozen;
	}

	/**
	 * @param lookupCode
	 *            the lookupCode to set
	 */
	public void setLookupCode(String lookupCode) {
		this.lookupCode = lookupCode;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @param isPrimaryKey
	 *            the isPrimaryKey to set
	 */
	public void setPrimaryKey(boolean isPrimaryKey) {
		this.isPrimaryKey = isPrimaryKey;
	}

	/**
	 * @param showHover
	 *            the showHover to set
	 */
	public void setShowHover(boolean showHover) {
		this.showHover = showHover;
	}

	/**
	 * @param showOnGrid
	 *            the showOnGrid to set
	 */
	public void setShowOnGrid(String showOnGrid) {
		this.showOnGrid = showOnGrid;
	}

	/**
	 * @param treeFieldType
	 *            the treeFieldType to set
	 */
	public void setTreeFieldType(String treeFieldType) {
		this.treeFieldType = treeFieldType;
	}

	/**
	 * @param treeInitializationValue
	 *            the treeInitializationValue to set
	 */
	public void setTreeInitializationValue(String treeInitializationValue) {
		this.treeInitializationValue = treeInitializationValue;
	}

	/**
	 * @param hoverСolumnСode
	 *            the hoverСolumnСode to set
	 */
	public void setHoverСolumnСode(String hoverСolumnСode) {
		this.hoverСolumnСode = hoverСolumnСode;
	}

	/**
	 * @return the hoverСolumnСode
	 */
	public String getHoverСolumnСode() {
		return hoverСolumnСode;
	}

	/**
	 * @param editorHeight
	 *            the editorHeight to set
	 */
	public void setEditorHeight(String editorHeight) {
		this.editorHeight = editorHeight;
	}

	/**
	 * @return the editorHeight
	 */
	public String getEditorHeight() {
		return editorHeight;
	}
}
