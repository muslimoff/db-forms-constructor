package com.abssoft.constructor.server;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.apps.xdo.XDOException;
import oracle.apps.xdo.template.RTFProcessor;

public class XMLPublisherServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 
		/******************* RequestData *******************/
		Integer sessionID = (Integer) req.getSession(true).getAttribute(Utils.sessionIdentifier);
		Session s = QueryServiceImpl.getSessionData(sessionID);
		System.out.println("SessionID:" + sessionID + "; s:" + s);
		String contentDisposition = "attachment"; // inline
		Enumeration<?> e = req.getParameterNames();
		while (e.hasMoreElements()) {
			String paramName = (String) e.nextElement();
			String paramValue = req.getParameter(paramName);
			System.out.println("XMLPublisherServlet.doGet. ParameterNames: " + paramName + "=" + paramValue);
			if ("contentDisposition".equals(paramName) && !"".equals(paramValue)) {
				contentDisposition = paramValue;
			}
		}
		/******************* Response *******************/
		// setContentType - вызывать как можно раньше.
		resp.setContentType("text/plain");
		resp.setHeader("Content-Disposition", contentDisposition + "; filename=\"example-data.xml\"");

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

	public void processXMLP(OutputStream fOs) {
		FileInputStream fIs;
		String filename = getServletContext().getRealPath("/WEB-INF") + "/" + "constructorapp.xml";

		try {
			fIs = new FileInputStream(filename);
			RTFProcessor rtfProcessor = new RTFProcessor(fIs);
			rtfProcessor.setOutput(fOs);
			rtfProcessor.process();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (XDOException e) {
			e.printStackTrace();
		}
	}
}
