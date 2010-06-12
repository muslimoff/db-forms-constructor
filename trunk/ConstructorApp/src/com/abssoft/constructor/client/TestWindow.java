package com.abssoft.constructor.client;

import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
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
		IButton b = new IButton("xxx");
		b.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(ClickEvent event) {
				/********** ServerSide ***********/
				// http://forums.smartclient.com/showthread.php?t=3314&highlight=download+file
				// //if returning an image
				// response.setContentType("image/jpeg");
				// OutputStream out = response.getOutputStream();
				// byte[] image = readImageData(....)
				// out.write(image);
				// out.flush();
				// out.close();
				// //if returning csv-data
				// response.setContentType("text/csv");
				// response.setHeader("Content-Disposition", "attachment; filename=\"example-data.csv\"");
				// OutputStream out = response.getOutputStream();
				// byte[] data = readCsvData(....);
				// out.write(data);
				// out.flush();
				// out.close();

				// com.google.gwt.core.client.GWT.getModuleBaseURL() + "constructorapp.xml",
				com.google.gwt.user.client.Window.open(com.google.gwt.core.client.GWT.getHostPageBaseURL() + "resources/loading.gif",
						"loading.gif", "menubar=no,location=no,resizable=no,scrollbars=no,status=no,width=150,height=150,navigation=no");

			}
		});

		this.addItem(b);
		this.addItem(vLayout);
		this.show();

	}

}
