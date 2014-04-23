<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.2-->

//SERVER_ERROR

  String content = request.getParameter("saveit_c");
  String filename = request.getParameter("saveit_f");
  if(filename == null) filename = "download.txt";
  if(content == null) content = ""; else content = new String(content.getBytes("ISO-8859-1"),"UTF-8");

  response.setContentType("text/javascript; charset=\"UTF-8\"");
  response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");
  response.setHeader("Pragma","public");
  response.setHeader("Expires","0");

  out.write(content);

%>