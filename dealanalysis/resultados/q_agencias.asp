<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
sql = "SELECT ID, NOMBRE, logotipo FROM C_OPERACIONES_INTERMEDIARIOS WHERE ID IN (SELECT ID FROM C_OPERACIONES WHERE " & request.QueryString("sqlw") & ")"
'sql = "SELECT logotipo FROM C_OPERACIONES_INTERMEDIARIOS WHERE ID=" & request.QueryString("id")
sql = sql & " AND TIPO LIKE '%I'"
sql = sql & " AND ID_ACTIVIDAD=28"

response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>