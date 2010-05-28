package com.abssoft.constructor.client.data;

import java.util.Map;

import com.abssoft.constructor.client.data.common.ClientActionType;
import com.abssoft.constructor.client.data.common.ConnectionInfo;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.MenusArr;
import com.abssoft.constructor.client.metadata.Row;
import com.abssoft.constructor.client.metadata.RowsArr;
import com.abssoft.constructor.client.metadata.ServerInfoArr;
import com.abssoft.constructor.client.metadata.StaticLookupsArr;
import com.google.gwt.user.client.rpc.RemoteService;
import com.google.gwt.user.client.rpc.RemoteServiceRelativePath;

@RemoteServiceRelativePath("query")
public interface QueryService extends RemoteService {

	/**
	 * Подключение к серверу.
	 * 
	 * @param url
	 * @param user
	 * @param password
	 * @return <code>ConnectionInfo</code> Результаты подключения
	 */
	public ConnectionInfo connect(int ServerIdx, String user, String password, boolean isScript);

	/**
	 * Получение метаданных формы (наименований столбцов и их типов и характеристик)
	 * 
	 * @param sessionId
	 * @param formCode
	 * @return <code>ArrayList<ColumnMetaData></code> метаданные...
	 */
	public FormMD getFormMetaData(int sessionId, String formCode);

	/**
	 * Получение данных о доступных формах (Название, горячая клавиша вызова...)
	 * 
	 * @param sessionId
	 * @return <code>MenusArr</code> данные доступных форм для построения меню
	 */
	public MenusArr getMenusArr(int sessionId);

	/**
	 * Получение части результата запроса
	 * 
	 * @param sessionId
	 * @param formCode
	 * @param gridHashCode
	 * @param sortBy
	 * @param startRow
	 * @param endRow
	 * @return <code>RowsArr</code>
	 */
	public RowsArr fetch(int sessionId, String formCode, int gridHashCode, String sortBy, int startRow, int endRow, Map<?, ?> criteria,
			boolean forceFetch);

	/**
	 * Выполнение DML на сервере
	 * 
	 * @param sessionId
	 * @param formCode
	 * @param gridHashCode
	 * @return Возвращает измененные на сервере данные;
	 */

	public Row executeDML(int sessionId, String formCode, int gridHashCode, Row oldRow, Row newRow, String actionCode,
			ClientActionType clientActionType);

	/**
	 * Закрывает текущую сессию (перед выходом из приложения).
	 * 
	 * @param sessionId
	 */
	public void sessionClose(int sessionId);

	/**
	 * Закрывает Resultset для формы
	 * 
	 * @param sessionId
	 * @param formCode
	 * @param gridHashCode
	 */
	public void closeForm(int sessionId, String formCode, int gridHashCode, FormMD formState);

	public StaticLookupsArr getStaticLookupsArr(int sessionId);

	public ServerInfoArr getServerInfoArr();
}
