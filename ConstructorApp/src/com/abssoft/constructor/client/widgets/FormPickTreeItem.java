package com.abssoft.constructor.client.widgets;

import java.util.Map;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.QueryServiceAsync;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.data.common.GwtRpcDataSource;
import com.abssoft.constructor.client.form.FormColumns;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.widgets.form.fields.IPickTreeItem;
import com.smartgwt.client.widgets.tree.TreeNode;

public class FormPickTreeItem extends IPickTreeItem {
	String lookupCode;
	TreeNode[] records;
	private int valueFieldNum = 0;

	class PickDataSource extends GwtRpcDataSource {

		FormDataSourceField[] dsFields;

		public void setFields(FormDataSourceField[] dsFields) {
			this.dsFields = dsFields;
			super.setFields(dsFields);
		}

		@Override
		protected void executeFetch(final String requestId, DSRequest request, final DSResponse response) {
			Utils.debug("PickDataSource Fetch. Lookup:" + lookupCode);
			Map<?, ?> filterValues = (new Criteria()).getValues();
			try {
				filterValues = request.getCriteria().getValues();
			} catch (Exception e) {
				Utils.debug("Exception on request.getCriteria().getValues():" + e.getMessage());
			}
			int startRow = 0;
			int endRow = 10000;
			String sortBy = request.getAttribute("sortBy");
			QueryServiceAsync service = GWT.create(QueryService.class);
			service.fetch(ConstructorApp.sessionId, lookupCode, -999, sortBy, startRow, endRow, filterValues, false,
					new DSAsyncCallback<RowsArr>(requestId, response, this) {
						public void onSuccess(RowsArr result) {
							records = new TreeNode[result.size()];
							Utils.debug("PickDataSource. valueFieldNum:" + valueFieldNum + "; result.size:" + result.size());
							for (int r = 0; r < result.size(); r++) {
								try {
									Row row = result.get(r);
									records[r] = Utils.getTreeNodeFromRow(dsFields, row);
								} catch (Exception e) {
									e.printStackTrace();
								}
							}
							response.setTotalRows(result.getTotalRows());
							response.setData(records);
							try {
								processResponse(requestId, response);
							} catch (Exception e) {
								e.printStackTrace();
							}
							Utils.debug("PickDataSource.fetch. ended...");
						}
					});
		}
	}

	public FormPickTreeItem(FormColumnMD columnMD, final MainFormPane mainFormPane) {
		this(columnMD, mainFormPane, null);
	}

	public FormPickTreeItem(FormColumnMD columnMD, final MainFormPane mainFormPane, final FormTreeGridField formTreeGridField) {
		this.lookupCode = columnMD.getLookupCode();
		FormMD fmd = mainFormPane.getFormMetadata().getLookupsArr().get(lookupCode);
		Utils.debug("PickDataSource ******** " + fmd.getFormName());
		final MainFormPane mfp = new MainFormPane();
		mfp.setFormCode(lookupCode);
		mfp.setFormMetadata(fmd);
		mfp.setFormColumns(new FormColumns(mfp));
		PickDataSource ds = new PickDataSource();
		ds.setFields(mfp.getFormColumns().createDSFields());
		// this.setValueField("ID");
		// this.setDisplayField(mfp.getFormColumns().getDataSourceFields()[0].getColumnMD().getName());
		this.setDataSource(ds);
		//this.setFetchMissingValues(true);
	}
}
