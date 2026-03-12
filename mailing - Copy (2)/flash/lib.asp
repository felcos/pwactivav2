<% sub BloqueVencimientosFlash(byRef pRS)	
num_titulo=0
apart= ""
%>
<table class="ResultItem" border="0" width="100%">
<tbody>
	<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
	<td width="20"></td>
    <td>Tipo de Empresa</td>
	<td width="90" align="right" nowrap="nowrap">M2 actuales&nbsp;</td>
	<td width="145">&nbsp;Ubicaci&oacute;n&nbsp;</td>
  </tr>
</table>
		</td></tr>
	<% Do While Not pRS.EOF
			if apart<>pRS("APARTADO") and pRS("APARTADO")<>"NO" then 
				apart=pRS("APARTADO")
				%><tr><td colspan="2"><div class="apartado"><img src="/img/flash/apunta.gif"><strong>&nbsp;<%= apart %></strong></div><hr></td></tr><%
			end if
			num_titulo=num_titulo+1
			contador=contador+1
			'enlace = enlace_base & "?" & strin & "=" & resultado("ID") & "&origen=DailyFlash&f=" & pFecha
			enlace = enlace_base & "?" & strin &"=" & pRS("ID") & "&origen=" & origen & "&f=" & pFecha
			Hoy="false"	
			%>
        <tr><td class="firstRow"><% CalcularTituloVencimiento(pRS) %></td></tr>
        <tr><td colspan="4"></td></tr>
    <% pRS.movenext
		loop
	%>

</tbody>
</table>
<% end sub %>


<% sub CalcularTituloVencimiento(byRef pRS)	
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
    <td><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>">&nbsp;<a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cTitulo %></a></td>
	<td width="50" align="right"><a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= formatnumber(pRS("metros_cuadrados"),0)  %>&nbsp;M2&nbsp;</a></td>
	<td width="145"> &nbsp; <a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cUbicacion %></a></td>
  </tr>
</table>
<% end sub %>



<% sub test_inyeccion_sql(rSql)	
	cPasa=true
	crSql=lcase(rSql)
	
	if instr(crSql, "declare") then cPasa=false
	if instr(crSql, "update") then cPasa=false
	if instr(crSql, "chr(") then cPasa=false
	if instr(crSql, "http") then cPasa=false
	
	if not(cPasa) then
		
		sqlReg = "INSERT INTO ataques (session_id, fecha, hora, ip, querystring, form, cookie_pw, cookie_licencia, referer) VALUES ("
		sqlReg = sqlReg & "'" & session.SessionID & "', '" & date & "', '" & time & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("REMOTE_ADDR") & "', "
		
		sqlReg = sqlReg & "'" & AcomodaTexto(request.QueryString) & "', "
		sqlReg = sqlReg & "'" & AcomodaTexto(request.Form) & "', "

		sqlReg = sqlReg & "'" & request.Cookies("pw") & "', "
		sqlReg = sqlReg & "'" & request.Cookies("licencia") & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("HTTP_REFERER") & "'"
		
		sqlReg = sqlReg & ")"
		
		session("connPWAcesos").execute sqlReg
		
		'configurar servidor email 
		Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = "smtp.propertyweb.eu"
		Mail.Port = 25 
		Mail.Username = "lcf013c"
		Mail.Password = "PWeu08"
		
		'Variables Mail  
		Mail.From = "informatica@propertyweb.eu"
		Mail.FromName = "Servidor NAVIA"
		
		Mail.AddAddress "informatica@propertyweb.eu", "jp"
		Mail.Subject = "Aviso de Ataque SQL"
	
		'Mail 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Se ha detectado un ataque SQL.</p>" & "<br>"
		txtMail = txtMail & "<p>" & date & " " & time & "</p>"
		txtMail = txtMail & "<p>REMOTE_ADDR: " & request.ServerVariables("REMOTE_ADDR") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>HTTP_REFERER:<br>" & request.ServerVariables("HTTP_REFERER") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>QueryString:<br>" & request.QueryString & "</p>" & "<hr>"
		txtMail = txtMail & "<p>Form:<br>" & request.Form & "</p>" & "<hr>"
		txtMail = txtMail & "</BODY></HTML>"
		
		Mail.Body = txtMail
		Mail.IsHTML = True
		
		'Enviar 
		On Error Resume Next
		Mail.Send 
		
		response.End()
	end if
	
end sub %>