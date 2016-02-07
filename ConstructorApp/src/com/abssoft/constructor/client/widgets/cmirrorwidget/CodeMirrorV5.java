package com.abssoft.constructor.client.widgets.cmirrorwidget;

//import com.abssoft.constructor.client.newfunctesting.CodeMirrorItem.CanvasDragResizeStopHandler;
//import com.abssoft.constructor.client.newfunctesting.CodeMirrorItem.CanvasResizedHandler;
import com.abssoft.constructor.client.widgets.CodeEditorItem.CodeEditorTextArea;
import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.user.client.ui.Widget;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.events.FormItemInitHandler;

//import com.google.gwt.event.logical.shared.ValueChangeHandler;
//import com.google.gwt.user.client.ui.HasValue;
public class CodeMirrorV5 extends CanvasItem //implements HasInitializeHandlers //  HasChangeHandlers, , HasValue<String> 
{

	private class CodeMirrorEditor extends Widget //implements HasChangeHandlers, HasValue<String>, HasInitializeHandlers 
	{
		private JavaScriptObject editor;

		CodeMirrorEditor() {
			super();
		}

		public void onLoad() {
			super.onLoad();
			editor = initEditor(id);
		}

		private native JavaScriptObject initEditor(String id) /*-{

			var self = this;

			//init a new editor with standard properties
			editor = new $wnd.CodeMirror($doc.getElementById(id), {
				value : "function myScript(){return 100;}\n",
				mode : "javascript"
			});

			return editor;

		}-*/;
	}

	private Canvas c = new Canvas() {
		@Override
		protected void parentResized() {
			super.parentResized();
			//editorResize();
		}
	};

	public CodeMirrorV5() {
		//c.addResizedHandler(new CanvasResizedHandler());
		//c.addDragResizeStopHandler(new CanvasDragResizeStopHandler());
		c.setCanDragResize(true);
		c.setBorder("2px solid blue");
		//c.addChild(editor);
		c.getID();
		setCanvas(c);

		setInitHandler(new FormItemInitHandler() {

			@Override
			public void onInit(FormItem item) {
				//id = c.getID();
				CodeMirrorEditor cmi = new CodeMirrorEditor();
				c.addChild(cmi);

			}
		});

	}

	private native JavaScriptObject initCodeMirror(CodeEditorTextArea ceta, String id)
	/*-{
	var editor = $wnd.CodeMirror.fromTextArea($doc.getElementById(id), {
		lineNumbers: true,
		matchBrackets: true,
		indentUnit: 4,
		mode: "text/x-plsql",
		onChange: function xx(){
			//editor.save(); //editor.toTextArea(); $wnd.alert(editor.getValue());
			ceta.@com.abssoft.constructor.client.widgets.CodeEditorItem.CodeEditorTextArea::fireValueChangeEvent(Ljava/lang/String;)(editor.getValue());
	}
	});
	return editor;
	}-*/;

	//	@Override
	//	public HandlerRegistration addInitializeHandler(InitializeHandler handler) {
	//		// TODO Auto-generated method stub
	//		return null;
	//	}
	//
	//	@Override
	//	public String getValue() {
	//		// TODO Auto-generated method stub
	//		return null;
	//	}
	//
	//	@Override
	//	public HandlerRegistration addChangeHandler(ChangeHandler handler) {
	//		// TODO Auto-generated method stub
	//		return null;
	//	}
	//	@Override
	//	public HandlerRegistration addValueChangeHandler(ValueChangeHandler<String> handler) {
	//		// TODO Auto-generated method stub
	//		return null;
	//	}
	//
	//	@Override
	//	public void setValue(String value, boolean fireEvents) {
	//		// TODO Auto-generated method stub
	//
	//	}
}
