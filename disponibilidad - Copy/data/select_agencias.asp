<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<select id="agencia" name="agencia" onchange="CargarDatos();">
<%
'onChange="CambiaAgencia();"
if 1=2 then
	for each elto in request.QueryString
		%><%= elto %>: <%= request.QueryString(elto) %> // <%
	next
end if

set rsQ = Server.CreateObject("ADODB.Recordset")

sql = "SELECT inmuebles_agentes.id_empresa AS id, EMPRESAS.NOMBRE FROM inmuebles_agentes INNER JOIN EMPRESAS ON "
sql = sql & "inmuebles_agentes.id_empresa = EMPRESAS.ID "
sql = sql & "INNER JOIN c_inmuebles ON inmuebles_agentes.id_inmueble = c_inmuebles.id "

sql = sql & "WHERE inmuebles_agentes.tipo = 'comerc' AND EMPRESAS.ID_ACTIVIDAD=28 AND inmuebles_agentes.fecha_hasta IS NULL"
if request.QueryString("ciudad")<>"" then
	sql = sql & " AND "
	select case lcase(trim(request.QueryString("ciudad")))
	case "madrid"
		sql = sql & "c_inmuebles.id_provincia = 2"
	case "barcelona"
		sql = sql & "c_inmuebles.id_provincia = 3"
	case else
		sql = sql & "c_inmuebles.localidad = '" & lcase(trim(request.QueryString("ciudad"))) & "'"
	end select
end if

if request.QueryString("min")="" then 
	sql = sql & " AND (c_inmuebles.disponible_min > 0) "
else
	min = request.QueryString("min")
	
	sql = sql & " AND c_inmuebles.id IN (SELECT DISTINCT id_inmueble FROM inmuebles_plantas WHERE "
	sql = sql & "disponible_superficie>=" & min
	if request.QueryString("max")<>"" then
		sql = sql & " AND disponible_superficie<=" & request.QueryString("max")
	end if
	sql = sql & ")"
end if 


sql = sql & "GROUP BY inmuebles_agentes.id_empresa, EMPRESAS.NOMBRE "
sql = sql & "ORDER BY EMPRESAS.NOMBRE "
'sql = "SELECT ID, NOMBRE FROM EMPRESAS WHERE ID_ACTIVIDAD=28 ORDER BY NOMBRE"

'response.Write(sql)
'response.End()
%><option value="" selected>Todas las agencias</option><%

rsQ.open sql, session("connPW")
do while not rsQ.eof
    %><option value="<%= rsQ("id") %>"><%= rsQ("nombre") %></option><%
    rsQ.movenext
loop
rsQ.close
set rsQ = nothing
%>
</select>
<div class="dropdown-toggle form-control" data-toggle="dropdown" id="" aria-expanded="false">
	<span class="dropdown-txt paisNombre">¿Quieres filtrar por Agencia?</span> 
	<span class="icon-arrow-down2 separadorSpan"></span>
</div>
<ul class="dropdown-menu" role="menu"></ul>