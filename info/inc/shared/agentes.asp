<%
swEncontradoAlgo = false
es_la_primera = true

set rsAg = Server.CreateObject("ADODB.Recordset")	

'Propiedad
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & rsInmueble("id")
sql = sql & " AND tipo='prop'"

if acceso_seccion then
	sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
else
	sql = sql & " AND fecha_hasta IS NULL"
end if
rsAg.Open sql, session("connPW")
if rsAg.eof then
	rsAg.close
	'Propiedad del padre
	if not(isnull(rsInmueble("id_complejo"))) then
		sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & rsInmueble("id_complejo")
		sql = sql & " AND tipo='prop'"
		if acceso_seccion then
			sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
		else
			sql = sql & " AND fecha_hasta IS NULL"
		end if
		'response.Write(sql)
		'response.End()
		
		rsAg.Open sql, session("connPW")
		
		if not(rsAg.eof) then
			call tblAgentes(rsAg, "Propiedad")
			swEncontradoAlgo = true
		end if
		
		rsAg.close
	end if
else
	call tblAgentes(rsAg, "Propiedad")
	swEncontradoAlgo = true
	
	rsAg.close
end if




'Comercialización
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & rsInmueble("id")
sql = sql & " AND tipo='comerc'"

if acceso_seccion then
	sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
else
	sql = sql & " AND fecha_hasta IS NULL"
end if
rsAg.Open sql, session("connPW")
if not rsAg.eof then
	call tblAgentes(rsAg, "Comercializaci&oacute;n")
	swEncontradoAlgo = true
end if
rsAg.close

'Gestión
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & rsInmueble("id")
sql = sql & " AND tipo='gest'"

if acceso_seccion then
	sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
else
	sql = sql & " AND fecha_hasta IS NULL"
end if
rsAg.Open sql, session("connPW")
if not rsAg.eof then
	call tblAgentes(rsAg, "Gesti&oacute;n")
	swEncontradoAlgo = true
end if
rsAg.close

set rsAg=nothing
%>

<% sub tblAgentes(byRef pRS, cTitulo) %>
<table class="tb-Gral tb-propiedad">
<thead>            
	<tr>
		<th><strong><%= cTitulo %>:</strong></th>
		<th>desde</th>
		<th>hasta</th>
	</tr>
</thead>
<tbody>
<% do while not pRS.eof 
	if isnull(pRS("fecha_desde")) then
		f_desde = "&nbsp;"
	else
		'f_desde = MonthName(month(pRS("fecha_desde")), true) & "/" & year(pRS("fecha_desde"))
		f_desde = FechaCorta(pRS("fecha_desde"))
	end if
	if isnull(pRS("fecha_hasta")) then
		f_hasta = "&nbsp;"
	else
		'f_hasta = MonthName(month(pRS("fecha_hasta")), true) & "/" & year(pRS("fecha_hasta"))
		f_hasta = FechaCorta(pRS("fecha_hasta"))
	end if
	
	if acceso_seccion then
		cTxt = pRS("empresa")
	else
		cTxt = lcase(pRS("actividad"))
	end if %>
	<tr <% if not isnull(pRS("fecha_hasta")) then %>class="historico"<% end if %>>
		<td><%= cTxt %></td>
		<td><%= f_desde %></td>
		<td><%= f_hasta %></td>
	</tr>
	<% pRS.movenext
loop %>
</table>
<% if request.Cookies("dev")("sql")<>"" then %><p class="dev peq" style="margin-top:0;"><%= pRS.source %></p><% end if %>
<% 
	es_la_primera = false
end sub %>

<% if swEncontradoAlgo then
	if not acceso_seccion then %>
		<p style="margin-bottom:18px; font-size:11px;">* Para acceder al arhivo hist&oacute;rico debe tener contratado Info-Inmuebles.</p>
	<% end if 
end if %>