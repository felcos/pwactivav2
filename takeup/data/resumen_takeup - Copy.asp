<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<% 
'on error resume next

localidad = trim(lcase(request.queryString("ciudad")))
agencia = request.queryString("agencia")

sql = "SELECT ID_TIPO_OPERACION, COUNT(ID) AS operaciones, SUM(METROS_CUADRADOS) AS superficie FROM dirs_w_ops WHERE "
sql = sql & "web_es<>0"
sql = sql & " AND (ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2)"
sql = sql & " AND seccion LIKE '%oficinas%'"

yy = request.QueryString("year")
if yy="" then yy = 2016
sql = sql & " AND FECHA_OPERACION BETWEEN CONVERT(DATETIME, '01/01/" & yy & "', 103) AND CONVERT(DATETIME, '31/12/" & yy & "', 103)"

if localidad="" then
	'sql = sql & " AND id_pais = 1"
else
	sql = sql & " AND "
	if localidad = "madrid" then
		sql = sql & "id_provincia = 2"
	elseif localidad = "barcelona" then
		sql = sql & "id_provincia = 3"
	elseif localidad = "londres" then
		sql = sql & "id_provincia = 60"
	else
		sql = sql & "localidad = '" & localidad & "'"
	end if
end if


if agencia<>"" then
	sql = sql & " AND id IN "
	'sql = sql & "(SELECT DISTINCT id_operacion FROM inmuebles_agentes WHERE (id_empresa = " & agencia & " AND tipo = 'comerc'))"
	sql = sql & "(SELECT DISTINCT OPERACIONES_CONTACTOS.id_operacion "
	sql = sql & "FROM OPERACIONES_CONTACTOS INNER JOIN EMPRESAS ON OPERACIONES_CONTACTOS.id_empresa = EMPRESAS.ID "
	sql = sql & "WHERE (EMPRESAS.ID_ACTIVIDAD = 28 AND OPERACIONES_CONTACTOS.tipo LIKE '%I'))"
end if

if request.queryString("id_subzona")<>"" then
	sql = sql & " AND id_subzona=" & request.queryString("id_subzona")

elseif request.queryString("id_zona")<>"" then
	sql = sql & " AND id_area=" & request.queryString("id_zona")
end if

sql = sql & " GROUP BY ID_TIPO_OPERACION"

'response.Write(sql)
'response.End()


response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>