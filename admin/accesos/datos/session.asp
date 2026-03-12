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
	%></p><%
end if 

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM reg_pags WHERE session_id=" & request.QueryString("session_id") 
rs.Open sql, session("connPWAcesos")

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
		
		url = lcase(rs("url"))
		url = replace(url, "/default.asp", "/")
		
		http_form = lcase(left(rs("form"), 20))
		http_qry = lcase(left(rs("querystring"), 20))
		
		'url_usuario = "uid=" & rs("cliente_id") & "&u=" & rs("session_usuario")
		'url_licencia = "uid=" & rs("cliente_id") & "&u=" & rs("session_usuario") & "&lid=" & rs("usuario_id") &  "&l=" & rs("session_nombre")
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra"><%= fecha %></td>
    <td class="dra"><%= hora %></td>
    
    <td class="dra"><%'= start %></td>
    <td class="dra"><%'= login %></td>
    
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url_usuario %>" target="_blank" ><%= rs("session_usuario") %></a></td>
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url_licencia %>" target="_blank" ><%= rs("session_nombre") %></a></td>
    <td><%'= rs("remote_host") %></td>
    <td><%= url %></td>
    
    <td class="peq"><%= http_qry %></td>
    <td class="peq"><%= http_form %></td>
</tr>
	<% 
	rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if
%>
