<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
ver_sql = false
ver_resumen = false
ver_indice = false

'generando_report = false
generando_report = true
modo_report = true
'if request.Form("presentacion")="informe" >>> modo_report

idMapa = 0

if request.QueryString("ver_sql")<>"" then ver_sql = true end if
if request.QueryString("ver_resumen")<>"" then ver_resumen = true end if
if request.QueryString("ver_indice")<>"" then ver_indice = true end if

dim resultado
fecha = request.QueryString("f")
desde = "CONVERT(DATETIME, '" & year(fecha) & "-" & month(fecha) & "-" & day(fecha) & " 00:00:00', 102)"
'
if request.QueryString("fto")="" then
	hasta=desde
else
	fecha = request.QueryString("fto")
	hasta = "CONVERT(DATETIME, '" & year(fecha) & "-" & month(fecha) & "-" & day(fecha) & " 00:00:00', 102)"
end if
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="/_inc/jm/estilos.css" rel="stylesheet" type="text/css">
    <link href="/mailing/report/leer_jm.css" rel="stylesheet" type="text/css">
    <link href="/mailing/report/css_jm.css" rel="stylesheet" type="text/css">
	<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria - <%= fecha %><% if hasta<>desde then %><%= hasta %><% end if %></title>
    <!--#include virtual="/inc/reg_accesos.asp" -->
    <!--#include virtual="/lib/funciones.asp" -->
    
    <!--#include virtual="/articulos/sin_acceso.asp" -->
    <!--#include virtual="/articulos/contenido/noticia.asp" -->
    <!--#include virtual="/articulos/contenido/rumor.asp" -->
    <!--#include virtual="/articulos/contenido/estudio.asp" -->
    <!--#include virtual="/articulos/contenido/demanda.asp" -->
    <!--#include virtual="/articulos/contenido/operacion_OLD.asp" -->
    <!--#include virtual="/articulos/contenido/subasta.asp" -->
    <!--#include virtual="/articulos/contenido/vencimientos.asp" -->
	<% if not generando_report then %>
    <script src="/js/jquery.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX-HAhl6u-wxBKLQO31nH4vMUQ3w8cEoU&sensor=false"></script>
	<% end if %>
</head>
<body>
<h2>Contenidos PropertyWeb - <%= fecha %></h2>
<div id="main_read">
<% if  ver_indice then %>
	<!--#include virtual="/mailing/report/indice.asp" -->
    <hr>
<% end if %>
<% 'Noticias		
if request.QueryString("actualidad")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	sqlNot = sql
	contNot = 0
	idsNot = ""
	do while not resultado.eof 
		call VerNoticia(resultado)
		
		if idsNot <> "" then idsNot = idsNot & ", "
		idsNot = idsNot & "<a href='#not" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contNot = contNot + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Rumores			
if request.QueryString("rumores")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='W' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	sqlRum = sql
	contRum = 0
	idsRum = ""
	do while not resultado.eof 
		call VerRumor(resultado)
		
		if idsRum <> "" then idsRum = idsRum & ", "
		idsRum = idsRum & "<a href='#web" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contRum = contRum + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Estudios		
if request.QueryString("estudios")<>"" then 
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='E' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql) 
	sqlEst = sql
	contEst = 0
	idsEst = ""
	do while not resultado.eof 
		call VerEstudio(resultado)
		
		if idsEst <> "" then idsEst = idsEst & ", "
		idsEst = idsEst & "<a href='#est" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contEst = contEst + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Operaciones		
if request.QueryString("operaciones")<>"" then
	sqlWop = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sqlWop = sqlWop & " AND ID_PAIS=1"
	end if
	'sqlWop = sqlWop & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sqlWop = sqlWop & " AND ((FECHA_PUBLICACION BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	
	sql = "SELECT *, CASE WHEN ID_PAIS = 1 THEN 1 ELSE 0 END AS nacional FROM C_OPERACIONES WHERE ID IN (" & sqlWop & ")"
	sql = sql & " ORDER BY nacional DESC, id"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql)
	contOpe = 0
	idsOpe = ""
	do while not resultado.eof 
		call OperacionesTablaEntera(resultado)
		
		if idsOpe <> "" then idsOpe = idsOpe & ", "
		idsOpe = idsOpe & "<a href='#ope" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contOpe = contOpe + 1
		idMapa = idMapa + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Demandas		
