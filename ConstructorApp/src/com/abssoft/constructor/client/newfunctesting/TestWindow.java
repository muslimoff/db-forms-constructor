package com.abssoft.constructor.client.newfunctesting;

import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.abssoft.constructor.common.ActionStatus.StatusType;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.layout.HLayout;

public class TestWindow extends Window {
	TabSet tabSet = new TabSet();

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
		tabSet.setCanDragResize(true);
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
		//tabSet.addTab(new CodeMirrorV5Test());
		tabSet.addTab(new CodeMirrorTest());
		//tabSet.addTab(rit);
		//tabSet.addTab(new SyntaxHighLightTab());

		// tabSet.addTab(new ChartTab());
		// tabSet.addTab(new RadarChartTab());

		// TestCase1
		//		Tab testCase1Tab = new Tab("TestCase1");
		//		testCase1Tab.setPane(new TestCase1());
		//		tabSet.addTab(testCase1Tab);

		{ // 20120811 кнопки на табсете
			tabSet.setCanCloseTabs(true);
		}

		HLayout vLayout = new HLayout();

		IButton b = new IButton("xxx");
		b.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(ClickEvent event) {
				ActionStatusWindow.createActionStatusWindow("title", "short", "long", StatusType.WARNING, null, "Ok");

			}
		});

		vLayout.addMember(b);
		vLayout.addMember(canvas);
		vLayout.addMember(tabSet);

		this.addItem(vLayout);
		this.show();

	}
}
