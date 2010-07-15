package com.abssoft.constructor.client.data;

import java.util.LinkedHashMap;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.metadata.FormColumnMD;
import com.abssoft.constructor.client.widgets.FormPickTreeItem;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.fields.BooleanItem;
import com.smartgwt.client.widgets.form.fields.ComboBoxItem;
import com.smartgwt.client.widgets.form.fields.DateItem;
import com.smartgwt.client.widgets.form.fields.FloatItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemIcon;
import com.smartgwt.client.widgets.form.fields.HeaderItem;
import com.smartgwt.client.widgets.form.fields.LinkItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.FocusEvent;
import com.smartgwt.client.widgets.form.fields.events.FocusHandler;
import com.smartgwt.client.widgets.form.fields.events.IconClickEvent;
import com.smartgwt.client.widgets.form.fields.events.IconClickHandler;

public class EditorFormItem extends FormItem {
	public static FormItem createItem(final FormColumnMD c, final MainFormPane mainFormPane) {
		final FormItem item;
		// boolean showHint = true;
		String lookupCode = c.getLookupCode();
		boolean showHint = !(null == c.getHelpText() || "".equals(c.getHelpText()));
		if ("3".equals(c.getTreeFieldType())) {
			item = new BooleanItem();
		} else if ("4".equals(c.getFieldType())) {
			item = new TextAreaItem(); // new AutoFitTextAreaItem();
		} else if ("5".equals(c.getFieldType())) {
			showHint = false;
			// TODO RichTextItem: Resize и все глюки.. Нужно свой класс MyRichTextItem
			//
			item = new RichTextItem();
			// item = new MyRichTextItem();
			item.setShowTitle(true);
		} else if ("6".equals(c.getFieldType())) {
			showHint = false;
			item = new HeaderItem();
		} else if ("7".equals(c.getFieldType())) {
			showHint = false;
			item = new HTMLPaneItem();
		} else if (("8".equals(c.getFieldType()) || "10".equals(c.getFieldType())) && null != lookupCode
				&& ConstructorApp.staticLookupsArr.containsKey(lookupCode)) {
			item = new ComboBoxItem();
			LinkedHashMap<String, String> lhm = Utils.createStrSortedLinkedHashMap(ConstructorApp.staticLookupsArr.get(lookupCode), !"8"
					.equals(c.getFieldType()));
			item.setValueMap(lhm);
		} else if ("9".equals(c.getFieldType()) && null != lookupCode) {
			item = new GridComboBoxItem(c, mainFormPane);
		} else if ("11".equals(c.getFieldType())) {
			item = new LinkItem();
		}
		// TODO PickTreeItem
		else if ("99".equals(c.getFieldType())) {
			item = new FormPickTreeItem(c, mainFormPane, null);
			item.setValue("Support");
		}
		//
		else {
			if ("D".equals(c.getDataType())) {
				item = new DateItem();
				((DateItem) item).setUseTextField(true);
				// ((DateItem) item).setDisplayFormat(DateDisplayFormat.TOEUROPEANSHORTDATE);
			} else if ("B".equals(c.getDataType())) {
				item = new BooleanItem();
			} else if ("N".equals(c.getDataType())) {
				item = new FloatItem();
			} else {
				item = new TextItem();
				if (null != c.getTextMask())
					((TextItem) item).setMask(c.getTextMask());
			}
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

	public EditorFormItem(final FormColumnMD c, final MainFormPane mainFormPane) {
		// super();
		// FormItem fitem = EditorFormItem.createItem(c, mainFormPane);
		// JSOHelper.apply(this.getJsObj(), fitem.getJsObj());
	}
}
