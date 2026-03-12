<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
<!--#include virtual="/lib/aspjson/aspJSON1.17.asp" -->
</head>
<body>
<h3><a href="https://www.aspjson.com/">https://www.aspjson.com/</a></h3>
<%
Set oJSON = New aspJSON

'Load JSON string


oJSON.loadJSON(jsonstring)

'Get single value
Response.Write oJSON.data("firstName") & "<br>"

'Loop through collection
For Each phonenr In oJSON.data("phoneNumber")
    Set this = oJSON.data("phoneNumber").item(phonenr)
    Response.Write _
    this.item("type") & ": " & _
    this.item("number") & "<br>"
Next

'Update/Add value
oJSON.data("firstName") = "James"

'Return json string
Response.Write oJSON.JSONoutput()
%>
</body>
</html>
