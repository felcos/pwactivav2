<% sub TablaOperaciones(pId, pTipo, pZona, pYear) 
	f_desde = pYear & "-01-01" 
	f_hasta = pYear & "-12-31" 
	
	sqlW = "(web_es=1) AND "
	sqlW = sqlW & "(id_empresa=" & pId & " OR id_sucursal=" & pId & ") AND " 
	sqlW = sqlW & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) AND (tipo='" & pTipo & "') AND "
	
	sqlW = sqlW & "(FECHA_OPERACION BETWEEN CONVERT(DATETIME, '" & f_desde & " 00:00:00', 102) AND "
	sqlW = sqlW & "CONVERT(DATETIME, '" & f_hasta & " 00:00:00', 102))"
	
	select case pZona
	case "e"
		sqlW = sqlW & " AND (ID_PAIS = 1) "
	case "r"
		sqlW = sqlW & " AND (ID_PAIS <> 1) "
	case "t"
		
	end select

	sql = "SELECT * FROM inversores_operaciones_agentes WHERE (" & sqlW & ") ORDER BY seccion, fecha_actualizacion DESC"
	'https://www.propertyweb.eu/inversores/empresa/?t=c&z=e&y=2014&id=1162
	test_inyeccion_sql sql
	
	Set resultado = Server.CreateObject("ADODB.Recordset")
	resultado.Open sql, session("connPW")	', 1, 1
	
	swMostrarDetalles = false
	'resp = session("PW_WS").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))
	'resp = session("PW_WS").IniCliente(request.Cookies("licencia")("user_id"), request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("movil"))
	if session("es_cliente") and session("acceso_activo") then 
		if session("pw_ws").accesoInversores then swMostrarDetalles = true	
	end if
	
	superficie=0
	contador=0
	num_titulo=0
%>
<% IF 1=2 THEN %>
<table width="100%">
<thead>
<tr>
    <th width="50">n&uacute;m</th>
    <th>operaci&oacute;n</th>
    <th width="70">superficie</th>
	<th width="80" align="right">fecha op.</th>
    </tr>
</thead>
<tbody>

<% if 1=2 then 
	'fila con datos de ejemplo para maquetar el archivo /dealanalysis/inc/tabla_titulos.asp
%>
<tr>
    <td valign="middle"><input type="checkbox" name="xxx" value="0" checked class="chexbox">9999</td>
    <td valign="center"><a href="#">C/ Tobago 34<br />Madrid</a></td>
    <td align="right">99999</td>
    <td align="right">31/12/2012</td>
    </tr>
<% end if %>

<% 
color="#FFF"
apart = ""
do while not resultado.eof	
	if apart<>resultado("seccion") then %>
<tr bgcolor="#666666" style="color:#FFFFFF;" valign="bottom"><td colspan="5" height="30"><b><%= resultado("seccion") %></b></td></tr>
	<%
	end if

		apart = resultado("seccion")
		
		num_titulo=num_titulo+1
		contador=contador+1
		superficie = superficie + resultado("METROS_CUADRADOS")
		

		'dirección		
'IF 1=2 THEN		
		direccion = ""
		if resultado("EDIFICIO")<>"N/D" AND resultado("EDIFICIO")<>"" THEN
			'direccion = "Edificio " & resultado("EDIFICIO") & " &nbsp; "
			direccion = resultado("EDIFICIO") & " &nbsp; "
		END IF
		
		'zona	
		linea = ""
		'if resultado("TIPOZONA")<>"N/D" and resultado("TIPOZONA")<>"" then 
		'	if resultado("ID_TIPO_ZONA")=1 then
		'		linea = "Parque "
		'	elseif resultado("ID_TIPO_ZONA")=2 then
		'		linea = "Pol&iacute;gono "
		'	end if
		'end if
		linea = linea & resultado("NOMBRE_ZONA")
		if linea<>"" then direccion = direccion  & linea & " &nbsp; "
		
		'calle
		linea = ""
		IF resultado("TIPODIRECCION")<>"N/D" and resultado("TIPODIRECCION")<>"" THEN
			linea = resultado("TIPODIRECCION") & " "
		END IF	
		linea = linea & resultado("NOMBRE_CALLE")
		IF resultado("NUMERO_CALLE")<>"N/D" and resultado("NUMERO_CALLE")<>"0" and resultado("NUMERO_CALLE")<>"" THEN
			linea = linea & " " & resultado("NUMERO_CALLE")
		END IF
		if linea<>"" then direccion = direccion & linea
		
		'localidad
		direccion = direccion & " &nbsp; (" & resultado("LOCALIDAD") & ")"
