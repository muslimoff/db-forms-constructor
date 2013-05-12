package com.abssoft.constructor.server;

import java.io.File;

import org.simpleframework.xml.Serializer;
import org.simpleframework.xml.core.Persister;
import org.simpleframework.xml.stream.CamelCaseStyle;
import org.simpleframework.xml.stream.Format;
import org.simpleframework.xml.stream.Style;

import com.abssoft.constructor.common.FormActionsArr;
import com.abssoft.constructor.common.metadata.FormActionMD;
import com.abssoft.constructor.common.metadata.FormMD;

public class AppLayerTestClass {
	public static void Serialize(String fileNamePart, Object o) {
		Style style = new CamelCaseStyle(); // new HyphenStyle();
		Format format = new Format(style);
		Serializer serializer = new Persister(format);
		File result = new File(QueryServiceImpl.getWebinfPath() + "/tmp/serialization/serialized." + fileNamePart + ".xml");
		try {
			serializer.write(o, result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {

		FormMD m = new FormMD();
		FormActionsArr a = new FormActionsArr();
		a.add(new FormActionMD());
		a.get(0).setHotKey("ssss");
		a.add(new FormActionMD());
		a.get(1).setHotKey("zzzz");
		m.setActions(a);
		Serializer serializer = new Persister();
		File result = new File("lure2.xml");
		try {
			serializer.write(m, result);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
