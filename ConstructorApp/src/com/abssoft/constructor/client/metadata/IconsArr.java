package com.abssoft.constructor.client.metadata;

import java.util.HashMap;

import com.abssoft.constructor.client.common.Constants;
import com.google.gwt.user.client.rpc.IsSerializable;

public class IconsArr extends HashMap<Integer, String> implements IsSerializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void put(int iconId, String iconFileName, String iconPath, boolean isScript) {
		String iconDefaultPath = isScript ? Constants.webIconURL : Constants.hostedIconURL;
		iconPath = (null != iconPath) ? (iconPath + "/") : iconDefaultPath;
		this.put(iconId, iconPath + iconFileName);
	}
}
