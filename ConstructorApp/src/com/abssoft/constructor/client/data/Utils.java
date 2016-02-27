package com.abssoft.constructor.client.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.MapPair;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.widgets.ActionStatusWindow;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.common.ActionStatus.StatusType;
import com.abssoft.constructor.common.Attribute;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.IconsArr;
import com.abssoft.constructor.common.Row;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.google.gwt.core.client.GWT;
import com.google.gwt.dom.client.Element;
import com.google.gwt.i18n.client.DateTimeFormat;
import com.google.gwt.user.client.Window;
import com.google.gwt.user.client.rpc.ServiceDefTarget;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeGrid;
import com.smartgwt.client.widgets.tree.TreeNode;

public class Utils {
	private static String dateFormat = "dd.MM.yyyy";

	public static QueryServiceAsync createQueryService(String id) {
		QueryServiceAsync res = (QueryServiceAsync) GWT.create(QueryService.class);
		((ServiceDefTarget) res).setServiceEntryPoint(ConstructorApp.AIRmoduleBaseURL + ConstructorApp.queryServiceRelativePath);
		if (Utils.isAIR() && ConstructorApp.debugEnabled) {
			Window.alert("AIRmoduleBaseURL(" + id + "): " + ConstructorApp.AIRmoduleBaseURL);
		}
		return res;
	}

	public static String dateToString(Date date) {
		if (date == null)
			return null;
		DateTimeFormat dateFormatter = DateTimeFormat.getFormat(getDateFormat());

		// mm20120722 Попытка пофиксить проблему с датами в Атырау.
		// http://forums.smartclient.com/showthread.php?t=7823&highlight=timezone
		// было так: String dateString = dateFormatter.format(date);
		String dateString = dateFormatter.format(date);
		// теперь так:
		// import com.google.gwt.i18n.client.TimeZone;
		// import com.google.gwt.i18n.client.TimeZoneInfo;
		// import com.google.gwt.i18n.client.constants.TimeZoneConstants;
		// import com.smartgwt.client.util.DateUtil;

		// final TimeZoneConstants timeZoneConstants =
		// GWT.create(TimeZoneConstants.class);
		// // TimeZone tzAsiaAlmaty =
		// TimeZone.createTimeZone(TimeZoneInfo.buildTimeZoneData(timeZoneConstants.asiaAlmaty()));
		// // TimeZone tzAsiaAlmaty =
		// TimeZone.createTimeZone(TimeZoneInfo.buildTimeZoneData(timeZoneConstants.europeAthens()));
		// TimeZone tzAsiaAlmaty = TimeZone.createTimeZone(0);
		// tzAsiaAlmaty.getOffset(date);
		//
		// String dateString = dateFormatter.format(date, tzAsiaAlmaty);
		// String dateString = dateFormatter.format(date);
		// String dateString = DateUtil.formatAsShortDatetime(date);
		// debug("tttt0-1 >> dateString:" + dateString + "; date:" + date +
		// "; TimeZone: " + tzAsiaAlmaty.getShortName(date)
		// + "; tzAsiaAlmaty.getOffset(date):" + tzAsiaAlmaty.getOffset(date));

		return dateString;
	}

	public static Date stringToDate(String dateString) {
		// TODO mm20120722 - не вызывается никогда что-ли?
		// mm20120722 Попытка пофиксить проблему с датами в Атырау.
		// Было:
		final DateTimeFormat dateFormatter = DateTimeFormat.getFormat(getDateFormat());
		Date date = dateFormatter.parse(dateString);
		// стало:
		// final DateTimeFormat dateFormatter =
		// DateTimeFormat.getFormat(dateFormat + ".zzzz");
		// Date date = dateFormatter.parse(dateString + ".GMT");
		// debug("tttt0-2 >> dateString:" + dateString + "; date:" + date);
		return date;
	}

