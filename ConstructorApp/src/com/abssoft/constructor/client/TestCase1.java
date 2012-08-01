package com.abssoft.constructor.client;

import java.util.Date;

import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.DataSourceField;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.types.ListGridEditEvent;
import com.smartgwt.client.types.ListGridFieldType;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.fields.DateItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridField;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.grid.events.EditorExitEvent;
import com.smartgwt.client.widgets.grid.events.EditorExitHandler;

public class TestCase1 extends Canvas {
	// public interface BodyKeyPressHandler extends EventHandler {
	// void onBodyKeyPress(com.smartgwt.client.widgets.grid.events.BodyKeyPressEvent event);
	// }

	private class MyListGrid extends ListGrid {
//		@Override
//		public void onBrowserEvent(Event event) {
//			super.onBrowserEvent(event);
//			System.out.println("zzz1" + event);
//			switch (event.getTypeInt()) {
//			case Event.ONPASTE: {
//				System.out.println("zzz2" + Event.getCurrentEvent());
//				// do something here
//				break;
//			}
//			}
//		}
	}

	@SuppressWarnings("deprecation")
	public TestCase1() {
		final ListGrid countryGrid = new MyListGrid();
		// EventListener eventListener = new EventListener();
		// com.google.gwt.user.client.DOM.setEventListener(countryGrid.getElement(), EventListener).

		countryGrid.setWidth("100%");
		countryGrid.setHeight("100%");
		countryGrid.setShowAllRecords(true);
		countryGrid.setCanEdit(true);
		countryGrid.setEditEvent(ListGridEditEvent.DOUBLECLICK);
		countryGrid.setModalEditing(true);

		// addEventListener(countryGrid, "paste", EventListener listener, false);

		DataSourceField nameField = new DataSourceField("countryName", FieldType.TEXT, "Country");
		DataSourceField independenceField = new DataSourceField("independence", FieldType.DATE, "Nationhood");
		DateItem dateItem = new DateItem();
		dateItem.setInputFormat("DMY");
		dateItem.setMaskDateSeparator(".");
		dateItem.setUseTextField(true);
		independenceField.setEditorType(dateItem);
		DataSource ds = new DataSource();
		ds.setFields(nameField, independenceField);

		CountryRecord[] r = new CountryRecord[] { new CountryRecord("xx", new Date(1776 - 1900, 6, 4)),
				new CountryRecord("yy", new Date(1947 - 1900, 7, 15)) };

		ListGridField nameFieldG = new ListGridField("countryName", "CountryG", 100);
		ListGridField independenceFieldG = new ListGridField("independence", "NationhoodG", 110);

		countryGrid.setDataSource(ds);
		countryGrid.setFields(nameFieldG, independenceFieldG);

		countryGrid.setData(r);
		countryGrid.addEditorExitHandler(new EditorExitHandler() {

			@Override
			public void onEditorExit(EditorExitEvent event) {
				System.out.println("d@@@@@@@@@event.getClass():" + event.getClass());
				System.out.println("d@@@@@@@@@ getNewValue:" + event.getNewValue());
				// System.out.println("d@@@@@@@@@ getNewValue" + event.getValue());
				int rowNum = event.getRowNum();
				int colNum = event.getColNum();
				String[] attributes = event.getRecord().getAttributes();
				for (int i = 0; i < attributes.length; i++) {
					System.out.println("xxxxxxxxx>>" + i + "=" + attributes[i] + "; " + event.getRecord().getAttribute(attributes[i]));
				}
				System.out.println("d@@@@@@@@@ attributes:" + attributes);
				String colName = attributes[colNum + 1];
				System.out.println("d@@@@@@@@@ colName:" + colName);
				System.out.println("d@@@@@@@@@ colVal:" + event.getRecord().getAttribute(colName));
				System.out.println("d@@@@@@@@@ event.getSource:" + event.getSource());
				ListGridFieldType fieldType = countryGrid.getField(colNum).getType();
				System.out.println("d@@@@@@@@@ fieldType:" + fieldType);
				if ("date".equals(fieldType.getValue())) {
					System.out.println("d@@@@@@@@@ colValDT:" + event.getRecord().getAttributeAsDate(colName));
				}
				System.out.println("d@@@@@@@@@ rowNum:" + rowNum);
				System.out.println("d@@@@@@@@@>>>" + countryGrid.getEditValue(rowNum, colNum));

			}
		});
		this.addChild(countryGrid);
	}

	private class CountryRecord extends ListGridRecord {
		CountryRecord(String txt, Date dt) {
			this.setAttribute("countryName", txt);
			this.setAttribute("independence", dt);
		}
	}
}
