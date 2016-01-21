package com.abssoft.constructor.client.data;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.data.common.DSAsyncCallback;
import com.abssoft.constructor.client.form.MainForm.FormTreeGrid;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.ActionStatus.StatusType;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.smartgwt.client.data.DSRequest;
import com.smartgwt.client.data.DSResponse;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.rpc.RPCResponse;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

public class DMLProcExecution {
	public enum ExecutionType {
		/* Добавление записи */
		ADD("Add"),
		/* Изменение записи */
		UPDATE("Update"),
		/* Удаление записи */
		DELETE("Delete");
		private String value;

		ExecutionType(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	private MainFormPane mainFormPane;
	private DSRequest request;
	private DSResponse response;
	private Row result;
	private TreeNode resultRecord;
	private FormDataSource formDataSource;
	private ExecutionType executionType;
	private int recordIndex = -1;
	protected ListGrid grid;

	public MainFormPane getMainFormPane() {
		return mainFormPane;
	}

	public DMLProcExecution(ExecutionType executionType, FormDataSource formDataSource, MainFormPane mainFormPane,
			DSRequest request, DSResponse response) {
		this.mainFormPane = mainFormPane;
		this.request = request;
		this.response = response;
		this.formDataSource = formDataSource;
		this.executionType = executionType;
		this.grid = mainFormPane.getMainForm().getTreeGrid();

		this.recordIndex = formDataSource.getEditedRecordIndex(); // grid.getRecordIndex(listGridRec);
		Utils.debug("DMLProcExecution.this. recordIndex:" + recordIndex);
	}

	// Для вызова вне DataSource.
	// См.:
	// com.abssoft.constructor.client.form.MainForm.setNewRecDefaultValues(final
	// int rowNum, boolean isFromDefaultVals)
	public DMLProcExecution(MainFormPane mainFormPane) {
		this(ExecutionType.UPDATE, mainFormPane.getDataSource(), mainFormPane, new DSRequest(), new DSResponse());
	}

	public void executeGlobal(Row oldRow, Row newRow) {
		executeGlobal(oldRow, newRow, true);
	}

	public void executeGlobal(Row oldRow, Row newRow, final Boolean showPrompt) {
		formDataSource.setEditedRecordIndex(-1); // 20120319 сброс редактируемой
													// записи
		FormActionMD actMD = mainFormPane.getCurrentAction();
		if (showPrompt)
			SC.showPrompt("Server Connecting");
		FormInstanceIdentifier fi = mainFormPane.getInstanceIdentifier();

		Utils.createQueryService("DMLProcExecution.executeDML").executeDML(fi, oldRow, newRow, actMD,
				new DSAsyncCallback<Row>() {
					@Override
					public void onSuccess(Row result) {
						super.onSuccess(result);
						DMLProcExecution.this.setResultRow(result);
						// 20110729b - добавлена типизация и вынесен глобально
						// код для response.setData
						TreeNode resRec = Utils.getTreeNodeFromRow(formDataSource.getFormDSFields(), result);
						// We do not receive removed record from server. Return
						// record from request.
						resRec = ExecutionType.DELETE.equals(executionType) ? new TreeNode(request.getData()) : resRec;
						// Очищаем код нажатой кнопки для повторного выполнения
						resRec.setAttribute(mainFormPane.getCurrentAction().getStatusButtonParam(), (String) null);

						// 20120317
						// if (!resRec.toMap().containsKey("_recIdx")) {
						// resRec.setAttribute("_recIdx", recordIndex);
						// }
						Utils.debugRecord(resRec, "DmlProcExecution.SUCCESS1");
						setResultRecord(resRec);
						response.setData(new TreeNode[] { resRec });
						Utils.debug("DmlProcExecution.SUCCESS2A" + grid.getRecordIndex(resRec));
						Utils.debugRecord(resRec, "DmlProcExecution.SUCCESS2B");
						// 20110729e
						if (showPrompt) {
							SC.clearPrompt();
						}
						result.getStatus().showActionStatus(DMLProcExecution.this);
						// DMLProcExecution.this.showActionStatus(result.getStatus());
						StatusType resStatus = result.getStatus().getStatusType();
						Utils.debug("DMLProcExecution.executeDML. StatusType:" + resStatus);
						if (ActionStatus.StatusType.SUCCESS.equals(resStatus) // Успешно
						) {
							Utils.debug("DMLProcExecution.executeDML. Before executeSuccessSubProc.");
							executeSuccessSubProc();
							Utils.debug("DMLProcExecution.executeDML. After executeSuccessSubProc.");
						} else if (ActionStatus.StatusType.WARNING.equals(resStatus)) {
							executeWarningSubProc();
						} else if (ActionStatus.StatusType.CANCEL.equals(resStatus)) {
							executeErrorSubProc(); // Окошко не показываем,
													// однако не сохраняем
													// изменения. См
													// ActionStatus.showActionStatus
						} else if (ActionStatus.StatusType.ERROR.equals(resStatus)) {
							executeErrorSubProc();
						} else {
							Utils.debugAlert("Unknown Action status!!! DMLProcExecution.executeDML");
						}
						// Пока только для апдейта - фильтрация дочерних форм.
						if (ExecutionType.UPDATE.equals(executionType)) {
							// grid.selectRecord(recordIndex);
							// mainFormPane.filterDetailData(grid.getRecord(recordIndex),
							// grid, recordIndex);
							int mfpSelectedRec = mainFormPane.getSelectedRow();
							ListGridRecord selectedRec = grid.getRecord(mfpSelectedRec);
							Utils.debug("DMLProcExecution.executeDML.onSuccess.UPDATE. mfpSelectedRec:" + mfpSelectedRec
									+ "; selectedRec:" + selectedRec);
							try {
								if (null != selectedRec) {
									grid.selectRecord(selectedRec);
									int selectedRecIdx = grid.getRecordIndex(selectedRec);
									Utils.debug(
											"DMLProcExecution.executeDML.onSuccess.UPDATE. Before mainFormPane.filterDetailData");
									mainFormPane.filterDetailData(selectedRec, grid, selectedRecIdx);
								}
							} catch (Exception e) {
								e.printStackTrace();
								Utils.logException(e, "DMLProcExecution.executeDML.onSuccess. grid.selectRecord...");
							}
						}

					}
				});
	}

	public void executeSuccessSubProc() {
		Utils.debug("DMLProcExecution.executeSuccessSubProc1");
		int rowsAdded = 0;
		if (ExecutionType.ADD.equals(executionType)) {
			rowsAdded = 1;
		} else if (ExecutionType.DELETE.equals(executionType)) {
			rowsAdded = -1;
		} else if (ExecutionType.UPDATE.equals(executionType)) {
			rowsAdded = 0;
		}
		String requestId = request.getRequestId();
		Utils.debug("DMLProcExecution... response.getStatus " + response.getStatus());

		// 20160119 - убрал текст ниже - решил проблему правильно. См
		// .http://forums.smartclient.com/forum/smart-gwt-technical-q-a/22607-help-in-listgrid-client-sort
		
		response.setStatus(RPCResponse.STATUS_SUCCESS);

		// 20130514 - обнаружнен косяк - при создании новой записи - сброс
		// сортировки в гриде
		// SortSpecifier[] sort = grid.getSort();
		// String sortState = grid.getSortState();
		// Utils.debugAlert("1sortState:" + sortState + "; sort:" + sort);

		formDataSource.processResponse(requestId, response);

		// 20130514 - обнаружнен косяк - при создании новой записи - сброс
		// сортировки в гриде
		if (ExecutionType.ADD.equals(executionType)) {
			grid.setSortState(mainFormPane.getSortState());
			// Utils.debugAlert("1sortState:" + grid.getSortState());

		}

		// Почему-то после предупреждения остается состояние редактирования.
		// Приходится делать так для корректной работы
		grid.discardAllEdits(new int[] { recordIndex }, false);
		// 20130727 Для дерева - выделяется следующая запись после перенесенной
		// (есть подозрение, что из-за строки выше.
		// Поэтому - очищаем все выделенные строки во избежание ошибочных
		// перетаскиваний
		if (ExecutionType.UPDATE.equals(executionType) && grid instanceof FormTreeGrid) {
			grid.deselectAllRecords();
		}

		formDataSource.setTotalRows(formDataSource.getTotalRows() + rowsAdded);
		mainFormPane.getMainForm().getBottomToolBar().setRowsCount(formDataSource.getTotalRows() + "");
		Utils.debug("DMLProcExecution.executeSuccessSubProc2");

		FormActionMD formActionMD = mainFormPane.getCurrentAction();
		// В случае наличия ActionURL - открываем ее.
		Utils.openURL(formActionMD, resultRecord, mainFormPane);

		// Вызов подчиненных действий
		if (null != formActionMD.getCode()) {
			for (FormActionMD act : mainFormPane.getFormMetadata().getActions()) {
				Utils.debug("formActionMD:" + formActionMD);
				Utils.debug("formActionMD.getCode():" + formActionMD.getCode());
				Utils.debug("act.getParentActionCode():" + act.getParentActionCode());
				if (null != act.getParentActionCode() && formActionMD.getCode().equals(act.getParentActionCode())) {
					mainFormPane.getButtonsToolBar().actionItemsMap.get(act.getCode()).doActionWithConfirm(recordIndex);
				}
			}
		}
	};

	/* 20120312. Функция getErrors: - См. файл TODO, ошибка 20120312№2. */
	// // lGrid.setFieldError(1, "MESSAGE", "!!!!!!!!!eeeerrrooorrr");
	// TODO Хороший вариант для возвращения пользовательских ошибок валидации:
	// lGrid.setRowErrors(rowNum, errors)
	// HashMap hm = new HashMap();
	// hm.put("MESSAGE", "???????eeeerrrooorrr");
	// response.setErrors(hm);
	private static LinkedHashMap<String, String> getErrors(Row result, FormDataSource formDataSource) {

		LinkedHashMap<String, String> errMap = new LinkedHashMap<String, String>();
		String firsFieldName = formDataSource.getFieldNames()[0];
		errMap.put(firsFieldName, result.getStatus().getLongMessageText());
		return errMap;
	}

	public void executeWarningSubProc() {
		Utils.debug("DMLProcExecution.executeWarningSubProc:\n" + result.getStatus().getLongMessageText());
		/*--*/
		request.setWillHandleError(true);
		// /20121005/
		setSQLReturnedValues(); // для типа действий 2?
		response.setStatus(RPCResponse.STATUS_FAILURE);
		response.setErrors(getErrors(result, formDataSource));
		// /20121005/
		formDataSource.processResponse(request.getRequestId(), response);
		/*--*/
		// Вывод значений,которые вернулись из PL/SQL процедуры.
		// Вместо processResponse, которое не отображает этих данных для
		// неуспешных статусов
		// Тут копать!
		// setSQLReturnedValues();

	};

	public void executeErrorSubProc() {
		Utils.debug("DMLProcExecution.executeErrorSubProc:\n" + result.getStatus().getLongMessageText());
		request.setWillHandleError(true);
		if ( // 20130520 - RaiseApplicationError - сброс состояния как будто не
				// удаляли
		ExecutionType.DELETE.equals(executionType)) {
			Record r = new Record();
			JSOHelper.apply(request.getData(), r.getJsObj());
			// response.setStatus(RPCResponse.STATUS_SUCCESS);
			response.setStatus(RPCResponse.STATUS_FAILURE);
			response.setData(r);
			formDataSource.processResponse(request.getRequestId(), response);

		} else {
			setSQLReturnedValues();
			response.setStatus(RPCResponse.STATUS_FAILURE);
			response.setErrors(getErrors(result, formDataSource));
			formDataSource.processResponse(request.getRequestId(), response);
		}

		// Вывод значений,которые вернулись из PL/SQL процедуры.
		// Вместо processResponse, которое не отображает этих данных для
		// неуспешных статусов
		// Тут копать!
		// setSQLReturnedValues();
	};

	private void setSQLReturnedValues() {
		grid.setEditValues(recordIndex, Utils.getMapFromRow(formDataSource.getFormDSFields(), getResultRow()));
	}

	public void setResultRow(Row result) {
		this.result = result;
	}

	public Row getResultRow() {
		return result;
	}

	public void setResultRecord(TreeNode resultRecord) {
		this.resultRecord = resultRecord;
	}

	public TreeNode getResultRecord() {
		return resultRecord;
	}

	public void setExecutionType(ExecutionType executionType) {
		this.executionType = executionType;
	}

	public ExecutionType getExecutionType() {
		return executionType;
	}

	// public void setRecordIndex(int recordIndex) {
	// this.recordIndex = recordIndex;
	// }
	//
	public int getRecordIndex() {
		return recordIndex;
	}

	// Обработка нажатия кнопки действия при предупреждении
	public void processActionStatusWindow(StatusType statusType, int btnIdx) {

		FormActionMD fAct = mainFormPane.getCurrentAction();
		if (StatusType.WARNING.equals(statusType)) {
			// Устанвливаем код нажатой кнопки
			Utils.debug("recordIndex:" + recordIndex + "; fAct.getStatusButtonParam():" + fAct.getStatusButtonParam()
					+ ";btnIdx:" + btnIdx);
			grid.setEditValue(recordIndex, fAct.getStatusButtonParam(), btnIdx);
			mainFormPane.getButtonsToolBar().actionItemsMap.get(fAct.getCode()).doActionWithConfirm(recordIndex);
		} else if (StatusType.SUCCESS.equals(statusType)) {
		} else if (StatusType.ERROR.equals(statusType)) {
		}
	}

	// public void showActionStatus(ActionStatus status) {
	// // ActionStatus status = this;
	// if (null != status) {
	// String msg = status.getLongMessageText();
	// String statusName = status.getStatusType().name();
	// String fullMsg = ": Message from server:\n" + msg;
	// // String shortMsg = (fullMsg.length() > 100) ? fullMsg.substring(0, 100)
	// : fullMsg;
	// String shortMsg = (msg.length() > 100) ? msg.substring(0, 100) : msg;
	// if (StatusType.SUCCESS.equals(status.getStatusType())) {
	// if (!"".equals(msg) && ConstructorApp.debugEnabled) {
	// System.out.println(fullMsg);
	// ActionStatusWindow.createActionStatusWindow(statusName, shortMsg,
	// fullMsg, status.getStatusType(), this, "OK");
	// }
	// } else if (StatusType.WARNING.equals(status.getStatusType())) {
	// String warnMsg = status.getWarnMsg();
	// String[] strArr = warnMsg.split("`");
	// int btnsCnt = strArr.length - 1;
	// String[] btns = new String[btnsCnt];
	// System.arraycopy(strArr, 1, btns, 0, btnsCnt);
	// ActionStatusWindow.createActionStatusWindow(statusName, strArr[0],
	// fullMsg, status.getStatusType(), this, btns);
	// } else {
	// String[] strArr = msg.replaceAll("ORA-[0-9]{5}:", "`").split("`");
	// // TODO - длинный текст ошибки все равно. Потому что
	// shortMsg = (msg.length() > 200) ? msg.substring(0, 200) : msg;
	// shortMsg = (2 > strArr.length) ? msg : strArr[1];
	//
	// shortMsg = (shortMsg.length() > 200) ? shortMsg.substring(0, 200) :
	// shortMsg;
	// ActionStatusWindow.createActionStatusWindow(statusName, shortMsg,
	// fullMsg, status.getStatusType(), this, "Cancel");
	// }
	// }
	//
	// }
}
