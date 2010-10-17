package com.abssoft.constructor.server;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import oracle.apps.xdo.template.FOProcessor;
import oracle.apps.xdo.template.RTFProcessor;
import oracle.i18n.net.MimeUtility;
import oracle.jdbc.OracleConnection;
import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;

public class XMLPublisherServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static void clobToOutputSteam(CLOB clob, PrintWriter out) throws SQLException, IOException {
		Reader clobInputStream = clob.getCharacterStream();
		int bytesRead = 0;
		int chunkSize = clob.getChunkSize();
		char[] binaryBuffer = new char[chunkSize];
		while ((bytesRead = clobInputStream.read(binaryBuffer)) != -1) {
			System.out.println("clobToOutputSteam: " + new String(binaryBuffer));
			out.write(binaryBuffer, 0, bytesRead);
		}
		clobInputStream.close();

	}

	public static String findExportData(Session session, Integer exportDataID) {
		String result;

		HashMap<String, Form> forms = session.getFormDataHashMap();
		Iterator<String> formsIt = forms.keySet().iterator();
		while (formsIt.hasNext()) {
			String frmKey = formsIt.next();
			Form frm = forms.get(frmKey);
			HashMap<Integer, FormInstance> formInsts = frm.getFormInstance();
			Iterator<Integer> formsInstIt = formInsts.keySet().iterator();
			while (formsInstIt.hasNext()) {
				Integer instIdx = formsInstIt.next();
				FormInstance frmInst = formInsts.get(instIdx);
				if (frmInst.getExportDatHM().containsKey(exportDataID)) {
					result = frmInst.getExportDatHM().get(exportDataID).getXML();
					frmInst.getExportDatHM().remove(exportDataID);
					return result;
				}
			}
		}
		return null;
	}

	public static CLOB findCLOB(Session session, Integer dataClobId) {
		CLOB result;

		HashMap<String, Form> forms = session.getFormDataHashMap();
		Iterator<String> formsIt = forms.keySet().iterator();
		while (formsIt.hasNext()) {
			String frmKey = formsIt.next();
			Form frm = forms.get(frmKey);
			HashMap<Integer, FormInstance> formInsts = frm.getFormInstance();
			Iterator<Integer> formsInstIt = formInsts.keySet().iterator();
			while (formsInstIt.hasNext()) {
				Integer instIdx = formsInstIt.next();
				FormInstance frmInst = formInsts.get(instIdx);
				System.out.println("key:" + frmKey + "; frm:" + frm + "; instIdx:" + instIdx);
				if (frmInst.getClobHM().containsKey(dataClobId)) {
					result = frmInst.getClobHM().get(dataClobId);
					System.out.println("CLOB:" + result);
					return result;
				}
			}
		}
		return null;
	}

	public static CLOB findCLOB(Session session, String reportCode) throws SQLException {
		OracleConnection connection = session.getConnection();
		String sqlText = Utils.getSQLQueryFromXML("reportTemplatesSQL", session.getServerInfoMD());
		OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(sqlText);
		Utils.setParameterValue(statement, "p_report_code", reportCode);
		ResultSet rs = statement.executeQuery();
		rs.next();
		CLOB result = (CLOB) rs.getClob(1);
		rs.close();
		statement.close();
		return result;
	}

	private static String getEncodedFileName(HttpServletRequest req, String reportName) throws UnsupportedEncodingException {
		// http://www.rsdn.ru/forum/java/2890460.flat.aspx
		String agent = req.getHeader("USER-AGENT").toLowerCase();
		String fileName = reportName;
		if (agent.indexOf("firefox") > -1) {
			fileName = URLDecoder.decode(reportName, "utf-8");
		} else if (agent.indexOf("chrome") > -1) {
			fileName = URLDecoder.decode(reportName, "windows-1251");
		}
		String contentDisposition = "filename=\"" + MimeUtility.encodeText(fileName, "UTF8", "B") + "\"";
		return contentDisposition;
	}

	public static void main(String[] args) throws UnsupportedEncodingException {
		String ffStr = "%D1%84%D1%8B%D0%B2%D0%B0%D0%BF%D1%80%D0%BE%D0%BB%D0%B4%D0%B6";
		String chromeStr = "%F4%FB%E2%E0%EF%F0%EE%EB%E4%E6";
		System.out.println(URLDecoder.decode(ffStr, "utf-8"));
		System.out.println(URLDecoder.decode(chromeStr, "windows-1251"));
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doMethod(req, resp);
	}

	private void doMethod(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		/******************* RequestData *******************/
		Integer sessionID = (Integer) req.getSession(true).getAttribute(Utils.sessionIdentifier);
		Session session = QueryServiceImpl.getSessionData(sessionID);
		System.out.println("SessionID:" + sessionID + "; session:" + session);
		System.out.println("req.getQueryString():" + req.getQueryString());
		// System.out.println("ss: " + req.getQueryString());
		// Reader r = req.getReader();
		if (null == session) {
			processEmptySessionResponse(req, resp);
		} else {
			/*
			 * contentDisposition: inline/attachment; type: file/xmlp/clob/blob; ContentType: null - defaultContentType
			 */
			String type = "file";
			String contentDisposition = "inline"; // attachment
			String ContentType = null;
			Integer docId = -1;
			String template = null;
			String filename = "файл";
			// String exportData = null;

			System.out.println("getParameterMap>> " + req.getParameterMap() + "; filename:"
					+ ((String[]) req.getParameterMap().get("filename"))[0]);
			//

			String[] pvs = req.getParameterValues("filename");
			System.out.println("aaa: " + pvs);
			for (int i = 0; i < pvs.length; i++) {
				System.out.println("x:" + i + ": " + pvs[i] + "; " + new String(pvs[i].getBytes()));

				System.out.println();
			}

			byte[] xx = req.getParameter("filename").getBytes();
			for (int i = 0; i < xx.length; i++) {
				System.out.println("y:" + i + ": " + xx[i]);
			}

			// byte[] yy = (byte[]) req.getParameterMap().get("filename");
			// for (int i = 0; i < yy.length; i++) {
			// System.out.println("z:" + i + ": " + yy[i]);
			// }
			System.out.println();
			//

			Enumeration<?> e = req.getParameterNames();

			while (e.hasMoreElements()) {
				String paramName = (String) e.nextElement();
				String paramValue = req.getParameter(paramName);
				// System.out.println("XMLPublisherServlet.doGet. ParameterNames: " + paramName + "=" + paramValue + "; "
				// + URLDecoder.decode(paramValue, "UTF8"));
				// System.out.println("param_decode: " + new String(paramValue.getBytes("utf-8"), "utf-16"));
				// System.out.println("xxa:" + paramValue.getBytes("utf-8"));
				if ("contentDisposition".equals(paramName) && !"".equals(paramValue)) {
					contentDisposition = paramValue;
				}
				if ("type".equals(paramName) && !"".equals(paramValue)) {
					type = paramValue;
				}
				if ("ContentType".equals(paramName) && !"".equals(paramValue)) {
					ContentType = paramValue;
				}
				if ("dataClobId".equals(paramName) && !"".equals(paramValue)) {
					try {
						docId = Integer.valueOf(paramValue);
						System.out.println("dataClobId:" + docId);
					} catch (Exception ee) {
					}
				}
				if ("template".equals(paramName) && !"".equals(paramValue)) {
					template = paramValue;
				}
				// filename
				if ("filename".equals(paramName) && !"".equals(paramValue)) {
					filename = paramValue;
				}

			}
			if ("file".equals(type)) {
				getFile(req, resp, session, contentDisposition, ContentType);
				return;
			}
			if ("xmlp".equals(type)) {
				processXMLP(req, resp, session, contentDisposition, ContentType, template, docId, filename);
				return;
			}
			if ("clob".equals(type)) {
				getCLOB(req, resp, session, contentDisposition, ContentType, docId);
				return;
			}
			if ("xslt".equals(type)) {
				processXSLT(req, resp, session, contentDisposition, ContentType, template, docId, filename);
				return;
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doMethod(req, resp);
	}

	public void processXSLT(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition,
			String ContentType, String template, Integer docId, String filename) throws IOException {
		resp.setCharacterEncoding("utf-8");
		String outFilename = (null != filename) ? filename : "noname.xml";
		String ct = (null != ContentType) ? ContentType : "text/plain";
		resp.setContentType(ct);
		resp.setHeader("Content-Disposition", contentDisposition + "; filename=\"" + outFilename + "\"");
		PrintWriter out = resp.getWriter();
		String exportData = "";
		try {

			exportData = findExportData(session, docId);
			// out.print(exportData);

			CLOB rtfTemplClob = findCLOB(session, template);
			// clobToOutputSteam(rtfTemplClob, out);
			ByteArrayInputStream xmlDataIS = new ByteArrayInputStream(exportData.getBytes("UTF-8"));

			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(new StreamSource(rtfTemplClob.getCharacterStream()));
			transformer.transform(new StreamSource(xmlDataIS), new StreamResult(out));
		} catch (Exception e) {

			resp.setContentType("text/plain");
			e.printStackTrace(out);
			out.write("\n =================DATA==================\n");
			out.write(exportData);
			e.printStackTrace();
		}
		out.flush();
		out.close();

	}

	// http://127.0.0.1:8888/constructorapp/xmlp?contentDisposition=inline&type=clob&ContentType=application/msword
	public void getCLOB(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition, String ContentType,
			Integer docId) throws IOException {
		resp.setCharacterEncoding("utf-8");
		String outFilename = "example-data.xml";
		String ct = (null != ContentType) ? ContentType : "text/plain";
		resp.setContentType(ct);
		resp.setHeader("Content-Disposition", contentDisposition + "; filename=\"" + outFilename + "\"");
		PrintWriter out = resp.getWriter();
		String exportData = findExportData(session, docId);
		if (null != exportData) {
			out.print(exportData);
		} else {
			try {

				CLOB clob = findCLOB(session, docId);
				clobToOutputSteam(clob, out);

			} catch (SQLException e) {
				PrintWriter errout = resp.getWriter();
				resp.setContentType("text/plain");
				e.printStackTrace(errout);
				e.printStackTrace();
			}
		}
		out.flush();
		out.close();
	}

	public void getFile(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition, String ContentType)
			throws IOException {
		String outFilename = "example-data.xml";
		// TODO Get real File Content Type
		String ct = (null != ContentType) ? ContentType : "text/plain";
		resp.setContentType(ct);
		resp.setHeader("Content-Disposition", contentDisposition + "; filename=\"" + outFilename + "\"");

		OutputStream out = resp.getOutputStream();
		String filename = getServletContext().getRealPath("/WEB-INF") + "/" + "constructorapp.xml";
		BufferedInputStream is = new BufferedInputStream(new FileInputStream(filename));

		byte[] buffer = new byte[8192];
		int count = 0;
		while ((count = is.read(buffer)) > 0) {
			out.write(buffer, 0, count);
		}
		out.flush();
		out.close();
	}

	@Override
	public void init() throws ServletException {
		super.init();
		Utils.debug("Middle tier service '" + this.getClass() + "' started...");
	}

	public void processEmptySessionResponse(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		resp.setContentType("text/plain");
		PrintWriter out = resp.getWriter();
		out.println("Not connected! Connect to Application first...");
		out.println("req.getLocalAddr():" + req.getLocalAddr());
		out.println("req.getLocalName():" + req.getLocalName());
		out.println("req.getLocalPort():" + req.getLocalPort());
		out.println("req.getRemoteAddr():" + req.getRemoteAddr());
		out.println("req.getRequestURI():" + req.getRequestURI());
		out.println("req.getQueryString():" + req.getQueryString());
		out.flush();
		out.close();
	}

	// http://ostermiller.org/convert_java_outputstream_inputstream.html
	// http://www.jdom.org/docs/faq.html
	public void processXMLP(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition,
			String ContentType, String template, Integer docId, String filename) throws IOException {
		System.out.println("XMLPublisherServlet.processXMLP");
		ServletOutputStream respOS = resp.getOutputStream();
		byte format = FOProcessor.FORMAT_RTF;
		String extention = "rtf";
		if ("application/vnd.ms-excel".equals(ContentType)) {
			format = FOProcessor.FORMAT_EXCEL;
			extention = "xls";
		}
		try {
			ByteArrayOutputStream rtfOS = new ByteArrayOutputStream();
			CLOB rtfTemplClob = findCLOB(session, template);
			CLOB xmlDataClob = findCLOB(session, docId);
			/** RTF to XSL FO **/
			RTFProcessor rtfProcessor = new RTFProcessor(rtfTemplClob.binaryStreamValue());
			rtfProcessor.setOutput(rtfOS);
			rtfProcessor.process();
			FOProcessor processor = new FOProcessor();
			/** RTF OutputStream to FO inputStream **/
			ByteArrayInputStream foIS = new ByteArrayInputStream(rtfOS.toByteArray());
			/** XFL FO and data XML to output **/
			processor.setTemplate(foIS);
			processor.setData(xmlDataClob.characterStreamValue());

			resp.setContentType(ContentType);
			resp.addHeader("Content-Disposition", contentDisposition + "; " + getEncodedFileName(req, filename + "." + extention));

			processor.setOutputFormat(format);
			processor.setOutput(respOS);
			processor.generate();
			foIS.close();
			System.out.println("xx" + resp.getLocale() + "; zz:" + resp.getContentType() + "; " + resp.getCharacterEncoding()
					+ resp.toString());

		} catch (Exception e) {
			// resp.setContentType("text/plain");
			// Writer writer = new StringWriter();
			// PrintWriter printWriter = new PrintWriter(writer);
			// e.printStackTrace(printWriter);
			// respOS.println(writer.toString());
			respOS.println(Utils.getExceptionStackIntoString(e));
		}
		respOS.flush();
		respOS.close();
	}
}
