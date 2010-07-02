package com.abssoft.constructor.client;

import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.google.gwt.core.client.GWT;
import com.google.gwt.user.client.Window;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.DataSourceField;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.fields.DataSourceBinaryField;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class TestDownloadFileClickHandler implements ClickHandler {
	Record r = new Record(JSOHelper.createObject());

	// Record r = new Record();

	public class FileDS extends GwtRpcDataSource {

		public FileDS() {
			DataSourceBinaryField fileFld = new DataSourceBinaryField("SKU");
			fileFld.setCanEdit(false);
			DataSourceField dsf = new DataSourceField("SSS", FieldType.TEXT);
			this.setFields(fileFld, dsf);
			String value = "<root/>";
			r.setAttribute("SKU", value);
			r.setAttribute("SSS", "sss");
			Record[] rr = new Record[1];
			rr[0] = r;
			this.setTestData(rr);
			setClientOnly(true);
		}

		@Override
		protected void executeFetch(String requestId, DSRequest request, DSResponse response) {
		}

		@Override
		public void viewFile(Record record) {
			// RPCManager.doCustomResponse();
			System.out.println("FileDS.viewFile");
			QueryServiceAsync service = GWT.create(QueryService.class);
			service.getFile(new DSAsyncCallback<String>() {
				public void onSuccess(String result) {
					Window.alert("FileDS.viewFile " + result);
				}
			});
		}

		@Override
		public void downloadFile(Record record) {
			System.out.println("FileDS.downloadFile");
			QueryServiceAsync service = GWT.create(QueryService.class);
			System.out.println("service:" + service);
			service.getFile(new DSAsyncCallback<String>() {
				public void onSuccess(String result) {
					Window.alert("FileDS.downloadFile " + result);
				}
			});
		}
	}

	FileDS fileDS = new FileDS();

	@Override
	public void onClick(MenuItemClickEvent event) {
		System.out.println("XXXXXXXXXXXX @1");
		// fileDS.viewFile(r);
		fileDS.downloadFile(r);
		System.out.println("XXXXXXXXXXXX @2");
	}

}
