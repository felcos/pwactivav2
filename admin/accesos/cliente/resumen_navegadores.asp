<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><hr /><%
end if

server.ScriptTimeout=300
'on error resume next

if request.QueryString("procesar")="" then
	procesar = false
else
	procesar = true
end if

cliente = request("u")
cliente_id = request("uid")
licencia = request("l")
licencia_id = request("lid")

if cliente_id="" then
	if cliente="" then
		%>sin datos<%
		response.End()
	else
		sqlW = "cookie_u='" & cliente & "'"
	end if
else
	sqlW = "cookie_uid=" & cliente_id
end if

if licencia_id="" then
	if licencia<>"" then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "cookie_l='" & licencia & "'"
	end if
else
	if sqlW<>"" then sqlW = sqlW & " AND "
	sqlW = sqlW & "cookie_lid=" & licencia_id
end if

sqlW = "(" & sqlW & ")"

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT http_user_agent FROM reg_accesos "
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "GROUP BY http_user_agent"

rs.Open sql, session("connPWAcesos")
%>
<table class="reg" id="tabla" style="margin-bottom:24px;" width="100%">
<tr>
	<td><strong>mozilla</strong></td>
    <% if procesar then %>
    <td><strong>navegador</strong></td>
    <td><strong>so</strong></td>
    <% end if %>
    <td><strong>http_user_agent</strong><span class="peq" style="float:right;"><% if procesar then %><a href="/admin/accesos/cliente/resumen_navegadores.asp?ip=<%= ip %>" target="_blank" id="recargar">http_user_agent</a><% else %><a href="/admin/accesos/cliente/resumen_navegadores.asp?ip=<%= ip %>&procesar=true" target="_blank" id="recargar">procesar</a><% end if %></span></td>
</tr>
<% do while not rs.eof 
	txt = rs("http_user_agent")
	
	mozilla = left(txt, 11)
	txt = trim(mid(txt, 12, len(txt)))
	
	if procesar then
		pos = instr(txt, ")")
		if pos>0 then
			so = mid(txt, 2, pos-2)
			txt = trim(mid(txt, pos+2, len(txt)))
		end if
		
		if instr(lcase(txt), "chrome") then
			pos = instr(lcase(txt), "chrome")
			navegador = mid(txt, pos, len(txt))
			txt = trim(left(txt, pos-1))
		else
			navegador = ""
		end if
	end if
	%>
<tr>
    <td><%= mozilla %></td>
    <% if procesar then %>
    <td><%= navegador %></td>
    <td class="peq"><%= so %></td>
    <% end if %>
    <td class="peq"><%= txt %></td>
</tr>
		<% 
		rs.movenext
	loop
	%>
</table>
<%
rs.close
set rs=nothing

if request.Cookies("dev")("sql")<>"" then
	%><p class="peq"><%= sql %></p><%
end if
%>

<script type="text/javascript">
$(document).ready(function () {
	$('#recargar').click(function(e) {
		
		$.ajax({
			url: this.href,
			data: '',	//$('#frm_accesos').serialize(),
			beforeSend: function() {
				//$('#resumen_navegadores').html('');
				//$('#loading_resumen_navegadores').show();
			},
			success: function(data, status, xhr){
				$('#resumen_navegadores').html(data);
				//$('#loading_resumen_navegadores').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		/*
		$.ajax({
			url: href,
			success: function(data, status, xhr) { 
				//$("#para_ver").html(data); 
				//console.log('bbb'); 
			}
		});
		*/
		// Bind a listener to the "jqplotDataClick" event.  Here, simply change
		// the text of the info3 element to show what series and ponit were
		// clicked along with the data for that point.
		
		/*
		$('#graf').bind('jqplotDataClick', 
			function (ev, seriesIndex, pointIndex, data) {
				$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
			}
		);
		*/
		return false;
    });
});
</script> 

