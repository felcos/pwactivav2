<% sub Vencimientos	%>
<%	'on error resume next
dim f_desde
dim f_hasta
swMostrarListado=false

if request.Form("FechaI")="" and request.Form("FechaI")="" then exit sub

f_desde=cdate(Request.Form("FechaI"))
f_hasta=cdate(Request.Form("FechaF"))

'if isdate(f_desde) and isdate(f_hasta) and len(trim(busqueda))>1 and datediff("d", f_desde, f_hasta)>0 then
'	swMostrarListado=true
'end if

if request.Cookies("dev")("request")<>"" then %>
<div class="dev">
    Form: 
    <% for each elto in request.Form 
        if request.Form(elto)<>"" then %><b><%= elto %></b>:[<%= request.Form(elto) %>]&nbsp;<% end if 
    next %>
</div>
<% end if
	limiteVencimientos=20
	
	'sql = "SELECT * FROM C_OPERACIONES WHERE FECHA_PUBLICACION_VENCIMIENTO IS NOT NULL AND "
	sql = "SELECT * FROM C_OPERACIONES WHERE (ID_TIPO_OPERACION=2) AND "
	
	'Ubicación		
	r_prov=request("provincia")
	r_localidad=request("localidad")
	
	if r_localidad="" or r_localidad="%" then
		sql = sql & "id_provincia=" & r_prov
	else
		sql = sql & "id_localidad=" & r_localidad
	end if
	
	'Superficie		
	if request("m2i")<>"" then
		r_m2i=request("m2i")
		if isnumeric(r_m2i) then
			sql = sql & " AND metros_cuadrados>=" & r_m2i
		end if
	end if
	if request("m2f")<>"" then
		r_m2f=request("m2f")
		if isnumeric(r_m2f) then
			sql = sql & " AND metros_cuadrados<=" & r_m2f
		end if
	end if
	
	sql = sql & " AND (FECHA_FIN >= CONVERT(DATETIME, '" & f_desde & "', 103) AND FECHA_FIN < CONVERT(DATETIME, '" & f_hasta & "', 103)) "
	
	sql = sql & "AND web_es <> 0"
	
	'response.Write(sql)
	'response.End()
	set resultado = Server.CreateObject("ADODB.Recordset")
	resultado.Open sql, session("connPW"), 1, 1
	
	if resultado.eof then 
		%>
        <p>No se ha encontrado ning&uacute;n vencimiento en el per&iacute;odo indicado.</p>
		<p>Afine los criterios de b&uacute;squeda, por favor.</p>
		<%
		exit sub
	elseif resultado.recordcount>application("limite_vencimientos") then
		'if request.Cookies("dev")="" then %>
        	<p>Se han encontrado un total de <%= resultado.recordcount %> posibles vencimientos de contrato, pero el l&iacute;mite es <%= application("limite_vencimientos") %>.</p>
			<p>Afine los criterios de b&uacute;squeda, por favor.</p>
		<% exit sub
		'end if
	end if
	'if resultado.recordcount>limiteVencimientos then response.Write(">limite<br>" & sql_show): exit sub
	
	call TablaResultados(resultado)
	
	
	
	
end sub %>

<% sub TablaResultados(byRef pRS) %>
<% if request.Cookies("dev")("sql")<>"" then %><div id="dev"><%= pRS.source %></div><% end if %>

<p><b>Encontrados <span id="contar_vencimientos"></span> Posibles Vencimientos de Contrato</b></p>
<hr />
<form method="post" action="/articulos/" id="frm_titulos" name="frm_titulos">
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="venc">
<tbody>
<!--
<tr valign="bottom">
    <td></td>
    <td></td>
    <td width="10"></td>
    <td></td>
    <td align="right" width="110"></td>
    <td width="10"></td>
    <td align="right" width="110"> &nbsp; &nbsp; &nbsp;</td>
</tr>
-->
<tr valign="bottom">
    <td class="check"></td>
    <td class="inquilinos">Inquilinos</td>
    <td class="vacio"></td>
    <td class="direccion">Direcci&oacute;n</td>
    <td class="actuales" align="right">M&sup2; actuales&nbsp;</td>
    <td class="vacio"></td>
    <td class="vencimiento" align="right">Posible&nbsp;<br>&nbsp;vencimiento</td>
