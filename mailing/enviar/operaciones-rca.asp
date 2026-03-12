<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb</title>
</head>

<!--#include virtual="/inc/js.asp" -->
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM C_OPERACIONES"
sql = sql & " WHERE "
sql = sql & "(FECHA_OPERACION BETWEEN CONVERT(DATETIME, '2012-12-01 00:00:00', 102) AND CONVERT(DATETIME, '2013-07-01 00:00:00', 102)) AND "
sql = sql & "(ID_TIPO_OPERACION = 1 OR ID_TIPO_OPERACION = 3) AND "
sql = sql & "(id_pais=1) AND "
sql = sql & "(PRECIO_EUR >= 5000000) "
sql = sql & "ORDER BY fecha_operacion, ID"


rsTmp.Open sql, session("connPW")
%>
<body>
<h2>Operaciones RCA</h2>
<p><%'= sql %>Pais = ESPA&Ntilde;A &nbsp; // &nbsp; tipo = INVERSION o VENTA &nbsp; // &nbsp; Precio >= 5 M &euro; &nbsp; // &nbsp; Fecha Op: 01/12/2012 - 01/07/2013 </p>
<table cellpadding="2" cellspacing="0" border="1" width="100%">
<tbody>
<thead>
<tr>
    <th>n&deg;</th>
    <th>id</th>
    <th>fecha</th>
    <th>direcci&oacute;n</th>
    <th>edificio</th>
    <th>M2</th>
    <th>&euro;</th>
    
    <td width="120">Comprador/Inquilino</td>
    <td width="120">Vendedor/Arrendador</td>
    <td width="150">Agentes</td>
    
    
</tr>
</thead>
<% 
ii=1
act_fecha = month(rsTmp("fecha_operacion")) & year(rsTmp("fecha_operacion"))

do while not rsTmp.eof 

	'dirección		
	edificio = ""
	direccion = ""
	c_fecha = month(rsTmp("fecha_operacion")) & year(rsTmp("fecha_operacion"))
	
	if rsTmp("EDIFICIO")<>"N/D" AND rsTmp("EDIFICIO")<>"" then
		edificio = rsTmp("EDIFICIO")
	end if
	
	'zona	
	linea = ""
	if rsTmp("TIPOZONA")<>"N/D" and rsTmp("TIPOZONA")<>"" then 
		if rsTmp("ID_TIPO_ZONA")=1 then
			linea = "Parque "
		elseif rsTmp("ID_TIPO_ZONA")=2 then
			linea = "Pol&iacute;gono "
		end if
	end if
	linea = linea & rsTmp("NOMBRE_ZONA")
	if linea<>"" then direccion = direccion  & linea & " &nbsp; "
	
	'calle
	linea = ""
	IF rsTmp("TIPODIRECCION")<>"N/D" and rsTmp("TIPODIRECCION")<>"" THEN
		linea = rsTmp("TIPODIRECCION") & " "
	END IF	
	linea = linea & rsTmp("NOMBRE_CALLE")
	IF rsTmp("NUMERO_CALLE")<>"N/D" and rsTmp("NUMERO_CALLE")<>"0" and rsTmp("NUMERO_CALLE")<>"" THEN
		linea = linea & " " & rsTmp("NUMERO_CALLE")
	END IF
	if linea<>"" then direccion = direccion & linea
	
	'localidad
	direccion = direccion & " &nbsp; (" & rsTmp("LOCALIDAD") & ")"
	
	'enlace
	enlace = "https://www.propertyweb.eu/articulos/?ope=" & rsTmp("ID") & "&origen=jpRCA"
	
	'rsAgentes 
	
%>
<% if c_fecha<>act_fecha then 
	act_fecha = c_fecha %>
	<tr><td colspan="10">&nbsp;</td></tr>
<% end if %>
<tr valign="top">
    <td><%= ii %></td>
    <td><a href="<%= enlace %>" class="simplemodal" target="_blank"><%= rsTmp("id") %></a></td>
    <td><%= rsTmp("fecha_operacion") %></td>
    <td><%= direccion %></td>
    <td><%= edificio %></td>
    <td align="right"><%= rsTmp("metros_cuadrados") %></td>
    <td align="right"><%= FormatNumber(rsTmp("precio_eur"),0) %></td>
    
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"C") %></td>
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"P") %></td>
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"I") %></td>
    
</tr>
	<% rsTmp.movenext
	ii=ii+1
loop
 
rsTmp.close
set rsTmp=nothing %>
</tbody></table>
<p>&nbsp;</p>


<% sub AgentesNombre(byRef pRs, pTipo) 
	Set rsAg = Server.CreateObject("ADODB.Recordset")	
	select case pTipo
		case "C"
			sql = "tipo='C'"
		case "P"
			sql = "tipo='P'"
		case "I"
			sql = "(tipo='CI' or tipo='PI')"
	end select
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & rsTmp("ID") & " AND " & sql & " ORDER BY tipo"
	rsAg.Open sql, session("connPW")
	if not rsAg.eof then %>
<div>
  <% do while not rsAg.eof 
		if pTipo="I" then
			if rsAg("tipo")="CI" then
				cTipo = " (C)"
			elseif rsAg("tipo")="PI" then
				cTipo = " (P)"
			end if
		else
			cTipo = ""
		end if 
		%>
<%= lcase(rsAg("NOMBRE")) %><%= cTipo %><br>
    	<% rsAg.movenext
		loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>


</body>
</html>