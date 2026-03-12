<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
select case request.QueryString("ver")
case "7d"
	fecha = dateadd("d", -7, date)
case "15d"
	fecha = dateadd("d", -15, date)
case "1m"
	fecha = dateadd("m", -1, date)
case "3m"
	fecha = dateadd("m", -3, date)
case "6m"
	fecha = dateadd("m", -6, date)
case "1y"
	fecha = dateadd("yyyy", -1, date)
case else
	fecha = dateadd("d", -15, date)
end select
'DateDiff("d", rsAccesos("ultimo_acceso"), txtFecha) > 0
sql = "SELECT * FROM clientes_control WHERE (activo=1 AND ID>2) AND (ultimo_acceso<'" & fecha & "' OR LICENCIAS_ENVIADAS=0 OR ultimo_acceso IS NULL) ORDER BY ultimo_acceso DESC"

linea = false
if request.Cookies("dev")("request")<>"" then
	for each elto in request.QueryString
		%><%= elto %>:<strong><%= request.QueryString(elto) %></strong> &nbsp; <%
	next
	linea = true
end if

if request.Cookies("dev")("sql")<>"" then
	%><p><%= sql %></p><%
	linea = true
end if

if linea then %><hr /><% end if
%>

<table class="reg">
    <tr>
        <th style="text-align:left; width:30px;">nn</td>
        <th style="text-align:left; width:100px;">cliente</th>
        <th style="text-align:left; width:30px;">id</td>
        <th style="text-align:left; width:300px;">empresa</th>
        <th style="text-align:left; width:50px;">licencias</th>
        <th style="text-align:right;">&uacute;ltimo acceso</th>
    </tr>
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, session("connPWAcesos")

nn = 0
do while not rs.eof 
	nn=nn+1
	licencias = rs("NUM_LICENCIAS") & "/" & rs("LICENCIAS_ENVIADAS")
	%>
    <tr>
		<td><%= nn %></td>
		<td><%= rs("EMPRESA") %></td>
        <td><%= rs("ID") %></td>
		<td><%= rs("NOMBRE_EMPRESA") %></td>
        <td style="text-align:right;"><%= licencias %></td>
		<td style="text-align:right;"><%= rs("ultimo_acceso") %></td>
	</tr>
    <% rs.movenext
loop 

rs.close
set rs=nothing
%>
</table>
