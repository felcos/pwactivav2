<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
sql = "SELECT id, nombre, nombre_completo, id_tipo_inmueble, tipo_inmueble, id_seccion, seccion, dir1, dir2, dir3, dir4, dir5, lat, lng, "
sql = sql & "disponible_fecha, disponible_min, disponible_max FROM dirs_w_inmuebles WHERE "	'tiene_coords=1 AND 
sql = sql & "lat>=" & request.QueryString("lat_min") & " AND "
sql = sql & "lat<=" & request.QueryString("lat_max") & " AND "

sql = sql & "lng>=" & request.QueryString("lng_min") & " AND "
sql = sql & "lng<=" & request.QueryString("lng_max")

sqlT = ""

if request.QueryString("cc")="" then 
	if sqlT<>"" then sqlT = sqlT & ", "
	sqlT = sqlT & "1"
end if

if request.QueryString("hotel")="" then 
	if sqlT<>"" then sqlT = sqlT & ", "
	sqlT = sqlT & "2"
end if

if request.QueryString("edif")="" then 
	if sqlT<>"" then sqlT = sqlT & ", "
	sqlT = sqlT & "0"
end if

if sqlT<>"" then sqlT = "AND id_tipo_inmueble NOT IN (" & sqlT & ") "

sql = sql & sqlT & " ORDER BY nombre_completo"

'QueryToJSON(session("connPW"), sql).Flush

'{"markers":[
'	{"id":"1309120671785","lat":"48.856614","long":"2.3522219000000177","creator":"sofasurfer","name":"paris","fileurl":"data\/1309120671785.html"},
'    {"id":"1309120893064","lat":"37.38263999999999","long":"-5.9962950999999975","creator":"sofasurfer","name":"seville","fileurl":"data\/1309120893064.html"},
'    {"id":"1309120908442","lat":"36.8913183","long":"27.283475199999998","creator":"sofasurfer","name":"kos","fileurl":"data\/1309120908442.html"},
'  	 .....
'    {"id":"1309132006781","lat":"51.919438","long":"19.14513599999998","creator":"Jim","name":"polska","fileurl":"data\/1309132006781.html"}
']}
%>{"request":"<%= request.QueryString %>",
"sql":"<%= sql %>",
"markers":<%= QueryToJSON(session("connPW"), sql).Flush %>
}