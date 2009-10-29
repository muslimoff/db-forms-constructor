package com.abssoft.constructor.server;

import java.sql.ResultSet;
import java.util.Map;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;

import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.data.common.RowsArr;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;

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
		try {
			rs.close();
			statement.close();
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
	}

	public RowsArr fetch(String sortBy, int startRow, int endRow, Map<?, ?> filterValues, boolean forceFetch) {
		RowsArr currentData = new RowsArr();
		try {
			// Первый вызов DataSource или изменение сортировки, фильтров, а
			// также принудительно
			if (forceFetch || -1 == currentEndRow || currentSortBy != sortBy || !currentFilterValues.equals(filterValues)) {
				Utils.debug("Erase ResultSetData....");
				currentEndRow = -1;
				resultData = new RowsArr();
				String sqlText = formSQLText
						+ ((sortBy != null) ? ("\n" + "order by " + sortBy.replaceAll("-", "") + (sortBy.contains("-") ? " desc" : ""))
								: "");
				Utils.debug(sqlText);
				statement = (OraclePreparedStatement) connection.prepareStatement("select count(*) cnt from (" + sqlText + "\n)"); // statement
				Utils.setFilterValues(statement, filterValues);
				rs = statement.executeQuery();
				rs.next();
				resultData.setTotalRows(rs.getInt("CNT"));
				rs.close();
				statement.close();
				statement = (OraclePreparedStatement) connection.prepareStatement(sqlText);
				Utils.setFilterValues(statement, filterValues);
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
					if (!rs.next()) {
						rs.close();
						statement.close();
						break;
					}
				} catch (java.sql.SQLException e) {
					Utils.debug("Error on close resultset/statement: " + e);
					break;
				}

				Row r = new Row();
				// System.out.println("rowNum: " + rowNum);
				for (int colNum = 0; colNum < columnsArr.size(); colNum++) {
					try {
						String cellVal = rs.getString(columnsArr.get(colNum).getName());
						// Необходимо убирать символы chr #00, которые может
						// возвращать БД - иначе grid вылетает..
						if (null != cellVal) {
							cellVal = cellVal.replaceAll(Character.toString((char) 0), "");
						}
						r.put(colNum, cellVal);
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
			currentData.setStatus(e.toString());
		} catch (Exception e) {
			e.printStackTrace();
			currentData.setStatus(e.toString());
		}
		currentSortBy = sortBy;
		return currentData;
	}
}
