package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.FormTabMD;
import com.abssoft.constructor.client.metadata.FormTabsArr;

/**
 * Данные формы <CODE>formCode</CODE> (метаданные, данные запроса).
 * 
 * @author User
 */
public class Form {
	private HashMap<Integer, FormInstance> formInstance = new HashMap<Integer, FormInstance>();
	private OracleConnection connection;
	private String fcSchemaOwner;

	private String formSQLText;
	private FormColumnsArr metadata = new FormColumnsArr();
	private String formCode;
	private FormMD formMetaData = null;

	public Form(OracleConnection connection, String formCode) {
		this.connection = connection;
		this.formCode = formCode;
		setFormSQLText(formCode);
	}

	public void closeForm(int gridHashCode) {
		Utils.debug("Server:form " + formCode + " - gridHashCode:" + gridHashCode + " before close...");
		formInstance.get(gridHashCode).closeForm();
		formInstance.remove(gridHashCode);
		Utils.debug("Server:form " + formCode + " - gridHashCode:" + gridHashCode + " closed...");
	}

	public Row executeDML(int gridHashCode, Row oldRow, Row newRow, String actionCode, ClientActionType clientActionType)
			throws SQLException {
		Row resultRow = null != newRow ? newRow : oldRow;
		Utils.debug("actionCode:" + actionCode + "; clientActionType:" + clientActionType, resultRow);
		FormActionsArr fActArr = formMetaData.getActions();
		System.out.println("q1");
		FormActionMD fActMD = null;
		for (int i = 0; i < fActArr.size(); i++) {
			System.out.println("q2:" + i);
			if (actionCode.equals(fActArr.get(i).getCode())) {
				System.out.println("q2.1");
				fActMD = fActArr.get(i);
			}

		}
		System.out.println("q3");
		{
			System.out.println("q4");
			String dmlProcText = fActMD.getDmlProcText();
			System.out.println("q5:" + dmlProcText);
			if (null != dmlProcText) {
				OracleCallableStatement stmnt = (OracleCallableStatement) connection.prepareCall(dmlProcText);
				Utils.debug(dmlProcText, resultRow);
				// ----------------------------------
				HashMap<String, String> rowValues = new HashMap<String, String>();
				for (int j = 0; j < resultRow.size(); j++) {
					if (null != newRow && null != oldRow) {
						rowValues.put("P_" + formMetaData.getColumns().get(j).getName(), newRow.get(j));
						rowValues.put("P_OLD_" + formMetaData.getColumns().get(j).getName(), oldRow.get(j));
					} else if (null != newRow) {
						rowValues.put("P_" + formMetaData.getColumns().get(j).getName(), newRow.get(j));
					} else if (null != oldRow) {
						rowValues.put("P_" + formMetaData.getColumns().get(j).getName(), oldRow.get(j));
						rowValues.put("P_OLD_" + formMetaData.getColumns().get(j).getName(), oldRow.get(j));
					}

				}
				// Цикл по IN-параметрам перед выполнением процедуры
				Iterator<Integer> allParamsIterator = fActMD.getAllArgs().keySet().iterator();
				while (allParamsIterator.hasNext()) {
					Integer paramNum = allParamsIterator.next();
					String paramName = fActMD.getAllArgs().get(paramNum);
					if (fActMD.getInputs().containsKey(paramNum)) {
						Utils.debug("IN:" + paramName + " => " + rowValues.get(paramName), resultRow);
						stmnt.setString(paramNum, rowValues.get(paramName));
					}
					if (fActMD.getOutputs().containsKey(paramNum)) {
						stmnt.registerOutParameter(paramNum, Types.VARCHAR);
					}
				}
				stmnt.execute();
				// Цикл по OUT-параметрам. P_OLD_ параметры не обрабатываются - предполагается, что они только IN
				for (int j = 0; j < resultRow.size(); j++) {
					String colName = "P_" + formMetaData.getColumns().get(j).getName();
					if (fActMD.getOutputsByName().containsKey(colName)) {
						String newValue = stmnt.getString(fActMD.getOutputsByName().get(colName));
						Utils.debug("OUT:" + colName + " => " + newValue, resultRow);
						resultRow.remove(j);
						resultRow.put(j, newValue);
					}
				}
				stmnt.close();
				connection.commit();
				// ----------------------------------

			}
		}
		return resultRow;
	}

	public RowsArr fetch(int gridHashCode, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch) {
		if (!formInstance.containsKey(gridHashCode)) {
			formInstance.put(gridHashCode, new FormInstance(connection, formSQLText, formMetaData));
		}
		return formInstance.get(gridHashCode).fetch(sortBy, startRow, endRow, criteria, forceFetch);
	}

