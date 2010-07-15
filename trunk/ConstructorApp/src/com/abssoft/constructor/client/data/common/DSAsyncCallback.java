package com.abssoft.constructor.client.data.common;

import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.rpc.AsyncCallback;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.rpc.RPCResponse;
import com.smartgwt.client.util.SC;

/**
 * Реализация интерфейса <code>AsyncCallback<T></code> с реализованным методом <code>onFailure</code> и абстрактным методом
 * <code>onSuccess</code>
 * 
 * @author User
 * 
 * @param <T>
 */
public abstract class DSAsyncCallback<T> implements AsyncCallback<T> {
	private String requestId;
	private DSResponse response;
	private DataSource dataSource;

	/**
	 * Конструктор без параметров - использовать при работе без DataSource
	 * 
	 */
	public DSAsyncCallback() {
		Utils.debug("DSAsyncCallback.CreateInstance");
		// SC.clearPrompt();
		// SC.showPrompt("Server Connecting");
	}

	/**
	 * Конструктор c параметрами из DataSource
	 * 
	 * @param requestId
	 * @param response
	 * @param dataSource
	 */
	public DSAsyncCallback(String requestId, DSResponse response, DataSource dataSource) {
		this();
		this.requestId = requestId;
		this.response = response;
		this.dataSource = dataSource;
	}

	public void onFailure(Throwable caught) {
		SC.clearPrompt();
		String details = caught.getMessage();
		String errCode = "Internal Error[GWT600]!";
		try {
			ActionStatusWindow.createActionStatusWindow(errCode, caught.toString(), Utils.getExceptionStack(caught));
		} catch (Exception e) {
			Window.alert(errCode + details);
		}
		caught.printStackTrace();
		if (null != dataSource) {
			response.setStatus(RPCResponse.STATUS_FAILURE);
			dataSource.processResponse(requestId, response);
		}

	}

	public abstract void onSuccess(T result);

}
