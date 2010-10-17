package com.abssoft.constructor.client.metadata;

import java.util.ArrayList;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ExportData implements IsSerializable {

	private static final String csvColSeparator = ";";
	private static final String csvRowSeparator = "\n";

	public static String replReservedSymbs(String txt) {
		String result = txt;
		result = result.replaceAll("&", "&amp;");
		return result;
	}

	private ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
	private ArrayList<String> headerDisplFldNames = new ArrayList<String>();
	private ArrayList<String> headerNames = new ArrayList<String>();
	private ArrayList<String> headerTitles = new ArrayList<String>();
	private String title = "";

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ExportData() {
	}

	public String getCSV() {
		String result = "";
		for (int i = 0; i < headerNames.size(); i++) {
			result = result + headerTitles.get(i) + csvColSeparator;
		}
		result = result + csvRowSeparator;
		for (int r = 0; r < data.size(); r++) {
			for (int c = 0; c < data.get(r).size(); c++) {
				result = result + data.get(r).get(c) + csvColSeparator;
			}
			result = result + csvRowSeparator;
		}
		return result;
	}

	public ArrayList<ArrayList<String>> getData() {
		return data;
	}

	public ArrayList<String> getHeaderDisplFldNames() {
		return headerDisplFldNames;
	}

	public ArrayList<String> getHeaderNames() {
		return headerNames;
	}

	public ArrayList<String> getHeaderTitles() {
		return headerTitles;
	}

	// Что-то влом генерить правильно
	public String getXML() {
		// Константы - структура XML
		final String cr = ""; // "\n";
		final String cellTmpl = "<CELL num=\"&cellNum&\">&cellData&</CELL>";
		final String rowTmpl = "<ROW num=\"&rowNum&\">" + cr + "&cellsData&" + "</ROW>";
		final String hdrTmpl = "<HEADER num=\"&cellNum&\">&hdrData&</HEADER>";
		final String dtypeTmpl = "<FIELD num=\"&cellNum&\">&dtype&</FIELD>";
		final String mainTmpl = "<?xml version=\"1.0\"?>" + "<MAIN>" + cr + "<TITLES><TITLE>&title&</TITLE></TITLES>" + cr + "<HEADERS>"
				+ cr + "&headersData&" + "</HEADERS>" + cr + "<FIELD_TYPES>" + cr + "&fieldTypesData&" + "</FIELD_TYPES>" + cr + "<TABLE>"
				+ cr + "&rowsData&" + "</TABLE>" + cr + "</MAIN>";

		// Формирование заголовков
		String hdrsTxt = "";
		String dtypesTxt = "";
		for (int i = 0; i < headerNames.size(); i++) {
			hdrsTxt = hdrsTxt + hdrTmpl.replaceAll("&cellNum&", i + "").replaceAll("&hdrData&", headerTitles.get(i)) + cr;
			dtypesTxt = dtypesTxt + dtypeTmpl.replaceAll("&cellNum&", i + "").replaceAll("&dtype&", "String") + cr;
		}
		// Формирование основных данных
		String result = "";
		for (int r = 0; r < data.size(); r++) {
			String rowTxt = "";
			for (int c = 0; c < data.get(r).size(); c++) {
				String val = replReservedSymbs(data.get(r).get(c));
				rowTxt = rowTxt + cellTmpl.replaceAll("&cellNum&", c + "").replaceAll("&cellData&", val) + cr;
			}
			result = result + rowTmpl.replaceAll("&cellsData&", rowTxt).replaceAll("&rowNum&", r + "") + cr;
		}
		result = mainTmpl.replaceAll("&rowsData&", result).replaceAll("&headersData&", hdrsTxt);
		result = result.replaceAll("&fieldTypesData&", dtypesTxt).replaceAll("&title&", title);
		// System.out.println(result);
		return result;
	}

}
