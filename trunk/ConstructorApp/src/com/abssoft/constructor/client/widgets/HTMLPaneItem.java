package com.abssoft.constructor.client.widgets;

import com.smartgwt.client.types.ContentsType;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.HTMLPane;
import com.smartgwt.client.widgets.form.fields.CanvasItem;

public class HTMLPaneItem extends CanvasItem {
	private HTMLPane htmlPane = new HTMLPane();

	public void setValue(String value) {
		htmlPane.setContentsURL(value);
	}

	public HTMLPaneItem() {
		htmlPane.setContentsType(ContentsType.PAGE);
		htmlPane.setContentsURL("http://www.google.com");
		htmlPane.setBorder("2px dotted green");
		this.setCanvas(htmlPane);
		this.setTitleOrientation(TitleOrientation.TOP);
		this.setColSpan("*");
		this.setShowTitle(false);
	}
}
