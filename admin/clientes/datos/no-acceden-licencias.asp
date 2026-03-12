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

sql = "SELECT * FROM licencias_control WHERE (activo=1 AND ID_EMPRESA>2 AND ultimo_acceso<'" & fecha & "') ORDER BY USUARIO, NOMBRE DESC"

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
        <th style="text-align:left; width:200px;">licencia</th>
        <th style="text-align:left; width:150px;">cliente</th>
        <th style="text-align:left; width:60px;" colspan="2">registrado</th>
        <th style="text-align:left; width:10px;"></th>
        <th style="text-align:left; width:60px;" colspan="2">licencia</th>
        <th style="text-align:right;">&uacute;ltimo acceso</th>
    </tr>
<% 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, session("connPWAcesos")
nn = 0
do while not rs.eof 
	nn=nn+1
	licencias = rs("LICENCIAS_ENVIADAS") & "/" & rs("NUM_LICENCIAS")
	
	url_usuario = "uid=" & rs("id_empresa") & "&u=" & rs("usuario")
	url_licencia = url_usuario & "&lid=" & rs("id") &  "&l=" & rs("nombre")
	%>
	<tr>
		<td><%= nn %></td>
		<td><%= rs("NOMBRE") %></td>
		<td><%= ucase(rs("USUARIO")) %></td>
        <td class="med"><%= rs("FECHA") %></td>
        <td class="med"><%= rs("HORA") %></td>
        
        <td></td>
        
        <td style="text-align:right;"><%= rs("NUMERO_LICENCIA") %></td>
        <td style="text-align:right;" class="peq"><%= licencias %></td>
        
		<td style="text-align:right;"><%= rs("ultimo_acceso") %></td>
	</tr>
    <% rs.movenext
loop 

rs.close
set rs=nothing
%>
</table>
