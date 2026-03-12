<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - Admin</title>
	<!--#include virtual="/inc/head.asp" -->

<% if request.Cookies("dev")="" then %>
	<link href="/css/dev.css" rel="stylesheet" type="text/css"/>
    <link href="/lib/bootstrap/css/bs.css" rel="stylesheet" type="text/css">
    <link href="/css/animate.css" rel="stylesheet" type="text/css">
<% end if %>

</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_buscador" class="row">
    <div class="caja">
      <h1 class="heading">PropertyWeb Admin</h1>
    </div>
</section>

<section id="s_control" class="row">
	<div class="row">
    
        <div class="col-sm-4">
<div class="panel panel-primary">
    <div class="panel-heading"><h4 class="panel-title">Control de Clientes</h4></div>
    
	<ul class="list-group">
		<li class="list-group-item">
            <div class="row">
                <div class="col-xs-12">
                	<ul>
                		<li><a href="/admin/clientes/no-acceden.asp">Clientes - No Acceden</a></li>
                    </ul>
                </div>
            </div>
        </li>
        <li class="list-group-item">
            <div class="row">
                <div class="col-xs-12">
                	<ul>
                    	<li><a href="/admin/clientes/">Clientes y Licencias</a></li>
                    </ul>
                </div>
            </div>
        </li>
        <li class="list-group-item">
            <div class="row">
                <div class="col-xs-12">
                	<ul>
                    	<li><a href="/admin/accesos/">Accesos al servidor</a></li>
                    </ul>
                </div>
            </div>
        </li>
    </ul>
    
</div>
        </div>
        
        <div class="col-sm-4">
<div class="panel panel-primary">
    <div class="panel-heading"><h4 class="panel-title">Inmuebles / coordenadas</h4></div>
    
	<ul class="list-group">
		<li class="list-group-item"><a href="/admin/inmuebles/centros/">Centros Comerciales</a></li>
        <li class="list-group-item"><a href="/admin/inmuebles/hoteles/">Hoteles</a></li>
        <li class="list-group-item"><a href="/admin/inmuebles/todos.asp">Todos</a></li>
        <% if request.Cookies("dev")<>"" then %>
        <li class="list-group-item"><a href="/admin/inmuebles/">Inmuebles - Mapa</a></li>
        <% end if %>
        <li class="list-group-item"><a href="/admin/zonas/">Subzonas</a></li>
    </ul>
    
</div>

        </div>
        
        <div class="col-sm-4"><!-- include virtual="/dev/inc/navegador.asp" --></div>
	</div>
    
</section>
	

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

