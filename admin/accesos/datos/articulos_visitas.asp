<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
on error resume next

starttime = Timer() 

FechaI = request("f")
FechaF = DateAdd("d", 1, FechaI)

Set rs = Server.CreateObject("ADODB.Recordset")
Set rsArt = Server.CreateObject("ADODB.Recordset")

if request.Cookies("dev")("request")<>"" then 
	if request.QueryString<>"" then %>
        <p>QueryString: &nbsp; <%
        for each elto in request.QueryString
            %><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
        next
        %></p><%
	end if
	if request.Form<>"" then
		%><p>Form: &nbsp; <%
		for each elto in request.Form
			%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
		next
		%></p><%
	end if
	%><hr /><%
end if

sql = "(fecha>='" & FechaI & "' AND fecha<'" & FechaF & "') AND "
sql = sql & "(articulo_tipo='" & request.QueryString("t") & "' AND articulo_id=" & request.QueryString("id") & ")"

sql = "SELECT * FROM reg_articulos WHERE (" & sql & ") ORDER BY id DESC"	'		fecha DESC, hora DESC"

rs.Open sql, session("connPWAcesos") 

if request.Cookies("dev")("sql")<>"" then %>
	<p class="med"><%= sql %></p>
	<hr /><%
end if
%>
<table width="100%" class="reg">
  <tr>
    <th style="width:30px; text-align:right;">nn</th>
    <th style="width:50px;">id</th>
    <th style="width:80px;">fecha</th>
    <th style="width:60px;">hora</th>
    
    <th style="width:20px;"></th>
    <th style="width:220px; text-align:left;">cliente</th>
    <th style="text-align:left;">licencia</th>
    
  </tr>
<%
inexistentes = ""
articulos = "#"
nn = 0
articulos_n=0

do while not rs.eof 
	nn = nn+1
	hora = rs("hora")
	hora = mid(hora, instr(hora, " ")+1, len(hora))
	
	url = "uid=" & rs("id_cliente") & "&u=" & rs("cliente") & "&lid=" & rs("id_licencia") & "&l=" & rs("licencia")	
	
	%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra peq"><%= rs("id") %></td>
    <td class="dra"><%= rs("fecha") %></td>
    <td class="dra"><%= hora %></td>
    
    <td></td>
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url %>" target="_blank"><%= rs("cliente") %> <span class="mini"><%= rs("id_cliente") %></span></a></td>
    <td nowrap="nowrap"><a href="/admin/accesos/cliente/?<%= url %>" target="_blank"><%= rs("licencia") %> <span class="mini"><%= rs("id_licencia") %></span></a></td>
</tr>
	<% 
	rs.movenext
loop
%>
</table>


<%
rs.close

'total
sql = "articulo_tipo='" & request.QueryString("t") & "' AND articulo_id=" & request.QueryString("id")
sql = "SELECT COUNT(*) AS total FROM reg_articulos WHERE (" & sql & ")"
rs.Open sql, session("connPWAcesos") 
%>
<p style="margin-top:10px;">Total visitas: <%= rs("total") %></p>
<%
if request.Cookies("dev")("sql")<>"" then %>
	<hr /><p class="med"><%= sql %></p><%
end if
rs.close


set rs=nothing
set rsArt=nothing

endtime = Timer() 
%>


