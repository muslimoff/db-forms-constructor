package com.abssoft.constructor.client.form;

import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.FormTabMD;

public class FormColumns {
	int columnsCount;
	FormColumnsArr columns;
	FormMD formMetadata;
	FormTreeGridField[] gridFields;
	FormDataSourceField[] dataSourceFields;
	MainFormPane mainFormPane;
	boolean hasBottomTabsCount = false;
	boolean hasSideTabsCount = false;

	public FormColumns(MainFormPane mainFormPane) {
		this.formMetadata = mainFormPane.getFormMetadata();
		this.columns = formMetadata.getColumns();
		this.mainFormPane = mainFormPane;
		this.columnsCount = columns.size();
		this.gridFields = new FormTreeGridField[columnsCount];
		this.dataSourceFields = new FormDataSourceField[columnsCount];

		for (FormTabMD e : formMetadata.getTabs()) {
			if (e.getTabPosition().equals("B"))
				hasBottomTabsCount = true;
			else
				hasSideTabsCount = true;
		}
		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD m = columns.get(i);
			// По умолчанию, если getFieldType=1 или =2, и табик не указан,
			// значит боковой динамический детейл
			if (("1".equals(m.getFieldType()) || "2".equals(m.getFieldType())) && null == m.getEditorTabCode())
				hasSideTabsCount = true;
		}

		Utils.debug("bottomTabsCount: " + hasBottomTabsCount + "; sideTabsCount: " + hasSideTabsCount);
	}

	public FormDataSourceField[] getDSFields() {
		for (int i = 0; i < columnsCount; i++) {
			dataSourceFields[i] = new FormDataSourceField(i, mainFormPane);
		}
		return dataSourceFields;
	}

	public FormTreeGridField[] getGridFields() {
		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD m = columns.get(i);
			gridFields[i] = new FormTreeGridField(mainFormPane, i, m);
			gridFields[i].setPrompt(m.getDescription());
		}
		return gridFields;
	}
}
