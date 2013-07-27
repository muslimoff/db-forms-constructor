package com.abssoft.constructor.server;

//TODO Google Authentification: 
//http://code.google.com/intl/ru-RU/apis/accounts/
//https://www.google.com/accounts/AuthSubRequest?next=http%3A%2F%2Feu.bas.kz%3A8000%2FConstructorApp%2F&&scope=http%3A%2F%2Fwww.google.com%2Fcalendar%2Ffeeds%2F
import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormInstanceIdentifier;
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
	private OracleConnection connection;
	private String fcSchemaOwner;
	private HashMap<String, Form> formDataHashMap = new HashMap<String, Form>();
	private boolean isScript;
	private final HashMap<String, String> paramsMap = new HashMap<String, String>();
	private ServerInfoMD serverInfoMD;
	private Boolean isDebugEnabled = false;

	// Для дебага (Session.debug) - вывода вне сессии
	public static Session getEmptySession(Boolean isDebugEnabled) {
		return new Session(isDebugEnabled, false);
	}

	// Пустышка для getEmptySession
	private Session(Boolean isDebugEnabled, Boolean isScript) {
		this.isDebugEnabled = isDebugEnabled;
		this.isScript = isScript;
	}

	public Session(Connection connection, ServerInfoMD serverInfoMD, Boolean isDebugEnabled, Boolean isScript) {
		this(isDebugEnabled, isScript);
		this.connection = (OracleConnection) connection;
		this.setServerInfoMD(serverInfoMD);
		this.setFcSchemaOwner(serverInfoMD.getFcSchemaOwner());
		setParamsMap();
		getStaticLookupsArr();
	}

	public void debug(String text) {
		// Timer t = new Timer();
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
		formDataHashMap.get(fi.getKey()).closeForm(fi.getGridHashCode(), formState);
		// TODO Было закомментировано: Во избежание повторной вычитки настроек формы. Но тогда возникают проблемы при изменении формы на
		// лету. Приходится делать реконнект. Раскомментировал. Предусмотреть режимы работы debug и рабочий. Или забить - пусть так будет.
		// А еще лучше - при старте сессии вычитывать настройки всех форм, а потом только перечитывать при изменении OVN.
		int instCount = formDataHashMap.get(fi.getKey()).getInstancesCount();
		this.debug("Form " + fi.getFormCode() + " instances: " + instCount);
		if (0 == instCount) {
			formDataHashMap.remove(fi.getKey());
		}
		this.debug("session form " + fi.getInfo() + " closed...");
	}

	public Row executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow, FormActionMD actMD) throws SQLException, Exception {
		return formDataHashMap.get(fi.getKey()).executeDML(fi.getGridHashCode(), oldRow, newRow, actMD);
	}

	public RowsArr fetch(FormInstanceIdentifier fi, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch)
			throws SQLException {
		return formDataHashMap.get(fi.getKey()).fetch(fi.getGridHashCode(), sortBy, startRow, endRow, criteria, forceFetch);
	}

	public OracleConnection getConnection() {
		return connection;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	public HashMap<String, Form> getFormDataHashMap() {
		return formDataHashMap;
	}

	// public FormMD getFormMetaData(FormInstanceIdentifier formIdentifier) throws SQLException {
	// return getFormMetaData(formIdentifier, true);
	// }

	public FormMD getFormMetaData(FormInstanceIdentifier fi
	// , boolean isNonLookupForm
	) throws SQLException {
		// String formMapKey = (null == parentFormCode) ? formCode : formCode + "." + parentFormCode;
		if (!formDataHashMap.containsKey(fi.getKey())) {
			// 20130516 - Вставка пустой записи для предотвращения рекурсии в случае, если родительская форма равна текущей
			// formDataHashMap.put(fi.getKey(), null);
			Form form = new Form(connection, this, fi);
			form.setFcSchemaOwner(fcSchemaOwner);
			formDataHashMap.put(fi.getKey(), form);
		}
		return formDataHashMap.get(fi.getKey()).getFormMetaData();
	}

	public MenusArr getMenusArrOld() {
		MenusArr metadata = new MenusArr();
		try {

			OraclePreparedStatement menusStmnt = //
			(OraclePreparedStatement) connection.prepareStatement(Utils.getSQLQueryFromXML("menusSQL", this));

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
			menusStmnt.close();

			// icons
			OraclePreparedStatement iconsStmnt = (OraclePreparedStatement) connection.prepareStatement(Utils.getSQLQueryFromXML("iconsSQL",
					this));
			ResultSet iconsRs = iconsStmnt.executeQuery();
			IconsArr icons = new IconsArr();
			while (iconsRs.next()) {
				icons.put(iconsRs.getInt("icon_id"), iconsRs.getString("icon_file_name"), iconsRs.getString("icon_path"), isScript);
			}
			metadata.setIcons(icons);
			iconsRs.close();
			iconsStmnt.close();

		} catch (Exception e) {
			printErrorStackTrace(e);
		}
		this.debug("session - MenusArr.size=" + metadata.size());
		return metadata;
	}

	public HashMap<String, String> getParamsMap() {
		return paramsMap;
	}

	public ServerInfoMD getServerInfoMD() {
		return serverInfoMD;
	}

	public StaticLookupsArr getStaticLookupsArr() {
		StaticLookupsArr lookupsArr = new StaticLookupsArr();
		String currentLookupCode = "-9999";
		try {
			OraclePreparedStatement lookupsStmnt = (OraclePreparedStatement) connection.prepareStatement(Utils.getSQLQueryFromXML(
					"statLookupsSQL", this));

			ResultSet lookupsRs = lookupsStmnt.executeQuery();
			StaticLookup l = new StaticLookup();
			while (lookupsRs.next()) {
				String lookupCode = lookupsRs.getString("lookup_code");
				String lookupValueCode = lookupsRs.getString("lookup_value_code");
				String lookupDisplayValue = lookupsRs.getString("lookup_display_value");
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
			lookupsStmnt.close();
		} catch (java.sql.SQLException e) {
			printErrorStackTrace(e);
		}
		return lookupsArr;
	}

	public boolean isScript() {
		return isScript;
	}

	public Integer setExportData(FormInstanceIdentifier fi, ExportData exportData) {
		return formDataHashMap.get(fi.getKey()).setExportData(fi, exportData);
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public void setFormDataHashMap(HashMap<String, Form> formDataHashMap) {
		this.formDataHashMap = formDataHashMap;
	}

	private void setParamsMap() {
		try {
			// metadataSQL
			String metadataSQL = Utils.getSQLQueryFromXML("metadataSQL", this);
			OraclePreparedStatement lookupsStmnt = (OraclePreparedStatement) connection.prepareStatement(metadataSQL);
			ResultSet lookupsRs = lookupsStmnt.executeQuery();
			while (lookupsRs.next()) {
				String lookupCode = lookupsRs.getString("param_name");
				String lookupValueCode = lookupsRs.getString("param_value");
				paramsMap.put(lookupCode, lookupValueCode);
			}
			lookupsRs.close();
			lookupsStmnt.close();
		} catch (Exception e) {
			printErrorStackTrace(e);
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

}
