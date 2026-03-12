<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
'response.Write("id: " & request.Form("id"))
'response.Write("ids: " & request.Form("ids"))
'response.End()

id = request.form("id")

sql = "SELECT id, nombre_completo, lat, lng FROM dirs_w_inmuebles WHERE id_subzona = " & id
sql = sql & " AND id_tipo_inmueble=0"
'sql = sql & " AND disponible_fecha IS NOT NULL"

if request.Form("ids")<>"" then
	sql = sql & " AND id NOT IN (" & request.Form("ids") & ")"
end if

'response.Write(sql)
'response.End()

response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>