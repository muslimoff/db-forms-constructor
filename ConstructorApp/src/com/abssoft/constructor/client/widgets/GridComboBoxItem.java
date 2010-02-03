package com.abssoft.constructor.client.widgets;

import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FilterCriteriaFunction;

public class GridComboBoxItem extends ComboBoxItem {
	private MainFormPane mainFormPane;

	public GridComboBoxItem(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		this.setPickListFilterCriteriaFunction(new FilterCriteriaFunction() {
			public Criteria getCriteria() {
				Record record = Utils.getEditedRow(getMainFormPane());
				Criteria criteria = Utils.getCriteriaFromListGridRecord(record, "GridComboBoxItem:" + GridComboBoxItem.this.getName());
				return criteria;
			}
		});
		this.setShowOptionsFromDataSource(true);
		this.setFetchMissingValues(true);
	}

	private FormTreeGridField formTreeGridField;

	/**
	 * @param formTreeGridField
	 *            the formTreeGridField to set
	 */
	public void setFormTreeGridField(FormTreeGridField formTreeGridField) {
		this.formTreeGridField = formTreeGridField;
	}

	/**
	 * @return the formTreeGridField
	 */
	public FormTreeGridField getFormTreeGridField() {
		return formTreeGridField;
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}

	/**
	 * @return the mainFormPane
	 */
	public MainFormPane getMainFormPane() {
		return mainFormPane;
	}

}
