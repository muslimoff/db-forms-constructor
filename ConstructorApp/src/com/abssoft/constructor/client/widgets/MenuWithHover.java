package com.abssoft.constructor.client.widgets;

import com.abssoft.constructor.client.app.MenusDataCallback.FormMenuItem;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.menu.Menu;

public class MenuWithHover extends Menu {

	public interface CellHoverCustomizer {
		String cellHoverHTML(ListGridRecord record, int rowNum, int colNum);

	}

	/**
	 * * HTML to be shown in hovers over cells in the column described by this field.
	 * 
	 * @param hoverCustomizer
	 *            the hover customizer
	 */
	public native void setCellHoverCustomizer(CellHoverCustomizer cellHoverCustomizer)
	/*-{
	var self = this.@com.abssoft.constructor.client.widgets.MenuWithHover::getJsObj()();
	   self.cellHoverHTML = function(record, rowNum, colNum) {
	     var recordJ = @com.smartgwt.client.widgets.grid.ListGridRecord::getOrCreateRef(Lcom/google/gwt/core/client/JavaScriptObject;)(record);
	     return cellHoverCustomizer.@com.abssoft.constructor.client.widgets.MenuWithHover.CellHoverCustomizer::cellHoverHTML(Lcom/smartgwt/client/widgets/grid/ListGridRecord;II)(recordJ, rowNum, colNum);
	   };
	}-*/;

	public void setHover() {
		this.setCanHover(true);
		this.setShowHover(true);
		this.setHoverWidth(300);
		this.setCellHoverCustomizer(new MenuWithHover.CellHoverCustomizer() {

			@Override
			public String cellHoverHTML(ListGridRecord record, int rowNum, int colNum) {
				String hover = null;
				if (record instanceof FormMenuItem) {
					hover = ((FormMenuItem) record).getFormMetadata().getDescription();
				}
				return hover;
			}
		});
	}
}
