<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
if request.Form("id")="undefined" then
	id = -1
elseif request.Form("id")="" then
	id = -1
else
	id = request.form("id")
end if
'id = request.QueryString("id")
'sql = "SELECT lat,lng FROM aux_subzonas_coordenadas WHERE id_subzona=" & id

sql = "SELECT aux_subzonas_coordenadas.lat, aux_subzonas_coordenadas.lng "
sql = sql & "FROM aux_subzonas_coordenadas INNER JOIN aux_subzonas ON aux_subzonas_coordenadas.id_subzona = aux_subzonas.id "
sql = sql & "WHERE aux_subzonas.id = " & id

'response.Write(sql)
%>
<% QueryToJSON(session("connPW"), sql).Flush %>