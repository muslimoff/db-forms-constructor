package com.abssoft.constructor.server;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.ConnectionInfo;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.ServerInfoArr;
import com.abssoft.constructor.client.metadata.ServerInfoMD;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;

//@SuppressWarnings("serial")
public class QueryServiceImpl extends RemoteServiceServlet implements QueryService {

	/**
	 * 
	 */

	// public static final String formSQL =
	// "Select * From forms_v a Where a.form_code = :p_form_code";
	// public static final String extendedFormSQL =
	// "Select form_utils.get_extended_sql_text(a.sql_text)  From forms_v a Where a.form_code = :p_form_code"
	// ;
	// public static final String ColumnsMetaDataSQL =
	// "Select column_display_number, form_code, column_code, column_data_type, column_user_name, column_display_size\n"
	// +
	// ",pimary_key_flag, show_on_grid, tree_initialization_value, tree_field_type, editor_tab_code, field_type\n"
	// +
	// ",column_description, is_frozen_flag, show_hover_flag, exists_in_metadata_flag, exists_in_query_flag\n"
	// +
	// ",lookup_code, hover_column_code, editor_height, lookup_field_type, help_text From Table (form_utils.describe_form_columns_pl (:p_form_code)) Order By form_code, column_display_number, column_code"
	// ;
	// public static final String formActionsSQL =
	// "Select * From form_actions_old a Where a.form_code = :p_form_code order by 2"
	// ;
	// public static final String argsSQLText =
	// "Select a.position, a.argument_name, DECODE (a.in_out, 'IN/OUT', 'Y', 'IN', 'Y') in_flag, DECODE (a.in_out, 'IN/OUT', 'Y', 'OUT', 'Y') out_flag \n"
	// +
	// " From all_arguments a Where a.package_name || '.' || a.object_name = UPPER (:p_procedure_name) And a.owner = User And a.Position != 0 Order By a.Position, a.Sequence"
	// ;
	// public static final String detailFormSQL =
	// "Select * From form_tabs_v a Where a.form_code = :p_form_code order by tab_display_number, tab_name, tab_code"
	// ;
	// //
//	public static final String statLookupsSQL = "Select l.lookup_code, lv.lookup_value_code, lv.lookup_display_value \n"
//			+ "From lookups l, lookup_values lv \n" + "Where l.lookup_code = lv.lookup_code\n"
//			+ "Order By l.lookup_code, lv.lookup_value_code";
//	//public static final String menusSQL = "Select a.form_code, a.hot_key, a.form_name, a.description, a.icon_id From forms_v a order by a.form_name";
	//public static final String iconsSQL = "Select i.icon_id, i.icon_file_name From icons i";

	// //
	private static final long serialVersionUID = 9137729400867519828L;
	private HashMap<Integer, Session> sessionData = new HashMap<Integer, Session>();
	public static final HashMap<String, String> queryMap = new HashMap<String, String>();
	private ServerInfoArr serverInfoArr = new ServerInfoArr();

	public QueryServiceImpl() {
		Utils.debug("Middle tier service 'QueryServiceImpl' started...");
		ReadSettingsXML();
	}

	public void ReadSettingsXML() {
		String filename = "constructorapp.xml";
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();

		try {
			XPathExpression findServers = xPath.compile("//dbConnections/server");
			XPathExpression findSQL = xPath.compile("//metadataQuery/sqlStatement");
			File xmlDocument = new File(filename);
			InputSource inputSource = new InputSource(new FileInputStream(xmlDocument));
			NodeList serversList = (NodeList) findServers.evaluate(inputSource, XPathConstants.NODESET);
			for (int i = 0; i < serversList.getLength(); i++) {
				Node node = serversList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				String displayName = attributes.getNamedItem("display").getTextContent();
				boolean isDefault = "true".equals(attributes.getNamedItem("default").getTextContent());
				System.out.println("server: " + node.getTextContent() + "; displayName=" + displayName + "; isDefault = " + isDefault);
				ServerInfoMD si = new ServerInfoMD();
				si.setDbUrl(node.getTextContent());
				si.setDefault(isDefault);
				si.setDisplay_name(displayName);
				serverInfoArr.add(si);
			}
			InputSource inputSource2 = new InputSource(new FileInputStream(xmlDocument));
			NodeList queryList = (NodeList) findSQL.evaluate(inputSource2, XPathConstants.NODESET);
			for (int i = 0; i < queryList.getLength(); i++) {
				Node node = queryList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				queryMap.put(attributes.getNamedItem("name").getTextContent(), node.getTextContent());
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (XPathExpressionException e1) {
			e1.printStackTrace();
		}
	}

	/**
	 * @return the serverInfoArr
	 */
	public ServerInfoArr getServerInfoArr() {
		return serverInfoArr;
	}

	public ConnectionInfo connect(String url, String user, String password) {
		String result = "";
		int sessionId = -1;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			result = e.toString();
		}
		try {
			Utils.debug("Server. Before connect...");
			Locale.setDefault(Locale.ENGLISH);
			Connection connection = DriverManager.getConnection(url, user, password);
			Utils.debug("Server. Connected..");
			connection.createStatement().execute("alter session set nls_language='AMERICAN'");
			ResultSet rs = connection.createStatement().executeQuery("Select USERENV ('sessionid') From DUAL");
			rs.next();
			sessionId = rs.getBigDecimal(1).intValue();
			rs.close();
			sessionData.put(sessionId, new Session(connection));
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
			result = e.toString();
		} catch (Exception e) {
			e.printStackTrace();
			result = e.toString();
		}
		ConnectionInfo c = new ConnectionInfo(result, sessionId);
		Utils.debug("Server:sessionId: " + sessionId + "; " + result);
		return c;
	}

	public MenusArr getMenusArr(int sessionId) {
		return sessionData.get(sessionId).getMenusArr();
	}

	public StaticLookupsArr getStaticLookupsArr(int sessionId) {
		return sessionData.get(sessionId).getStaticLookupsArr();
	}

	public FormMD getFormMetaData(int sessionId, String formCode) {
		return sessionData.get(sessionId).getFormMetaData(formCode);
	}

	public RowsArr fetch(int sessionId, String formCode, int gridHashCode, String sortBy, int startRow, int endRow, Map<?, ?> criteria,
			boolean forceFetch) {
		return sessionData.get(sessionId).fetch(formCode, gridHashCode, sortBy, startRow, endRow, criteria, forceFetch);
	}

	public Row executeDML(int sessionId, String formCode, int gridHashCode, Row row, String actionCode, ClientActionType clientActionType) {
		try {
			return sessionData.get(sessionId).executeDML(formCode, gridHashCode, row, actionCode, clientActionType);
		} catch (SQLException e) {
			e.printStackTrace();
			row.setServerMessage(e.getMessage());
			return row;
		}
	}

	public void sessionClose(int sessionId) {
		try {
			Connection connection = sessionData.get(sessionId).getConnection();
			Utils.debug("Close connection:" + connection);
			connection.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		sessionData.remove(sessionId);
	}

	public void closeForm(int sessionId, String formCode, int gridHashCode) {
		sessionData.get(sessionId).closeForm(formCode, gridHashCode);
		Utils.debug("Server:service form " + formCode + " - gridHashCode:" + gridHashCode + " closed...");
	}
}
