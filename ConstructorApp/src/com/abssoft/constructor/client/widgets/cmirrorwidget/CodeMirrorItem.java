package com.abssoft.constructor.client.widgets.cmirrorwidget;

import com.abssoft.constructor.client.data.Utils;
import com.google.gwt.event.logical.shared.InitializeEvent;
import com.google.gwt.event.logical.shared.InitializeHandler;
import com.google.gwt.event.logical.shared.ValueChangeEvent;
import com.google.gwt.event.logical.shared.ValueChangeHandler;
import com.smartgwt.client.widgets.Canvas;
import com.smartgwt.client.widgets.events.DragResizeStopEvent;
import com.smartgwt.client.widgets.events.DragResizeStopHandler;
import com.smartgwt.client.widgets.events.ResizedEvent;
import com.smartgwt.client.widgets.events.ResizedHandler;
import com.smartgwt.client.widgets.form.fields.CanvasItem;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.events.FormItemInitHandler;

public class CodeMirrorItem extends CanvasItem {
	/**
	 * 
	 */
	private CodeMirrorV511 editor;
	private Canvas c = new Canvas() {
		@Override
		protected void parentResized() {
			super.parentResized();
			editorResize();
		}
	};
	private CodeMirrorConfiguration config = new CodeMirrorConfiguration();
	private boolean isEditorInitialized = false;

	public CodeMirrorItem() {
		setInitHandler(new FormItemInitHandler() {

			@Override
			public void onInit(FormItem item) {
				// TODO Auto-generated method stub
				config.setLineNumbers(true);
				//				config.setContinuousScanning(0);
				//				config.setTextWrapping(false);
				//				config.setAutoMatchParens(false);
				//				config.setLineNumbers(false);
				editor = new CodeMirrorV511(config);
				editor.addInitializeHandler(new CodeMirrorInitializeHandler());
				c.addResizedHandler(new CanvasResizedHandler());
				c.setCanDragResize(true);
				//c.setBorder("2px solid blue");
				c.addChild(editor);
				c.addDragResizeStopHandler(new CanvasDragResizeStopHandler());
				CodeMirrorItem.this.setCanvas(c);
			}
		});

	}

	@Override
	public void setValue(String value) {
		//Если уже инициализирован - выполняем, иначе - только родительский вызов, а остальное в инициализации
		//super.setValue(value);
		super.storeValue(value);
		if (isEditorInitialized) {
			//editor.setContent(value);
			editor.setValue(value, false);
		}
	}

	public String getValue() {
		return editor.getContent();
	}

	public void editorResize() {
		String w = c.getVisibleWidth() + "";
		String h = c.getVisibleHeight() + "";
		Utils.debug(">" + this.getClass() + " > editorResize" + ". w:" + w + "; h:" + h);
		if (isEditorInitialized) {
			editor.setWidth(w);
			editor.setHeight(h);
		}
	}

	private final class CanvasDragResizeStopHandler implements DragResizeStopHandler {
		@Override
		public void onDragResizeStop(DragResizeStopEvent event) {
			Utils.debug(">>" + this.getClass());
			editorResize();
		}
	}

	private final class CanvasResizedHandler implements ResizedHandler {
		@Override
		public void onResized(ResizedEvent event) {
			Utils.debug(">>>>" + this.getClass() + "...");
			editorResize();
		}
	}

	private final class CodeMirrorInitializeHandler implements InitializeHandler {

		public void onInitialize(InitializeEvent event) {
			Utils.debug("CodeMirrorItem.onInitialize 1");
			if (!isEditorInitialized) {
				Utils.debug("CodeMirrorItem.onInitialize 2");
				//editor.setParser(CodeMirror.PARSER_SQL);
				//editor.setLineNumbers(true);
				//editor.setIndentUnit(2);
				//editor.setFocus();
				//editor.reindent();
				//String w = c.getVisibleWidth() + "";
				//String h = c.getVisibleHeight() + "";
				//editor.setWidth(w);
				//editor.setHeight(h);
				isEditorInitialized = true;
				Object initValueObj = CodeMirrorItem.super.getValue();
				String initValue = (null == initValueObj) ? null : (initValueObj + "");
				editor.setContent(initValue);
				editor.addValueChangeHandler(new CodeMirrorValueChangeHandler());
			}
		}

		private final class CodeMirrorValueChangeHandler implements ValueChangeHandler<String> {
			@Override
			public void onValueChange(final ValueChangeEvent<String> event) {
				final Object value = event.getValue();

				//				fireEvent(new com.smartgwt.client.widgets.form.fields.events.ChangedEvent(CodeMirrorItem.this.getJsObj()) {
				//					@Override
				//					public Object getValue() {
				//						return value;
				//					}
				//				});
				CodeMirrorItem.super.storeValue(value);
			}
		}
	}
}