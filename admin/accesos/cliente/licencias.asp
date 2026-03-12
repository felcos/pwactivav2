<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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

cliente = request("u")
cliente_id = request("uid")

if cliente_id="" then
	%>sin cliente_id<%
	response.End()
end if

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM clientes_licencias WHERE ID_EMPRESA = " & cliente_id
sql = sql & " ORDER BY NUMERO_LICENCIA DESC"

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPW")
%>
<table class="reg">
    <tr>
        <th>N&deg;</th>
        <th style="width:280px;">Licencia</th>
        <th>Registrado</th>
        <th></th>
        <th>IP</th>
        <th>Mozilla</th>
        <th>Nav.</th>
        <th>SO</th>
    </tr>
<%
do while not rs.eof 
	url = "uid=" & cliente_id & "&u=" & cliente & "&lid=" & rs("id") & "&l=" & rs("NOMBRE")	
	%>
    <tr>
        <td class="peq"><%= rs("NUMERO_LICENCIA") %></td>
        <td><a href="/admin/accesos/cliente/?<%= url %>" target="_blank"><%= rs("NOMBRE") %> <span class="mini"><%= rs("id") %></span></a></td>
        <td><%= rs("FECHA") %></td>
        <td class="peq"><%= rs("HORA") %></td>
        <td class="peq"><%= rs("IP") %></td>
        <td class="peq"><%= rs("http_mozilla") %></td>
        <td class="peq"><%= rs("http_navegador") %></td>
        <td class="peq" nowrap="nowrap"><%= rs("http_so") %></td>
    </tr>
	<% rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
%>
<script type="text/javascript">
$(document).ready(function () {
	
})
</script>