package com.abssoft.constructor.client.app;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.rpc.AsyncCallback;

public class ReloginWindow extends ConnectWindow {

	private boolean opened = false;

	private static ReloginWindow rw;

	public static ReloginWindow getInstance() {
		if (rw == null)
			rw = new ReloginWindow();
		return rw;
	}

	public ReloginWindow() {
		super(null);
	}

	@Override
	public void connect() {
		String user = (String) userNameItem.getValue();
		String password = (String) passItem.getValue();
		setOpacity(50);
		String urlParams = com.google.gwt.user.client.Window.Location
				.getQueryString();
		Utils.createQueryService("ConnectWindow.connect").relogin(
				ConstructorApp.sessionId, user, password, urlParams,
				new AsyncCallback<Void>() {

					@Override
					public void onSuccess(Void v) {
						ReloginWindow.this.hide();
						ReloginWindow.this.opened = false;
					}

					@Override
					public void onFailure(Throwable caught) {
						ReloginWindow.this.setOpacity(100);
						Window.alert(caught.getMessage());
						// ReloginWindow.this.opened = false;
					}
				});
	}

	@Override
	public void show() {
		if (!opened)
			super.show();
		opened = true;
	}
	@Override
	public void hide() {
		opened = false;
		super.hide();
	}
}
