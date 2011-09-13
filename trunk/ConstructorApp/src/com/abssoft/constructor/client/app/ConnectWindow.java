package com.abssoft.constructor.client.app;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.ConnectionInfo;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.ServerInfoArr;
import com.abssoft.constructor.client.metadata.ServerInfoMD;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.types.VerticalAlignment;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.ButtonItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.PasswordItem;
import com.smartgwt.client.widgets.form.fields.SelectItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.ChangeEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangeHandler;
import com.smartgwt.client.widgets.form.fields.events.ClickEvent;
import com.smartgwt.client.widgets.form.fields.events.KeyPressEvent;
import com.smartgwt.client.widgets.form.fields.events.KeyPressHandler;

public class ConnectWindow extends com.smartgwt.client.widgets.Window {
	public class ConnectDataCallback extends DSAsyncCallback<ConnectionInfo> {
		public ConnectDataCallback() {
		}

		public void onSuccess(ConnectionInfo result) {
			ConstructorApp.sessionId = result.getSessionId();
			String status = result.getStatus();
			if (!"".equals(status) || -1 == ConstructorApp.sessionId) {
				ConnectWindow.this.setOpacity(100);
				status = "Error:" + status;
				Window.alert(status);
				Utils.debug(status);

			} else {
				Utils.debug("sessionId: " + ConstructorApp.sessionId);
				QueryServiceAsync service = (QueryServiceAsync) GWT.create(QueryService.class);
				service.getMenusArr(ConstructorApp.sessionId, new MenusDataCallback());
				service.getStaticLookupsArr(ConstructorApp.sessionId, new DSAsyncCallback<StaticLookupsArr>() {

					@Override
					public void onSuccess(StaticLookupsArr result) {
						ConstructorApp.staticLookupsArr = result;
						System.out.println(result);
						// openFormsFromURL();
					}
				});
				ConnectWindow.this.hide();
			}
		}
	}

	private ButtonItem connectBtn;

	private Integer defaultServerInfoArrIdx = -1;

	private SelectItem serverSelectItem = new SelectItem();
	private TextItem userNameItem = new TextItem();
	private PasswordItem passItem = new PasswordItem();
	private QueryServiceAsync queryService = (QueryServiceAsync) GWT.create(QueryService.class);
	private ConstructorApp сonstructorApp;

	// TODO Parameters
	// public void openFormsFromURL1() {
	// List<String> formList = ConstructorApp.urlParams.get("app.form");
	// if (null != formList) {
	// for (int i = 0; i < formList.size(); i++) {
	// String formCode = formList.get(i);
	// Utils.debug("Form, that will be open (" + i + "): \"" + formCode + "\"");
	// if (formCode != null && ConstructorApp.formNameArr.containsKey(formCode)) {
	// Utils.debug("Form opening (" + i + "):" + formCode);
	// MainFormContainer mfc = new MainFormContainer(FormTab.TabType.MAIN, ConstructorApp.tabSet, formCode);
	// mfc.getMainFormPane().setFromUrl(true);
	// }
	// }
	// }
	// }

