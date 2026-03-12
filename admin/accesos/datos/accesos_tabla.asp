<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/dev/inc_funciones.asp" -->
<style type="text/css">

td.details-control {
	background: url("/lib/data-tables/images/details_open.png") no-repeat center center;
	cursor: pointer;
}
tr.shown td.details-control {
	background: url("/lib/data-tables/images/details_close.png") no-repeat center center;
}
</style>
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

FechaI = request("Fecha")
FechaI = date
FechaF = DateAdd("d", 1, FechaI)

select case request("ver")
case "conlicencia"
	sql = "cookie_lid IS NOT NULL"
case "sinlicencia"
	sql = "cookie_lid IS NULL"
case else
	sql = ""
end select
if sql<>"" then sql = " AND (" & sql & ")"

sql = "session_start>='" & FechaI & "' AND session_start<'" & FechaF & "'" & sql

sql = "SELECT * FROM reg_accesos WHERE (" & sql & ") ORDER BY session_start DESC"

'test_inyeccion_sql sql

rs.Open sql, session("connPWAcesos")

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><hr /><%
end if
%>

<table width="100%" class="display compact" id="tblAccesos">
<thead>
  <tr>
    <th>nn</th>
    <th>fecha</th>
    <th>hora</th>
    
    <th>a.c.</th>
    
    <th>session_id</th>
    
    <th>cliente</th>
    <th>licencia</th>
    
    <th>IP</th>
    <th>navegador</th>
    <th>SO</th>
    
    <th></th>
  </tr>
</thead>
<tbody>
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
		
		'links
		link_reg_pags = "/admin/accesos/datos/session.asp?session_id=" & rs("session_id")
		link_cliente = "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u")
		link_licencia =  "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u") & "&lid=" & rs("cookie_lid") & "&l=" & rs("cookie_l")
		%>
<tr>
	<td><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= nn %></a></td>
    <td><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= fecha %></a></td>
    <td><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= hora %></a></td>
    <td><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= login %></a></td>
    <td><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%=rs("session_id")  %></a></td>
    <td><a href="<%= link_cliente %>" target="_blank"><%= rs("cookie_u") %> <span class="mini"><%= rs("cookie_uid") %></span></a></td>
    <td><a href="<%= link_licencia %>" target="_blank"><%= rs("cookie_l") %> <span class="mini"><%= rs("cookie_lid") %></span></a></td>
    
    <td><%= rs("http_ip") %></td>
    <%
	navegador = "" & rs("http_navegador")
	if navegador="" then navegador = "<span class='destaca'>" & calcular_http_navegador(rs("http_user_agent")) & "</span>"
	'if navegador="" then navegador = calcular_http_navegador(rs("http_user_agent"))
	
	so = "" & rs("http_so")
	if so="" then so = "<span class='destaca'>" & calcular_http_so(rs("http_user_agent")) & "</span>"
	%>
    <td><%= navegador %></td>
    <td><%= so %></td>
    <td></td>
</tr>
	<% rs.movenext
loop
%>
</tbody>
</table>
<%
rs.close
set rs=nothing
%>
<script type="text/javascript" language="javascript" class="init">
$(document).ready(function() {
	$('#contador_accesos').html('(<%= nn %>)');
	
	if ($.fn.dataTable.isDataTable("#tblAccesos")) {
		console.log("$('#tblAccesos').DataTable().destroy()");
		$("#tblAccesos").DataTable().destroy();
	};
	
	var tblAccesos = $("#tblAccesos").DataTable({
		"paging":   false,
        "ordering": true,
        "info":     true,
		
		"scrollY": "350px",
        "scrollCollapse": true,
		
		"columns": [
			{ "name": "nn", "sWidth": "25px" },
			{ "name": "fecha", "sWidth": "65px" },
			{ "name": "hora", "sWidth": "55px" },
			{ "name": "condiciones", "sWidth": "80px" },
			
			{ "name": "session_id", "visible": false },
			
			{ "name": "cliente", "sWidth": "150px" },
			{ "name": "licencia" },
			{ "name": "ip", "sWidth": "90px" },
			{ "name": "navegador", "sWidth": "120px" },
			{ "name": "so", "sWidth": "120px" },
			{ 	"className":      "details-control",
				"orderable":      false,
				"data":           null,
				"defaultContent": "", 
				"sWidth": "20px"
			
			 }
		  ]
	});
	
	$('#tblAccesos tbody').on('click', 'td.details-control', function () {
		var tr = $(this).closest('tr');
		var row = tblAccesos.row( tr );
		
		if ( row.child.isShown() ) {
			// This row is already open - close it
			row.child.hide();
			tr.removeClass('shown');
		}
		else {
			// Open this row
			row.child( format(row.data()) ).show();
			tr.addClass('shown');
		}
	});
});
/* Formatting function for row details - modify as you need */
function format ( d ) {
// `d` is the original data object for the row
return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
	'<tr>'+
		'<td>id:</td>'+
		'<td>'+d[0]+'</td>'+
	'</tr>'+
	'<tr>'+
		'<td>SessionId:</td>'+
		'<td>'+d[4]+'</td>'+
	'</tr>'+
	'</table>';
}
</script>

