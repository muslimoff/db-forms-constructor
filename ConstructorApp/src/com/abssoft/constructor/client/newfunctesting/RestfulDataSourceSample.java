package com.abssoft.constructor.client.newfunctesting;

/* 
 * Smart GWT (GWT for SmartClient) 
 * Copyright 2008 and beyond, Isomorphic Software, Inc. 
 * 
 * Smart GWT is free software; you can redistribute it and/or modify it 
 * under the terms of the GNU Lesser General Public License version 3 
 * as published by the Free Software Foundation.  Smart GWT is also 
 * available under typical commercial license terms - see 
 * http://smartclient.com/license 
 * 
 * This software is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of 
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU 
 * Lesser General Public License for more details. 
 */

import com.smartgwt.client.data.OperationBinding;
import com.smartgwt.client.data.RestDataSource;
import com.smartgwt.client.data.fields.DataSourceTextField;
import com.smartgwt.client.types.DSOperationType;
import com.smartgwt.client.types.DSProtocol;
import com.smartgwt.client.widgets.Window;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.layout.VLayout;

public class RestfulDataSourceSample extends Window {

	public RestfulDataSourceSample() {

		VLayout layout = new VLayout(15);
		layout.setAutoHeight();

		RestDataSource formDS = new RestDataSource();
		OperationBinding fetch = new OperationBinding();
		fetch.setOperationType(DSOperationType.FETCH);
		fetch.setDataProtocol(DSProtocol.POSTMESSAGE);
		formDS.setOperationBindings(fetch);

		DataSourceTextField formCode = new DataSourceTextField("FORM_CODE", "FormCode");
		formCode.setPrimaryKey(true);
		formCode.setCanEdit(false);
		DataSourceTextField formName = new DataSourceTextField("FORM_NAME", "FormName");
		DataSourceTextField formSQL = new DataSourceTextField("SQL_TEXT", "SQL");

		formDS.setFields(formCode, formName, formSQL);
		formDS.setFetchDataURL("http://vm_xe:8080/oradb/FC22/FORMS");

		final ListGrid formGrid = new ListGrid();
		formGrid.setWidth(500);
		formGrid.setHeight(224);
		formGrid.setDataSource(formDS);
		formGrid.setEmptyCellValue("--");

		formGrid.setSortField(0);
		formGrid.setDataPageSize(50);
		formGrid.setAutoFetchData(true);
		layout.addMember(formGrid);
		this.addItem(layout);
		this.show();
	}
}