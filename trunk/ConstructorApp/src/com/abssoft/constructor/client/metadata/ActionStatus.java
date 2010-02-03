package com.abssoft.constructor.client.metadata;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.Utils;
import com.google.gwt.user.client.rpc.IsSerializable;
import com.smartgwt.client.util.SC;

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

	public static void showActionStatus(ActionStatus status) {
		if (null != status) {
			String msg = status.getStatusMessage();
			// <pre></pre>
			String fullMsg = status.getStatusType().name() + ": Message from server: " + msg + "";
			if (StatusType.SUCCESS.equals(status.getStatusType())) {
				if (!"".equals(msg)) {
					Utils.debug(fullMsg);
					if (ConstructorApp.debugEnabled) {
						SC.say(fullMsg);
					}

				}
			} else {
				Utils.debug(fullMsg);
				SC.warn(fullMsg);
			}

		}
	}
}
