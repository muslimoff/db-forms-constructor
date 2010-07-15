package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.metadata.Attribute;
import com.abssoft.constructor.client.metadata.FormActionMD;
import com.abssoft.constructor.client.metadata.FormActionsArr;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormInstanceIdentifier;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.FormTabMD;
import com.abssoft.constructor.client.metadata.FormTabsArr;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;

/**
 * Данные формы <CODE>formCode</CODE> (метаданные, данные запроса).
 * 
 * @author User
 */
public class Form {
	private HashMap<Integer, FormInstance> formInstance = new HashMap<Integer, FormInstance>();

	public HashMap<Integer, FormInstance> getFormInstance() {
		return formInstance;
	}

	public void setFormInstance(HashMap<Integer, FormInstance> formInstance) {
		this.formInstance = formInstance;
	}

	private OracleConnection connection;
	private String fcSchemaOwner;
	private String formSQLText;
	private FormColumnsArr metadata = new FormColumnsArr();
	private String formCode;
	private String parentFormCode;
	private FormMD formMetaData = null;
	private ArrayList<Integer> formLookupsIdx = new ArrayList<Integer>();
	private Session session;
	private Boolean isDrillDownForm;

	public Form(OracleConnection connection, String formCode, String parentFormCode, Boolean isDrillDownForm, Session session) {
		this.setConnection(connection);
		this.formCode = formCode;
		this.parentFormCode = parentFormCode;
		this.setIsDrillDownForm(isDrillDownForm);
		this.session = session;
		setFormSQLText();
		Utils.debug("" + this);
	}

	public void closeForm(int gridHashCode, FormMD formState) {
		Utils.debug("Server:form " + formCode + " - gridHashCode:" + gridHashCode + " before close...");
		formInstance.get(gridHashCode).closeForm();
		formInstance.remove(gridHashCode);
		if (0 == getInstancesCount()) {
			Utils.debug("Server:form " + formCode + " - gridHashCode:" + gridHashCode + " save current state for User...");
			Utils.debug("formState:" + formState + "; FormCode:" + formState.getFormCode());
			// TODO Обработка состояния формы при закрытии: FormMD formState - сохранение ширин, сортировок и прочей хери.
		}
		Utils.debug("Server:form " + formCode + " - gridHashCode:" + gridHashCode + " closed...");
	}

	public Row executeDML(int gridHashCode, Row oldRow, Row newRow, String actionCode, ClientActionType clientActionType)
			throws SQLException, Exception {
		Row resultRow = null != newRow ? newRow : oldRow;
		Utils.debug("actionCode:" + actionCode + "; clientActionType:" + clientActionType, resultRow);
		FormActionsArr fActArr = formMetaData.getActions();
		FormActionMD fActMD = null;
		for (int i = 0; i < fActArr.size(); i++) {
			if (actionCode.equals(fActArr.get(i).getCode())) {
				fActMD = fActArr.get(i);
			}

		}
		{
			String dmlProcText = fActMD.getDmlProcText();
			if (null != dmlProcText) {
				OracleCallableStatement stmnt = (OracleCallableStatement) getConnection().prepareCall(dmlProcText);
				Utils.debug(dmlProcText, resultRow);
				// ----------------------------------
				HashMap<String, Attribute> rowValues = new HashMap<String, Attribute>();
				for (int j = 0; j < resultRow.size(); j++) {
					String newParamName = "P_" + formMetaData.getColumns().get(j).getName();
					String oldParamName = "P_OLD_" + formMetaData.getColumns().get(j).getName();
					// TODO Оптимизировать код
					if (null != newRow && null != oldRow) {
						rowValues.put(newParamName, newRow.get(j));
						rowValues.put(oldParamName, oldRow.get(j));
					} else if (null != newRow) {
						rowValues.put(newParamName, newRow.get(j));
						// rowValues.put(oldParamName, newRow.get(j));
						rowValues.put(oldParamName, new Attribute());
					} else if (null != oldRow) {
						rowValues.put(newParamName, oldRow.get(j));
						// rowValues.put(newParamName, new Attribute());
						rowValues.put(oldParamName, oldRow.get(j));
					}
					// Attribute newVal = (null != newRow) ? newRow.get(j) : new Attribute();
					// Attribute oldVal = (null != oldRow) ? oldRow.get(j) : newRow.get(j);
					// rowValues.put(newParamName, newVal);
					// rowValues.put(oldParamName, oldVal);
				}
				// Цикл по IN-параметрам перед выполнением процедуры
				Iterator<Integer> allParamsIterator = fActMD.getAllArgs().keySet().iterator();
				while (allParamsIterator.hasNext()) {
					int paramNum = allParamsIterator.next();
					int outParamType = Types.VARCHAR;
					String paramName = fActMD.getAllArgs().get(paramNum);
					if (fActMD.getInputs().containsKey(paramNum)) {
						Attribute attr = rowValues.get(paramName);
						Object val = attr.getAttributeAsObject();
						if (null != val) {
							if (val instanceof java.util.Date) {
								// Converting java.util.Date to java.sql.Date
								stmnt.setDate(paramNum, new java.sql.Date(((java.util.Date) val).getTime()));
								outParamType = Types.DATE;
							} else if (val instanceof Double) {
								stmnt.setDouble(paramNum, (Double) val);
								outParamType = Types.DOUBLE;
							} else if (val instanceof Boolean) {
								stmnt.setString(paramNum, ((Boolean) val) ? "Y" : "N");
								outParamType = Types.VARCHAR;
							} else {
								stmnt.setString(paramNum, (String) val);
							}
						} else {
							stmnt.setString(paramNum, null);
						}
						Utils.debug("(" + attr.getDataType() + ")" + "IN:" + paramName + " => " + val + ";", resultRow);
					}
					if (fActMD.getOutputs().containsKey(paramNum)) {
						stmnt.registerOutParameter(paramNum, outParamType);
					}
				}
				stmnt.execute();
				// Цикл по OUT-параметрам. P_OLD_ параметры не обрабатываются - предполагается, что они только IN
				for (int j = 0; j < resultRow.size(); j++) {
					String colName = "P_" + formMetaData.getColumns().get(j).getName();
					if (fActMD.getOutputsByName().containsKey(colName)) {
						String dataType = resultRow.get(j).getDataType();
						resultRow.remove(j);
						Integer colIdx = fActMD.getOutputsByName().get(colName);
						Attribute attr = Utils.getAttribute(colIdx, dataType, stmnt);
						Utils.debug("(" + dataType + ")" + "OUT:" + colName + " => " + attr.getAttribute() + "; is null:"
								+ (null == attr.getAttribute()), resultRow);
						resultRow.put(j, attr);
					}
				}
				stmnt.close();
				getConnection().commit();
				// ----------------------------------

			}
		}
		return resultRow;
	}

