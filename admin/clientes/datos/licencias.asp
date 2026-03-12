<% @ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<style>
.avisar, .avisar a {
	color:#990000;
}
</style>
<%
id=request.QueryString("id")
'if id<>"" then
	sql = "SELECT * FROM licencias_control"	'WHERE ID_EMPRESA=" & last_login order by 
	%>
    <table class="reg" width="100%">
        <tr>
            <th style="text-align:left; width:20px;" colspan="2">licencia</th>
            <th style="width:15px;"></th>
			<th style="text-align:left;" width="50%">nombre</th>
			<th style="text-align:left;" width="50%">telefono</th>
            <th style="text-align:left; width:60px;" colspan="2">registrado</th>
            <th style="text-align:right; width:120px;" nowrap="nowrap">&uacute;ltimo acceso</th>
        </tr>
    <% 
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, session("connPWAcesos")
	nn = 0
	do while not rs.eof 
		nn=nn+1
		
		url_usuario = "uid=" & rs("id_empresa") & "&u=" & rs("usuario")
		url_licencia = url_usuario & "&lid=" & rs("id") &  "&l=" & rs("nombre")
		
		avisar=false
		if isnull(rs("ultimo_acceso")) or datediff("d", rs("ultimo_acceso"), date)>15 then avisar=true
		%>
		<tr <% if avisar then %>class="avisar"<% end if %>>
			<td style="text-align:right;"><%= rs("NUMERO_LICENCIA") %></td>
			<td style="text-align:right;" class="peq">/<%= rs("NUM_LICENCIAS") %></td>
			<td class="med"></td>
			<td><a href="/admin/accesos/cliente/?<%= url_licencia %>" target="_blank" ><%= rs("NOMBRE") %></a></td>
			<td class="med"><%= rs("telefono") %></td>
			<td class="med"><%= rs("FECHA") %></td>
			<td class="med"><%= rs("HORA") %></td>
			<td style="text-align:right;"><%= rs("ultimo_acceso") %></td>
		</tr>
		<% rs.movenext
	loop 

	rs.close
	set rs=nothing
%>
</table>
<% 'end if %>