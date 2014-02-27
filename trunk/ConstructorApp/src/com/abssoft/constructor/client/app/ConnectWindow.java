package com.abssoft.constructor.client.app;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.common.ConnectionInfo;
import com.abssoft.constructor.common.ServerInfoArr;
import com.abssoft.constructor.common.StaticLookupsArr;
import com.abssoft.constructor.common.metadata.ServerInfoMD;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.Cookies;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.types.HeaderControls;
import com.smartgwt.client.types.VerticalAlignment;
import com.smartgwt.client.widgets.HeaderControl;
import com.smartgwt.client.widgets.IButton;
import com.smartgwt.client.widgets.events.ClickEvent;
import com.smartgwt.client.widgets.events.ClickHandler;
import com.smartgwt.client.widgets.events.VisibilityChangedEvent;
import com.smartgwt.client.widgets.events.VisibilityChangedHandler;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemIfFunction;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.PasswordItem;
import com.smartgwt.client.widgets.form.fields.SelectItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.ToolbarItem;
import com.smartgwt.client.widgets.form.fields.events.BlurEvent;
import com.smartgwt.client.widgets.form.fields.events.BlurHandler;
import com.smartgwt.client.widgets.form.fields.events.ChangeEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangeHandler;
import com.smartgwt.client.widgets.form.fields.events.KeyPressEvent;
import com.smartgwt.client.widgets.form.fields.events.KeyPressHandler;

public class ConnectWindow extends com.smartgwt.client.widgets.Window {
	private boolean detailsDisplayed = false;

	public class ConnectDataCallback extends DSAsyncCallback<ConnectionInfo> {
		public ConnectDataCallback() {
		}

		public void onSuccess(ConnectionInfo result) {

			ConstructorApp.sessionId = result.getSessionId();
			Cookies.setCookie("FCSessionId", (String) ""
					+ ConstructorApp.sessionId);
			// String currentSkin = Cookies.getCookie("FCSessionId");
			String status = result.getStatus();
			ConstructorApp.dbServerVersion = result.getDbServerVersion();
			detailTextItem.setVersions(ConstructorApp.clientVersion,
					ConstructorApp.appServerVersion,
					ConstructorApp.dbServerVersion);
			if (!"".equals(status) || -1 == ConstructorApp.sessionId) {
				ConnectWindow.this.setOpacity(100);
				status = "Error:" + status;
				Window.alert(status);
				Utils.debug(status);

			} else {
				Utils.debug("sessionId: " + ConstructorApp.sessionId);
				Utils.createQueryService("ConnectWindow.getMenusArr")
						.getMenusArr(ConstructorApp.sessionId,
								new MenusDataCallback());
				Utils.createQueryService("ConnectWindow.StaticLookups")
						.getStaticLookupsArr(ConstructorApp.sessionId,
								new DSAsyncCallback<StaticLookupsArr>() {

									@Override
									public void onSuccess(
											StaticLookupsArr result) {
										ConstructorApp.staticLookupsArr = result;
										System.out.println(result);
										// openFormsFromURL();
									}
								});
				ConnectWindow.this.hide();
			}
		}
	}

	private IButton connectBtn;

	private class VersionsTextAreaItem extends TextAreaItem {
		public void setVersions(String clientVersion, String appServerVersion,
				String dbServerVersion) {
			this.setValue("clientVersion:" + clientVersion
					+ ";\nappServerVersion:" + appServerVersion
					+ ";\ndbServerVersion:" + dbServerVersion);
		}
	};

	private Integer defaultServerInfoArrIdx = -1;

	private SelectItem dbServerSelectItem = new SelectItem();
	protected TextItem userNameItem = new TextItem();
	protected PasswordItem passItem = new PasswordItem();
	private ConstructorApp сonstructorApp;
	private TextItem appServerTextItem = new TextItem();
	private VersionsTextAreaItem detailTextItem = new VersionsTextAreaItem();

	// TODO Parameters
	// public void openFormsFromURL1() {
	// List<String> formList = ConstructorApp.urlParams.get("app.form");
	// if (null != formList) {
	// for (int i = 0; i < formList.size(); i++) {
	// String formCode = formList.get(i);
	// Utils.debug("Form, that will be open (" + i + "): \"" + formCode + "\"");
	// if (formCode != null && ConstructorApp.formNameArr.containsKey(formCode))
	// {
	// Utils.debug("Form opening (" + i + "):" + formCode);
	// MainFormContainer mfc = new MainFormContainer(FormTab.TabType.MAIN,
	// ConstructorApp.tabSet, formCode);
	// mfc.getMainFormPane().setFromUrl(true);
	// }
	// }
	// }
	// }

