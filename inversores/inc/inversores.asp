<% sub TopInversores(tipo, zona, anno)
	'tipo = c | v
	'zona = e | r
	
	set rsTmp = Server.CreateObject("ADODB.Recordset")
	
	f_desde = anno & "-01-01" 
	f_hasta = anno & "-12-31" 
	
	if tipo="c" then
		r_tipo = "C"
	elseif tipo="v" then
		r_tipo = "P"
	else
		exit sub
	end if
	
	'sql = "SELECT OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE, COUNT(C_OPERACIONES.ID) AS ops, SUM(C_OPERACIONES.PRECIO_EUR) AS euros "
	'sql = sql & ", EMPRESAS.ID_PAIS, Paises.Nombre AS PAIS "
	'
	'sql = sql & "FROM TIPOS_DE_ACTIVIDADES RIGHT OUTER JOIN "
	'sql = sql & "Paises RIGHT OUTER JOIN "
	'sql = sql & "OPERACIONES_CONTACTOS INNER JOIN "
	'sql = sql & "EMPRESAS ON OPERACIONES_CONTACTOS.id_sucursal = EMPRESAS.ID INNER JOIN "
	'sql = sql & "C_OPERACIONES ON OPERACIONES_CONTACTOS.id_operacion = C_OPERACIONES.ID "
	'sql = sql & "ON Paises.Id = EMPRESAS.ID_PAIS ON "
	'sql = sql & "TIPOS_DE_ACTIVIDADES.ID = EMPRESAS.ID_ACTIVIDAD "
	'
	'sql = sql & " WHERE "
	'sql = sql & "(C_OPERACIONES.ID_TIPO_OPERACION = 3) AND (TIPOS_DE_ACTIVIDADES.directorio = 1) AND "
	'
	'sql = sql & "(OPERACIONES_CONTACTOS.tipo = '" & r_tipo & "') AND "
	'
	'sql = sql & "(C_OPERACIONES.FECHA_OPERACION BETWEEN CONVERT(DATETIME, '" & f_desde & " 00:00:00', 102) AND "
	'sql = sql & "CONVERT(DATETIME, '" & f_hasta & " 00:00:00', 102)) "
	'
	'if zona="e" then
	'	sql = sql & "AND (C_OPERACIONES.ID_PAIS = 1) "
	'elseif zona="r" then
	'	sql = sql & "AND (C_OPERACIONES.id_region IN (2, 3, 5)) "
	'else
	'	response.End()
	'end if
	'
	'sql = sql & "GROUP BY OPERACIONES_CONTACTOS.id_empresa, OPERACIONES_CONTACTOS.id_sucursal, EMPRESAS.NOMBRE "
	'sql = sql & ", EMPRESAS.ID_PAIS, Paises.Nombre "
	'
	'sql = sql & "ORDER BY SUM(C_OPERACIONES.PRECIO_EUR) DESC"
	
	sql = "SELECT TOP(10) id_empresa, empresa_nombre, empresa_id_pais, COUNT(ID) AS ops, SUM(PRECIO_EUR) AS euros, ID_PAIS, PAIS, id_region FROM inversores_operaciones_agentes WHERE ("
	sql = sql & "(ID_TIPO_OPERACION = 3) AND (directorio = 1) AND "
	sql = sql & "(tipo = '" & r_tipo & "') AND "
	sql = sql & "(FECHA_OPERACION BETWEEN CONVERT(DATETIME, '" & f_desde & " 00:00:00', 102) AND "
	sql = sql & "CONVERT(DATETIME, '" & f_hasta & " 00:00:00', 102)) "
	
	if zona="e" then
		sql = sql & "AND (ID_PAIS = 1)"
	elseif zona="r" then
		sql = sql & "AND (id_region IN (2, 3, 5))"
	else
		response.End()
	end if
	sql = sql & ") "
	sql = sql & "GROUP BY id_empresa, empresa_nombre, empresa_id_pais, ID_PAIS, PAIS, id_region "
	sql = sql & "ORDER BY SUM(PRECIO_EUR) DESC"
	
	test_inyeccion_sql sql
	rsTmp.Open sql, session("connPW")
	ii=1
	link = "y=" & anno & "&t=" & tipo & "&z=" & zona
	%>
<div class="invcont">
<div class="boxerhead">
	<div class="filatit">
		<div class="box1tit">
<% 
	if session("pw_ws").LicenciaId=0 then 
		%>Principales <% if tipo="v" then %>vendedores<% else %>compradores<% end if %><br />
		<% if zona="e" then %>Espa&ntilde;a<% else %>Resto de Europa<% end if %><%
	else
		%><a href="/inversores/empresas/?<%= link %>">Principales <% if tipo="v" then %>vendedores<% else %>compradores<% end if %><br />
		<% if zona="e" then %>Espa&ntilde;a<% else %>Resto de Europa<% end if %></a><%
	end if %>
        </div>
		<div class="box2tit">M &euro;</div>
	</div>
</div>


<div class="boxer">
<% for ii=1 to 5
	if rsTmp.eof then exit for
	if session("pw_ws").accesoInversores then 
		valor=FormatNumber(rsTmp("euros")/1000000,0)
		if valor=0 then valor=""
	else
		valor = "..."
	end if
	%>
	<div class="box-row">
		<div class="box1"><%= ii %></div>
		<div class="box2"><% 
	if session("pw_ws").LicenciaId=0 then 
		%><%= rsTmp("empresa_nombre") %><%
	else
		%><a href="/inversores/empresa/?<%= link %>&id=<%= rsTmp("id_empresa") %>" data-ajax="false"><%= rsTmp("empresa_nombre") %></a><%
	end if %></div>
		<div class="box3"><img src="/img/paises/32/<%= rsTmp("empresa_id_pais") %>.png" width="16" height="10" border="0"/></div>
        <div class="box4"><%= valor %></div>
	</div>
	<% rsTmp.movenext
next %>
</div>
<% rsTmp.close
set rsTmp=nothing %>


<div class="boxerfoot">
<% 
	'if session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id"))=0 then 
	if session("pw_ws").LicenciaId=0 then 
		%>ver m&aacute;s<%
	else
		%><a href="/inversores/empresas/?<%= link %>">ver m&aacute;s</a><%
	end if %>
</div>

</div>

<% 
if request.Cookies("dev")("sql")<>"" then 
	response.Write(sql)
end if

end sub %>