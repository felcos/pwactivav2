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
</head>
<body>
<img src="https://www.propertyweb.eu/img/logo_cabecera.png" width="260" height="105">
<br>
<div id="main_read">
<%
'Rumores			
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE fecha_actualizacion='18/12/2015'"
	
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
%>
<br style="clear:both">
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>

<% set resultado = nothing %>

</body>
</html>

