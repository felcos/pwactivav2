<% 
if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><hr /><%
end if 

FechaI = request("Fecha")
FechaF = DateAdd("d", 1, FechaI)

Set rs = Server.CreateObject("ADODB.Recordset")

select case request("ver")
case "conlicencia"
	sql = "cliente_id IS NOT NULL"
case "sinlicencia"
	sql = "cliente_id IS NULL"
case else
	sql = ""
end select
if sql<>"" then sql = " AND (" & sql & ")"

sql = "(session_start>='" & FechaI & "' AND session_start<'" & FechaF & "')" & sql

sql = "SELECT * FROM reg WHERE (" & sql & ") ORDER BY date"

rs.Open sql, session("connPWAcesos")

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if
%>
<table width="100%" class="reg">
  <tr>
    <th style="width:30px;">nn</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:55px;">start</th>
    <th style="width:55px; ">a.c.</th>
    
    <th style="width:150px; text-align:left;">usuario</th>
    <th style="width:200px; text-align:left;">licencia</th>
    <th style="width:100px; text-align:left;">IP</th>
    
    <th style="text-align:left;">url</th>
    <th style="text-align:left; width:150px;">qry</th>
    <th style="text-align:left; width:150px;">form</th>
  </tr>
<%
	nn = 0
	do while not rs.eof 
		nn = nn+1
		
		hora = rs("date")
		fecha = left(hora, instr(hora, " "))
		hora = mid(hora, instr(hora, " ")+1, len(hora))
		
		start = rs("session_start")
		start = mid(start, instr(start, " ")+1, len(start))
		
		login = rs("fecha_login")
		if login<>"" then
			login = mid(login, instr(login, " ")+1, len(login))
		end if
		
		url = lcase(rs("url"))
		url = replace(url, "/default.asp", "/")
		
		http_form = lcase(left(rs("form"), 20))
		http_qry = lcase(left(rs("querystring"), 20))
		
		url_usuario = "uid=" & rs("cliente_id") & "&u=" & rs("session_usuario")
		url_licencia = "uid=" & rs("cliente_id") & "&u=" & rs("session_usuario") & "&lid=" & rs("usuario_id") &  "&l=" & rs("session_nombre")
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra"><%= fecha %></td>
    <td class="dra"><%= hora %></td>
    
    <td class="dra"><%= start %></td>
    <td class="dra"><%= login %></td>
    
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url_usuario %>" target="_blank" ><%= rs("session_usuario") %> <span class="mini"><%= rs("cliente_id") %></span></a></td>
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url_licencia %>" target="_blank" ><%= rs("session_nombre") %> <span class="mini"><%= rs("usuario_id") %></span></a></td>
    <td><a href="/admin/accesos/ip/?ip=<%= rs("remote_host") %>" target="_blank" ><%= rs("remote_host") %></a></td>
    <td><%= url %></td>
    
    <td class="peq"><%= http_qry %></td>
    <td class="peq"><%= http_form %></td>
</tr>
	<% 
	if nn>=5000 then exit do
	rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
%>

<hr>
<p class="med"><%= sql %></p>
<p>&nbsp;</p>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_reg').html('(<%= nn %>)');
});
</script>