package com.abssoft.constructor.client.data;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.smartgwt.client.types.ListGridFieldType;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.grid.CellFormatter;
import com.smartgwt.client.widgets.grid.HoverCustomizer;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.ChangedEvent;
import com.smartgwt.client.widgets.grid.events.ChangedHandler;
import com.smartgwt.client.widgets.tree.TreeGridField;

public class FormTreeGridField extends TreeGridField {
	private MainFormPane mainFormPane;
	private int colNum;
	private FormColumnMD columnMD;
	private GridComboBoxItem gridComboBoxItem;

	class GridFieldChangedHandler implements ChangedHandler {
		String colName;

		GridFieldChangedHandler(String colName) {
			this.colName = colName;
		}

		@Override
		public void onChanged(ChangedEvent event) {
			if ("boolean".equals(event.getItem().getType())) {
				getMainFormPane().getValuesManager().setValue(colName, "true".equals(event.getValue() + ""));
			} else {
				getMainFormPane().getValuesManager().setValue(colName, event.getValue() + "");
			}
		}

	}

	public FormTreeGridField(MainFormPane mainFormPane, int colNum, final FormColumnMD c) {
		final String colName = c.getName();
		String lookupCode = c.getLookupCode();
		this.setMainFormPane(mainFormPane);
		this.setColNum(colNum);
		this.setColumnMD(c);
		this.setName(colName);
		this.setTitle(c.getDisplayName());
		this.setWidth(c.getDisplaySize());
		this.setFrozen(c.isFrozen());
		this.setShowHover(c.isShowHover());
		if (null != c.getHoverСolumnСode()) {
			this.setHoverCustomizer(new HoverCustomizer() {

				@Override
				public String hoverHTML(Object value, ListGridRecord record, int rowNum, int colNum) {
					String hover = null != record ? record.getAttribute(c.getHoverСolumnСode()) : null;
					return hover;
				}
			});
		}
		this.setPrompt(c.getDescription());
		if (!"Y".equals(c.getShowOnGrid())) {
			this.setHidden(true);
			this.setCanHide(ConstructorApp.debugEnabled); // Чтобы включить нельзя было
		}

		// При редактировании грида изменять и значения в редакторе
		this.addChangedHandler(new GridFieldChangedHandler(colName));

		if ("N".equals(c.getDataType())) {
			this.setType(ListGridFieldType.FLOAT);

		}
		if ("D".equals(c.getDataType())) {
			this.setType(ListGridFieldType.DATE);
			// this.setDateFormatter(DateDisplayFormat.TOEUROPEANSHORTDATE);
		}

		if ("3".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.IMAGE);
		} else if ("4".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.TEXT);
			this.setEditorType(new TextAreaItem());

		}
		// StaticLookup
		// TODO вывести одинаковый код
		else if (("8".equals(c.getFieldType()) || "10".equals(c.getFieldType())) && null != lookupCode
				&& ConstructorApp.staticLookupsArr.containsKey(lookupCode)) {
			ComboBoxItem s = new ComboBoxItem();
			final LinkedHashMap<String, String> lhm = Utils.createStrSortedLinkedHashMap(ConstructorApp.staticLookupsArr.get(lookupCode),
					!"8".equals(c.getFieldType()));
			s.setValueMap(lhm);
			// s.setPickListFields(pickListFields);
			this.setCellFormatter(new CellFormatter() {
				@Override
				public String format(Object value, ListGridRecord record, int rowNum, int colNum) {
					String result;
					try {
						result = lhm.get(value);
					} catch (Exception e) {
						result = e.toString();
					}
					return result;
				}
			});
			this.setEditorType(s);
		}
		// SQL Lookup
		else if ("Y".equals(c.getShowOnGrid()) && null != lookupCode && ("9".equals(c.getFieldType()))) {
			new GridComboBoxItem(c, mainFormPane, this);
		}

	}

	/**
	 * @return the colNum
	 */
	public int getColNum() {
		return colNum;
	}

	/**
	 * @return the column
	 */
	public FormColumnMD getColumnMD() {
		return columnMD;
	}

	/**
	 * @return the mainFormPane
	 */
	public MainFormPane getMainFormPane() {
		return mainFormPane;
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
	 *            the column to set
	 */
	public void setColumnMD(FormColumnMD columnMD) {
		this.columnMD = columnMD;
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}

	public void setGridComboBoxItem(GridComboBoxItem gridComboBoxItem) {
		this.gridComboBoxItem = gridComboBoxItem;
	}

	public GridComboBoxItem getGridComboBoxItem() {
		return gridComboBoxItem;
	}
}
