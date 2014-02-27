package com.abssoft.constructor.server;

import java.util.Iterator;
import java.util.concurrent.ConcurrentMap;

public class TimeoutChecker implements Runnable {
	private final ConcurrentMap<Integer, Session> sessionData;

	public TimeoutChecker(ConcurrentMap<Integer, Session> sessionData) {
		this.sessionData = sessionData;
	}

	@Override
	public void run() {
		Iterator<Session> iter = sessionData.values().iterator();
		while (!Thread.interrupted() && iter.hasNext()) {
			iter.next().releaseTimedout();
		}
	}
}
