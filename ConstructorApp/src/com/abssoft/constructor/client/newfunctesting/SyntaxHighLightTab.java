package com.abssoft.constructor.client.newfunctesting;

import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.widgets.CodeEditorItem;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.TextAreaItem;
import com.smartgwt.client.widgets.form.fields.events.ChangedEvent;
import com.smartgwt.client.widgets.form.fields.events.ChangedHandler;
import com.smartgwt.client.widgets.form.fields.events.FocusEvent;
import com.smartgwt.client.widgets.form.fields.events.FocusHandler;
import com.smartgwt.client.widgets.tab.Tab;
import com.smartgwt.client.widgets.tab.events.TabSelectedEvent;
import com.smartgwt.client.widgets.tab.events.TabSelectedHandler;

class SyntaxHighLightTab extends Tab {

	TextAreaItem tai = new TextAreaItem("test");
	DynamicForm f = new DynamicForm();
	CodeEditorItem codeEditor = new CodeEditorItem();
	CodeEditorItem codeEditor2 = new CodeEditorItem();
	boolean isRendered = false;

	SyntaxHighLightTab() {
		this.addTabSelectedHandler(new SHTabSelectedHandler());
		codeEditor2.addChangedHandler(new SHChangedHandler());
		f.setItems(codeEditor2, codeEditor, tai);
		setPane(f);
		tai.addFocusHandler(new TAFocusHandler());
		tai.addChangedHandler(new TAChangedHandler());

	}

	public void init() {
		tai.focusInItem();
	}

	public String getTextAreaID(DynamicForm form) {
		String textAreaID = form.getInnerHTML();
		com.google.gwt.user.client.Window.alert("0-1>>>" + textAreaID);
		textAreaID = textAreaID.replaceFirst("<FORM.*<TEXTAREA.*?ID=", "").replaceFirst(" .*$", "");
		com.google.gwt.user.client.Window.alert("0-2>>>" + textAreaID);
		return textAreaID;
	}

	private final class TAFocusHandler implements FocusHandler {
		@Override
		public void onFocus(FocusEvent event) {
			if (!isRendered) {
				isRendered = true;
				tai.setValue("{\n	if (1==2) {\n	}\n}");
				// initCodeMirror(getTextAreaID(event.getForm()));
			}
		}
	}

	private final class TAChangedHandler implements ChangedHandler {
		@Override
		public void onChanged(ChangedEvent event) {
			String value = (null != event.getValue()) ? event.getValue().toString() : null;
			Utils.debug("SyntaxHighLightTab.tai.onChanged.event.getValue:" + value);
			codeEditor.setValue(value);
		}
	}

	private final class SHTabSelectedHandler implements TabSelectedHandler {
		@Override
		public void onTabSelected(TabSelectedEvent event) {
			Utils.debug("SyntaxHighLightTab.onTabSelected...");
			codeEditor.setValue("declare\n  x dual%rowtype;\nbegin\n select * into x from dual;\nend;");
			codeEditor2.setValue("declare\n  xz dual%rowtype;\nbegin\n select * into x from dual;\nend;");

		}
	}

	private final class SHChangedHandler implements ChangedHandler {
		@Override
		public void onChanged(ChangedEvent event) {
			Utils.debug("SyntaxHighLightTab.codeEditor.onChanged.event.getValue:" + event.getValue());
			Utils.debug("SyntaxHighLightTab.codeEditor.onChanged.codeEditor2.getValue:" + codeEditor2.getValue());
			codeEditor.setValue(codeEditor2.getValue());
			tai.setValue(codeEditor2.getValue());

		}
	}
}