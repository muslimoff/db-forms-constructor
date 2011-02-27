package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;

import com.abssoft.constructor.client.metadata.ActionStatus;
import com.abssoft.constructor.client.metadata.Attribute;
import com.abssoft.constructor.client.metadata.ExportData;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;

public class FormInstance {
	private FormColumnsArr columnsArr = new FormColumnsArr();
	private Form form;
	private ResultSet rs;
	private OraclePreparedStatement statement;
	private String currentSortBy;
	private Map<?, ?> currentFilterValues;
	private int currentEndRow = -1;
	private RowsArr resultData = new RowsArr();
	private HashMap<Integer, CLOB> ClobHM = new HashMap<Integer, CLOB>();
	private HashMap<Integer, ExportData> exportDatHM = new HashMap<Integer, ExportData>();

	public FormInstance(Form form) throws SQLException {
		this.form = form;
		this.columnsArr = form.getFormMetaData().getColumns();
	}

	public void closeForm() {
		Utils.debug("Server:FormInstance. before close...");
		try {
			rs.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		Utils.debug("Server:FormInstance. Resultset closed.");
		try {

			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		resultData.clear();
		ClobHM.clear();
		Utils.debug("Server:FormInstance. Statement closed.");
		Utils.debug("Server:FormInstance closed...");
	}

	public RowsArr fetch(String sortBy, int startRow, int endRow, Map<?, ?> filterValues, boolean forceFetch) {
		// TODO Обработка признака больших табличек - не выполнять запрос с TotalRows

		RowsArr currentData = new RowsArr();
		// /////////////////////////
		if (null != sortBy) {
			String[] sortByArr = sortBy.split(",");
			sortBy = "";
			for (String ss : sortByArr) {
				// System.out.println("######>" + ss);
				sortBy = sortBy + ("".equals(sortBy) ? "" : ", ") + ss.replaceAll("-", "") + (ss.contains("-") ? " desc" : "");
			}
			sortBy = "\n" + "order by " + sortBy;
			Utils.debug("sortBy:" + sortBy);
		}

		// ////////////////////////
		String sqlText = null;
		boolean isStmntClosedErr = false;
		try {
			// Первый вызов DataSource или изменение сортировки, фильтров, а также принудительно
			if (forceFetch || -1 == currentEndRow || currentSortBy != sortBy || !currentFilterValues.equals(filterValues)) {
				OracleConnection connection = form.getConnection();
				Utils.debug("Erase ResultSetData....");
				currentEndRow = -1;
				resultData = new RowsArr();
				ClobHM.clear();
				sqlText = form.getFormSQLText() + ((sortBy != null) ? sortBy : "");
				{
					String totalRowsSqlText = "select count(*) cnt from (" + sqlText + "\n)";
					OraclePreparedStatement rowCntStmnt = (OraclePreparedStatement) connection.prepareStatement(totalRowsSqlText); // statement
					Utils.setFilterValues(rowCntStmnt, filterValues);
					Utils.debug("totalRowsSqlText:\n" + totalRowsSqlText);
					ResultSet rowCntRS = rowCntStmnt.executeQuery();
					rowCntRS.next();
					int totalRows = rowCntRS.getInt("CNT");
					Utils.debug("totalRows:" + totalRows);
					resultData.setTotalRows(totalRows);
					rowCntRS.close();
					rowCntStmnt.close();
				}
				statement = (OraclePreparedStatement) connection.prepareStatement(sqlText);
				Utils.setFilterValues(statement, filterValues);
				Utils.debug("sqlText:\n" + sqlText);
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
			Utils.debug("currentEndRow before: " + currentEndRow + "; Cashe: " + resultData.size() + "; startRow: " + startRow
					+ "; endRow: " + endRow + "; gridHashCode: " + "; sortBy: " + sortBy + "; forceFetch: " + forceFetch);
			// Пробегаем по ResultSet от последней строки, считанной при предыдущем вызове (currentEndRow),
			// до конца текущего диапазона (endRow) или до оконца ResultSet. Если currentEndRow>endRow -
			// цикл не выполняется - данные уже считаны.
			for (int rowNum = currentEndRow + 1; rowNum <= endRow; rowNum++) {
				boolean isRSclosed = false;
				try {
					if (!rs.next() // !rs.isAfterLast() //!rs.isClosed() &&
					) {
						Utils.debug("FormInstance. ResultSet ended. rowNum:" + rowNum);
						rs.close();
						statement.close();
						isRSclosed = true;
					}
				} catch (Exception e) {
					Utils.debug("Error on close resultset/statement: " + e);
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
						r.put(colNum, Utils.getAttribute(colName, formColDataType, rs, this));
					} catch (Exception e) {
						r.put(colNum, new Attribute(e.getMessage()));
						Utils.debug("Error on column: " + columnsArr.get(colNum).getName());
						e.printStackTrace();
					}

				}
				resultData.put(rowNum, r);
				currentEndRow = rowNum;
			}

			Utils.debug("currentEndRow after:" + currentEndRow);
			// пробегаем по resultData и возвращаем только данные в требуемом диапазоне: startRow и endRow.
			// Очищаем ранее передаваемые данные из resultData для экономии памяти. Остаются только записи,
			// считанные из курсора rs, но невостребованные ранее.

			for (int i = 0; i <= Math.min(endRow, currentEndRow) - startRow; i++) {
				Row r = resultData.get(i + startRow);
				currentData.put(i, r);
				// resultData.remove(i + startRow);
				// System.out.println("col:" + i + "; data1:" + r.get(0));
			}
			currentData.setTotalRows(resultData.getTotalRows());
			Utils.debug("currentData.TotalRows setted" + resultData.getTotalRows());
		} catch (Exception e) {

			String errText = Utils.getExceptionStackIntoString(e) + "\n";
			errText = errText + "Form:" + form.getFormCode() + "\n";
			errText = errText + "SQL:" + sqlText + "\n";
			Utils.debug(errText);
			if (!isStmntClosedErr) {
				currentData.setStatus(new ActionStatus(errText, ActionStatus.StatusType.ERROR));
			} else {
				currentData.setStatus(new ActionStatus(errText, ActionStatus.StatusType.SUCCESS));
			}
		}
		currentSortBy = sortBy;
		Utils.debug("FormInstance.fetch... return.." + this.form.getFormCode());
		return currentData;
	}

	public void setClobHM(HashMap<Integer, CLOB> clobHM) {
		ClobHM = clobHM;
	}

	public HashMap<Integer, CLOB> getClobHM() {
		return ClobHM;
	}

	public void setForm(Form form) {
		this.form = form;
	}

	public Form getForm() {
		return form;
	}

	public HashMap<Integer, ExportData> getExportDatHM() {
		return exportDatHM;
	}

	public Integer setExportData(ExportData exportData) {
		int clobID = exportData.hashCode();
		exportDatHM.put(clobID, exportData);
		return clobID;
	}
}
