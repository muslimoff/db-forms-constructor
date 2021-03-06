package com.abssoft.constructor.common.metadata;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Информация о поле формы - отображение вьюшки FORM_COLUMNS_V
 * 
 * @author User
 * 
 */
public class FormColumnMD implements IsSerializable, Cloneable {

	private String dataType;
	private String description;
	private String displayName;
	private String headerName;
	private int displayNum;
	private String displaySize;
	private String EditorTabCode;
	private String fieldType;
	private boolean isFrozen;
	private boolean isPrimaryKey;
	private String lookupCode;
	private String lookupFieldType;
	private String name;
	private boolean showHover;
	private String showOnGrid;
	private String treeFieldType;
	private String treeInitializationValue;
	private String hoverСolumnСode;
	private String editorHeight;
	private String helpText;
	private String textMask;
	private String validationRegexp;
	private String defaultOrderByNumber;
	private String defaultValue;
	private String editorTitleOrientation;
	private boolean editorEndRow;
	private String editorColsSpan;
	private String lookupDisplayValue;
	private String editorOnEnterKeyAction;
	private Integer lookupWidth;
	private Integer lookupHeight;

	private Map<String, String> lookupAttributes = new HashMap<String, String>();

	private ArrayList<ColumnAction> colActions = new ArrayList<ColumnAction>();

	private ArrayList<FormColumnLookupMappingMD> columnLookupMappingArr = new ArrayList<FormColumnLookupMappingMD>();

	public FormColumnMD() {
	}

	public FormColumnMD clone() {
		FormColumnMD clone = new FormColumnMD();

		clone.setDataType(this.dataType);
		clone.setDescription(this.description);
		clone.setDisplayName(this.displayName);
		clone.setHeaderName(this.headerName);
		clone.setDisplayNum(this.displayNum);
		clone.setDisplaySize(this.displaySize);
		clone.setEditorTabCode(this.EditorTabCode);
		clone.setFieldType(this.fieldType);
		clone.setFrozen(this.isFrozen);
		clone.setPrimaryKey(this.isPrimaryKey);
		clone.setLookupCode(this.lookupCode);
		clone.setLookupFieldType(this.lookupFieldType);
		clone.setName(this.name);
		clone.setShowHover(this.showHover);
		clone.setShowOnGrid(this.showOnGrid);
		clone.setTreeFieldType(this.treeFieldType);
		clone.setTreeInitializationValue(this.treeInitializationValue);
		clone.setHoverСolumnСode(this.hoverСolumnСode);
		clone.setEditorHeight(this.editorHeight);
		clone.setHelpText(this.helpText);
		clone.setTextMask(this.textMask);
		clone.setValidationRegexp(this.validationRegexp);
		clone.setDefaultOrderByNumber(this.defaultOrderByNumber);
		clone.setDefaultValue(this.defaultValue);
		clone.setEditorTitleOrientation(this.editorTitleOrientation);
		clone.setEditorEndRow(this.editorEndRow);
		clone.setEditorColsSpan(this.editorColsSpan);
		clone.setLookupDisplayValue(this.lookupDisplayValue);
		clone.setEditorOnEnterKeyAction(this.editorOnEnterKeyAction);
		clone.setLookupWidth(this.lookupWidth);
		clone.setLookupHeight(this.lookupHeight);
		// тут сфилонил - нужно и в тех методах писать клонирование. Или общий
		// метод...
		clone.setLookupAttributes(this.lookupAttributes);
		clone.setColActions(this.colActions);

		return clone;
	}

	/**
	 * @return the dataType
	 */
	public String getDataType() {
		return dataType;
	}

	public String getDefaultOrderByNumber() {
		return defaultOrderByNumber;
	}

