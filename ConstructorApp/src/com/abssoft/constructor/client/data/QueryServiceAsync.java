package com.abssoft.constructor.client.data;

import java.util.Map;

import com.abssoft.constructor.common.ConnectionInfo;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.MenusArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.ServerInfoArr;
import com.abssoft.constructor.common.StaticLookupsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.google.gwt.user.client.rpc.AsyncCallback;

public interface QueryServiceAsync {

	public void connect(int ServerIdx, String user, String password,
			boolean isScript, String urlParams, Boolean isDebugEnabled,
			AsyncCallback<ConnectionInfo> callback);

	public void relogin(int sessionID, String user, String password,
			String urlParams, AsyncCallback<Void> callback);

	public void fetch(FormInstanceIdentifier fi, String sortBy, int startRow,
			int endRow, Map<?, ?> criteria, boolean forceFetch,
			AsyncCallback<RowsArr> callback) throws TimeoutException;

	public void executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow,
			FormActionMD actMD, AsyncCallback<Row> callback);

	public void getFormMetaData(FormInstanceIdentifier fi,
			AsyncCallback<FormMD> callback);

	public void getMenusArr(int sessionId, AsyncCallback<MenusArr> callback);

	public void sessionClose(int sessionId, AsyncCallback<Void> callback);

	public void closeForm(FormInstanceIdentifier fi, FormMD formState,
			AsyncCallback<Void> callback);

	public void getStaticLookupsArr(int sessionId,
			AsyncCallback<StaticLookupsArr> callback);

	public void getServerInfoArrWithoutPassword(
			AsyncCallback<ServerInfoArr> callback);

	public void getFile(AsyncCallback<String> callback);

	public void setExportData(FormInstanceIdentifier fi, ExportData exportData,
			AsyncCallback<Integer> callback);
}
