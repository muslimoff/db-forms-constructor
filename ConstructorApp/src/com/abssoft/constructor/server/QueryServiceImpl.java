package com.abssoft.constructor.server;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
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
import com.abssoft.constructor.client.data.TimeoutException;
import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.ConnectionInfo;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.MenusArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.ServerInfoArr;
import com.abssoft.constructor.common.StaticLookupsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.ServerInfoMD;
import com.google.gwt.user.server.rpc.RemoteServiceServlet;

//@SuppressWarnings("serial")
public class QueryServiceImpl extends RemoteServiceServlet implements
		QueryService {
	private final ScheduledThreadPoolExecutor timeoutChecker = new ScheduledThreadPoolExecutor(
			1);
	public static final Map<String, String> queryMap1 = new HashMap<String, String>();
	private static final long serialVersionUID = 9137729400867519828L;
	private static final ConcurrentMap<Integer, Session> sessionData = new ConcurrentHashMap<Integer, Session>();

	public static Session getSessionData(FormInstanceIdentifier fi) {
		Session s = getSessionData(fi.getSessionId());
		s.setIsDebugEnabled(fi.getIsDebugEnabled());
		return s;
	}

	// private String appServerVersion = "";

	public static Session getSessionData(Integer sessionID) {
		Session s = sessionData.get(sessionID);
		return s;
	}

	private ServerInfoArr serverInfoArr = new ServerInfoArr();

	// public static String SERVER_WEB_INF;
	private static String webinfPath;

	public QueryServiceImpl() {
	}

	public void closeForm(FormInstanceIdentifier fi, FormMD formState) {
		Session session = getSessionData(fi);
		session.debug("service " + fi.getInfo() + " before close...");
		session.closeForm(fi, formState);
		session.debug("service form " + fi.getInfo() + " closed...");
	}

	private boolean isValidLogin(Session session, String user, String password,
			String urlParams) throws SQLException {
		String validateLoginSQL = Utils.getSQLQueryFromXML(
				"customLoginValidationSQL", session);
		session.debug("@@@validateLoginSQL:\n" + validateLoginSQL);

		OraclePreparedStatement statement = null;
		boolean isLoginValid = false;
		try {
			Connection connection = session.getConnection();
			statement = (OraclePreparedStatement) connection
					.prepareStatement(validateLoginSQL);
			session.debug("Parameters: ");
			Utils.setParameterValue(session, statement, "p_username", user);
			Utils.setParameterValue(session, statement, "p_password", password);
			Utils.setParameterValue(session, statement, "p_url_params",
					urlParams);
			ResultSet loginRS = statement.executeQuery();
			loginRS.next();
			isLoginValid = "Y".equals(loginRS.getString("isValid"));
			loginRS.close();
		} finally {
			if (statement != null)
				statement.close();
		}
		return isLoginValid;
	}

	public ConnectionInfo connect(int ServerIdx, String user, String password,
			boolean isScript, String urlParams, Boolean isDebugEnabled) {

		// ServletContext x = getServletContext();

		// String jSessionId = httpSession.getId();
		// //////////////////////////////////
		Session session = Session.getEmptySession(isDebugEnabled);

		try {
			HttpSession httpSession = this.getThreadLocalRequest().getSession();
			this.getThreadLocalResponse().addCookie(new Cookie("xxx", "yyy"));
			session.debug("jSessionId: " + httpSession.getId());
			for (Cookie c : this.getThreadLocalRequest().getCookies()) {
				session.debug("Cookie:" + c.getName() + "=\"" + c.getValue()
						+ "\"");
			}
		} catch (Exception e) {
			session.debug("httpSession error 1:");
			e.printStackTrace();
		}

		session.debug("QueryServiceImpl.connect. urlParams:" + urlParams);
		String errMsg = "";
		int sessionId = -1;
		try {
			session.debug("QueryServiceImpl.connect. Before connect...");
			Class.forName("oracle.jdbc.driver.OracleDriver");
			ServerInfoMD serverInfoMD = serverInfoArr.get(ServerIdx);
			session.debug("serverInfoMD:" + serverInfoMD);
			String userName = serverInfoMD.isTransferPassToClient() ? user
					: serverInfoMD.getDbUsername();
			String userPass = serverInfoMD.isTransferPassToClient() ? password
					: serverInfoMD.getDbPassword();
			Locale.setDefault(Locale.ENGLISH);
			Connection connection = DriverManager.getConnection(
					"jdbc:oracle:thin:@" + serverInfoMD.getDbUrl(), userName,
					userPass);
			session.debug("Connected..");
			{
				String nlsLangSQL = "alter session set nls_language='AMERICAN'";
				OraclePreparedStatement nlsStmnt = (OraclePreparedStatement) connection
						.prepareStatement(nlsLangSQL);
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
			// mm20110724 Выключил автокоммит сессии для управления комитом на
			// уровне действий (FormActionMD.autoCommit)
			connection.setAutoCommit(false);
			session = new Session(connection, serverInfoMD, isDebugEnabled,
					isScript);
			// Custom Login Validation
			Utils.spoolOut("serverInfoMD.isTransferPassToClient():"
					+ serverInfoMD.isTransferPassToClient());
			if (!serverInfoMD.isTransferPassToClient()) {
				session.debug("QueryServiceImpl.connect. Custom Login.");
				session.debug("user:" + user + "; password:" + password
						+ "; userName:" + userName + "; userPass:" + userPass);
				if (!isValidLogin(session, user, password, urlParams)) {
					connection.close();
					sessionId = -1;
					throw new Exception("Пароль не тот...");
				}
			}
			sessionData.put(sessionId, session);
			try {
				this.getThreadLocalRequest().getSession(true)
						.setAttribute(Utils.sessionIdentifier, sessionId);
			} catch (Exception e) {
				session.debug("httpSession error 2:");
				e.printStackTrace();
			}

		} catch (Exception e) {
			e.printStackTrace();
			errMsg = e.toString();
			sessionId = -1;
		}
		ConnectionInfo c = new ConnectionInfo(errMsg, sessionId);
		c.setDbServerVersion("bla-bla-bla...");
		session.debug("sessionId: " + sessionId + "; " + errMsg);
		return c;
	}

	public void relogin(int sessionID, String user, String password,
			String urlParams) throws Exception {
		Session session = getSessionData(sessionID);
		if (isValidLogin(session, user, password, urlParams))
			session.renew();
		else
			throw new Exception(Messages.getMessage("login.failed"));
	}

	public Row executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow,
			FormActionMD actMD) throws TimeoutException {
		Session session = getSessionData(fi);
		session.checkRenew();
		try {
			return session.executeDML(fi, oldRow, newRow, actMD);
		} catch (Exception e) {
			e.printStackTrace();
			session.debug("QueryServiceImpl.executeDML... oldRow:" + oldRow
					+ "; newRow:" + newRow);
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
			longMessageText = e.getMessage() + "\n-------------------------\n"
					+ longMessageText;
			actionStatus.setLongMessageText(longMessageText);
			r.setStatus(actionStatus);
			return r;
		}
	}

	public RowsArr fetch(FormInstanceIdentifier fi, String sortBy,
			int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch)
			throws TimeoutException {
		RowsArr result = new RowsArr();
		Session session = getSessionData(fi);
		session.checkRenew();
		session.debug("QueryServiceImpl.fetch. start");
		try {
			result = session.fetch(fi, sortBy, startRow, endRow, criteria,
					forceFetch);
		} catch (SQLException e) {
			result.setStatus(new ActionStatus(Messages.getMessage(e),
					ActionStatus.StatusType.ERROR));
		}
		session.debug("QueryServiceImpl.fetch. end");
		return result;
	}

	public String getAppServerVersion() {
		String appServerVersion = "";
		Properties prop = new Properties();
		try {
			prop.load(new FileInputStream(webinfPath + "/"
					+ "application.properties"));
			appServerVersion = prop.getProperty("major.minor") + "."
					+ prop.getProperty("build.number");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return appServerVersion;
	}

	// TODO DownloadFileTest
	public String getFile() {
		return "DownloadFileTest@";
	}

	public FormMD getFormMetaData(FormInstanceIdentifier fi)
			throws TimeoutException {
		FormMD result = new FormMD();
		Session session = getSessionData(fi);
		session.checkRenew();
		try {
			result = session.getFormMetaData(fi);
		} catch (SQLException e) {
			String errMsg = Messages.getMessage(e);
			// errMsg = "FormCode:" + fi.getFormCode() + "\n" + errMsg;
			result.setStatus(new ActionStatus(errMsg,
					ActionStatus.StatusType.ERROR));
		}
		return result;
	}

	public MenusArr getMenusArr(int sessionId) throws TimeoutException {
		Session session = getSessionData(sessionId);
		session.checkRenew();
		return session.getMenusArrOld();
	}

	/**
	 * @return the serverInfoArr
	 */
	public ServerInfoArr getServerInfoArrWithoutPassword() {
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

		result.setSkinsList(serverInfoArr.getSkinsList());
		result.setAppServerVersion(serverInfoArr.getAppServerVersion());
		Utils.spoolOut("serverInfoArr:" + serverInfoArr);
		Utils.spoolOut("result:" + result);
		return result;
	}

	public StaticLookupsArr getStaticLookupsArr(int sessionId)
			throws TimeoutException {
		Session session = getSessionData(sessionId);
		session.checkRenew();
		return session.getStaticLookupsArr();
	}

	public static String getWebinfPath() {
		return webinfPath;
	}

	// Тест сериализации сессий: http://habrahabr.ru/post/60317/
	// private void SerializeSession(Session session) {
	//
	// try {
	// FileOutputStream fos;
	// fos = new FileOutputStream("session-" + session.getClass().toString() +
	// ".serialization");
	// ObjectOutputStream oos = new ObjectOutputStream(fos);
	// oos.writeObject(session);
	// oos.flush();
	// oos.close();
	// } catch (FileNotFoundException e1) {
	// // TODO Auto-generated catch block
	// e1.printStackTrace();
	// } catch (IOException e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// } catch (Exception e) {
	// // TODO Auto-generated catch block
	// e.printStackTrace();
	// }
	//
	// }

	@Override
	public void init() throws ServletException {
		super.init();
		webinfPath = getServletContext().getRealPath("/WEB-INF");
		String filename = webinfPath + "/" + "constructorapp.connections.xml";
		Utils.spoolOut("filename: " + filename);
		Utils.spoolOut("Middle tier service '" + this.getClass()
				+ "' started...");
		File f = new File(".");
		for (String s : f.list()) {
			Utils.spoolOut(s);
		}

		this.serverInfoArr = ReadSettingsXML(filename);
		this.serverInfoArr.setAppServerVersion(getAppServerVersion());
		Utils.spoolOut("appServerVersion3:"
				+ this.serverInfoArr.getAppServerVersion());
		timeoutChecker.scheduleWithFixedDelay(new TimeoutChecker(sessionData),
				0, 1, TimeUnit.MINUTES);
	}

	@Override
	public void destroy() {
		super.destroy();
		timeoutChecker.shutdownNow();
	}

	private ServerInfoArr ReadSettingsXML(String filename) {
		ServerInfoArr result = new ServerInfoArr();
		XPathFactory factory = XPathFactory.newInstance();
		XPath xPath = factory.newXPath();
		String defaultUsername = "";
		String defaultTitle = "";
		String defaultDebugValue = "";
		String defaultfcSchemaOwner = "";
		String defaultValidationFN = "";

		try {
			XPathExpression findDefalutServerSettings = xPath
					.compile("//dbConnections/defaultValues");
			XPathExpression findServers = xPath
					.compile("//dbConnections/server");
			XPathExpression findSQL = xPath
					.compile("//metadataQuery/sqlStatement");
			XPathExpression findSkins = xPath.compile("//skins/skin");
			File xmlDocument = new File(filename);

			InputSource dfltServerSettingsIS = new InputSource(
					new FileInputStream(xmlDocument));
			NodeList defalutServerSettings = (NodeList) findDefalutServerSettings
					.evaluate(dfltServerSettingsIS, XPathConstants.NODESET);
			for (int i = 0; i < defalutServerSettings.getLength(); i++) {
				Node node = defalutServerSettings.item(i);
				NamedNodeMap attributes = node.getAttributes();
				defaultUsername = Utils.getTextFromAttr(attributes,
						"dbusername");
				defaultTitle = Utils.getTextFromAttr(attributes, "title");
				defaultDebugValue = Utils.getTextFromAttr(attributes, "debug");
				defaultfcSchemaOwner = Utils.getTextFromAttr(attributes,
						"fcSchemaOwner");
				defaultValidationFN = Utils.getTextFromAttr(attributes,
						"validationFN");
			}

			InputSource serversIS = new InputSource(new FileInputStream(
					xmlDocument));
			NodeList serversList = (NodeList) findServers.evaluate(serversIS,
					XPathConstants.NODESET);
			for (int i = 0; i < serversList.getLength(); i++) {
				Node node = serversList.item(i);
				NamedNodeMap attributes = node.getAttributes();

				ServerInfoMD si = new ServerInfoMD();
				// si.setDbUrl(node.getTextContent());
				si.setDbUrl(Utils.getCharacterDataFromElement(node));
				si.setDefault("true".equals(Utils.getTextFromAttr(attributes,
						"default")));
				si.setDisplayName(Utils.getTextFromAttr(attributes, "display"));
				si.setDbUsername(Utils
						.getTextFromAttr(attributes, "dbusername"));
				si.setDbPassword(Utils
						.getTextFromAttr(attributes, "dbpassword"));
				String debugValue = Utils.getTextFromAttr(attributes, "debug");
				si.setDebug("true"
						.equals(null == debugValue ? defaultDebugValue
								: debugValue));
				si.setTitle(Utils.getTextFromAttr(attributes, "title"));
				si.setFcSchemaOwner(Utils.getTextFromAttr(attributes,
						"fcSchemaOwner"));
				si.setAllowUserChange(!"false".equals(Utils.getTextFromAttr(
						attributes, "allowuserchange")));
				// Если пароль и пользователь БД заданы - не передаем на клиента
				// и воспринимаем логин/пароль как паользователя приложения
				si.setTransferPassToClient(si.isAllowUserChange()
						|| null == si.getDbPassword()
						|| null == si.getDbUsername());
				si.setServerID(Utils.getTextFromAttr(attributes, "id"));
				si.setValidationFN(Utils.getTextFromAttr(attributes,
						"validationFN"));
				String timeout = Utils.getTextFromAttr(attributes,
						"sessionTimeout");
				if (timeout != null && timeout.matches("^\\d+$"))
					si.setSessionTimeout(Integer.parseInt(timeout));
				else
					si.setSessionTimeout(-1);
				timeout = Utils.getTextFromAttr(attributes, "dbSessionTimeout");
				if (timeout != null && timeout.matches("^\\d+$"))
					si.setDbSessionTimeout(Integer.parseInt(timeout));
				else
					si.setDbSessionTimeout(-1);

				// System.out.println("getServerID>>" + si.getServerID());
				// System.out.println("getDisplayName>>" +
				// si.getDisplayName());
				// System.out.println("isAllowUserChange>>" +
				// si.isAllowUserChange());
				// System.out.println("getDbUsername>>" +
				// si.getDbUsername());
				// System.out.println("getDbPassword>>" +
				// si.getDbPassword());
				// System.out.println("isTransferPassToClient>>" +
				// si.isTransferPassToClient());
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

				result.add(si);
			}
			InputSource queryIS = new InputSource(new FileInputStream(
					xmlDocument));
			NodeList queryList = (NodeList) findSQL.evaluate(queryIS,
					XPathConstants.NODESET);
			for (int i = 0; i < queryList.getLength(); i++) {
				Node node = queryList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				// queryMap.put(Utils.getTextFromAttr(attributes, "name"),
				// node.getTextContent());
				queryMap1.put(Utils.getTextFromAttr(attributes, "name"),
						Utils.getCharacterDataFromElement(node));
			}

			InputSource skinsIS = new InputSource(new FileInputStream(
					xmlDocument));
			NodeList skinList = (NodeList) findSkins.evaluate(skinsIS,
					XPathConstants.NODESET);
			for (int i = 0; i < skinList.getLength(); i++) {
				Node node = skinList.item(i);
				NamedNodeMap attributes = node.getAttributes();
				// Utils.debug(Utils.getTextFromAttr(attributes, "code") + ":" +
				// node.getTextContent());
				// Utils.debug(Utils.getTextFromAttr(attributes, "name") + ":" +
				// node.getTextContent());
				result.getSkinsList().put(
						Utils.getTextFromAttr(attributes, "code"),
						Utils.getTextFromAttr(attributes, "name"));
			}
			// Collections.sort(serverInfoArr.getSkinsList());

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (XPathExpressionException e1) {
			e1.printStackTrace();
		}
		return result;
	}

	public void sessionClose(int sessionId) {
		if (sessionData.containsKey(sessionId)) {
			Session session = getSessionData(sessionId);
			// Тест сериализации сессий: http://habrahabr.ru/post/60317/
			// Вообще - нужна периодическая пробежка по сессиям, которые давно
			// не использовались (по таймауту мочим).
			// Нифира не заработало из-за: java.io.NotSerializableException:
			// oracle.jdbc.driver.T4CConnection
			// SerializeSession(session);
			try {
				Connection connection = getSessionData(sessionId)
						.getConnection();
				session.debug("Close connection:" + connection);
				connection.close();
			} catch (java.sql.SQLException e) {
				session.printErrorStackTrace(e);
			}
			sessionData.remove(sessionId);
		}
	}

	public Integer setExportData(FormInstanceIdentifier fi,
			ExportData exportData) throws TimeoutException {
		Session session = getSessionData(fi);
		session.checkRenew();
		session.debug("service " + fi.getInfo() + " before close...");
		Integer result = session.setExportData(fi, exportData);
		session.debug("service form " + fi.getInfo() + " closed...");
		return result;
	}
}
