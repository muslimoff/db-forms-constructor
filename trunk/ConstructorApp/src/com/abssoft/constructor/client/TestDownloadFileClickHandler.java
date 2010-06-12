package com.abssoft.constructor.client;

import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.data.fields.DataSourceBinaryField;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.menu.events.ClickHandler;
import com.smartgwt.client.widgets.menu.events.MenuItemClickEvent;

public class TestDownloadFileClickHandler implements ClickHandler {
	Record r = new Record(JSOHelper.createObject());

	// Record r = new Record();

	public class FileDS extends GwtRpcDataSource {

		public FileDS() {
			DataSourceBinaryField fileFld = new DataSourceBinaryField("SKU");
			this.setFields(fileFld);
			String value = "<root/>";
			r.setAttribute("SKU", value);
			Record[] rr = new Record[1];
			rr[0] = r;
			this.setTestData(rr);
			setClientOnly(true);
		}

		@Override
		protected void executeFetch(String requestId, DSRequest request, DSResponse response) {
		}

	}

	FileDS fileDS = new FileDS();

	@Override
	public void onClick(MenuItemClickEvent event) {
		System.out.println("XXXXXXXXXXXX @1");
		fileDS.viewFile(r);
		System.out.println("XXXXXXXXXXXX @2");
	}

}
