package com.abssoft.constructor.client.widgets;

import com.google.gwt.user.client.Window;
import com.smartgwt.client.widgets.RichTextEditor;
import com.smartgwt.client.widgets.events.KeyPressEvent;
import com.smartgwt.client.widgets.events.KeyPressHandler;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.events.ChangedEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangedHandler;

public class MyRichTextItem extends CanvasItem {
	RichTextEditor editor = new RichTextEditor();

	@Override
	public void setValue(String value) {
		editor.setValue(value);
	}

	public MyRichTextItem() {

		editor.addKeyPressHandler(new KeyPressHandler() {
			@Override
			public void onKeyPress(KeyPressEvent event) {
				Window.alert("2222");
			}
		});
		editor.setCanDragResize(true);
		editor.setShowEdges(true);
		editor.setWidth100();
		// editor.setHeight100();
		this.setCanvas(editor);
		this.setAttribute("vPolicy", "fill");
		this.setAttribute("hPolicy", "fill");
		//
		this.addChangedHandler(new ChangedHandler() {
			@Override
			public void onChanged(ChangedEvent event) {
				event.getForm();
				Window.alert("11111");
			}
		});
	}
}
