package com.abssoft.constructor.server;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.IconsArr;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.abssoft.constructor.client.metadata.StaticLookup;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;

/**
 * Данные сессии приложения - метаданные, <CODE>Connection</CODE>. Хранит {@link Form}
 * 
 * @author User
 */
public class Session {

	private OracleConnection connection;
	private boolean isScript;
	private HashMap<String, Form> formDataHashMap = new HashMap<String, Form>();

	public HashMap<String, Form> getFormDataHashMap() {
		return formDataHashMap;
	}

	public void setFormDataHashMap(HashMap<String, Form> formDataHashMap) {
		this.formDataHashMap = formDataHashMap;
	}

	private String fcSchemaOwner;

	public Session(Connection connection) {
		this.connection = (OracleConnection) connection;
		getStaticLookupsArr();
	}

	public void closeForm(FormInstanceIdentifier fi, FormMD formState) {
		// formIdentifier
		Utils.debug("Server:session form " + fi.getInfo() + " before close...");
		formDataHashMap.get(fi.getKey()).closeForm(fi.getGridHashCode(), formState);
		// TODO Было закомментировано: Во избежание повторной вычитки настроек формы. Но тогда возникают проблемы при изменении формы на
		// лету. Приходится делать реконнект. Раскомментировал. Предусмотреть режимы работы debug и рабочий. Или забить - пусть так будет.
		// А еще лучше - при старте сессии вычитывать настройки всех форм, а потом только перечитывать при изменении OVN.
		int instCount = formDataHashMap.get(fi.getKey()).getInstancesCount();
		System.out.println("Form " + fi.getFormCode() + " instances: " + instCount);
		if (0 == instCount) {
			formDataHashMap.remove(fi.getKey());
		}
		Utils.debug("Server:session form " + fi.getInfo() + " closed...");
	}

	public Row executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow, String actionCode, ClientActionType clientActionType)
			throws SQLException, Exception {
		return formDataHashMap.get(fi.getKey()).executeDML(fi.getGridHashCode(), oldRow, newRow, actionCode, clientActionType);
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

	public FormMD getFormMetaData(FormInstanceIdentifier formIdentifier) throws SQLException {
		return getFormMetaData(formIdentifier, true);
	}

	public FormMD getFormMetaData(FormInstanceIdentifier fi, boolean isNonLookupForm) throws SQLException {
		// String formMapKey = (null == parentFormCode) ? formCode : formCode + "." + parentFormCode;
		if (!formDataHashMap.containsKey(fi.getKey())) {
			Form form = new Form(connection, fi.getFormCode(), fi.getParentFormCode(), fi.getIsDrillDownForm(), this);
			form.setFcSchemaOwner(fcSchemaOwner);
			formDataHashMap.put(fi.getKey(), form);
		}
		return formDataHashMap.get(fi.getKey()).getFormMetaData();
	}

	public MenusArr getMenusArrOld() {
		MenusArr metadata = new MenusArr();
		try {
			OraclePreparedStatement statement = //
			(OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap.get("menusSQL"));
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String formCode = rs.getString("form_code");
				// String formName = rs.getString("form_name");
				String formName = rs.getString("menu_name");
				MenuMD menu = new MenuMD();
				menu.setFormCode(formCode);
				menu.setFormName(formName);
				menu.setIconId(rs.getInt("icon_id"));
				menu.setHotKey(rs.getString("hot_key"));
				menu.setDescription(rs.getString("description"));
				//
				menu.setLvl(rs.getString("lvl"));
				menu.setMenuCode(rs.getString("menu_code"));
				menu.setParentMenuCode(rs.getString("parent_menu_code"));
				menu.setMenuPosition(rs.getString("menu_position"));
				menu.setShowInNavigator(rs.getString("show_in_navigator"));
				menu.setMenuName(rs.getString("menu_name"));
				menu.setChildCount(rs.getInt("child_count"));

				metadata.add(menu);
			}
			rs.close();
			// icons
			statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap.get("iconsSQL"));
			rs = statement.executeQuery();
			IconsArr icons = new IconsArr();
			while (rs.next()) {
				icons.put(rs.getInt("icon_id"), rs.getString("icon_file_name"), rs.getString("icon_path"), isScript);
			}
			rs.close();
			statement.close();
			metadata.setIcons(icons);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("Server:session - MenusArr.size=" + metadata.size());
		return metadata;
	}

	public StaticLookupsArr getStaticLookupsArr() {
		StaticLookupsArr lookupsArr = new StaticLookupsArr();
		String currentLookupCode = "-9999";
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("statLookupsSQL"));
			ResultSet rs = statement.executeQuery();
			StaticLookup l = new StaticLookup();
			while (rs.next()) {
				String lookupCode = rs.getString("lookup_code");
				String lookupValueCode = rs.getString("lookup_value_code");
				String lookupDisplayValue = rs.getString("lookup_display_value");
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
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		return lookupsArr;
	}

	public boolean isScript() {
		return isScript;
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public void setScript(boolean isScript) {
		this.isScript = isScript;
	}

}
