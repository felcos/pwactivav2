<!--#include virtual="/lib/aspjson/aspJSON1.17.asp" -->
<% 
'on error resume next
set rsTmp = Server.CreateObject("ADODB.Recordset")
Set oJSON = New aspJSON

localidad = trim(lcase(request.queryString("ciudad")))
agencia = request.queryString("agencia")

dim tmp_sql
tmp_sql = tmp_sql & "id_tipo_inmueble=0"
'tmp_sql = tmp_sql & " AND disponible_fecha IS NOT NULL"

if localidad<>"" then
	tmp_sql = tmp_sql & " AND "
	if localidad = "madrid" then
		tmp_sql = tmp_sql & "id_provincia = 2"
	elseif localidad = "barcelona" then
		tmp_sql = tmp_sql & "id_provincia = 3"
	elseif localidad = "londres" then
		tmp_sql = tmp_sql & "id_provincia = 60"
	else
		tmp_sql = tmp_sql & "localidad = '" & localidad & "'"
	end if
end if

if request.queryString("id_subzona")<>"" then
	tmp_sql = tmp_sql & " AND id_subzona=" & request.queryString("id_subzona")

elseif request.queryString("id_zona")<>"" then
	tmp_sql = tmp_sql & " AND id_area=" & request.queryString("id_zona")
	
end if

'response.Write(tmp_sql)
'response.End()

sql = "SELECT COUNT(id) AS inmuebles, SUM(disponible_max) AS disponible_total, SUM(superf_br_alq) AS sba_total FROM c_inmuebles WHERE (" & tmp_sql & ")"

rsTmp.open sql, session("connPW")

oJSON.data.Add "inmuebles", FormatNumber(rsTmp("inmuebles"), 0)
oJSON.data.Add "sba_total", FormatNumber(rsTmp("sba_total"), 0)

rsTmp.close
set rsTmp = nothing

Response.Write oJSON.JSONoutput()
%>