</tr>
<tr height="1" bgcolor="#999999"><td colspan="7"></td></tr>
<% 
nn=0
do while not(pRS.eof)
	nn=nn+1
	
	'dirección		
	direccion = ""
	
	'if pRS("EDIFICIO")<>"N/D" AND pRS("EDIFICIO")<>"" THEN
	'	direccion = "Edificio " & pRS("EDIFICIO") & "<br>"
	'END IF
	
	'calle
	linea = ""
	IF pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" THEN
		linea = pRS("TIPODIRECCION") & " "
	END IF	
	linea = linea & pRS("NOMBRE_CALLE")
	'if session("es_cliente") then
	'	IF pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" THEN
	'		linea = linea & " " & pRS("NUMERO_CALLE")
	'	END IF
	'end if
	if linea<>"" then direccion = direccion & linea & "<br>"
	
	'localidad/provincia
	if ucase(pRS("PROVINCIA"))=ucase(pRS("LOCALIDAD")) THEN
		direccion = direccion & pRS("LOCALIDAD")
	else
		direccion = direccion & pRS("LOCALIDAD")
	end if
	
	'zona	
	'linea = ""
	'if pRS("TIPOZONA")<>"N/D" and pRS("TIPOZONA")<>"" then 
	'	if pRS("ID_TIPO_ZONA")=1 then
	'		linea = "Parque "
	'	elseif pRS("ID_TIPO_ZONA")=2 then
	'		linea = "Pol&iacute;gono "
	'	else
	'		linea = pRS("TIPOZONA") & " " 
	'	end if
	'end if
	'linea = linea & pRS("NOMBRE_ZONA")
	'if linea="" then 
	'	linea = "&nbsp;"
	'else
	'	linea = ",&nbsp;" & linea & "<br>"
	'end if
	'direccion = direccion  & linea 
	
	if ucase(pRS("PROVINCIA"))<>ucase(pRS("LOCALIDAD")) THEN
		direccion = direccion & ",&nbsp;" & pRS("PROVINCIA")
	end if
	
	
	'superficie		
	if pRS("METROS_CUADRADOS") = 0 then
		superficie = "n/d &nbsp; "
	else
		superficie = formatnumber(pRS("METROS_CUADRADOS"), 0)& "&nbsp;m&sup2;&nbsp;"
	end if
	
	'link = "/articulos/?ven=" & pRS("id") & "&origen=vencimientos"
	link = "/articulos/?ven=" & pRS("id")
	for each elto in request.Form
		link = link & "&" & elto & "=" & request.Form(elto)
	next
	%>
<!--
<tr height="1" bgcolor="#999999"><td colspan="7"></td></tr>
-->
<tr valign="top">
    <td class="check"><% if request.Cookies("dev")<>"" then %>[<%= nn %>]<% end if %><input name="ven" value="<%= pRS("id") %>" type="checkbox"/></td>
    <td class="inquilinos"><a href="<%= link %>" class="simplemodal"><% call inquilinos(pRS) %></a></td>
    <td class="vacio"></td>
    <td class="direccion"><a href="<%= link %>" class="simplemodal"><%= direccion %></a></td>
    <td class="actuales" align="right"><a href="<%= link %>" class="simplemodal"><%= superficie %></a></td>
    <td class="vacio"></td>
    <td class="vencimiento" align="right"><a href="<%= link %>" class="simplemodal"><%= pRS("FECHA_FIN") %></a>&nbsp;</td>
</tr>
	<% pRS.movenext 
	loop %>
</tbody>
</table>
<div style="margin-top:3em; margin-bottom:2em; text-align:center;">
    <input type="submit" id="submit" class="btn_3" value="Leer art&iacute;culos seleccionados">
    <% for each elto in request.Form
        %><input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>"/><%
    next %>
    <!-- input type="submit" id="enviar" style="display:none;" -->
</div>
</form>
<script language="javascript">
	document.getElementById('contar_vencimientos').innerHTML="<%= nn %>"
</script>
<% end sub %>

<% sub inquilinos(byRef pRS)	
	cTitulo=pRS("TITULO")
	if instr(lcase(cTitulo), "compr") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "compr")-2)
	elseif instr(lcase(cTitulo), "prealquil") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "prealquil")-2)
	elseif instr(lcase(cTitulo), "alquil") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "alquil")-2)
	end if
	
	response.Write(cTitulo)
end sub %>

<% sub inquilinosAnt(byRef pRS)	
	Set rsAgentes = Server.CreateObject("ADODB.Recordset")
	' class="txtTabla" 
	%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="CURSOR:help;">
  <% 'Propietarios
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND tipo ='C'"

'	test_inyeccion_sql sql
	rsAgentes.Open sql, session("connPW"), 1, 1
	do while not rsAgentes.eof  %>
		<tr><td><%= rsAgentes("NOMBRE") %></td></tr>
		<% rsAgentes.movenext
	loop %>
  
</table>
<% end sub %>

<% sub Vencimientos_SinAcceso %>
<br />
<br />
<table width="75%" border="0">
	<tr>
		<td class="registro" align="center">
<br />
<br />
No tiene acceso a la sección de Posibles Vencimientos.
<br />
<br />
<br />
Para m&aacute;s informaci&oacute;n p&oacute;ngase en contacto con Property Web.
<br />
<br />
<br />
<br />
		</td>
	</tr>
	<tr>
		<td class="registro" align="right"><em><b>&copy; Property Web, S.L.</b></em></td>
	</tr>
</table>
<% end sub %>
