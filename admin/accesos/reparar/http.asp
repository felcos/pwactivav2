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

FechaI = request.QueryString("FechaI")
FechaF = request.QueryString("FechaF")

select case request("var_http")
case "so"
	sql = "(http_so IS NULL OR http_so = '')"
	var = "Sist.Op."
	
case "mozilla"
	sql = "(http_mozilla IS NULL OR http_mozilla = '')"
	var = "Mozilla"
	
case "navegador"
	sql = "(http_navegador IS NULL OR http_navegador = '')"
	var = "Navegador"
	
end select

sql = "(session_start>='" & FechaI & "' AND session_start<'" & FechaF & "') AND " & sql
sql = "SELECT * FROM reg_accesos WHERE (" & sql & ") ORDER BY session_start"

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
    
    <th style="width:10px;"></th>
    <th style="width:60px;">session_id</th>
    <th style="width:10px;"></th>
    
    <th style="width:200px; text-align:left;">licencia</th>
    
    <th style="text-align:left; width:90px;">IP</th>
    <th style="text-align:left; width:75px;">mozilla</th>
    <th style="width:10px;"></th>
    
    <th style="text-align:left; width:120px;"><%= var %></th>
    <th style="text-align:left; width:120px;">[calc]</th>
    
    <th style="text-align:left; width:40px;"></th>
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
		
		select case request("var_http")
		case "so"
			valor = rs("http_so")
			
		case "mozilla"
			valor = rs("http_mozilla")
			
		case "navegador"
			valor = rs("http_navegador")
			
		end select
		%>
<tr>
	<td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= nn %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= fecha %></a></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%= hora %></a></td>
    <td></td>
    <td class="dra"><a href="<%= link_reg_pags %>" class="ver_reg_pags" id="<%= rs("session_id") %>"><%=rs("session_id")  %></a></td>
    <td></td>
    <td nowrap="nowrap"><a href="<%= link_licencia %>" target="_blank"><%= rs("cookie_l") %> <span class="mini"><%= rs("cookie_lid") %></span></a></td>
    
    <td class="med"><%= rs("http_ip") %></td>
    <td class="peq"><%= rs("http_mozilla") %></td>
    
    <td></td>
    
    <td><%= valor %></td>
    <td class="peq"><%= valor_calc %></td>
    
    <td class="peq" align="right"> <a href="#" class="ver_detalles" id="<%= rs("session_id") %>">+ info</a></td>
</tr>
<tr id="row_<%= request("var_http") %>_<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="13" id="session_<%= rs("session_id") %>"></td>
</tr>
<tr id="rowinfo_<%= request("var_http") %>_<%= rs("session_id") %>" style="display:none; background-color:#EEEEEE;">
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
		
		var fila=document.getElementById('rowinfo_<%= request("var_http") %>_'+id);
		
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
		
		var fila=document.getElementById('row_<%= request("var_http") %>_'+id);
		
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