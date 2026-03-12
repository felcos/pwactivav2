<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - Admin</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_titulo" class="cf">
	<div class="grid-full titulo">
    	<h1 class="heading">Admin</h1>
	</div>
</section>

<section id="s_graficas" class="cf">
    <div class="grid-2">

<div class="panel panel-default">
    <div class="panel-heading">Control de Clientes</div>
    
	<ul class="list-group">
		<li><a href="/admin/clientes/no-acceden.asp">Clientes - No Acceden</a></li>
        <li><a href="/admin/clientes/">Clientes y Licencias</a></li>
        <li><a href="/admin/accesos/">Accesos al servidor</a></li>
    </ul>
</div>

	</div>
    
    <div class="grid-2">
    
<div class="panel panel-default">
    <div class="panel-heading">Inmuebles - coordenadas</div>
    
	<ul class="list-group">
		<li><a href="/admin/inmuebles/centros/">Centros Comerciales</a></li>
        <li><a href="/admin/inmuebles/hoteles/">Hoteles</a></li>
        <% if request.Cookies("dev")<>"" then %>
        <li><a href="/admin/inmuebles/todos.asp">Todos</a></li>
        <li><a href="/admin/inmuebles/">Inmuebles - Mapa</a></li>
        <% end if %>
    </ul>
    
</div>

	</div>
    
    <div class="grid-2">
    	<!-- include virtual="/dev/inc/informa.asp" -->
    </div>
    
</section>

</div>
</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function () {
	
});
</script>

