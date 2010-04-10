package com.abssoft.constructor.client.data;

import java.util.LinkedHashMap;
import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSource;
import com.smartgwt.client.types.DSDataFormat;
import com.smartgwt.client.types.DSOperationType;
import com.smartgwt.client.types.DSProtocol;
import com.smartgwt.client.widgets.tree.TreeNode;

public class LookupDataSource extends DataSource {
	private String lookupCode;
	public LinkedHashMap<String, TreeNode> values = new LinkedHashMap<String, TreeNode>();
	private FormDataSourceField[] dsFields;
	TreeNode[] records;
	private int valueFieldNum = 0;
	private String lookupDisplValFld;

	public int getValueFieldNum() {
		return valueFieldNum;
	}

	public void setValueFieldNum(int valueFieldNum) {
		this.valueFieldNum = valueFieldNum;
	}

	public void setFields(FormDataSourceField[] dsFields) {
		this.dsFields = dsFields;
		super.setFields(dsFields);
	}

	public LookupDataSource(final String lookupCode, String lookupDisplValFld) {
		this.lookupCode = lookupCode;
		this.lookupDisplValFld = lookupDisplValFld;
		setDataProtocol(DSProtocol.CLIENTCUSTOM);
		setDataFormat(DSDataFormat.CUSTOM);
		setClientOnly(false);
		setAttribute("dataProtocol", "clientCustom", false);
	}

	public DSRequest transformRequest(DSRequest request, final Boolean isInitialFetch) {
		String requestId = request.getRequestId();
		DSResponse response = new DSResponse();
		response.setAttribute("clientContext", request.getAttributeAsObject("clientContext"));
		response.setStatus(0);
		if (DSOperationType.FETCH.equals(request.getOperationType())) {
			executeFetch(requestId, request, response, isInitialFetch);
		}
		return request;
	}

	@Override
	protected Object transformRequest(DSRequest request) {
		DSRequest req = transformRequest(request, false);
		return req.getData();
	}

	public void initialFetch() {
		DSRequest request = new DSRequest();
		request.setOperationType(DSOperationType.FETCH);
		transformRequest(request, true);
	}

	protected void executeFetch(final String requestId, DSRequest request, final DSResponse response, final Boolean isInitialFetch) {
		Utils.debug("ReadOnlyDataSource Fetch. Lookup:" + lookupCode);
		Map<?, ?> filterValues = (new Criteria()).getValues();
		try {
			filterValues = request.getCriteria().getValues();
		} catch (Exception e) {
			Utils.debug("Exception on request.getCriteria().getValues():" + e.getMessage());
		}
		int startRow = 0;
		int endRow = 10000;
		// TODO request.getSortBy() не работает так, как описано.
		String sortBy = null;
		try {
			if (null != lookupDisplValFld) {
				startRow = request.getStartRow();
				endRow = request.getEndRow();
			}
			sortBy = request.getAttribute("sortBy");
		} catch (Exception e) {
			Utils.debug("Exception on request.getAttribute(\"sortBy\"):" + e.getMessage());
			e.printStackTrace();
		}
		System.out.println("startRow:" + startRow + "; endRow:" + endRow);
		QueryServiceAsync service = GWT.create(QueryService.class);
		// TODO вынести в XML параметров endRow - фактически размер лова.
		service.fetch(ConstructorApp.sessionId, lookupCode, -999, sortBy, startRow, endRow, filterValues, false,
				new DSAsyncCallback<RowsArr>(requestId, response, this) {
					public void onSuccess(RowsArr result) {
						records = new TreeNode[result.size()];
						values.clear();
						Utils.debug("LookupDataSource.fetch. valueFieldNum:" + valueFieldNum + "; result.size:" + result.size());
						for (int r = 0; r < result.size(); r++) {
							try {
								Row row = result.get(r);
								records[r] = Utils.getTreeNodeFromRow(dsFields, row);
								values.put(row.get(valueFieldNum).getAttribute(), records[r]);
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						if (!isInitialFetch) {
							Utils.debug("LookupDataSource.fetch. response.setTotalRows...");
							response.setTotalRows(result.getTotalRows());
							Utils.debug("LookupDataSource.fetch. response.setData...");
							response.setData(records);
							Utils.debug("LookupDataSource.fetch. processResponse...");
							try {
								processResponse(requestId, response);
							} catch (Exception e) {
								e.printStackTrace();
							}
							Utils.debug("LookupDataSource.fetch. ended...");
						}
					}
				});
	}
}