'END IF
		
		direccion = resultado("TITULO")
		'direccion = resultado("NOMBRE_CALLE")
		
		superf = "" & FormatNumber(resultado("METROS_CUADRADOS"),0)
		if superf = "0" then
			superf = "&nbsp;N/D"
		else
			superf = superf & "&nbsp;m<sup>2</sup>"
		end if
		'articulo2(resultado) 
		
		enlace = "/articulos/?ope=" & resultado("ID") & "&origen=invers"
		
		%>
<tr style="background-color:<%= color %>">
    <td valign="top"><input type="checkbox" name="ope" value="<%= resultado("ID") %>" <% if checked="true" then %>checked<% end if %> class="chexbox"> &nbsp; <a href="<%= enlace %>" class="simplemodal"><%= num_titulo %></a></td>
    <td valign="top" style="font-size:14px;"><a href="<%= enlace %>" class="simplemodal"><%= direccion %></a></td>
    <td valign="top" align="right"><a href="<%= enlace %>" class="simplemodal"><%= superf %></a></td>
    <td valign="top" align="right"><a href="<%= enlace %>" class="simplemodal"><%= resultado("FECHA_OPERACION") %></a></td>
    </tr>
		<% resultado.movenext
		if color="#CCC" then
			color="#FFF"
		else
			color="#CCC"
		end if
	'next
	loop

	%>
</tbody>
</table>
<% ELSE 
	if not resultado.eof then %>
	<!-- include virtual="/inversores/empresa/inc_titulos.asp" -->
	<!--#include virtual="/dealanalysis/resultados/inc_titulos.asp" -->
	<% end if
END IF %>
<% if contador=0 then %>
	<p style="padding-left:4px; padding-top:15px; padding-bottom:10px;">No se ha encontardo ninguna operaci&oacute;n.</p>
<% end if %>
<% if request.Cookies("dev")("sql")<>"" then %>
	<div style="background:#FFFFCC; padding:3px; margin-top:3px;font-size:11px;border:#000000 1px solid;"><%= resultado.source %></div>
<% end if %>

<% 
set resultado=nothing

end sub %>

<% Sub TablaResumen(pId) 
	sqlW = "(web_es=1) AND "
	sqlW = sqlW & "(id_empresa=" & pId & " OR id_sucursal=" & pId & ") AND " 
	sqlW = sqlW & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) "
	
	sql = "SELECT * FROM inversores_operaciones_agentes WHERE (" & sqlW & ")"
	
	test_inyeccion_sql sql
	
	Set resultado = Server.CreateObject("ADODB.Recordset")
	resultado.Open sql, session("connPW")	', 1, 1
	
	num_titulo=0
	cont_compra=0
	cont_venta=0
	
	do while not resultado.eof
		num_titulo=num_titulo+1
		select case resultado("tipo")
		case "C"
			cont_compra = cont_compra+1
		case "P"
			cont_venta = cont_venta+1
		end select
		
		resultado.movenext
	loop
	%>
<div style="padding-left:10px;">
    <table border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td>Se han encontrado:&nbsp; &nbsp;</td>
        <td align="right"><%= cont_compra %></td>
        <td>&nbsp;operaciones de venta</td>
      </tr>
      <tr>
            <td align="right">&nbsp;</td>
        <td align="right"><%= cont_venta %></td>
        <td>&nbsp;operaciones de compra</td>
      </tr>
    </table>
    <hr style="margin-top:20px; margin-bottom:20px" />
    <p>Para acceder a los contenidos restringidos debe tener contrato Inversores.</p>
    <p style="margin-top:10px; margin-bottom:15px;">Para m&aacute;s informaci&oacute;n, p&oacute;ngase en contacto con PropertyWeb.</p>
  </div>
<% end sub %>
<% sub div_orden(p_orden) 
	select case p_orden
	case "dir"
		c_desc = "Ordenar por Direcci&oacute;n"
	case "superf"
		c_desc = "Ordenar por Superficie"
	case "precio"
		c_desc = "Ordenar por Precio"
	case "fecha"
		c_desc = "Ordenar por Fecha de Operaci&oacute;n"
	end select
	
	if r_orden=p_orden then
		if r_ordent="desc" then 
			img = "/img/sort_asc.png"
			n_ordent = ""
			n_orden = ""
			
		elseif r_ordent="asc" then
			img = "/img/sort_asc.png"
			n_ordent = "desc"
			n_orden = p_orden
			
		elseif r_ordent="" then
			img = "/img/sort_desc.png"
			n_ordent = "desc"
			n_orden = p_orden
			
		else
			response.End()
		end if
	else
		img = "/img/sort_both.png"
		n_ordent = ""
		n_orden = p_orden
	end if

	
	if p_orden="null" then %>
		<img src="/img/transparent.png" width="1" height="19" />
    <% else %>
		<a href="javascript:ordena('<%= n_orden %>', '<%= n_ordent %>');"><img src="<%= img %>" width="19" height="19" alt="Ordenar" longdesc="<%= c_desc %>" /></a>
    <% end if 
end sub %>
