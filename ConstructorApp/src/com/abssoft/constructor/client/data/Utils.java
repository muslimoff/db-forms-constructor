package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.data.common.Row;
import com.smartgwt.client.data.Criteria;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.FieldType;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.ListGridRecord;
import com.smartgwt.client.widgets.tree.TreeNode;

public class Utils {
	public static TreeNode getListGridRecordFromRow(FormDataSourceField[] dsFields, Row row) {
		TreeNode listGridRecord = new TreeNode();
		Utils.debug("getListGridRecordFromRow:" + row);
		for (int c = 0; c < row.size(); c++) {
			String dsFieldName = dsFields[c].getName();
			String cellValue = row.get(c);
			boolean b = "T".equals(dsFields[c].getFormMetadata().getFormType()) && "4".equals(dsFields[c].getColumnMD().getTreeFieldType());

			if (dsFields[c].getType().equals(FieldType.BOOLEAN)) {
				listGridRecord.setAttribute(dsFieldName, "1".equals(cellValue) || "Y".equals(cellValue));
			} else if (b || null != dsFields[c].getColumnMD().getFieldType() && dsFields[c].getColumnMD().getFieldType().equals("3")
					&& null != cellValue) {
				try {
					String iconFileName = ConstructorApp.menus.getIcons().get(Integer.decode(cellValue));
					listGridRecord.setAttribute(dsFieldName, iconFileName);
				} catch (Exception e) {
					Utils.debug("Icon " + cellValue + " not found: " + e);
				}
			} else {
				listGridRecord.setAttribute(dsFieldName, cellValue);
			}

			// 1
			if (dsFields[c].getType().equals(FieldType.BOOLEAN)) {
				listGridRecord.setIsFolder(("1".equals(cellValue) || "Y".equals(cellValue)) && dsFields[c].isTreeFolder());
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

		return listGridRecord;
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

	public static Row getRowFromListGridRecord(FormDataSourceField[] dsFields, ListGridRecord listGridRecord) {
		Row row = new Row();
		for (int c = 0; c < dsFields.length; c++) {
			String colName = dsFields[c].getName();
			String cellValue;
			if (FieldType.BOOLEAN.equals(dsFields[c].getType())) {
				cellValue = listGridRecord.getAttributeAsBoolean(colName) ? "Y" : "N";
			} else {
				cellValue = listGridRecord.getAttribute(colName);
				// cellValue = "null".equals(cellValue) ? null : cellValue;
			}
			debug(colName + ":" + cellValue + "; is null:" + (null == cellValue));
			row.put(c, cellValue);
		}
		return row;
	}

	public static Criteria getCriteriaFromListGridRecord(ListGridRecord record, String formCode) {
		Criteria criteria = new Criteria();
		criteria.addCriteria(new Criteria("P_$MASTER_FORM_CODE", formCode));
		for (String s : record.getAttributes()) {
			criteria.addCriteria(new Criteria(s, record.getAttribute(s)));
			Utils.debug(s + " >> " + record.getAttribute(s));
		}
		Utils.debug(formCode + "getCriteriaFromListGridRecord executed..");
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
}
