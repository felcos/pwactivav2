<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
server.ScriptTimeout=600
'on error resume next

starttime = Timer() 

for each elto in request.Form
	%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
next

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM reg_articulos WHERE YEAR(fecha)=2015"		' WHERE ID>470279
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
    <th style="width:45px;">id</th>
    <th style="width:75px;">fecha</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:10px;"></th>
    <th style="width:75px; text-align:left;">session_id</th>
    
    <th style="width:30px; text-align:left;">tipo</th>
    <th style="width:45px; text-align:left;">id art.</th>
    
    <th style="width:10px;"></th>
    <th style="width:150px; text-align:left;">cliente</th>
    <th style="width:300px; text-align:left;">licencia</th>
    <th style="text-align:left;">-</th>
  </tr>
<%
duplicados = ""
inexistentes = ""
articulos = "#"
nn = 0
duplicados_n = 0
articulos_n=0

do while not rs.eof 
	nn = nn+1
	hora = rs("hora")
	hora = mid(hora, instr(hora, " ")+1, len(hora))
	
	articulo = rs("articulo_tipo") & rs("articulo_id") & "_" & rs("session_id")
	if instr(articulos, "#" & articulo & "#") then
		if duplicados<>"" then duplicados = duplicados & ", "
		duplicados = duplicados & rs("id")
		duplicados_n = duplicados_n + 1
		articulo_ver = articulo
		%>
<tr>
	<td class="dra"><%= nn %></td>
    <td class="dra peq"><%= rs("id") %></td>
    <td class="dra"><%= rs("fecha") %></td>
    <td class="dra"><%= hora %></td>
    
    <td></td>
    <td><%= rs("session_id") %></td>
    <td><%= rs("articulo_tipo") %></td>
    <td class="dra"><%= rs("articulo_id") %></td>
    <td></td>
    <td><%= rs("cliente") %> <span class="peq"><%= rs("id_cliente") %></span></td>
    <td><%= rs("licencia") %> <span class="peq"><%= rs("id_licencia") %></span></td>
    
    <td><%= articulo_ver %></td>
</tr>
		<%
	else
		articulos = articulos & articulo & "#"
		articulos_n = articulos_n + 1
	end if
	 
	if duplicados_n>=1000 then		'>=2500 then 
		%>
<tr>
	<td colspan="12">hay mas...</td>
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
set rsArt=nothing

endtime = Timer() 
%>
<hr />
<li>tiempo: <%= FormatNumber((endtime-starttime),1 ) %> seg.</li>
<% if inexistentes<>"" then %>
<li>inexistentes: <%= inexistentes %></li>
<% end if %>
<li>articulos visitados: <%= articulos_n %></li>
<li>duplicados: <%= duplicados_n %></li>
<hr />
<script language="javascript">	
$(document).ready(function(){
	<% if duplicados<>"" then %>
		$('#duplicados').val('<%= duplicados %>');
		$('#cmd_duplicados').removeAttr("disabled");
		$('#timming').html('<%= FormatNumber((endtime-starttime),1 ) %> seg.');
	<% end if %>
});
</script>

