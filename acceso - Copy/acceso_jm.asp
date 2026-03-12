<!DOCTYPE html>
<html>
<head>
	<!-- meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /-->
	<link rel="stylesheet" href="/_inc/jm/reset.css" media="all" />
	<link rel="stylesheet" href="/_inc/jm/global.css">
	<link rel="stylesheet" href="/_inc/jm/estilos.css" type="text/css">
	<title>PropertyWeb - acceso</title>
    <!--#include virtual="/inc/js.asp" -->
</head>
<body>
<div id="centrado">
	<!--#include virtual="/_inc/jm/header.asp" -->
   
<div id="contenedor_left">

<section id="noticias">
	<!--#include virtual="/inc/password.asp" -->
    <% if session("PW_WS").boolAceptadasCondiciones then %>
    		Registro correcto.... <a href="/articulos">continuar</a>
    <% end if %>
</section>


</div><!-- FIN: contenedor_left -->

<div id="contenedor_right">
	<!-- include virtual="/inc/herramientas_busq.asp" -->

<% 'if request.Cookies("dev")<>"" then %>
<div id="mibloque">
    <div id="informa_licencia" style="display:inline;">
    	<p>request.cookies(&quot;<b>licencia</b>&quot;)&nbsp;:&nbsp;<b><% if request.Cookies("licencia")="" then %>NO <% end if %></b>existe</p>
    </div>
    <span style="font-size:10px; padding-top:4px;"><a href="javascript:void();" onclick="javascript:comprobar_licencia();">comprobar licencia</a></span>
</div>

<div id="mibloque" style="margin-bottom:10px; clear:both;">
    Aceptadas Condiciones: <div id="informa_condiciones" style="display:inline;"><%= session("PW_WS").boolAceptadasCondiciones %></div>
	<p style="font-size:10px;"><a href="javascript:void();" onclick="javascript:comprobar_condiciones();">comprobar</a></p>
    <p align="right" style="font-size:12px;">
<span style="float:left; font-size:10px;"><a href="/acceso/session_abandon.asp">Session.Abandon()</a></span>
	</p>
</div>
<% 'end if %>

<div id="mibloque" style="margin-bottom:10px; clear:both;">
	<!--#include virtual="/acceso/inc/informa_cliente.asp" -->
</div>

<div id="mibloque" style="margin-bottom:10px; clear:both;">
	<p><a href="/acceso/registro.asp">Registro sin JavaScript</a></p>
</div>
</div><!-- FIN: contenedor_right -->	

<!--#include virtual="/_inc/jm/footer.asp" -->
</div><!-- FIN: centrado -->

</body>
</html>

