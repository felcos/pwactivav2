<% 
if request.Cookies("dev")("request")<>"" then
	%><p><strong>QueryString</strong> &nbsp; <%
	for each elto in request.QueryString
		%><%= elto %>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p><strong>Form</strong>: &nbsp; <%
	for each elto in request.Form
		%><%= elto %>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><hr /><%
end if

FechaI = request("FechaI")
FechaF = request("FechaF")
if FechaF<>"" then FechaF=DateAdd("d", 1, FechaF)

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

Set rs = Server.CreateObject("ADODB.Recordset")

sqlW = "cliente_id=" & cliente_id 
if licencia_id="" then
	if licencia<>"" then
		sqlW = sqlW & " AND session_nombre LIKE '" & licencia & "'"
	end if
else
	sqlW = sqlW & " AND usuario_id=" & licencia_id
end if

sqlW = "(" & sqlW & ")"

if FechaI<>"" then
	sqlF = "session_start>='" & FechaI & "'"
end if
if FechaF<>"" then
	if sqlF<>"" then sqlF = sqlF & " AND "
	sqlF = sqlF & "session_start<'" & FechaF & "'"
end if
if sqlF<>"" then sqlF = " AND (" & sqlF & ")"

sqlW = sqlW & sqlF

sql = "SELECT TOP(1001) * FROM reg WHERE (" & sqlW & ") ORDER BY date DESC"
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos") 
%>
<hr>
<p class="med"><%= sql %></p>
<hr />
<% 'response.End() %>
<table width="100%" class="reg">
  <tr>
    <th style="width:30px;">nn</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:55px;">start</th>
    <th style="width:55px; ">login</th>
    
    <% if licencia_id="" then %>
    <th style="width:10px;"></th>
    <th style="width:180px; text-align:left;">licencia</th>
    <% end if %>
    
    <th style="width:10px;"></th>
    <th style="text-align:left;">url</th>
    <th style="text-align:left; width:200px;">qry</th>
    <th style="text-align:left; width:300px;">form</th>
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
		
		http_form = lcase(left(rs("form"), 40))
		http_qry = lcase(left(rs("querystring"), 60))
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra"><%= fecha %></td>
    <td class="dra"><%= hora %></td>
    
    <td class="dra"><%= start %></td>
    <td class="dra"><%= login %></td>
    <% if licencia_id="" then %>
    <td></td>
    <td nowrap="nowrap"><%= rs("session_nombre") %> <span class="mini"><a href="/admin/accesos/cliente/?uid=<%= cliente_id %>&u=<%= cliente %>&l=<%= rs("session_nombre") %>&lid=<%= rs("usuario_id") %>"><%= rs("usuario_id") %></a></span></td>
    <% end if %>
    <td></td>
    <td><%= url %></td>
    
    <td class="peq"><%= http_qry %></td>
    <td class="peq"><%= http_form %></td>
</tr>
	<% 
	if nn>=1000 then 
		%>
<tr>
	<td colspan="11">hay mas...</td>
</tr>
		<%
		exit do
	end if
	rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
%>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_reg').html('(<%= nn %>)');
});
</script>
