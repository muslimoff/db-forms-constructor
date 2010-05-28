package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Wrapper;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.driver.OracleParameterMetaData;

import org.w3c.dom.NamedNodeMap;

import com.abssoft.constructor.client.metadata.Attribute;
import com.abssoft.constructor.client.metadata.Row;

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
			String value;
			Object valueObj = filterValues.get(mapKey);
			try {
				value = (String) valueObj;
				Utils.debug("filterValues: " + mapKey + "=" + value + "; class: " + valueObj.getClass());
			} catch (Exception e) {
				value = valueObj + "";
				Utils.debug("setFilterValues. Error on filterValues.get(mapKey): " + e.getMessage());
			}
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

	/******************************/
	private static Attribute getAttribute(String column, String formColDataType, ResultSet rs) throws SQLException {
		Attribute attr;
		String val;
		if ("N".equals(formColDataType)) {
			Double dVal = rs.getDouble(column);
			dVal = rs.wasNull() ? null : dVal;
			attr = new Attribute(dVal);
		} else if ("D".equals(formColDataType)) {
			attr = new Attribute(rs.getDate(column));
		} else if ("B".equals(formColDataType)) {
			val = rs.getString(column);
			attr = new Attribute("1".equals(val) || "Y".equals(val));
		} else {
			val = rs.getString(column);
			// Необходимо убирать символы chr #00, которые может возвращать БД - иначе grid вылетает..
			if (null != val) {
				val = val.replaceAll(Character.toString((char) 0), "");
			}
			attr = new Attribute(val);
		}
		return attr;
	}

	// TODO getAttribute - одинаковый код. Как быть?
	private static Attribute getAttribute(Integer column, String formColDataType, OracleCallableStatement rs) throws SQLException {
		Attribute attr;
		String val;
		if ("N".equals(formColDataType)) {
			Double dVal = rs.getDouble(column);
			dVal = rs.wasNull() ? null : dVal;
			attr = new Attribute(dVal);
		} else if ("D".equals(formColDataType)) {
			attr = new Attribute(rs.getDate(column));
		} else if ("B".equals(formColDataType)) {
			val = rs.getString(column);
			attr = new Attribute("1".equals(val) || "Y".equals(val));
		} else {
			val = rs.getString(column);
			// Необходимо убирать символы chr #00, которые может возвращать БД - иначе grid вылетает..
			if (null != val) {
				val = val.replaceAll(Character.toString((char) 0), "");
			}
			attr = new Attribute(val);
		}
		return attr;
	}

	public static Attribute getAttribute(Object column, String formColDataType, Wrapper rs) throws SQLException {
		Attribute attr = null;
		if (column instanceof Integer && rs instanceof OracleCallableStatement) {
			Integer col = (Integer) column;
			attr = getAttribute(col, formColDataType, (OracleCallableStatement) rs);
		} else if (column instanceof String && rs instanceof ResultSet) {
			String col = (String) column;
			attr = getAttribute(col, formColDataType, (ResultSet) rs);
		}
		return attr;
	}
	/******************************/
}
