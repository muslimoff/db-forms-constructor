package com.abssoft.constructor.server;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;

import com.abssoft.constructor.client.common.Constants;
import com.abssoft.constructor.common.ActionStatus;
import com.abssoft.constructor.common.Attribute;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.metadata.FormColumnMD;

public class FormInstance implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5522796409440448143L;
	private FormColumnsArr columnsArr = new FormColumnsArr();
	private Form form;
	private ResultSet rs;
	private OraclePreparedStatement statement;
	private String currentSortBy;
	private Map<?, ?> currentFilterValues;
	private int currentEndRow = -1;
	// private RowsArr resultData = new RowsArr();
	private Map<Integer, CLOB> clobHM = new HashMap<Integer, CLOB>();
	private Map<Integer, ExportData> exportDatHM = new HashMap<Integer, ExportData>();
	private Session session;
	private int totalRows;

	public FormInstance(Form form) throws SQLException {
		this.form = form;
		this.columnsArr = form.getFormMetaData().getColumns();
		this.session = form.getSession();
	}

	public void closeForm() {
		session.debug("FormInstance. before close...");
		try {
			if (rs != null)
				rs.close();
		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} catch (Exception e) {
			session.printErrorStackTrace(e);
		}
		session.debug("FormInstance. Resultset closed.");
		try {
			statement.close();
		} catch (SQLException e) {
			session.printErrorStackTrace(e);
		} catch (Exception e) {
			session.printErrorStackTrace(e);
		}
		session.debug("FormInstance. Statement closed.");
		// resultData.clear();
		// resultData = null;
		session.debug("FormInstance. resultData (RowsArr) cleared.");
		clobHM.clear();
		// ClobHM = null;
		session.debug("FormInstance. ClobHM cleared.");
		session.debug("FormInstance closed...");
		// showReferencedObjects(this);
	}

	public RowsArr fetch(String sortBy, int startRow, int endRow,
			Map<?, ?> filterValues, boolean forceFetch) {
		// TODO Обработка признака больших табличек - не выполнять запрос с
		// TotalRows

		RowsArr currentData = new RowsArr();
		// /////////////////////////
		if (null != sortBy) {
			String[] sortByArr = sortBy.split(",");
			sortBy = "";
			for (String ss : sortByArr) {
				sortBy = sortBy + ("".equals(sortBy) ? "" : ", ")
						+ ss.replaceAll("-", "")
						+ (ss.contains("-") ? " desc" : "");
			}
			sortBy = sortBy.replaceAll("\\$\\$"
					+ Constants.lokupWithoutMappingPrefix, "");
			sortBy = "\n" + "order by " + sortBy;
			session.debug("sortBy:" + sortBy);
		}

		// ////////////////////////
		String sqlText = null;
		boolean isStmntClosedErr = false;
		try {
			RowsArr resultData = new RowsArr();
			// Первый вызов DataSource или изменение сортировки, фильтров, а
			// также принудительно
			if (forceFetch || -1 == currentEndRow || currentSortBy != sortBy
					|| !currentFilterValues.equals(filterValues)) {
				Connection connection = form.getConnection();
				session.debug("Erase ResultSetData....");
				currentEndRow = -1;
				// resultData = new RowsArr();
				clobHM.clear();
				sqlText = form.getFormSQLText()
						+ ((sortBy != null) ? sortBy : "");
				{
					String totalRowsSqlText = "select count(*) cnt from ("
							+ sqlText + "\n)";
					OraclePreparedStatement rowCntStmnt = null;
					try {
						rowCntStmnt = (OraclePreparedStatement) connection
								.prepareStatement(totalRowsSqlText);
						form.setFilterValues(session, rowCntStmnt, filterValues);
						session.debug("totalRowsSqlText:\n" + totalRowsSqlText);
						ResultSet rowCntRS = rowCntStmnt.executeQuery();
						rowCntRS.next();
						totalRows = rowCntRS.getInt("CNT");
						session.debug("totalRows:" + totalRows);
						rowCntRS.close();
					} finally {
						Utils.closeStatement(rowCntStmnt);
					}
				}
				statement = (OraclePreparedStatement) connection
						.prepareStatement(sqlText);
				form.setFilterValues(session, statement, filterValues);
				session.debug("sqlText:\n" + sqlText);
				// 20100928
				// if (statement.isClosed()) {
				// Utils.debug("FormInstance. statement closed: ");
				// } else {
				isStmntClosedErr = true;
				rs = statement.executeQuery();
				isStmntClosedErr = false;
				// }
				currentSortBy = sortBy;
				currentFilterValues = filterValues;

			}
			resultData.setTotalRows(totalRows);
			session.debug("currentEndRow before: " + currentEndRow
					+ "; Cashe: " + resultData.size() + "; startRow: "
					+ startRow + "; endRow: " + endRow + "; gridHashCode: "
					+ "; sortBy: " + sortBy + "; forceFetch: " + forceFetch);
			// Пробегаем по ResultSet от последней строки, считанной при
			// предыдущем вызове (currentEndRow),
			// до конца текущего диапазона (endRow) или до оконца ResultSet.
			// Если currentEndRow>endRow -
			// цикл не выполняется - данные уже считаны.
			for (int rowNum = currentEndRow + 1; rowNum <= endRow; rowNum++) {
				boolean isRSclosed = false;
				try {
					if (!rs.next()) {
						session.debug("FormInstance. ResultSet ended. rowNum:"
								+ rowNum);
						rs.close();
						statement.close();
						isRSclosed = true;
					}
				} catch (Exception e) {
					session.debug("Error on close resultset/statement: " + e);
					// e.printStackTrace();
					isRSclosed = true;
				}
				if (isRSclosed)
					break;
				Row r = new Row();
				for (int colNum = 0; colNum < columnsArr.size(); colNum++) {
					try {
						FormColumnMD cmd = columnsArr.get(colNum);
						String colName = cmd.getName();
						String formColDataType = cmd.getDataType();
						r.put(colNum, Utils.getAttribute(colName,
								formColDataType, rs, this));
					} catch (Exception e) {
						r.put(colNum, new Attribute(e.getMessage()));
						session.debug("Error on column: "
								+ columnsArr.get(colNum).getName());
						session.printErrorStackTrace(e);
					}

				}
				resultData.put(rowNum, r);
				currentEndRow = rowNum;
			}

			session.debug("currentEndRow after:" + currentEndRow);
			// пробегаем по resultData и возвращаем только данные в требуемом
			// диапазоне: startRow и endRow.
			// Очищаем ранее передаваемые данные из resultData для экономии
			// памяти. Остаются только записи,
			// считанные из курсора rs, но невостребованные ранее.

			for (int i = 0; i <= Math.min(endRow, currentEndRow) - startRow; i++) {
				Row r = resultData.get(i + startRow);
				currentData.put(i, r);
			}
			currentData.setTotalRows(resultData.getTotalRows());
			session.debug("currentData.TotalRows setted"
					+ resultData.getTotalRows());
		} catch (Exception e) {
			String errText = Messages.getMessage(e);
			if (!isStmntClosedErr) {
				currentData.setStatus(new ActionStatus(errText,
						ActionStatus.StatusType.ERROR));
			} else {
				currentData.setStatus(new ActionStatus(errText,
						ActionStatus.StatusType.SUCCESS));
			}
			errText = errText + "Form:" + form.getFormCode() + "\n";
			errText = errText + "SQL:" + sqlText + "\n";
			session.debug(errText);
		}
		currentSortBy = sortBy;
		session.debug("FormInstance.fetch... return.."
				+ this.form.getFormCode());
		return currentData;
	}

	public void setClobHM(Map<Integer, CLOB> clobHM) {
		this.clobHM = clobHM;
	}

	public Map<Integer, CLOB> getClobHM() {
		return clobHM;
	}

	public void setForm(Form form) {
		this.form = form;
	}

	public Form getForm() {
		return form;
	}

	public Map<Integer, ExportData> getExportDatHM() {
		return exportDatHM;
	}

	public Integer setExportData(ExportData exportData) {
		int clobID = exportData.hashCode();
		exportDatHM.put(clobID, exportData);
		return clobID;
	}
}