	public ConnectWindow(final ConstructorApp сonstructorApp) {
		final DynamicForm form = new DynamicForm();
		this.сonstructorApp = сonstructorApp;
		HeaderControl comment = new HeaderControl(HeaderControl.COMMENT,
				new ClickHandler() {
					@Override
					public void onClick(ClickEvent event) {
						detailsDisplayed = !detailsDisplayed;
						form.markForRedraw();
					}
				});
		this.setHeaderControls(HeaderControls.HEADER_LABEL, comment,
				HeaderControls.CLOSE_BUTTON);
		this.setWidth(360);
		// this.setHeight(150);
		// this.setHeight(170);
		this.setTitle("Connect");
		this.setShowMinimizeButton(false);
		this.setCanDragResize(true);
		this.setShowModalMask(true);
		this.setIsModal(true);
		this.centerInPage();
		// 20120811 - Добавил для эргономичной работы с тестовым окном
		this.addVisibilityChangedHandler(new VisibilityChangedHandler() {
			@Override
			public void onVisibilityChanged(VisibilityChangedEvent event) {
				if (!event.getIsVisible() && ConstructorApp.debugEnabled) {
					// Window.alert("hidden");
					// new TestWindow();
				}

			}
		});

		this.setAutoSize(true);

		Utils.debug("ConnectWindow.ModuleBaseURL:"
				+ com.google.gwt.core.client.GWT.getModuleBaseURL());
		Utils.debug("ConnectWindow.QueryString:"
				+ com.google.gwt.user.client.Window.Location.getQueryString());
		Utils.debug("ConnectWindow.ParameterMap:"
				+ com.google.gwt.user.client.Window.Location.getParameterMap());
		form.setHeight100();
		form.setWidth100();
		form.setPadding(5);
		// form.setTitleWidth(100);
		// form.setColWidths(100, 200);
		form.setWrapItemTitles(false);
		// form.setAutoWidth();
		// form.setNumCols(3);
		final LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
		form.setLayoutAlign(VerticalAlignment.BOTTOM);
		dbServerSelectItem.setTitle("DB Server");
		userNameItem.setTitle("User Name");
		passItem.setTitle("Password");
		appServerTextItem.setTitle("App Server");
		appServerTextItem.setValue(ConstructorApp.AIRmoduleBaseURL);

		dbServerSelectItem.addChangeHandler(new ChangeHandler() {
			@Override
			public void onChange(ChangeEvent event) {
				setValues(Integer.decode(event.getValue().toString()));
				userNameItem.focusInItem();
			}
		}

		);

		userNameItem.addKeyPressHandler(new KeyPressHandler() {
			@Override
			public void onKeyPress(KeyPressEvent event) {
				if ("Enter".equals(event.getKeyName())) {
					passItem.focusInItem();
				}
			}
		});

		passItem.addKeyPressHandler(new KeyPressHandler() {
			@Override
			public void onKeyPress(KeyPressEvent event) {
				if ("Enter".equals(event.getKeyName())) {
					connect();
				}
			}
		});

		if (!Utils.isAIR()) {
			Utils.createQueryService("ConnectWindow.getServerInfoArr")
					.getServerInfoArrWithoutPassword(
							new ServerInfoArrDSAsyncCallback(valueMap));
		}

		connectBtn = new IButton("Connect");
		connectBtn.setAlign(Alignment.CENTER);
		connectBtn.addClickHandler(new ClickHandler() {

			@Override
			public void onClick(ClickEvent event) {
				Utils.debug("connectBtn.onClick");
				// ConstructorApp.tabSet.viewToolstripAfterDraw();
				connect();
			}
		});

		appServerTextItem.addBlurHandler(new BlurHandler() {

			@Override
			public void onBlur(BlurEvent event) {
				// TODO Auto-generated method stub

				ConstructorApp.AIRmoduleBaseURL = appServerTextItem
						.getValueAsString();
				Utils.createQueryService("ConnectWindow.getServerInfoArr2")
						.getServerInfoArrWithoutPassword(
								new ServerInfoArrDSAsyncCallback(valueMap));
			}
		});
		ToolbarItem toolbar = new ToolbarItem();
		toolbar.setAlign(Alignment.CENTER);
		toolbar.setButtons(connectBtn);
		toolbar.setWidth("1");
		detailTextItem.setShowTitle(false);
		detailTextItem.setHeight(100);
		detailTextItem.setColSpan("*");
		detailTextItem.setVersions(ConstructorApp.clientVersion, null, null);
		detailTextItem.setWidth("*");
		detailTextItem.setShowIfCondition(new FormItemIfFunction() {
			@Override
			public boolean execute(FormItem item, Object value, DynamicForm form) {
				return detailsDisplayed;
			}
		});

		if (Utils.isAIR()) {
			form.setFields(new FormItem[] { dbServerSelectItem, userNameItem,
					passItem, appServerTextItem, toolbar, detailTextItem });
		} else {
			form.setFields(new FormItem[] { dbServerSelectItem, userNameItem,
					passItem, toolbar, detailTextItem });
		}

		this.addItem(form);
		this.show();
	}