	public ConnectWindow(final ConstructorApp сonstructorApp) {
		this.сonstructorApp = сonstructorApp;
		this.setWidth(360);
		this.setHeight(150);
		this.setTitle("Connect");
		this.setShowMinimizeButton(false);
		this.setShowModalMask(true);
		this.setIsModal(true);
		this.centerInPage();

		Utils.debug("ConnectWindow.ModuleBaseURL:" + com.google.gwt.core.client.GWT.getModuleBaseURL());
		Utils.debug("ConnectWindow.QueryString:" + com.google.gwt.user.client.Window.Location.getQueryString());
		Utils.debug("ConnectWindow.ParameterMap:" + com.google.gwt.user.client.Window.Location.getParameterMap());
		DynamicForm form = new DynamicForm();
		form.setHeight100();
		form.setWidth100();
		form.setPadding(5);
		final LinkedHashMap<String, String> valueMap = new LinkedHashMap<String, String>();
		form.setLayoutAlign(VerticalAlignment.BOTTOM);
		serverSelectItem.setTitle("Server");
		userNameItem.setTitle("User Name");
		passItem.setTitle("Password");

		serverSelectItem.addChangeHandler(new ChangeHandler() {
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

		queryService.getServerInfoArr(new DSAsyncCallback<ServerInfoArr>() {
			@Override
			public void onSuccess(ServerInfoArr result) {
				// Сервер по умолчанию - если передается через параметр serverID - имеет более высокий приоритет, чем дефолтный из
				// constructorapp.xml
				ConstructorApp.serverInfoArr = result;
				String defaultServerID = com.google.gwt.user.client.Window.Location.getParameter("app.serverID");
				Boolean defaultServerSetted = null != defaultServerID && !"".equals(defaultServerID);
				// System.out.println("defaultServerID: " + defaultServerID + "; is null:" + (null == defaultServerID) + "; isEmptyString:"
				// + "".equals(defaultServerID) + "; defaultServerSetted:" + defaultServerSetted);

				for (int i = 0; i < result.size(); i++) {
					ServerInfoMD si = result.get(i);
					String displayName = si.getDisplayName();
					valueMap.put(i + "", displayName);
					if ((defaultServerSetted && defaultServerID.equals(si.getServerID())) || (!defaultServerSetted && si.isDefault())) {
						defaultServerInfoArrIdx = i;
					}
				}
				serverSelectItem.setValueMap(valueMap);
				setValues(defaultServerInfoArrIdx);
				// 20110911
				ConstructorApp.skinSelectorMenu.setItems(result.getSkinsList());

				// UserName & Password from URL Parameters
				String userName = com.google.gwt.user.client.Window.Location.getParameter("app.userName");
				String pwd = com.google.gwt.user.client.Window.Location.getParameter("app.pwd");
				if (defaultServerSetted && null != userName && !"".equals(userName)) {
					userNameItem.setValue(userName);
					passItem.setValue(pwd);
					connect();
				}
			}
		});

		connectBtn = new ButtonItem("Connect");
		connectBtn.setColSpan("*");
		connectBtn.setAlign(Alignment.CENTER);

		connectBtn.addClickHandler(new com.smartgwt.client.widgets.form.fields.events.ClickHandler() {

			@Override
			public void onClick(ClickEvent event) {
				Utils.debug("connectBtn.onClick");
				connect();
			}
		});
		form.setFields(new FormItem[] { serverSelectItem, userNameItem, passItem, connectBtn });
		this.addItem(form);
		this.show();
	}

	public void connect() {
		int serverIdx = Integer.decode(serverSelectItem.getValue().toString());
		String user = null;
		String password = null;
		// if (ConstructorApp.serverInfoArr.get(serverIdx).isTransferPassToClient()) {
		user = (String) userNameItem.getValue();
		password = (String) passItem.getValue();
		// }
		Utils.debug("ConnId:" + serverSelectItem.getValue() + "; user:" + user + "; password:" + password);
		сonstructorApp.clearMenus();
		Utils.debug("Create new session...");
		// ((ServiceDefTarget)queryService).setServiceEntryPoint("/OA_HTML/constructorapp/query");
		ConnectWindow.this.setOpacity(50);
		String urlParams = com.google.gwt.user.client.Window.Location.getQueryString();
		queryService.connect(serverIdx, user, password, GWT.isScript(), urlParams, new ConnectDataCallback());
	}

	void setValues(Integer idx) {
		if (-1 != idx) {
			String pass = ConstructorApp.serverInfoArr.get(idx).getDbPassword();
			boolean isDisabled = !ConstructorApp.serverInfoArr.get(idx).isAllowUserChange();
			boolean isCustomAuth = !ConstructorApp.serverInfoArr.get(idx).isTransferPassToClient();
			// isDisabled = isDisabled && isPassDisabled;
			serverSelectItem.setValue(idx + "");
			ConstructorApp.serverInfoArr.get(idx).isTransferPassToClient();
			userNameItem.setValue(ConstructorApp.serverInfoArr.get(idx).getDbUsername());
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
			ConstructorApp.defaultTitle = ConstructorApp.serverInfoArr.get(idx).getTitle();
			ConstructorApp.setPageTitle("");
			ConstructorApp.debugEnabled = ConstructorApp.serverInfoArr.get(idx).isDebug();
		}
	}

	public void show() {
		super.show();
		super.setOpacity(100);
		passItem.focusInItem();
		// serverSelectItem.focusInItem();
		// connectBtn.focusInItem();
	}
}