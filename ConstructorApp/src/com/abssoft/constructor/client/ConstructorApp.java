package com.abssoft.constructor.client;

import java.util.Iterator;
import java.util.LinkedHashMap;

import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.common.KeyIdentifier;
import com.abssoft.constructor.client.common.TabSet;
import com.abssoft.constructor.client.common.ToolBar;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.ConnectionInfo;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.ApplicationToolBar;
import com.abssoft.constructor.client.form.MainFormContainer;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;
import com.abssoft.constructor.client.widgets.MenuWithHover;
import com.google.gwt.core.client.EntryPoint;
import com.google.gwt.core.client.GWT;
import com.google.gwt.event.logical.shared.CloseEvent;
import com.google.gwt.event.logical.shared.CloseHandler;
import com.google.gwt.user.client.Cookies;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.types.Side;
import com.smartgwt.client.types.VerticalAlignment;
import com.smartgwt.client.util.KeyCallback;
import com.smartgwt.client.util.Page;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.ButtonItem;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.PasswordItem;
import com.smartgwt.client.widgets.form.fields.SelectItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.ChangeEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangeHandler;
import com.smartgwt.client.widgets.form.fields.events.ClickEvent;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.layout.VStack;
import com.smartgwt.client.widgets.menu.Menu;
import com.smartgwt.client.widgets.menu.MenuButton;
import com.smartgwt.client.widgets.menu.MenuItem;
import com.smartgwt.client.widgets.menu.MenuItemIfFunction;
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

	private TabSet tabSet = new TabSet();
	public static int sessionId = -1;
	public static MenusArr menus;
	public static StaticLookupsArr staticLookupsArr;
	public static ApplicationToolBar mainToolBar = new ApplicationToolBar();
	public static boolean debugEnabled = false;
	MenuButton formsMenuBtn = new MenuButton("Формы");
	ConnectWindow connectWindow;

	class ConnectDataCallback extends DSAsyncCallback<ConnectionInfo> {

		public void onSuccess(ConnectionInfo result) {
			String status = result.getStatus();
			status = status.equals("") ? "Connected." : ("Error:" + status);
			sessionId = result.getSessionId();
			Utils.debug("sessionId: " + sessionId);
			com.abssoft.constructor.client.data.Utils.debug(status);
			QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
			service.getMenusArr(ConstructorApp.sessionId, new MenusDataCallback(formsMenuBtn, tabSet));
			service.getStaticLookupsArr(ConstructorApp.sessionId, new DSAsyncCallback<StaticLookupsArr>() {

				@Override
				public void onSuccess(StaticLookupsArr result) {
					ConstructorApp.staticLookupsArr = result;
					System.out.println(result);
				}
			});
		}
	}

	public class ConnectWindow extends com.smartgwt.client.widgets.Window {
		private ButtonItem connectBtn;

		public void show() {
			super.show();
			connectBtn.focusInItem();
		}

		public ConnectWindow() {
			final QueryServiceAsync queryService = (QueryServiceAsync) GWT.create(QueryService.class);
			this.setWidth(360);
			this.setHeight(140);
			this.setTitle("Connect");
			this.setShowMinimizeButton(false);
			this.setIsModal(true);
			this.centerInPage();

			DynamicForm form = new DynamicForm();
			form.setHeight100();
			form.setWidth100();
			form.setPadding(5);
			form.setLayoutAlign(VerticalAlignment.BOTTOM);
			final ComboBoxItem serverSelectItem = new ComboBoxItem();
			serverSelectItem.setTitle("Server");

			LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
			valueMap.put("jdbc:oracle:thin:@10.0.14.10:1521:APPLPR", "NBAPPLPR");
			valueMap.put("jdbc:oracle:thin:@apps.abssoft.kz:1522:DEMO12i", "DemoLocal");
			valueMap.put("jdbc:oracle:thin:@apps.ba-solutions.kz:1522:DEMO", "BAS_11");
			valueMap.put("jdbc:oracle:thin:@VM_XE:1521:XE", "VM_XE");
			valueMap.put("jdbc:oracle:thin:@rdbms.abssoft.kz:1524:VIS12", "VIS12");
			valueMap.put("jdbc:oracle:thin:@192.168.110.3:1524:VIS12", "VIS12_IP");
			String s = "jdbc:oracle:thin:@(DESCRIPTION =(ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = rdbms.abssoft.kz)(PORT = 1524)))"
					+ "(CONNECT_DATA = (SID = VIS12) (SERVER = DEDICATED)))";
			valueMap.put(s, "VIS12_full");

			serverSelectItem.setValueMap(valueMap);
			// serverSelectItem.setValue("jdbc:oracle:thin:@VM_XE:1521:XE");
			serverSelectItem.setValue("jdbc:oracle:thin:@10.0.14.10:1521:APPLPR");

			final TextItem textItem = new TextItem();
			textItem.setTitle("User Name");
			textItem.setValue("FORMS_CONSTRUCTOR");
			final PasswordItem passItem = new PasswordItem();
			passItem.setTitle("Password");
			passItem.setValue("f");
			connectBtn = new ButtonItem("Connect");
			connectBtn.addClickHandler(new com.smartgwt.client.widgets.form.fields.events.ClickHandler() {

				@Override
				public void onClick(ClickEvent event) {
					Utils.debug("connectBtn.onClick");
					String url = serverSelectItem.getValue().toString();
					String user = textItem.getValue().toString();
					String password = passItem.getValue().toString();
					Utils.debug("url:" + url + "; user:" + user + "; password:" + password);
					if (-1 != sessionId) {
						Utils.debug("Close previous session...");
						doBeforeClose("ConnectWindow:");
						for (MenuItem m : formsMenuBtn.getMenu().getItems()) {
							formsMenuBtn.getMenu().removeItem(m);
							menus.clear();
						}
					}
					Utils.debug("Create new session...");
					Utils.debug("ModuleBaseURL:" + com.google.gwt.core.client.GWT.getModuleBaseURL());
					queryService.connect(url, user, password, new ConnectDataCallback());
					ConnectWindow.this.hide();
				}
			});
			form.setFields(new FormItem[] { serverSelectItem, textItem, passItem, connectBtn });
			this.addItem(form);
			this.show();
		}
	}

	public class SkinSelector extends DynamicForm {
		public SkinSelector() {
			SelectItem selectItem = new SelectItem();
			selectItem.setWidth(130);
			LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
			valueMap.put("Enterprise", "Enterprise");
			valueMap.put("SilverWave", "Silver Wave");
			valueMap.put("BlackOps", "Black Ops");
			valueMap.put("TreeFrog", "Tree Frog");
			valueMap.put("fleet", "Fleet");

			valueMap.put("Cupertino", "Cupertino");
			valueMap.put("standard", "Standard");
			// valueMap.put("ToolSkin", "ToolSkin");

			selectItem.setValueMap(valueMap);

			String currentSkin = Cookies.getCookie("skin");
			if (currentSkin == null) {
				currentSkin = "SilverWave";
			}
			selectItem.setDefaultValue(currentSkin);
			selectItem.setShowTitle(false);
			selectItem.addChangeHandler(new ChangeHandler() {
				public void onChange(ChangeEvent event) {
					Cookies.setCookie("skin", (String) event.getValue());
					com.google.gwt.user.client.Window.Location.reload();
				}
			});

			this.setPadding(0);
			this.setMargin(0);
			this.setCellPadding(1);
			this.setNumCols(1);
			this.setFields(selectItem);
		}
	}

	private void doBeforeClose(final String msg) {
		QueryServiceAsync queryService = (QueryServiceAsync) GWT.create(QueryService.class);
		queryService.sessionClose(sessionId, new DSAsyncCallback<Void>() {
			@Override
			public void onSuccess(Void result) {
				String msg2 = msg + ": DB session " + sessionId + " closed...";
				sessionId = -1;
				com.abssoft.constructor.client.data.Utils.debug(msg2);
				Window.alert(msg2);
			}
		});
		for (Tab t : tabSet.getTabs()) {
			tabSet.removeTab(t);
		}
		mainToolBar.clear();
	}

	public void onModuleLoad() {
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
		tabSet.setHeight("93%");
		tabSet.setAccessKey("Q");

		final MenuButton fileMenuBtn = new MenuButton("Файл");
		// -----------
		MenuItem connMI = new MenuItem("Connect");
		connMI.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(MenuItemClickEvent event) {
				if (null == connectWindow) {
					connectWindow = new ConnectWindow();
				}
				connectWindow.show();

			}
		});
		//
		final MenuItem debugMI = new MenuItem("Debug");
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
		mm.setData(connMI, debugMI);
		fileMenuBtn.setMenu(mm);
		// -----------
		MenuButton serviceMenuBtn = new MenuButton("Сервис");
		MenuItem testMI = new MenuItem("Test");
		testMI.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(MenuItemClickEvent event) {
				System.out.println("XXXXXXXXXXXX TESTw");
				new TestWindow();
			}
		});
		Menu smm = new Menu();
		smm.setData(testMI);
		serviceMenuBtn.setMenu(smm);
		// -----connect();
		ToolBar menuBar = new ToolBar(20);
		menuBar.addMembers(fileMenuBtn, formsMenuBtn, serviceMenuBtn);
		menuBar.addMember(new SkinSelector());

		VStack vStack = new VStack();
		vStack.addMember(menuBar);
		vStack.addMember(mainToolBar);
		vStack.addMember(tabSet);
		vStack.setWidth100();
		vStack.setHeight100();
		canvas.addChild(vStack);
		canvas.draw();
		connectWindow = new ConnectWindow();
	}

	public void add_debug_console() {
		if (!GWT.isScript() || 1 == 1) {
			Page.registerKey(new KeyIdentifier("Ctrl+D"), new KeyCallback() {
				public void execute(String keyName) {
					SC.showConsole();
				}
			});
		}
	}

	private static final String defaultTitle = "Forms Constructor";

	public static void setPageTitle(String title) {
		Page.setTitle(defaultTitle + " " + title);
	}
}

