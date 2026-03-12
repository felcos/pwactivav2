<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
sql = sql & "lat IS NOT NULL "

'if request.QueryString("coords")<>"" then
	sql = sql & " AND lat>=" & request.QueryString("lat_min")
	sql = sql & " AND lat<=" & request.QueryString("lat_max")
	sql = sql & " AND lng>=" & request.QueryString("lng_min")
	sql = sql & " AND lng<=" & request.QueryString("lng_max")
'end if

sql = "SELECT id, nombre, nombre_completo, id_tipo_inmueble, tipo_inmueble, id_seccion, seccion, dir1, dir2, dir3, dir4, dir5, lat, lng, "
sql = sql & "disponible_fecha, disponible_min, disponible_max FROM dirs_w_inmuebles WHERE "

'response.Write(sql)

QueryToJSON(session("connPW"), sql).Flush
%>