<!DOCTYPE html>
<html lang="es">
<head>
<!--#include virtual="/inc/reg_accesos.asp" -->
<link rel="stylesheet" href="/_inc/jm/estilos.css" type="text/css">
<style>
#main_read {
	border: 0px green solid;
	float:left;
	width:720px;
	padding:5px;
}
</style>
<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>

<!--#include virtual="/report/inc_noticia.asp" -->
<!--#include virtual="/report/inc_rumor.asp" -->
<!--#include virtual="/report/inc_estudio.asp" -->
<!--#include virtual="/report/inc_demanda.asp" -->
<!--#include virtual="/report/inc_operacion.asp" -->
<!-- include virtual="/report/inc_subasta.asp" -->
<!-- include virtual="/report/inc_vencimientos.asp" -->

<!--#include virtual="/inc/js.asp" -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX-HAhl6u-wxBKLQO31nH4vMUQ3w8cEoU&sensor=false"></script>

</head>
<body>
<%
dim resultado
dim idMapa
idMapa = 0
desde = "CONVERT(DATETIME, '2013-04-22 00:00:00', 102)"
hasta = "CONVERT(DATETIME, '2013-04-30 00:00:00', 102)"
%>
<div id="main_read">
<%
sqlW = "TIPOSECCION LIKE '%comercial%'"

'Noticias		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
		
	set resultado = session("connPW").execute(sql) 
	sqlNot = sql
	contNot = 0
	do while not resultado.eof 
		call VerNoticia(resultado)
		%><br><%
		resultado.movenext
		contNot = contNot + 1
	loop
	resultado.close
	
'Rumores			
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='W' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	set resultado = session("connPW").execute(sql) 
	sqlRum = sql
	contRum = 0
	do while not resultado.eof 
		call VerRumor(resultado)
		%><br><%
		resultado.movenext
		contRum = contRum + 1
	loop
	resultado.close
	
'Estudios		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='E' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	set resultado = session("connPW").execute(sql) 
	sqlEst = sql
	contEst = 0
	do while not resultado.eof 
		call VerEstudio(resultado)
		%><br><%
		resultado.movenext
		contEst = contEst + 1
	loop
	resultado.close
	
'Operaciones			
	sqlW = "SECCION LIKE '%comercial%'"
	
	sqlW = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 AND " & sqlW
	sqlW = sqlW & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	
	sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	set resultado = session("connPW").execute(sql)
	sqlOpe = sql
	contOpe = 0
	do while not resultado.eof 
		call OperacionesTablaEntera(resultado)
		%><br><%
		resultado.movenext
		contOpe = contOpe + 1
		idMapa = idMapa + 1
	loop
	resultado.close
	
	
IF 1=2 THEN	
'Demandas			
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & art_id
	Set resultado = session("connPW").execute(sql) 
	if resultado.eof and resultado.bof then
		call ArticuloInexistente
	else
		call VerDemanda(resultado)
	end if
	resultado.close
	
'Subastas			
	sql = "SELECT * FROM C_Concursos WHERE Id = " & art_id
	
	Set resultado = session("connPW").execute(sql) 
	if resultado.eof and resultado.bof then
		call ArticuloInexistente
	else
		VerSubasta(resultado)
	end if
	resultado.close	
	
'Vencimientos		
	if session("pw_ws").accesoVencimientos then
		listaVencimientos=""
		tmpLista=split(session("lista_vencimientos"),",")
		mm=ubound(tmpLista)
		
		for ii=0 to mm
			if listaVencimientos<>"" then listaVencimientos=listaVencimientos & ","
			listaVencimientos=listaVencimientos & mid(tmpLista(ii), instr(tmpLista(ii), "=")+1, len(tmpLista(ii)))
		next
		sql=" SELECT * FROM C_OPERACIONES WHERE ID IN (" & listaVencimientos & ")"
		Set resultado = session("connPW").Execute(SQL)
		
		call TablaVencimientos(resultado)
	else
		call Vencimientos_SinAcceso
	end if
	

END IF 
%>
</div>

<% set resultado = nothing %>

<% 'if 1=2 then %>
<hr style="clear:both">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">Noticias: </td>
    <td width="10px"></td>
    <td valign="top"><%= contNot %></td>
    <td width="10px"></td>
    <td><%'= sqlNot %></td>
  </tr>
  <tr>
    <td valign="top">Rumores:</td>
    <td width="10px"></td>
    <td valign="top"><%= contRum %></td>
    <td width="10px"></td>
    <td><%'= sqlRum %></td>
  </tr>
  <tr>
    <td valign="top">Estudios:</td>
    <td width="10px"></td>
    <td valign="top"><%= contEst %></td>
    <td width="10px"></td>
    <td><%'= sqlEst %></td>
  </tr>
  <tr>
    <td valign="top">Operaciones:</td>
    <td width="10px"></td>
    <td valign="top"><%= contOpe %></td>
    <td width="10px"></td>
    <td><%'= sqlOpe %></td>
  </tr>
</table>
<% 'end if %>
</body>
</html>

