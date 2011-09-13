package com.abssoft.constructor.client.form;

import java.util.ArrayList;

import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.EditorFormItem;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.FormTabMD;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemHoverFormatter;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.grid.ListGrid;

/**
 * Один табик формы редактора
 * 
 * @author User
 * 
 */
public class FormRowEditorTab extends FormTab {
	DynamicForm form;
	private int parentGridSelectedRow;
	private ArrayList<FormItem> fieldsList = new ArrayList<FormItem>();

	FormRowEditorTab(FormTabMD editorTab, MainFormPane mainFormPane) {
		super(FormTab.TabType.EDITOR, mainFormPane.getFormCode());
		this.setMainFormPane(mainFormPane);
		final FormMD formMetadata = getMainFormPane().getFormMetadata();
		final FormColumnsArr columns = formMetadata.getColumns();
		final int columnsCount = columns.size();

		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD c = columns.get(i);
			if (editorTab.getTabCode().equals(c.getEditorTabCode())) {
				FormItem item = EditorFormItem.createItem(c, mainFormPane);
				// FormItem item = new EditorFormItem(c, mainFormPane);
				fieldsList.add(item);
				mainFormPane.getFormColumns().editorFormItems[i] = item;
			}
		}
		form = new DynamicForm();

		// TODO Дизейбл формы при отсутствии изменений сделать.
		// form.setDisabled(!formMetadata.getActions().isUpdateAllowed());
		if (0 != editorTab.getNumberOfColumns()) {
			form.setNumCols(editorTab.getNumberOfColumns());
		}
		form.setColWidths("*");
		form.setDataSource(mainFormPane.getDataSource());
		mainFormPane.getValuesManager().addMember(form);
		form.setWrapItemTitles(false);
		form.setAutoWidth();
		form.setFields(fieldsList.toArray(new FormItem[fieldsList.size()]));
		this.setTitle(getIconTitle(editorTab.getTabName(), editorTab.getIconId()));
		// TODO Рамки формочек вынести в опции приложения. Пока убрал.
		// if (false && ConstructorApp.debugEnabled) {form.setCellBorder(1);}
		form.setItemTitleHoverFormatter(new FormItemHoverFormatter() {
			@Override
			public String getHoverHTML(FormItem item, DynamicForm form) {
				String s = item.getName();
				for (int i = 0; i < columnsCount; i++) {
					FormColumnMD c = columns.get(i);
					if (c.getName().equals(s)) {
						s = c.getDescription();
						break;
					}
				}
				return s;
			}
		});
		form.addItemChangedHandler(new ItemChangedHandler() {

			@Override
			public void onItemChanged(ItemChangedEvent event) {
				FormItem item = event.getItem();
				String itemName = item.getName();
				String itemType = item.getType();
				try {
					// FormItem item = event.getItem();
					// // item.setType(type);
					// String itemName = item.getName();
					// String itemType = item.getType();
					Object itemValue = event.getItem().getValue();
					Utils.debug("FormRowEditorTab.onItemChanged... " + itemName + "; " + itemType);
					ListGrid g = getMainFormPane().getMainForm().getTreeGrid();
					int rn = getMainFormPane().getSelectedRow();
					if ("boolean".equals(itemType)) {
						g.setEditValue(rn, itemName, item.getAttributeAsBoolean("value"));
					} else if ("date".equals(itemType)) {
						g.setEditValue(rn, itemName, item.getAttributeAsDate("value"));
					}
					// //
					// else if ("float".equals(itemType)) {
					// g.setEditValue(rn, itemName, item.getAttributeAsFloat("value"));
					// }
					/***/
					else if ("RichTextItem".equals(itemType)) {
						// TODO Пустышки в richTextItem косячат.. Возможно из-за преобразования (String) event.getItem().getValue()
						if (!"".equals(itemValue) && null != g.getRecord(rn).getAttribute(itemName)) {
							g.setEditValue(rn, itemName, item.getAttribute("value"));
						}
					} else {
						Utils.debug("FormRowEditorTab.onItemChanged... ???. Value:  " + item.getAttribute("value"));
						Utils.debug("FormRowEditorTab.onItemChanged... ???. LGRecord:"+g.getRecord(rn));
						// System.out.println(">>" + item.getValue() + "; " + item.getValue().getClass());
						String val = null;
						try {
							val = item.getAttribute("value");
						} catch (java.lang.IllegalArgumentException e) {
							Object objVal = item.getValue();
							val = null == objVal ? null : objVal + "";
						}
						g.setEditValue(rn, itemName, val);
					}

				} catch (Exception e) {
					Utils.logException(e, "FormRowEditorTab.onItemChanged. itemType:" + itemType + "; itemName:" + itemName);
					e.printStackTrace();
				}
			}
		});
		/*
		 * Read Only - reject changes form.addItemChangeHandler(new ItemChangeHandler() {
		 * 
		 * @Override public void onItemChange(ItemChangeEvent event) {event.getItem().setAttribute("value", event.getItem().getValue() +"");
		 * } });
		 */
		this.setPane(form);
		// }
	}

	/**
	 * @return the form
	 */
	public DynamicForm getForm() {
		return form;
	}

	/**
	 * @param form
	 *            the form to set
	 */
	public void setForm(DynamicForm form) {
		this.form = form;
	}

	/**
	 * @param parentGridSelectedRow
	 *            the parentGridSelectedRow to set
	 */
	public void setParentGridSelectedRow(int parentGridSelectedRow) {
		this.parentGridSelectedRow = parentGridSelectedRow;
		Utils.debug("parentGridSelectedRow set to " + parentGridSelectedRow);
	}

	/**
	 * @return the parentGridSelectedRow
	 */
	public int getxParentGridSelectedRow() {
		Utils.debug("parentGridSelectedRow get: " + parentGridSelectedRow);
		return parentGridSelectedRow;
	}
}