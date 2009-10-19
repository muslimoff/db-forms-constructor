package com.abssoft.constructor.client.metadata;

import java.util.HashMap;
import java.util.Iterator;

import com.abssoft.constructor.client.common.Constants;
import com.google.gwt.user.client.rpc.IsSerializable;

public class IconsArr extends HashMap<Integer, String> implements IsSerializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void addDefaultIconPath() {
		Iterator<Integer> iconsIterator = this.keySet().iterator();

		while (iconsIterator.hasNext()) {
			Integer i = iconsIterator.next();
			put(i, Constants.getDefaultIconPath() + get(i));
		}
	}

}
