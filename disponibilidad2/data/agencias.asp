<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
busqueda = request.QueryString("frmInfo_busq")

function calcular_sql()	
	sql = "SELECT ID FROM dirs_w_inmuebles WHERE ("
	if busqueda<>"%" then
		sql = sql & "("
		sql = sql & "(nombre COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sql = sql & " OR nombre_completo COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sql = sql & " OR nombre_alt COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sql = sql & " OR localidad COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI"
		sql = sql & ")"
		sql = sql & " OR ("
		'sql = sql & "dir1 LIKE '%" & busqueda & "%' OR "
		sql = sql & "dir2 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
		sql = sql & "dir3 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI OR "
		sql = sql & "dir4 COLLATE Latin1_General_CI_AI LIKE '%" & busqueda & "%' COLLATE Latin1_General_CI_AI)"
		sql = sql & ")"
		sql = sql & " AND "
	end if
	
	sql = sql & "id_tipo_inmueble=0"
	sql = sql & " AND disponible_fecha IS NOT NULL"
	
	min = request.QueryString("min")
	if min="" then min = 0
	
	if min=0 then
		sql = sql & " AND disponible_min>0"
	else
		sql = sql & " AND disponible_min>=" & min
	end if
	
	if request.QueryString("max")<>"" then
		sql = sql & " AND disponible_min<=" & request.QueryString("max")
	end if 
	
	sql = sql & ")"
	
	calcular_sql = sql

end function

sqlMap = calcular_sql()

sql = "SELECT id_inmueble, id_empresa, empresa, tipo, logotipo FROM c_inmuebles_agentes WHERE id_inmueble IN (" & sqlMap & ")"
sql = sql & " AND TIPO='comerc'"
'sql = sql & " AND TIPO='prop'"
sql = sql & " AND fecha_hasta IS NULL"

response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>