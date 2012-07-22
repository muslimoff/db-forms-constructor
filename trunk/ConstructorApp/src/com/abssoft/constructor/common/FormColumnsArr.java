package com.abssoft.constructor.common;

import java.util.HashMap;

import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Содержит метаданные всех столбцов формы
 * 
 * @author User
 * 
 */
public class FormColumnsArr extends HashMap<Integer, FormColumnMD> implements IsSerializable {

	private static final long serialVersionUID = 8363157651461720532L;
	private HashMap<String, Integer> columnsByName = new HashMap<String, Integer>();

	@Override
	public FormColumnMD put(Integer key, FormColumnMD value) {
		super.put(key, value);
		columnsByName.put(value.getName(), key);
		return value;
	}

	public Integer getColIndex(String colName) {
		return columnsByName.get(colName);
	}

	public FormColumnMD get(String colName) {
		return this.get(getColIndex(colName));
	}

}
