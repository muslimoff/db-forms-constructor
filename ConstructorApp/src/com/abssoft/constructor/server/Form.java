package com.abssoft.constructor.server;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;

import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.Attribute;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormActionsArr;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.FormTabsArr;
import com.abssoft.constructor.common.FormsArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.ColumnAction;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormColumnLookupMappingMD;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.FormTabMD;

/**
 * Данные формы <CODE>formCode</CODE> (метаданные, данные запроса).
 * 
 * @author User
 */
public class Form implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7446321420765160091L;
	private Map<Integer, FormInstance> formInstance = new HashMap<Integer, FormInstance>();

	public Map<Integer, FormInstance> getFormInstance() {
		return formInstance;
	}

	public void setFormInstance(HashMap<Integer, FormInstance> formInstance) {
		this.formInstance = formInstance;
	}

	private Connection connection;
	private String fcSchemaOwner;
	private String formSQLText;
	private String formSQLCountText;
	private FormColumnsArr metadata = new FormColumnsArr();
	private String formCode;
	private FormMD formMetaData = null;
	private List<Integer> formLookupsIdx = new ArrayList<Integer>();
	private Session session;
	private FormInstanceIdentifier fi;

	public Session getSession() {
		return session;
	}

	private void setFormMDParams(OraclePreparedStatement statement) {
		Utils.setFormMDParams(session, statement, fi);
	}

	public void setFilterValues(Session session,
			OraclePreparedStatement statement, Map<?, ?> filterValues) {
		Utils.setFilterValues(session, statement, filterValues);
		Utils.setParameterValue(session, statement, "p_$master_form_code",
				fi.getParentFormCode());
		Utils.setParameterValue(session, statement, "p_$master_form_tab_code",
				fi.getParentFormTabCode());
		// Под вопросом
		// setFormMDParams(statement);

	}

	public Form() {
	}

	public Form(Connection connection, Session session,
			FormInstanceIdentifier fi) {
		this.fi = fi;
		this.setConnection(connection);
		this.setFormCode(fi.getFormCode());
		this.session = session;
		setFormSQLText();
		session.debug("" + this);
	}

	public void closeForm(int gridHashCode, FormMD formState) {
		session.debug("form " + getFormCode() + " - gridHashCode:"
				+ gridHashCode + " before close...");
		if (formInstance.containsKey(gridHashCode)) {
			formInstance.get(gridHashCode).closeForm();
			formInstance.remove(gridHashCode);

		} else {
			// formInstance для табов с отложенным запросом не успел создаться -
			// ничего не делаем
		}
		if (0 == getInstancesCount()) {
			session.debug("form " + getFormCode() + " - gridHashCode:"
					+ gridHashCode + " save current state for User...");
			session.debug("formState:" + formState + "; FormCode:"
					+ formState.getFormCode());
			// TODO Обработка состояния формы при закрытии: FormMD formState -
			// сохранение ширин, сортировок и прочей хери.
		}
		session.debug("form " + getFormCode() + " - gridHashCode:"
				+ gridHashCode + " closed...");
	}

	
	public Row executeDML(int gridHashCode, Row oldRow, Row newRow,
			FormActionMD actMD) throws SQLException, Exception {
		Row resultRow = null != newRow ? newRow : oldRow;
		// String statusMsgLevelParamName = null;
		// String statusMsgTxtParamName = null;
	
		session.debug(
				"actionCode:" + actMD.getCode() + "; Type:" + actMD.getType(),
				resultRow);
		{

			String dmlProcText = actMD.getDmlProcText();
								
			if (null != dmlProcText) {
				OracleCallableStatement stmnt = null;
				try {
					stmnt = (OracleCallableStatement) getConnection().prepareCall(dmlProcText);
					
					session.debug(dmlProcText, resultRow);
					// ----------------------------------
					Map<String, Attribute> rowValues = new HashMap<String, Attribute>();
					Map<String, Boolean> isClobHM = new HashMap<String, Boolean>();
					for (int j = 0; j < resultRow.size(); j++) {
	
						String newParamName = "P_"
								+ formMetaData.getColumns().get(j).getName();
						String oldParamName = "P_OLD_"
								+ formMetaData.getColumns().get(j).getName();
						if ("CLOB".equals(formMetaData.getColumns().get(j)
								.getDataType())) {
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
					Iterator<Integer> allParamsIterator = actMD.getAllArgs()
							.keySet().iterator();
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
						
							Object val = (null != attr) ? attr
									.getAttributeAsObject() : null;
									
														
							String dType = attr.getDataType();
							if ("D".equals(dType)) {
								outParamType = Types.DATE;
								// Converting java.util.Date to java.sql.Date
								java.sql.Date dt = (null != val) ? new java.sql.Date(
										((java.util.Date) val).getTime())
										: null;
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
								stmnt.setString(paramNum, ((Boolean) val) ? "Y"
										: "N");
							} else {
								if (isClobHM.containsKey(paramName)) {
									Integer clobId = (null != val) ? Integer
											.valueOf((String) val) : null;
									CLOB clb = formInstance.get(gridHashCode)
											.getClobHM().get(clobId);
									session.debug("clob: " + clb + "; clobId:"
											+ clobId);
									stmnt.setCLOB(paramNum, clb);
								} else {
									stmnt.setString(paramNum, (String) val);
								}
							}
							session.debug(
									"("
											+ (null != attr ? attr
													.getDataType() : null)
											+ ")"
											+ "IN:"
											+ paramName
											+ " => "
											+ val
											+ "; class:"
											+ ((null != val) ? val.getClass()
													: "null") + "; is null:"
											+ (val == null), resultRow);
						}

						if (actMD.getOutputs().containsKey(paramNum)) {
							session.debug("registerOutParameter. paramName: "
									+ paramName + "; paramNum:" + paramNum
									+ "; outParamType:" + outParamType,
									resultRow);
							((OracleCallableStatement) stmnt)
									.registerOutParameter(paramNum,
											outParamType);

						}
					}

					// Обработка сообщения
					ActionStatus.StatusType msgLvl = ActionStatus.StatusType.SUCCESS;
					String msgText = null;
				    stmnt.execute();
					// Цикл по OUT-параметрам. P_OLD_ параметры не
					// обрабатываются -
					// предполагается, что они только IN
					for (int j = 0; j < resultRow.size(); j++) {
						String colName = "P_"
								+ formMetaData.getColumns().get(j).getName();
						if (actMD.getOutputsByName().containsKey(colName)) {
							String dataType = resultRow.get(j).getDataType();
							if (isClobHM.containsKey(colName)) {
								dataType = "CLOB";
							}
							resultRow.remove(j);
							Integer colIdx = actMD.getOutputsByName().get(
									colName);
							Attribute attr = Utils.getAttribute(colIdx,
									dataType, stmnt,
									formInstance.get(gridHashCode));
							session.debug(
									"(" + dataType + ")" + "OUT:" + colName
											+ " => " + attr.getAttribute()
											+ "; is null:"
											+ (null == attr.getAttribute()),
									resultRow);
							resultRow.put(j, attr);

							// Обработка сообщения
							if (colName.equals("P_"
									+ actMD.getStatusMsgLevelParam())) {
								// statusMsgLevelParamName = "P_" + colName;
								String msgLvlTxt = attr.getAttribute();
								msgLvl = null == msgLvlTxt ? ActionStatus.StatusType.WARNING
										: ActionStatus.StatusType
												.valueOf(msgLvlTxt);
							}

							if (colName.equals("P_"
									+ actMD.getStatusMsgTxtParam())) {
								// statusMsgTxtParamName = "P_" + colName;
								msgText = attr.getAttribute();
							}

						}
					}
					// Обработка сообщения
					ActionStatus status = resultRow.getStatus();
					status.setStatusType(msgLvl);
					status.setWarnMsg(msgText);
					status.setWarnButtonIdx((Integer) null);
					resultRow.setStatus(status);

					if (actMD.getAutoCommit()) {
						session.debug("Auto Commit complete...", resultRow);
						getConnection().commit();
					} else {
						session.debug("Auto Commit disabled...", resultRow);
					}
				} finally {
					Utils.closeStatement(stmnt);
				}
			}
		}
		return resultRow;
	}

	public RowsArr fetch(int gridHashCode, String sortBy, int startRow,
			int endRow, Map<?, ?> criteria, boolean forceFetch)
			throws SQLException {
		if (!formInstance.containsKey(gridHashCode)) {
			formInstance.put(gridHashCode, new FormInstance(this));
		}
		return formInstance.get(gridHashCode).fetch(sortBy, startRow, endRow,
				criteria, forceFetch);
	}

	private FormColumnsArr getColumns() {
		OraclePreparedStatement statement = null;
		OraclePreparedStatement attrStmnt = null;
		OraclePreparedStatement actStmnt = null;
		OraclePreparedStatement mapStmnt = null;
		try {
			{
				session.debug("Parse Query: ");
				String columnsMetaDataSQL = Utils.getSQLQueryFromXML(
						"ColumnsMetaDataSQL", session);
				session.debug(columnsMetaDataSQL);

				statement = (OraclePreparedStatement) getConnection()
						.prepareStatement(columnsMetaDataSQL);
				session.debug("Parameters: ");
				setFormMDParams(statement);
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
					cmd.setTreeInitializationValue(rs
							.getString("tree_initialization_value"));
					cmd.setTreeFieldType(rs.getString("tree_field_type"));
					cmd.setEditorTabCode(rs.getString("editor_tab_code"));
					cmd.setFieldType(rs.getString("field_type"));
					cmd.setDescription(rs.getString("column_description"));
					cmd.setPrimaryKey("Y".equals(rs
							.getString("pimary_key_flag")));
					cmd.setFrozen("Y".equals(rs.getString("is_frozen_flag")));
					cmd.setShowHover("Y".equals(rs.getString("show_hover_flag")));
					cmd.setLookupCode(rs.getString("lookup_code"));
					cmd.setLookupFieldType(rs.getString("lookup_field_type"));
					cmd.setHoverСolumnСode(rs.getString("hover_column_code"));
					cmd.setEditorHeight(rs.getString("editor_height"));
					cmd.setHelpText(rs.getString("help_text"));
					cmd.setTextMask(rs.getString("text_mask"));
					cmd.setValidationRegexp(rs.getString("validation_regexp"));
					cmd.setDefaultOrderByNumber(rs
							.getString("default_orderby_number"));
					cmd.setDefaultValue(Utils.bindVarsToLowerCase(session,
							rs.getString("default_value"), "(?i):[\\w\\$]+",
							"&", "&"));
					cmd.setEditorTitleOrientation(rs
							.getString("editor_title_orientation"));
					cmd.setEditorEndRow("Y".equals(rs
							.getString("editor_end_row_flag")));
					cmd.setEditorColsSpan(rs.getString("editor_cols_span"));
					cmd.setLookupDisplayValue(rs
							.getString("lookup_display_value"));
					cmd.setEditorOnEnterKeyAction(rs
							.getString("editor_on_enter_key_action"));

					String integerString = rs.getString("lookup_width");
					cmd.setLookupWidth(null != integerString ? Integer
							.decode(integerString) : null);
					integerString = rs.getString("lookup_height");
					cmd.setLookupHeight(null != integerString ? Integer
							.decode(integerString) : null);

					{// 20130727 HeaderSpans.
						String fName = cmd.getDisplayName();
						String hdrSeparator = "|";
						// Разбивка DisplayName на displayName и headerName по
						// hdrSeparator
						if (null != fName && fName.contains(hdrSeparator)) {
							String[] fNameSplitArr = fName.split("\\"
									+ hdrSeparator); // Разбиваем на фрагменты
														// наименование
							cmd.setHeaderName(fNameSplitArr[0]);
							cmd.setDisplayName(fNameSplitArr[1]);
						}
					}

					metadata.put(colNum, cmd);
					if (null != cmd.getLookupCode()) {
						formLookupsIdx.add(colNum);
					}
				}
				rs.close();
			}
			{
				// get Column Attributes
				String columnAttributesSQL = Utils.getSQLQueryFromXML(
						"columnAttributesSQL", session);
				attrStmnt = (OraclePreparedStatement) getConnection()
						.prepareStatement(columnAttributesSQL);
				setFormMDParams(attrStmnt);
				ResultSet attrRS = attrStmnt.executeQuery();
				while (attrRS.next()) {
					String colName = attrRS.getString("column_code");
					String attrCode = attrRS.getString("attribute_code");
					String attrValue = attrRS.getString("attribute_value");
					metadata.get(colName).getLookupAttributes()
							.put(attrCode, attrValue);
				}
				attrRS.close();
			}

			{
				// get Column Actions
				String columnActionsSQL = Utils.getSQLQueryFromXML(
						"columnActionsSQL", session);
				actStmnt = (OraclePreparedStatement) getConnection()
						.prepareStatement(columnActionsSQL);
				setFormMDParams(actStmnt);
				ResultSet colActsRS = actStmnt.executeQuery();
				while (colActsRS.next()) {
					String colName = colActsRS.getString("column_code");
					ColumnAction ca = new ColumnAction();
					ca.setActionCode(colActsRS.getString("action_code"));
					ca.setActionKeyCode(colActsRS.getString("action_key_code"));
					ca.setColActionTypeCode(colActsRS
							.getString("col_action_type_code"));
					metadata.get(colName).getColActions().add(ca);
				}
				colActsRS.close();
			}

			{

				String columnLookupMappingSQL = Utils.getSQLQueryFromXML(
						"columnLookupMappingSQL", session);
				mapStmnt = (OraclePreparedStatement) getConnection()
						.prepareStatement(columnLookupMappingSQL);
				setFormMDParams(mapStmnt);
				ResultSet mapRS = mapStmnt.executeQuery();
				while (mapRS.next()) {

					FormColumnLookupMappingMD lookupMapping = new FormColumnLookupMappingMD();
					String colName = mapRS.getString("column_code");
					lookupMapping.setLookupFormColumnCode(mapRS
							.getString("lookup_form_column_code"));
					lookupMapping.setColumnUserName(mapRS
							.getString("column_user_name"));
					lookupMapping.setColumnDisplaySize(mapRS
							.getString("column_display_size"));
					lookupMapping.setColumnDisplayNumber(mapRS
							.getInt("column_display_number"));
					lookupMapping
							.setShowOnGrid(mapRS.getString("show_on_grid"));
					lookupMapping.setColumnCodeToMapping(mapRS
							.getString("column_code_to_mapping"));
					metadata.get(colName).getColumnLookupMappingArr()
							.add(lookupMapping);
				}
				mapRS.close();
			}
		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(statement);
			Utils.closeStatement(attrStmnt);
			Utils.closeStatement(actStmnt);
			Utils.closeStatement(mapStmnt);
		}
		return metadata;
	}

	private String getDMLProcText(FormActionMD actionData) throws SQLException {
		String dmlProcText = "begin " + actionData.getSqlProcedureName() + "(";
		String argsSQLText = Utils.getSQLQueryFromXML("argsSQLText", session);
		OraclePreparedStatement actProcStmnt = null;
		try {
			actProcStmnt = (OraclePreparedStatement) getConnection()
					.prepareStatement(argsSQLText);
			Utils.setParameterValue(session, actProcStmnt, "p_procedure_name",
					actionData.getSqlProcedureName());
			Utils.setParameterValue(session, actProcStmnt, "p_fc_schema_owner",
					getFcSchemaOwner());
			ResultSet actProcRs = actProcStmnt.executeQuery();
			int argNum = -1;
			while (actProcRs.next()) {
				argNum = actProcRs.getInt("position");
				String argName = actProcRs.getString("argument_name");
				String argType = actProcRs.getString("data_type");
				session.debug("argNum: " + argNum + "; argName: " + argName
						+ "(" + argType + ")");
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
			dmlProcText = dmlProcText.substring(0, dmlProcText.length()
					- (-1 == argNum ? 0 : 1))
					+ "); end;";
			actProcRs.close();
		} finally {
			Utils.closeStatement(actProcStmnt);
		}
		dmlProcText = Utils.getSQLwUserVarsReplaced(dmlProcText, session);
		return dmlProcText;
	}

	public String getFcSchemaOwner() {
		return fcSchemaOwner;
	}

	private FormActionsArr getFormActionsArr() {
		FormActionsArr result = new FormActionsArr();
		OraclePreparedStatement statement = null;
		try {
			String formActionsSQL = Utils.getSQLQueryFromXML("formActionsSQL",
					session);
			statement = (OraclePreparedStatement) getConnection()
					.prepareStatement(formActionsSQL);
			setFormMDParams(statement);
			ResultSet actRs = statement.executeQuery();
			while (actRs.next()) {
				FormActionMD actionData = new FormActionMD();
				actionData.setCode(actRs.getString("action_code"));
				actionData.setIconId(actRs.getInt("icon_id"));
				actionData.setType(actRs.getString("action_type"));
				actionData.setSqlProcedureName(Utils.bindVarsToLowerCase(
						session, actRs.getString("procedure_name"),
						"(?i):[\\w]+", ":", ":"));
				actionData.setConfirmText(Utils.bindVarsToLowerCase(session,
						actRs.getString("confirm_text"), "(?i):[\\w]+", "&",
						"&"));
				actionData.setDisplayName(Utils.bindVarsToLowerCase(session,
						actRs.getString("action_display_name"), "(?i):[\\w]+",
						"&", "&"));
				if (null != actionData.getSqlProcedureName()) {
					actionData.setDmlProcText(getDMLProcText(actionData));
				}
				actionData.setHotKey(actRs.getString("hot_key"));
				actionData.setShowSeparatorBelow("Y".equals(actRs
						.getString("show_separator_below")));
				actionData.setDisplayOnToolbar("Y".equals(actRs
						.getString("display_on_toolbar")));
				actionData.setChildFormCode(actRs.getString("child_form_code"));
				actionData.setUrlText(Utils.bindVarsToLowerCase(session,
						actRs.getString("url_text"), "(?i):[\\w]+", ":", ":"));
				actionData.setParentActionCode(actRs
						.getString("parent_action_code"));
				actionData.setDisplayInContextMenu("Y".equals(actRs
						.getString("display_in_context_menu")));
				actionData.setAutoCommit("Y".equals(actRs
						.getString("autocommit")));
				actionData.setStatusButtonParam(actRs
						.getString("status_button_param"));
				actionData.setStatusMsgLevelParam(actRs
						.getString("status_msg_level_param"));
				actionData.setStatusMsgTxtParam(actRs
						.getString("status_msg_txt_param"));

				result.add(actionData);
			}
			actRs.close();
		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(statement);
		}
		return result;
	}

	public FormMD getFormMetaData() throws SQLException {
		String formSQL = Utils.getSQLQueryFromXML("formSQL", session);
		Integer ovn = -1; // Несуществующий ovn.
		OraclePreparedStatement statement = null;
		try {
			statement = (OraclePreparedStatement) getConnection()
					.prepareStatement(formSQL);
			setFormMDParams(statement);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				ovn = rs.getInt("object_version_number");
				if (null != formMetaData //
						// && null != formMetaData.getColumns()
						// && 0 != formMetaData.getColumns().size()
						&& formMetaData.getObjectVersionNumber() == ovn
				// && formMetaData.isMetadataComplete()
				) {
					session.debug(getFormCode()
							+ " FormMetadata exists. Exiting...");
					rs.close();
					statement.close();
					return formMetaData;
				}
				formMetaData = new FormMD();
				formMetaData.setObjectVersionNumber(ovn);
				formMetaData.setFormInstanceIdentifier(fi);
				session.debug("Reading Metadata for " + getFormCode());
				formMetaData.setFormCode(getFormCode());
				formMetaData.setHotKey(rs.getString("hot_key"));
				formMetaData.setFormName(rs.getString("form_name"));
				formMetaData.setFormType(rs.getString("form_type"));
				formMetaData.setShowTreeRootNode(rs
						.getString("show_tree_root_node"));
				formMetaData.setIconId(rs.getInt("icon_id"));
				formMetaData.setWidth(rs.getString("form_width"));
				formMetaData.setHeight(rs.getString("form_height"));
				formMetaData.setBottomTabsPosition(rs
						.getString("bottom_tabs_orientation"));
				formMetaData.setSideTabsPosition(rs
						.getString("side_tabs_orientation"));
				formMetaData.setShowBottomToolBar(rs.getString(
						"show_bottom_toolbar").equals("Y") ? true : false);
				formMetaData.setDoubleClickActionCode(rs
						.getString("double_click_action_code"));
				formMetaData.setDragAndDropActionCode(rs
						.getString("dragdrop_action_code"));
				formMetaData.setDataPageSize(rs.getInt("data_page_size"));

				String integerString = rs.getString("lookup_width");
				formMetaData.setLookupWidth(null != integerString ? Integer
						.decode(integerString) : null);
				integerString = rs.getString("lookup_height");
				formMetaData.setLookupHeight(null != integerString ? Integer
						.decode(integerString) : null);
				formMetaData.setColumns(getColumns());

			}
			rs.close();
		} finally {
			Utils.closeStatement(statement);
		}

		// 20130519 - В случае указания ошибочного кода формы - возникает
		// проблема...
		if (null == formMetaData) {
			formMetaData = new FormMD();
		}
		session.debug("Form: Lookups Metadata...\n" + getFormSQLText());
		for (int i = 0; i < formLookupsIdx.size(); i++) {
			FormColumnMD cmd = formMetaData.getColumns().get(
					formLookupsIdx.get(i));
			String formLookupCode = cmd.getLookupCode();
			if ("9".equals(cmd.getFieldType())
					|| "99".equals(cmd.getFieldType())
					|| "16".equals(cmd.getFieldType())) {
				putChildFormToFormsArr(formLookupCode, true,
						formMetaData.getLookupsArr(), null);
			}
			if ("8".equals(cmd.getFieldType())) {
				// TODO Static Lookups - вычитывать для формы
			}
		}

		if (!fi.getIsLookupForm()) {
			formMetaData.setTabs(getFormTabsArr());
			formMetaData.setActions(getFormActionsArr());
			formMetaData.setChildForms(getChildForms());
		} else {
			formMetaData.setTabs(new FormTabsArr());
			formMetaData.setActions(new FormActionsArr());
			formMetaData.setChildForms(new FormsArr());
		}
		session.debug("Form: Lookups Metadata finished...");
		// formMetaData.setMetadataComplete(true);
		// formMetaData.setObjectVersionNumber(ovn);
		session.debug("Form: getFormMetaData(" + getFormCode()
				+ ") executed...");
		// TODO - 20130512 Сериализация для работ по переводу класса Form на
		// сторону БД
		// if (!fi.getIsLookupForm() && null == fi.getParentFormCode()) {
		// AppLayerTestClass.Serialize(fi.getKey(), formMetaData);
		// }

		// AppLayerTestClass.SerializeJAXB(fi.getKey(), this);
		return formMetaData;
	}

	private FormsArr getChildForms() throws SQLException {
		FormsArr result = formMetaData.getChildForms();
		for (int i = 0; i < formMetaData.getTabs().size(); i++) {
			FormTabMD ftmd = formMetaData.getTabs().get(i);
			String formCode = ftmd.getChildFormCode();
			if (null != formCode && !"".equals(formCode)) {
				putChildFormToFormsArr(formCode, false, result,
						ftmd.getTabCode());
			}
		}
		return result;
	}

	private void putChildFormToFormsArr(String formCode, boolean isLookupForm,
			FormsArr childFormsArr, String parentFormTabCode)
			throws SQLException {
		FormInstanceIdentifier fi = //
		new FormInstanceIdentifier(this.fi.getSessionId(), formCode,
				this.fi.getIsDebugEnabled(), isLookupForm, false,
				getFormCode(), parentFormTabCode);
		FormMD fmd = session.getFormMetaData(fi);
		if (null != fmd
		// Для предотвращения рекурсии
				&& !this.fi.getKey().equals(fi.getKey())) {
			childFormsArr.put(fi.getKey(), fmd);
		}
	}

	private FormTabsArr getFormTabsArr() {
		FormTabsArr result = new FormTabsArr();
		OraclePreparedStatement statement = null;
		try {
			String detailFormSQL = Utils.getSQLQueryFromXML("detailFormSQL",
					session);
			statement = (OraclePreparedStatement) getConnection()
					.prepareStatement(detailFormSQL);
			// TODO Utils.setStringParameterValue(statement, "p_form_code",
			// formCode);
			// TODO Utils.setStringParameterValue(statement,
			// "p_master_form_code", parentFormCode);
			setFormMDParams(statement);
			ResultSet detRs = statement.executeQuery();
			while (detRs.next()) {
				FormTabMD tabData = new FormTabMD();
				tabData.setFormCode(detRs.getString("form_code"));
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
		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(statement);
		}
		return result;
	}

	public int getInstancesCount() {
		return formInstance.size();
	}

	public void setFcSchemaOwner(String fcSchemaOwner) {
		this.fcSchemaOwner = fcSchemaOwner;
	}

	public String getFormSQLText() {
		return formSQLText;
	}

	public void setFormSQLText(String formSQLText) {
		this.formSQLText = formSQLText;
	}

	private void setFormSQLText() {
		OraclePreparedStatement statement = null;
		try {
			String extendedFormSQL = Utils.getSQLQueryFromXML(
					"extendedFormSQL", session);
			statement = (OraclePreparedStatement) getConnection()
					.prepareStatement(extendedFormSQL);
			setFormMDParams(statement);
			ResultSet rs = statement.executeQuery();
			rs.next();
			String sqText = rs.getString(1);

			// Принудительно приводим все bind variables к lowerCase
			String lowVarsSQL = Utils.bindVarsToLowerCase(session, sqText,
					"(?i):[\\w\\$]+");
			session.debug("Form: lowVarsSQL:\n" + lowVarsSQL);
			setFormSQLText(lowVarsSQL);
			rs.close();

		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(statement);
		}
		setFormSQLCountText();
	}

	private void setFormSQLCountText() {
		OraclePreparedStatement statement = null;
		try {
			String extendedFormSQLCount = Utils.getSQLQueryFromXML(
					"extendedFormSQLCount", session);
			statement = (OraclePreparedStatement) getConnection()
					.prepareStatement(extendedFormSQLCount);
			setFormMDParams(statement);
			ResultSet rs = statement.executeQuery();
			rs.next();
			String sqText = rs.getString(1);

			// Принудительно приводим все bind variables к lowerCase
			String lowVarsSQL = Utils.bindVarsToLowerCase(session, sqText,
					"(?i):[\\w\\$]+");
			session.debug("Form: lowVarsSQL:\n" + lowVarsSQL);
			setFormSQLCountText(lowVarsSQL);
			rs.close();

		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} finally {
			Utils.closeStatement(statement);
		}
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public Connection getConnection() {
		return connection;
	}

	public void setFormCode(String formCode) {
		this.formCode = formCode;
	}

	public String getFormCode() {
		return formCode;
	}

	public Integer setExportData(FormInstanceIdentifier fi,
			ExportData exportData) {
		return formInstance.get(fi.getGridHashCode()).setExportData(exportData);
	}

	public String getFormSQLCountText() {
		return formSQLCountText;
	}

	public void setFormSQLCountText(String formSQLCountText) {
		this.formSQLCountText = formSQLCountText;
	}
}
