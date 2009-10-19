package com.abssoft.constructor.client.form;

import java.util.ArrayList;
import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.common.FormTab;
import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.metadata.FormColumnsArr;
import com.abssoft.constructor.client.metadata.FormMD;
import com.abssoft.constructor.client.metadata.FormTabMD;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemHoverFormatter;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.events.ItemKeyPressEvent;
import com.smartgwt.client.widgets.form.events.ItemKeyPressHandler;
import com.smartgwt.client.widgets.form.fields.BooleanItem;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemIcon;
import com.smartgwt.client.widgets.form.fields.HeaderItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.IconClickEvent;
import com.smartgwt.client.widgets.form.fields.events.IconClickHandler;
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

	FormRowEditorTab(FormTabMD editorTab, final MainFormPane mainFormPane) {
		super(FormTab.TabType.EDITOR, mainFormPane.getFormCode());
		this.setMainFormPane(mainFormPane);
		// if (2 == 1) {
		final FormMD formMetadata = mainFormPane.getFormMetadata();
		final FormColumnsArr columns = formMetadata.getColumns();
		final int columnsCount = columns.size();
		ArrayList<FormItem> fieldsList = new ArrayList<FormItem>();
		for (int i = 0; i < columnsCount; i++) {
			boolean showHint = true;
			final FormColumnMD c = columns.get(i);
			if (editorTab.getTabCode().equals(c.getEditorTabCode())) {
				FormItem item;
				if ("3".equals(c.getTreeFieldType()) || "B".equals(c.getDataType())) {
					item = new BooleanItem();
				} else if ("4".equals(c.getFieldType())) {
					item = new TextAreaItem(); // new AutoFitTextAreaItem();
					item.setTitleOrientation(TitleOrientation.TOP);
				} else if ("5".equals(c.getFieldType())) {
					showHint = false;
					item = new RichTextItem();
					item.setTitleOrientation(TitleOrientation.TOP);
					item.setShowTitle(true);
				} else if ("6".equals(c.getFieldType())) {
					showHint = false;
					item = new HeaderItem();
				} else if ("7".equals(c.getFieldType())) {
					showHint = false;
					item = new HTMLPaneItem();
				} else if (null != c.getLookupCode() && ConstructorApp.staticLookupsArr.containsKey(c.getLookupCode())) {
					item = new ComboBoxItem(); // new SelectItem();
					LinkedHashMap<String, String> lhm = new LinkedHashMap<String, String>();
					lhm.putAll(ConstructorApp.staticLookupsArr.get(c.getLookupCode()));
					item.setValueMap(lhm);
				} else {
					item = new TextItem();
				}
				// item.setTextBoxStyle("textItem");
				item.setName(c.getName());
				item.setTitle(c.getDisplayName());
				item.setWidth("*");
				item.setColSpan("*"); // item.setRowSpan("*");
				item.setHeight(c.getEditorHeight());
				item.setEndRow(true);
				// Hint
				if (showHint) {
					final FormItemIcon icon = new FormItemIcon();
					icon.setSrc("[SKIN]/actions/help.png");
					item.setIcons(icon);
					// item.setShowDisabled(false);

					item.addIconClickHandler(new IconClickHandler() {
						public void onIconClick(IconClickEvent event) {
							if (icon.getSrc().equals(event.getIcon().getSrc())) {
								SC.say(c.getDescription());
							}
						}
					});
				}
				fieldsList.add(item);
			}
		}
		form = new DynamicForm();

		// !!
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
		form.setCellBorder(1);
		// form.setit
		form.setItemTitleHoverFormatter(new FormItemHoverFormatter() {
			@Override
			public String getHoverHTML(FormItem item, DynamicForm form) {
				// TODO цикл - возможно медленно, а что делать... Нужно добавить
				// еще HashMap<ColumnName, ColIndex> и по нему искать
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
				try {
					String itemName = event.getItem().getName();
					Utils.debug("onItemChanged... " + itemName);
					ListGrid g = getMainFormPane().getMainForm().getTreeGrid();
					int rn = mainFormPane.getCurrentGridRowSelected();
					if ("boolean".equals(event.getItem().getType())) {
						g.setEditValue(rn, itemName, event.getItem().getAttributeAsBoolean("value"));
					} else {
						g.setEditValue(rn, itemName, (String) event.getItem().getValue());
					}
				} catch (Exception e) {
					Utils.logException(e, "FormRowEditorTab.onItemChanged");
					e.printStackTrace();
				}
			}
		});
		form.addItemKeyPressHandler(new ItemKeyPressHandler() {

			@Override
			public void onItemKeyPress(ItemKeyPressEvent event) {
				// Escape
				System.out.println("FormRowEditorTab ItemKeyPressHandler KeyName: " + event.getKeyName());
				event.getItem().getName();
			}
		});
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
	public int getParentGridSelectedRow() {
		Utils.debug("parentGridSelectedRow get: " + parentGridSelectedRow);
		return parentGridSelectedRow;
	}
}