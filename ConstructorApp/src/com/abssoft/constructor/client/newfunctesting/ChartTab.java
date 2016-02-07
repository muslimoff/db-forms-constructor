package com.abssoft.constructor.client.newfunctesting;

import com.google.gwt.user.client.ui.HTML;
import com.google.gwt.user.client.ui.HasHorizontalAlignment;
import com.rednels.ofcgwt.client.ChartWidget;
import com.rednels.ofcgwt.client.model.ChartData;
import com.rednels.ofcgwt.client.model.axis.XAxis;
import com.rednels.ofcgwt.client.model.axis.YAxis;
import com.rednels.ofcgwt.client.model.elements.BarChart;
import com.rednels.ofcgwt.client.model.elements.BarChart.BarStyle;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.tab.Tab;

class ChartTab extends Tab {
	public ChartTab() {
		ChartWidget chart1 = new ChartWidget();
		ChartData cd1 = new ChartData("Sales by Month 2006", "font-size: 14px; font-family: Verdana; text-align: center;");
		cd1.setBackgroundColour("#ffffff");
		XAxis xa = new XAxis();
		xa.setLabels("J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D");
		xa.setMax(12);
		cd1.setXAxis(xa);
		YAxis ya = new YAxis();
		ya.setSteps(16);
		ya.setMax(160);
		cd1.setYAxis(ya);
		BarChart bchart1 = new BarChart(BarStyle.GLASS);
		bchart1.setTooltip("$#val#");
		bchart1.addValues(133, 123, 144, 122, 155, 123, 135, 153, 123, 122, 111, 100);
		cd1.addElements(bchart1);
		chart1.setSize("100%", "100%");
		chart1.setChartData(cd1);
		HTML label1 = new HTML("<u>Normal Bar Chart</u>");
		label1.setWidth("100%");
		label1.setHorizontalAlignment(HasHorizontalAlignment.ALIGN_CENTER);
		Canvas c = new Canvas();
		c.addChild(chart1);
		String imgHTML = Canvas.imgHTML("[ISOMORPHIC]/resources/icons/database_connect.png");
		String title = "ChartTab";
		String formTitle = "<span>" + imgHTML + "&nbsp;" + title + "</span>";
		this.setTitle(formTitle);
		this.setPane(c);
	}
}