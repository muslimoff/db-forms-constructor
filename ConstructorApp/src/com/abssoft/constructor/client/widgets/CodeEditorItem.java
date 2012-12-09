package com.abssoft.constructor.client.widgets;

import com.abssoft.constructor.client.data.Utils;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.google.gwt.event.logical.shared.ValueChangeHandler;
import com.google.gwt.user.client.ui.TextArea;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.events.ShowValueEvent;
import com.smartgwt.client.widgets.form.fields.events.ShowValueHandler;

//TODO Сделать lazy loading подсветки синтаксиса: http://stackoverflow.com/questions/7968831/gwt-deferred-loading-of-external-js-resources
public class CodeEditorItem extends CanvasItem {

	public class CodeEditorTextArea extends TextArea {

		public JavaScriptObject getCodeMirror() {
			return codeMirror;
		}

		private JavaScriptObject codeMirror;

		private boolean isFiredFromSetValue;

		CodeEditorTextArea(String id) {
			super();
			this.getElement().setId(id);
			isFiredFromSetValue = false;
		}

		@SuppressWarnings("unused")
		private void fireValueChangeEvent(String value) {
			Utils.debug("0. CodeEditorTextArea.fireValueChangeEvent. isFiredFromSetValue:" + isFiredFromSetValue);
			if (!isFiredFromSetValue) {
				ValueChangeEvent.fire(this, value);
			}
		}

		/**
		 * Создание JS-объекта CodeMirror
		 * 
		 * @param id
		 * @return
		 */
		private native JavaScriptObject initCodeMirror(CodeEditorTextArea ceta, String id) /*-{
			var editor = $wnd.CodeMirror.fromTextArea($doc.getElementById(id), {
			lineNumbers: true,
			matchBrackets: true,
			indentUnit: 4,
			mode: "text/x-plsql",
			onChange:
			function xx(){
			//editor.save(); //editor.toTextArea(); $wnd.alert(editor.getValue());
			ceta.@com.abssoft.constructor.client.widgets.CodeEditorItem.CodeEditorTextArea::fireValueChangeEvent(Ljava/lang/String;)(editor.getValue());
			}
			});
			return editor;
		}-*/;

		@Override
		protected void onLoad() {
			codeMirror = initCodeMirror(CodeEditorTextArea.this, CodeEditorTextArea.this.getElement().getId());
			isFiredFromSetValue = false;
			setValue(CodeEditorItem.this.value);
		}

		private native void setValue(JavaScriptObject cm, String content) /*-{
			cm.setValue(content);
			cm.clearHistory();
		}-*/;

		@Override
		public void setValue(String value) {
			setValue(value, false);
		}

		@Override
		public void setValue(String value, boolean fireEvents) {
			isFiredFromSetValue = !fireEvents;
			super.setValue(value, fireEvents);

			Utils.debug("1. setValue. isFiredFromSetValue:" + isFiredFromSetValue + "\n" + this.getValue());
			setValue(codeMirror, value);
			isFiredFromSetValue = false;
		}
	}

	/*********************************/

	private CodeEditorTextArea codeEditorTextArea;

	private String value;

	public CodeEditorItem() {
		super();
		String id = getJsObj().hashCode() + "";
		this.setShouldSaveValue(true);
		this.setTitleOrientation(TitleOrientation.TOP);
		this.setColSpan("*");
		this.setHeight("200");
		codeEditorTextArea = new CodeEditorTextArea(id);
		Canvas c = new Canvas();
		c.setBorder("2px solid blue");
		c.setCanDragResize(true);
		c.addChild(codeEditorTextArea);
		codeEditorTextArea.setWidth("100%");
		codeEditorTextArea.setHeight("100%");
		this.setCanvas(c);

		// codeEditorTextArea.addChangeHandler(new ChangeHandler() //одна фигня что и ValueChangeHandler- работает при выходе из редактора
		codeEditorTextArea.addValueChangeHandler(new ValueChangeHandler<String>() {

			@Override
			public void onValueChange(ValueChangeEvent<String> event) {
				value = event.getValue();
				Utils.debug("2. ValueChangeHandler.onValueChange. FieldName:" + getFieldName() + "\n" + value);
				CodeEditorItem.this.storeValue(value);
			}
		});

		this.addShowValueHandler(new ShowValueHandler() {

			@Override
			public void onShowValue(ShowValueEvent event) {
				// TODO Auto-generated method stub
				String value = (null == event.getDataValue()) ? null : (String) event.getDataValue();
				CodeEditorItem.this.value = value;
				Utils.debug("4. CodeEditorItem.onShowValue.\n" + value);
				if (null == codeEditorTextArea.getCodeMirror())
					return;
				codeEditorTextArea.setValue(value, false);
			}
		});

	}

//	@Override
//	public void setValue(String value) {
//		this.value = value;
//		codeEditorTextArea.setValue(value, false);
//		Utils.debugAltert("3. CodeEditorItem.setValue.\n" + value);
//	}
}
