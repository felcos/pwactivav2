<% 'Variables globales 
	
	public num_titulo 
	public enlace
	public target
	public hoy
%>

<% SUB NUEVA_SECCION(ap) %>
	<tr><td valign="top" class="pagsum_apartados"><%= lcase(ap) %></td></tr> 
<% end sub %>
<% SUB NUEVA_SECCION_OP(ap) %>
	<tr><td valign="top" class="pagsum_apartados"><%= CalcularSeccionOp(ap) %><%'= ap %></td></tr> 
<% end sub %>

<% sub TablaResultados(byRef pRS)	
num_titulo=0
%>
<table class="ResultItem" border="0" width="100%">
<tbody>
<% if request.Cookies("dev")("sql")<>"" and 1=2 then %>
    <tr><td colspan="4"><%= pRS.source %></td></tr>
<% end if %>
	<% if seccion2="VENCIMIENTOS" then %><tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
	<td width="20"></td>
    <td>Tipo de Empresa</td>
	<td width="90" align="right">M2 actuales&nbsp;</td>
	<td width="145">&nbsp;Ubicaci&oacute;n&nbsp;</td>
  </tr>
</table>
		</td></tr><% end if %>
<% if ErrMesage<>"" then %>
	<tr> 
		<td width="76%" align="center"><%= ErrMesage %></td>
	</tr>
<% else 'if ErrMesage<>""... %>	  
	<%'en el caso de Noticias cuando cambie a rumor debe parar y rellenar otra tabla
		if seccion="not" then tipo=pRS("TIPO_NOTICIA")
		'Esta variable me controla los apartados
		apart= ""
		Do While Not pRS.EOF
			if seccion="not" then
				if tipo<>pRS("TIPO_NOTICIA") then exit do
				tipo=pRS("TIPO_NOTICIA")
			end if
			if apart<>pRS("APARTADO") and pRS("APARTADO")<>"NO" then 
				if bloque="operac" then
					call NUEVA_SECCION_OP(pRS("APARTADO"))
				else
					%><tr><td colspan="2"><div class="apartado_tit"><img src="/img/flash/apunta.gif"><strong>&nbsp;<%= resultado("APARTADO") %></strong></div><hr></td></tr><%
					'call NUEVA_SECCION(pRS("APARTADO"))
				end if
			end if
			apart=pRS("APARTADO")
			'a=a+1
			num_titulo=num_titulo+1
			contador=contador+1
			
			enlace = enlace_base & strin &"=" & pRS("ID") & "&origen=" & origen
			Hoy="false"	
			%>
    <tr><td class="firstRow"><% CalcularTitulo(pRS) %></td></tr>
	<tr><td colspan="4"></td></tr>
    <% pRS.movenext
		loop
	%>
<% end if %>
</tbody>
</table>
<% end sub %>


<% sub CalcularTitulo(byRef pRS)	
	if seccion2="VENCIMIENTOS" then
		cTitulo=pRS("TITULO")
		if instr(lcase(cTitulo), "compr") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "compr")-2)
		elseif instr(lcase(cTitulo), "prealquil") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "prealquil")-2)
		elseif instr(lcase(cTitulo), "alquil") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "alquil")-2)
		end if

		cUbicacion = pRS("localidad")
		if lcase(pRS("provincia"))<>lcase(pRS("localidad")) then
			if len(cUbicacion)>21 then cUbicacion = left(cUbicacion, 18) & "..."
			cUbicacion = cUbicacion & " (" & pRS("provincia") & ")"
		end if
		if len(cUbicacion)>22 then cUbicacion = replace(cUbicacion, " (", "<br> &nbsp; &nbsp; (")
		%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
    <td><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>">&nbsp;<a href="<%= enlace %>" <% if origen="FlashPW" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cTitulo %></a></td>
	<td width="50" align="right"><a href="<%= enlace %>" <% if origen="FlashPW" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= formatnumber(pRS("metros_cuadrados"),0)  %>&nbsp;M2&nbsp;</a></td>
	<td width="145"> &nbsp; <a href="<%= enlace %>" <% if origen="FlashPW" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cUbicacion %></a></td>
  </tr>
</table>
	<% else
		IF LEN(resultado("TITULO"))<3 OR ISNULL(resultado("TITULO")) THEN 
			RESPONSE.WRITE pRS("TITULO_AUX")
		'	CalcularTitulo="<font class='azullink' color='#999999'>" & pRS("TITULO_AUX") & "</FONT>"
		ELSE
			RESPONSE.WRITE pRS("TITULO")
			'RESPONSE.WRITE AcomodaBD(pRS("TITULO"))
		'	CalcularTitulo=pRS("TITULO")
		END IF
	end if
end sub %>

<% function CalcularSeccionOp(pIds)
	cIds = "," & pIds
	
	Set rsSecc = Server.CreateObject("ADODB.Recordset")
	rsSecc.open "SELECT * FROM TIPOS_DE_SECCIONES_OPERACIONES", session("connPW")	', 1, 1
	do while not rsSecc.eof
		
    	cIds = replace(cIds, "," & rsSecc("ID") & ",", lcase(rsSecc("NOMBRE")) & ",")
		rsSecc.movenext
	loop
	
	rsSecc.close
	set rsSecc=nothing
	
	cIds = replace(cIds, ",", "/")
	cIds = cIds & "/"
	cIds = replace(cIds, "//", "")
	
	CalcularSeccionOp=cIds 
	
end function %>
