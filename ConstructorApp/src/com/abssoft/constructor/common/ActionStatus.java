package com.abssoft.constructor.common;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.DMLProcExecution;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.google.gwt.user.client.rpc.IsSerializable;

public class ActionStatus implements IsSerializable {

	public enum StatusType {
		ERROR("2"), SUCCESS("0"), WARNING("1"), CANCEL("3");
		private String value;

		StatusType(String value) {
			this.value = value;

		}

		public String getValue() {
			return this.value;
		}
	}

	private String longMessageText = "";
	private StatusType statusType = StatusType.SUCCESS;
	private String warnMsg = "";
	private Integer warnButtonIdx = -1;

	public ActionStatus() {
	}

	public ActionStatus(String longMessageText, StatusType statusType) {
		this.setLongMessageText(longMessageText);
		this.setStatusType(statusType);
	}

	public String getLongMessageText() {
		return longMessageText;
	}

	public StatusType getStatusType() {
		return statusType;
	}

	public String getWarnMsg() {
		return warnMsg;
	}

	public void setLongMessageText(String longMessageText) {
		this.longMessageText = longMessageText;
	}

	public void setStatusType(StatusType statusType) {
		this.statusType = statusType;
	}

	public void setWarnMsg(String warnMsg) {
		this.warnMsg = warnMsg;
	}

	public void showActionStatus() {
		showActionStatus(null);
	}

	public void showActionStatus(DMLProcExecution dmlData) {
		ActionStatus status = this;
		if (null != status) {
			String msg = status.getLongMessageText();
			String statusName = status.getStatusType().name();
			String fullMsg = ": Message from server:\n" + msg;
			// String shortMsg = (fullMsg.length() > 100) ? fullMsg.substring(0, 100) : fullMsg;
			String shortMsg = (msg.length() > 100) ? msg.substring(0, 100) : msg;
			if (StatusType.SUCCESS.equals(status.getStatusType()) || StatusType.CANCEL.equals(status.getStatusType())) {
				if (!"".equals(msg) && ConstructorApp.debugEnabled) {
					// System.out.println(fullMsg);
					ActionStatusWindow.createActionStatusWindow(statusName, shortMsg, fullMsg, status.getStatusType(), dmlData, "OK");
				}
			} else if (StatusType.WARNING.equals(status.getStatusType())) {
				String warnMsg = status.getWarnMsg();
				String[] strArr = warnMsg.split("`");
				int btnsCnt = strArr.length - 1;
				String[] btns = new String[btnsCnt];
				System.arraycopy(strArr, 1, btns, 0, btnsCnt);
				ActionStatusWindow.createActionStatusWindow(statusName, strArr[0], fullMsg, status.getStatusType(), dmlData, btns);
			} else if (StatusType.ERROR.equals(status.getStatusType())) {
				// TODO Поведение для STATUS=Error ваще другое...
				// ...
				String[] strArr = msg.replaceAll("ORA-[0-9]{5}:", "`").split("`");
				// TODO - длинный текст ошибки все равно. Потому что
				shortMsg = (msg.length() > 200) ? msg.substring(0, 200) : msg;
				shortMsg = (2 > strArr.length) ? msg : strArr[1];

				shortMsg = ((null == shortMsg || "".equals(shortMsg)) && strArr.length >= 3) ? strArr[2] : shortMsg;

				shortMsg = (shortMsg.length() > 200) ? shortMsg.substring(0, 200) : shortMsg;
				ActionStatusWindow.createActionStatusWindow(statusName, shortMsg, fullMsg, status.getStatusType(), dmlData, "Cancel");
			}
			// if (StatusType.CANCEL.equals(status.getStatusType())) { }
			else // CANCEL
			{
				Utils.debugAlert("!!!UUU!!! " + status.getStatusType());
			}
		}

	}

	public void setWarnButtonIdx(Integer warnButtonIdx) {
		this.warnButtonIdx = warnButtonIdx;
	}

	public void setWarnButtonIdx(String warnButtonIdx) {
		System.out.println(">>>> " + warnButtonIdx);
		this.warnButtonIdx = (null == warnButtonIdx) ? null : Integer.valueOf(warnButtonIdx);
	}

	public Integer getWarnButtonIdx() {
		return warnButtonIdx;
	}
}