	public String getDefaultValue() {
		return defaultValue;
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

	public String getEditorColsSpan() {
		return editorColsSpan;
	}

	/**
	 * @return the editorHeight
	 */
	public String getEditorHeight() {
		return editorHeight;
	}

	public String getEditorOnEnterKeyAction() {
		return editorOnEnterKeyAction;
	}

	/**
	 * @return the editorTabCode
	 */
	public String getEditorTabCode() {
		return EditorTabCode;
	}

	public String getEditorTitleOrientation() {
		return editorTitleOrientation;
	}

	/**
	 * @return the fieldType
	 */
	public String getFieldType() {
		return fieldType;
	}

	/**
	 * @return the helpText
	 */
	public String getHelpText() {
		return helpText;
	}

	/**
	 * @return the hoverСolumnСode
	 */
	public String getHoverСolumnСode() {
		return hoverСolumnСode;
	}

	public Map<String, String> getLookupAttributes() {
		return lookupAttributes;
	}

	/**
	 * @return the lookupCode
	 */
	public String getLookupCode() {
		return lookupCode;
	}

	public String getLookupDisplayValue() {
		return lookupDisplayValue;
	}

	/**
	 * @return the lookupFieldType
	 */
	public String getLookupFieldType() {
		return lookupFieldType;
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

	public String getTextMask() {
		return textMask;
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

	public String getValidationRegexp() {
		return validationRegexp;
	}

	public boolean isEditorEndRow() {
		return editorEndRow;
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

	public void setDefaultOrderByNumber(String defaultOrderByNumber) {
		this.defaultOrderByNumber = defaultOrderByNumber;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
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

	public void setEditorColsSpan(String editorColsSpan) {
		this.editorColsSpan = editorColsSpan;
	}

	public void setEditorEndRow(boolean editorEndRow) {
		this.editorEndRow = editorEndRow;
	}

	/**
	 * @param editorHeight
	 *            the editorHeight to set
	 */
	public void setEditorHeight(String editorHeight) {
		this.editorHeight = editorHeight;
	}

	public void setEditorOnEnterKeyAction(String editorOnEnterKeyAction) {
		this.editorOnEnterKeyAction = editorOnEnterKeyAction;
	}

	/**
	 * @param editorTabCode
	 *            the editorTabCode to set
	 */
	public void setEditorTabCode(String editorTabCode) {
		EditorTabCode = editorTabCode;
	}

	public void setEditorTitleOrientation(String editorTitleOrientation) {
		this.editorTitleOrientation = editorTitleOrientation;
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
	 * @param helpText
	 *            the helpText to set
	 */
	public void setHelpText(String helpText) {
		this.helpText = helpText;
	}

	/**
	 * @param hoverСolumnСode
	 *            the hoverСolumnСode to set
	 */
	public void setHoverСolumnСode(String hoverСolumnСode) {
		this.hoverСolumnСode = hoverСolumnСode;
	}

	public void setLookupAttributes(Map<String, String> lookupAttributes) {
		this.lookupAttributes = lookupAttributes;
	}

	/**
	 * @param lookupCode
	 *            the lookupCode to set
	 */
	public void setLookupCode(String lookupCode) {
		this.lookupCode = lookupCode;
	}

	public void setLookupDisplayValue(String lookupDisplayValue) {
		this.lookupDisplayValue = lookupDisplayValue;
	}

	/**
	 * @param lookupFieldType
	 *            the lookupFieldType to set
	 */
	public void setLookupFieldType(String lookupFieldType) {
		this.lookupFieldType = lookupFieldType;
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

	public void setTextMask(String textMask) {
		this.textMask = textMask;
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

	public void setValidationRegexp(String validationRegexp) {
		this.validationRegexp = validationRegexp;
	}

	public void setColActions(ArrayList<ColumnAction> colActions) {
		this.colActions = colActions;
	}

	public ArrayList<ColumnAction> getColActions() {
		return colActions;
	}

	public void setLookupWidth(Integer lookupWidth) {
		this.lookupWidth = lookupWidth;
	}

	public Integer getLookupWidth() {
		return lookupWidth;
	}

	public void setLookupHeight(Integer lookupHeight) {
		this.lookupHeight = lookupHeight;
	}

	public Integer getLookupHeight() {
		return lookupHeight;
	}

	public void setHeaderName(String headerName) {
		this.headerName = headerName;
	}

	public String getHeaderName() {
		return headerName;
	}

	public ArrayList<FormColumnLookupMappingMD> getColumnLookupMappingArr() {
		return columnLookupMappingArr;
	}

}
