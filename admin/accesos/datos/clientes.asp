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

f = split(FormatDateTime(request("Fecha")), "/")
Fecha = f(2) & "-" & f(1) & "-" & f(0)

select case request("ver")
case "conlicencia"
	sql = "cookie_lid IS NOT NULL"
case "sinlicencia"
	sql = "cookie_lid IS NULL"
case else
	sql = ""
end select
if sql<>"" then sql = sql & " AND "

sql = sql & "cookie_u <> ''"
sql = " AND (" & sql & ")"

sql = "(session_start>='" & FechaI & "' AND session_start<'" & FechaF & "')" & sql

sql = "SELECT cookie_uid AS uid, cookie_u AS u, COUNT(id) AS accesos, COUNT(DISTINCT cookie_l) AS licencias FROM reg_accesos WHERE (" & sql
sql = sql & ") GROUP BY cookie_uid, cookie_u ORDER BY cookie_u"

sql = "SELECT * FROM regClientes('" & Fecha & "', '" & Fecha & "') ORDER BY u"

'test_inyeccion_sql sql

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if

rs.Open sql, session("connPWAcesos")
%>
<hr />
<table width="100%" class="reg">
  <tr>
    <th style="width:25px;">nn</th>
    <th style="width:10px;"></th>
    <th style="text-align:left;">cliente</th>
    <th style="text-align:left;width:180px;">&nbsp;</th>
    <th style="text-align:right; width:80px;">licencias</th>
    <th style="width:220px;"></th>
    <th style="text-align:right; width:100px;">articulos</th>
    <th style="text-align:right; width:100px;">accesos</th>
    <th style="text-align:right; width:100px;">pags.</th>
    <th style="text-align:right; width:40px;"></th>
    <th style="text-align:left; width:40px;"></th>
  </tr>
<%
	nn = 0
	do while not rs.eof 
		nn = nn+1
		'links
		link_ver_licencias = "/admin/accesos/datos/clientes_licencias.asp?Fecha=" & FechaI & "&uid=" & rs("uid") & "&u=" & rs("u") & "&n=" & nn
		link_cliente = "/admin/accesos/cliente/?uid=" & rs("uid") & "&u=" & rs("u")
		link_licencia =  "xxx" '& rs("cookie_uid") & "&u=" & rs("cookie_u") & "&lid=" & rs("cookie_lid") & "&l=" & rs("cookie_l")
		link_detalles = ""
		%>
<tr>
	<td class="dra"><a href="<%= link_ver_licencias %>" class="cliente_ver_licencias" id="<%= nn %>"><%= nn %></a></td>
    <td></td>
    <td><a href="<%= link_ver_licencias %>" class="cliente_ver_licencias" id="<%= nn %>"><%= rs("u") %> &nbsp; <span class="mini"><%= rs("uid") %></span></a></td>
    <td><a href="<%= link_cliente %>" class="mini">cliente</a></td>
    <td align="right"><a href="<%= link_ver_licencias %>" class="cliente_ver_licencias" id="<%= nn %>"><%= rs("licencias") %></a> &nbsp; </td>
    <td></td>
    <td align="right"><%= rs("articulos") %> &nbsp; </td>
    <td align="right"><%= rs("accesos") %> &nbsp; </td>
    <td align="right"><%= rs("pags") %> &nbsp; </td>
    <td></td>
    <td class="peq" align="right"><a href="#" class="cliente_ver_detalles" id="<%= nn %>"> + info</td>
</tr>
<tr id="row_cliente_licencias_<%= nn %>" style="display:none;">
	<td colspan="11" id="cliente_<%= nn %>" style="padding:0; margin:0;"></td>
</tr>
<tr id="row_cliente_info_<%= nn %>" style="display:none;">
	<td colspan="11" id="cliente_info_<%= nn %>" class="peq">
<p>row_cliente_info_<%= nn %></p>
<p>cliente_info_<%= nn %></p>
    </td>
</tr>
	<% rs.movenext
loop
%>
</table>
<%
rs.close
set rs=nothing
%>
<script language="javascript">	
$(document).ready(function(){
	$('#contador_clientes').html('(<%= nn %>)');
	
	$('.cliente_ver_detalles').click(function (e) {
		var id=this.getAttribute("id");
		var fila=document.getElementById('row_cliente_info_'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		/*
		var ncelda='#session_'+id;
		var celda = $(ncelda);
		
		if (celda.html()=='') {
			$.ajax({
				url: this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		*/
		return false;
	})
	$('.cliente_ver_licencias').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('row_cliente_licencias_'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		var ncelda='#cliente_'+id;
		var celda = $(ncelda);
		
		if (celda.html()=='') {
			$.ajax({
				url: this.getAttribute("href"),
				data: '',
				beforeSend: function() {
					celda.html('<img src="/img/camera-loader.gif">');
				},
				success: function(data, status, xhr){
					celda.html(data);
				},
				error: function(xhr, status, err) {}
			});
		}
		
		//console.log($(celda).html());
		return false;
	})
})
</script>
