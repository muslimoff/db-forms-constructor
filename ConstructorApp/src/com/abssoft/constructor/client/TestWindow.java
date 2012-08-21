package com.abssoft.constructor.client;

import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.abssoft.constructor.common.ActionStatus.StatusType;
import com.google.gwt.user.client.ui.HTML;
import com.google.gwt.user.client.ui.HasHorizontalAlignment;
import com.rednels.ofcgwt.client.ChartWidget;
import com.rednels.ofcgwt.client.model.ChartData;
import com.rednels.ofcgwt.client.model.axis.RadarAxis;
import com.rednels.ofcgwt.client.model.axis.XAxis;
import com.rednels.ofcgwt.client.model.axis.YAxis;
import com.rednels.ofcgwt.client.model.elements.AreaChart;
import com.rednels.ofcgwt.client.model.elements.BarChart;
import com.rednels.ofcgwt.client.model.elements.BarChart.BarStyle;
import com.rednels.ofcgwt.client.model.elements.LineChart.LineStyle;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.types.TabBarControls;
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
import com.smartgwt.client.widgets.form.fields.ViewFileItem;
import com.smartgwt.client.widgets.layout.HLayout;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.events.TabSelectedEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedHandler;
import com.smartgwt.client.widgets.toolbar.ToolStrip;
import com.smartgwt.client.widgets.toolbar.ToolStripButton;
import com.smartgwt.client.widgets.toolbar.ToolStripMenuButton;

public class TestWindow extends Window {
	TabSet tabSet = new TabSet();

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

