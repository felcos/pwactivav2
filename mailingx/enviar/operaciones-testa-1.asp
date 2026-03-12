<!DOCTYPE html>
<html lang="es">
<head>
<title>Property Web - market intelligence: Spain</title>
</head>
<style>
table, th, td {border-bottom:1px solid #c1c1c1; padding: 6px 8px;}
table {border-collapse: collapse;}
th {}
td {vertical-align:top;}
</style>
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT *, seccion AS APARTADO FROM C_OPERACIONES WHERE ("
sql = sql & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) AND (seccion LIKE '%naves industriales%') AND (ID_PROVINCIA=2 OR ID_PROVINCIA=3) "
sql = sql & "AND METROS_CUADRADOS>=15000 AND FECHA_OPERACION >= CONVERT(DATETIME, '01/01/2013', 103) AND web_es<>0 ) "
sql = sql & "ORDER BY FECHA_OPERACION DESC"

rsTmp.Open sql, session("connPW")
%>
<body>
<img src="https://www.propertyweb.eu/img/logo_pw.png" width="260" height="57">
<h2>Operaciones de Naves Industriales</h2>
<p><%'= sql %>
MADRID y BARCELONA &nbsp; // &nbsp; tipo = VENTA / OCUPACI&Oacute;N PROPIA &nbsp; // &nbsp; Superf. >= 15.000 M&sup2; &nbsp; // &nbsp; Fecha Ops.: 01/01/2013 - 16/06/2015</p>
<table width="100%">
<tbody>
<thead>
<tr>
    <th>n&deg;</th>
    <th>fecha op.</th>
    <th>direcci&oacute;n</th>
    <th>edificio</th>
    <th>M2</th>
    <th>&euro;</th>
    <td width="120">Comprador(es)</td>
    <td width="120">Vendedor(es)</td>
    <td width="150">Agente(s)</td>
</tr>
</thead>
<tbody>
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
	direccion = direccion & ", &nbsp;" & rsTmp("LOCALIDAD") & "<br>" & rsTmp("PROVINCIA") 
	direccion = trim(direccion)
	
	'enlace
	enlace = "https://www.propertyweb.eu/articulos/?ope=" & rsTmp("ID") & "&origen=mailDeals"
	
	'rsAgentes 
	
%>
<% if c_fecha<>act_fecha then 
	act_fecha = c_fecha %>
<% end if %>
<tr valign="top">
    <td><a href="<%= enlace %>" class="simplemodal" target="_blank"><%= ii %></a></td>
    <td><%= rsTmp("fecha_operacion") %></td>
    <td><%= direccion %></td>
    <td><%= edificio %></td>
    <td align="right"><%= FormatNumber(rsTmp("metros_cuadrados"),0) %></td>
    <td align="right"><% if rsTmp("precio_eur")>0 then %><%= FormatNumber(rsTmp("precio_eur"),0) %><% end if %></td>
    
    <td style="font-size:.85em;"><% call AgentesNombre(pRS,"C") %></td>
    <td style="font-size:.85em;"><% call AgentesNombre(pRS,"P") %></td>
    <td style="font-size:.85em;"><% call AgentesNombre(pRS,"I") %></td>
    
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