	public static TreeNode getTreeNodeFromRow(FormDataSourceField[] dsFields, Row row) {
		TreeNode result = new TreeNode();
		String formType = null != dsFields[0] ? dsFields[0].getFormMetadata().getFormType() : null;
		MainFormPane mainFormPane = null != dsFields[0] ? dsFields[0].getMainFormPane() : null;
		for (int c = 0; null != row && c < row.size(); c++) {
			String dsFieldName = dsFields[c].getName();
			Attribute attr = row.get(c);
			String cellValue = attr.getAttribute();
			Object obj = attr.getAttributeAsObject();
			boolean b = "T".equals(formType) && "4".equals(dsFields[c].getColumnMD().getTreeFieldType());
			if (b || null != dsFields[c].getColumnMD().getFieldType() && dsFields[c].getColumnMD().getFieldType().equals("3")
					&& null != cellValue) {
				try {
					String iconFileName = ConstructorApp.menus.getIcons().get((Float.valueOf(cellValue)).intValue());
					result.setAttribute(dsFieldName, iconFileName);
				} catch (Exception e) {
					Utils.debug("Icon " + cellValue + " not found: " + e);
				}
			} else if (obj instanceof Boolean) {
				Boolean bVal = attr.getAttributeAsBoolean();
				result.setAttribute(dsFieldName, bVal);
				if (dsFields[c].isTreeFolder()) {
					result.setIsFolder(bVal);
				}

				if (dsFields[c].isCanAcceptDrop()) {
					result.setCanAcceptDrop(bVal);
				}
				if (dsFields[c].isCanDrag()) {
					result.setCanDrag(bVal);
				}
			} else if (obj instanceof Double) {
				result.setAttribute(dsFieldName, attr.getAttributeAsDouble());
			} else if (obj instanceof Date) {
				result.setAttribute(dsFieldName, attr.getAttributeAsDate());
				//
				Utils.debug("tttt5-1:" + attr.getAttributeAsDate());
				Utils.debug("tttt5-2:" + result.getAttributeAsDate(dsFieldName));
				// result.setAttribute(dsFieldName,
				// Utils.stringToDate(Utils.dateToString(attr.getAttributeAsDate())));
				// Utils.debug("tttt5-3:" +
				// result.getAttributeAsDate(dsFieldName));
				// //
				// Utils.debug("tttt5-4:" +
				// Utils.dateToString(attr.getAttributeAsDate()));
				// Utils.debug("tttt5-5:" + DateTimeFormat.getFormat(dateFormat
				// + "-zzzz").format(attr.getAttributeAsDate()));

			} else {
				result.setAttribute(dsFieldName, cellValue);
			}
		}

		// 20130316 - добавлена обработка для возможности Drop на leaf
		// TODO - теоретически от иконки наверное избавиться. Лучше зарегить их
		// иконку как свою и вперед...
		if ("T".equals(formType)) {
			try {
				TreeGrid treeGrid = ((TreeGrid) mainFormPane.getMainForm().getTreeGrid());

				if (!result.getAttributeAsBoolean("isFolder")) {
					result.setIsFolder(true);
					result.setChildren(new TreeNode[] {});
					String customIconProperty = treeGrid.getCustomIconProperty();
					String defaultNodeIcon = treeGrid.getNodeIcon();
					String customIconValue = result.getAttribute(customIconProperty);
					customIconValue = null == customIconValue ? defaultNodeIcon : customIconValue;
					result.setAttribute(customIconProperty, customIconValue);
					if (null == result.getIcon()) {
						result.setIcon(defaultNodeIcon);
					}
				} else {
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}

	public static Map<String, Object> getMapFromRow(FormDataSourceField[] dsFields, Row row) {
		Map<String, Object> result = new LinkedHashMap<String, Object>();

		TreeNode treeNode = getTreeNodeFromRow(dsFields, row);
		for (int c = 0; null != row && c < row.size(); c++) {
			String dsFieldName = dsFields[c].getName();
			result.put(dsFieldName, treeNode.getAttributeAsObject(dsFieldName));
		}
		return result;
	}

	public static void logException(Exception e) {
		logException(e, "Undefined");
	}

	public static void logException(Exception e, String txt) {
		// e.printStackTrace();
		Utils.debugAlert(txt + ": " + e);
	}

	public static TreeNode getTreeNodeFromRecordWithoutRef(FormDataSourceField[] dsFields, Record record) {
		TreeNode treeNode = new TreeNode(JSOHelper.createObject());
		for (FormDataSourceField dsf : dsFields) {
			String colName = dsf.getName();
			if (FieldType.BOOLEAN.equals(dsf.getType())) {
				treeNode.setAttribute(colName, record.getAttributeAsBoolean(colName));
			} else {
				treeNode.setAttribute(colName, record.getAttribute(colName));
			}
		}
		return treeNode;
	}

	public static List<Object> getKeysFromValue(Map<?, ?> hm, Object value) {
		List<Object> list = new ArrayList<Object>();
		for (Object o : hm.keySet()) {
			if (hm.get(o).equals(value)) {
				list.add(o);
			}
		}
		return list;
	}

	public static Row getRowFromRecord(FormDataSourceField[] dsFields, Record record) {
		Row row = new Row();
		for (int c = 0; c < dsFields.length; c++) {
			String colName = dsFields[c].getName();

			Attribute attr = new Attribute();
			try {
				if (FieldType.BOOLEAN.equals(dsFields[c].getType())) {
					Boolean cellValue = record.getAttributeAsBoolean(colName);
					attr = new Attribute(cellValue);
				} else if (FieldType.FLOAT.equals(dsFields[c].getType())) {
					Float fVal = null;
					// Icons
					if ("3".equals(dsFields[c].getColumnMD().getFieldType()) //
							|| "4".equals(dsFields[c].getColumnMD().getTreeFieldType())) {
						try {
							IconsArr iArr = ConstructorApp.menus.getIcons();
							fVal = ((Integer) getKeysFromValue(iArr, record.getAttribute(colName)).get(0)).floatValue();
						} catch (Exception e) {
							// TODO Ошипка при редактировании новой записи сразу
							// после сохранения.
							// e.printStackTrace();
						}
					} else {
						try {
							fVal = null != record.getAttribute(colName) ? record.getAttributeAsFloat(colName) : null;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
					Double cellValue = (null == fVal) ? null : fVal.doubleValue();
					attr = new Attribute(cellValue);
				} else if (FieldType.DATE.equals(dsFields[c].getType())) {
					Date cellValue = record.getAttributeAsDate(colName);
					attr = new Attribute((Date) cellValue);
				} else {
					String cellValue = record.getAttribute(colName);
					attr = new Attribute(cellValue);
				}

			} catch (Exception e) {
				// TODO JavaScript орет тут для несохраненных записей
				e.printStackTrace();
			}
			if (null == attr.getAttributeAsObject()) {
				attr.setDataType(dsFields[c].getColumnMD().getDataType());
			}
			debug("Utils.getRowFromRecord. " + colName + ":" + attr.getAttribute() + "; Type:" + dsFields[c].getType() + ";"
					+ dsFields[c].getColumnMD().getDataType());
			row.put(c, attr);
		}
		return row;
	}

	public static Row getEditedRow(FormDataSourceField[] dsFields, Row oldRow, Row newRow) {
		Row row = new Row();
		for (int i = 0; i < dsFields.length; i++) {
			Attribute a;
			try {
				a = newRow.containsKey(i) ? newRow.get(i) : oldRow.get(i);
				System.out.println(i + ":newRow:" + newRow.containsKey(i));
				System.out.println(i + ":oldRow:" + oldRow.containsKey(i));
				row.put(i, a);
			} catch (Exception e) {
				a = new Attribute();
				System.out.println("Utils.getEditedRow - unknown attribute exception:");
				e.printStackTrace();
			}
			System.out.println("Utils.getEditedRow[" + i + "]" + dsFields[i].getName() + ": " + a.getAttribute());
		}
		return row;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> getRowDefaultValuesMap(MainFormPane mainFormPane) {
		Utils.debug("01 getRowDefaultValuesMap...");
		String dateFormat = "EEE MMM dd yyyy hh:mm:ss ZZZZ";
		DateTimeFormat fmt = DateTimeFormat.getFormat(dateFormat);
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		Criteria cc = mainFormPane.getParentFormCriteria();

		Map<String, Object> critMap = cc.getValues();
		for (FormDataSourceField dsf : mainFormPane.getDataSource().getFormDSFields()) {
			try {
				String defVal = dsf.getColumnMD().getDefaultValue();
				String dataType = dsf.getColumnMD().getDataType();
				Object objDefaultValue = null;
				if (null != defVal) {
					Iterator<String> itr = critMap.keySet().iterator();
					while (itr.hasNext()) {
						String key = itr.next();
						Object val = critMap.get(key);
						Utils.debug("02 getRowDefaultValuesMap... key:" + key + "=" + val);
						String attrVal;
						if (val instanceof Date) {
							attrVal = (null == val) ? "" : fmt.format((Date) val);
						} else {
							attrVal = (null == val) ? "" : val + "";
						}
						defVal = defVal.replaceAll("&" + key.toLowerCase() + "&", attrVal);
						Utils.debug("03 getRowDefaultValuesMap... key:" + key + "=" + val);
					}
					defVal = defVal.replaceAll("&[0-0a-zA-Z_]+&", "");
					Utils.debug("04 Default Value: After Bind variables replaced: " + dsf.getName() + " => " + defVal);
					if ("B".equals(dataType)) {
						objDefaultValue = (Boolean) "1".equals(defVal) || "Y".equals(defVal);
					} else if ("N".equals(dataType)) {
						Double v = null;
						try {
							v = "".equals(defVal) ? null : Double.valueOf(defVal);
							Utils.debug("05 getRowDefaultValuesMap...");
						} catch (Exception e) {
							Utils.debug("06 Number transform Error: " + e.getMessage());
							e.printStackTrace();
						}
						objDefaultValue = (Double) v;
					} else if ("D".equals(dataType)) {
						Date v = null;
						try {
							v = "".equals(defVal) ? null : fmt.parse(defVal);
						} catch (Exception e) {
							Utils.debug("07 Date transform Error: " + defVal + "; " + e.getMessage());
							e.printStackTrace();
						}
						objDefaultValue = (Date) v;
					} else {
						objDefaultValue = defVal;
					}
					if (null != objDefaultValue)
						result.put(dsf.getName(), objDefaultValue);
				}

			} catch (Exception e) {
				Utils.debug("08 getRowDefaultValuesMap other Error:" + e.getMessage());
			}
		}
		// ------
		Utils.debug("UrlCriteria. mainFormPane.isMasterForm():" + (null == mainFormPane.getParentFormPane()));
		Utils.debug("UrlCriteria. mainFormPane.isFromUrl():" + mainFormPane.isFromUrl());
		if (// mainFormPane.isMasterForm()
		null == mainFormPane.getParentFormPane() && mainFormPane.isFromUrl()) {
			// result.putAll(ConstructorApp.urlParamsCriteria.getValues());
			// ///////////////
			Iterator<String> i = ConstructorApp.urlParamsCriteria.getValues().keySet().iterator();
			while (i.hasNext()) {
				String key = i.next();
				String val = (String) ConstructorApp.urlParamsCriteria.getValues().get(key);
				// System.out.println("!!!" + ky + ": " + val);
				result.put(key.toUpperCase(), val);
			}
		}
		// ------
		Utils.debug("09 getRowDefaultValuesMap...");
		return result;

	}

	private static Criteria getCriteriaFromListGridRecord1(FormDataSourceField[] dsFields, Record record) {
		Utils.debug("getCriteriaFromListGridRecord start");
		Criteria criteria = new Criteria();
		if (null != record) {
			// TODO getCriteriaFromListGridRecord из getRowFromRecord
			/***********************/
			Row row = getRowFromRecord(dsFields, record);
			for (int i = 0; i < row.size(); i++) {
				Attribute attr = row.get(i);
				Object obj = attr.getAttributeAsObject();
				String dsFieldName = dsFields[i].getName();
				Utils.debug("getCriteriaFromListGridRecord: " + dsFieldName + " => "
						+ ((null != obj) ? (obj.toString() + " -> " + obj.getClass()) : "null"));
				if (obj instanceof Boolean) {
					criteria.addCriteria(dsFieldName, attr.getAttributeAsBoolean());
				} else if (obj instanceof Double) {
					JSOHelper.setAttribute(criteria.getJsObj(), dsFieldName, attr.getAttributeAsDouble());
				} else if (obj instanceof Date) {
					criteria.addCriteria(dsFieldName, attr.getAttributeAsDate());
				} else {
					criteria.addCriteria(dsFieldName, attr.getAttribute());
				}
			}
			/***********************/
		}
		Utils.debug("getCriteriaFromListGridRecord end.. dsFields:" + dsFields);
		return criteria;

	}

	public static Criteria getCriteriaFromListGridRecord2(MainFormPane mainFormPane, Record record
	// , String masterFormCode,String masterFormTabCode
	) {
		//
		Criteria criteria = getCriteriaFromListGridRecord1(mainFormPane.getDataSource().getFormDSFields(), record);
		// //criteria.addCriteria(new Criteria(Constants.formMasterFormCode,
		// masterFormCode));
		// // criteria.addCriteria(new Criteria(Constants.formMasterFormTabCode,
		// masterFormTabCode));
		// // try {
		// // criteria.addCriteria(new Criteria(Constants.formMasterFormCode,
		// mainFormPane.getParentFormPane().getFormCode()));
		// // } catch (Exception e) {
		// // Utils.debug("Can't define system variable \"" +
		// Constants.formMasterFormCode + "\": " + e.getMessage());
		// // criteria.addCriteria(new Criteria(Constants.formMasterFormCode,
		// e.getMessage()));
		// // // Utils.debugAlert("6: Err");
		// // }
		// // // criteria.addCriteria(new
		// Criteria(Constants.formMasterFormTabCode, masterFormCode));
		// // try {
		// // // Utils.debugAlert("0:" +
		// mainFormPane.getParentFormPane().getFormCode());
		// // // Utils.debugAlert("1:" + mainFormPane);
		// // // Utils.debugAlert("2:" + mainFormPane.getMainFormContainer());
		// // // Utils.debugAlert("3:" +
		// mainFormPane.getMainFormContainer().getTabMetaData());
		// // // Utils.debugAlert("4:" +
		// mainFormPane.getMainFormContainer().getTabMetaData().getTabCode());
		// // String masterFormTabCode =
		// mainFormPane.getMainFormContainer().getTabMetaData().getTabCode();
		// // criteria.addCriteria(new Criteria(Constants.formMasterFormTabCode,
		// "Ssssssssss"));// masterFormTabCode));
		// // // Utils.debugAlert("5: OK. " + masterFormTabCode);
		// // } catch (Exception e) {
		// // Utils.debug("Can't define system variable \"" +
		// Constants.formMasterFormTabCode + "\": " + e.getMessage());
		// // criteria.addCriteria(new Criteria(Constants.formMasterFormTabCode,
		// e.getMessage()));
		// // // Utils.debugAlert("6: Err");
		// // }
		Utils.debug("getCriteriaFromListGridRecord executed... mainFormPane: " // +
																				// mainFormPane
		);
		return criteria;

	}

	public static void debug(String text) {
		debug(text, false);
	}

	public static void debugAlert(String text) {
		debug(text, true);
	}

	private static void debug(String text, boolean withAlert) {
		if (ConstructorApp.debugEnabled) {
			System.out.println("CLNT:" + text);
			if (GWT.isScript()) {
				SC.logWarn(text);
			}
			if (withAlert) {
				try {
					String shortMsg = (text.length() > 100) ? text.substring(0, 100) : text;
					ActionStatusWindow.createActionStatusWindow("DebugAlert", shortMsg, text, StatusType.WARNING, null, "OK");
				} catch (Exception e) {
					try {
						Window.alert(e.getMessage() + "\n" + text);
					} catch (Exception ee) {
						ee.printStackTrace();
					}
				}
			}
		}
	}

	public static native boolean isChrome()
	/*-{
		return $wnd.isc.Browser.isChrome;
	}-*/;

	public static native boolean isFirefox()
	/*-{
		return $wnd.isc.Browser.isFirefox;
	}-*/;

	public static native boolean isMoz()
	/*-{
		return $wnd.isc.Browser.isMoz;
	}-*/;

	public static native boolean isAIR()
	/*-{
		return $wnd.isc.Browser.isAIR;
	}-*/;

	public static boolean isIE() {
		return SC.isIE();
	}

	public static native String getClientVersion()
	/*-{
		return $wnd.clientVersion;
	}-*/;

	public static LinkedHashMap<String, String> createStrKeySortedLinkedHashMap(HashMap<String, String> mm) {
		final LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
		Vector<String> v = new Vector<String>(mm.keySet());
		Collections.sort(v);
		Iterator<String> mmIt = v.iterator();
		while (mmIt.hasNext()) {
			String key = mmIt.next();
			result.put(key, mm.get(key));
		}
		return result;
	}

	public static LinkedHashMap<String, String> createStrValSortedLinkedHashMap(HashMap<String, String> srcMap) {
		HashMap<String, MapPair> mapPair = new HashMap<String, MapPair>();
		Iterator<String> keyIt = srcMap.keySet().iterator();
		while (keyIt.hasNext()) {
			String key = keyIt.next();
			String value = srcMap.get(key);
			mapPair.put(value, new MapPair(key, value));
		}
		List<String> mapValues = new ArrayList<String>(srcMap.values());
		Collections.sort(mapValues);
		LinkedHashMap<String, String> result = new LinkedHashMap<String, String>();
		Iterator<String> valueIt = mapValues.iterator();
		while (valueIt.hasNext()) {
			String value = valueIt.next();
			result.put(mapPair.get(value).getKey(), value);
		}

		return result;
	}

	public static LinkedHashMap<String, String> createStrSortedLinkedHashMap(HashMap<String, String> mm, boolean isSortByValue) {
		if (isSortByValue) {
			return createStrValSortedLinkedHashMap(mm);
		} else {
			return createStrKeySortedLinkedHashMap(mm);
		}
	}

	public static void debugRecord(Record r, String recTitle) {
		Utils.debug("debugRecord." + recTitle + "; " + r);
		if (null != r) {
			for (String s : r.getAttributes()) {
				Utils.debug("	DEBUGRECORD " + recTitle + ". FIELD: " + s + "=" + r.getAttribute(s));
			}
		}
	}

	// TODO - Пересмотреть кучу хлама на использование класса JSOHelper
	public static Record getNewRecordWithOldValues(Record oldRecord, Record newRecord) {
		Record rec = (null != oldRecord) ? oldRecord : newRecord;
		if (null != oldRecord) {
			JSOHelper.apply(newRecord.getJsObj(), rec.getJsObj());
		}

		return rec;
	}

	public static Record getEditedRecord(MainFormPane mainFormPane) {
		ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		Record record;
		int editRowIdx = grid.getEditRow();
		Utils.debug("getEditedRow: editRowIdx=" + editRowIdx);
		Utils.debug("getEditedRow: getCurrentGridRowSelected=" + mainFormPane.getSelectedRow());
		if (-1 != editRowIdx) {
			mainFormPane.setSelectedRow(editRowIdx);
			record = grid.getEditedRecord(editRowIdx);
		} else {
			record = grid.getEditedRecord(mainFormPane.getSelectedRow());
		}
		// //////////
		// else {
		// Record selRec = grid.getSelectedRecord();
		// record = new ListGridRecord(selRec.getJsObj());
		// Map<?, ?> ev = grid.getEditValues(selRec);
		// Iterator<?> it = ev.keySet().iterator();
		// while (it.hasNext()) {
		// String mapKey = (String) it.next();
		// String value = (String) ev.get(mapKey);
		// Utils.debug("Nonsaved Edit: " + mapKey + "=" + value);
		// record.setAttribute(mapKey, value);
		// }
		// }
		return record;
	}

	// см com.abssoft.constructor.server.Utils.getExceptionStackIntoString
	public static String getExceptionStack(Throwable caught) {
		String result = caught.toString() + "\n"; // .getMessage();
		StackTraceElement[] elements = caught.getStackTrace();
		for (StackTraceElement e : elements) {
			result = result + "at " + e.toString() + "\n";
		}
		return result;
	}

	// Error При передаче Double почему-то передается Float и летим/ Поэтому -
	// явно преобразовываем...
	@SuppressWarnings("unchecked")
	public static LinkedHashMap<String, Object> getHashMapFromCriteria(Criteria cr) {
		Utils.debug("Utils.getHashMapFromCriteria start..." + cr);
		Map<String, Object> filterValues = cr.getValues();
		Utils.debug("Utils.getHashMapFromCriteria. filterValues:" + filterValues + "");
		LinkedHashMap<String, Object> filterValues2 = new LinkedHashMap<String, Object>();
		{
			Iterator<String> it = filterValues.keySet().iterator();
			while (it.hasNext()) {
				String key = it.next();
				Object val = filterValues.get(key);
				Utils.debug(
						"Utils.getHashMapFromCriteria. key:" + key + ":=>" + val + "; class:" + ((null != val) ? val.getClass() : null));
				if (val instanceof Float && null != val) {
					val = Double.valueOf(val.toString());
				}
				filterValues2.put(key, val);
			}
		}
		Utils.debug("Utils.getHashMapFromCriteria end...");
		return filterValues2;
	}

	public static ArrayList<String> createArrayListFromRecord(Record r, MainFormPane mainFormPane, ArrayList<String> headers,
			ArrayList<String> displHeaders) {
		ArrayList<String> row = new ArrayList<String>();
		for (int i = 0; i < headers.size(); i++) {
			String attrName = (null == displHeaders.get(i)) ? headers.get(i) : displHeaders.get(i);
			FormColumnMD cmd = mainFormPane.getFormMetadata().getColumns().get(attrName);
			String value = "";
			try {
				value = r.getAttribute(attrName);
				if ("8".equals(cmd.getFieldType()) && ConstructorApp.staticLookupsArr.containsKey(cmd.getLookupCode())) {
					value = ConstructorApp.staticLookupsArr.get(cmd.getLookupCode()).get(value);
				} else if ("D".equals(cmd.getDataType())) {
					value = Utils.dateToString(r.getAttributeAsDate(attrName));
				} else if ("B".equals(cmd.getDataType())) {
					// TODO Сделать лукап true/false -> Да/Нет
					value = r.getAttributeAsBoolean(attrName) ? "Y" : "N";
				} else
				if ("9".equals(cmd.getFieldType()) && null == cmd.getLookupDisplayValue()) {
					value = r.getAttribute(attrName);
					Integer colIdx = mainFormPane.getFormMetadata().getColumns().getColIndex(attrName);

					GridComboBoxItem cbx = (GridComboBoxItem) mainFormPane.getFormColumns().getEditorFormItems()[colIdx];
					if (null == cbx) {
						cbx = mainFormPane.getFormColumns().getGridFields()[colIdx].getGridComboBoxItem();
					}
					value = cbx.getValues().containsKey(value) ? cbx.getValues().get(value).getAttribute(cbx.getDisplayFieldName()) : value;
				}
			} catch (Exception e) {
				value = e.getMessage();
			}
			row.add(value);
		}
		return row;
	}

	public static String replaceBindVariables(MainFormPane mainFormPane, ListGridRecord selectedRecord, String str, String chr,
			boolean urlEncode) {
		String result = str;
		Utils.debug("replaceBindVariables1. selectedRecord:" + selectedRecord);
		try {
			FormColumnsArr fca = mainFormPane.getFormMetadata().getColumns();
			if (null != str && str.contains(chr)) {
				Iterator<Integer> itr = fca.keySet().iterator();
				while (itr.hasNext()) {
					String columnName = fca.get(itr.next()).getName();
					try {
						String columnValue = selectedRecord.getAttribute(columnName);
						if (urlEncode) {
							columnValue = com.google.gwt.http.client.URL.encodeQueryString(columnValue);
						}
						result = result.replaceAll(chr + columnName.toLowerCase() + chr, columnValue);
						Utils.debug("columnName:" + columnName + "; columnValue:" + columnValue + "; result:" + result);
					} catch (Exception e) {
						Utils.debug("replaceBindVariables1. Error:" + e.getMessage());
						e.printStackTrace();
					}
				}
			}
		} catch (Exception e) {
			Utils.debug("replaceBindVariables. Error:" + e.getMessage() + "\n" + e);
			e.printStackTrace();
		}
		return result;
	}

	public static String replaceBindVariables(MainFormPane mainFormPane, String str, String chr) {
		return Utils.replaceBindVariables(mainFormPane, mainFormPane.getMainForm().getTreeGrid().getSelectedRecord(), str, chr, false);
	}

	// public static String replaceBindVariables(MainFormPane mainFormPane,
	// ListGridRecord selectedRecord, String str) {
	// return Utils.replaceBindVariables(mainFormPane, selectedRecord, str,
	// "&");
	// }

	public static String replaceBindVariables(MainFormPane mainFormPane, String str) {
		return Utils.replaceBindVariables(mainFormPane, str, "&");
	}

	// //
	public static void openURL(FormActionMD formActionMD, ListGridRecord selectedRecord, MainFormPane mainFormPane) {
		if (null != formActionMD.getUrlText()) {
			System.out.println("111<<<<<<<<<<<<<<<<<<<<>>>>>>>>selectedRecord: " + selectedRecord);
			try {
				String actionUrl = null != formActionMD.getUrlText() ? formActionMD.getUrlText() : formActionMD.getSqlProcedureName();
				actionUrl = Utils.replaceBindVariables(mainFormPane, selectedRecord, actionUrl, ":", true);
				actionUrl = actionUrl.replaceAll("\\[ModuleBaseURL\\]", ConstructorApp.moduleBaseURL);
				actionUrl = actionUrl.replaceAll("\\[HostPageBaseURL\\]", ConstructorApp.hostPageBaseURL);
				actionUrl = actionUrl.replaceAll("\\[ModuleName\\]", ConstructorApp.moduleName);
				//Кодирует все, в т.ч. и параметры. Поэтому, для статического текста нельзя писать кирилицей - только в виде: 
				//	%xx hexadecimal escape sequence. Поэтому вынесена в Utils.replaceBindVariables
				//actionUrl = com.google.gwt.http.client.URL.encodeQueryString(actionUrl);
				com.google.gwt.user.client.Window.open(actionUrl, "", "");
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			// System.out.println("ssssssssssssssssssssssssssssssssssssssssssss");
		}
	}

	// openURL Для нестрочных действий (напр. Refresh), когда берем первую
	// попавшуюся выбранную строку
	public static void openURL2(FormActionMD formActionMD, MainFormPane mainFormPane) {
		System.out
				.println("222<<<<<<<<<<<<<<<<<<<<>>>>>>>>selectedRecord: " + mainFormPane.getMainForm().getTreeGrid().getSelectedRecord());
		openURL(formActionMD, mainFormPane.getMainForm().getTreeGrid().getSelectedRecord(), mainFormPane);
	}

	static public native String getComputedStyleProperty(Element el, String property)
	/*-{
		if (window['getComputedStyle']) { // W3C DOM method
			if (property === 'float')
				property = 'cssFloat';

			var value = el.style[property], computed;

			if (!value) {
				computed = el['ownerDocument']['defaultView']['getComputedStyle']
						(el, null);
				if (computed) { // test computed before touching for safari
					value = computed[property];
				}
			}
			return value;

		} else if (el['currentStyle']) {
			var value;

			switch (property) {
			case 'opacity':// IE opacity uses filter
				value = 100;
				try { // will error if no DXImageTransform
					value = el.filters['DXImageTransform.Microsoft.Alpha'].opacity;

				} catch (e) {
					try { // make sure its in the document
						value = el.filters('alpha').opacity;
					} catch (err) {
					}
				}
				return value / 100;
			case 'float': // fix reserved word
				property = 'styleFloat'; // fall through
			default:
				value = el['currentStyle'] ? el['currentStyle'][property]
						: null;
				return (el.style[property] || value);
			}
		}
		return "";
	}-*/;

	public static String getDateFormat() {
		return dateFormat;
	}

	public static void setDateFormat(String dateFormat) {
		Utils.dateFormat = dateFormat;
	}

}
