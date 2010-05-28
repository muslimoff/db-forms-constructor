package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.metadata.ActionStatus;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;

public class FormInstance {
	private OracleConnection connection;
	private String formSQLText;
	private FormColumnsArr columnsArr = new FormColumnsArr();

	private ResultSet rs;
	private OraclePreparedStatement statement;
	private String currentSortBy;
	private Map<?, ?> currentFilterValues;
	private int currentEndRow = -1;
	private RowsArr resultData = new RowsArr();

	public FormInstance(OracleConnection connection, String formSQLText, FormMD formMetaData) {
		this.connection = connection;
		this.formSQLText = formSQLText;
		this.columnsArr = formMetaData.getColumns();
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

		Utils.debug("Server:FormInstance. Statement closed.");
		Utils.debug("Server:FormInstance closed...");
	}

	public RowsArr fetch(String sortBy, int startRow, int endRow, Map<?, ?> filterValues, boolean forceFetch) {
		RowsArr currentData = new RowsArr();
		// /////////////////////////
		if (null != sortBy) {
			String[] sortByArr = sortBy.split(",");
			sortBy = "";
			for (String ss : sortByArr) {
				System.out.println("######>" + ss);
				sortBy = sortBy + ("".equals(sortBy) ? "" : ", ") + ss.replaceAll("-", "") + (ss.contains("-") ? " desc" : "");
			}
			sortBy = "\n" + "order by " + sortBy;
			Utils.debug("sortBy:" + sortBy);

		}

		// ////////////////////////
		try {
			// Первый вызов DataSource или изменение сортировки, фильтров, а
			// также принудительно
			if (forceFetch || -1 == currentEndRow || currentSortBy != sortBy || !currentFilterValues.equals(filterValues)) {
				Utils.debug("Erase ResultSetData....");
				currentEndRow = -1;
				resultData = new RowsArr();
				String sqlText = formSQLText + ((sortBy != null) ? sortBy : "");
				String totalRowsSqlText = "select count(*) cnt from (" + sqlText + "\n)";
				statement = (OraclePreparedStatement) connection.prepareStatement(totalRowsSqlText); // statement
				Utils.setFilterValues(statement, filterValues);
				Utils.debug("totalRowsSqlText:\n" + totalRowsSqlText);
				rs = statement.executeQuery();
				rs.next();
				resultData.setTotalRows(rs.getInt("CNT"));
				rs.close();
				statement.close();
				statement = (OraclePreparedStatement) connection.prepareStatement(sqlText);
				Utils.setFilterValues(statement, filterValues);
				Utils.debug("sqlText:\n" + sqlText);
				rs = statement.executeQuery();
				currentSortBy = sortBy;
				currentFilterValues = filterValues;

			}
			Utils.debug("currentEndRow before: " + currentEndRow + "; Cashe: " + resultData.size() + "; startRow: " + startRow
					+ "; endRow: " + endRow + "; gridHashCode: " + "; sortBy: " + sortBy + "; forceFetch: " + forceFetch);
			// Пробегаем по ResultSet от последней строки, считанной при
			// предыдущем вызове (currentEndRow), до конца текущего диапазона
			// (endRow) или до оконца ResultSet. Если currentEndRow>endRow -
			// цикл не выполняется - данные уже считаны.
			for (int rowNum = currentEndRow + 1; rowNum <= endRow; rowNum++) {
				try {
					// System.out.println("isAfterLast(): " + rs.isAfterLast());
					if (!rs.next() // !rs.isAfterLast() //!rs.isClosed() &&
					) {
						rs.close();
						statement.close();
						break;
					}
				} catch (java.sql.SQLException e) {
					Utils.debug("Error on close resultset/statement: " + e);
					break;
				}

				Row r = new Row();
				for (int colNum = 0; colNum < columnsArr.size(); colNum++) {
					try {
						FormColumnMD cmd = columnsArr.get(colNum);
						String colName = cmd.getName();
						String formColDataType = cmd.getDataType();
						r.put(colNum, Utils.getAttribute(colName, formColDataType, rs));
					} catch (java.sql.SQLException e) {
						Utils.debug("Error on column: " + columnsArr.get(colNum).getName());
						e.printStackTrace();
					}

				}
				resultData.put(rowNum, r);
				currentEndRow = rowNum;
			}
			Utils.debug("currentEndRow after:" + currentEndRow);
			// пробегаем по resultData и возвращаем только данные в требуемом
			// диапазоне: startRow и endRow. Очищаем ранее передаваемые данные
			// из resultData для экономии памяти. Остаются только записи,
			// считанные из курсора rs, но невостребованные ранее.

			for (int i = 0; i <= Math.min(endRow, currentEndRow) - startRow; i++) {
				Row r = resultData.get(i + startRow);
				currentData.put(i, r);
				// resultData.remove(i + startRow);
				// System.out.println("col:" + i + "; data1:" + r.get(0));
			}
			currentData.setTotalRows(resultData.getTotalRows());
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
			currentData.setStatus(new ActionStatus(e.getMessage(), ActionStatus.StatusType.ERROR));
		} catch (Exception e) {
			e.printStackTrace();
			currentData.setStatus(new ActionStatus(e.toString(), ActionStatus.StatusType.ERROR));
		}
		currentSortBy = sortBy;
		Utils.debug("FormInstance.fetch... return");
		return currentData;
	}
}
