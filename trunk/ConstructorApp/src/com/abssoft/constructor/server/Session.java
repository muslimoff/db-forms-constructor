package com.abssoft.constructor.server;

//TODO Google Authentification: 
//http://code.google.com/intl/ru-RU/apis/accounts/
//https://www.google.com/accounts/AuthSubRequest?next=http%3A%2F%2Feu.bas.kz%3A8000%2FConstructorApp%2F&&scope=http%3A%2F%2Fwww.google.com%2Fcalendar%2Ffeeds%2F
import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.abssoft.constructor.client.data.TimeoutException;
import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.ActionStatus.StatusType;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.HasActionStatus;
import com.abssoft.constructor.common.IconsArr;
import com.abssoft.constructor.common.MenusArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.StaticLookupsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.MenuMD;
import com.abssoft.constructor.common.metadata.ServerInfoMD;
import com.abssoft.constructor.common.metadata.StaticLookup;

/**
 * Данные сессии приложения - метаданные, <CODE>Connection</CODE>. Хранит {@link Form}
 * 
 * @author User
 */
/**
 * @author amuslimov
 * 
 */
public class Session implements Serializable {

	private static final long serialVersionUID = 8497777456570432919L;
	private Connection conn;
	private String fcSchemaOwner;
	private Map<String, Form> formDataMap = new HashMap<String, Form>();
	private boolean isScript;
	private final Map<String, String> paramsMap = new HashMap<String, String>();
	private ServerInfoMD serverInfoMD;
	private boolean isDebugEnabled = false;
	private Date startDate = new Date();
	private boolean isApplicationTimedOut = false;
	private boolean inUse = false;
	private String urlParams;

	// Для дебага (Session.debug) - вывода вне сессии
	public static Session getEmptySession(Boolean isDebugEnabled) {
		return new Session(isDebugEnabled, false);
	}

	// Пустышка для getEmptySession
	private Session(Boolean isDebugEnabled, Boolean isScript) {
		this.isDebugEnabled = isDebugEnabled;
		this.isScript = isScript;
	}

	public Session(Connection conn, ServerInfoMD serverInfoMD,
			Boolean isDebugEnabled, Boolean isScript, String urlParams) {
		this(isDebugEnabled, isScript);
		this.urlParams = urlParams;
		this.conn = conn;
		this.serverInfoMD = serverInfoMD;
		this.fcSchemaOwner = serverInfoMD.getFcSchemaOwner();
		setParamsMap();
		getStaticLookupsArr();
		resetDbSession();
	}

	public void debug(String text) {
		if (isDebugEnabled) {
			Utils.spoolOut(text);
		}
	};

	public void debug(String text, Row row) {
		debug(text);
		String currMsg = row.getStatus().getLongMessageText();
		row.getStatus().setLongMessageText(currMsg + "\n" + text);
	}

	public void printErrorStackTrace(Exception e) {
		this.debug(e.toString());
		if (isDebugEnabled) {
			e.printStackTrace();
		}
	}

	public void closeForm(FormInstanceIdentifier fi, FormMD formState) {
		this.debug("session form " + fi.getInfo() + " before close...");
		formDataMap.get(fi.getKey()).closeForm(fi.getGridHashCode(), formState);
		// TODO Было закомментировано: Во избежание повторной вычитки настроек
		// формы. Но тогда возникают проблемы при изменении формы на
		// лету. Приходится делать реконнект. Раскомментировал. Предусмотреть
		// режимы работы debug и рабочий. Или забить - пусть так будет.
		// А еще лучше - при старте сессии вычитывать настройки всех форм, а
		// потом только перечитывать при изменении OVN.
		int instCount = formDataMap.get(fi.getKey()).getInstancesCount();
		this.debug("Form " + fi.getFormCode() + " instances: " + instCount);
		if (0 == instCount) {
			formDataMap.remove(fi.getKey());
		}
		this.debug("session form " + fi.getInfo() + " closed...");
	}

	public void closeFormInstance(FormInstanceIdentifier fi) {
		this.debug("session form " + fi.getInfo() + " before close...");
		Map<Integer, FormInstance> formInstance = formDataMap.get(fi.getKey())
				.getFormInstance();
		if (formInstance.containsKey(fi.getGridHashCode())) {
			formInstance.get(fi.getGridHashCode()).closeForm();
			formInstance.remove(fi.getGridHashCode());

		}
		this.debug("session form " + fi.getInfo() + " closed...");
	}

