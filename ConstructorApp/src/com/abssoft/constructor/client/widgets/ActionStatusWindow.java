package com.abssoft.constructor.client.widgets;

import com.abssoft.constructor.client.data.Utils;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.types.HeaderControls;
import com.smartgwt.client.util.Page;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.HeaderControl;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.CloseClickHandler;
import com.smartgwt.client.widgets.events.CloseClientEvent;
import com.smartgwt.client.widgets.events.DrawEvent;
import com.smartgwt.client.widgets.events.DrawHandler;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemIfFunction;
import com.smartgwt.client.widgets.form.fields.BlurbItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;

public class ActionStatusWindow extends Window {
	class MyDynamicForm extends DynamicForm {
		MyDynamicForm(String title, String shortMsg, String longText) {
			int width = 400;
			String imgHTML = Canvas.imgHTML("[SKINIMG]Dialog/say.png");
			String msg = "<span>" + imgHTML + "&nbsp;" + shortMsg + "</span>";
			BlurbItem shortTextItem = new BlurbItem();
			shortTextItem.setWrap(true);
			shortTextItem.setValue(msg);
			shortTextItem.setWidth(width);

			TextAreaItem detailTextItem2 = new TextAreaItem();
			detailTextItem2.setShowTitle(false);
			detailTextItem2.setWidth(width);
			detailTextItem2.setHeight(200);
			detailTextItem2.setValue(longText);
			detailTextItem2.setShowIfCondition(new FormItemIfFunction() {
				@Override
				public boolean execute(FormItem item, Object value, DynamicForm form) {
					return detailsDisplayed;
				}
			});
			ToolbarItem toolbar = new ToolbarItem();
			toolbar.setAlign(Alignment.CENTER);
			final IButton b = new IButton("OK");
			b.setAlign(Alignment.CENTER);
			b.addClickHandler(new ClickHandler() {
				@Override
				public void onClick(ClickEvent event) {
					beforeClose();
				}
			});
			b.addDrawHandler(new DrawHandler() {
				public void onDraw(DrawEvent event) {
					b.focus();
				}
			});
			toolbar.setButtons(b);
			this.setMargin(10);
			this.setFields(shortTextItem, toolbar, detailTextItem2);
		}
	}

	public static int windowsCount = 0;

	public static ActionStatusWindow createActionStatusWindow(String title, String shortMsg, String longText) {
		Utils.debug(title + ": " + shortMsg);
		Utils.debug(longText);
		return new ActionStatusWindow(title, shortMsg, longText);
	}

	private boolean detailsDisplayed = false;

	private ActionStatusWindow(String title, String shortMsg, String longText) {

		int width = 360;
		int height = 150;

		// this.setWidth(width);
		// this.setHeight(height);

		int left = Page.getWidth() - width;
		int top = Page.getHeight() - height;
		left = Math.min(left / 2 + windowsCount * 20, left);
		top = Math.min(top / 2 + windowsCount * 20, top);

		this.setTitle(title);
		this.setShowMinimizeButton(false);
		this.setShowModalMask(true);
		this.setModalMaskOpacity(20);
		this.setIsModal(true);
		this.setCanDragResize(true);
		this.setShowResizer(true);
		this.setTop(top);
		this.setLeft(left);
		this.setAutoSize(true);
		// this.setOverflow(Overflow.)
		final MyDynamicForm f = new MyDynamicForm(title, shortMsg, longText);
		HeaderControl comment = new HeaderControl(HeaderControl.COMMENT, new ClickHandler() {
			@Override
			public void onClick(ClickEvent event) {
				detailsDisplayed = !detailsDisplayed;
				f.markForRedraw();
			}
		});
		this.setHeaderControls(HeaderControls.HEADER_LABEL, comment, HeaderControls.CLOSE_BUTTON);
		this.addItem(f);
		this.addCloseClickHandler(new CloseClickHandler() {
			@Override
			public void onCloseClick(CloseClientEvent event) {
				beforeClose();
			}
		});
		windowsCount++;
		// 
		this.show();
	}

	private void beforeClose() {
		windowsCount--;
		ActionStatusWindow.this.destroy();
	}
}
