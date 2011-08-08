package com.abssoft.constructor.server;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import oracle.jdbc.OraclePreparedStatement;

import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.abssoft.constructor.client.data.QueryService;
import com.abssoft.constructor.client.data.common.ConnectionInfo;
import com.abssoft.constructor.client.metadata.ActionStatus;
import com.abssoft.constructor.client.metadata.ExportData;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
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
	public static final HashMap<String, String> queryMap1 = new HashMap<String, String>();
	private ServerInfoArr serverInfoArr = new ServerInfoArr();
	private static final HashMap<Integer, Session> sessionData = new HashMap<Integer, Session>();

	public static Session getSessionData(Integer sessionID) {
		return sessionData.get(sessionID);
	}

	// public static String SERVER_WEB_INF;

	@Override
	public void init() throws ServletException {
		super.init();
		String filename = getServletContext().getRealPath("/WEB-INF") + "/" + "constructorapp.connections.xml";
		System.out.println("filename: " + filename);
		Utils.debug("Middle tier service '" + this.getClass() + "' started...");
		File f = new File(".");
		for (String s : f.list()) {
			System.out.println(s);
		}

		ReadSettingsXML(filename);
	}

	public QueryServiceImpl() {
	}

	public void ReadSettingsXML(String filename) {
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		String defaultUsername = "";
		String defaultTitle = "";
		String defaultDebugValue = "";
		String defaultfcSchemaOwner = "";
		String defaultValidationFN = "";

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
				defaultValidationFN = Utils.getTextFromAttr(attributes, "validationFN");
			}

			InputSource serversIS = new InputSource(new FileInputStream(xmlDocument));
			NodeList serversList = (NodeList) findServers.evaluate(serversIS, XPathConstants.NODESET);
			for (int i = 0; i < serversList.getLength(); i++) {
				Node node = serversList.item(i);
				NamedNodeMap attributes = node.getAttributes();

				ServerInfoMD si = new ServerInfoMD();
				// si.setDbUrl(node.getTextContent());
				si.setDbUrl(Utils.getCharacterDataFromElement(node));
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
				si.setServerID(Utils.getTextFromAttr(attributes, "id"));
				si.setValidationFN(Utils.getTextFromAttr(attributes, "validationFN"));
				System.out.println("getServerID>>" + si.getServerID());
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
				if (null == si.getValidationFN()) {
					si.setValidationFN(defaultValidationFN);
				}

				serverInfoArr.add(si);
			}
			InputSource queryIS = new InputSource(new FileInputStream(xmlDocument));
			NodeList queryList = (NodeList) findSQL.evaluate(queryIS, XPathConstants.NODESET);
			for (int i = 0; i < queryList.getLength(); i++) {
				Node node = queryList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				// queryMap.put(Utils.getTextFromAttr(attributes, "name"), node.getTextContent());
				queryMap1.put(Utils.getTextFromAttr(attributes, "name"), Utils.getCharacterDataFromElement(node));
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

	public ConnectionInfo connect(int ServerIdx, String user, String password, boolean isScript, String urlParams) {
		Utils.debug("Server. urlParams:" + urlParams);
		String errMsg = "";
		int sessionId = -1;
		try {
			Utils.debug("Server. Before connect...");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			ServerInfoMD serverInfoMD = serverInfoArr.get(ServerIdx);
			Utils.debug("serverInfoMD:" + serverInfoMD);
			String userName = serverInfoMD.isTransferPassToClient() ? user : serverInfoMD.getDbUsername();
			String userPass = serverInfoMD.isTransferPassToClient() ? password : serverInfoMD.getDbPassword();
			Locale.setDefault(Locale.ENGLISH);
			Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@" + serverInfoMD.getDbUrl(), userName, userPass);
			Utils.debug("Server. Connected..");
			{
				String nlsLangSQL = "alter session set nls_language='AMERICAN'";
				OraclePreparedStatement nlsStmnt = (OraclePreparedStatement) connection.prepareStatement(nlsLangSQL);
				nlsStmnt.execute();
				nlsStmnt.close();
			}
			{
				String sessionSQL = "Select USERENV ('sessionid') as sessionid From DUAL";
				Statement sessionStmnt = connection.createStatement();
				ResultSet sessionidRS = sessionStmnt.executeQuery(sessionSQL);
				sessionidRS.next();
				sessionId = sessionidRS.getBigDecimal(1).intValue();
				sessionidRS.close();
				sessionStmnt.close();
			}
			// mm20110724 Выключил автокоммит сессии для управления комитом на уровне действий (FormActionMD.autoCommit)
			connection.setAutoCommit(false);
			Session session = new Session(connection, serverInfoMD);
			session.setScript(isScript);
			// session.setFcSchemaOwner(serverInfoMD.getFcSchemaOwner());

			// Custom Login Validation
			System.out.println("serverInfoMD.isTransferPassToClient():" + serverInfoMD.isTransferPassToClient());
			if (!serverInfoMD.isTransferPassToClient()) {
				Utils.debug("Server. Custom Login.");
				System.out.println("user:" + user + "; password:" + password + "; userName:" + userName + "; userPass:" + userPass);
				String validateLoginSQL = Utils.getSQLQueryFromXML("customLoginValidationSQL", session);
				System.out.println("@@@validateLoginSQL:\n" + validateLoginSQL);
				OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(validateLoginSQL);
				Utils.debug("Parameters: ");
				Utils.setParameterValue(statement, "p_username", user);
				Utils.setParameterValue(statement, "p_password", password);
				Utils.setParameterValue(statement, "p_url_params", urlParams);
				ResultSet loginRS = statement.executeQuery();
				loginRS.next();
				Boolean isLoginValid = "Y".equals(loginRS.getString("isValid"));
				loginRS.close();
				if (!isLoginValid) {
					connection.close();
					sessionId = -1;
					throw new Exception("Пароль не тот...");
				}
			}
			sessionData.put(sessionId, session);
			this.getThreadLocalRequest().getSession(true).setAttribute(Utils.sessionIdentifier, sessionId);
		} catch (Exception e) {
			e.printStackTrace();
			errMsg = e.toString();
			sessionId = -1;
		}
		Utils.debug("Server.sessionId:" + sessionId);
		ConnectionInfo c = new ConnectionInfo(errMsg, sessionId);
		Utils.debug("Server:sessionId: " + sessionId + "; " + errMsg);
		return c;
	}

	public MenusArr getMenusArr(int sessionId) {
		return sessionData.get(sessionId).getMenusArrOld();
	}

	public StaticLookupsArr getStaticLookupsArr(int sessionId) {
		return sessionData.get(sessionId).getStaticLookupsArr();
	}

	public FormMD getFormMetaData(FormInstanceIdentifier fi) {
		FormMD result = new FormMD();
		try {
			result = sessionData.get(fi.getSessionId()).getFormMetaData(fi);
		} catch (Exception e) {
			String errMsg = Utils.getExceptionStackIntoString(e);
			errMsg = "FormCode:" + fi.getFormCode() + "\n" + errMsg;
			result.setStatus(new ActionStatus(errMsg, ActionStatus.StatusType.ERROR));
		}
		return result;
	}

	public RowsArr fetch(FormInstanceIdentifier fi, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch) {
		RowsArr result = new RowsArr();
		Utils.debug("QueryServiceImpl.fetch. start");
		try {
			result = sessionData.get(fi.getSessionId()).fetch(fi, sortBy, startRow, endRow, criteria, forceFetch);
		} catch (SQLException e) {
			result.setStatus(new ActionStatus(Utils.getExceptionStackIntoString(e), ActionStatus.StatusType.ERROR));
		}
		Utils.debug("QueryServiceImpl.fetch. end");
		return result;
	}

	public Row executeDML(FormInstanceIdentifier formIdentifier, Row oldRow, Row newRow, FormActionMD actMD) {
		try {
			return sessionData.get(formIdentifier.getSessionId()).executeDML(formIdentifier, oldRow, newRow, actMD);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("QueryServiceImpl.executeDML... oldRow:" + oldRow + "; newRow:" + newRow);
			Row r;
			if (!"3".equals(actMD.getType())
			// !ClientActionType.DEL.equals(clientActionType)
			) {

				r = newRow;
			} else {
				r = oldRow;
			}
			ActionStatus actionStatus = r.getStatus();
			actionStatus.setStatusType(ActionStatus.StatusType.ERROR);
			String longMessageText = actionStatus.getLongMessageText();
			longMessageText = e.getMessage() + "\n-------------------------\n" + longMessageText;
			actionStatus.setLongMessageText(longMessageText);
			r.setStatus(actionStatus);
			return r;
		}
	}

	public void sessionClose(int sessionId) {
		if (sessionData.containsKey(sessionId)) {
			try {
				Connection connection = sessionData.get(sessionId).getConnection();
				Utils.debug("Close connection:" + connection);
				connection.close();
			} catch (java.sql.SQLException e) {
				e.printStackTrace();
			}
			sessionData.remove(sessionId);
		}
	}

	public void closeForm(FormInstanceIdentifier fi, FormMD formState) {
		Utils.debug("Server:service " + fi.getInfo() + " before close...");
		sessionData.get(fi.getSessionId()).closeForm(fi, formState);
		Utils.debug("Server:service form " + fi.getInfo() + " closed...");
	}

	public Integer setExportData(FormInstanceIdentifier fi, ExportData exportData) {

		Utils.debug("Server:service " + fi.getInfo() + " before close...");
		Integer result = sessionData.get(fi.getSessionId()).setExportData(fi, exportData);
		Utils.debug("Server:service form " + fi.getInfo() + " closed...");
		return result;
	}

	// TODO DownloadFileTest
	public String getFile() {
		return "DownloadFileTest@";
	}
}
