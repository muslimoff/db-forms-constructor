package com.abssoft.constructor.client.form;

import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Vector;

import com.abssoft.constructor.client.data.FormDataSourceField;
import com.abssoft.constructor.client.data.FormTreeGridField;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.common.FormColumnsArr;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.abssoft.constructor.common.metadata.FormTabMD;
import com.smartgwt.client.data.SortSpecifier;
import com.smartgwt.client.types.Alignment;
import com.smartgwt.client.types.SortDirection;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.HeaderSpan;

public class FormColumns {
	int columnsCount;
	FormColumnsArr columns;
	FormMD formMetadata;
	FormTreeGridField[] gridFields;
	FormDataSourceField[] dataSourceFields;
	FormItem[] editorFormItems;
	SortSpecifier[] defaultSort = null;
	private Map<String, HeaderSpan> gridHeaderSpansMap = new LinkedHashMap<String, HeaderSpan>();

	public FormItem[] getEditorFormItems() {
		return editorFormItems;
	}

	MainFormPane mainFormPane;

	boolean hasBottomTabsCount = false;
	boolean hasSideTabsCount = false;

	public FormColumns(MainFormPane mainFormPane) {
		this.formMetadata = mainFormPane.getFormMetadata();
		this.columns = formMetadata.getColumns();
		this.mainFormPane = mainFormPane;
		this.columnsCount = columns.size();
		this.gridFields = new FormTreeGridField[columnsCount];
		this.dataSourceFields = new FormDataSourceField[columnsCount];
		this.editorFormItems = new FormItem[columnsCount];

		for (FormTabMD e : formMetadata.getTabs()) {
			if (e.getTabPosition().equals("B"))
				hasBottomTabsCount = true;
			else
				hasSideTabsCount = true;
		}
		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD m = columns.get(i);
			// По умолчанию, если getFieldType=1 или =2, и табик не указан,
			// значит боковой динамический детейл
			if (("1".equals(m.getFieldType()) || "2".equals(m.getFieldType()))
					&& null == m.getEditorTabCode())
				hasSideTabsCount = true;
		}

		Utils.debug("bottomTabsCount: " + hasBottomTabsCount
				+ "; sideTabsCount: " + hasSideTabsCount);
	}

	public FormDataSourceField[] createDSFields() {
		for (int i = 0; i < columnsCount; i++) {
			dataSourceFields[i] = new FormDataSourceField(i, mainFormPane);
		}
		return dataSourceFields;
	}

	public FormTreeGridField[] createGridFields() {
		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD m = columns.get(i);
			gridFields[i] = new FormTreeGridField(mainFormPane, i, m);
			gridFields[i].setPrompt(m.getDescription());
			gridFields[i].setAlign(Alignment.CENTER);

			String fieldDataType = m.getDataType();
			if ("N".equalsIgnoreCase(fieldDataType)
					|| "D".equalsIgnoreCase(fieldDataType)) {
				gridFields[i].setCellAlign(Alignment.RIGHT);
			} else if ("S".equalsIgnoreCase(fieldDataType)) {
				gridFields[i].setCellAlign(Alignment.LEFT);
			}

			{// 20130727 HeaderSpans. Разбивка перенесена на серверную часть
				// (Form.getColumns)
				HeaderSpan hs = null;
				String headerName = m.getHeaderName();
				if (null != headerName) {
					if (gridHeaderSpansMap.containsKey(headerName)) {
						hs = gridHeaderSpansMap.get(headerName);
						String[] srcArr = hs.getFields();
						int srcArrLength = srcArr.length;
						String[] destArr = new String[srcArrLength + 1];
						System.arraycopy(srcArr, 0, destArr, 0, srcArrLength);
						destArr[srcArrLength] = gridFields[i].getName();
						hs.setFields(destArr);
						// for (int ddd = 0; ddd < destArr.length; ddd++) {
						// System.out.println(">>> ddd[" + ddd + "]=" +
						// destArr[ddd]);
						// }

					} else {
						hs = new HeaderSpan(headerName,
								new String[] { gridFields[i].getName() });
						gridHeaderSpansMap.put(headerName, hs);
					}
				}
			}
		}
		return gridFields;
	}

	public HeaderSpan[] getHeaderSpans() {

		HeaderSpan[] result = new HeaderSpan[gridHeaderSpansMap.size()];
		Iterator<String> mmIt = gridHeaderSpansMap.keySet().iterator();
		int i = 0;
		while (mmIt.hasNext()) {
			String key1 = mmIt.next();
			result[i] = gridHeaderSpansMap.get(key1);
			i++;
		}

		return result;
	}

	public FormDataSourceField[] getDataSourceFields() {
		return dataSourceFields;
	}

	public SortSpecifier[] getDefaultSort() {
		Utils.debug("getDefaultSort.columns:" + columns);
		if (null != defaultSort) {
			return defaultSort;
		}
		HashMap<String, String> x = new HashMap<String, String>();
		Iterator<Integer> itr = columns.keySet().iterator();
		while (itr.hasNext()) {
			Integer colIdx = itr.next();
			FormColumnMD cmd = columns.get(colIdx);
			if (null != cmd.getDefaultOrderByNumber()) {
				x.put(cmd.getDefaultOrderByNumber(), cmd.getName());
			}
		}
		SortSpecifier[] result = new SortSpecifier[] {};
		if (0 != x.size()) {
			Vector<String> v = new Vector<String>(x.keySet());
			Collections.sort(v);
			Iterator<String> i1 = v.iterator();
			result = new SortSpecifier[x.size()];
			int k = 0;
			while (i1.hasNext()) {
				String colSortIdx = i1.next();
				Utils.debug("getDefaultSort. colSortIdx: " + colSortIdx
						+ " => " + x.get(colSortIdx));
				SortDirection sd = colSortIdx.contains("-") ? SortDirection.DESCENDING
						: SortDirection.ASCENDING;
				result[k++] = new SortSpecifier(x.get(colSortIdx).replaceAll(
						"-", ""), sd);
			}
		}
		return result;
	}

	public FormTreeGridField[] getGridFields() {
		return gridFields;
	}
}
