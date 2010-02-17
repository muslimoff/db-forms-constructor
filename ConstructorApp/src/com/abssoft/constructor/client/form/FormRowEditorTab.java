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
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.FormItemHoverFormatter;
import com.smartgwt.client.widgets.form.events.ItemChangedEvent;
import com.smartgwt.client.widgets.form.events.ItemChangedHandler;
import com.smartgwt.client.widgets.form.fields.BooleanItem;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemIcon;
import com.smartgwt.client.widgets.form.fields.HeaderItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.FocusEvent;
import com.smartgwt.client.widgets.form.fields.events.FocusHandler;
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

	static FormItem createItem(final FormColumnMD c, final MainFormPane mainFormPane) {
		FormItem item;
		// boolean showHint = true;
		boolean showHint = !(null == c.getHelpText() || "".equals(c.getHelpText()));
		if ("3".equals(c.getTreeFieldType()) || "B".equals(c.getDataType())) {
			item = new BooleanItem();
		} else if ("4".equals(c.getFieldType())) {
			item = new TextAreaItem(); // new AutoFitTextAreaItem();
			// @item.setTitleOrientation(TitleOrientation.TOP);
		} else if ("5".equals(c.getFieldType())) {
			showHint = false;
			item = new RichTextItem();
			// @item.setTitleOrientation(TitleOrientation.TOP);
			item.setShowTitle(true);
		} else if ("6".equals(c.getFieldType())) {
			showHint = false;
			item = new HeaderItem();
		} else if ("7".equals(c.getFieldType())) {
			showHint = false;
			item = new HTMLPaneItem();
		} else if (("8".equals(c.getFieldType()) || "10".equals(c.getFieldType())) && null != c.getLookupCode()
				&& ConstructorApp.staticLookupsArr.containsKey(c.getLookupCode())) {
			item = new ComboBoxItem();
			LinkedHashMap<String, String> lhm = Utils.createStrSortedLinkedHashMap(ConstructorApp.staticLookupsArr.get(c.getLookupCode()),
					!"8".equals(c.getFieldType()));
			System.out.println("$$ LHM: " + c.getLookupCode() + ". Values: " + lhm);
			item.setValueMap(lhm);
		} else if ("9".equals(c.getFieldType()) && null != c.getLookupCode()) {
			item = new GridComboBoxItem(mainFormPane);
			mainFormPane.putLookup(c.getLookupCode(), (GridComboBoxItem) item);
		} else {
			item = new TextItem();
			if (null != c.getTextMask())
				((TextItem) item).setMask(c.getTextMask());
		}
		// item.setTextBoxStyle("textItem");
		item.setName(c.getName());
		item.setTitle(c.getDisplayName());
		item.setWidth("*");
		item.setColSpan(c.getEditorColsSpan());
		// item.setRowSpan("*");
		item.setHeight(c.getEditorHeight());
		item.setEndRow(c.isEditorEndRow());
		TitleOrientation titleOrientation = "L".equals(c.getEditorTitleOrientation()) ? TitleOrientation.LEFT : ("R".equals(c
				.getEditorTitleOrientation()) ? TitleOrientation.LEFT : TitleOrientation.TOP);
		item.setTitleOrientation(titleOrientation);
		// Hint
		if (showHint) {
			final FormItemIcon icon = new FormItemIcon();
			icon.setSrc("[SKIN]/actions/help.png");
			item.setIcons(icon);
			// item.setShowDisabled(false);

			item.addIconClickHandler(new IconClickHandler() {
				public void onIconClick(IconClickEvent event) {
					if (icon.getSrc().equals(event.getIcon().getSrc())) {
						String helpText = c.getHelpText();
						helpText = null != helpText ? helpText : c.getDescription();
						helpText = null != helpText ? helpText : "???";
						SC.say(helpText);
					}
				}
			});
		}
		item.addFocusHandler(new FocusHandler() {

			@Override
			public void onFocus(FocusEvent event) {
				Utils.debug("Formcode: " + mainFormPane.getFormCode() + " Event: onFocus; FormRowEditorTab > Item:"
						+ event.getItem().getFieldName());
				ConstructorApp.mainToolBar.setForm(mainFormPane);
			}
		});
		return item;
	}

	FormRowEditorTab(FormTabMD editorTab, MainFormPane mainFormPane) {
		super(FormTab.TabType.EDITOR, mainFormPane.getFormCode());
		this.setMainFormPane(mainFormPane);
		final FormMD formMetadata = getMainFormPane().getFormMetadata();
		final FormColumnsArr columns = formMetadata.getColumns();
		final int columnsCount = columns.size();
		ArrayList<FormItem> fieldsList = new ArrayList<FormItem>();
		for (int i = 0; i < columnsCount; i++) {
			FormColumnMD c = columns.get(i);
			if (editorTab.getTabCode().equals(c.getEditorTabCode())) {
				FormItem item = createItem(c, mainFormPane);
				fieldsList.add(item);
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
				// TODO цикл - возможно медленно, а что делать... Нужно добавить еще HashMap<ColumnName, ColIndex> и по нему искать
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
					int rn = getMainFormPane().getCurrentGridRowSelected();
					if ("boolean".equals(event.getItem().getType())) {
						g.setEditValue(rn, itemName, event.getItem().getAttributeAsBoolean("value"));
					} else if (
					// TODO Пустышки в richTextItem косячат.. Возможно из-за преобразования (String) event.getItem().getValue()
					"RichTextItem".equals(event.getItem().getType())) {
						if (!"".equals(event.getItem().getValue()) && null != g.getRecord(rn).getAttribute(itemName)) {
							g.setEditValue(rn, itemName, (String) event.getItem().getValue());
						}
					} else {
						g.setEditValue(rn, itemName, (String) event.getItem().getValue());
					}

				} catch (Exception e) {
					Utils.logException(e, "FormRowEditorTab.onItemChanged");
					e.printStackTrace();
				}
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