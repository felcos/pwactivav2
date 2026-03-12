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
	
	<!--#include virtual="/articulos/contenido/noticia.asp" -->
    <!--#include virtual="/articulos/contenido/rumor.asp" -->
    <!--#include virtual="/articulos/contenido/estudio.asp" -->
    
</head>
<body>
<%
modo_report = true

f_desde = "26/03/2014"
f_hasta = "07/04/2014"
ver_sql = FALSE

dim resultado
desde = "CONVERT(DATETIME, '" & year(f_desde) & "-" & month(f_desde) & "-" & day(f_desde) & " 00:00:00', 102)"
hasta = "CONVERT(DATETIME, '" & year(f_hasta) & "-" & month(f_hasta) & "-" & day(f_hasta) & " 00:00:00', 102)"
%>
<img src="/img/logo_cabecera.png"><br>
Resultados de la b&uacute;squeda - 'inmobiliaria colonial ' desde <%= f_desde %> hasta <%= f_hasta %><br>
<div id="main_read">
<%
sqlW = "PALABRAS_CLAVES LIKE '%inmobiliaria%' AND PALABRAS_CLAVES LIKE '%colonial%'"

'Noticias		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
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
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
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
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
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
	
'Operaciones			

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
</table>
<% end if %>

</body>
</html>

