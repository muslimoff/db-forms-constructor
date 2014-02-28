package com.abssoft.constructor.common;

import java.util.HashMap;

import com.abssoft.constructor.common.metadata.StaticLookup;
import com.google.gwt.user.client.rpc.IsSerializable;

public class StaticLookupsArr extends HashMap<String, StaticLookup> implements
		IsSerializable, HasActionStatus {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5827636272398212201L;
	private ActionStatus status;

	@Override
	public void setStatus(ActionStatus status) {
		this.status = status;

	}

	@Override
	public ActionStatus getStatus() {
		return status;
	}
}
