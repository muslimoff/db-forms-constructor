package com.abssoft.constructor.client.metadata;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ServerInfoArr extends ArrayList<ServerInfoMD> implements IsSerializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -282158044607740099L;

	private LinkedHashMap<String, String> skinsList = new LinkedHashMap<String, String>();

	public void setSkinsList(LinkedHashMap<String, String> skinsList) {
		this.skinsList = skinsList;
	}

	public LinkedHashMap<String, String> getSkinsList() {
		return skinsList;
	}

}
