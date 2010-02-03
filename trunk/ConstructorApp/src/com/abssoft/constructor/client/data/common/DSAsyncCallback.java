package com.abssoft.constructor.client.data.common;

import com.abssoft.constructor.client.data.Utils;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.rpc.RPCResponse;
import com.smartgwt.client.util.SC;
import com.google.gwt.user.client.rpc.AsyncCallback;

/**
 * Реализация интерфейса <code>AsyncCallback<T></code> с реализованным методом
 * <code>onFailure</code> и абстрактным методом <code>onSuccess</code>
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
	}

	/**
	 * Конструктор c параметрами из DataSource
	 * 
	 * @param requestId
	 * @param response
	 * @param dataSource
	 */
	public DSAsyncCallback(String requestId, DSResponse response,
			DataSource dataSource) {
		super();
		this.requestId = requestId;
		this.response = response;
		this.dataSource = dataSource;
	}

	public void onFailure(Throwable caught) {
		String details = caught.getMessage();
		Window.alert("Ашипка: " + details);
		SC.logWarn("Ашипка2: " + details);
		caught.printStackTrace();
		SC.logWarn("Ашипка3: " + caught.toString());
		// for (String s : caught.getStackTrace())
		if (null != dataSource) {
			response.setStatus(RPCResponse.STATUS_FAILURE);
			dataSource.processResponse(requestId, response);
		}

	}

	public abstract void onSuccess(T result);

}