	public Row executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow,
			FormActionMD actMD) throws SQLException, Exception {
		return formDataMap.get(fi.getKey()).executeDML(fi.getGridHashCode(),
				oldRow, newRow, actMD);
	}

	public RowsArr fetch(FormInstanceIdentifier fi, String sortBy,
			int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch)
			throws SQLException {
		return formDataMap.get(fi.getKey()).fetch(fi.getGridHashCode(), sortBy,
				startRow, endRow, criteria, forceFetch);
	}

	public Connection getConnection() {
		return conn;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	public Map<String, Form> getFormDataMap() {
		return formDataMap;
	}

	public FormMD getFormMetaData(FormInstanceIdentifier fi)
			throws SQLException {
		if (!formDataMap.containsKey(fi.getKey())) {
			// 20130516 - Вставка пустой записи для предотвращения рекурсии в
			// случае, если родительская форма равна текущей
			// formDataHashMap.put(fi.getKey(), null);
			Form form = new Form(conn, this, fi);
			form.setFcSchemaOwner(fcSchemaOwner);
			formDataMap.put(fi.getKey(), form);
		}
		return formDataMap.get(fi.getKey()).getFormMetaData();
	}

	public MenusArr getMenusArrOld() {
		MenusArr metadata = new MenusArr();
		PreparedStatement menusStmnt = null;
		PreparedStatement iconsStmnt = null;
		try {
			menusStmnt = conn.prepareStatement(Utils.getSQLQueryFromXML(
					"menusSQL", this));
			ResultSet menusRs = menusStmnt.executeQuery();
			while (menusRs.next()) {
				String formCode = menusRs.getString("form_code");
				// String formName = rs.getString("form_name");
				String formName = menusRs.getString("menu_name");
				MenuMD menu = new MenuMD();
				menu.setFormCode(formCode);
				menu.setFormName(formName);
				menu.setIconId(menusRs.getInt("icon_id"));
				menu.setHotKey(menusRs.getString("hot_key"));
				menu.setDescription(menusRs.getString("description"));
				//
				menu.setLvl(menusRs.getString("lvl"));
				menu.setMenuCode(menusRs.getString("menu_code"));
				menu.setParentMenuCode(menusRs.getString("parent_menu_code"));
				menu.setMenuPosition(menusRs.getString("menu_position"));
				menu.setShowInNavigator(menusRs.getString("show_in_navigator"));
				menu.setMenuName(menusRs.getString("menu_name"));
				menu.setChildCount(menusRs.getInt("child_count"));

				metadata.add(menu);
			}
			menusRs.close();
			// icons
			iconsStmnt = conn.prepareStatement(Utils.getSQLQueryFromXML(
					"iconsSQL", this));
			ResultSet iconsRs = iconsStmnt.executeQuery();
			IconsArr icons = new IconsArr();
			while (iconsRs.next()) {
				icons.put(iconsRs.getInt("icon_id"),
						iconsRs.getString("icon_file_name"),
						iconsRs.getString("icon_path"), isScript);
			}
			metadata.setIcons(icons);
			iconsRs.close();

		} catch (Exception e) {
			printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(menusStmnt);
			Utils.closeStatement(iconsStmnt);
		}
		this.debug("session - MenusArr.size=" + metadata.size());
		return metadata;
	}

	public Map<String, String> getParamsMap() {
		return paramsMap;
	}

	public ServerInfoMD getServerInfoMD() {
		return serverInfoMD;
	}

	public StaticLookupsArr getStaticLookupsArr() {
		StaticLookupsArr lookupsArr = new StaticLookupsArr();
		String currentLookupCode = "-9999";
		PreparedStatement lookupsStmnt = null;
		try {
			lookupsStmnt = conn.prepareStatement(Utils.getSQLQueryFromXML(
					"statLookupsSQL", this));
			ResultSet lookupsRs = lookupsStmnt.executeQuery();
			StaticLookup l = new StaticLookup();
			while (lookupsRs.next()) {
				String lookupCode = lookupsRs.getString("lookup_code");
				String lookupValueCode = lookupsRs
						.getString("lookup_value_code");
				String lookupDisplayValue = lookupsRs
						.getString("lookup_display_value");
				if ("-9999".equals(currentLookupCode)) {
					currentLookupCode = lookupCode;
				}
				if (!lookupCode.equals(currentLookupCode)) {
					lookupsArr.put(currentLookupCode, l);
					l = new StaticLookup();
				}
				l.put(lookupValueCode, lookupDisplayValue);
				currentLookupCode = lookupCode;
				lookupsArr.put(currentLookupCode, l);
			}
			lookupsRs.close();
		} catch (java.sql.SQLException e) {
			printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(lookupsStmnt);
		}
		this.debug("lookupsArr:" + lookupsArr);
		return lookupsArr;
	}

	public boolean isScript() {
		return isScript;
	}

	public Integer setExportData(FormInstanceIdentifier fi,
			ExportData exportData) {
		return formDataMap.get(fi.getKey()).setExportData(fi, exportData);
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public void setFormDataHashMap(HashMap<String, Form> formDataHashMap) {
		this.formDataMap = formDataHashMap;
	}

	private void setParamsMap() {
		PreparedStatement lookupsStmnt = null;
		try {
			// metadataSQL
			String metadataSQL = Utils.getSQLQueryFromXML("metadataSQL", this);
			lookupsStmnt = conn.prepareStatement(metadataSQL);
			ResultSet lookupsRs = lookupsStmnt.executeQuery();
			while (lookupsRs.next()) {
				String lookupCode = lookupsRs.getString("param_name");
				String lookupValueCode = lookupsRs.getString("param_value");
				paramsMap.put(lookupCode, lookupValueCode);
			}
			lookupsRs.close();
		} catch (Exception e) {
			printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(lookupsStmnt);
		}
	}

	public void setServerInfoMD(ServerInfoMD serverInfoMD) {
		this.serverInfoMD = serverInfoMD;
	}

	public void setIsDebugEnabled(Boolean isDebugEnabled) {
		this.isDebugEnabled = isDebugEnabled;
	}

	public Boolean getIsDebugEnabled() {
		return isDebugEnabled;
	}

	public synchronized void resetDbSession() {
		String resetSql = Utils.getSQLQueryFromXML("RESET_SESSION_SQL", this);
		if (resetSql == null || resetSql.isEmpty())
			return;
		CallableStatement call = null;
		try {
			call = conn.prepareCall(resetSql);
			call.setString(1, urlParams);
			call.execute();
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Utils.closeStatement(call);
		}
		renew();
	}

	public synchronized void renew() {
		startDate = new Date();
		isApplicationTimedOut = false;
	}

	private boolean executeTimeoutSql() {
		String timeoutSql = Utils.getSQLQueryFromXML("TIMEOUTSQL", this);
		if (timeoutSql == null || timeoutSql.isEmpty())
			return false;
		String res = null;
		CallableStatement call = null;
		try {
			call = conn.prepareCall(timeoutSql);
			call.registerOutParameter(1, Types.VARCHAR);
			call.setString(2, urlParams);
			call.execute();
			res = call.getString(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Utils.closeStatement(call);
		}
		return "Y".equals(res);
	}

	private boolean isApplicationTimedOut() {
		if (serverInfoMD == null || serverInfoMD.getSessionTimeout() < 0)
			return false;
		if (isApplicationTimedOut)
			return true;
		Date now = new Date();
		long period = now.getTime() - startDate.getTime();
		isApplicationTimedOut = period > serverInfoMD.getSessionTimeout() * 60 * 1000;
		if (!isApplicationTimedOut)
			isApplicationTimedOut = executeTimeoutSql();
		return isApplicationTimedOut;
	}

	private boolean isDbTimedOut() {
		if (serverInfoMD.getDbSessionTimeout() < 0)
			return false;
		Date now = new Date();
		long period = now.getTime() - startDate.getTime();
		return period > serverInfoMD.getDbSessionTimeout() * 60 * 1000;
	}

	public synchronized void checkDbTimeout() throws TimeoutException {
		if (isDbTimedOut())
			throw new TimeoutException();
		else if (!isApplicationTimedOut())
			renew();
	}

	public void checkApplTimeout(HasActionStatus result) {
		if (isApplicationTimedOut()) {
			ActionStatus as = result.getStatus();
			if (as == null)
				as = new ActionStatus();
			as.setStatusType(StatusType.APPL_TIMEOUT);
			result.setStatus(as);
		} else
			renew();
	}

	public synchronized void releaseTimedout() {
		try {
			if (isInUse())
				return;
			boolean closable = conn != null && !conn.isClosed();
			if (closable && isDbTimedOut())
				conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public synchronized boolean isInUse() {
		return inUse;
	}

	public synchronized void setInUse(boolean inUse) {
		this.inUse = inUse;
	}
}