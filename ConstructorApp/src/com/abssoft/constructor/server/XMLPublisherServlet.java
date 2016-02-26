package com.abssoft.constructor.server;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.commons.io.input.ReaderInputStream;

import oracle.jdbc.OraclePreparedStatement;
import oracle.sql.CLOB;
import oracle.xdo.common.log.Logger;
import oracle.xdo.template.ExcelProcessor;
import oracle.xdo.template.FOProcessor;
import oracle.xdo.template.RTFProcessor;

public class XMLPublisherServlet extends HttpServlet // implements javax.servlet.SingleThreadModel
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String webInfRoot;

	public static void clobToOutputSteam(CLOB clob, PrintWriter out) throws SQLException, IOException {
		Reader clobInputStream = clob.getCharacterStream();
		int bytesRead = 0;
		int chunkSize = clob.getChunkSize();
		char[] binaryBuffer = new char[chunkSize];
		while ((bytesRead = clobInputStream.read(binaryBuffer)) != -1) {
			//Utils.spoolOut("clobToOutputSteam: " + new String(binaryBuffer));
			out.write(binaryBuffer, 0, bytesRead);
		}
		clobInputStream.close();

	}

	public static String findExportData(Session session, Integer exportDataID) {
		String result;

		Map<String, Form> forms = session.getFormDataMap();
		Iterator<String> formsIt = forms.keySet().iterator();
		while (formsIt.hasNext()) {
			String frmKey = formsIt.next();
			Form frm = forms.get(frmKey);
			Map<Integer, FormInstance> formInsts = frm.getFormInstance();
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

		Map<String, Form> forms = session.getFormDataMap();
		Iterator<String> formsIt = forms.keySet().iterator();
		while (formsIt.hasNext()) {
			String frmKey = formsIt.next();
			Form frm = forms.get(frmKey);
			Map<Integer, FormInstance> formInsts = frm.getFormInstance();
			Iterator<Integer> formsInstIt = formInsts.keySet().iterator();
			while (formsInstIt.hasNext()) {
				Integer instIdx = formsInstIt.next();
				FormInstance frmInst = formInsts.get(instIdx);
				if (frmInst.getClobHM().containsKey(dataClobId)) {
					result = frmInst.getClobHM().get(dataClobId);
					return result;
				}
			}
		}
		return null;
	}

	public static CLOB findCLOB(Session session, String reportCode) throws SQLException {
		Connection connection = session.getConnection();
		String sqlText = Utils.getSQLQueryFromXML("reportTemplatesSQL", session);
		OraclePreparedStatement statement = (OraclePreparedStatement) connection.prepareStatement(sqlText);
		Utils.setParameterValue(session, statement, "p_report_code", reportCode);
		ResultSet rs = statement.executeQuery();
		rs.next();
		CLOB result = (CLOB) rs.getClob(1);
		rs.close();
		statement.close();
		return result;
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doMethod(req, resp);
	}

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doMethod(req, resp);
	}

	public void setResponseHeader(HttpServletResponse resp, String contentDisposition, String ContentType, String filename)
			throws IOException {
		//http://blogs.msdn.com/b/ieinternals/archive/2010/06/07/content-disposition-attachment-and-international-unicode-characters.aspx
		resp.setCharacterEncoding("utf-8");
		String outFilename = (null != filename) ? filename : "noname.xml";
		//http://stackoverflow.com/questions/18050718/utf-8-encoding-name-in-downloaded-file
		outFilename = URLEncoder.encode(outFilename, "UTF-8");
		String ct = (null != ContentType) ? ContentType : "text/plain";
		resp.setContentType(ct);
		resp.setHeader("Content-Disposition", contentDisposition + "; filename*=UTF-8''" + outFilename + "");
	}

	private void doMethod(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setCharacterEncoding("utf-8");
		cntr++;
		// TODO вылетает сессия XMLPublisherServlet при долгом таймауте session.setMaxInactiveInterval(interval);
		HttpSession httpSession = req.getSession(true);

		httpSession.setMaxInactiveInterval(-1); // (2 * 60 * 60); // A negative time indicates the session should never timeout.
		Utils.spoolOut("httpSession:" + httpSession);
		Utils.spoolOut("httpSession.getCreationTime:" + httpSession.getCreationTime());
		Utils.spoolOut("httpSession.getId:" + httpSession.getId());
		Utils.spoolOut("httpSession.getLastAccessedTime:" + httpSession.getLastAccessedTime());
		Utils.spoolOut("httpSession.getMaxInactiveInterval:" + httpSession.getMaxInactiveInterval());

		/******************* RequestData *******************/
		Integer sessionID = (Integer) httpSession.getAttribute(Utils.sessionIdentifier);
		Session session = QueryServiceImpl.getSessionData(sessionID);
		Utils.spoolOut("SessionID:" + sessionID + "; session:" + session);
		Utils.spoolOut("req.getQueryString():" + req.getQueryString());
		if (null == session) {
			processEmptySessionResponse(req, resp);
		} else {
			/*
			 * contentDisposition: inline/attachment; type: file/xmlp/clob/blob;
			 * ContentType: null - defaultContentType
			 */
			String type = "file";
			String contentDisposition = "inline"; // attachment
			String ContentType = null;
			Integer docId = -1;
			String template = null;
			String filename = "файл";

			System.out.println(
					"getParameterMap>> " + req.getParameterMap() + "; filename:" + ((String[]) req.getParameterMap().get("filename"))[0]);

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

			System.out.println();

			Enumeration<?> e = req.getParameterNames();

			while (e.hasMoreElements()) {
				String paramName = (String) e.nextElement();
				String paramValue = req.getParameter(paramName);
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
				if ("filename".equals(paramName) && !"".equals(paramValue)) {
					filename = paramValue;
				}

			}
			if ("file".equals(type)) {
				filename = webInfRoot + "/" + "constructorapp.xml";
				setResponseHeader(resp, contentDisposition, ContentType, filename);
				getFile(req, resp, session, contentDisposition, ContentType, filename);
				return;
			} else if ("clob".equals(type)) {
				setResponseHeader(resp, contentDisposition, ContentType, filename);
				getCLOB(req, resp, session, contentDisposition, ContentType, docId //, filename
				);
			} else if ("xslt".equals(type)) {
				setResponseHeader(resp, contentDisposition, ContentType, filename);
				processXSLT(req, resp, session, contentDisposition, ContentType, template, docId //, filename
				);
			} else if ("xmlp".equals(type)) {
				String extention = "rtf";
				if ("application/vnd.ms-excel".equals(ContentType)) {
					extention = "xls";
				} else if ("application/pdf".equals(ContentType)) {
					extention = "pdf";
				} else if ("text/html".equals(ContentType)) {
					extention = "html";
				}

				setResponseHeader(resp, contentDisposition, ContentType, filename + "." + extention);
				processXMLP(req, resp, session, contentDisposition, ContentType, template, docId //, filename
				);
			} else if ("xlsxmlp".equals(type)) {
				setResponseHeader(resp, "attachment", "application/vnd.ms-excel", filename);
				processXlsXMLP(req, resp, session, template, docId);
			}
			session.debug("Exiting... " + cntr + "; " + this);
			// httpSession.invalidate();
		}
	}

	public void processXSLT(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition,
			String ContentType, String template, Integer docId //, String filename
	) throws IOException {
		PrintWriter out = resp.getWriter();
		String exportData = "";
		try {

			exportData = findExportData(session, docId);
			CLOB rtfTemplClob = findCLOB(session, template);
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
			Integer docId //, String filename
	) throws IOException {
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

	//Заготовка для выгрузки файлов с сервера приложений
	public void getFile(HttpServletRequest req, HttpServletResponse resp, Session session, String contentDisposition, String ContentType,
			String filename) throws IOException {
		OutputStream out = resp.getOutputStream();
		BufferedInputStream is = new BufferedInputStream(new FileInputStream(filename));

		byte[] buffer = new byte[8192];
		int count = 0;
		while ((count = is.read(buffer)) > 0) {
			out.write(buffer, 0, count);
		}
		is.close();
		out.flush();
		out.close();
	}

	private int cntr = 0; // счетчик обращений

	@Override
	public void init() throws ServletException {
		super.init();
		webInfRoot = getServletContext().getRealPath("/WEB-INF");
		Utils.spoolOut("Middle tier service '" + this.getClass() + "' started...");
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
			String ContentType, String template, Integer docId //, String filename
	) throws IOException {
		Utils.spoolOut("XMLPublisherServlet.processXMLP");
		Logger.setLevel(Logger.OFF);
		byte format = FOProcessor.FORMAT_RTF;
		if ("application/vnd.ms-excel".equals(ContentType)) {
			format = FOProcessor.FORMAT_EXCEL;
		} else if ("application/pdf".equals(ContentType)) {
			format = FOProcessor.FORMAT_PDF;
		} else if ("text/html".equals(ContentType)) {
			format = FOProcessor.FORMAT_HTML;
		}
		ServletOutputStream respOS = resp.getOutputStream();
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
			processor.setOutputFormat(format);
			processor.setOutput(respOS);
			processor.setConfig(webInfRoot + "/xdo.cfg");
			processor.generate();
			foIS.close();
			Utils.spoolOut(
					"xx" + resp.getLocale() + "; zz:" + resp.getContentType() + "; " + resp.getCharacterEncoding() + resp.toString());

		} catch (Exception e) {
			respOS.println(Utils.getExceptionStackIntoString(e));
		}
		respOS.flush();
		respOS.close();
	}

	public void processXlsXMLP(HttpServletRequest req, HttpServletResponse resp, Session session, String template, Integer docId)
			throws IOException {
		Utils.spoolOut("XMLPublisherServlet.processXlsXMLP");
		Logger.setLevel(Logger.STATEMENT);
		ServletOutputStream respOS = resp.getOutputStream();
		try {
			CLOB xmlDataClob = findCLOB(session, docId);
			String templatePath = webInfRoot + "/tempxmpldata/mosology_template.xls";
			File tmpDir = null;
			File xsl = File.createTempFile("xdo", ".xsl", tmpDir);
			xsl.deleteOnExit();
			FileInputStream fi = new FileInputStream(templatePath);
			ExcelProcessor excelProc = new ExcelProcessor();
			excelProc.setConfig(webInfRoot + "/xdo.cfg");
			excelProc.setTemplate(fi);
			//excelProc.setData(IOUtils.toInputStream(IOUtils.toString(xmlDataClob.getCharacterStream())));
			excelProc.setData(new ReaderInputStream(xmlDataClob.getCharacterStream()));
			excelProc.setOutput(respOS);
			excelProc.process();
			Utils.spoolOut(
					"xx" + resp.getLocale() + "; zz:" + resp.getContentType() + "; " + resp.getCharacterEncoding() + resp.toString());

		} catch (Exception e) {
			respOS.println(Utils.getExceptionStackIntoString(e));
		}
		respOS.flush();
		respOS.close();
	}
}
