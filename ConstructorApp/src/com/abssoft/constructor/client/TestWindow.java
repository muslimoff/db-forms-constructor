package com.abssoft.constructor.client;

import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.layout.HLayout;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.TabSet;

public class TestWindow extends Window {
	class StatTab extends Tab {
		StatTab(String title) {
			final RichTextItem richTextItem = new RichTextItem();
			richTextItem.setTitleOrientation(TitleOrientation.TOP);

			final CanvasItem canvasItem = new CanvasItem();
			canvasItem.setTitleOrientation(TitleOrientation.TOP);
			canvasItem.setCanvas(new Canvas());
			canvasItem.getCanvas().setBorder("2px solid green");
			canvasItem.setColSpan("*");
			canvasItem.setEndRow(true);
			canvasItem.setName("canvasItem");
			final DynamicForm form = new DynamicForm();
			form.setItems(richTextItem, canvasItem);
			form.setBorder("2px dotted red");
			form.setCellBorder(1);
			form.addItemChangedHandler(new ItemChangedHandler() {
				@Override
				public void onItemChanged(ItemChangedEvent event) {
					if (richTextItem.equals(event.getItem())) {
						canvasItem.getCanvas().setContents(richTextItem.getValue().toString());
					}
				}
			});
			this.setPane(form);
			this.setTitle(title);
		}
	}

	public TestWindow() {
		this.setWidth(600);
		this.setHeight(400);
		this.setTitle("Connect");
		this.setShowMinimizeButton(false);
		this.setIsModal(true);
		this.centerInPage();
		Canvas canvas = new Canvas();
		canvas.setContents("aa");
		canvas.setWidth("10%");
		TabSet tabSet = new TabSet();
		tabSet.setWidth100();
		tabSet.addTab(new StatTab("Static"));
		HLayout vLayout = new HLayout();
		vLayout.addMember(canvas);
		vLayout.addMember(tabSet);
		this.addItem(vLayout);
		this.show();

	}

}
