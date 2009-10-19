package com.abssoft.constructor.server;

import java.util.Iterator;
import java.util.Map;

import com.abssoft.constructor.client.data.common.Row;

import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.driver.OracleParameterMetaData;

public class Utils {
	public static void debug(String text) {
		//
		System.out.println(text);
	}

	public static void debug(String text, Row row) {
		debug(text);
		row.setServerMessage(row.getServerMessage() + "\n" + text);

	}

	public static void setStringParameterValue(OraclePreparedStatement statement, String name, String value) {
		try {
			statement.setStringAtName(name, value);
			Utils.debug(name + " => '" + value + "'");
		} catch (java.sql.SQLException e) {
		}
	}

	public static void setFilterValues(OraclePreparedStatement statement, Map<?, ?> filterValues) {
		try {
			// Устанавливаем принудительно все параметры в null. В дальнейшем -
			// что смогем заполнить - то заполним,
			// остальные так и останутся незаполненными...
			OracleParameterMetaData md = (OracleParameterMetaData) statement.getParameterMetaData();
			for (int i = 1; i <= md.getParameterCount(); i++) {
				statement.setString(i, "");
				// System.out.println("OracleParameterMetaData: param(" + i +
				// ") = " + md);
			}
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		// Вывод значений фильтров... и их установка... по возможности
		Iterator<?> it = filterValues.keySet().iterator();
		while (it.hasNext()) {
			String mapKey = (String) it.next();
			String value = (String) filterValues.get(mapKey);
			Utils.setStringParameterValue(statement, mapKey.toLowerCase(), value);
			Utils.debug("filterValues: " + mapKey + "=" + value);
		}
	}

}
