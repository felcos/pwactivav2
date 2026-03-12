<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/dev/inc_funciones.asp" -->
<% 
'if request.Cookies("dev")("request")<>"" then
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
'end if

'server.ScriptTimeout=300

Set rs = Server.CreateObject("ADODB.Recordset")

FechaI = "20/03/2015"
FechaF = DateAdd("d", 1, FechaI)

sql = "session_start>='" & FechaI & "' AND (http_so IS NULL OR http_so = '')"
'sql = "session_start>='" & FechaI & "' AND session_start<'" & FechaF & "'" & sql
sql = "SELECT * FROM reg_accesos WHERE (" & sql & ") ORDER BY session_start DESC"

'test_inyeccion_sql sql

rs.Open sql, session("connPWAcesos")

'if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
'end if
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
    
    <th style="width:100px; text-align:left;">cliente</th>
    <th style="width:250px; text-align:left;">licencia</th>
    
    <th style="text-align:left; width:80px;">IP</th>
    <th style="text-align:left; width:85px;">navegador</th>
    <th style="text-align:left; width:80px;">SO</th>
    
    <th style="text-align:left; width:30px;"></th>
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
		
		'links
		link_reg_pags = "/admin/accesos/datos/session.asp?session_id=" & rs("session_id")
		link_cliente = "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u")
		link_licencia =  "/admin/accesos/cliente/?uid=" & rs("cookie_uid") & "&u=" & rs("cookie_u") & "&lid=" & rs("cookie_lid") & "&l=" & rs("cookie_l")
		%>
<tr>
	<td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= nn %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= fecha %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= hora %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= login %></a></td>
    <td></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%=rs("session_id")  %></a></td>
    <td></td>
    <td><a href="<%= link_cliente %>" target="_blank"><%= rs("cookie_u") %> <span class="mini"><%= rs("cookie_uid") %></span></a></td>
    <td nowrap="nowrap"><a href="<%= link_licencia %>" target="_blank"><%= rs("cookie_l") %> <span class="mini"><%= rs("cookie_lid") %></span></a></td>
    
    <td class="med"><%= rs("http_ip") %></td>
    <%
	navegador = "" & rs("http_navegador")
	if navegador="" then navegador = "<span class='destaca'>" & calcular_http_navegador(rs("http_user_agent")) & "</span>"
	'if navegador="" then navegador = calcular_http_navegador(rs("http_user_agent"))
	
	so = "" & rs("http_so")
	if so="" then so = "<span class='destaca'>" & calcular_http_so(rs("http_user_agent")) & "</span>"
	%>
    <td><%= navegador %></td>
    <td class="peq"><%= so %></td>
    <td class="peq" align="right"> <a href="#" class="ver_detalles" id="<%= rs("session_id") %>">+ info</a></td>
</tr>
<tr id="row<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="13" id="session_<%= rs("session_id") %>"></td>
</tr>
<tr id="rowinfo<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="13" id="info_<%= rs("session_id") %>" class="peq">
<p><%= rs("http_user_agent") %></p>
<br />
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
	$('#contador_accesos').html('(<%= nn %>)');
});
</script>
<script language="javascript">	
$(document).ready(function(){
	$('.ver_detalles').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('rowinfo'+id);
		
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
	$('.ver_reg_pags').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('row'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
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
		
		//console.log($(celda).html());
		return false;
	})
})
</script>