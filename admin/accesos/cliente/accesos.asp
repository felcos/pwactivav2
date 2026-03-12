<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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

server.ScriptTimeout=300

Set rs = Server.CreateObject("ADODB.Recordset")

FechaI = request("FechaI")
FechaF = request("FechaF")
if FechaF<>"" then FechaF=DateAdd("d", 1, FechaF)

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

if cliente_id="" then
	if cliente="" then
		%>sin datos<%
		response.End()
	else
		sqlW = "reg_accesos.cookie_u='" & cliente & "'"
	end if
else
	sqlW = "reg_accesos.cookie_uid=" & cliente_id
end if

if licencia_id="" then
	if licencia<>"" then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "reg_accesos.cookie_l='" & licencia & "'"
	end if
else
	if sqlW<>"" then sqlW = sqlW & " AND "
	sqlW = sqlW & "reg_accesos.cookie_lid=" & licencia_id
end if
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

sql = "SELECT * FROM reg_accesos WHERE (" & sqlW & ") ORDER BY session_start DESC"
'test_inyeccion_sql sql

rs.Open sql, session("connPWAcesos")

for each elto in request.Form
	%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
next 


if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if
%>
<hr />

<table width="100%" class="reg">
  <tr>
    <th style="width:30px;">nn</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:55px;">a.c.</th>
    
    <th style="width:10px;"></th>
    <th style="width:60px;">session_id</th>
    <th style="width:10px;"></th>
    
    <th style="width:300px; text-align:left;">licencia</th>
    
    <th style="text-align:left; width:250px;">http_user_agent</th>
    <th></th>
  </tr>
<%
	nn = 0
	do while not rs.eof 
		nn = nn+1
		
		hora = rs("session_start")
		fecha = left(hora, instr(hora, " "))
		hora = mid(hora, instr(hora, " ")+1, len(hora))
		
		login = rs("session_login")
		if login<>"" then
			login = mid(login, instr(login, " ")+1, len(login))
		end if
		
		url = ""	'rs("info")
		
		http_user_agent = rs("http_user_agent")
		http_qry = ""
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra"><%= fecha %></td>
    <td class="dra"><%= hora %></td>
    <td class="dra"><%= login %></td>
    <td></td>
    <td class="dra"><%=rs("session_id")  %></td>
    <td></td>
    <td><a href="#"><%= rs("cookie_l") %> <span class="mini"><%= rs("cookie_lid") %></span></a></td>
    
    <td class="peq"><%'= http_user_agent %></td>
    <td class="mini dra">user agent</td>
    
</tr>
		<%
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
	$('#contador_accesos').html('(<%= nn %>)');
});
</script>
