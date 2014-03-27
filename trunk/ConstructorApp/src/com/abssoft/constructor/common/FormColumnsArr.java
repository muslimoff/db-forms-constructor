package com.abssoft.constructor.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.google.gwt.user.client.rpc.IsSerializable;

/**
 * Содержит метаданные всех столбцов формы
 * 
 * @author User
 * 
 */
public class FormColumnsArr extends HashMap<Integer, FormColumnMD> implements
		IsSerializable, Cloneable {

	private static final long serialVersionUID = 8363157651461720532L;
	private Map<String, Integer> columnsByName = new HashMap<String, Integer>();

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

	public FormColumnsArr clone() {
		FormColumnsArr clone = new FormColumnsArr();

		Iterator<Integer> it = this.keySet().iterator();
		while (it.hasNext()) {
			Integer key = it.next();
			clone.put(key, this.get(key).clone());
		}

		return clone;
	}
}
