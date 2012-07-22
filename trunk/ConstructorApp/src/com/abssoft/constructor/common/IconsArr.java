package com.abssoft.constructor.common;

import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

public class IconsArr extends HashMap<Integer, String> implements IsSerializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void put(int iconId, String iconFileName, String iconPath, boolean isScript) {
		iconPath = (null != iconPath) ? (iconPath + "/") : "[ISOMORPHIC]/resources/icons/";
		this.put(iconId, iconPath + iconFileName);

	}
}