if request.QueryString("demandas")<>"" then
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='B' AND web_es=1 "
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND nacional<>0"
	end if
	sql = sql & " AND ((FECHA_NOTICIA BETWEEN " & desde & " AND " & hasta & ") OR (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & "))"
	sql = sql & " ORDER BY nacional DESC, TIPOSECCION"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	Set resultado = session("connPW").execute(sql) 
	sqlDem = sql
	contDem = 0
	idsDem = ""
	do while not resultado.eof 
		call VerDemanda(resultado)
		
		if idsDem <> "" then idsDem = idsDem & ", "
		idsDem = idsDem & "<a href='#dem" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contDem = contDem + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Subastas		
if request.QueryString("subastas")<>"" then
	sql = "SELECT * FROM C_CONCURSOS WHERE web_es=1 AND "
	sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, fecha) & "', 103) AND CONVERT(DATETIME, '" & fecha & "', 103) OR "
	sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7, fecha) & "', 103) AND CONVERT(DATETIME, '" & fecha & "', 103) )"
	
	sql = sql & " ORDER BY tipo_concurso"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	Set resultado = session("connPW").execute(sql) 
	sqlSub = sql
	contSub = 0
	idsSub = ""
	do while not resultado.eof 
		VerSubasta(resultado)
		if idsSub <> "" then idsSub = idsSub & ", "
		idsSub = idsSub & "<a href='#sub" & resultado("id") & "'>" &  resultado("id") & "</a>"
		%><br><%
		
		resultado.movenext
		contSub = contSub + 1
	loop
	resultado.close
end if
%>
<div style="clear:both;"></div>
<% 'Vencimientos	
if 1=2 then
'if request.QueryString("vencimientos")<>"" then
	sql = "SELECT * "
	sql = sql & "FROM C_OPERACIONES WHERE "
	sql = sql & "(FECHA_PUBLICACION_VENCIMIENTO BETWEEN " & desde & " AND " & hasta & ")"	
	if not request.QueryString("internacional")<>"" then
		sql = sql & " AND ID_PAIS=1"
	end if
	sql = sql & " AND web_es <> 0"
	sql = sql & " ORDER BY SECCION"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	test_inyeccion_sql sql
	set resultado = session("connPW").execute(sql)
	contVenc = 0
	idsVenc = ""
	if not resultado.eof then
		call TablaVencimientos(resultado)
	end if
		
	resultado.close
end if
%>
<br style="clear:both">
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>


<% set resultado = nothing %>

<% if ver_resumen then %>
<hr style="clear:both">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">Noticias: </td>
    <td width="10px"></td>
    <td valign="top"><%= contNot %></td>
    <td width="10px"></td>
    <td><%= idsNot %></td>
  </tr>
  <tr>
    <td valign="top">Rumores:</td>
    <td width="10px"></td>
    <td valign="top"><%= contRum %></td>
    <td width="10px"></td>
    <td><%= idsRum %></td>
  </tr>
  <tr>
    <td valign="top">Estudios:</td>
    <td width="10px"></td>
    <td valign="top"><%= contEst %></td>
    <td width="10px"></td>
    <td><%= idsEst %></td>
  </tr>
  <tr>
    <td valign="top">Operaciones:</td>
    <td width="10px"></td>
    <td valign="top"><%= contOpe %></td>
    <td width="10px"></td>
    <td><%= idsOpe %></td>
  </tr>
  <tr>
    <td valign="top">Subastas/Concursos:</td>
    <td width="10px"></td>
    <td valign="top"><%= contSub %></td>
    <td width="10px"></td>
    <td><%= idsSub %></td>
  </tr>
  <tr>
    <td valign="top">Demandas:</td>
    <td width="10px"></td>
    <td valign="top"><%= contDem %></td>
    <td width="10px"></td>
    <td><%= idsDem %></td>
  </tr>
  <tr>
    <td valign="top">Vencimientos:</td>
    <td width="10px"></td>
    <td valign="top"><%= contVenc %></td>
    <td width="10px"></td>
    <td><%= idsVenc %></td>
  </tr>
</table>
<% end if %>

</body>
</html>
