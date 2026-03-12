<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Actualidad Inmobiliaria</title>
    <!--#include virtual="/inc/simple/head.asp" -->
	<% sec_actual = "/acceso/" %>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->

<section id="content">
<div class="contenedor">

<section id="introp" class="cf">
	
    <div class="grid-full">
    	<h1 class="heading">Licencia</h1>
	</div>
	
    <div class="grid-4">

<section id="noticias">
	<!--#include virtual="/acceso/password_z.asp" -->
    <% if boolAceptadasCondiciones then %>
    		Registro correcto.... <a href="/flash">continuar</a>
    <% end if %>
</section>

    </div>
	
    <div class="grid-2 grid-flow-opposite">
<% 'if request.Cookies("dev")<>"" then %>
<figure>
    <div id="informa_licencia" style="display:inline;">
    	<p>request.cookies(&quot;<b>licencia</b>&quot;)&nbsp;:&nbsp;<b><% if request.Cookies("licencia")="" then %>NO <% end if %></b>existe</p>
    </div>
    <span style="font-size:10px; padding-top:4px;"><a href="javascript:void();" onclick="javascript:comprobar_licencia();">comprobar licencia</a></span>
</figure>

<figure style="margin-top:10px;">
    <div id="mibloque" style="margin-bottom:10px; clear:both;">
        Aceptadas Condiciones: <div id="informa_condiciones" style="display:inline;"><%= boolAceptadasCondiciones %></div>
        <p style="font-size:10px;"><a href="javascript:void();" onclick="javascript:comprobar_condiciones();">comprobar</a></p>
        <p align="right" style="font-size:12px;">
    <span style="float:left; font-size:10px;"><a href="/acceso/session_abandon.asp">Session.Abandon()</a></span>
        </p>
    </div>
</figure>
<% 'end if %>

<figure style="margin-top:10px;">
	<!--#include virtual="/acceso/inc/informa_cliente.asp" -->
</figure>

<figure style="margin-top:10px;">
	<p><a href="/acceso/registro.asp">Registro sin JavaScript</a></p>
</figure>
	</div>

    <div style="clear:both;"></div>
    
<div name="div_instrucciones" id="div_instrucciones" class="grid-full" style="border: 1px red dashed;">
	<p>instrucciones</p>
</div>

<div id="div_result" class="grid-full" style="border: 1px green dashed;">
	<div id="result">RESULTADOS</div>
</div>
    
</section>


</div>
</section>

</body>
</html>
