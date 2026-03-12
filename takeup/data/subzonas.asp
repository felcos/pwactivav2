<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
r = request("ciudad")
select case r
case "madrid"
	prov = 2
case "barcelona"
	prov = 3
case else
	prov = 0
end select

'sql = "SELECT lat,lng FROM aux_subzonas_coordenadas WHERE id_subzona=" & id
sql = "SELECT id, nombre FROM aux_subzonas WHERE id_provincia = " & prov

'response.Write(sql)
'response.End()
%>
<% QueryToJSON(session("connPW"), sql).Flush %>