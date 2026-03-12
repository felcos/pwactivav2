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

FechaI = request("FechaI")
FechaF = request("FechaF")
if FechaF<>"" then FechaF=DateAdd("d", 1, FechaF)

ip = request("ip")

Set rs = Server.CreateObject("ADODB.Recordset")


sqlW = "remote_host='" & ip & "'"

if sqlW<>"" then sqlW = "(" & sqlW & ")"

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
'response.Write(sql)
'response.End()

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
    <th style="width:180px; text-align:left;">licencia</th>
    
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
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra"><%= fecha %></td>
    <td class="dra"><%= hora %></td>
    
    <td class="dra"><%= start %></td>
    <td class="dra"><%= login %></td>
    
    <td><a href="#"><%= rs("session_usuario") %> <span class="mini"><%= rs("cliente_id") %></span></a></td>
    <td><a href="#"><%= rs("session_nombre") %> <span class="mini"><%= rs("usuario_id") %></span></a></td>
    <td><%= url %></td>
    
    <td class="peq"><%= http_qry %></td>
    <td class="peq"><%= http_form %></td>
</tr>
	<% 
	if nn>=1000 then 
		%>
<tr>
	<td colspan="10">hay mas...</td>
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
