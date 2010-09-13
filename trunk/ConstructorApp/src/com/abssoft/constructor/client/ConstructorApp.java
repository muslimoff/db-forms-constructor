package com.abssoft.constructor.client;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.abssoft.constructor.client.app.ConnectWindow;
import com.abssoft.constructor.client.app.SkinSelectorMenu;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.common.ToolBar;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.ApplicationToolBar;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.ServerInfoArr;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.CloseEvent;
import com.google.gwt.event.logical.shared.CloseHandler;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.util.DateDisplayFormatter;
import com.smartgwt.client.util.DateInputFormatter;
import com.smartgwt.client.util.DateUtil;
import com.smartgwt.client.util.KeyCallback;
import com.smartgwt.client.util.Page;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.layout.VStack;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuButton;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
import com.smartgwt.client.widgets.menu.MenuItemSeparator;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;
import com.smartgwt.client.widgets.tab.Tab;

/**
 *ConstructorApp - GUI-generator, based on SQL-queries
 * 
 * @author Muslimoff
 * @version 0.0.0.1
 */
public class ConstructorApp implements EntryPoint {

	public static TabSet tabSet = new TabSet();
	public static int sessionId = -1;
	// TODO Разделить иконки и меню
	public static MenusArr menus;
	public static HashMap<String, Integer> formIconArr = new HashMap<String, Integer>();
	public static HashMap<String, String> formNameArr = new HashMap<String, String>();
	public static StaticLookupsArr staticLookupsArr;
	public static ApplicationToolBar mainToolBar = new ApplicationToolBar();
	public static boolean debugEnabled = true;
	public static ServerInfoArr serverInfoArr;
	public static String defaultTitle = "Forms Constructor";
	public static ToolBar menuBar = new ToolBar(20);
	private static MenuButton serviceMenuBtn = new MenuButton("Сервис");
	private static MenuButton fileMenuBtn = new MenuButton("Файл");
	public static Map<String, List<String>> urlParams;
	public static Criteria urlParamsCriteria = new Criteria();

	ConnectWindow connectWindow;

	private void doBeforeClose(final String msg) {
		if (-1 != sessionId) {
			QueryServiceAsync queryService = (QueryServiceAsync) GWT.create(QueryService.class);
			queryService.sessionClose(sessionId, new DSAsyncCallback<Void>() {
				@Override
				public void onSuccess(Void result) {
					String msg2 = msg + ": DB session " + sessionId + " closed...";
					sessionId = -1;
					// Utils.debug(msg2);
					System.out.println(msg2);
				}
			});
			for (Tab t : tabSet.getTabs()) {
				tabSet.removeTab(t);
			}
			mainToolBar.clear();
		}
	}

	public void clearMenus() {
		if (-1 != sessionId) {
			Utils.debug("Close previous session...");
			doBeforeClose("ConnectWindow:");

			for (Canvas cc : menuBar.getMembers()) {
				if (cc instanceof MenuButton && !cc.equals(serviceMenuBtn) && !cc.equals(fileMenuBtn)) {
					((MenuButton) cc).getMenu().destroy();
					cc.destroy();
				}
			}
			menus.clear();
		}
	}