	private FormColumnsArr getColumns() {
		try {
			Utils.debug("Parse Query: ");
			Utils.debug(QueryServiceImpl.queryMap.get("ColumnsMetaDataSQL"));
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("ColumnsMetaDataSQL"));
			Utils.debug("Parameters: ");
			Utils.setStringParameterValue(statement, "p_form_code", formCode);
			ResultSet rs = statement.executeQuery();
			int colNum = -1;
			while (rs.next()) {
				colNum++;

				FormColumnMD cmd = new FormColumnMD(); //
				cmd.setDisplayNum(rs.getInt("column_display_number"));
				cmd.setName(rs.getString("column_code"));
				cmd.setDataType(rs.getString("column_data_type"));
				cmd.setDisplayName(rs.getString("column_user_name"));
				cmd.setDisplaySize(rs.getString("column_display_size"));
				cmd.setShowOnGrid(rs.getString("show_on_grid"));
				cmd.setTreeInitializationValue(rs.getString("tree_initialization_value"));
				cmd.setTreeFieldType(rs.getString("tree_field_type"));
				cmd.setEditorTabCode(rs.getString("editor_tab_code"));
				cmd.setFieldType(rs.getString("field_type"));
				cmd.setDescription(rs.getString("column_description"));
				cmd.setPrimaryKey("Y".equals(rs.getString("pimary_key_flag")));
				cmd.setFrozen("Y".equals(rs.getString("is_frozen_flag")));
				cmd.setShowHover("Y".equals(rs.getString("show_hover_flag")));
				cmd.setLookupCode(rs.getString("lookup_code"));
				cmd.setLookupFieldType(rs.getString("lookup_field_type"));
				cmd.setHoverСolumnСode(rs.getString("hover_column_code"));
				cmd.setEditorHeight(rs.getString("editor_height"));
				cmd.setHelpText(rs.getString("help_text"));
				cmd.setTextMask(rs.getString("text_mask"));
				cmd.setValidationRegexp(rs.getString("validation_regexp"));
				cmd.setDefaultOrderByNumber(rs.getString("default_orderby_number"));
				cmd.setDefaultValue(Utils.bindVarsToLowerCase(rs.getString("default_value"), "(?i):[\\w\\$]+", "&", "&"));
				cmd.setEditorTitleOrientation(rs.getString("editor_title_orientation"));
				cmd.setEditorEndRow("Y".equals(rs.getString("editor_end_row_flag")));
				cmd.setEditorColsSpan(rs.getString("editor_cols_span"));
				metadata.put(colNum, cmd);
			}
			// Если распарсить колонки на БД не получилось, пробуем распарсить с
			// помощью Java (statement.getMetaData).
			if (-1 == colNum) {
				Utils.debug("колонки из statement.getMetaData");
				Utils.debug("formSQLText = \n" + formSQLText);

				try {
					System.out.println("connection:" + connection);
					statement = (OraclePreparedStatement) connection.prepareStatement(formSQLText);
					System.out.println("zxxxxxxxxxxxxxxxxxx");
					System.out.println("zzzzzzzzzzzzzzzzzzz");
					// statement.setEscapeProcessing(false);
					Utils.setFilterValues(statement, null);
					rs = statement.executeQuery();
					ResultSetMetaData rsMetaData = statement.getMetaData();
					for (colNum = 0; colNum < rsMetaData.getColumnCount(); colNum++) {
						String colType = "";
						switch (rsMetaData.getColumnType(colNum + 1)) {
						case Types.NUMERIC:
							colType = "N";
							break;
						case Types.DATE:
							colType = "D";
							break;
						default:
							colType = "C";
							break;
						}
						colType = rsMetaData.getColumnType(colNum + 1) + "x";
						FormColumnMD columnMetaData = new FormColumnMD();
						columnMetaData.setDisplayNum(colNum + 1);
						columnMetaData.setName(rsMetaData.getColumnLabel(colNum + 1));
						columnMetaData.setDataType(colType);
						columnMetaData.setShowOnGrid("Y");
						metadata.put(colNum, columnMetaData);
					}
				} catch (java.sql.SQLException e) {
					System.out.println("zzzzzzzzzzz SQLException");
					Utils.debug(e.toString());
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			Utils.debug(e.toString());
			e.printStackTrace();
		}
		return metadata;
	}

	private String getDMLProcText(FormActionMD actionData) throws java.sql.SQLException {
		String dmlProcText = "begin " + actionData.getSqlProcedureName() + "(";
		OraclePreparedStatement actProcStmnt = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
				.get("argsSQLText"));
		Utils.setStringParameterValue(actProcStmnt, "p_procedure_name", actionData.getSqlProcedureName());
		Utils.setStringParameterValue(actProcStmnt, "p_fc_schema_owner", getFcSchemaOwner());
		ResultSet actProcRs = actProcStmnt.executeQuery();
		int argNum = -1;
		while (actProcRs.next()) {
			argNum = actProcRs.getInt("position");
			String argName = actProcRs.getString("argument_name");
			System.out.println("argNum: " + argNum + "; argName: " + argName);
			dmlProcText = dmlProcText + argName + " => ?,";
			actionData.getAllArgs().put(argNum, argName);
			if ("Y".equals(actProcRs.getString("in_flag"))) {
				actionData.getInputs().put(argNum, argName);
			}
			if ("Y".equals(actProcRs.getString("out_flag"))) {
				actionData.getOutputs().put(argNum, argName);
				actionData.getOutputsByName().put(argName, argNum);
			}
		}
		dmlProcText = dmlProcText.substring(0, dmlProcText.length() - (-1 == argNum ? 0 : 1)) + "); end;";
		actProcRs.close();
		actProcStmnt.close();
		return dmlProcText;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	private FormActionsArr getFormActionsArr() {
		boolean insertAllowed = false;
		boolean updateAllowed = false;
		boolean deleteAllowed = false;
		FormActionsArr result = new FormActionsArr();
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("formActionsSQL"));
			Utils.setStringParameterValue(statement, "p_form_code", formCode);
			ResultSet actRs = statement.executeQuery();
			while (actRs.next()) {
				FormActionMD actionData = new FormActionMD();
				actionData.setCode(actRs.getString("action_code"));
				actionData.setDisplayName(actRs.getString("action_display_name"));
				actionData.setIconId(actRs.getInt("icon_id"));
				actionData.setType(actRs.getString("action_type"));
				actionData.setSqlProcedureName(actRs.getString("procedure_name"));
				actionData.setConfirmText(Utils.bindVarsToLowerCase(actRs.getString("confirm_text"), "(?i):[\\w]+", "&", "&"));
				if (null != actionData.getSqlProcedureName()) {
					actionData.setDmlProcText(getDMLProcText(actionData));
				}
				result.add(actionData);

				insertAllowed = ClientActionType.ADD.getValue().equals(actionData.getType()) ? true : insertAllowed;
				updateAllowed = ClientActionType.UPD.getValue().equals(actionData.getType()) ? true : updateAllowed;
				deleteAllowed = ClientActionType.DEL.getValue().equals(actionData.getType()) ? true : deleteAllowed;

			}
			actRs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		result.setInsertAllowed(insertAllowed);
		result.setUpdateAllowed(updateAllowed);
		result.setDeleteAllowed(deleteAllowed);
		return result;
	}

