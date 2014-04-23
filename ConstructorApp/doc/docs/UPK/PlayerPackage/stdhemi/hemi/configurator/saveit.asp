<%

' Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.

'<!--Version 9.6.0.2-->

'SERVER_ERROR

Dim content
Dim filename

Set content = Request.Form("saveit_c")
Set filename = Request.Form("saveit_f")

If filename = "" Then
  filename = "download.txt"
End If

Response.ContentType = "text/javascript; charset=""UTF-8"""
Response.AddHeader "Content-Disposition", "attachment; filename=""" & filename & """"
Response.AddHeader "Pragma", "public"
Response.AddHeader "Expire", "0"
Response.Write content

%>