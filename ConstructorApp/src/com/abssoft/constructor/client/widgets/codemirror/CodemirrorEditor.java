package com.abssoft.constructor.client.widgets.codemirror;

import java.util.ArrayList;
import java.util.List;

import com.google.gwt.core.client.JavaScriptObject;
import com.google.gwt.core.client.Scheduler;
import com.google.gwt.core.client.Scheduler.ScheduledCommand;
import com.google.gwt.dom.client.Element;
import com.google.gwt.event.dom.client.KeyDownEvent;
import com.google.gwt.event.dom.client.KeyDownHandler;
import com.google.gwt.user.client.ui.Composite;
import com.google.gwt.user.client.ui.SimplePanel;
import com.google.gwt.user.client.ui.TextArea;

public class CodemirrorEditor extends Composite {

	private final TextArea area = new TextArea();
	// private LayoutPanel widget = new LayoutPanel();

	private final List<SubmitListener> listeners = new ArrayList<SubmitListener>();

	private JavaScriptObject cm;

	public CodemirrorEditor() {
		// widget.add(area);
		SimplePanel widget = new SimplePanel(area);
		cm = initCodemirror(area.getElement());
		assert cm != null : "CodeMirror editor is null";

		initWidget(widget);
		addDomHandler(new KeyDownHandler() {
			@Override
			public void onKeyDown(KeyDownEvent event) {
				if (!enabled) {
					event.preventDefault();
					event.stopPropagation();
				}
			}
		}, KeyDownEvent.getType());
	}

	@Override
	protected void onLoad() {
		Scheduler.get().scheduleDeferred(new ScheduledCommand() {
			@Override
			public void execute() {
				refresh(cm);
			}
		});
		super.onLoad();
	}

	private native JavaScriptObject initCodemirror(Element textArea) /*-{
		var that = this;
		var cm = $wnd.CodeMirror
				.fromTextArea(
						textArea,
						{
							lineNumbers : true,
							lineWrapping : true,
							matchBrackets : true,
							indentWithTabs : true,
							tabSize : 4,
							indentUnit : 4,
							extraKeys : {
								"Ctrl-S" : function(cm) {
									that.@com.abssoft.constructor.client.widgets.codemirror.CodemirrorEditor::submit()();
								}
							}
						});

		cm.setSize("100%", "100%");
		return cm;
	}-*/;

	private native void refresh(JavaScriptObject cm) /*-{
		cm.refresh();
	}-*/;

	private native void focus(JavaScriptObject cm) /*-{
		cm.focus();
	}-*/;

	private native void setValue(JavaScriptObject cm, String value) /*-{
		cm.setValue(value);
	}-*/;

	private native String getValue(JavaScriptObject cm) /*-{
		return cm.getValue();
	}-*/;

	private native void setMode(JavaScriptObject cm, String mode) /*-{
		cm.setOption("mode", mode);
	}-*/;

	public void setValue(String value) {
		setValue(cm, value);
	}

	public String getValue() {
		return getValue(cm);
	}

	/**
	 * sets the mimetype by the mode
	 * 
	 * @param mode
	 */
	public void setMode(Mode mode) {
		setMimeType(mode.getMimeType());
	}

	/**
	 * if setMode doesn't work, or u need more controll, use this
	 * 
	 * @param mimeType
	 */
	public void setMimeType(String mimeType) {
		setMode(cm, mimeType);
	}

	private boolean enabled = true;

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public void focus() {
		focus(cm);
	}

	public void submit() {
		for (SubmitListener l : listeners)
			l.onSubmit();
	}

	public void addSubmitListener(SubmitListener listener) {
		listeners.add(listener);
	}
}