	public FormMD getFormMetaData() {
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("formSQL"));
			Utils.setStringParameterValue(statement, "p_form_code", formCode);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Integer ovn = rs.getInt("object_version_number");
				if (null != formMetaData && null != formMetaData.getColumns() && 0 != formMetaData.getColumns().size()
						&& formMetaData.getObjectVersionNumber() == ovn) {
					Utils.debug(formCode + " FormMetadata exists. Exiting...");
					rs.close();
					statement.close();
					return formMetaData;
				}
				formMetaData = new FormMD();
				Utils.debug("Reading Metadata for " + formCode);
				formMetaData.setFormCode(formCode);
				formMetaData.setHotKey(rs.getString("hot_key"));
				formMetaData.setFormName(rs.getString("form_name"));
				formMetaData.setFormType(rs.getString("form_type"));
				formMetaData.setShowTreeRootNode(rs.getString("show_tree_root_node"));
				formMetaData.setIconId(rs.getInt("icon_id"));
				formMetaData.setWidth(rs.getString("form_width"));
				formMetaData.setHeight(rs.getString("form_height"));
				formMetaData.setBottomTabsPosition(rs.getString("bottom_tabs_orientation"));
				formMetaData.setSideTabsPosition(rs.getString("side_tabs_orientation"));
				formMetaData.setShowBottomToolBar(rs.getString("show_bottom_toolbar").equals("Y") ? true : false);
				formMetaData.setColumns(getColumns());
				formMetaData.setTabs(getFormTabsArr());
				formMetaData.setActions(getFormActionsArr());
				formMetaData.setObjectVersionNumber(ovn);
			}
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		// Принудительно приводим все bind variables к lowerCase
		formSQLText = Utils.bindVarsToLowerCase(formSQLText, "(?i):[\\w\\$]+");
		Utils.debug("Form: getFormMetaData executed...");
		return formMetaData;
	}

	private FormTabsArr getFormTabsArr() {
		FormTabsArr result = new FormTabsArr();
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("detailFormSQL"));
			Utils.setStringParameterValue(statement, "p_form_code", formCode);
			ResultSet detRs = statement.executeQuery();
			while (detRs.next()) {
				FormTabMD tabData = new FormTabMD();
				tabData.setTabCode(detRs.getString("tab_code"));
				tabData.setChildFormCode(detRs.getString("child_form_code"));
				tabData.setTabPosition(detRs.getString("tab_position"));
				tabData.setTabName(detRs.getString("tab_name"));
				tabData.setNumberOfColumns(detRs.getInt("number_of_columns"));
				tabData.setIconId(detRs.getInt("icon_id"));
				tabData.setTabType(detRs.getString("tab_type"));
				result.add(tabData);
			}
			detRs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public int getInstancesCount() {
		return formInstance.size();
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	private void setFormSQLText(String formCode) {

		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(QueryServiceImpl.queryMap
					.get("extendedFormSQL"));
			Utils.setStringParameterValue(statement, "p_form_code", formCode);
			ResultSet rs = statement.executeQuery();
			rs.next();
			formSQLText = rs.getString(1);
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
	}
}
