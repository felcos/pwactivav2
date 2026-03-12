<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<%
sql = "SELECT DISTINCT localidad FROM dirs_w_inmuebles WHERE (id_tipo_inmueble = 0) AND (disponible_fecha IS NOT NULL) AND (disponible_min > 0)"
response.Write(QueryToJSON(session("connPW"), sql).Flush)
%>