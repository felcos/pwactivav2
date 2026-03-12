<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<% 
dim tmp_sql
sql = sql & "id_tipo_inmueble=0"
'sql = sql & " AND disponible_fecha IS NOT NULL"

'sql = sql & "id_pais=1 AND "
'sql = sql & "lat IS NOT NULL AND "
'sql = sql & "superf_br_alq IS NOT NULL AND "

'if localidad<>"" then
'	sql = sql & " AND "
'	if localidad = "madrid" then
'		sql = sql & "id_provincia = 2"
'	elseif localidad = "barcelona" then
'		sql = sql & "id_provincia = 3"
'	else
'		sql = sql & "localidad = '" & localidad & "'"
'	end if
'end if

sql = "SELECT id, nombre, lat, lng FROM inmuebles WHERE (" & sql & ")"

'response.Write(sql)
'response.End()

QueryToJSON(session("connPW"), sql).Flush
%>