	public void onModuleLoad() {
		DateUtil.setShortDateDisplayFormatter(new DateDisplayFormatter() {
			@Override
			public String format(Date date) {
				if (date == null)
					return null;

				DateTimeFormat dateFormatter = DateTimeFormat.getFormat("dd.MM.yyyy");
				String format = dateFormatter.format(date);
				return format;
			}
		});
		DateUtil.setDateInputFormatter(new DateInputFormatter() {
			@Override
			public Date parse(String dateString) {
				final DateTimeFormat dateFormatter = DateTimeFormat.getFormat("dd.MM.yyyy");
				Date date = dateFormatter.parse(dateString);
				return date;
			}
		});
		Window.addCloseHandler(new CloseHandler<Window>() {
			public void onClose(CloseEvent<Window> event) {
				doBeforeClose("onClose");
			}
		});
		add_debug_console();
		Canvas canvas = new Canvas();
		canvas.setWidth100();
		canvas.setBackgroundImage("[SKIN]/shared/background.gif");
		canvas.setHeight100();

		tabSet.setTabBarPosition(Side.BOTTOM);
		tabSet.setTabBarAlign(Side.LEFT);
		tabSet.setHeight("92%");
		tabSet.setAccessKey("Q");
		// -----------
		MenuItem connMI = new MenuItem("Connect");
		connMI.setIcon("[ISOMORPHIC]/resources/icons/database_connect.png");
		connMI.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(MenuItemClickEvent event) {
				if (null == connectWindow) {
					connectWindow = new ConnectWindow(ConstructorApp.this);
				}
				connectWindow.show();

			}
		});
		//
		final MenuItem debugMI = new MenuItem("Debug");
		debugMI.setIcon("[ISOMORPHIC]/resources/icons/" + "bug.png");
		debugMI.setCheckIfCondition(new MenuItemIfFunction() {
			public boolean execute(Canvas target, Menu menu, MenuItem item) {
				return ConstructorApp.debugEnabled;
			}
		});
		debugMI.addClickHandler(new ClickHandler() {
			public void onClick(MenuItemClickEvent event) {
				ConstructorApp.debugEnabled = !ConstructorApp.debugEnabled;
			}
		});

		Menu mm = new Menu();
		mm.setData(connMI, debugMI, new MenuItemSeparator(), new SkinSelectorMenu());
		fileMenuBtn.setMenu(mm);
		// -----------
		MenuItem testMI = new MenuItem("Test");
		testMI.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(MenuItemClickEvent event) {
				System.out.println("XXXXXXXXXXXX TESTw");
				new TestWindow();
			}
		});
		// /////////////
		MenuItem closeFormMI = new MenuItem("Закрыть форму");
		KeyIdentifier key = new KeyIdentifier("ctrl+alt+shift+4");
		closeFormMI.setKeys(key);
		closeFormMI.setKeyTitle(key.getTitle());
		closeFormMI.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(MenuItemClickEvent event) {
				tabSet.removeMainFormContainerTab(tabSet.getSelectedTab());
			}
		});
		MenuItem downloadMI = new MenuItem("TestActWnd");
		downloadMI.addClickHandler(new ClickHandler() {
			@Override
			public void onClick(MenuItemClickEvent event) {
				ActionStatusWindow.createActionStatusWindow("wwwwwwww", this.getClass().getName(), this.toString());
				// new RestfulDataSourceSample();
			}
		});
		// /////////////
		Menu smm = new Menu();
		smm.setData(closeFormMI, testMI, downloadMI);
		serviceMenuBtn.setMenu(smm);
		// -----connect();
		menuBar.addMembers(fileMenuBtn, serviceMenuBtn);
		VStack vStack = new VStack();
		vStack.addMember(menuBar);
		vStack.addMember(mainToolBar);
		vStack.addMember(tabSet);
		vStack.setWidth100();
		vStack.setHeight100();
		canvas.addChild(vStack);
		canvas.draw();
		urlParams = com.google.gwt.user.client.Window.Location.getParameterMap();
		{
			Map<String, List<String>> urlParams = com.google.gwt.user.client.Window.Location.getParameterMap();
			Iterator<String> i = urlParams.keySet().iterator();
			Utils.debug("%%%%%%%%%%%%%%%%%%%PARAMETERS%%%%%%%%%%%%%%%%%");
			while (i.hasNext()) {
				String pKey = i.next();
				Utils.debug(pKey + ": " + urlParams.get(pKey));
				List<String> vals = urlParams.get(pKey);
				for (String val : vals) {
					if (!val.matches("app\\.")) {
						urlParamsCriteria.addCriteria(pKey, val);
						// Utils.debug("parameter: " + pKey + "=\"" + val + "\"");
					}
				}
			}

		}
		Utils.debug("QueryString:" + com.google.gwt.user.client.Window.Location.getQueryString());
		connectWindow = new ConnectWindow(ConstructorApp.this);
	}

	public void add_debug_console() {
		if (!GWT.isScript() || 1 == 1) {
			Page.registerKey(new KeyIdentifier("Ctrl+Alt+Shift+D"), new KeyCallback() {
				public void execute(String keyName) {
					SC.showConsole();
				}
			});
		}
	}

	public static void setPageTitle(String title) {
		String pageTitle = (defaultTitle + " " + title).trim();
		Page.setTitle(pageTitle);
	}
}