class MenusDataCallback extends DSAsyncCallback<MenusArr> {
	MenuButton menuButton;

	TabSet tabSet;

	class FormMenuItem extends MenuItem {
		private MenuMD menuMetadata;

		/**
		 * @return the menuMetadata
		 */
		public MenuMD getMenuMetadata() {
			return menuMetadata;
		}

		/**
		 * @param menuMetadata
		 *            the menuMetadata to set
		 */
		public void setMenuMetadata(MenuMD menuMetadata) {
			this.menuMetadata = menuMetadata;
		}

		public FormMenuItem(final MenuMD menuMetadata) {
			this.menuMetadata = menuMetadata;
			String title = (null == menuMetadata.getFormName()) ? menuMetadata.getFormCode() : menuMetadata.getFormName();
			this.setTitle(title);

			this.setIcon(ConstructorApp.menus.getIcons().get(menuMetadata.getIconId()));
			String hotKey = menuMetadata.getHotKey();
			if (hotKey != null) {
				KeyIdentifier key = new KeyIdentifier(menuMetadata.getHotKey());
				this.setKeys(key);
				this.setKeyTitle(key.getTitle());
			}
			this.addClickHandler(new ClickHandler() {
				public void onClick(MenuItemClickEvent event) {
					Utils.debug("FormMenus onClick: " + menuMetadata.getFormCode());
					new MainFormContainer(FormTab.TabType.MAIN, tabSet, menuMetadata.getFormCode());
					Utils.debug("FormMenus onClick2: " + menuMetadata.getFormCode());
				}
			});

		}

