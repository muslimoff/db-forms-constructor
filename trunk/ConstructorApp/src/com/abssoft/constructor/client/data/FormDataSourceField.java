package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormMD;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.widgets.tree.TreeGrid;

public class FormDataSourceField extends com.smartgwt.client.data.DataSourceField {
	private FormColumnMD columnMD;
	private String formType;
	private FormMD formMetadata;
	private int colNum;
	private boolean isTreeFolder = false;

	public FormDataSourceField(int colNum, MainFormPane mainFormContainer) {
		this.colNum = colNum;
		this.formMetadata = mainFormContainer.getFormMetadata();
		this.columnMD = formMetadata.getColumns().get(colNum);
		this.formType = formMetadata.getFormType();

		this.setColumnMD(columnMD);
		String colName = columnMD.getName();
		FieldType type = FieldType.TEXT;
		if // Tree
		("T".equals(formType)) {
			// TreeGrid treeGrid = ((TreeGrid) mainFormContainer.getMainForm().getTreeGrid());
			String treeFieldType = columnMD.getTreeFieldType();
			if ("1".equals(treeFieldType)) {
				this.setPrimaryKey(true);
			} else if ("2".equals(treeFieldType)) {
				this.setForeignKey("ID");
			} else if ("3".equals(treeFieldType)) {
				setTreeFolder(true);
				type = FieldType.BOOLEAN;
			} else if ("4".equals(treeFieldType) && null != mainFormContainer.getMainForm()) {
				((TreeGrid) mainFormContainer.getMainForm().getTreeGrid()).setCustomIconProperty(colName);
			}
		} else // Grid
		{
			// Определение типа редактирования
			if ("D-пока убрал".equals(columnMD.getDataType())) {
				type = FieldType.DATE;
			}
		}
		if ("B".equals(columnMD.getDataType())) {
			type = FieldType.BOOLEAN;
		}
		// if ("N".equals(columnMD.getDataType())) {
		// type = FieldType.FLOAT;
		// }
		this.setPrimaryKey(columnMD.isPrimaryKey());
		this.setName(colName);
		this.setTitle(columnMD.getDisplayName());
		this.setType(type);
		this.setRequired(false);
	}

	/**
	 * @return the colNum
	 */
	public int getColNum() {
		return colNum;
	}

	/**
	 * @return the columnMD
	 */
	public FormColumnMD getColumnMD() {
		return columnMD;
	}

	/**
	 * @return the formMetadata
	 */
	public FormMD getFormMetadata() {
		return formMetadata;
	}

	/**
	 * @return the formType
	 */
	public String getFormType() {
		return formType;
	}

	/**
	 * @param colNum
	 *            the colNum to set
	 */
	public void setColNum(int colNum) {
		this.colNum = colNum;
	}

	/**
	 * @param columnMD
	 *            the columnMD to set
	 */
	public void setColumnMD(FormColumnMD columnMD) {
		this.columnMD = columnMD;
	}

	/**
	 * @param formMetadata
	 *            the formMetadata to set
	 */
	public void setFormMetadata(FormMD formMetadata) {
		this.formMetadata = formMetadata;
	}

	/**
	 * @param formType
	 *            the formType to set
	 */
	public void setFormType(String formType) {
		this.formType = formType;
	}

	/**
	 * @param isTreeFolder
	 *            the isTreeFolder to set
	 */
	public void setTreeFolder(boolean isTreeFolder) {
		this.isTreeFolder = isTreeFolder;
	}

	/**
	 * @return the isTreeFolder
	 */
	public boolean isTreeFolder() {
		return isTreeFolder;
	}

}
