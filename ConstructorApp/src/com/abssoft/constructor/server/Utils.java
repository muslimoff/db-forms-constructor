package com.abssoft.constructor.server;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.Map;
import java.util.TimeZone;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OraclePreparedStatement;
import oracle.jdbc.driver.OracleParameterMetaData;
import oracle.sql.CLOB;
import oracle.sql.DATE;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.abssoft.constructor.common.Attribute;
import com.abssoft.constructor.common.metadata.ServerInfoMD;

public class Utils {
	public static final String sessionIdentifier = "ConstructorSession";

	public static String bindVarsToLowerCase(Session session, String text, String regExp) {
		return bindVarsToLowerCase(session, text, regExp, ":", "");
	}

	public static String bindVarsToLowerCase(Session session, String text, String regExp, String addStartChars, String addEndChars) {
		if (null != text) {
			// "(?i):" + columnName.toLowerCase() + "(?=\\b)"
			session.debug("bindVarsToLowerCase. 1>" + text);

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
				session.debug(i + "bindVarsToLowerCase. 2>" + text.substring(strt, end));
				String strForReplace = text.substring(strt, end);
				session.debug("bindVarsToLowerCase. 3> strt=" + strt + "; end=" + end + " >> " + strForReplace);
				text = text.replaceAll(strForReplace, addStartChars + strForReplace.substring(1).toLowerCase() + addEndChars);
			}
			session.debug("bindVarsToLowerCase. 4:" + text);
		}
		return text;
	}

	public static void spoolOut(String text) {
		System.out.println("SRV:" + text);
	}

	/**
	 *Создана для решения проблемы в Атырау - таймзона клиента на час меньше, чем таймзона сервера. Функция переводит srcDate из Таймзоны
	 * сервера в таймзону UTC
	 * 
	 * @param srcDate
	 *            - Дата в таймзоне сервера
	 * @return - дата в таймзоне UTC
	 */
	public static Date changeTimezone(Date srcDate) {
		Date destDate = srcDate;
		if (null != destDate) {
			// TimeZone tzALA = TimeZone.getTimeZone("Asia/Almaty");
			// TimeZone tzALA = TimeZone.getTimeZone("Canada/Pacific");

			TimeZone tzDefault = TimeZone.getDefault(); // Таймзона сервера (ALA например)
			TimeZone tzUTC = TimeZone.getTimeZone("UTC"); // UTC - Таймзона
			Calendar calendar = new GregorianCalendar(tzDefault); // Создаем новый календарь с дефолтной таймзоной
			DateFormat dtFmt = DateFormat.getDateInstance(DateFormat.SHORT);
			dtFmt.setCalendar(calendar);
			try {
				String dateStr = dtFmt.format(srcDate); // конвертим в строку, отсекая всю лишнюю инфу, в т.ч. таймзону
				calendar.setTimeZone(tzUTC); // перебрасываем таймзону календаря в UTC
				destDate = dtFmt.parse(dateStr); // Снова конвертим в Date, с новой таймзоной календаря
			} catch (ParseException e) {
				e.printStackTrace();
				destDate = srcDate;
			}
			// spoolOut("tttt_srv_attr2:" + dateStr + "; xx: " + DateFormat.getDateInstance(DateFormat.FULL).format(destDate));
		}
		return destDate; // Таки вот - теперь сервер всегда отдает даты в UTCб пофигу метель...
	}

	private static Attribute getAttribute(String colStr, Integer colInt, String formColDataType, ResultSet rs, OracleCallableStatement cs,
			FormInstance formInstance) throws SQLException {
		Attribute attr;
		String val;
		boolean isCalStmnt = null == colStr && null == rs;
		if ("N".equals(formColDataType)) {
			Double dVal = isCalStmnt ? cs.getDouble(colInt) : rs.getDouble(colStr);
			dVal = (isCalStmnt ? cs.wasNull() : rs.wasNull()) ? null : dVal;
			attr = new Attribute(dVal);
		} else if ("D".equals(formColDataType)) {
			DATE dt = isCalStmnt ? cs.getDATE(colInt) : null;
			Date dateVal = isCalStmnt ? (cs.wasNull() ? null : dt.dateValue()) : rs.getDate(colStr);
			dateVal = changeTimezone(dateVal);
			attr = new Attribute(dateVal);
		} else if ("B".equals(formColDataType)) {
			val = isCalStmnt ? cs.getString(colInt) : rs.getString(colStr);
			attr = new Attribute("1".equals(val) || "Y".equals(val));
		} else if ("CLOB".equals(formColDataType)) {
			CLOB cval = (CLOB) (isCalStmnt ? cs.getClob(colInt) : rs.getClob(colStr));
			Integer clobHashCode = (null != cval) ? cval.hashCode() : null;
			attr = new Attribute((Double) ((null != clobHashCode) ? Double.valueOf(clobHashCode) : null));
			formInstance.getClobHM().put(clobHashCode, cval);
		} else {
			val = isCalStmnt ? cs.getString(colInt) : rs.getString(colStr);
			// Необходимо убирать символы chr #00, которые может возвращать БД - иначе grid вылетает..
			if (null != val) {
				val = val.replaceAll(Character.toString((char) 0), "");
			}
			attr = new Attribute(val);
		}
		return attr;
	}

	public static Attribute getAttribute(String colStr, String formColDataType, ResultSet rs, FormInstance formInstance)
			throws SQLException {
		return getAttribute(colStr, null, formColDataType, rs, null, formInstance);
	}

	public static Attribute getAttribute(Integer colInt, String formColDataType, OracleCallableStatement cs, FormInstance formInstance)
			throws SQLException {
		return getAttribute(null, colInt, formColDataType, null, cs, formInstance);
	}

	// public static void main(String[] args) {
	// Integer clobHashCode = null;
	// Double b = Double.valueOf(clobHashCode);
	// spoolOut("xxxxxx:" + b);
	// }

	/******************************/
	public static String getCharacterDataFromElement(Node field) {
		String result = "";
		NodeList nl = field.getChildNodes();
		if (nl.getLength() > 0)
			for (int i = 0; i < nl.getLength(); i++) {
				short nType = nl.item(i).getNodeType();
				if (nType == Node.CDATA_SECTION_NODE || nType == Node.TEXT_NODE)
					result = result + nl.item(i).getNodeValue();
			}
		result = "".equals(result) ? field.getNodeValue() : result;
		return result;
	}

	public static String getTextFromAttr(NamedNodeMap attributes, String attributeName) {
		String result = null;
		try {
			Node node = attributes.getNamedItem(attributeName);
			result = getCharacterDataFromElement(node);
			result = "".equals(result) ? null : result;
		} catch (Exception e) {
		}
		return result;
	}

	public static void setFilterValues(Session session, OraclePreparedStatement statement, Map<?, ?> filterValues) {
		try {
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
				session.printErrorStackTrace(e);
			}
			// Вывод значений фильтров... и их установка... по возможности
			session.debug("setFilterValues... filterValues=" + filterValues + "; keySet=" + filterValues.keySet());
			Iterator<?> it = filterValues.keySet().iterator();
			while (it.hasNext()) {
				String mapKey = (String) it.next();
				Object valueObj = filterValues.get(mapKey);
				Utils.setParameterValue(session, statement, mapKey.toLowerCase(), valueObj);
			}
		} catch (Exception e) {
			session.printErrorStackTrace(e);
		}
	}

	public static void setFormMDParams(Session session, OraclePreparedStatement statement, String formCode, String parentFormCode,
			Boolean isDrillDownForm) {
		Utils.setParameterValue(session, statement, "p_form_code", formCode);
		Utils.setParameterValue(session, statement, "p_master_form_code", parentFormCode);
		Utils.setParameterValue(session, statement, "p_drilldown_flag", isDrillDownForm ? "Y" : "N");
	}

	public static void setParameterValue(Session session, OraclePreparedStatement statement, String name, Object value) {
		session.debug("setParameterValue. name=" + name + "=>" + (null != value ? value : "null"));
		try {
			if (null != value) {
				if (value instanceof Boolean) {
					statement.setStringAtName(name, (Boolean) value ? "Y" : "N");
				} else if (value instanceof Double) {
					statement.setDoubleAtName(name, (Double) value);
				} else if (value instanceof Date) {
					statement.setDateAtName(name, new java.sql.Date(((java.util.Date) value).getTime()));
				} else {
					statement.setStringAtName(name, value + "");
				}
			} else {
				statement.setStringAtName(name, null);
			}
		} catch (java.sql.SQLException e) {
			session.debug("*****setParameterValue: " + e.getMessage());
		}
	}

	public static String getExceptionStackIntoString(Throwable e) {
		Writer writer = new StringWriter();
		PrintWriter printWriter = new PrintWriter(writer);
		e.printStackTrace(printWriter);
		return writer.toString();
	}

	public static String getSQLwUserVarsReplaced(String sqlText, Session session) {
		ServerInfoMD serverInfoMD = session.getServerInfoMD();
		String query = sqlText;
		query = query.replaceAll("(?i)&validationFN", serverInfoMD.getValidationFN());
		query = query.replaceAll("(?i)&fc_schema_owner\\.", serverInfoMD.getFcSchemaOwner());
		query = query.replaceAll("(?i)&fc_schema_owner", serverInfoMD.getFcSchemaOwner());
		query = query.replaceAll("(?i)&db_username\\.", serverInfoMD.getDbUsername());
		query = query.replaceAll("(?i)&db_username", serverInfoMD.getDbUsername());
		return query;
	}

	public static String getSQLQueryFromXML(String queryCode, Session session) {
		// Ищем запросы в session.paramsMap. Если там нет, то для обратной совместимости ищем в QueryServiceImpl.queryMap1 (в XML-ке)
		String query = session.getParamsMap().containsKey(queryCode) ? session.getParamsMap().get(queryCode) : QueryServiceImpl.queryMap1
				.get(queryCode);
		query = getSQLwUserVarsReplaced(query, session);
		return query;
	}
}
