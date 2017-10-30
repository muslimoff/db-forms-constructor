package com.abssoft.constructor.common;

import java.util.ArrayList;

import com.google.gwt.user.client.rpc.IsSerializable;

public class ExportData implements IsSerializable {

	private static final String csvColSeparator = ";";
	private static final String csvRowSeparator = "\n";

	public static String replReservedSymbs(String txt) {
		String result = null == txt ? "" : txt;
		result = result.replaceAll("&", "&amp;");
		result = result.replaceAll("\"", "&quot;");
		result = result.replaceAll("<", "&lt;");
		result = result.replaceAll(">", "&gt;");
		// result = result.replaceAll("^", "&circ;");
		// result = result.replaceAll("~", "&tilde;");
		// result = result.replaceAll("\\$", "\\\\\\$");
		result = result.replaceAll("\\$", "");
		return result;
	}

	private ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
	private ArrayList<String> headerDisplFldNames = new ArrayList<String>();
	private ArrayList<String> headerNames = new ArrayList<String>();
	private ArrayList<String> headerTitles = new ArrayList<String>();
	private ArrayList<String> headerTypes = new ArrayList<String>();

	private ArrayList<String> paramNames = new ArrayList<String>();
	private ArrayList<String> paramVals = new ArrayList<String>();

	public ArrayList<String> getParamNames() {
		return paramNames;
	}

	public void setParamNames(ArrayList<String> paramNames) {
		this.paramNames = paramNames;
	}

	public ArrayList<String> getParamVals() {
		return paramVals;
	}

	public void setParamVals(ArrayList<String> paramVals) {
		this.paramVals = paramVals;
	}

	private String title = "";

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public ExportData() {
		// paramNames.add("x");
		// paramNames.add("y");
		// paramVals.add("xxxxx");
		// paramVals.add("yyyyy");
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
		final String hdrTmpl = "<HEADER num=\"&cellNum&\" type=\"&dtype&\">&hdrData&</HEADER>";
		final String prmTmpl = "<PARAM num=\"&cellNum&\" name=\"&paramName&\">&paramData&</PARAM>";
		final String mainTmpl = "<?xml version=\"1.0\"?>" + "<MAIN>" + cr + "<TITLES><TITLE>&title&</TITLE></TITLES>" + cr + "<HEADERS>"
				+ cr + "&headersData&" + "</HEADERS>" + cr + "<PARAMS>" + cr + "&paramsData&" + "</PARAMS>" //
				+ cr + "<TABLE>" + cr + "&rowsData&" + "</TABLE>" + cr + "</MAIN>";

		// Формирование заголовков
		String hdrsTxt = "";
		// String dtypesTxt = "";
		for (int i = 0; i < headerNames.size(); i++) {
			String val2 = headerTitles.get(i);
			val2=val2.replaceAll("<b>","");
			if (i == 0) {
				hdrsTxt = hdrsTxt
						+ hdrTmpl.replaceAll("&cellNum&", i + "").replaceAll("&hdrData&", val2).replaceAll("&dtype&",
						"String") + cr;
			}
			else {
				hdrsTxt = hdrsTxt
						+ hdrTmpl.replaceAll("&cellNum&", i + "").replaceAll("&hdrData&", val2).replaceAll("&dtype&",
						headerTypes.get(i)) + cr;
		}
		// Формирование параметров
		String paramsTxt = "";
		for (int i = 0; i < paramNames.size(); i++) {
			String val = replReservedSymbs(paramVals.get(i));
			paramsTxt = paramsTxt
					+ prmTmpl.replaceAll("&cellNum&", i + "").replaceAll("&paramName&", paramNames.get(i)).replaceAll("&paramData&", val)
					+ cr;
		}
		// Формирование основных данных
		String result = "";
		for (int r = 0; r < data.size(); r++) {
			String rowTxt = "";
			System.out.println(r + " >>>>> " + data.get(r) + "<<<<");
			for (int c = 0; c < data.get(r).size(); c++) {
				String val = replReservedSymbs(data.get(r).get(c));
				String txt = cellTmpl.replaceAll("&cellNum&", c + "");
				try {
					txt = txt.replaceAll("&cellData&", val);
				} catch (Exception e) {
					// e.printStackTrace();
					System.out.println(e.getMessage() + ". col#: " + c + "; val: " + val);
					txt = txt.replaceAll("&cellData&", e.getMessage());
				}
				rowTxt = rowTxt + txt + cr;
			}
			// rowTxt = replReservedSymbs(rowTxt);
			result = result + rowTmpl.replaceAll("&cellsData&", rowTxt).replaceAll("&rowNum&", r + "") + cr;
		}
		// result = replReservedSymbs(result);
		result = mainTmpl.replaceAll("&rowsData&", result).replaceAll("&headersData&", hdrsTxt);
		result = result.replaceAll("&paramsData&", paramsTxt).replaceAll("&title&", title);
		// System.out.println("======================================");
		// System.out.println(result);
		// System.out.println("======================================");
		return result;
	}

	public void setHeaderTypes(ArrayList<String> headerTypes) {
		this.headerTypes = headerTypes;
	}

	public ArrayList<String> getHeaderTypes() {
		return headerTypes;
	}
}
