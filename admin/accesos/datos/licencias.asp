<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/dev/inc_funciones.asp" -->
<% if request.Cookies("dev")("request")<>"" then %>
    <p class="peq"><strong>QueryString</strong> &nbsp; <%
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

if sql<>"" then sql = " AND (" & sql & ")"

sql = "session_start>='" & FechaI & "' AND session_start<'" & FechaF & "'" & sql

sql = "SELECT cookie_uid, cookie_u, cookie_l, COUNT(id) AS accesos, COUNT(DISTINCT session_id) AS sesiones FROM reg_accesos WHERE (" & sql
sql = sql & ") GROUP BY cookie_uid, cookie_u, cookie_l ORDER BY cookie_u"

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
    <th style="text-align:left;">licencia</th>
    <th style="width:200px; text-align:left;">cliente</th>
    <th style="width:10px;"></th>
    <th style="text-align:left; width:60px;">sesiones</th>
    <th style="text-align:left; width:60px;">accesos</th>
    <th style="text-align:left; width:35px;"></th>
  </tr>
<%
	nn = 0
	do while not rs.eof 
		nn = nn+1
		
		'links
		link_reg_pags = "xxx" '& rs("session_id")
		link_cliente = "xxx" '& rs("cookie_uid") & "&u=" & rs("cookie_u")
		link_licencia =  "xxx" '& rs("cookie_uid") & "&u=" & rs("cookie_u") & "&lid=" & rs("cookie_lid") & "&l=" & rs("cookie_l")
		link_detalles = ""
		%>
<tr>
	<td class="dra"><a href="<%= link_reg_pags %>" class="licencia_ver_pags" id="<%= rs("cookie_uid") %>"><%= nn %></a></td>
    <td></td>
    <td><a href="<%= link_cliente %>" target="_blank"><%= rs("cookie_l") %></a></td>
    <td><a href="<%= link_cliente %>" target="_blank"><%= rs("cookie_u") %> <span class="mini"><%= rs("cookie_uid") %></span></a></td>
    <td></td>
    <td><%= rs("sesiones") %></td>
    <td><%= rs("accesos") %></td>
    <td class="peq" align="right"><a href="#" class="licencia_ver_detalles" id="<%= nn %>"> + info</td>
</tr>
<tr id="licencia_row<%= nn %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="8" id="licencia_<%= nn %>"></td>
</tr>
<tr id="licencia_rowinfo<%= nn %>" style="display:none; background-color:#EEEEEE;">
	<td colspan="8" id="licencia_info_<%= nn %>" class="peq">
<p>licencia_rowinfo<%= nn %></p>
<p>licencia_info_<%= nn %></p>
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
	$('#contador_licencias').html('(<%= nn %>)');
});
</script>
<script language="javascript">	
$(document).ready(function(){
	$('.licencia_ver_detalles').click(function (e) {
		var id=this.getAttribute("id");
		var fila=document.getElementById('licencia_rowinfo'+id);
		
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
	$('.licencia_ver_pags').click(function (e) {
		var id=this.getAttribute("id");
		
		var fila=document.getElementById('licencia_row'+id);
		
		if (fila.style.display=='') {
			fila.style.display='none';
		} else {
			fila.style.display='';
		};
		
		var ncelda='#licencia_'+id;
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