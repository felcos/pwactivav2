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

sql = "SELECT cookie_uid AS usuario_id, cookie_u AS usuario, cookie_l AS licencia, MIN(session_start) AS fini, MAX(session_start) AS fend FROM reg_accesos WHERE "
sql = sql & "("
sql = sql & "cookie_uid = " & cliente_id 
if cliente<>"" then
	sql = sql & " AND cookie_u = '" & cliente & "'"
end if
sql = sql & ")"
sql = sql & " AND NOT cookie_l IN (SELECT NOMBRE FROM PW_clientes_licencias WHERE ID_EMPRESA=" & cliente_id & ")"
sql = sql & " GROUP BY cookie_u, cookie_l, cookie_uid "
sql = sql & " ORDER BY licencia"


if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
%>
<table class="reg">
    <tr>
        <th>N&deg;</th>
        <th style="width:280px;">Licencia</th>
        <th></th>
        <th style="width:70px; text-align:left;">desde</th>
        <th style="width:70px; text-align:left;">hasta</th>
        <th></th>
    </tr>
<%
nn = 0

do while not rs.eof 
	nn = nn +1
	url = "/admin/accesos/cliente/?uid=" & cliente_id & "&u=" & cliente & "&l=" & rs("licencia") & "&old=old"
	fini = rs("fini")
	fini = left(fini, instr(fini, " ")-1)
	fend = rs("fend")
	fend = left(fend, instr(fend, " ")-1)
	%>
    <tr>
        <td align="right"><%= nn %> &nbsp; <input name="licencia" type="checkbox" value="<%= rs("licencia") %>" /></td>
        <td><a href="<%= url %>"><%= rs("licencia") %></a></td>
        <td></td>
        <td class="peq"><%= fini %></td>
        <td class="peq"><%= fend %></td>
        <td class="peq" nowrap="nowrap"><%'= rs("http_so") %></td>
    </tr>
	<% rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
%>