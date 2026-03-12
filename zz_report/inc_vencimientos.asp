<% sub TablaVencimientos(byRef pRS) %>
<a name="vencim" id="vencim"></a>
<div class="caja_ancha">
<h3 class="encabezado_vencimientos">Posibles Vencimientos de Contratos</h3>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr valign="bottom">
    <td>Inquilinos</td>
    <td width="10"></td>
    <td>Direccion</td>
    <td align="right">M<sup>2</sup> actuales&nbsp;</td>
    <td width="10"></td>
    <td align="right">Posible&nbsp;vencimiento&nbsp;</td>
</tr>
<% 
nn=0
do while not(pRS.eof)
	nn=nn+1
	'dirección		
	direccion = ""
	
	if idsVenc <> "" then idsVenc = idsVenc & ", "
	idsVenc = idsVenc & "<a href='#vencim'>" &  resultado("id") & "</a>"
	
	if pRS("EDIFICIO")<>"N/D" AND pRS("EDIFICIO")<>"" THEN
		direccion = "Edificio " & pRS("EDIFICIO") & "<br>"
	END IF
	
	'calle
	linea = ""
	IF pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" THEN
		linea = pRS("TIPODIRECCION") & " "
	END IF	
	linea = linea & pRS("NOMBRE_CALLE")
	IF pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" THEN
		linea = linea & " " & pRS("NUMERO_CALLE")
	END IF
	if linea<>"" then direccion = direccion & linea & "<br>"

	'zona	
	linea = ""
	if pRS("TIPOZONA")<>"N/D" and pRS("TIPOZONA")<>"" then 
		if pRS("ID_TIPO_ZONA")=1 then
			linea = "Parque "
		elseif pRS("ID_TIPO_ZONA")=2 then
			linea = "Pol&iacute;gono "
		end if
	end if
	linea = linea & pRS("NOMBRE_ZONA")
	if linea<>"" then direccion = direccion  & linea & "<br>"
	
	'localidad/provincia
	if ucase(pRS("PROVINCIA"))=ucase(pRS("LOCALIDAD")) THEN
		direccion = direccion & pRS("PROVINCIA")
	else
		direccion = direccion & pRS("LOCALIDAD") & " &nbsp; (" & pRS("PROVINCIA") & ")"
	end if
	
	'superficie		
	if pRS("METROS_CUADRADOS") = 0 then
		superficie = "n/d"
	else
		superficie = formatnumber(pRS("METROS_CUADRADOS"), 0)& "&nbsp;m<sup>2</sup> &nbsp; "
	end if %>
<tr height="1" bgcolor="#999999"><td colspan="6"></td></tr>
<tr valign="top">
    <td><% call inquilinos(pRS) %></td>
    <td></td>
    <td><%= direccion %></td>
    <td align="right"><%= superficie %></td>
    <td></td>
    <td align="right"><%= pRS("FECHA_FIN") %>&nbsp;</td>
</tr> 
	<% pRS.movenext 
	contVenc = contVenc + 1
	loop %>
</table>
<br>
</div>
<% end sub %>

<% sub inquilinos(byRef pRS)	
	Set rsAgentes = Server.CreateObject("ADODB.Recordset")
	' class="txtTabla" 
	%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="CURSOR:help;">
  <% 'Propietarios
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND tipo ='C'"

'	test_inyeccion_sql sql
	rsAgentes.Open sql, session("connPW"), 1, 1
	do while not rsAgentes.eof  
		boxover_header = rsAgentes("NOMBRE")
		boxover_body = "Tipo: " & rsAgentes("ACTIVIDAD")
		if rsAgentes("TLF1")<>"" then boxover_body = boxover_body & "<br> &nbsp; Telf.&nbsp;" & rsAgentes("TLF1")
		if rsAgentes("TLF2")<>"" then boxover_body = boxover_body & "<br> &nbsp; Telf.&nbsp;" & rsAgentes("TLF2")
		boxover_titulo = "header=[" & boxover_header & "] body=[" & boxover_body & "]" %>
		<tr><td title="<%= boxover_titulo %>"><%= rsAgentes("NOMBRE") %></td></tr>
		<% rsAgentes.movenext
	loop %>
  
</table>
<% end sub %>