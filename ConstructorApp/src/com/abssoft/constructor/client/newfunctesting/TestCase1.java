package com.abssoft.constructor.client.newfunctesting;

import java.util.Date;

import com.abssoft.constructor.client.data.Utils;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.data.DataSourceField;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.types.ListGridEditEvent;
import com.smartgwt.client.types.ListGridFieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.RightMouseDownEvent;
import com.smartgwt.client.widgets.events.RightMouseDownHandler;
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
		// @Override
		// public void onBrowserEvent(Event event) {
		// super.onBrowserEvent(event);
		// System.out.println("zzz1" + event);
		// switch (event.getTypeInt()) {
		// case Event.ONPASTE: {
		// System.out.println("zzz2" + Event.getCurrentEvent());
		// // do something here
		// break;
		// }
		// }
		// }

		public native Boolean startEditing(int rowNum)
		// / * - {
		// var self = this.@com.smartgwt.client.widgets.BaseWidget::getOrCreateJsObj()();
		// var retVal =self.startEditing(rowNum);
		// if(retVal == null || retVal === undefined) {
		// return null;
		// } else {
		// return @com.smartgwt.client.util.JSOHelper::toBoolean(Z)(retVal);
		// }
		//
		// } - * / ;
		/*-{
			var self = this.@com.smartgwt.client.widgets.BaseWidget::getOrCreateJsObj()();
			var retVal =self.startEditing(rowNum);
			if(retVal == null || retVal === undefined) {
			    return null;
			} else {
			    return @com.smartgwt.client.util.JSOHelper::toBoolean(Z)(retVal);
			}
		}-*/;
	}

	@SuppressWarnings("deprecation")
	public TestCase1() {
		final MyListGrid countryGrid = new MyListGrid();

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

		CountryRecord[] r = new CountryRecord[5];
		for (int i = 0; i < 5; i++) {
			r[i] = new CountryRecord("xx" + i, new Date(1776 + i - 1900, 6, 4));
		}

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
				// 20121004-3.1d tests. System.out.println("d@@@@@@@@@>>>" + countryGrid.getEditValue(rowNum, colNum));
				System.out.println("d@@@@@@@@@>>>" + countryGrid.getEditValue(rowNum, colName));

			}
		});

		countryGrid.addRightMouseDownHandler(new RightMouseDownHandler() {

			@Override
			public void onRightMouseDown(RightMouseDownEvent event) {
				ListGridRecord selRec = countryGrid.getSelectedRecord();
				ListGridRecord newRec = new ListGridRecord();
				JSOHelper.apply(selRec.getJsObj(), newRec.getJsObj());
				newRec.setAttribute("countryName", selRec.getAttribute("countryName") + "*");
				// this.setAttribute("countryName", txt);
				int idx = countryGrid.getRecordIndex(selRec);
				Utils.debug("ZZZ! " + idx);
				countryGrid.getRecordList().addAt(newRec, idx);
				countryGrid.startEditing(idx);
			}
		});
		this.addChild(countryGrid);
		// ToolStrip toolstrip = new ToolStrip();
		// HLayout mainLayout = new HLayout();
		// mainLayout.setCanDragResize(true);
		//
		// this.addChild(mainLayout);
		// mainLayout.addChild(toolstrip);
		// mainLayout.addChild(countryGrid);

		// SectionStack sectionStack = new SectionStack();
		// sectionStack.setVisibilityMode(VisibilityMode.MULTIPLE);
		//
		// SectionStackSection section1 = new SectionStackSection("1");
		// SectionStackSection section2 = new SectionStackSection("2");
		// section1.setExpanded(true);
		// section2.setExpanded(true);
		// HLayout l = new HLayout();
		// l.setCanDragResize(true);
		// l.addChild(sectionStack);
		//
		// this.addChild(l);
		// sectionStack.setHeight100();
		// sectionStack.setWidth100();
		//
		// ToolStrip toolstrip = new ToolStrip();
		// sectionStack.addSection(section1, 0);
		// sectionStack.addSection(section2, 1);
		// section1.setItems(toolstrip);
		// section2.setItems(countryGrid);

		// HLayout l = new HLayout();
		// ToolStrip toolstrip = new ToolStrip();
		// l.addChild(toolstrip);
		// l.addChild(countryGrid);
		// this.addChild(l);
	}

	private class CountryRecord extends ListGridRecord {
		CountryRecord(String txt, Date dt) {
			this.setAttribute("countryName", txt);
			this.setAttribute("independence", dt);
		}
	}
}
