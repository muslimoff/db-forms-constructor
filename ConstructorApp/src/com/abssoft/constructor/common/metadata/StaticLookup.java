package com.abssoft.constructor.common.metadata;

//import java.util.LinkedHashMap; Летит на клиенте с ошибкой com.google.gwt.user.client.rpc.IncompatibleRemoteServiceException
import java.util.HashMap;

import com.google.gwt.user.client.rpc.IsSerializable;

public class StaticLookup extends HashMap<String, String> implements IsSerializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -8139816440143540565L;

	public StaticLookup() {
	}

}
