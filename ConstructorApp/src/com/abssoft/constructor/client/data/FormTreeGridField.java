package com.abssoft.constructor.client.data;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.smartgwt.client.types.ListGridFieldType;
import com.smartgwt.client.widgets.form.fields.SelectItem;
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
	private FormColumnMD column;

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
		this.setMainFormPane(mainFormPane);
		this.setColNum(colNum);
		this.setColumn(c);
		this.setName(colName);
		this.setTitle(c.getDisplayName());
		this.setWidth(c.getDisplaySize());
		String lookupCode = c.getLookupCode();
		if ("3".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.IMAGE);
		} else if ("4".equals(c.getFieldType())) {
			this.setType(ListGridFieldType.TEXT);
			this.setEditorType(new TextAreaItem());

		} else if (null != lookupCode) {
			SelectItem s = new SelectItem();
			// StaticLookup
			if (ConstructorApp.staticLookupsArr.containsKey(lookupCode)) {
				final LinkedHashMap<String, String> lhm = new LinkedHashMap<String, String>();
				lhm.putAll(ConstructorApp.staticLookupsArr.get(lookupCode));
				// boolean nullsAllowed = true;
				// if (nullsAllowed && !lhm.containsKey(null)) {
				// lhm.put(null, "");
				// }
				s.setValueMap(lhm);
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
			}
			// SQL Lookup
			else {
				ReadOnlyDataSource ds = new ReadOnlyDataSource(lookupCode);
				s.setOptionDataSource(ds);
			}
			this.setEditorType(s);
		}
		this.setFrozen(c.isFrozen());
		this.setShowHover(c.isShowHover());
		if (null != c.getHoverСolumnСode()) {
			this.setHoverCustomizer(new HoverCustomizer() {

				@Override
				public String hoverHTML(Object value, ListGridRecord record, int rowNum, int colNum) {
					String hover = record.getAttribute(c.getHoverСolumnСode());
					return hover;
				}
			});
		}
		this.setPrompt(c.getDescription());
		if (!"Y".equals(c.getShowOnGrid())) {
			this.setHidden(true);
			this.setCanHide(false); // Чтобы включить нельзя было
		}

		// При редактировании грида изменять и значения в редакторе
		this.addChangedHandler(new GridFieldChangedHandler(colName));
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
	public FormColumnMD getColumn() {
		return column;
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
	 * @param column
	 *            the column to set
	 */
	public void setColumn(FormColumnMD column) {
		this.column = column;
	}

	/**
	 * @param mainFormPane
	 *            the mainFormPane to set
	 */
	public void setMainFormPane(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}
}
