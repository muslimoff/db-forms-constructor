package com.abssoft.constructor.server;

import java.io.File;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

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
			e.printStackTrace();
		}
	}

	public static void SerializeJAXB(String fileNamePart, Form f) {
		try {
			JAXBContext jc = JAXBContext.newInstance(f.getClass());

			Marshaller marshaller = jc.createMarshaller();
			marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

			File result = new File(QueryServiceImpl.getWebinfPath() + "/tmp/serialization/FORM@serialized." + fileNamePart + ".xml");
			marshaller.marshal(f.getClass(), result);
			// marshaller.marshal(f.getClass(), System.out);
		} catch (JAXBException e) {
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

		AppLayerTestClass.Serialize("test1", m);

		// AppLayerTestClass.SerializeJAXB("test2", this);
	}
}
