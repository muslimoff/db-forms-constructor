package com.abssoft.constructor.client.metadata;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.google.gwt.user.client.rpc.IsSerializable;

public class ActionStatus implements IsSerializable {

	public enum StatusType {
		/* Успешно */
		SUCCESS("0"),
		/* Предупреждение */
		WARNING("1"),
		/* Ошибка */
		ERROR("2");
		private String value;

		StatusType(String value) {
			this.value = value;
		}

		public String getValue() {
			return this.value;
		}
	}

	private String statusMessage = "";
	private StatusType statusType = StatusType.SUCCESS;

	public ActionStatus() {
	}

	public ActionStatus(String statusMessage, StatusType statusType) {
		this.setStatusMessage(statusMessage);
		this.setStatusType(statusType);
	}

	public void setStatusMessage(String statusMessage) {
		this.statusMessage = statusMessage;
	}

	public String getStatusMessage() {
		return statusMessage;
	}

	public void setStatusType(StatusType statusType) {
		this.statusType = statusType;
	}

	public StatusType getStatusType() {
		return statusType;
	}

	public void showActionStatus() {
		ActionStatus status = this;
		if (null != status) {
			String msg = status.getStatusMessage();
			String statusName = status.getStatusType().name();
			String fullMsg = ": Message from server:\n" + msg;
			// String shortMsg = (fullMsg.length() > 100) ? fullMsg.substring(0, 100) : fullMsg;
			String shortMsg = (msg.length() > 100) ? msg.substring(0, 100) : msg;

			if (StatusType.SUCCESS.equals(status.getStatusType())) {
				if (!"".equals(msg)) {
					if (ConstructorApp.debugEnabled) {
						System.out.println(fullMsg);
						ActionStatusWindow.createActionStatusWindow(statusName, shortMsg, fullMsg, status.getStatusType());
					}
				}
			} else {
				ActionStatusWindow.createActionStatusWindow(statusName, shortMsg, fullMsg, status.getStatusType());
			}
		}

	}
}
