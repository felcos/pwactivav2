<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<meta http-equiv="contenido-Type" contenido="text/html; charset=iso-8859-1">
<title>Property Web - La Comunidad Inmobiliaria Europea</title>
<link href="css.css" rel="stylesheet" type="text/css" />
<% 
if session("presenta_font_size")="" then session("presenta_font_size")=5 
select case session("presenta_font_size")	
case 0
	c_size = 8
case 1
	c_size = 9
case 2
	c_size = 10
case 3
	c_size = 11
case 4
	c_size = 12
case 5
	c_size = 14
case 6
	c_size = 16
case 7
	c_size = 18
case 8
	c_size = 20
case 9
	c_size = 24
end select
%>
<style type="text/css">
	#contenido, #contenido td{font-size: <%= c_size %>px;}
</style>
<script language="JavaScript">
	//function aumentaLetra()		{window.self.location='size.asp?letra=aumentar&p=<%= request.QueryString("p") %>'}
	//function disminuyeLetra()	{window.self.location='size.asp?letra=disminuir&p=<%= request.QueryString("p") %>'}
	//function resetLetra()		{window.self.location='size.asp?letra=reset&p=<%= request.QueryString("p") %>'}
</script>
</head>
<body>
<div id="wrapper">


<div id="cabecera">
	<img src="/presenta/img/cabecera.gif" border="0" usemap="#Map"/>
	<map name="Map">
		<area shape="rect" coords="13,208,47,241" href="presentacion.pdf">
		<area shape="rect" coords="48,208,82,241" href="javascript:disminuyeLetra();">
		<area shape="rect" coords="83,208,117,241" href="javascript:aumentaLetra();">
	</map>
</div>

<div id="contenido"><% 
select case request.QueryString("p")
	case "introduccion"		%><!--#include file="inc/intro.asp" --><%
	case "actualidad"		%><!--#include file="inc/actualidad.asp" --><%
	case "estudios"			%><!--#include file="inc/estudios.asp" --><%
	case "ofertas"			%><!--#include file="inc/ofertas.asp" --><%
	case "operaciones"		%><!--#include file="inc/operaciones.asp" --><%
	case "rumores"			%><!--#include file="inc/rumores.asp" --><%
	case "infoempresas"		%><!--#include file="inc/infoempresas.asp" --><%
	case "infoinmuebles"	%><!--#include file="inc/infoinmuebles.asp" --><%
	case "demandas"			%><!--#include file="inc/demandas.asp" --><%
	case "subastas"			%><!--#include file="inc/subastas.asp" --><%
	case "directorio"		%><!--#include file="inc/directorio.asp" --><%
	case "publicidad"		%><!--#include file="inc/publicidad.asp" --><%
	case "tarifas"			%><!--#include file="inc/tarifas.asp" --><%
	case "contacto" 		%><!--#include file="inc/contacto.asp" --><%
	case "vencimientos" 	%><!--#include file="inc/vencimientos.asp" --><%
	case else				%><!--#include file="inc/intro.asp" --><%
end select
%></div>

<div id="msenu">
<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr height="6"><td></td></tr>
	<tr><td class="mnu_tit">Qu&eacute; es</td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=intro" class="mnu_txt">Con&oacute;zcanos un poco</a></td></tr>
	<tr><td align="right"> .................................</td></tr>
	<tr><td class="mnu_tit">Secciones</td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0"/><a href="?p=actualidad" class="mnu_txt">Actualidad</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=operaciones" class="mnu_txt">Operaciones</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=estudios" class="mnu_txt">Estudios de Mercado</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=rumores" class="mnu_txt">Rumores y Oportunidades</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=vencimientos" class="mnu_txt">Vencimientos de Contratos</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=demandas" class="mnu_txt">Demandas</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=subastas" class="mnu_txt">Subastas</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=ofertas" class="mnu_txt">Ofertas</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=directorio" class="mnu_txt">Directorio de Empresas</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=infoempresas" class="mnu_txt">Info Empresas</a></td></tr>
	<tr><td class="mnu_txt"><img src="/presenta/img/flecha.gif" hspace="4" border="0" /><a href="?p=infoinmuebles" class="mnu_txt">Info Inmuebles</a></td></tr>
	<tr><td align="right">.................................</td></tr>
	<tr height="9"><td></td></tr>
	<tr><td class="mnu_tit"><a href="?p=tarifas" class="mnu_tit">Tarifas</a></td></tr>
	<tr><td class="mnu_tit"><a href="?p=contacto" class="mnu_tit">Contacto</a></td></tr>
	<tr height="6"><td></td></tr>
	<tr><td class="mnu_tit"><a href="?p=publicidad" class="mnu_tit">Publicidad</a></td></tr>
	<tr><td align="right">.................................</td></tr>
	<tr height="36"><td></td></tr>
	<tr><td class="mnu_txt" align="center"><img src="/presenta/img/volver.gif" hspace="4" /> <a href="https://www.propertyweb.eu">volver a PropertyWeb</a></td></tr>	
	<tr height="36"><td></td></tr>
</table>
</div>

<div id="pie">
	<a href="https://www.thecomcom.com" target="_blank" class="madein">made in thecomcom.com 2008</a>
</div>
</div>
</body>
</html>
