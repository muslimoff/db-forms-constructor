package com.abssoft.constructor.server;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.IconsArr;
import com.abssoft.constructor.client.metadata.MenuMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.StaticLookup;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;

/**
 * Данные сессии приложения - метаданные, <CODE>Connection</CODE>. Хранит
 * {@link Form}
 * 
 * @author User
 */
public class Session {

	private OracleConnection connection;
	private HashMap<String, Form> formDataHashMap = new HashMap<String, Form>();

	public OracleConnection getConnection() {
		return connection;
	}

	public Session(Connection connection) {
		this.connection = (OracleConnection) connection;
		getStaticLookupsArr();
	}

	public MenusArr getMenusArr() {
		MenusArr metadata = new MenusArr();
		String menusSQL = "Select a.form_code, a.hot_key, a.form_name, a.description, a.icon_id From forms_v a order by a.form_name";
		String iconsSQL = "Select i.icon_id, i.icon_file_name From icons i";
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(menusSQL);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				String formCode = rs.getString("form_code");
				MenuMD col = new MenuMD(formCode, rs.getString("hot_key"), rs.getString("form_name"), rs.getString("description"), rs
						.getInt("icon_id"));
				metadata.put(formCode, col);
			}
			rs.close();
			// icons
			statement = (OraclePreparedStatement) connection.prepareStatement(iconsSQL);
			rs = statement.executeQuery();
			IconsArr icons = new IconsArr();
			while (rs.next()) {
				icons.put(rs.getInt("icon_id"), rs.getString("icon_file_name"));
			}
			rs.close();
			statement.close();
			metadata.setIcons(icons);
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		return metadata;
	}

	public StaticLookupsArr getStaticLookupsArr() {
		String statLookupsSQL = "Select l.lookup_code, lv.lookup_value_code, lv.lookup_display_value \n"
				+ "From lookups l, lookup_values lv \n" + "Where l.lookup_code = lv.lookup_code\n"
				+ "Order By l.lookup_code, lv.lookup_value_code";
		StaticLookupsArr lookupsArr = new StaticLookupsArr();
		String currentLookupCode = "-9999";
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(statLookupsSQL);
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

	public FormMD getFormMetaData(String formCode) {
		if (!formDataHashMap.containsKey(formCode)) {
			formDataHashMap.put(formCode, new Form(connection, formCode));
		}
		return formDataHashMap.get(formCode).getFormMetaData();
	}

	public RowsArr fetch(String formCode, int gridHashCode, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch) {
		return formDataHashMap.get(formCode).fetch(gridHashCode, sortBy, startRow, endRow, criteria, forceFetch);
	}

	public Row executeDML(String formCode, int gridHashCode, Row row, String actionCode, ClientActionType clientActionType)
			throws SQLException {
		return formDataHashMap.get(formCode).executeDML(gridHashCode, row, actionCode, clientActionType);
	}

	public void closeForm(String formCode, int gridHashCode) {
		formDataHashMap.get(formCode).closeForm(gridHashCode);
		// if (0 == formDataHashMap.get(formCode).getInstancesCount()) {
		// formDataHashMap.remove(formCode); }
		Utils.debug("Server:session form " + formCode + " - gridHashCode:" + gridHashCode + " closed...");
	}

}
