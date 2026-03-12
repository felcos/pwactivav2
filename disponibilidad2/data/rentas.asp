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

sql = "SELECT id_inmueble, MIN(disponible_renta) AS renta_min, MAX(disponible_renta) AS renta_max, AVG(disponible_renta) AS renta_media "
sql = sql & "FROM inmuebles_plantas WHERE ("
sql = sql & "id_inmueble IN (" & sqlMap & ") "
sql = sql & "AND (disponible_renta IS NOT NULL) "
sql = sql & "AND (seccion_operacion = 1)"
sql = sql & ") "
sql = sql & "GROUP BY id_inmueble"

response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>