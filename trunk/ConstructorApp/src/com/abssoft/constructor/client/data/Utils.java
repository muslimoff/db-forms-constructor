package com.abssoft.constructor.client.data;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Vector;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.MapPair;
import com.abssoft.constructor.client.data.common.Row;
import com.abssoft.constructor.client.form.MainFormPane;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.ListGrid;
import com.smartgwt.client.widgets.tree.TreeNode;

public class Utils {
	public static TreeNode getTreeNodeFromRow(FormDataSourceField[] dsFields, Row row) {
		TreeNode result = new TreeNode();
		//Utils.debug("getListGridRecordFromRow:" + row);
		for (int c = 0; null != row && c < row.size(); c++) {
			String dsFieldName = dsFields[c].getName();
			String cellValue = row.get(c);
			boolean b = "T".equals(dsFields[c].getFormMetadata().getFormType()) && "4".equals(dsFields[c].getColumnMD().getTreeFieldType());

			if (dsFields[c].getType().equals(FieldType.BOOLEAN)) {
				result.setAttribute(dsFieldName, "1".equals(cellValue) || "Y".equals(cellValue));
			} else if (b || null != dsFields[c].getColumnMD().getFieldType() && dsFields[c].getColumnMD().getFieldType().equals("3")
					&& null != cellValue) {
				try {
					String iconFileName = ConstructorApp.menus.getIcons().get(Integer.decode(cellValue));
					result.setAttribute(dsFieldName, iconFileName);
				} catch (Exception e) {
					Utils.debug("Icon " + cellValue + " not found: " + e);
				}
			}

			else {
				result.setAttribute(dsFieldName, cellValue);
			}

			// 1
			if (dsFields[c].getType().equals(FieldType.BOOLEAN)) {
				result.setIsFolder(("1".equals(cellValue) || "Y".equals(cellValue)) && dsFields[c].isTreeFolder());
			}
			// if (dsFields[c].isTreeId()) {
			// listGridRecord.setID(cellValue);
			// listGridRecord.setName(cellValue);
			// }
			// if (dsFields[c].isTreeParentId()) {
			// listGridRecord.setParentID(cellValue);
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

	public static Row getRowFromFormFields(FormItem[] record) {
		Utils.debug("record>" + record);
		Row row = new Row();
		for (int i = 0; i < record.length; i++) {
			row.put(i, (String) record[i].getValue());
		}
		return row;
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

	public static Row getRowFromRecord(FormDataSourceField[] dsFields, Record record) {
		Row row = new Row();
		for (int c = 0; c < dsFields.length; c++) {
			String colName = dsFields[c].getName();
			String cellValue;
			if (FieldType.BOOLEAN.equals(dsFields[c].getType())) {
				cellValue = record.getAttributeAsBoolean(colName) ? "Y" : "N";
			} else {
				cellValue = record.getAttribute(colName);
			}
			debug(colName + ":" + cellValue + "; is null:" + (null == cellValue));
			row.put(c, cellValue);
		}
		return row;
	}

	public static Criteria getCriteriaFromListGridRecord(Record record) {
		Criteria criteria = new Criteria();
		for (String s : record.getAttributes()) {
			criteria.addCriteria(new Criteria(s, record.getAttribute(s)));
			Utils.debug("getCriteriaFromListGridRecord: " + s + " => " + record.getAttribute(s));
		}
		return criteria;

	}

	public static Criteria getCriteriaFromListGridRecord(Record record, String formCode) {
		Criteria criteria = getCriteriaFromListGridRecord(record);
		criteria.addCriteria(new Criteria("P_$MASTER_FORM_CODE", formCode));
		Utils.debug(formCode + " getCriteriaFromListGridRecord executed..");
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
		System.out.println("getEditedRow: getCurrentGridRowSelected=" + mainFormPane.getCurrentGridRowSelected());
		if (-1 != editRowIdx) {
			mainFormPane.setCurrentGridRowSelected(editRowIdx);
			record = grid.getEditedRecord(editRowIdx);
		} else {
			record = grid.getEditedRecord(mainFormPane.getCurrentGridRowSelected());
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
