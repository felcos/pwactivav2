<%'@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
sql = "SELECT id AS value, nombre, provincia "
sql = sql & " FROM C_LOCALIDADES WHERE id_pais=1 AND NOMBRE LIKE '%" & ucase(request.QueryString("q")) & "%' ORDER BY nombre"

QueryToJSON(session("connPW"), sql).Flush
%>