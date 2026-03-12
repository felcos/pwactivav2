<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<% 
'on error resume next
'set rsTmp = Server.CreateObject("ADODB.Recordset")
'Set oJSON = New aspJSON

localidad = trim(lcase(request.queryString("ciudad")))
agencia = request.queryString("agencia")

dim tmp_sql
tmp_sql = tmp_sql & "id_tipo_inmueble=0 AND "
tmp_sql = tmp_sql & "disponible_fecha IS NOT NULL AND disponible_min>0"

if localidad="" then
	tmp_sql = tmp_sql & " AND id_pais = 1"
else
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

yy=request.QueryString("year")
if yy="" then yy="2018"

if yy="2018" then
	
	if agencia<>"" then
		tmp_sql = tmp_sql & " AND id IN "
		tmp_sql = tmp_sql & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
	end if
	
	sql = "SELECT COUNT(id) AS inmuebles, SUM(disponible_max) AS disponible FROM dirs_w_inmuebles WHERE (" & tmp_sql & ")"
	
else
	if agencia<>"" then
		tmp_sql = tmp_sql & " AND t1.id_inmueble IN "
		tmp_sql = tmp_sql & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
	end if
	
	sql = "SELECT COUNT(t1.id_inmueble) AS inmuebles, SUM(t1.superficie) AS disponible "
	'sql = sql & "t1.renta_min AS hist_renta_min, t1.renta_max AS hist_renta_max, t1.porcentaje AS int_porcentaje "
	sql = sql & "FROM inmuebles_disponibilidad t1 INNER JOIN "
	sql = sql & "(SELECT id_inmueble, MAX(fecha) AS MaxDate FROM inmuebles_disponibilidad WHERE "
	sql = sql & "fecha <= '31/12/" & yy & "' "
	sql = sql & "GROUP BY id_inmueble) t2 ON "
	sql = sql & "t1.id_inmueble = t2.id_inmueble AND t1.fecha = t2.MaxDate LEFT OUTER JOIN dbo.dirs_w_inmuebles ON "
	sql = sql & "t1.id_inmueble = dbo.dirs_w_inmuebles.id_edificio "
	
	sql = sql & "WHERE (" & tmp_sql & ")"
	
end if


'sql = "SELECT COUNT(id) AS inmuebles, SUM(disponible_max) AS disponible FROM c_inmuebles WHERE (" & tmp_sql & ")"

'response.Write(sql)
'response.End()

QueryToJSON(session("connPW"), sql).Flush
'rsTmp.open sql, session("connPW")

'oJSON.data.Add "inmuebles", FormatNumber(rsTmp("inmuebles"), 0)
'oJSON.data.Add "disponible", FormatNumber(rsTmp("disponible"), 0)

'rsTmp.close
'set rsTmp = nothing
%>