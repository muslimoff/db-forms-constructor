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
import com.abssoft.constructor.client.metadata.ActionStatus;
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
	private static final long serialVersionUID = 9137729400867519828L;
	public static final HashMap<String, String> queryMap = new HashMap<String, String>();
	private ServerInfoArr serverInfoArr = new ServerInfoArr();
	private HashMap<Integer, Session> sessionData = new HashMap<Integer, Session>();

	public QueryServiceImpl() {
		Utils.debug("Middle tier service 'QueryServiceImpl' started...");
		File f = new File(".");
		for (String s : f.list()) {
			System.out.println(s);
		}
		ReadSettingsXML();

	}

	public void ReadSettingsXML() {
		String filename = "constructorapp.xml";
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		String defaultUsername = "";
		String defaultTitle = "";
		String defaultDebugValue = "";
		String defaultfcSchemaOwner = "";

		try {
			XPathExpression findDefalutServerSettings = xPath.compile("//dbConnections/defaultValues");
			XPathExpression findServers = xPath.compile("//dbConnections/server");
			XPathExpression findSQL = xPath.compile("//metadataQuery/sqlStatement");
			File xmlDocument = new File(filename);

			InputSource dfltServerSettingsIS = new InputSource(new FileInputStream(xmlDocument));
			NodeList defalutServerSettings = (NodeList) findDefalutServerSettings.evaluate(dfltServerSettingsIS, XPathConstants.NODESET);
			for (int i = 0; i < defalutServerSettings.getLength(); i++) {
				Node node = defalutServerSettings.item(i);
				NamedNodeMap attributes = node.getAttributes();
				defaultUsername = Utils.getTextFromAttr(attributes, "dbusername");
				defaultTitle = Utils.getTextFromAttr(attributes, "title");
				defaultDebugValue = Utils.getTextFromAttr(attributes, "debug");
				defaultfcSchemaOwner = Utils.getTextFromAttr(attributes, "fcSchemaOwner");
			}

			InputSource serversIS = new InputSource(new FileInputStream(xmlDocument));
			NodeList serversList = (NodeList) findServers.evaluate(serversIS, XPathConstants.NODESET);
			for (int i = 0; i < serversList.getLength(); i++) {
				Node node = serversList.item(i);
				NamedNodeMap attributes = node.getAttributes();

				ServerInfoMD si = new ServerInfoMD();
				si.setDbUrl(node.getTextContent());
				si.setDefault("true".equals(Utils.getTextFromAttr(attributes, "default")));
				si.setDisplayName(Utils.getTextFromAttr(attributes, "display"));
				si.setDbUsername(Utils.getTextFromAttr(attributes, "dbusername"));
				si.setDbPassword(Utils.getTextFromAttr(attributes, "dbpassword"));
				String debugValue = Utils.getTextFromAttr(attributes, "debug");
				si.setDebug("true".equals(null == debugValue ? defaultDebugValue : debugValue));
				si.setTitle(Utils.getTextFromAttr(attributes, "title"));
				si.setFcSchemaOwner(Utils.getTextFromAttr(attributes, "fcSchemaOwner"));
				si.setAllowUserChange(!"false".equals(Utils.getTextFromAttr(attributes, "allowuserchange")));
				// Если пароль и пользователь БД заданы - не передаем на клиента и воспринимаем логин/пароль как паользователя приложения
				si.setTransferPassToClient(si.isAllowUserChange() || null == si.getDbPassword() || null == si.getDbUsername());
				System.out.println("getDisplayName>>" + si.getDisplayName());
				System.out.println("isAllowUserChange>>" + si.isAllowUserChange());
				System.out.println("getDbUsername>>" + si.getDbUsername());
				System.out.println("getDbPassword>>" + si.getDbPassword());
				System.out.println("isTransferPassToClient>>" + si.isTransferPassToClient());
				if (null == si.getDbUsername()) {
					si.setDbUsername(defaultUsername);
				}
				if (null == si.getDbPassword()) {
					si.setDbPassword("");
				}
				if (null == si.getTitle()) {
					si.setTitle(defaultTitle);
				}
				if (null == si.getFcSchemaOwner()) {
					si.setFcSchemaOwner(defaultfcSchemaOwner);
				}

				serverInfoArr.add(si);
			}
			InputSource queryIS = new InputSource(new FileInputStream(xmlDocument));
			NodeList queryList = (NodeList) findSQL.evaluate(queryIS, XPathConstants.NODESET);
			for (int i = 0; i < queryList.getLength(); i++) {
				Node node = queryList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				queryMap.put(Utils.getTextFromAttr(attributes, "name"), node.getTextContent());
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
		ServerInfoArr result = new ServerInfoArr();
		for (int i = 0; i < serverInfoArr.size(); i++) {
			ServerInfoMD x = (ServerInfoMD) serverInfoArr.get(i).clone();
			x.setDbUrl(null);
			if (!x.isTransferPassToClient()) {
				x.setDbPassword(null);
				x.setDbUsername(null);
			}
			result.add(x);
		}
		System.out.println("serverInfoArr:" + serverInfoArr);
		System.out.println("result:" + result);
		return result;
	}

	public ConnectionInfo connect(int ServerIdx, String user, String password, boolean isScript) {
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

			ServerInfoMD serverInfoMD = serverInfoArr.get(ServerIdx);
			System.out.println("serverInfoMD:" + serverInfoMD);
			String userName = serverInfoMD.isTransferPassToClient() ? user : serverInfoMD.getDbUsername();
			String userPass = serverInfoMD.isTransferPassToClient() ? password : serverInfoMD.getDbPassword();
			Locale.setDefault(Locale.ENGLISH);
			Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@" + serverInfoMD.getDbUrl(), userName, userPass);
			Utils.debug("Server. Connected..");
			connection.createStatement().execute("alter session set nls_language='AMERICAN'");
			ResultSet rs = connection.createStatement().executeQuery("Select USERENV ('sessionid') From DUAL");
			rs.next();
			sessionId = rs.getBigDecimal(1).intValue();
			rs.close();
			Session session = new Session(connection);
			session.setScript(isScript);
			session.setFcSchemaOwner(serverInfoMD.getFcSchemaOwner());
			sessionData.put(sessionId, session);
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
			result = e.getMessage();

		} catch (Exception e) {
			e.printStackTrace();
			result = e.toString();
		}
		ConnectionInfo c = new ConnectionInfo(result, sessionId);
		Utils.debug("Server:sessionId: " + sessionId + "; " + result);
		return c;
	}

	public MenusArr getMenusArr(int sessionId) {
		return sessionData.get(sessionId).getMenusArrOld();
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

	public Row executeDML(int sessionId, String formCode, int gridHashCode, Row oldRow, Row newRow, String actionCode,
			ClientActionType clientActionType) {
		try {
			return sessionData.get(sessionId).executeDML(formCode, gridHashCode, oldRow, newRow, actionCode, clientActionType);
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("QueryServiceImpl.executeDML... oldRow:" + oldRow + "; newRow:" + newRow);
			// newRow.setServerMessage(e.getMessage());

			newRow.setStatus(new ActionStatus(e.getMessage(), ActionStatus.StatusType.ERROR));
			return newRow;
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
		Utils.debug("Server:service form " + formCode + " - gridHashCode:" + gridHashCode + " before close...");
		sessionData.get(sessionId).closeForm(formCode, gridHashCode);
		Utils.debug("Server:service form " + formCode + " - gridHashCode:" + gridHashCode + " closed...");
	}
}
