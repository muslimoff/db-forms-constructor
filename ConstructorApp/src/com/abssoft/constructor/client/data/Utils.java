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
import com.abssoft.constructor.client.metadata.Attribute;
import com.abssoft.constructor.client.metadata.IconsArr;
import com.abssoft.constructor.client.metadata.Row;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.tree.TreeNode;

public class Utils {
	public static TreeNode getTreeNodeFromRow(FormDataSourceField[] dsFields, Row row) {
		TreeNode result = new TreeNode();
		for (int c = 0; null != row && c < row.size(); c++) {
			String dsFieldName = dsFields[c].getName();
			Attribute attr = row.get(c);
			String cellValue = attr.getAttribute();
			Object obj = attr.getAttributeAsObject();
			boolean b = "T".equals(dsFields[c].getFormMetadata().getFormType()) && "4".equals(dsFields[c].getColumnMD().getTreeFieldType());
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
			} else if (obj instanceof Double) {
				result.setAttribute(dsFieldName, attr.getAttributeAsDouble());
			} else if (obj instanceof Date) {
				result.setAttribute(dsFieldName, attr.getAttributeAsDate());
			} else {
				result.setAttribute(dsFieldName, cellValue);
			}

			// 1
			// if ("1".equals(dsFields[c].getColumnMD().getTreeFieldType())) {
			// result.setID(cellValue);
			// result.setName(cellValue);
			// }
			// if ("2".equals(dsFields[c].getColumnMD().getTreeFieldType())) {
			// result.setParentID(cellValue);
			// }
			// if (dsFields[c].isTreeTitle()) {
			// listGridRecord.setTitle(cellValue);
			// }

		}

		return result;
	}

	public static void logException(Exception e) {
		logException(e, "Undefined");
	}

	public static void logException(Exception e, String txt) {
		// e.printStackTrace();
		Utils.debug(txt + ": " + e);
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

			Attribute attr;
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
						// TODO Ошипка при редактировании новой записи сразу после сохранения.
						// e.printStackTrace();
					}
				} else {
					try {
						fVal = record.getAttributeAsFloat(colName);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				Double cellValue = (null == fVal) ? null : fVal.doubleValue();
				attr = new Attribute(cellValue);
			} else if (FieldType.DATE.equals(dsFields[c].getType())) {
				Date cellValue = record.getAttributeAsDate(colName);
				attr = new Attribute(cellValue);
			} else {
				String cellValue = record.getAttribute(colName);
				attr = new Attribute(cellValue);
			}
			debug(colName + ":" + attr.getAttribute());
			row.put(c, attr);
		}
		return row;
	}

	public static Map<String, Object> getRowDefaultValuesMap(MainFormPane mainFormPane) {
		// TODO Issue 49 - Получение значения по умолчанию запросом.
		Utils.debug("getRowDefaultValuesMap...");
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		for (FormDataSourceField dsf : mainFormPane.getDataSource().getFormDSFields()) {

			String defVal = dsf.getColumnMD().getDefaultValue();
			String dataType = dsf.getColumnMD().getDataType();
			if (null != defVal) {
				if (null != mainFormPane.getParentFormPane()) {
					Criteria cc = mainFormPane.getParentFormPane().getInitialFilter();
					for (String s : cc.getAttributes()) {
						String attrVal = cc.getAttribute(s);
						attrVal = (null == attrVal) ? "" : attrVal;
						defVal = defVal.replaceAll("&" + s.toLowerCase() + "&", attrVal);
					}
				}
				Utils.debug("Default Value: After Bind variables replaced: " + dsf.getName() + " => " + defVal);
				if ("B".equals(dataType)) {
					result.put(dsf.getName(), "1".equals(defVal) || "Y".equals(defVal));
				} else {
					result.put(dsf.getName(), defVal);
				}
			}
		}
		return result;
	}

	public static Criteria getCriteriaFromListGridRecord(MainFormPane mainFormPane, Record record) {
		Criteria criteria = new Criteria();
		if (null != record) {
			for (String s : record.getAttributes()) {
				criteria.addCriteria(new Criteria(s, record.getAttribute(s)));
				Utils.debug("getCriteriaFromListGridRecord: " + s + " => " + record.getAttribute(s));
			}
			// TODO getCriteriaFromListGridRecord из getRowFromRecord
			/***********************/
			// Row row = getRowFromRecord(mainFormPane.getDataSource().getFormDSFields(), record);
			// for (int i = 0; i < row.size(); i++) {
			// }
			/***********************/
		}
		return criteria;

	}

	public static Criteria getxCriteriaFromListGridRecord(MainFormPane mainFormPane, Record record, String masterFormCode) {
		Criteria criteria = getCriteriaFromListGridRecord(mainFormPane, record);
		criteria.addCriteria(new Criteria("P_$MASTER_FORM_CODE", masterFormCode));
		Utils.debug(masterFormCode + " getCriteriaFromListGridRecord executed..");
		return criteria;

	}

	public static void debug(String text) {
		if (ConstructorApp.debugEnabled) {
			System.out.println(text);
			SC.logWarn(text);
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

	public static boolean isIE() {
		return SC.isIE();
	}

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

	public static Record getEditedRow(MainFormPane mainFormPane) {
		ListGrid grid = mainFormPane.getMainForm().getTreeGrid();
		Record record;
		int editRowIdx = grid.getEditRow();
		System.out.println("getEditedRow: editRowIdx=" + editRowIdx);
		System.out.println("getEditedRow: getCurrentGridRowSelected=" + mainFormPane.getSelectedRow());
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
}
