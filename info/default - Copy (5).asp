<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/inc/sin_acceso.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Info</title>
	<!--#include virtual="/inc/head.asp" -->
    <link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/tabs031-izq.css" rel="stylesheet" type="text/css">
	<!-- EXTRA  -->
	<link href="/css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/filtrosForm.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    
	<link href="/lib/fancyBox/jquery.fancybox.css" type="text/css" rel="stylesheet">
	<link href="/lib/blockUI/block.css" rel="stylesheet" type="text/css">
    
	<script src="/lib/fancyBox/jquery.fancybox.pack.js"></script>
    <script src="/lib/blockUI/jquery.blockUI.min.js"></script>	
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
    <script src="/lib/maps/infobox.js" type="text/javascript"></script>
    <!-- script src="/js/selectDrop_javier.js"></script -->
    <script src="/js/selectDrop.js"></script>
<% 
'sec_actual = "/info/"

dim busqueda
dim vari(20)
dim minisql

frmInfo_busq = request.form("frmInfo_busq")
frmInfo_tipo = request.form("frmInfo_tipo")	
frmInfo_propietario = request.form("frmInfo_propietario")

dim contador_paso
dim ids_actual

public acceso_seccion
acceso_seccion = false

select case frmInfo_tipo
case "prop"
	titulo = "Propietario Actual"
	if session("pw_ws").accesoInfoPropietario then acceso_seccion = true
	
case "cc"
	titulo = "Centro Comercial"
	if session("pw_ws").accesoInfoCentroComercial then acceso_seccion = true

case "ni"
	titulo = "Poligono/Nave Industrial"
	if session("pw_ws").accesoInfoEdificio then acceso_seccion = true
	
case "hot"
	titulo = "Hotel"
	if session("pw_ws").accesoInfoHotel then acceso_seccion = true
	
case "edif"
	titulo = "Edificio o Direcci&oacute;n"
	if session("pw_ws").accesoInfoEdificio then acceso_seccion = true
	
case "empr"
	titulo = "Empresa"
	if session("pw_ws").accesoInfoEmpresa then acceso_seccion = true
	
end select
%>

<script>
	var datos = [];
	var markerList = [];
	var infoboxesList = [];
	var seleccionados = [];
	var rentas_todas;
	var agentes_todos;
	
	var edif_todos = [];
	var edif_markers = [];
	
	var subzonas = [];
	var poligonos = [];
	
	var limite_seleccion = 50;
	var centrarMapa = false;
	
	//var cargando = true;
	var cargando = false;
	var frm_data = "";
	var frm_agencias = "";
	
	var faltan_inmuebles = 0;
	
	var counter = 0;
	
	var images = new Array();
	var img;
	
	var poligono;
	var markersZona = [];
	
	
	var block_opts = {
		message: "<img src='/img/ajax-loader.gif'>",
		css: {
			border: "none", 
			padding: "0px", 
			backgroundColor: "none",
			opacity: .8, 			
			left: "0px", 
			right: "0px",
			width: "none"
		},
		overlayCSS: {
			backgroundColor: "#fff",  //
			opacity: 0.3,
			margin: "auto"
		}	
	};
	
	var swMostrarDiapositivas = true;
	
	var reload_map = false;
	<% 
	settab = "map"
	if request.form("tab")<>"" then 
		settab = request.form("tab")
	end if
	
	if session("navegador")="old" then 
		cargar_mapa = false
		settab = "list"
	end if
	
	if settab <> "map" then %>
		reload_map = true;
		console.log("tabmap <> map => reload_map=" + reload_map);
	<% end if %>
	
	var act_map = {'zoom':0, 'lat': 0, 'lng': 0}
	var act_zoom = 0;
	
	var datos_mapa = "";
	var datos_cargados = false;
	
</script>

<style type="text/css">
	#myMap {
		width: 100%;
		height: 480px;
		z-index: 0;
		/*position: relative;*/
	}
	.leer {
		cursor:pointer;	
	}
	
	input.warning {
		color:red;
	}
	
	#depura {
		clear:both;
		display:block;
		font-size: 12px;
		margin: 3px;
		color: #C94307;
		display: none;/**/
	}
	
	#div_titulos {
		min-height:300px;
	}
	
	<% if request.Cookies("dev")<>"" then %>
	.dispA-direccion .numcalle {
		display: inline-block !important;
		color:red;
	}
	.popover-check{
		display:block !important;
	}
	.popover {
		max-width:none;
		width:400px;
		/*left:730px !important;*/
	}
	<% end if %>
</style>
<%
set rsBusq = Server.CreateObject("ADODB.Recordset")

settab = "map"
if request.form("tab")<>"" then 
	settab = request.form("tab")
end if
%>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>

