<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
<div class="tabla">
<div class="fila">
	<div class="accesos_icon tit"></div>
    <div class="accesos_id tit">id</div>
    
    <div class="accesos_fecha tit">fecha<% 'call div_orden("null") %></div>
    <div class="accesos_hora tit">hora<% 'call div_orden("null") %></div>
    <div class="accesos_hora_logout tit">out<% 'call div_orden("null") %></div>
    
    <div class="accesos_session_usuario tit">session_usuario<% 'call div_orden("dir") %></div>
    <div class="accesos_session_nombre tit">session_nombre<% 'call div_orden("null") %></div>
    <div class="accesos_remote_host tit">remote_host<% 'call div_orden("superf") %></div>
    <div class="accesos_xx tit">xx.<% 'call div_orden("fecha") %></div>
    <div class="accesos_session_start tit">session_start<% 'call div_orden("titulo") %></div>
</div>

<%
f_desde = "01/12/2014"
sql = "SELECT TOP(100) * FROM reg_accesos WHERE session_start>=CONVERT(DATETIME, '" & f_desde & "', 103)"
'" AND session_start<=CONVERT(DATETIME, '" & f_hasta & "', 103)"	
sql = sql & " ORDER BY id DESC"

Set rs = Server.CreateObject("ADODB.Recordset")
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos")	', 1, 1

nn = 0

do while not rs.eof 
	nn=nn+1
	ff = rs("session_start")
	fecha_ini = mid(ff, 1, instr(ff, " ")-1)
	hora_ini = mid(ff, instr(ff, " ")+1, len(ff)-instr(ff, " "))
%>
<div class="fila">
	<div class="accesos_icon">+</div>
	<div class="accesos_num"><%= nn %></div>
    
    <div class="accesos_fecha"><%= fecha_ini %></div>
    <div class="accesos_hora"><%= hora_ini %></div>
    <div class="accesos_hora_logout"><%= hora_out %></div>
    
    <div class="accesos_session_usuario"><%= rs("session_usuario") %></div>
    <div class="accesos_session_nombre"><%= rs("session_nombre") %></div>
    <div class="accesos_remote_host"><%= rs("remote_host") %></div>
    
    <div class="accesos_xx">xx</div>
    
    <div class="accesos_session_start"><%= rs("session_start") %></div>
    
</div>
	<% rs.movenext
loop %>
</div>