		public MenuMD getFormMetadata() {
			return menuMetadata;
		}
	}

	public MenusDataCallback(MenuButton menuButton, TabSet tabSet) {
		this.menuButton = menuButton;
		this.tabSet = tabSet;
	}

	public void onSuccess(MenusArr result) {
		ConstructorApp.menus = result;
		ConstructorApp.menus.getIcons().addDefaultIconPath();
		final MenuWithHover menu = new MenuWithHover();
		menu.setShowShadow(true);
		menu.setShadowDepth(10);
		Iterator<String> menuIterator = result.keySet().iterator();
		int formsCount = result.size();
		FormMenuItem[] mi = new FormMenuItem[formsCount];
		int i = 0;
		while (menuIterator.hasNext()) {
			mi[i++] = new FormMenuItem(result.get(menuIterator.next()));
			// mi[i].setAttribute("description", "descr" + i);
		}

		menu.setData(mi);
		menuButton.setMenu(menu);

		menu.setCanHover(true);
		menu.setShowHover(true);
		menu.setHoverWidth(300);
		menu.setCellHoverCustomizer(new MenuWithHover.CellHoverCustomizer() {

			@Override
			public String cellHoverHTML(ListGridRecord record, int rowNum, int colNum) {
				String hover = null;
				if (record instanceof FormMenuItem) {
					hover = ((FormMenuItem) record).getFormMetadata().getDescription();
				}
				hover = (null != hover) ? hover : record.getAttribute("title");
				return hover;
			}
		});
	}
}
