<%
swEncontradoAlgo = false
es_la_primera = true

set rsAg = Server.CreateObject("ADODB.Recordset")	

'Propiedad
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & pRS("ID")
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
	if not(isnull(rsAg("id_complejo"))) then
		sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & pRS("id_complejo")
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
			call tblAgentes2(rsAg, "Propiedad")
			swEncontradoAlgo = true
		end if
		
		rsAg.close
	end if
else
%>
	<table class="tb-Gral tb-propiedad">
		<thead>            
			<tr>
				<th><strong>Propiedad:</strong></th>
				<th>desde</th>
				<th>hasta</th>
			</tr>
		</thead>
		<tbody>
		<% do while not rsAg.eof 
			if isnull(rsAg("fecha_desde")) then
				f_desde = "&nbsp;"
			else
				'f_desde = MonthName(month(rsAg("fecha_desde")), true) & "/" & year(rsAg("fecha_desde"))
				f_desde = FechaCorta(rsAg("fecha_desde"))
			end if
			if isnull(rsAg("fecha_hasta")) then
				f_hasta = "&nbsp;"
			else
				'f_hasta = MonthName(month(rsAg("fecha_hasta")), true) & "/" & year(rsAg("fecha_hasta"))
				f_hasta = FechaCorta(rsAg("fecha_hasta"))
			end if
			
			'if acceso_seccion then
				cTxt = rsAg("empresa")
			'else
			''	cTxt = lcase(rsAg("actividad"))
			'end if %>
			<tr <% if not isnull(rsAg("fecha_hasta")) then %>class="historico"<% end if %>>
				<td><%= cTxt %></td>
				<td><%= f_desde %></td>
				<td><%= f_hasta %></td>
			</tr>
			<% rsAg.movenext
		loop %>
		</table><% 
	swEncontradoAlgo = true
	
	rsAg.close
end if




'Comercialización
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & pRS("id")
sql = sql & " AND tipo='comerc'"

if acceso_seccion then
	sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
else
	sql = sql & " AND fecha_hasta IS NULL"
end if
rsAg.Open sql, session("connPW")
if not rsAg.eof then
%>
	<table class="tb-Gral tb-propiedad">
		<thead>            
			<tr>
				<th><strong>Comercializaci&oacute;n:</strong></th>
				<th>desde</th>
				<th>hasta</th>
			</tr>
		</thead>
		<tbody>
		<% do while not rsAg.eof 
			if isnull(rsAg("fecha_desde")) then
				f_desde = "&nbsp;"
			else
				'f_desde = MonthName(month(rsAg("fecha_desde")), true) & "/" & year(rsAg("fecha_desde"))
				f_desde = FechaCorta(rsAg("fecha_desde"))
			end if
			if isnull(rsAg("fecha_hasta")) then
				f_hasta = "&nbsp;"
			else
				'f_hasta = MonthName(month(rsAg("fecha_hasta")), true) & "/" & year(rsAg("fecha_hasta"))
				f_hasta = FechaCorta(rsAg("fecha_hasta"))
			end if
			
			'if acceso_seccion then
				cTxt = rsAg("empresa")
			'else
			''	cTxt = lcase(rsAg("actividad"))
			'end if %>
			<tr <% if not isnull(rsAg("fecha_hasta")) then %>class="historico"<% end if %>>
				<td><%= cTxt %></td>
				<td><%= f_desde %></td>
				<td><%= f_hasta %></td>
			</tr>
			<% rsAg.movenext
		loop %>
		</table><% 
	swEncontradoAlgo = true
end if
rsAg.close

'Gestión
sql = "SELECT * FROM c_inmuebles_agentes WHERE id_inmueble=" & pRS("id")
sql = sql & " AND tipo='gest'"

if acceso_seccion then
	sql = sql & " ORDER BY isnull(fecha_hasta, GETDATE()) DESC, fecha_hasta DESC"
else
	sql = sql & " AND fecha_hasta IS NULL"
end if
rsAg.Open sql, session("connPW")
if not rsAg.eof then
%>
	<table class="tb-Gral tb-propiedad">
		<thead>            
			<tr>
				<th><strong>Gesti&oacute;n:</strong></th>
				<th>desde</th>
				<th>hasta</th>
			</tr>
		</thead>
		<tbody>
		<% do while not rsAg.eof 
			if isnull(rsAg("fecha_desde")) then
				f_desde = "&nbsp;"
			else
				'f_desde = MonthName(month(rsAg("fecha_desde")), true) & "/" & year(rsAg("fecha_desde"))
				f_desde = FechaCorta(rsAg("fecha_desde"))
			end if
			if isnull(rsAg("fecha_hasta")) then
				f_hasta = "&nbsp;"
			else
				'f_hasta = MonthName(month(rsAg("fecha_hasta")), true) & "/" & year(rsAg("fecha_hasta"))
				f_hasta = FechaCorta(rsAg("fecha_hasta"))
			end if
			
			'if acceso_seccion then
				cTxt = rsAg("empresa")
			'else
			''	cTxt = lcase(rsAg("actividad"))
			'end if %>
			<tr <% if not isnull(rsAg("fecha_hasta")) then %>class="historico"<% end if %>>
				<td><%= cTxt %></td>
				<td><%= f_desde %></td>
				<td><%= f_hasta %></td>
			</tr>
			<% rsAg.movenext
		loop %>
		</table><% 
	swEncontradoAlgo = true
end if
rsAg.close

set rsAg=nothing
%>


<% if swEncontradoAlgo then
	if not acceso_seccion then %>
		<p style="margin-bottom:18px; font-size:11px;">* Para acceder al arhivo hist&oacute;rico debe tener contratado Info-Inmuebles.</p>
	<% end if 
end if %>