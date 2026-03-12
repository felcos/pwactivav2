<%' @ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<% 'if request.Cookies("dev")="" then response.Redirect("/info/") %>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!-- include virtual="/lib/funciones.asp" -->
<%
'busqueda=Request.Form("busq")
'busqueda = "alfonso xii"

val_edif = true
val_cc = false
val_hotel = false

val_nac = true
val_int = false

val_top = false
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>PropertyWeb - Administraci&oacute;n de Inmuebles</title>
	<!--#include virtual="/inc/simple/head.asp" -->
    
    <style>
#mapa {
	padding-top:22px;
	height:450px;
	width: 100%;
}
.controls {
	background-color: #fff;
	border-radius: 2px;
	border: 1px solid transparent;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
	box-sizing: border-box;
	font-family: Roboto;
	font-size: 13px;
	font-weight: 300;
	height: 20px;
	/*margin-left: 17px;*/
	margin-top: 0px;
	outline: none;
	padding: 0 11px 0 13px;
	text-overflow: ellipsis;
	width: 400px;
}
.controls:focus {
	border-color: #4d90fe;
	/* width: 400px; */
}

<% if request.Cookies("admin")("confirmar_coordenadas")="" then %>
.confirmar_coordenadas {
	display: none;
}
<% end if %>
	</style>
</head>
<body>
<!--include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="introp" class="cf">
<form id="frm_busq" class="cssform" name="frm_busq" action="/admin/inmuebles/busq_edificios.asp" method="post" autocomplete="off" target="_blank">
<%
'/info/busq/edificios.asp
%>
    <div class="grid-half titulo">
        <h1 class="heading">Administraci&oacute;n de Inmuebles</h1>
	</div>
	
    <div class="grid-half titulo grid-flow-opposite">
<div class="dev mini" style="display:none;">
	<div style="float:left; width:60px;">actual: </div><input id="actual" name="actual" type="text" value="" style="width:60px;" class="mini">
    <input id="markLatLng" name="markLatLng" type="text" value="" style="width:60px;" class="mini">
    <input id="markGeocoder" name="markGeocoder" type="text" value="" style="width:60px;" class="mini">
    <div style="clear:both;"></div>
    <input type="text" name="edif" value="1"/>
    <input type="text" name="nacional" value="1" />
</div>

<div style="margin: 18px 0 18px 0;">
    <label>Tiene:</label><br>
    <div class="grid-2" style="margin-bottom:0;">
	Lat/Lng.:&nbsp;
    <select name="tiene_latlng" style="border:none;">
      <option value="1">s&iacute;</option>
      <option value="0" selected>no</option>
      <option value="*">*</option>
    </select>
    </div>
    <div class="grid-2" style="margin-bottom:0;">
    Direcci&oacute;n:&nbsp;
    <select name="tiene_dir" style="border:none;">
      <option value="1" selected>s&iacute;</option>
      <option value="0">no</option>
      <option value="*">*</option>
    </select>
    </div>
    <div class="grid-2" style="margin-bottom:0;"></div>
    <div style="clear:both;"></div>
</div>

    </div>
    
	<div class="grid-half">
<div style="margin: 8px 0 8px;">

<label for="busq">Buscar:</label>
<input id="busq" type="text" name="busq" value="<%= busqueda %>" autofocus maxlength="50" />
<div style="width:16px; vertical-align:bottom; margin: 0 8px; display:inline-block;"><div id="buscando" style="display:none;"><img src="/img/loading.gif"></div></div>
<input value="buscar" type="submit"> &nbsp; <input value="reset" type="button" onClick="location.assign('/admin/inmuebles/edificios.asp');">
</div>
	</div>
</form>
</section>

<section id="conts" class="cf" style="padding-bottom:4px; border-bottom: 1px solid #ccc;">
	
    <div class="grid-3" style="margin-bottom:0;">
    	<div id="thead" style="padding-right:17px;">
<table width="100%" class="listado" id="listado">
<thead>
<tr>
    <th style="width:25px;"></th>
    <th align="left">inmueble &nbsp; <span id="contador_articulos"></span></th>
    <th style="font-weight:normal; font-size:10px; width:30px;"><span class="confirmar_coordenadas">OK</span></th>
    <th style="font-weight:normal; font-size:10px; width:25px;">dir</th>
    <th style="font-weight:normal; font-size:10px; width:25px;">lat/lng</th>
</tr>
</thead>
</table>
        </div>
        <div id="result" style="height:450px; overflow-y:scroll;"></div>
    </div>
	
    <div class="grid-3 grid-flow-opposite" style="margin-bottom:0;">
    	<div id="mapa"></div>
    	<div id="controles_mapa" style="margin-top:6px; display:none;">
<div class="grid-1" align="center"><a href="#" onclick="fitmap()" class="peq">fitmap</a></div>
<div class="grid-1" align="center"><a href="#" onclick="zoommap()" class="peq">zoom in</a></div>
<div class="grid-1" align="center"><a href="#" onclick="allmap()" class="peq">zoom out</a></div>
<div class="grid-1" align="center"></div>
<div class="grid-1" align="center"><a href="#" class="peq" onClick="clearmap()">clear</a></div>
<div class="grid-1" align="center"><label class="peq">lock </label><input type="checkbox" id="lockmap"/></div>
<input id="pac-input" class="controls" type="text" placeholder="buscar">
        </div>
        <div id="informa_mapa" class="peq" style="display:none;">
<li>center: <span id="mapa-center"></span></li>
<li>zoom: <span id="mapa-zoom"></span></li>
<li>bounds: <span id="mapa-bounds"></span></li>
        </div>
    </div>
    
</section>

<section id="informa" class="cf" style="margin-top:6px; margin-bottom:6px; display:none;">
	<div id="informa-busq">[informa-busq]</div>
	<div id="informa-sql">[informa-sql]</div>
	<div id="informa3">[informa3]</div>
	<div id="informa4">[informa4]</div>
</section>

</div>
</div>

</body>
</html>
<!--#include virtual="/admin/inmuebles/inc_js.asp" -->
