package com.abssoft.constructor.client.newfunctesting;

import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.ViewFileItem;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;
import com.smartgwt.client.widgets.tab.Tab;

class RichTextItemIssueTab extends Tab {
	public RichTextItem richTextItem = new RichTextItem();

	RichTextItemIssueTab() {
		richTextItem.setTitleOrientation(TitleOrientation.TOP);
		richTextItem.setValue("http://vm_xe:8080/public/reports/file2.rtf");
		final CanvasItem canvasItem = new CanvasItem();
		canvasItem.setTitleOrientation(TitleOrientation.TOP);
		canvasItem.setCanvas(new Canvas());
		canvasItem.getCanvas().setBorder("2px solid green");
		canvasItem.setColSpan("*");
		canvasItem.setEndRow(true);
		canvasItem.setName("canvasItem");
		ViewFileItem vfi = new ViewFileItem();
		vfi.setTitle("ccccccccc");
		final DynamicForm form = new DynamicForm();
		form.setItems(richTextItem, canvasItem, vfi);
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
		this.setTitle("Static");

		// Для проверки функциональности контекстного меню в классе TabSet
		Menu ctxMenu = new Menu();
		MenuItem m1 = new MenuItem("sss-" + this.getTitle());
		MenuItem m2 = new MenuItemSeparator();
		ctxMenu.setData(m1, m2);
		this.setContextMenu(ctxMenu);
	}
}