<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="/_inc/jm/estilos.css" rel="stylesheet" type="text/css">
    <!-- link href="/mailing/report/leer_jm.css" rel="stylesheet" type="text/css" -->
    <!-- link href="/mailing/report/css_jm.css" rel="stylesheet" type="text/css" -->
	<style>
    #main_read {
        border: 0px green solid;
        float:left;
        width:720px;
        padding:5px;
    }
    </style>
    <title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>
	<!--#include virtual="/lib/funciones.asp" -->
    <!--#include virtual="/articulos/contenido/noticia.asp" -->
    <!--#include virtual="/articulos/contenido/rumor.asp" -->
    <!--#include virtual="/articulos/contenido/estudio.asp" -->
	<!--#include virtual="/articulos/contenido/demanda.asp" -->
    <!--#include virtual="/mailing/enviar/inc_operacion.asp" -->
</head>
<body>
<h2>PropertyWeb - Centros Comerciales - 03/06/2013 - 07/06/2013</h2>
<%
modo_report = true

dim resultado
desde = "CONVERT(DATETIME, '2013-06-10 00:00:00', 102)"
hasta = "CONVERT(DATETIME, '2013-06-15 00:00:00', 102)"
%>
<div id="main_read">
<%
sqlW = "PALABRAS_CLAVES LIKE '%comercial%' AND PALABRAS_CLAVES LIKE '%centro%' "
'sqlW = "PALABRAS_CLAVES LIKE '%comercial%' AND PALABRAS_CLAVES NOT LIKE '%centro%' "
'sqlW = "TIPOSECCION LIKE '%comercial%'"

'Noticias		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
		
	set resultado = session("connPW").execute(sql) 
	sqlNot = sql
	contNot = 0
	idsNot = ""
	do while not resultado.eof 
		call VerNoticia(resultado)
		
		if idsNot <> "" then idsNot = idsNot & ", "
		idsNot = idsNot & resultado("id")
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
	idsRum = ""
	do while not resultado.eof 
		call VerRumor(resultado)
		
		if idsRum <> "" then idsRum = idsRum & ", "
		idsRum = idsRum & resultado("id")
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
	idsEst = ""
	do while not resultado.eof 
		call VerEstudio(resultado)
		
		if idsEst <> "" then idsEst = idsEst & ", "
		idsEst = idsEst & resultado("id")
		%><br><%
		
		resultado.movenext
		contEst = contEst + 1
	loop
	resultado.close
	
IF 1=2 THEN
END IF
'Operaciones			
	sqlWop = "SECCION LIKE '%CENTROS COMERCIALES%'"
	
	sqlWop = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 AND " & sqlWop
	sqlWop = sqlWop & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	
	sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & sqlWop & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	set resultado = session("connPW").execute(sql)
	contOpe = 0
	idsOpe = ""
	do while not resultado.eof 
		call OperacionesTablaEntera(resultado)
		
		if idsOpe <> "" then idsOpe = idsOpe & ", "
		idsOpe = idsOpe & resultado("id")
		%><br><%
		
		resultado.movenext
		contOpe = contOpe + 1
	loop
	resultado.close

	
IF 1=2 THEN
END IF
'Demandas			
	'sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & art_id
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='B' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	Set resultado = session("connPW").execute(sql) 
	do while not resultado.eof 
		call VerDemanda(resultado)
		resultado.movenext
	loop
	resultado.close
%>
<br style="clear:both">
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>

<% set resultado = nothing %>

<% if 1=2 then %>
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
    <td valign="top">Demandas:</td>
    <td width="10px"></td>
    <td valign="top"><%= contDem %></td>
    <td width="10px"></td>
    <td><%= idsDem %></td>
  </tr>
</table>
<% end if %>


</body>
</html>

