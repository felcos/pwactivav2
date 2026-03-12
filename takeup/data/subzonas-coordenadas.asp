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

sql = "SELECT aux_subzonas_coordenadas.id_subzona, aux_subzonas_coordenadas.lat, aux_subzonas_coordenadas.lng "
sql = sql & "FROM aux_subzonas_coordenadas INNER JOIN aux_subzonas ON aux_subzonas_coordenadas.id_subzona = aux_subzonas.id "
sql = sql & "WHERE aux_subzonas.id_provincia = " & prov & " ORDER BY aux_subzonas_coordenadas.id_subzona, aux_subzonas_coordenadas.id"

'response.Write(sql)
'response.End()
%>
<% QueryToJSON(session("connPW"), sql).Flush %>