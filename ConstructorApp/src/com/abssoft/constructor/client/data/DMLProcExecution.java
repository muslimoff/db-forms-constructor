package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.ActionStatus;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.Row;
import com.google.gwt.core.client.GWT;
import com.smartgwt.client.util.SC;

public class DMLProcExecution {
	private MainFormPane mainFormPane;
	private Row result;

	public DMLProcExecution(MainFormPane mainFormPane) {
		this.mainFormPane = mainFormPane;
	}

	public void executeGlobal(Row oldRow, Row newRow) {
		executeGlobal(oldRow, newRow, true);
	}

	public void executeGlobal(Row oldRow, Row newRow, final Boolean showPrompt) {
		FormActionMD actMD = mainFormPane.getCurrentAction();
		QueryServiceAsync service = GWT.create(QueryService.class);
		if (showPrompt)
			SC.showPrompt("Server Connecting");
		FormInstanceIdentifier fi = mainFormPane.getInstanceIdentifier();
		service.executeDML(fi, oldRow, newRow, actMD, new DSAsyncCallback<Row>() {
			@Override
			public void onSuccess(Row result) {
				DMLProcExecution.this.setResultRow(result);
				if (showPrompt)
					SC.clearPrompt();
				result.getStatus().showActionStatus();
				if (!ActionStatus.StatusType.ERROR.equals(result.getStatus().getStatusType())) {
					executeSubProc();
				}
			}
		});
	}

	public void executeSubProc() {
		// TODO переделать FormDataSource
	}

	public void setResultRow(Row result) {
		this.result = result;
	}

	public Row getResultRow() {
		return result;
	}
}