</head>
<body>
	<!--#include virtual="/inc/body-header.asp" -->
	<div class="container">
    <% if 1=2 then 'request.Cookies("dev")("request")<>"" then %>
        <div class="dev peq">
            Form: &nbsp; <% 
            for each elto in request.Form 
                if request.Form(elto)<>"" then %>[<b><%= elto %></b> = <%= request.Form(elto) %>]&nbsp;<% end if 
            next %>
        </div>
    <% end if %>
	<% if frmInfo_tipo = "empr" then %>
    	<section id="s_titulos" class="row">
			<div id="result" class="caja">
            	<!--#include virtual="/info/busq/empr.asp" -->
			</div>
		</section>
    <% else %>
        <section id="s_titulos" class="row">
			<div class="caja">
                <a id="scrollmap"></a>
                <div class="miga"><h2 class="tit_miga02"><%= titulo %></h2></div>
                <% if frmInfo_busq<>"" then %>
                <div class="tit_resultados" id="informa_resultados">
                    <p><span class="tit_busqueda" id="informa-tit-busq"><%= ucase(frmInfo_busq) %></span><span class="tit_tipo" id="informa-tipo-busq"></span><span class="tit_numero" id="informa-num-busq"><!--XXX resultados, --></span><span class="tit_metros" id="informa-total-sup-busq"><!--con un total de XXXX m2--></span><span class="tit_metros" id="informa-total-edifs-busq"></span></p> 
                </div>
                <% end if %>
                <div class="PwTabs">
                    
                    <ul class="nav nav-tabs clearfix lineNavs" style="">
                        <li id="li-tab-map" <% if settab="map" then %>class="active"<% end if %>><a href="#map" data-toggle="tab" aria-expanded="true" data-id="map"><span class="icon-map2"></span> Mapa</a></li>
                        <li id="li-tab-list" <% if settab="list" then %>class="active"<% end if %>><a href="#list" data-toggle="tab" aria-expanded="false" data-id="list"><span class="icon-menu"></span> Listado</a></li>
                    </ul>
                    <% 'if 1=2 then 
                    if request.Cookies("dev")<>"" then %>
                    <div class="dev" style="padding:2px;">
                        <div class="pull-right">
                            fit: 
                            <input type="button" value="ini" onClick="f_bounds_ini();" class="btn btn-sm"> &nbsp; 
                            <input type="button" value="fitMap" onClick="fitMap();" class="btn btn-sm"> &nbsp; 
                        </div>
                        <input type="text" class="dev" id="datos_mapa" value="" style="width:80px;">
                        <input type="button" value="show markers" onClick="MuestraMarkers();" class="btn btn-sm">
                        <input type="button" value="hide markers" onClick="OcultaMarkers();" class="btn btn-sm">
                        
                        <input type="button" value="show boxes" onClick="MuestraBoxes();" class="btn btn-sm">
                        <input type="button" value="hide boxes" onClick="OcultaBoxes();" class="btn btn-sm">
                         - 
                        <input type="text" class="dev" id="fit" value="" style="width:60px;">
                        <input type="button" value="show selection" class="btn btn-sm blancoHover" onClick="ver_seleccionados();">
                        <!-- img src='/img/ajax-loader.gif' -->
                    </div>
                    <% end if %>
                    
                    <div class="tab-content activo">
                        <!-- include virtual="/..../filtros.asp" -->
                        <div class="tab-pane <% if settab="map" then %>active<% end if %>" id="map">
                            <% 'if request.Form="" then %><!-- include virtual="/..../diapositivas.asp" --><% 'end if %>
                            <div id="myMap" class="myMap"></div>
                            <div class="divDisponMapa" id="myMapDisp"></div>
                            
                            <div class="dev" style="padding:4px; <% if request.Cookies("dev")="" then %>display:none;<% end if %>">
                                <span id="map-zoom"></span> // <span id="map-bounds"></span>
                            </div>
                        </div>
                        <div class="tab-pane <% if settab="list" then %>active<% end if %>" id="list">
                            
                            <div class="caja-operaciones">
                                
                                <div class="divDispon clearfix">
                                    <!--form name="frm_titulos" id="frm_titulos" method="GET" action="/articulos/"></form-->
                                        <div id="div_titulos">
                                            <% select case frmInfo_tipo
                                            case "prop"
                                                %><!--#include virtual="/info/busq/prop.asp" --><%
                                            case "cc"
                                                %><!--#include virtual="/info/busq/cc.asp" --><%
                                            case "ni"
                                                %><!--#include virtual="/info/busq/ni.asp" --><%
                                            case "hot"
                                                %><!--#include virtual="/info/busq/hotel.asp" --><%
                                            case "edif"
                                                %><!--#include virtual="/info/busq/edif.asp" --><%
                                            case "empr"
                                                %><!--#include virtual="/info/busq/empr.asp" --><%
                                            end select %>
                                        </div>
                                    
                                </div>
                            </div>
                            
                        </div>
                    </div>
                    
                </div><!-- // PwTabs --> 
  
			</div>
		</section>
    <% end if %>
    
	<% if request.Cookies("dev")<>"" then %>
        <section class="caja">
            <% for each elto in request.form 
                %><li><%= elto %>: <%= request.form(elto) %></li>
            <% next %>
        </section>
        <section id="informaJP"></section>
    <% end if %>
    
    </div>
    <!--#include virtual="/inc/body-footer.asp" -->
    <% 
	if frmInfo_tipo<>"empr" then 
		%><!--#include virtual="/info/busq/js.asp" --><% 
	end if
    set rsBusq=nothing 
    %>
</body>
</html>