package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;

import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.Attribute;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormActionsArr;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.FormTabsArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.ColumnAction;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.FormTabMD;

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

	public Session getSession() {
		return session;
	}

	private Boolean isDrillDownForm;

	public Form(OracleConnection connection, String formCode, String parentFormCode, Boolean isDrillDownForm, Session session) {
		this.setConnection(connection);
		this.setFormCode(formCode);
		this.parentFormCode = parentFormCode;
		this.setIsDrillDownForm(isDrillDownForm);
		this.session = session;
		setFormSQLText();
		session.debug("" + this);
	}

	public void closeForm(int gridHashCode, FormMD formState) {
		session.debug("form " + getFormCode() + " - gridHashCode:" + gridHashCode + " before close...");
		formInstance.get(gridHashCode).closeForm();
		formInstance.remove(gridHashCode);
		if (0 == getInstancesCount()) {
			session.debug("form " + getFormCode() + " - gridHashCode:" + gridHashCode + " save current state for User...");
			session.debug("formState:" + formState + "; FormCode:" + formState.getFormCode());
			// TODO Обработка состояния формы при закрытии: FormMD formState - сохранение ширин, сортировок и прочей хери.
		}
		session.debug("form " + getFormCode() + " - gridHashCode:" + gridHashCode + " closed...");
	}

	public Row executeDML(int gridHashCode, Row oldRow, Row newRow, FormActionMD actMD) throws SQLException, Exception {
		Row resultRow = null != newRow ? newRow : oldRow;
		// String statusMsgLevelParamName = null;
		// String statusMsgTxtParamName = null;
		session.debug("actionCode:" + actMD.getCode() + "; Type:" + actMD.getType(), resultRow);
		{
			String dmlProcText = actMD.getDmlProcText();
			if (null != dmlProcText) {
				OracleCallableStatement stmnt = (OracleCallableStatement) getConnection().prepareCall(dmlProcText);
				session.debug(dmlProcText, resultRow);
				// ----------------------------------
				HashMap<String, Attribute> rowValues = new HashMap<String, Attribute>();
				HashMap<String, Boolean> isClobHM = new HashMap<String, Boolean>();
				for (int j = 0; j < resultRow.size(); j++) {
					String newParamName = "P_" + formMetaData.getColumns().get(j).getName();
					String oldParamName = "P_OLD_" + formMetaData.getColumns().get(j).getName();
					if ("CLOB".equals(formMetaData.getColumns().get(j).getDataType())) {
						isClobHM.put(newParamName, true);
						isClobHM.put(oldParamName, true);
					}
					if (null != newRow && null != oldRow) {
						rowValues.put(newParamName, newRow.get(j));
						rowValues.put(oldParamName, oldRow.get(j));
					} else if (null != newRow) {
						rowValues.put(newParamName, newRow.get(j));
						rowValues.put(oldParamName, new Attribute());
					} else if (null != oldRow) {
						rowValues.put(newParamName, oldRow.get(j));
						rowValues.put(oldParamName, oldRow.get(j));
					}
				}
				// Цикл по IN-параметрам перед выполнением процедуры
				Iterator<Integer> allParamsIterator = actMD.getAllArgs().keySet().iterator();
				while (allParamsIterator.hasNext()) {
					int paramNum = allParamsIterator.next();
					int outParamType = Types.VARCHAR;
					String paramName = actMD.getAllArgs().get(paramNum);

					if (isClobHM.containsKey(paramName)) {
						outParamType = Types.CLOB;
					}
					if (actMD.getInputs().containsKey(paramNum)) {
						Attribute attr = rowValues.get(paramName);
						attr = (null == attr) ? new Attribute() : attr;
						Object val = (null != attr) ? attr.getAttributeAsObject() : null;
						String dType = attr.getDataType();
						if ("D".equals(dType)) {
							outParamType = Types.DATE;
							// Converting java.util.Date to java.sql.Date
							java.sql.Date dt = (null != val) ? new java.sql.Date(((java.util.Date) val).getTime()) : null;
							stmnt.setDate(paramNum, dt);
						} else if ("N".equals(dType)) {
							outParamType = Types.DOUBLE;
							if (null == val) {
								stmnt.setString(paramNum, null);
								outParamType = Types.VARCHAR;
							} else {
								stmnt.setDouble(paramNum, (Double) val);
							}
						} else if ("B".equals(dType)) {
							outParamType = Types.VARCHAR;
							stmnt.setString(paramNum, ((Boolean) val) ? "Y" : "N");
						} else {
							if (isClobHM.containsKey(paramName)) {
								Integer clobId = (null != val) ? Integer.valueOf((String) val) : null;
								CLOB clb = formInstance.get(gridHashCode).getClobHM().get(clobId);
								session.debug("clob: " + clb + "; clobId:" + clobId);
								stmnt.setCLOB(paramNum, clb);
							} else {
								stmnt.setString(paramNum, (String) val);
							}
						}
						session.debug("(" + (null != attr ? attr.getDataType() : null) + ")" + "IN:" + paramName + " => " + val
								+ "; class:" + ((null != val) ? val.getClass() : "null") + "; is null:" + (val == null), resultRow);
					}

					if (actMD.getOutputs().containsKey(paramNum)) {
						session.debug("registerOutParameter. paramName: " + paramName + "; paramNum:" + paramNum + "; outParamType:"
								+ outParamType, resultRow);
						((OracleCallableStatement) stmnt).registerOutParameter(paramNum, outParamType);

					}
				}

				// Обработка сообщения
				ActionStatus.StatusType msgLvl = ActionStatus.StatusType.SUCCESS;
				String msgText = null;
				stmnt.execute();
				// Цикл по OUT-параметрам. P_OLD_ параметры не обрабатываются - предполагается, что они только IN
				for (int j = 0; j < resultRow.size(); j++) {
					// System.out.println(">>>" + resultRow.get(j).getDataType());
					String colName = "P_" + formMetaData.getColumns().get(j).getName();
					if (actMD.getOutputsByName().containsKey(colName)) {
						String dataType = resultRow.get(j).getDataType();
						if (isClobHM.containsKey(colName)) {
							dataType = "CLOB";
						}
						resultRow.remove(j);
						Integer colIdx = actMD.getOutputsByName().get(colName);
						Attribute attr = Utils.getAttribute(colIdx, dataType, stmnt, formInstance.get(gridHashCode));
						session.debug("(" + dataType + ")" + "OUT:" + colName + " => " + attr.getAttribute() + "; is null:"
								+ (null == attr.getAttribute()), resultRow);
						resultRow.put(j, attr);

						// Обработка сообщения
						if (colName.equals("P_" + actMD.getStatusMsgLevelParam())) {
							// statusMsgLevelParamName = "P_" + colName;
							String msgLvlTxt = attr.getAttribute();
							msgLvl = null == msgLvlTxt ? ActionStatus.StatusType.WARNING : ActionStatus.StatusType.valueOf(msgLvlTxt);
						}

						if (colName.equals("P_" + actMD.getStatusMsgTxtParam())) {
							// statusMsgTxtParamName = "P_" + colName;
							msgText = attr.getAttribute();
						}

					}
				}
				// Обработка сообщения
				// if (!"".equals(msgText) && null != msgText) {
				ActionStatus status = resultRow.getStatus();
				// String longTxt = status.getLongMessageText() + "\n";
				// longTxt = longTxt + "StatusTxt(" + statusMsgTxtParamName + "): " + msgText;
				// longTxt = longTxt + "StatusLvl(" + statusMsgLevelParamName + "): " + msgLvl;
				// status.setLongMessageText(longTxt);
				status.setStatusType(msgLvl);
				status.setWarnMsg(msgText);
				status.setWarnButtonIdx((Integer) null);
				resultRow.setStatus(status);

				// }
				stmnt.close();
				if (actMD.getAutoCommit()) {
					session.debug("Auto Commit complete...", resultRow);
					getConnection().commit();
				} else {
					session.debug("Auto Commit disabled...", resultRow);
				}
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
			{
				session.debug("Parse Query: ");
				String ColumnsMetaDataSQL = Utils.getSQLQueryFromXML("ColumnsMetaDataSQL", session);
				session.debug(ColumnsMetaDataSQL);
				OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(ColumnsMetaDataSQL);
				session.debug("Parameters: ");
				Utils.setFormMDParams(session, statement, getFormCode(), parentFormCode, isDrillDownForm);
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
					cmd.setDefaultValue(Utils.bindVarsToLowerCase(session, rs.getString("default_value"), "(?i):[\\w\\$]+", "&", "&"));
					cmd.setEditorTitleOrientation(rs.getString("editor_title_orientation"));
					cmd.setEditorEndRow("Y".equals(rs.getString("editor_end_row_flag")));
					cmd.setEditorColsSpan(rs.getString("editor_cols_span"));
					cmd.setLookupDisplayValue(rs.getString("lookup_display_value"));
					cmd.setEditorOnEnterKeyAction(rs.getString("editor_on_enter_key_action"));
					metadata.put(colNum, cmd);
					if (null != cmd.getLookupCode()) {
						formLookupsIdx.add(colNum);
					}
				}
				rs.close();
				statement.close();
			}
			{
				// get Column Attributes
				String columnAttributesSQL = Utils.getSQLQueryFromXML("columnAttributesSQL", session);
				OraclePreparedStatement attrStmnt = (OraclePreparedStatement) getConnection().prepareStatement(columnAttributesSQL);
				Utils.setFormMDParams(session, attrStmnt, getFormCode(), parentFormCode, isDrillDownForm);
				ResultSet attrRS = attrStmnt.executeQuery();
				while (attrRS.next()) {
					String colName = attrRS.getString("column_code");
					String attrCode = attrRS.getString("attribute_code");
					String attrValue = attrRS.getString("attribute_value");
					metadata.get(colName).getLookupAttributes().put(attrCode, attrValue);
				}
				attrRS.close();
				attrStmnt.close();
			}

			{
				// get Column Actions
				String columnActionsSQL = Utils.getSQLQueryFromXML("columnActionsSQL", session);
				OraclePreparedStatement actStmnt = (OraclePreparedStatement) getConnection().prepareStatement(columnActionsSQL);
				Utils.setFormMDParams(session, actStmnt, getFormCode(), parentFormCode, isDrillDownForm);
				ResultSet colActsRS = actStmnt.executeQuery();
				while (colActsRS.next()) {
					String colName = colActsRS.getString("column_code");
					ColumnAction ca = new ColumnAction();
					ca.setActionCode(colActsRS.getString("action_code"));
					ca.setActionKeyCode(colActsRS.getString("action_key_code"));
					ca.setColActionTypeCode(colActsRS.getString("col_action_type_code"));
					metadata.get(colName).getColActions().add(ca);
				}
				colActsRS.close();
				actStmnt.close();
			}
		} catch (java.sql.SQLException e) {
			session.printErrorStackTrace(e);
		}
		return metadata;
	}

	private String getDMLProcText(FormActionMD actionData) throws java.sql.SQLException {
		String dmlProcText = "begin " + actionData.getSqlProcedureName() + "(";
		String argsSQLText = Utils.getSQLQueryFromXML("argsSQLText", session);
		OraclePreparedStatement actProcStmnt = (OraclePreparedStatement) getConnection().prepareStatement(argsSQLText);
		Utils.setParameterValue(session, actProcStmnt, "p_procedure_name", actionData.getSqlProcedureName());
		Utils.setParameterValue(session, actProcStmnt, "p_fc_schema_owner", getFcSchemaOwner());
		// Utils.setFormMDParams(actProcStmnt, formCode, parentFormCode);
		ResultSet actProcRs = actProcStmnt.executeQuery();
		int argNum = -1;
		while (actProcRs.next()) {
			argNum = actProcRs.getInt("position");
			String argName = actProcRs.getString("argument_name");
			String argType = actProcRs.getString("data_type");
			session.debug("argNum: " + argNum + "; argName: " + argName + "(" + argType + ")");
			dmlProcText = dmlProcText + argName + " => ?,";
			actionData.getAllArgs().put(argNum, argName);
			actionData.getAllDataTypes().put(argNum, argType);
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
		dmlProcText = Utils.getSQLwUserVarsReplaced(dmlProcText, session);
		return dmlProcText;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	private FormActionsArr getFormActionsArr() {
		FormActionsArr result = new FormActionsArr();
		try {
			String formActionsSQL = Utils.getSQLQueryFromXML("formActionsSQL", session);
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(formActionsSQL);
			Utils.setFormMDParams(session, statement, getFormCode(), parentFormCode, isDrillDownForm);
			ResultSet actRs = statement.executeQuery();
			while (actRs.next()) {
				FormActionMD actionData = new FormActionMD();
				actionData.setCode(actRs.getString("action_code"));
				actionData.setIconId(actRs.getInt("icon_id"));
				actionData.setType(actRs.getString("action_type"));
				actionData.setSqlProcedureName(Utils.bindVarsToLowerCase(session, actRs.getString("procedure_name"), "(?i):[\\w]+", ":",
						":"));
				actionData.setConfirmText(Utils.bindVarsToLowerCase(session, actRs.getString("confirm_text"), "(?i):[\\w]+", "&", "&"));
				actionData.setDisplayName(Utils.bindVarsToLowerCase(session, actRs.getString("action_display_name"), "(?i):[\\w]+", "&",
						"&"));
				if (null != actionData.getSqlProcedureName()) {
					actionData.setDmlProcText(getDMLProcText(actionData));
				}
				actionData.setHotKey(actRs.getString("hot_key"));
				actionData.setShowSeparatorBelow("Y".equals(actRs.getString("show_separator_below")));
				actionData.setDisplayOnToolbar("Y".equals(actRs.getString("display_on_toolbar")));
				actionData.setChildFormCode(actRs.getString("child_form_code"));
				actionData.setUrlText(Utils.bindVarsToLowerCase(session, actRs.getString("url_text"), "(?i):[\\w]+", ":", ":"));
				actionData.setParentActionCode(actRs.getString("parent_action_code"));
				actionData.setDisplayInContextMenu("Y".equals(actRs.getString("display_in_context_menu")));
				actionData.setAutoCommit("Y".equals(actRs.getString("autocommit")));
				actionData.setStatusButtonParam(actRs.getString("status_button_param"));
				actionData.setStatusMsgLevelParam(actRs.getString("status_msg_level_param"));
				actionData.setStatusMsgTxtParam(actRs.getString("status_msg_txt_param"));

				result.add(actionData);
			}
			actRs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			session.printErrorStackTrace(e);
		}
		return result;
	}

	public FormMD getFormMetaData() throws SQLException {
		return getFormMetaData(true);
	}

	public FormMD getFormMetaData(boolean isNonLookupForm) throws SQLException {
		String formSQL = Utils.getSQLQueryFromXML("formSQL", session);
		OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(formSQL);
		// Utils.setStringParameterValue(statement, "p_form_code", formCode);
		Utils.setFormMDParams(session, statement, getFormCode(), parentFormCode, isDrillDownForm);
		ResultSet rs = statement.executeQuery();
		while (rs.next()) {
			Integer ovn = rs.getInt("object_version_number");
			if (null != formMetaData && null != formMetaData.getColumns() && 0 != formMetaData.getColumns().size()
					&& formMetaData.getObjectVersionNumber() == ovn) {
				session.debug(getFormCode() + " FormMetadata exists. Exiting...");
				rs.close();
				statement.close();
				return formMetaData;
			}
			formMetaData = new FormMD();
			session.debug("Reading Metadata for " + getFormCode());
			formMetaData.setFormCode(getFormCode());
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
		setFormSQLText(Utils.bindVarsToLowerCase(session, getFormSQLText(), "(?i):[\\w\\$]+"));
		session.debug("Form: Lookups Metadata...\n" + getFormSQLText());
		for (int i = 0; i < formLookupsIdx.size(); i++) {
			FormColumnMD cmd = formMetaData.getColumns().get(formLookupsIdx.get(i));
			String formLookupCode = cmd.getLookupCode();
			if ("9".equals(cmd.getFieldType()) || "99".equals(cmd.getFieldType())) {
				FormInstanceIdentifier fi = new FormInstanceIdentifier();
				fi.setFormCode(formLookupCode);
				FormMD fmd = session.getFormMetaData(fi, false);
				if (null != fmd) {
					formMetaData.getLookupsArr().put(formLookupCode, fmd);
					session.debug("***: " + formMetaData.getLookupsArr().get(formLookupCode).getFormCode());
				}
			}
			if ("8".equals(cmd.getFieldType())) {
				// TODO Static Lookups - вычитывать для формы
			}
		}
		session.debug("Form: Lookups Metadata finished...");
		session.debug("Form: getFormMetaData(" + getFormCode() + ") executed...");
		return formMetaData;
	}

	private FormTabsArr getFormTabsArr() {
		FormTabsArr result = new FormTabsArr();
		try {
			String detailFormSQL = Utils.getSQLQueryFromXML("detailFormSQL", session);
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(detailFormSQL);
			// TODO Utils.setStringParameterValue(statement, "p_form_code", formCode);
			// TODO Utils.setStringParameterValue(statement, "p_master_form_code", parentFormCode);
			Utils.setFormMDParams(session, statement, getFormCode(), parentFormCode, isDrillDownForm);
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
			session.printErrorStackTrace(e);
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
			String extendedFormSQL = Utils.getSQLQueryFromXML("extendedFormSQL", session);
			OraclePreparedStatement statement = (OraclePreparedStatement) getConnection().prepareStatement(extendedFormSQL);
			Utils.setFormMDParams(session, statement, getFormCode(), parentFormCode, isDrillDownForm);
			ResultSet rs = statement.executeQuery();
			rs.next();
			formSQLText = rs.getString(1);
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			session.printErrorStackTrace(e);
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

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	public String getFormCode() {
		return formCode;
	}

	public Integer setExportData(FormInstanceIdentifier fi, ExportData exportData) {
		return formInstance.get(fi.getGridHashCode()).setExportData(exportData);
	}
}