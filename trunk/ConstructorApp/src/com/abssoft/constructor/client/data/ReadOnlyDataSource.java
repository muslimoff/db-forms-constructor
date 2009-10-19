package com.abssoft.constructor.client.data;

import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.types.DSDataFormat;
import com.smartgwt.client.types.DSProtocol;

/**
 * Для SQL-Lookups
 * 
 * @author User
 * 
 */
public class ReadOnlyDataSource extends DataSource {
	private String lookupCode;

	/**
	 * Creates new data source which communicates with server by GWT RPC. It is
	 * normal server side SmartClient data source with data protocol set to
	 * <code>DSProtocol.CLIENTCUSTOM</code> ("clientCustom" - natively supported
	 * by SmartClient but should be added to smartGWT) and with data format
	 * <code>DSDataFormat.CUSTOM</code>.
	 */
	public ReadOnlyDataSource(String lookupCode) {
		setLookupCode(lookupCode);
		setDataProtocol(DSProtocol.CLIENTCUSTOM);
		setDataFormat(DSDataFormat.CUSTOM);
		setClientOnly(false);
		setAttribute("dataProtocol", "clientCustom", false);
		System.out.println("ReadOnlyDataSource");
	}

	/**
	 * Executes request to server.
	 * 
	 * @param request
	 *            <code>DSRequest</code> being processed.
	 * @return <code>Object</code> data from original request.
	 */
	@Override
	protected Object transformRequest(DSRequest request) {
		String requestId = request.getRequestId();
		DSResponse response = new DSResponse();
		response.setAttribute("clientContext", request.getAttributeAsObject("clientContext"));
		// Asume success
		response.setStatus(0);
		switch (request.getOperationType()) {
		case FETCH:
			executeFetch(requestId, request, response);
			break;
		default:
			Utils.debug("Unimplemented operaion: " + request.getOperationType());
			break;
		}
		return request.getData();
	}

	/**
	 * Executed on <code>FETCH</code> operation.
	 * <code>processResponse (requestId, response)</code> should be called when
	 * operation completes (either successful or failure).
	 * 
	 * @param requestId
	 *            <code>String</code> extracted from
	 *            <code>DSRequest.getRequestId ()</code>.
	 * @param request
	 *            <code>DSRequest</code> being processed.
	 * @param response
	 *            <code>DSResponse</code>. <code>setData (list)</code> should be
	 *            called on successful execution of this method.
	 *            <code>setStatus (&lt;0)</code> should be called on failure.
	 */
	protected void executeFetch(String requestId, DSRequest request, DSResponse response) {
		System.out.println("ReadOnlyDataSource FETCH:");
		System.out.println(getLookupCode());
	}

	public void setLookupCode(String lookupCode) {
		this.lookupCode = lookupCode;
	}

	public String getLookupCode() {
		return lookupCode;
	}

}
