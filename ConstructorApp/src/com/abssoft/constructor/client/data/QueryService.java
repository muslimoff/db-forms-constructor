package com.abssoft.constructor.client.data;

import java.util.Map;

import com.abssoft.constructor.common.ConnectionInfo;
import com.abssoft.constructor.common.ExportData;
import com.abssoft.constructor.common.FormInstanceIdentifier;
import com.abssoft.constructor.common.MenusArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.RowsArr;
import com.abssoft.constructor.common.ServerInfoArr;
import com.abssoft.constructor.common.StaticLookupsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.google.gwt.user.client.rpc.RemoteService;

//@RemoteServiceRelativePath(ConstructorApp.queryServiceRelativePath)
public interface QueryService extends RemoteService {

	/**
	 * Подключение к серверу.
	 * 
	 * @param url
	 * @param user
	 * @param password
	 * @return <code>ConnectionInfo</code> Результаты подключения
	 */
	public ConnectionInfo connect(int ServerIdx, String user, String password, boolean isScript, String urlParams, Boolean isDebugEnabled);

	/**
	 * Получение метаданных формы (наименований столбцов и их типов и характеристик)
	 * 
	 * @param sessionId
	 * @param formCode
	 * @return <code>ArrayList<ColumnMetaData></code> метаданные...
	 */
	public FormMD getFormMetaData(FormInstanceIdentifier fi);

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
	public RowsArr fetch(FormInstanceIdentifier fi, String sortBy, int startRow, int endRow, Map<?, ?> criteria, boolean forceFetch);

	/**
	 * Выполнение DML на сервере
	 * 
	 * @param sessionId
	 * @param formCode
	 * @param gridHashCode
	 * @return Возвращает измененные на сервере данные;
	 */

	public Row executeDML(FormInstanceIdentifier fi, Row oldRow, Row newRow, FormActionMD actMD);

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
	public void closeForm(FormInstanceIdentifier fi, FormMD formState);

	public StaticLookupsArr getStaticLookupsArr(int sessionId);

	public ServerInfoArr getServerInfoArrWithoutPassword();

	public String getFile();

	public Integer setExportData(FormInstanceIdentifier fi, ExportData exportData);
}
