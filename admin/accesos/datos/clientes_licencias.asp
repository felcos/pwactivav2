<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/dev/inc_funciones.asp" -->
<% 
if request.Cookies("dev")("request")<>"" then
	%><p class="peq"><strong>QueryString</strong> &nbsp; <%
	for each elto in request.QueryString
		%><%= elto %>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p class="peq"><strong>Form</strong>: &nbsp; <%
	for each elto in request.Form
		%><%= elto %>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><hr /><%
end if

server.ScriptTimeout=300

Set rs = Server.CreateObject("ADODB.Recordset")

FechaI = request("Fecha")
FechaF = DateAdd("d", 1, FechaI)

sql = "SELECT reg_accesos.cookie_l, reg_accesos.cookie_lid, COUNT(DISTINCT reg_accesos.id) AS accesos, COUNT(DISTINCT reg_pags.id) AS pags, COUNT(DISTINCT reg_articulos.id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "RIGHT OUTER JOIN reg_accesos ON reg_articulos.session_id = reg_accesos.session_id "
sql = sql & "LEFT OUTER JOIN reg_pags ON reg_accesos.session_id = reg_pags.session_id "
sql = sql & "WHERE ("
sql = sql & "(reg_accesos.session_start>='" & FechaI & "' AND reg_accesos.session_start<'" & FechaF & "') AND "
sql = sql & "(reg_accesos.cookie_uid=" & request("uid") & ")"
sql = sql & ") "
sql = sql & "GROUP BY reg_accesos.cookie_l, reg_accesos.cookie_lid "
sql = sql & "ORDER BY reg_accesos.cookie_l"

'test_inyeccion_sql sql

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
%>
<table width="100%" class="reg" style="margin-bottom:.6em; background-color:#F5F5F5; font-size:.85em;">
<% IF 1=2 THEN %>
<thead>
  <tr>
    <th></th>
    <th>nn</th>
    <th></th>
    <th style="text-align:left;">licencia</th>
    <th></th>
    <th style="text-align:right;">articulos</th>
    <th style="text-align:right;">accesos</th>
    <th style="text-align:right;">pags</th>
    <th></th>
    <th></th>
  </tr>
</thead>
<% END IF %>
<tbody>
	<%
	suma_articulos = 0
	suma_accesos = 0
	suma_pags = 0
	nn = 0
	do while not rs.eof 
		nn = nn+1
		
		suma_articulos = suma_articulos + rs("articulos")
		suma_accesos = suma_accesos + rs("accesos")
		suma_pags = suma_pags + rs("pags")
		
		link_licencia = "/admin/accesos/cliente/?"
		link_licencia = link_licencia & "uid=" & request("uid") & "&"
		link_licencia = link_licencia & "u=" & request("u") & "&"
		'link_licencia = link_licencia & "lid=" & rs("cookie_lid") & "&"
		link_licencia = link_licencia & "l=" & rs("cookie_l")
		%>
<tr>
	<td style="width:20px;"></td>
    
    <td style="width:25px;" class="dra"><a href="<%= link_licencia %>" id="<%= rs("cookie_l") %>" target="_blank"><%= nn %></a></td>
    <td style="width:10px;"></td>
    <td><a href="<%= link_licencia %>" target="_blank"><%= rs("cookie_l") %></a></td>
    <td style="width:50px;"></td>
    <td style="width:100px;" align="right"><%= rs("articulos") %> &nbsp; </td>
    <td style="width:100px;" align="right"><%= rs("accesos") %> &nbsp; </td>
    <td style="width:100px;" align="right"><%= rs("pags") %> &nbsp; </td>
    <td style="width:40px;"></td>
    <td style="width:40px;" class="mini" align="right"><a href="#"> + info</a>&nbsp;</td>
</tr>
	<% rs.movenext
loop
%>
</tbody>
<tfoot>
  <tr style="background-color:#FFF; border-bottom:0;">
    <th></th>
    <th></th>
    <th></th>
    <th></th>
    <th></th>
    <th align="right"><%= suma_articulos %> &nbsp; </th>
    <th style="text-align:right;"><%= suma_accesos %> &nbsp; </th>
    <th style="text-align:right;"><%= suma_pags %> &nbsp; </th>
    <th>&nbsp;</th>
    <th>&nbsp;</th>
  </tr>
</tfoot>
</table>
<%
rs.close
set rs=nothing
%>
