package com.abssoft.constructor.client.data;

import com.abssoft.constructor.client.ConstructorApp;
import com.abssoft.constructor.client.form.MainFormPane;
import com.abssoft.constructor.client.widgets.CodeEditorItem;
import com.abssoft.constructor.client.widgets.FormLookupComboboxItem;
import com.abssoft.constructor.client.widgets.FormPickTreeItem;
import com.abssoft.constructor.client.widgets.GridComboBoxItem;
import com.abssoft.constructor.client.widgets.HTMLPaneItem;
import com.abssoft.constructor.client.widgets.MyComboBoxItem;
import com.abssoft.constructor.common.metadata.ColumnAction;
import com.abssoft.constructor.common.metadata.FormColumnMD;
import com.abssoft.constructor.common.metadata.FormMD;
import com.smartgwt.client.data.Record;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.util.SC;
import com.smartgwt.client.widgets.form.fields.BooleanItem;
import com.smartgwt.client.widgets.form.fields.DateItem;
import com.smartgwt.client.widgets.form.fields.FloatItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.FormItemIcon;
import com.smartgwt.client.widgets.form.fields.HeaderItem;
import com.smartgwt.client.widgets.form.fields.LinkItem;
import com.smartgwt.client.widgets.form.fields.RichTextItem;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.TextItem;
import com.smartgwt.client.widgets.form.fields.events.BlurEvent;
import com.smartgwt.client.widgets.form.fields.events.BlurHandler;
import com.smartgwt.client.widgets.form.fields.events.FocusEvent;
import com.smartgwt.client.widgets.form.fields.events.FocusHandler;
import com.smartgwt.client.widgets.form.fields.events.IconClickEvent;
import com.smartgwt.client.widgets.form.fields.events.IconClickHandler;
import com.smartgwt.client.widgets.form.fields.events.KeyPressEvent;
import com.smartgwt.client.widgets.form.fields.events.KeyPressHandler;

public class EditorFormItem extends FormItem {
	public static FormItem createItem(final FormColumnMD c, final MainFormPane mainFormPane) {
		FormMD fmd = mainFormPane.getFormMetadata();
		final FormItem item;
		// LinkedHashMap
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
			// 20110913 - пофиксил косяк FormRowEditorTab.onItemChanged, снова появившийся в SGWT 2.5
			// при проверке - раньше getAttribute("type") возвращало "RichTextItem". Теперь внутри делают setAttribute("editorType",
			// "RichTextItem");
			item.setType("RichTextItem");

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
			item = new MyComboBoxItem(c, mainFormPane) {

				@Override
				public void onSelectValue(FormItem item, Record rec) {
					// TODO Auto-generated method stub
				}

				@Override
				public void onClearValue(FormItem item) {
					// TODO Auto-generated method stub

				}
			};
			((MyComboBoxItem) item).setLookupSize(c.getLookupWidth(), c.getLookupHeight(), fmd.getLookupWidth(), fmd.getLookupHeight());
			// LinkedHashMap<String, String> lhm = Utils.createStrSortedLinkedHashMap(ConstructorApp.staticLookupsArr.get(lookupCode), !"8"
			// .equals(c.getFieldType()));
			// ((MyComboBoxItem) item).setValueMap(lhm);
			((MyComboBoxItem) item).setValueMap(lookupCode);
		} else if ("9".equals(c.getFieldType()) && null != lookupCode) {
			item = new GridComboBoxItem(c, mainFormPane);
		} else if ("11".equals(c.getFieldType())) {
			item = new LinkItem();
		} else if ("15".equals(c.getFieldType())) {
			item = new CodeEditorItem(); // c + mainFormPane.getJsObj().toString() // просто ID
		} else if ("16".equals(c.getFieldType()) && null != lookupCode) {
			item = new FormLookupComboboxItem(c, mainFormPane);
		}
		// TODO PickTreeItem
		else if ("99".equals(c.getFieldType())) {
			item = new FormPickTreeItem(c, mainFormPane, null);
			item.setValue("Support");
		}
		//
		else {
			if ("D".equals(c.getDataType())) {
				DateItem dateItem = new DateItem();
				// dateItem.setInputFormat("DMY");
				// dateItem.setMaskDateSeparator(".");
				dateItem.setUseTextField(true);
				// http: // forums.smartclient.com/showthread.php?t=11017&highlight=DateChooser+DateItem
				// http://forums.smartclient.com/showthread.php?t=8868&highlight=custom+dateItem
				item = dateItem;
			} else if ("B".equals(c.getDataType())) {
				item = new BooleanItem();
			} else if ("N".equals(c.getDataType())) {
				item = new FloatItem();
				// 20130514 - Добавлено выравнивание по правому краю для чисел
				item.setAlign(com.smartgwt.client.types.Alignment.RIGHT);
			} else {
				item = new TextItem();

				// if (null != c.getTextMask())
				// ((TextItem) item).setMask(c.getTextMask());
			}
		}
		// item.setTextBoxStyle("textItem");
		item.setName(c.getName());
		item.setTitle(c.getDisplayName());
		item.setWidth("*");
		item.setColSpan(c.getEditorColsSpan());
		// item.setRowSpan("*");
		if (null != c.getEditorHeight()) {
			item.setHeight(c.getEditorHeight());
		}
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
		// !!!!!!!!
		if (null != c.getEditorOnEnterKeyAction()) {
			item.addKeyPressHandler(new KeyPressHandler() {

				@Override
				public void onKeyPress(KeyPressEvent event) {
					if ("Enter".equals(event.getKeyName())) {
						mainFormPane.getButtonsToolBar().actionItemsMap.get(c.getEditorOnEnterKeyAction()).doActionWithConfirm(
								mainFormPane.getSelectedRow());
					}
				}
			});
		}
		// TODO - циклит при входе/выходе из поля при обращении к БД
		/***************** Действия ***********************/
		for (int j = 0; 1 == 2 && j < c.getColActions().size(); j++) {
			final ColumnAction ca = c.getColActions().get(j);
			System.out.println("getColAction(" + j + "):" + ca);
			String actionType = ca.getColActionTypeCode();
			if ("1".equals(actionType)) {
				// TODO Отловить Enter
				// this.addChangedHandler(new ChangedHandler() {
				// @Override
				// public void onChanged(ChangedEvent event) {
				//
				// }
				// });
			}
			if ("2".equals(actionType)) {
				item.addFocusHandler(new FocusHandler() {
					@Override
					public void onFocus(FocusEvent event) {
						mainFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode()).doActionWithConfirm(
								mainFormPane.getSelectedRow());
					}
				});
			}

			if ("3".equals(actionType)) {
				item.addBlurHandler(new BlurHandler() {

					@Override
					public void onBlur(BlurEvent event) {
						mainFormPane.getButtonsToolBar().actionItemsMap.get(ca.getActionCode()).doActionWithConfirm(
								mainFormPane.getSelectedRow());
					}
				});

			}
			// if ("4".equals(actionType) && item instanceof ComboBoxItem && 1 == 2) {
			// }
		}
		return item;
	}

	public EditorFormItem(final FormColumnMD c, final MainFormPane mainFormPane) {
		// super();
		// FormItem fitem = EditorFormItem.createItem(c, mainFormPane);
		// JSOHelper.apply(this.getJsObj(), fitem.getJsObj());
	}
}
