<!--#include virtual="/lib/aspjson/aspJSON1.17.asp" -->
<% 
'on error resume next
set rsTmp = Server.CreateObject("ADODB.Recordset")
Set oJSON = New aspJSON

localidad = trim(lcase(request.form("ciudad")))
agencia = request.form("agencia")

dim tmp_sql
tmp_sql = tmp_sql & "id_tipo_inmueble=0"
'tmp_sql = tmp_sql & " AND disponible_fecha IS NOT NULL"

if localidad<>"" then
	tmp_sql = tmp_sql & " AND "
	if localidad = "madrid" then
		tmp_sql = tmp_sql & "id_provincia = 2"
	elseif localidad = "barcelona" then
		tmp_sql = tmp_sql & "id_provincia = 3"
	else
		tmp_sql = tmp_sql & "localidad = '" & localidad & "'"
	end if
end if

IF 1=2 THEN
	if agencia<>"" then
		tmp_sql = tmp_sql & " AND id IN "
		tmp_sql = tmp_sql & "(SELECT DISTINCT id_inmueble FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
	end if
END IF

if request.Form("id_subzona")<>"" then
	tmp_sql = tmp_sql & " AND id_subzona=" & request.Form("id_subzona")

elseif request.Form("id_zona")<>"" then
	tmp_sql = tmp_sql & " AND id_area=" & request.Form("id_zona")
	
end if

If request("calle")<>"" then	
	sql_dir = ""
	
	calles = request("calle")
	calles = split(trim(calles), ",")
	
	for each elto in calles 
		'response.Write("<li>[" & elto & "]</li>")
		if trim(elto)<>"" then
			if sql_dir <> "" then sql_dir = sql_dir & " OR "
			'sql_dir = sql_dir & "NOMBRE_CALLE LIKE '%" & trim(elto) & "%'"
			sql_dir = sql_dir & "NOMBRE_CALLE COLLATE Latin1_General_CI_AI LIKE '%" & trim(elto) & "%' COLLATE Latin1_General_CI_AI"
			
			'"nombre COLLATE Latin1_General_CI_AI = '" & busqueda & "' COLLATE Latin1_General_CI_AI "
			'sql = sql & "OR nombre_completo COLLATE Latin1_General_CI_AI = '" & busqueda & "' COLLATE Latin1_General_CI_AI)
		end if
	next
	if sql_dir<>"" then
		sql_dir = " AND (" & sql_dir & ")"
	end if
	tmp_sql = tmp_sql &  sql_dir
	
end if
	
'sql = "SELECT * FROM c_inmuebles WHERE (" & tmp_sql & ")"

sql = "SELECT COUNT(id) AS inmuebles, SUM(disponible_max) AS disponible_total, SUM(superf_br_alq) AS sba_total FROM c_inmuebles WHERE (" & tmp_sql & ")"

'response.Write(sql)
'response.End()

'QueryToJSON(session("connPW"), sql).Flush
rsTmp.open sql, session("connPW")

oJSON.data.Add "inmuebles", FormatNumber(rsTmp("inmuebles"), 0)
oJSON.data.Add "sba_total", FormatNumber(rsTmp("sba_total"), 0)

rsTmp.close
set rsTmp = nothing

Response.Write oJSON.JSONoutput()
%>