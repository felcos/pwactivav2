<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
response.Buffer = False
server.ScriptTimeout=300
%>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css"/>
<%
fecha = request.QueryString("f")
if fecha="" then  fecha=date
%>
<% sub fila(p_fecha) 
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	'reg_articulos
	sql = "SELECT COUNT(*) AS cont FROM reg_articulos WHERE fecha='" & p_fecha & "'"
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_articulos = rs("cont")
	rs.close
	
	sql = "SELECT COUNT(*) AS cont FROM reg_articulos_distintos WHERE fecha='" & p_fecha & "'"
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_articulos_distintos = rs("cont")
	rs.close
	
	
	
	'reg_accesos
	sqlF = "(session_start>='" & p_fecha & "' AND session_start<'" & dateadd("d", 1, p_fecha) & "')"
	
	sql = "SELECT COUNT(*) AS cont FROM reg_accesos WHERE " & sqlF 
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_accesos = rs("cont")
	rs.close
	
	sql = "SELECT COUNT(*) AS cont FROM reg_accesos WHERE (cliente_id IS NULL AND " & sqlF & ")"
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_accesos_null = rs("cont")
	rs.close
	
	'reg_pags
	sqlF = "(date>='" & p_fecha & "' AND date<'" & dateadd("d", 1, p_fecha) & "')"
	
	sql = "SELECT COUNT(*) AS cont FROM reg_pags WHERE " & sqlF 
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_pags = rs("cont")
	rs.close
	
	sql = "SELECT COUNT(*) AS cont FROM reg_pags WHERE (cookie_u='' AND " & sqlF & ")"
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	reg_pags_null = rs("cont")
	rs.close
	
%>
<div class="fila">
    <div class="reg_fecha"><a href="/admin/accesos/fecha.asp?f=<%= p_fecha %>" ><%= p_fecha %>, <%=  WeekdayName(DatePart("w", p_fecha)) %></a></div>
    <div class="reg_col"><%= reg_articulos_distintos %></div>
    <div class="reg_col_p"><%= reg_articulos %></div>
    <div class="reg_col"><%= reg_accesos %></div>
    <div class="reg_col"><%= reg_accesos_null %></div>
    <div class="reg_col"><%= reg_pags %></div>
    <div class="reg_col"><%= reg_pags_null %></div>
</div>
<script type="text/javascript">
serie_articulos.push(['<%= p_fecha %>', <%= reg_articulos %>]);
serie_articulos_distintos.push(['<%= p_fecha %>', <%= reg_articulos_distintos %>]);
</script>
	<% 
	
	set rs = nothing
end sub %>

<%
jj_control = 10

jj = 0
ff=fecha
do 
	jj=jj+1
	%><script type="text/javascript">console.log('fila: <%= p_fecha %>.')</script><%
	
	call fila(ff)
	
	ff=DateAdd("d", -1, ff)
	if DatePart("w", ff)=1 then exit do
	if jj=jj_control then exit do
loop
%>
<script type="text/javascript">	
$(document).ready(function() { 
	$('#div_mas').html('<a href="/admin/accesos/semana.asp?f=<%= ff %>" class="carga_mas">siguientes</a>'); 
	
	$(".carga_mas").click(function() {
		var start = new Date().getTime();
		var href=this.href;
		console.log(href);
		
		$.ajax({
			url: href,
			beforeSend: function () {
				$("#div_mas").html('<img src="/img/ajax-loader.gif"/>')
			},
			success: function(data, status, xhr) {
				$("#div_mas").before(data);
				var end = new Date().getTime();
				console.log((end-start)/1000);
			}
		});
		
		return false;
	});
	
});
</script>