	public RowsArr fetch(int gridHashCode, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch)
			throws SQLException {
		if (!formInstance.containsKey(gridHashCode)) {
			formInstance.put(gridHashCode, new FormInstance(this));
		}
		return formInstance.get(gridHashCode).fetch(sortBy, startRow, endRow, criteria, forceFetch);
	}

	private FormColumnsArr getColumns() {
		try {
			Utils.debug("Parse Query: ");
			Utils.debug(QueryServiceImpl.queryMap.get("ColumnsMetaDataSQL"));
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(
					QueryServiceImpl.queryMap.get("ColumnsMetaDataSQL"));
			Utils.debug("Parameters: ");
			Utils.setFormMDParams(statement, formCode, parentFormCode, isDrillDownForm);
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
				cmd.setLookupDisplayValue(rs.getString("lookup_display_value"));
				metadata.put(colNum, cmd);
				if (null != cmd.getLookupCode()) {
					formLookupsIdx.add(colNum);
				}
			}
			// Если распарсить колонки на БД не получилось, пробуем распарсить с
			// помощью Java (statement.getMetaData).
			if (-1 == colNum) {
				Utils.debug("колонки из statement.getMetaData");
				Utils.debug("formSQLText = \n" + getFormSQLText());

				try {
					statement = (OraclePreparedStatement) getConnection().prepareStatement(getFormSQLText());
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
		OraclePreparedStatement actProcStmnt = (OraclePreparedStatement) getConnection().prepareStatement(
				QueryServiceImpl.queryMap.get("argsSQLText"));
		Utils.setParameterValue(actProcStmnt, "p_procedure_name", actionData.getSqlProcedureName());
		Utils.setParameterValue(actProcStmnt, "p_fc_schema_owner", getFcSchemaOwner());
		// Utils.setFormMDParams(actProcStmnt, formCode, parentFormCode);
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
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(
					QueryServiceImpl.queryMap.get("formActionsSQL"));
			// Utils.setStringParameterValue(statement, "p_form_code", formCode);
			Utils.setFormMDParams(statement, formCode, parentFormCode, isDrillDownForm);
			ResultSet actRs = statement.executeQuery();
			while (actRs.next()) {
				FormActionMD actionData = new FormActionMD();
				actionData.setCode(actRs.getString("action_code"));
				actionData.setIconId(actRs.getInt("icon_id"));
				actionData.setType(actRs.getString("action_type"));
				// actionData.setSqlProcedureName(actRs.getString("procedure_name"));
				actionData.setSqlProcedureName(Utils.bindVarsToLowerCase(actRs.getString("procedure_name"), "(?i):[\\w]+", ":", ":"));
				actionData.setConfirmText(Utils.bindVarsToLowerCase(actRs.getString("confirm_text"), "(?i):[\\w]+", "&", "&"));
				actionData.setDisplayName(Utils.bindVarsToLowerCase(actRs.getString("action_display_name"), "(?i):[\\w]+", "&", "&"));
				// actionData.setDisplayName(actRs.getString("action_display_name"));
				if (null != actionData.getSqlProcedureName()) {
					actionData.setDmlProcText(getDMLProcText(actionData));
				}
				actionData.setHotKey(actRs.getString("hot_key"));
				actionData.setShowSeparatorBelow("Y".equals(actRs.getString("show_separator_below")));
				actionData.setDisplayOnToolbar("Y".equals(actRs.getString("display_on_toolbar")));
				actionData.setChildFormCode(actRs.getString("child_form_code"));
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

	public FormMD getFormMetaData() throws SQLException {
		return getFormMetaData(true);
	}

	public FormMD getFormMetaData(boolean isNonLookupForm) throws SQLException {

		OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(
				QueryServiceImpl.queryMap.get("formSQL"));
		// Utils.setStringParameterValue(statement, "p_form_code", formCode);
		Utils.setFormMDParams(statement, formCode, parentFormCode, isDrillDownForm);
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
			formMetaData.setDoubleClickActionCode(rs.getString("double_click_action_code"));
			formMetaData.setLookupWidth(rs.getString("lookup_width"));
			formMetaData.setColumns(getColumns());
			formMetaData.setObjectVersionNumber(ovn);
			if (isNonLookupForm) {
				formMetaData.setTabs(getFormTabsArr());
				formMetaData.setActions(getFormActionsArr());
			}

		}
		rs.close();
		statement.close();

		// Принудительно приводим все bind variables к lowerCase
		setFormSQLText(Utils.bindVarsToLowerCase(getFormSQLText(), "(?i):[\\w\\$]+"));
		Utils.debug("Form: Lookups Metadata...\n" + getFormSQLText());
		for (int i = 0; i < formLookupsIdx.size(); i++) {
			FormColumnMD cmd = formMetaData.getColumns().get(formLookupsIdx.get(i));
			String formLookupCode = cmd.getLookupCode();
			if ("9".equals(cmd.getFieldType()) || "99".equals(cmd.getFieldType())) {
				FormInstanceIdentifier fi = new FormInstanceIdentifier();
				fi.setFormCode(formLookupCode);
				FormMD fmd = session.getFormMetaData(fi, false);
				if (null != fmd) {
					formMetaData.getLookupsArr().put(formLookupCode, fmd);
					Utils.debug("***: " + formMetaData.getLookupsArr().get(formLookupCode).getFormCode());
				}
			}
			if ("8".equals(cmd.getFieldType())) {
				// TODO Static Lookups - вычитывать для формы
			}
		}
		Utils.debug("Form: Lookups Metadata finished...");
		Utils.debug("Form: getFormMetaData(" + formCode + ") executed...");
		return formMetaData;
	}

	private FormTabsArr getFormTabsArr() {
		FormTabsArr result = new FormTabsArr();
		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(
					QueryServiceImpl.queryMap.get("detailFormSQL"));
			// TODO Utils.setStringParameterValue(statement, "p_form_code", formCode);
			// TODO Utils.setStringParameterValue(statement, "p_master_form_code", parentFormCode);
			Utils.setFormMDParams(statement, formCode, parentFormCode, isDrillDownForm);
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

	private void setFormSQLText() {

		try {
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(
					QueryServiceImpl.queryMap.get("extendedFormSQL"));
			Utils.setFormMDParams(statement, formCode, parentFormCode, isDrillDownForm);
			ResultSet rs = statement.executeQuery();
			rs.next();
			formSQLText = rs.getString(1);
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
	}

	public void setIsDrillDownForm(Boolean isDrillDownForm) {
		this.isDrillDownForm = isDrillDownForm;
	}

	public Boolean getIsDrillDownForm() {
		return isDrillDownForm;
	}

	public void setFormSQLText(String formSQLText) {
		this.formSQLText = formSQLText;
	}

	public String getFormSQLText() {
		return formSQLText;
	}

	public void setConnection(OracleConnection connection) {
		this.connection = connection;
	}

	public OracleConnection getConnection() {
		return connection;
	}
}
