<% sub publicar_inversores 
	Set rsPublicar = Server.CreateObject("ADODB.Recordset")
	rsPublicar.open "SELECT * FROM directorio_inversores WHERE id=" & day(date), session("connPW")
	
	pub_letra=rsPublicar("letra")
	rsPublicar.Close
	Set rsPublicar = Nothing
	
	
	
	Set rsBusqAprox = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT * FROM directorio WHERE NOMBRE LIKE '" & pub_letra & "%'  AND directorio=1 AND (NOMBRE_CALLE IS NOT NULL AND NOMBRE_CALLE<>'') ORDER BY ACTIVIDAD, NOMBRE"
	'sql = "SELECT * FROM directorio WHERE NOMBRE LIKE '" & pub_letra & "%'  AND directorio=1 ORDER BY ACTIVIDAD, NOMBRE"
	
	rsBusqAprox.open sql, session("connPW")	
	col=1
	nn=0
	do while not rsBusqAprox.eof
		nn=nn+1
		link = rsBusqAprox("nombre")
		if instr(link, "&") then link = replace(link, "&", "_amp_")
		if col=1 then
			'(" & nn & ") &nbsp; 
			col_1 = col_1 & "<li>" & rsBusqAprox("nombre") & "</li>"
			'col_1 = col_1 & "<li>(" & nn & ") &nbsp; <a href=""default.asp?busq=" & rsBusqAprox("nombre") & """>" & rsBusqAprox("nombre") & "</a></li>"
			'col_1 = col_1 & "<li><a href='default.asp?busq=" & link & "' class='negro'>" & rsBusqAprox("nombre") & "</a></li>"
			col=2
		else
			'(" & nn & ") &nbsp; 
			col_2 = col_2 & "<li>" & rsBusqAprox("nombre") & "</li>"
			'col_2 = col_2 & "<li>(" & nn & ") &nbsp; <a href=""default.asp?busq=" & rsBusqAprox("nombre") & """>" & rsBusqAprox("nombre") & "</a></li>"
			'col_2 = col_2 & "<li><a href='default.asp?busq=" & link & "' class='negro'>" & rsBusqAprox("nombre") & "</a></li>"
			col=1
		end if
		rsBusqAprox.movenext
	loop
	rsBusqAprox.Close
	Set rsBusqAprox = Nothing
	
	if col_1<>"" then %>
<p>&nbsp; Empresas que comienzan por: &nbsp;<span class="style2"><%= pub_letra %></span></p>
<table width="100%" border="0" cellspacing="4" cellpadding="2">
	<tr valign="top">
		<td width="50%"><%= col_1 %></td>
		<td width="50%"><%= col_2 %></td>
	</tr>
</table>
	<% end if		'rsBusqAprox.eof
	
end sub 

%>


