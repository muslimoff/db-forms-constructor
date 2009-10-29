package com.abssoft.constructor.client.widgets;

import java.util.Iterator;
import java.util.Map;

import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FilterCriteriaFunction;
import com.smartgwt.client.widgets.grid.ListGridRecord;

public class GridComboBoxItem extends ComboBoxItem {
	private MainFormPane mainFormPane;

	public GridComboBoxItem(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
		this.setPickListFilterCriteriaFunction(new FilterCriteriaFunction() {
			public Criteria getCriteria() {
				ListGridRecord r = getMainFormPane().getMainForm().getTreeGrid().getSelectedRecord();
				Map<?, ?> ev = getMainFormPane().getMainForm().getTreeGrid().getEditValues(r);
				Iterator<?> it = ev.keySet().iterator();
				while (it.hasNext()) {
					String mapKey = (String) it.next();
					String value = (String) ev.get(mapKey);
					r.setAttribute(mapKey, value);
				}
				Criteria criteria = Utils.getCriteriaFromListGridRecord(r);
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
