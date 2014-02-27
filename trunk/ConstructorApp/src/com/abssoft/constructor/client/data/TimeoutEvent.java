package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.data.TimeoutException.TimeoutType;
import com.google.gwt.event.shared.GwtEvent;

public class TimeoutEvent extends GwtEvent<TimeoutEventHandler> {

	private static Type<TimeoutEventHandler> TYPE;
	private final TimeoutType timeoutType;

	public TimeoutEvent(TimeoutType timeoutType) {
		this.timeoutType = timeoutType;
	}

	public static com.google.gwt.event.shared.GwtEvent.Type<TimeoutEventHandler> getType() {
		if (TYPE == null)
			TYPE = new Type<TimeoutEventHandler>();
		return TYPE;
	}

	@Override
	protected void dispatch(TimeoutEventHandler handler) {
		handler.onTimeout(timeoutType);
	}

	@Override
	public com.google.gwt.event.shared.GwtEvent.Type<TimeoutEventHandler> getAssociatedType() {
		return TYPE;
	}

	public TimeoutType getTimeoutType() {
		return timeoutType;
	}

}
