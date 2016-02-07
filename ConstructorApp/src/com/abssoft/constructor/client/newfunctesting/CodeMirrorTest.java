package com.abssoft.constructor.client.newfunctesting;

import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.widgets.cmirrorwidget.CodeMirrorItem;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.events.ResizedEvent;
import com.smartgwt.client.widgets.events.ResizedHandler;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.events.ChangedEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangedHandler;
import com.smartgwt.client.widgets.tab.Tab;

class CodeMirrorTest extends Tab {
	TextAreaItem tai = new TextAreaItem("test");
	CodeMirrorItem cmi = new CodeMirrorItem();
	DynamicForm f = new DynamicForm();

	CodeMirrorTest() {
		//		cmi.addChangedHandler(new ChangedHandler() {
		//			@Override
		//			public void onChanged(ChangedEvent event) {
		//				String value = event.getValue() + "";
		//				Utils.debug(">>>@1" + getClass() + ": " + value);
		//				tai.setValue(value);
		//			}
		//		});

		tai.setWidth("*");
		//tai.setTitleOrientation(TitleOrientation.TOP);
		//cmi.setTitleOrientation(TitleOrientation.TOP);
		cmi.setWidth("*");
		tai.addChangedHandler(new TAIChangedHandler());

		f.setTitleOrientation(TitleOrientation.TOP);
		f.setNumCols(1);
		f.setItems(tai, cmi);
		setPane(f);
		f.addResizedHandler(new FResizedHandler());

		String initText = "begin\n\tnull;\n end;\n";
		tai.setValue(initText);
		cmi.setValue(initText);
		f.addItemChangedHandler(new FormItemChangedHandler());

	}

	private final class FormItemChangedHandler implements ItemChangedHandler {
		@Override
		public void onItemChanged(ItemChangedEvent event) {
			// TODO Auto-generated method stub
			String value = event.getItem().getValue() + "";
			String itemName = event.getItem().getName();
			Utils.debug(">" + getClass() + "; itemName: " + itemName + "; value: " + value);
		}
	}

	private final class FResizedHandler implements ResizedHandler {
		@Override
		public void onResized(ResizedEvent event) {
			// TODO Auto-generated method stub
			Utils.debug(">>>" + this.getClass() + "...");
			cmi.editorResize();
		}
	}

	private final class TAIChangedHandler implements ChangedHandler {
		@Override
		public void onChanged(ChangedEvent event) {
			String value = tai.getValueAsString();
			Utils.debug(">>>@2" + getClass() + ": " + value);
			cmi.setValue("" + event.getValue());
		}
	}
}