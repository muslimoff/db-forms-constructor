package com.abssoft.constructor.client.newfunctesting;

import com.rednels.ofcgwt.client.ChartWidget;
import com.rednels.ofcgwt.client.model.ChartData;
import com.rednels.ofcgwt.client.model.axis.RadarAxis;
import com.rednels.ofcgwt.client.model.elements.AreaChart;
import com.rednels.ofcgwt.client.model.elements.LineChart.LineStyle;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.tab.Tab;

class RadarChartTab extends Tab {
	public RadarChartTab() {
		ChartWidget chart = new ChartWidget();
		chart.setTitle("Radar Chart");
		AreaChart area = new AreaChart();
		area.setWidth(5);
		area.setLineStyle(new LineStyle(10, 10));
		area.addValues(3, 4, 5, 4, 3, 3, 2.5);
		area.setFillAlpha(0.1f);
		ChartData cd = new ChartData();

		RadarAxis r = new RadarAxis();
		r.setLabels("a1", "a2", "a3", "a4", "a5");
		r.setRange(0, 5, 1);
		cd.setRadarAxis(r);
		area.setLoop(true);
		cd.addElements(area);
		chart.setChartData(cd);
		// //
		chart.setSize("100%", "100%");
		Canvas c = new Canvas();
		c.addChild(chart);
		this.setTitle("RadarChartTab");
		this.setPane(c);
	}
}