	public TestWindow() {
		this.setWidth(600);
		this.setHeight(400);
		this.setTitle("Connect");
		this.setShowMinimizeButton(false);
		this.setCanDragResize(true);
		this.setIsModal(true);
		this.centerInPage();
		Canvas canvas = new Canvas();
		canvas.setContents("aa");
		canvas.setWidth("10%");

		tabSet.setWidth100();
		tabSet.setTabBarPosition(Side.LEFT);
		final RichTextItemIssueTab rit = new RichTextItemIssueTab();

		String imgHTML = Canvas.imgHTML("[ISOMORPHIC]/resources/icons/database_connect.png");
		System.out.println("imgHTML:" + imgHTML);
		// TODO Rotate text:
		// 1. http://snook.ca/archives/html_and_css/css-text-rotation
		// 2. http://css3please.com/
		String formTitle = "<span align=\"left\" style=\"{-webkit-transform: rotate(-90deg); -moz-transform: rotate(-90deg);}\">" + imgHTML
				+ "&nbsp;" + "Static" + "</span>";
		System.out.println("formTitle:" + formTitle);
		rit.setTitle(formTitle);

		tabSet.addTab(rit);
		tabSet.addTab(new ChartTab());
		tabSet.addTab(new RadarChartTab());

		// TestCase1
		Tab testCase1Tab = new Tab("TestCase1");
		testCase1Tab.setPane(new TestCase1());
		tabSet.addTab(testCase1Tab);

		{ // 20120811 кнопки на табсете

			// DynamicForm form = new DynamicForm();
			// form.setPadding(0);
			// form.setMargin(0);
			// form.setCellPadding(1);
			// form.setNumCols(1);
			// form.setFields(selectItem);
			// tabSet.setTabBarControls(TabBarControls.TAB_SCROLLER, TabBarControls.TAB_PICKER, form);

			// final Menu menu = new Menu();
			// MenuItem newItem = new MenuItem("New", "icons/16/document_plain_new.png", "Ctrl+N");
			// menu.setItems(newItem);
			// final ToolStripMenuButton menuButton = new ToolStripMenuButton("File", menu);
			// menuButton.setWidth(100);
			// ToolStrip toolStrip = new ToolStrip();
			//
			// // Если сбоку... кстати, работает херотенька для боковых табиков в хроме и фаерфоксе. Только в TAB_PICKER теперь все боком
			// мля..
			// // И с шириной все как-то не так..
			// //
			// // toolStrip.setVertical(true);
			// // tabSet.setTabBarPosition(Side.LEFT);
			//
			// tabSet.setTabBarPosition(Side.TOP);
			// toolStrip.setWidth(100);
			// toolStrip.setHeight(null != tabSet.getHeight() ? tabSet.getHeight() : 24); // пофигу - дефолтной высоты tabSet не дает
			// toolStrip.addMenuButton(menuButton);
			// toolStrip.addSeparator();
			// ToolStripButton hideTabsetPanesButton = new ToolStripButton();
			// hideTabsetPanesButton.setIcon("[SKIN]/headerIcons/arrow_down_Over.png"); // arrow_left_Over/arrow_right_Over/arrow_up_Over
			// toolStrip.addButton(hideTabsetPanesButton);
			// tabSet.setTabBarControls(TabBarControls.TAB_SCROLLER, TabBarControls.TAB_PICKER, toolStrip);
			tabSet.setCanCloseTabs(true);
			{
				// tabSet.addTabContextMenuHandler(new TabContextMenuHandler() {
				//
				// @Override
				// public void onTabContextMenu(TabContextMenuEvent event) {
				// com.google.gwt.user.client.Window.alert("TabContextMenuEvent. TabTitle:" + event.getTab().getTitle());
				// Menu ctxMenu = new Menu();
				// MenuItem m1 = new MenuItem("sss-" + event.getTab().getTitle());
				// MenuItem m2 = new MenuItemSeparator();
				// ctxMenu.setData(m1, m2);
				// tabSet.setContextMenu(ctxMenu);
				// }
				// });

				// tabSet.addTabSelectedHandler(new TabSelectedHandler() {
				//
				// @Override
				// public void onTabSelected(TabSelectedEvent event) {
				// // com.google.gwt.user.client.Window.alert("TabSelectedEvent. TabTitle:" + event.getTab().getTitle());
				// String title = "New" + event.getTab().getTitle();
				// MenuItem newItem = new MenuItem(title, "icons/16/document_plain_new.png", "Ctrl+N");
				// menu.setItems(newItem);
				// menuButton.setTitle(title);
				// menuButton.setTooltip(title);
				// }
				// });
			}
		}

		HLayout vLayout = new HLayout();

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

				// com.google.gwt.user.client.Window.open(GWT.getModuleBaseURL() + "query/loading.gif", "loading.gif",
				// "menubar=no,location=no,resizable=no,scrollbars=no,status=no,width=250,height=150,navigation=no");
				// com.google.gwt.user.client.Window.open(rit.richTextItem.getValue().toString(), "File",
				// "menubar=no,location=no,resizable=no,scrollbars=no,status=no,width=250,height=150,navigation=no");
				// com.google.gwt.user.client.Window.open("data:text/html;charset=utf-8, aaabbb", "_blank", "height=300,width=400");
				// tabSet.hideTabBar();

				ActionStatusWindow.createActionStatusWindow("title", "short", "long", StatusType.WARNING, null, "Ok");

			}
		});

		vLayout.addMember(b);
		vLayout.addMember(canvas);
		vLayout.addMember(tabSet);
		this.addItem(vLayout);

		// /////////////
		// TestDownloadFileClickHandler ddd = new TestDownloadFileClickHandler();
		// DynamicForm df = new DynamicForm();
		// df.setDataSource(ddd.new FileDS());
		// ViewFileItem vfi = new ViewFileItem("SKU", "Download");
		// FormItem fi = new FormItem();
		// fi.setTitle("dddmy");
		// df.setItems(fi, vfi);
		// Tab t = new Tab("Downloadaaa");
		// t.setPane(df);
		// tabSet.addTab(t);
		// //
		// ListGrid g = new ListGrid();
		// g.setDataSource(ddd.new FileDS());
		// Tab t2 = new Tab("Download2");
		// t2.setPane(g);
		// tabSet.addTab(t2);
		// g.fetchData();
		// ////////////////////

		this.show();
		// tabSet.hideTabBar();
	}
}
