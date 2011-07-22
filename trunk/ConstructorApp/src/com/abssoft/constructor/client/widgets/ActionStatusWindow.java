package com.abssoft.constructor.client.widgets;

import com.abssoft.constructor.client.data.DMLProcExecution;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.ActionStatus.StatusType;
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
		MyDynamicForm(String title, String shortMsg, String longText, final StatusType statusType, final DMLProcExecution dmlData,
				String... buttonNames) {
			int width = 400;

			String icon = "say";
			if (StatusType.ERROR.equals(statusType)) {
				icon = "error";
			} else if (StatusType.WARNING.equals(statusType)) {
				icon = "warn";
			}
			String imgHTML = Canvas.imgHTML("[SKINIMG]Dialog/" + icon + ".png");

			String msg = "<span>" + imgHTML + "&nbsp;" + "<b>" + shortMsg + "</b></span>";
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

			IButton[] buttons = new IButton[buttonNames.length];
			// Сбрасываем код нажатой кнопки
			// if (null != dmlData) {
			// dmlData.getMainFormPane().setWarnButtonIdx(null);
			// }
			for (int i = 0; i < buttonNames.length; i++) {
				final int btnIdx = i;
				final String btnName = buttonNames[btnIdx];
				final IButton b = new IButton(btnName);

				b.setAlign(Alignment.CENTER);
				b.addClickHandler(new ClickHandler() {
					@Override
					public void onClick(ClickEvent event) {
						System.out.println(">>>>>>>>>>btnIdx: " + btnIdx);
						if (StatusType.WARNING.equals(statusType)) {
							if (null != dmlData) {
								// Устанвливаем код нажатой кнопки
								dmlData.getMainFormPane().setWarnButtonIdx(btnIdx);
								// com.google.gwt.user.client.Window.alert("2button name: " + btnName + "-" + btnIdx + "; "
								// + dmlData.getMainFormPane().getWarnButtonIdx());
								dmlData.getMainFormPane().getButtonsToolBar().actionItemsMap.get(
										dmlData.getMainFormPane().getCurrentAction().getCode()).doActionWithConfirm();
							}

						}
						beforeClose();
					}
				});
				b.addDrawHandler(new DrawHandler() {
					public void onDraw(DrawEvent event) {
						b.focus();
					}
				});
				buttons[i] = b;
			}
			// toolbar.setButtons(b);
			toolbar.setButtons(buttons);
			this.setMargin(10);
			this.setFields(shortTextItem, toolbar, detailTextItem2);
		}
	}

	public static int windowsCount = 0;

	public static ActionStatusWindow createActionStatusWindow(String title, String shortMsg, String longText, StatusType statusType,
			DMLProcExecution dmlData, String... buttonNames) {
		Utils.debug(title + ": " + shortMsg);
		Utils.debug(longText);
		return new ActionStatusWindow(title, shortMsg, longText, statusType, dmlData, buttonNames);
	}

	public static ActionStatusWindow createActionStatusWindow(String title, String shortMsg, String longText, StatusType statusType,
			String... buttonNames) {
		return createActionStatusWindow(title, shortMsg, longText, statusType, null, buttonNames);
	}

	private boolean detailsDisplayed = false;

	private ActionStatusWindow(String title, String shortMsg, String longText, StatusType statusType, DMLProcExecution dmlData,
			String... buttonNames) {

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
		final MyDynamicForm f = new MyDynamicForm(title, shortMsg, longText, statusType, dmlData, buttonNames);
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
