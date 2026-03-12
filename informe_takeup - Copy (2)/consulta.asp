<meta charset="UTF-8">
<% 

set rsData = Server.CreateObject("ADODB.Recordset")
set rsData2 = Server.CreateObject("ADODB.Recordset")
localidad=""
dim year
year=2020
sql_m2="SELECT SUM(METROS_CUADRADOS) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & year & "0101' AND '" & year & "1231' "
sql_eu="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & year & "0101' AND '" & year & "1231'"

if localidad="" then
	sqlw = sqlw & " AND id_pais = 1"
else

	sqlw = sqlw & " AND "
	if localidad = "madrid" then
		sqlw = sqlw & "id_provincia = 2"
	elseif localidad = "barcelona" then
		sqlw = sqlw & "id_provincia = 3"
	elseif localidad = "londres" then
		sqlw = sqlw & "id_provincia = 60"
	else
		sqlw = sqlw & "localidad = '" & localidad & "'"
	end if
end if



%>
<table border="1">
	<tr>
		<td>Año</td>
		<td>Ops</td>
		<td>M2</td>
	</tr>

	<%
dim i 
For i =1985 To 2020
	year=i
	sql_m2="SELECT SUM(METROS_CUADRADOS) as MetrosCuad FROM dirs_w_OPS where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and web_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & year & "0101' AND '" & year & "1231' "
	sql_eu="SELECT COUNT(id) as Nro_Ops FROM C_OPERACIONES where ( ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=2 ) AND seccion LIKE '%oficinas%' and pw_es<>0 and ID_PAIS=1 and  FECHA_OPERACION BETWEEN '" & year & "0101' AND '" & year & "1231'"
	rsData.open sql_m2, session("connPW")
	rsData2.open sql_eu, session("connPW")
	%>
	<tr>
		<td><%=i %></td>
		<td><%= rsData2("Nro_Ops") %></td>
		<td><%= rsData("MetrosCuad") %></td>
	</tr>
	<%
rsData.close
rsData2.close
Next
%>

</table>
<%






%>