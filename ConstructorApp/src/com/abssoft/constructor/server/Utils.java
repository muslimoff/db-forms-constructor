package com.abssoft.constructor.server;

import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.w3c.dom.NamedNodeMap;

import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.driver.OracleParameterMetaData;

import com.abssoft.constructor.client.data.common.Row;

public class Utils {
	public static void debug(String text) {
		// Timer t = new Timer();
		System.out.println(text);
	}

	public static void debug(String text, Row row) {
		debug(text);
		String currMsg = row.getStatus().getStatusMessage();
		row.getStatus().setStatusMessage(currMsg + "\n" + text);
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
				// Utils.debug("OracleParameterMetaData: param(" + i + ") = " + md);
			}
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		// Вывод значений фильтров... и их установка... по возможности
		Utils.debug("setFilterValues... filterValues=" + filterValues + "; keySet=" + filterValues.keySet());
		Iterator<?> it = filterValues.keySet().iterator();
		while (it.hasNext()) {
			String mapKey = (String) it.next();
			String value = (String) filterValues.get(mapKey);
			Utils.setStringParameterValue(statement, mapKey.toLowerCase(), value);
			Utils.debug("filterValues: " + mapKey + "=" + value);
		}
	}

	public static String bindVarsToLowerCase(String text, String regExp, String addStartChars, String addEndChars) {
		if (null != text) {
			// "(?i):" + columnName.toLowerCase() + "(?=\\b)"
			Utils.debug("bindVarsToLowerCase. 1>" + text);

			Vector<Integer> startPos = new Vector<Integer>();
			Vector<Integer> endPos = new Vector<Integer>();
			{
				Matcher m = Pattern.compile(regExp).matcher(text);
				while (m.find()) {
					startPos.add(m.start());
					endPos.add(m.end());
				}
			}
			for (int i = startPos.size() - 1; i >= 0; i--) {
				int strt = startPos.get(i);
				int end = endPos.get(i);
				Utils.debug(i + "bindVarsToLowerCase. 2>" + text.substring(strt, end));
				String strForReplace = text.substring(strt, end);
				Utils.debug("bindVarsToLowerCase. 3> strt=" + strt + "; end=" + end + " >> " + strForReplace);
				text = text.replaceAll(strForReplace, addStartChars + strForReplace.substring(1).toLowerCase() + addEndChars);
			}
			Utils.debug("bindVarsToLowerCase. 4:" + text);
		}
		return text;
	}

	public static String bindVarsToLowerCase(String text, String regExp) {
		return bindVarsToLowerCase(text, regExp, ":", "");
	}

	public static String getTextFromAttr(NamedNodeMap attributes, String attributeName) {
		String result = null;
		try {
			result = attributes.getNamedItem(attributeName).getTextContent();
			//
			result = "".equals(result) ? null : result;
		} catch (Exception e) {
			// e.printStackTrace();
		}
		return result;
	}
}