	private class ServerInfoArrDSAsyncCallback extends
			DSAsyncCallback<ServerInfoArr> {
		private LinkedHashMap<String, String> valueMap;

		ServerInfoArrDSAsyncCallback(LinkedHashMap<String, String> valueMap) {
			this.valueMap = valueMap;
		}

		@Override
		public void onSuccess(ServerInfoArr result) {
			// Сервер по умолчанию - если передается через параметр serverID -
			// имеет более высокий приоритет, чем дефолтный из
			// constructorapp.xml
			ConstructorApp.serverInfoArr = result;
			ConstructorApp.appServerVersion = result.getAppServerVersion();
			detailTextItem.setVersions(ConstructorApp.clientVersion,
					ConstructorApp.appServerVersion, null);
			// Utils.debug("AppServerVersion:" +
			// ConstructorApp.appServerVersion);
			String defaultServerID = com.google.gwt.user.client.Window.Location
					.getParameter("app.serverID");
			Boolean defaultServerIsSet = null != defaultServerID
					&& !"".equals(defaultServerID);
			// System.out.println("defaultServerID: " + defaultServerID +
			// "; is null:" + (null == defaultServerID) + "; isEmptyString:"
			// + "".equals(defaultServerID) + "; defaultServerIsSet:" +
			// defaultServerIsSet);

			for (int i = 0; i < result.size(); i++) {
				ServerInfoMD si = result.get(i);
				String displayName = si.getDisplayName();
				valueMap.put(i + "", displayName);
				if ((defaultServerIsSet && defaultServerID.equals(si
						.getServerID()))
						|| (!defaultServerIsSet && si.isDefault())) {
					defaultServerInfoArrIdx = i;
				}
			}
			dbServerSelectItem.setValueMap(valueMap);
			setValues(defaultServerInfoArrIdx);
			// 20110911
			ConstructorApp.skinSelectorMenu.setItems(result.getSkinsList());

			// UserName & Password from URL Parameters
			String userName = com.google.gwt.user.client.Window.Location
					.getParameter("app.userName");
			String pwd = com.google.gwt.user.client.Window.Location
					.getParameter("app.pwd");
			if (defaultServerIsSet && null != userName && !"".equals(userName)) {
				userNameItem.setValue(userName);
				passItem.setValue(pwd);
				connect();
			}
		}
	}

	public void connect() {
		int serverIdx = Integer
				.decode(dbServerSelectItem.getValue().toString());
		String user = null;
		String password = null;
		// if
		// (ConstructorApp.serverInfoArr.get(serverIdx).isTransferPassToClient())
		// {
		user = (String) userNameItem.getValue();
		password = (String) passItem.getValue();
		// }
		Utils.debug("ConnId:" + dbServerSelectItem.getValue() + "; user:"
				+ user + "; password:" + password);
		сonstructorApp.clearMenus();
		Utils.debug("Create new session...");
		ConnectWindow.this.setOpacity(50);
		String urlParams = com.google.gwt.user.client.Window.Location
				.getQueryString();
		Utils.createQueryService("ConnectWindow.connect").connect(serverIdx,
				user, password, GWT.isScript(), urlParams,
				ConstructorApp.debugEnabled, new ConnectDataCallback());
	}

	void setValues(Integer idx) {
		if (-1 != idx) {
			String pass = ConstructorApp.serverInfoArr.get(idx).getDbPassword();
			boolean isDisabled = !ConstructorApp.serverInfoArr.get(idx)
					.isAllowUserChange();
			boolean isCustomAuth = !ConstructorApp.serverInfoArr.get(idx)
					.isTransferPassToClient();
			// isDisabled = isDisabled && isPassDisabled;
			dbServerSelectItem.setValue(idx + "");
			ConstructorApp.serverInfoArr.get(idx).isTransferPassToClient();
			userNameItem.setValue(ConstructorApp.serverInfoArr.get(idx)
					.getDbUsername());
			passItem.setValue(pass);
			// userNameItem.setDisabled(isDisabled);
			if (isCustomAuth) {
				userNameItem.setTitle("^User Name");
				passItem.setTitle("^Password");
				userNameItem.setDisabled(false);
			} else {
				userNameItem.setDisabled(isDisabled);
				userNameItem.setTitle("User Name");
				passItem.setTitle("Password");
			}

			ConnectWindow.this.markForRedraw();
			// passItem.setDisabled(isDisabled && isPassDisabled);
			ConstructorApp.defaultTitle = ConstructorApp.serverInfoArr.get(idx)
					.getTitle();
			ConstructorApp.setPageTitle("");
			ConstructorApp.debugEnabled = ConstructorApp.serverInfoArr.get(idx)
					.isDebug();
		}
	}

	public void show() {
		userNameItem.setValue("");
		passItem.setValue("");
		super.show();
		super.setOpacity(100);
		passItem.focusInItem();
		// serverSelectItem.focusInItem();
		// connectBtn.focusInItem();
	}
}