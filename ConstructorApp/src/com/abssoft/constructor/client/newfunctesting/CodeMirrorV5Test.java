package com.abssoft.constructor.client.newfunctesting;

import com.abssoft.constructor.client.data.Utils;
import com.abssoft.constructor.client.widgets.cmirrorwidget.CodeMirrorV5;
import com.google.gwt.dom.client.Element;
import com.smartgwt.client.types.TitleOrientation;
import com.smartgwt.client.util.JSOHelper;
import com.smartgwt.client.widgets.form.DynamicForm;
import com.smartgwt.client.widgets.form.fields.FormItem;
import com.smartgwt.client.widgets.form.fields.events.FormItemInitHandler;
import com.smartgwt.client.widgets.tab.Tab;

final class CodeMirrorV5Test extends Tab {

	CodeMirrorV5 tai = new CodeMirrorV5();
	DynamicForm f = new DynamicForm();

	public CodeMirrorV5Test() {
		super();
		tai.setName("CodeMirrorV5Test");
		tai.setValue("begin\nnull;\nend;");
		tai.setWidth("*");
		tai.setHeight("*");
		f.setTitleOrientation(TitleOrientation.TOP);
		//		tai.setInitHandler(new FormItemInitHandler() {
		//
		//			@Override
		//			public void onInit(FormItem item) {
		////				Utils.debug("1CodeMirrorV5Test. " + tai.getJsObj().toString());
		////				Utils.debug("2CodeMirrorV5Test. " + tai.getJsObj().toSource());
		////				//Utils.debug("CodeMirrorV5Test. " + tai + ";" + tai.getAttributeAsString(SC.REF));
		////				//RefDataClass existingObj = RefDataClass.getRef(tai.getJsObj());
		////				//JSOHelper.deleteAttribute(jsObj, com.smartgwt.client.util.SC.REF);
		////				Element[] ee = JSOHelper.toElementArray(tai.getJsObj());
		////				Utils.debug("3CodeMirrorV5Test. " + ee);
		////				Element e = JSOHelper.getElementValueFromJavaScriptObjectArray(tai.getJsObj(), 1);
		////				Utils.debug("4CodeMirrorV5Test. " + e.getId());
		////				Utils.debug("5CodeMirrorV5Test. " + e.toString());
		////				Utils.debug("6CodeMirrorV5Test. " + e.toSource());
		//
		//			}
		//		});

		f.setNumCols(1);
		f.setItems(tai);
		setPane(f);
	}
}