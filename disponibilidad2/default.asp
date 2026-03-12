<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Disponibilidad</title>
	<!--#include virtual="/inc/head.asp" -->
    
    <link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/tabs031-izq.css" rel="stylesheet" type="text/css">
	<!-- EXTRA  -->
	<link href="/css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/filtrosForm.css" rel="stylesheet" type="text/css">
    
	<link href="/lib/fancyBox/jquery.fancybox.css" type="text/css" rel="stylesheet">
	<!-- link href="/lib/block/blockUI/block.css" rel="stylesheet" type="text/css" -->
    
<script src="/lib/fancyBox/jquery.fancybox.pack.js"></script>
<script src="/lib/block/jquery.blockUI.min.js"></script>	
<%' if cargar_mapa then %>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>

<script src="/lib/maps/infobox.js" type="text/javascript"></script>
<!-- script src="/_inc/javier/js/javier.js"></script -->
<script src="/js/selectDrop.js"></script>


<script>
	var startTime = new Date();
	var endTime = new Date();
	var FechaHoy = new Date();
	

	var inmuebles = [];
	var markerList = [];
	var infoboxesList = [];
	var seleccionados = [];
	var rentas_todas;
	var agentes_todos;
	
	var localidades = [];
	
	var limite_seleccion = 50;
	var centrarMapa = false;
	
	//var cargando = true;
	//var frm_data = "frmInfo_disp_tab=&lat=&lng=&zoom=&orden=&ordent=&ciudad=&min=&max=&agencia=&zona=&subzona=&calle=";
	var cargando = false;
	var frm_data = "";
	
	var faltan_inmuebles = 0;
	
	var counter = 0;
	//var calc_renta;
	
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
			/*
			opacity: .5, 
			*/
			/*
			backgroundColor: "#000", 
			"-webkit-border-radius": "10px", 
			"-moz-border-radius": "10px", 

			color: "#fff" 
			*/
			width: "none"
		},
		overlayCSS: {
			backgroundColor: "#fff",
			opacity: 0.3,
			margin: "auto"
		}	
	};
	/*
	var block_opts = {
		message: "<img src='/img/ajax-loader.gif'>",
		css: { 
			border: "none", 
			padding: "0px", 
			backgroundColor: "none",
			//backgroundColor: "#000", 
			//"-webkit-border-radius": "10px", 
			//"-moz-border-radius": "10px", 
			//opacity: .5, 
			//color: "#fff" 
			width: "none"
		},
		overlayCSS: { backgroundColor: "#00f" }
	}
	*/
	var swMostrarDiapositivas = true;
	
	var reload_map = false;
	<% 
	settab = "map"
	if request.form("tab")<>"" then 
		settab = request.Form("tab")
	end if
	if request.form("frmInfo_disp_tab")<>"" then 
		settab = request.Form("frmInfo_disp_tab")
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
	
</script>



<%' end if %>
<style type="text/css">
	#myMap {
		width: 100%;
		height: 480px;
		z-index: 0;
		position: relative;
	}
	
	input.warning {
		color:red;
	}
	
	#depura {
		clear:both;
		display:block;
		font-size: 14px;
		margin: 3px;
		color: #C94307;
		display: none;
	}
	.depura-filtros {
		clear:both;
		display:block;
		font-size: 14px;
		margin: 3px;
		color: #C94307;
		display: none;
	}
	
	<% if request.Cookies("dev")<>"" then %>
	.dispA-direccion .numcalle {
		display: inline-block !important;
		color:red;
	}
	<% end if %>
</style>
<%
session("origen")=""
dim busqueda

set rsBusq = Server.CreateObject("ADODB.Recordset")

settab = "map"
if request.form("tab")<>"" then 
	settab = request.Form("tab")
end if
if request.form("frmInfo_disp_tab")<>"" then 
	settab = request.Form("frmInfo_disp_tab")
end if

if session("navegador")="old" then 
	cargar_mapa = false
	settab = "list"
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
    	<section id="s_titulos" class="row">
		  <div class="caja">

<a id="scrollmap"></a>
<div class="miga"><h2 class="tit_miga02">Disponibilidad<% if request.Cookies("dev")<>"" then %> &nbsp; [<a href="/disponibilidad/">reset</a>]<% end if %></h2></div>

<div class="tit_resultados" id="informa_resultados">
	<p><span class="tit_busqueda"><%= ucase(frmInfo_busq) %></span><span class="tit_metros"><!--con un total de XXXX m2--></span><span class="tit_numero"><!--XXX resultados, --></span></p> 
</div>
<!--include virtual="/disponibilidad/preguntas_jp.asp" -->
<div class="PwTabs">
	
	<a id="verSubmenu" href="" class="btn bt_lupa animaHide" ><span class="ico icon-cross"></span><span class="hidden-xs"> ZONAS/SUBZONAS</span></a>
    
	<ul class="nav nav-tabs clearfix lineNavs" style="">
		<li id="li-tab-map" <% if settab="map" then %>class="active"<% end if %>><a href="#map" data-toggle="tab" aria-expanded="true" data-id="map"><span class="icon-map2"></span> Mapa</a></li>
		<li id="li-tab-list" <% if settab="list" then %>class="active"<% end if %>><a href="#list" data-toggle="tab" aria-expanded="false" data-id="list"><span class="icon-menu"></span> Listado</a></li>
	</ul>
    
	<div id="sticky-marcador"></div>
	<div class="divCajaCheck" style=" background-color:#FFF; display:none;">
		<div class="contadorSelect"><!-- style="margin-top:-45px;"  -->
			<div  class="contadorSelectGris"style="background-color:#dedede">
				<span class="numero" id="sel-count">0</span>
				<span class="icon-checkmark"></span>
			</div>
			<input id="cmd-read-sel" type="button" value="Ver fichas" class="btn btn-sm">
			<input id="cmd-clear-sel" type="button" value="Borrar" class="btn blancoHover btn-sm">
			<p class="hidden alert" id="informa-limite">El l&iacute;mite es <span id="limite_seleccion">0</span> </p>
		</div>
	</div>
	
	<% 'if 1=2 then 
	if request.Cookies("dev")<>"" then %>
    <div class="dev" style="padding:2px;">
    	<div class="pull-right">
	        <input type="button" value="AsociarDatos" onClick="AsociarDatos();" class="btn btn-sm" id="cmd-asociar">
            <input type="button" value="generar" onClick="generar();" class="btn btn-sm" id="cmd-generar">
            <input type="button" value="CargarDatos" onClick="CargarDatos();" class="btn btn-sm" id="cmd-cargar">
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
    
	<div class="tab-content">
    	
		<!--#include virtual="/disponibilidad2/inc/filtros.asp" -->
        
		<div class="tab-pane <% if settab="map" then %>active<% end if %>" id="map">
			<!--#include virtual="/disponibilidad/inc/diapositivas.asp" -->
			<div id="myMap" class="myMap"></div>
            <div class="divDisponMapa" id="myMapDisp"></div>
            <div class="dev" style="padding:4px; <% if request.Cookies("dev")="" then %>display:none;<% end if %>">
            	<span id="map-zoom"></span> // <span id="map-bounds"></span>
            </div>
            <div class="dev" style="padding:4px; <% if request.Cookies("dev")="" then %>display:none;<% end if %>">
            	<!--
            	
            	<input type="button" value="filtros" onClick="btSubmenu($('#verSubmenu'))" class="btn btn-sm"> &nbsp; 
            	<input type="button" value="xx" onClick="xx();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="xx" onClick="xx();" class="btn btn-sm"> &nbsp; 
                -->fit: 
                <input type="button" value="ini" onClick="f_bounds_ini();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="spain" onClick="f_bounds_spain();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="edificios" onClick="f_bounds_edificios();" class="btn btn-sm"> &nbsp; 
                // &nbsp; 
                block: 
                <input id="blockButtonDef" type="button" value="default" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButtonActual" type="button" value="actual" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButton1" type="button" value="block 1" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="blockButton2" type="button" value="block 2" class="btn btn-sm blancoHover"> &nbsp; 
                <input id="unblockButton" type="button" value="unblock" class="btn btn-sm blancoHover">
            </div>
		</div>
		<div class="tab-pane <% if settab="list" then %>active<% end if %>" id="list">
        	
			<div class="caja-operaciones">
            	
            	<div class="divDispon clearfix">
                	<div class="dispTitu">  <!--col-sm-8     -->
                        <table class="tbDispon">
                        <thead>
                            <tr class="cabeza">
								
                                <th class="tbDisp-Plta">Planta</th>
                                <th class="tbDisp-Tipo">Tipo</th>
                                <th class="tbDisp-Min"><a href="javascript:ordenar('min');" data-field="min">M&iacute;n</a></th>
                                <th class="tbDisp-Max"><a href="javascript:ordenar('max');" data-field="max">M&aacute;x</a></th>
                                <th class="tbDisp-Renta">Renta<br>Salida</th> 
                                <th class="tbDisp-Fecha">@Fecha</th> 
                            </tr>
                        </thead>
                        </table>
                	</div>
                    <form name="frm_titulos" id="frm_titulos" method="post" action="/articulos/">
                    <div id="div_titulos"><!--include virtual="/disponibilidad2/titulos.asp" --></div>
                    </form>
            	</div>
            </div>
            
		</div>
	</div>
    
</div><!-- // PwTabs --> 
  
			</div>
		</section>
        <% if request.Cookies("dev")<>"" then %>
    	<section class="caja">
        	<% for each elto in request.Form 
            %><li><%= elto %>: <%= request.Form(elto) %></li>
        <% next %>
        </section>
        <% end if %>
	</div>
    <!--#include virtual="/inc/body-footer.asp" -->
<script>
	/**********************************************/
	var datos_mapa = "";
	var datos_cargados = false;
	
	<% if request.Form("zoom")="" then %>
		//opciones = {zoom: 6, center: {lat: 40.45509438392602, lng: -3.692486281662004}};	//peninsulas
		opciones = {zoom: 4, center: {lat: 36.095226722498644, lng: -6.59621130000005}};	//europa
		//opciones = {zoom: 4, center: {lat: 40.50785648293567, lng: -3.692621014788756}};	//mad
		//opciones = {zoom: 4, center: {lat: 41.434695065809805, lng: 2.135699999999929}};	//bcn
	<% else %>
		opciones = {zoom: <%= request.Form("zoom") %>, center: {lat:<%= request.Form("lat") %>, lng:<%= request.Form("lng") %>}};	//, mapTypeControl: false
	<% end if %>
	var map = new google.maps.Map(document.getElementById("myMap"), opciones );
	console.log("cargando mapa...")
	//$("#myMap").block(block_opts);
	
	var bounds_all = new google.maps.LatLngBounds();
	var bounds = new google.maps.LatLngBounds();
	
	google.maps.event.addListener(map, "bounds_changed", function() {
		if (act_map.zoom==map.getZoom() & act_map.lat==map.getCenter().lat() & act_map.lng==map.getCenter().lng()) {return}	//act_zoom
		if (map.getZoom()==0) {
			return false;
		}

		if (cargando) {
			console.log("bounds_changed cancelado (cargando)");
			return false;
		}

		$("#map-bounds").html(map.getBounds().toString());
		$("#map-zoom").html(map.getZoom());
		
		act_map.zoom = map.getZoom();
		act_map.lat = map.getCenter().lat();
		act_map.lng = map.getCenter().lng();
		
		//$("#frm_preguntas input[name='lat']").val(act_map.lat);
		//$("#frm_preguntas input[name='lng']").val(act_map.lng);
		//$("#frm_preguntas input[name='zoom']").val(act_map.zoom);
		
		//console.log("counter < %= counter %>", datos_mapa)
		
		<% 'if counter>0 then %>
		if (map.getZoom()<13) {
			if (datos_mapa=="boxes") {
				//console.log(".getZoom()<13");
				OcultaBoxes();
				MuestraMarkers();
			}
			
		} else {				
			if (datos_mapa=="markers") {
				//console.log(".getZoom()>=13");
				OcultaMarkers();
				MuestraBoxes();	
			}
		};
		<% 'end if %>
	})
	
	google.maps.event.addListener(map, "idle", function() {
		if (!cargando) {
			return false;
		}
		
		var tt0 = new Date();
	  	
		//CargarDatos();
		
		var tt1 = new Date();
		console.log("idle:", tt1-tt0 + " ms");
		
	})
	
	/**********************************************/
	
	
	function recolocarContador() {
		var window_top = $(window).scrollTop();
		var div_top = $("#sticky-marcador").offset().top;
		if (window_top > div_top) {
			//alert("salta")
		   $(".divCajaCheck").addClass("stick");
		} else {
		   $(".divCajaCheck").removeClass("stick");
		}
	}
	
	$(window).scroll(recolocarContador);
	recolocarContador();
	
	function sel_inm(inm) {
		//console.log("sel_inm", inm);
		$("#chkDisp" + inm).click();
		//mapalista(inm);
		return false;
	}
	
	function CargarDatos() {
		//alert("cargando !");
		var t0 = new Date;
		if (cargando) {
			console.log("CargarDatos: cancelado (cargando=true)");
			return false;
		}
		var tmp_data = $("#frm_preguntas").serialize();
		if (frm_data==tmp_data) {
			console.log("CargarDatos: cancelado (frm_preguntas sin cambios)");
			return false;
		}
		
		//console.log("CargarDatos");
		$("#myMap").block(block_opts);
		cargando = true;
		frm_data = tmp_data;
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setZoom(6);
		
		$("#myMapDisp.divDisponMapa").hide("fast", "", function() {$("#myMapDisp").html("")});
		//if (poligono) poligono.setMap(null);
		
		$.each(markerList, function(ii, marker) {
			marker.setMap(null);
		});
		$.each(infoboxesList, function(ii, infobox) {
			//console.log("close" + ii, infobox)
			infobox.hide();
			infobox.close;
		});
		markerList = [];
		infoboxesList = [];
		
		inmuebles = [];
		seleccionados = [];
		
		//$("#div_titulos").html("");
		cargando = true;
		
		if ($("#frmInfo_disp_tab").val()=="list") {
			reload_map = true;
			console.log("tabmap <> map => reload_map=" + reload_map);
		}
		
		$.ajax({
			url: "/disponibilidad/data/ajax.asp",
			data: $("#frm_preguntas").serialize(),
			type: "POST",
			success: function(recibe) {
				//rentas_todas = $.parseJSON(recibe)
				$("#div_titulos").html(recibe);
				generar();
				$("#cmd-cargar").addClass("blancoHover");
				//$("#myMap").unblock();	//ya desbloqueamos al terminar carga ¿?
				if ($("#id_subzona").val()!="") {
					EdificiosSubzona();
				}
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
		var t1 = new Date();
		console.log("CargarDatos:", t1-t0 + " ms");
		
		
		return false;
	}
	
	function CambiaLocalidad() {
		console.log("CambiaLocalidad")
		//$("#zona>option").each(function(index, elto) {
		//	$(elto).prop("selected", null)
		//});
		map.setCenter(opciones.center);
		map.setZoom(opciones.zoom);
		
		CargaSubzonas();
		CargaAgencias();
		$("#id_zona").val("");
		$("#zona").val("");
		
		LimpiaCalles();
		
		if ($("#ciudad-filtro").val().trim().toLowerCase()=="madrid" | $("#ciudad-filtro").val().trim().toLowerCase()=="barcelona") {
			$("#filtrosDisponibilidad").show();
		} else {
			$("#filtrosDisponibilidad").hide();
		}
		
		CargarDatos();
		
	}

	function CargaSubzonas() {
		$("#id_subzona").val("");
		$("#subzona").val("");
		//console.log("CargaSubzonas", $("#frm_preguntas").serialize());
		$("#li-subzonas").load(
			"/disponibilidad/data/ul_subzonas.asp", 
			$("#frm_preguntas").serialize(), 
			function(recibe) {
				//console.log("li-subzonas, recibido")
			}
		);
	}
	
	function CargaAgencias() {
		//console.log("CargaAgencias");
		$("#dropdown-agencias").load(
			"/disponibilidad/data/select_agencias.asp", 
			$("#frm_preguntas").serialize(), 
			function(recibe) {
				$("#dropdown-agencias").fnSelectDrop();
				$(window).on("resize", function(){ $("#dropdown-agencias").fnSelectDrop();});
				//$(".selectDrop").fnSelectDrop();/*"red"*/
				//$(window).on('resize', function(){ $(".selectDrop").fnSelectDrop();}); /*"yellow"*/
			}
		);
	}
	
	function CambiaZona(id) {
		//var xxx = $($("#ul-zonas>li[class='active']>a")[0]).data("value");
		//console.log("CambiaZona", xxx)
		
		$("#id_zona").val( id );
		var z = $("#ul-zonas>[data-id='" + id + "']>a").text();
		$("#zona").val( z );
		
		$("#id_subzona").val("");
		$("#subzona").val("");
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		$.each(markersZona, function(ii, marker) {
			marker.setMap(null);
		})
		markersZona = [];
		
		CargarDatos();
	}
	
	function EdificiosSubzona() {
		console.log("EdificiosSubzona", $("#id_subzona").val());
		var ids = [];
		$.each($(".dispA"), function (ii) {
			ids.push($(this).data("id"));
		})
		var datos = { id: $("#id_subzona").val(), ids: ids.join(",") };
		//console.log(ids);
		
		$.ajax({
			url: "/disponibilidad/data/subzona-edificios.asp",
			data: datos,
			type: "POST",
			success: function(recibe) {
				//console.log(recibe);
				counter = 0;
				var points = $.parseJSON(recibe);
				$.each(points, function(ii, punto) {
					//console.log(ii, punto);
					var myLatlng = new google.maps.LatLng(punto.lat, punto.lng);
					var marker = new google.maps.Marker({
						map: map, 
						<% if request.Cookies("dev")<>"" then %>title: "[" + punto.id + "] " + punto.nombre_completo,<% end if %>
						visible:true,
						position: myLatlng,
						icon: "/img/mapa.png"
						
					});
					markersZona[counter] = marker;
					
					counter++;
				});
			}
		});
	}
	
	function CambiaSubzona(id) {
		//xxx = $("#ul-subzonas>li[class='active']>a")[0];
		//console.log("CambiaSubzona");
		//console.log(id);
		
		$("#id_subzona").val( id );
		var sz = $("#ul-subzonas>[data-id='" + id + "']>a").text();
		//console.log("subzona", id, sz)
		$("#subzona").val( sz );
		$("#id_zona").val("");
		$("#zona").val("");
		
		//CargarDatos();
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		console.log("CambiaSubzona", markersZona.length)
		$.each(markersZona, function(ii, marker) {
			marker.setMap(null);
		})
		markersZona = [];
		
		if (id=="") {
			console.log("sin subzona")
			return false;
		}
		var nbounds = new google.maps.LatLngBounds();
		//nbounds = map.getBounds();
		
		$.ajax({
			url: "/disponibilidad/data/subzonas-coordenadas.asp",
			data: "id=" + id,
			type: "POST",
			success: function(recibe) {
				//console.log(recibe);
				puntos = $.parseJSON(recibe);
				$.each(puntos, function(ii, punto) {
					//console.log(ii, punto);
					tmp_coords.push(punto);
					var p = new google.maps.LatLng(punto);
					//console.log(nbounds);
					nbounds.extend(p);
				});
				//console.log(tmp_coords);
				
				poligono = new google.maps.Polygon({
					paths: tmp_coords,
					strokeColor: "#000000",	//sz.color_zona, // "blue"
					strokeOpacity: .9,
					strokeWeight: 1,
					fillColor: "#52aaec",
					fillOpacity: 0.7  //0.2
				});
				poligono.setMap(map);
				map.fitBounds(nbounds);
				
				//EdificiosSubzona();
				
				CargarDatos();
				
				
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	function f_bounds_spain() {
		console.log("bounds_spain: NADA");
		//console.log(bounds_spain);
		//map.fitBounds(bounds_spain);
	}
	function f_bounds_ini() {
		//console.log("opciones.center")
		map.setCenter(opciones.center);
		//map.panTo(opciones.center);
		map.setZoom(opciones.zoom);
	}
	function f_bounds_edificios() {
		if (inmuebles.length==0) {
			console.log("sin edificios");
			return false;
		}
		var tmp_bounds = new google.maps.LatLngBounds();
		$.each(inmuebles, function(ii, inmueble) {
			var myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
			tmp_bounds.extend(myLatlng);
			map.fitBounds(tmp_bounds);
			//map.panToBounds(tmp_bounds);
		});
		//map.fitBounds(tmp_bounds);
		//map.panToBounds(tmp_bounds);
	}
	
	function f_ver_filtros() {
		btSubmenu($('#verSubmenu'));
	}
	
	function CiudadDisponible(ciudad) {
		for (var i = 0; i < localidades.length; i++) {
			//console.log(i, localidades[i])
			if (localidades[i].localidad == $.trim(ciudad).toUpperCase()) {
				return true;
			}
		}
		return false;
	}
	
	function generar() {
		//if (!cargando) {
		//	console.log("generar CANCELADO (!cargando)");	
		//	return false
		//};
		
		counter=0;
		var t0 = new Date;
		
		//actZoom = map.getZoom();
		//console.log("sql_inmuebles: <%= sql_inmuebles %>")
		
		//bounds_all = new google.maps.LatLngBounds();
		$.each(inmuebles, function(ii, inmueble) {
			if ( inmueble.lat==null ) {
				//var listItem = $("<li/>").text(inmueble.id + ', ' + inmueble.nombre);
				//faltan_inmuebles++;
				//$("#faltan_inm").append(listItem);
				console.log("FALTAN coordenadas: ", inmueble.id + ', ' + inmueble.nombre)
				
			} else {
				var myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
				<% 'if request.form("lat")="" then %>
//				if ( $("#frm_preguntas input[name='lat']").val()=="" ) {
				//	console.log("centrando mapa")
				//	bounds_all.extend(myLatlng);
				//	map.fitBounds(bounds_all);
				//	//map.panToBounds(bounds_all);
//				}
				<%' end if %>
				var icono;
				var hoyhoy = new Date();
				var hoydd = hoyhoy.getDate();
				var hoymm = hoyhoy.getMonth()+1;
				var hoyyyyy = hoyhoy.getFullYear();

				if(hoydd<10) {
					hoydd='0'+hoydd;
				} 
				
				if(hoymm<10) {
					hoymm='0'+hoymm;
				} 

				hoyhoy = hoydd+'/'+hoymm+'/'+hoyyyyy;
				var strDF = inmueble.disponible_fecha;
				var resDF = strDF.split("/");
				var fecha_texto = resDF[2]+"-"+resDF[1]+"-"+resDF[0];
				var strDF2 = hoyhoy;
				var resDF2 = strDF2.split("/");
				var fecha_texto2 = resDF2[2]+"-"+resDF2[1]+"-"+resDF2[0];

 				ms = Date.parse(fecha_texto);
				if(Date.parse(fecha_texto)<Date.parse(fecha_texto2)){icono="/img/ico-mapa02.png";}else{icono="/img/ico-mapa-naranja.png";}
				icono="/img/ico-mapa01.png"; // quitar esta linea para diferenciar disponibilidad futura
				//console.log("inm:"+ inmueble.id + "-"+Date.parse(fecha_texto)+" hoy:"+Date.parse(fecha_texto2));
				var marker = new google.maps.Marker({
					id: inmueble.id,
					map: map, 
					title: inmueble.nombre_completo,
					visible:false,
					position: myLatlng,
					icon:  icono
					
				});
				markerList[counter] = marker;
				
				counter++;
				
			}
			
			
		});
		
		//$(".divPreguntas").addClass("activo");
		if ($("#id_subzona").val()=="") {
			f_bounds_edificios();
		}
		AsociarDatos();
		
		actZoom = map.getZoom();
		//console.log(" mostrar desde generar: " + actZoom);
				
		if (actZoom<13) {
			MuestraMarkers();
		} else {
			//OcultaMarkers();
			MuestraBoxes();
		}	
		
		<% if session("pw_ws").accesoDisponibilidad then %>
		/*
		$.each(rentas_todas, function(jj, renta) {
			var inm = inmueble(renta.id_inmueble);
			if (inm) {
				inm.renta = { min: renta.renta_min, max: renta.renta_max, media: renta.renta_media} 
				var calc_renta = "" + inm.renta.min;
				if (inm.renta.max!=inm.renta.min) {
					calc_renta = calc_renta + "/" + inm.renta.max;
				}
				calc_renta = calc_renta.replace(".", ",");
				//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
				$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
			}
		});
		
		$.each(agentes_todos, function(jj, agente) {
			var inm = inmueble(agente.id_inmueble);
			if (inm) {
				if (!inm.agentes) inm.agentes = [];
				
				inm.agentes.push( { nombre: agente.empresa, id: agente.id_empresa, tipo: agente.tipo, logotipo: agente.logotipo} );
				
				var res = "";
				if (agente.logotipo === null) {
					if (agente.nombre=="PROPIEDAD") {
						res = "Propiedad";
					} else {
						$("#faltan_img").append( $("<li/>").text(agente.id_empresa + ', ' + agente.empresa) )
					}
					
				} else {
					img =  new Image();
					img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
					images.push(img);
					
					res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
				}
				$("#inm_" + inm.id + "-intermediario").append(res);
				
			}
		});
		*/
		<% end if %>
		
		cargando = false;
		$("#myMap").unblock();
		
		var t1 = new Date();
		console.log("generar:", t1-t0 + " ms");
		
		$("#cmd-generar").addClass("blancoHover");
		
	}	
	
	function AsociarDatos() {
		//console.log("AsociarDatos", "CANCELADO")
		//return false;
		var t0 = new Date;
		
		if (rentas_todas) {
			$.each(rentas_todas, function(jj, renta) {
				var inm = inmueble(renta.id_inmueble);
				if (inm) {
					inm.renta = { min: renta.renta_min, max: renta.renta_max, media: renta.renta_media} 
					var calc_renta = "" + inm.renta.min;
					if (inm.renta.max!=inm.renta.min) {
						calc_renta = calc_renta + "/" + inm.renta.max;
					}
					calc_renta = calc_renta.replace(".", ",");
					//calc_renta = calc_renta + " <span>&euro;/m&sup2;</sup>";
					$(".tbDisp-Renta[data-id='" + inm.id + "']").html( calc_renta )
				}
			});
		}
		
		if (agentes_todos) {
			$.each(agentes_todos, function(jj, agente) {
				var inm = inmueble(agente.id_inmueble);
				if (inm) {
					if (!inm.agentes) inm.agentes = [];
					
					inm.agentes.push( { nombre: agente.empresa, id: agente.id_empresa, tipo: agente.tipo, logotipo: agente.logotipo} );
					
					var res = "";
					if (agente.logotipo === null) {
						if (agente.nombre=="PROPIEDAD") {
							res = "Propiedad";
						} else {
							$("#faltan_img").append( $("<li/>").text(agente.id_empresa + ', ' + agente.empresa) )
						}
						
					} else {
						img =  new Image();
						img.src = "/_inc/javier/img/empresas/" + agente.logotipo;
						images.push(img);
						
						res = '<img src="/_inc/javier/img/empresas/' + agente.logotipo + '">';
					}
					$("#inm_" + inm.id + "-intermediario").append(res);
					
				}
			});
		}
		
		var t1 = new Date();
		console.log("AsociarDatos:", t1-t0 + " ms");
		
		$("#cmd-asociar").addClass("blancoHover");
	}
	
	
	function inmueble( id ) {
		for (var i = 0; i < inmuebles.length; i++) {
			if (inmuebles[i].id == id) {
				return inmuebles[i];
			}
		}
		console.log("inmueble no encontrado: " + id);
	}
	
	function contenidoInfoBox( inmueble ) {
		var precio;
		var msg1="";
		var msg2="";
		
		var marcados = $("#frm_titulos input:checkbox:checked");
		var marcado = "";
		$.each(marcados, function(ii, val) {
			if (val.value==inmueble.id) {
				marcado = " checked";
				return false;
			}
		});
		
		<% if session("pw_ws").accesoDisponibilidad then  %>
		if (inmueble.renta) {
			precio = "" + inmueble.renta.min;
			if (inmueble.renta.max!=inmueble.renta.min) {
				precio = precio + "/" + inmueble.renta.max;
			}
			precio = precio.replace(".", ",");
			precio = precio + "</span> <span>&euro;/m&sup2;</sup>";
		} else {
			msg1 = "sin rentas";
			precio = "N/D ";
		}
		<% else %>
			precio = "<img src='/img/lock.svg' width='14' height='14'/>";
		<% end if %>
		
		if (!(inmueble.agentes) || inmueble.agentes.length==0) {
			msg2 = "sin agencia";
			//console.log("   sin agencia, id_inmueble: " + inmueble.id + ' - ' + inmueble.nombre)
		}
		if (msg1 + msg2!="") {
			if (msg1!="") { if (msg2!="") {msg2 = ", " + msg2} }
			//$("#informa").append( $("<li/>").text(inmueble.id + ' - ' + inmueble.nombre + ' : ' + msg1 + msg2) )
			//console.log( inmueble.id + ' - ' + inmueble.nombre + ' : ', msg1, msg2)
		}
		
		var res = '';
		res = res + '<div class="infoboxPosition" data-id="' + inmueble.id + '">';
		res = res + '<div class="popover top disp" id="">';
		
		res = res + '<div class="popover-check">';
		res = res + '<button type="button" id="chkMap' + inmueble.id + '" class="btn btnCheck' + marcado + '" onClick="sel_inm(' + inmueble.id + ');"></button>';
		res = res + '</div>';
		
		res = res + '<table class="popover-tbDisp" onclick="mapalista(' + inmueble.id + ')">';
		res = res + '<tbody>';
		
		<% if session("pw_ws").accesoDisponibilidad then  %>
			var sup_min = inmueble.disponible_min.toLocaleString("es", { maximumFractionDigits: 0});
			var sup_max = inmueble.disponible_max.toLocaleString("es", { maximumFractionDigits: 0});
		<% else %>
			var sup_min = "<img src='/img/lock.svg' width='14' height='14'/>";
			var sup_max = "<img src='/img/lock.svg' width='14' height='14'/>";
		<% end if %>
		
		<% if request.Cookies("dev")<>"" then %>
		res = res + '<tr>';
		res = res + '<td colspan="2">id: ' + inmueble.id + '</td>';
		res = res + '<tr>';
		res = res + '</tr>';
		res = res + '<td colspan="2">' + inmueble.nombre_completo + '</td>';
		res = res + '</tr>';
		<% end if %>
		
		res = res + '<tr>';
		res = res + '<td><span>min</span><span>' + sup_min + '</span></td>';
		res = res + '<td><span>max</span><span>' + sup_max + '</span></td>';
		res = res + '</tr>';
		
		res = res + '<tr>';
		res = res + '<td colspan="2"><span>Renta Salida</span><span>' + precio + '</span></td>';
		res = res + '</tr>';
		
		<% if session("pw_ws").accesoDisponibilidad then  %>
		res = res + '<tr><td colspan="2">';
		if (inmueble.agentes) {
			for (var jj=0; jj<inmueble.agentes.length; jj++) {
				if (inmueble.agentes[jj].logotipo === null) {
					if (inmueble.agentes[jj].nombre=="PROPIEDAD") {
						res = res + 'Propiedad';
					} else {
						//console.log("falta img: " + inmueble.agentes[jj].nombre)
					}
				} else {
					res = res + '<img src="/_inc/javier/img/empresas/' + inmueble.agentes[jj].logotipo + '">';
				}
			};
		}
		res = res + '</td></tr>';
		<% end if %>
		
		res = res + '</tbody>';
		res = res + '</table>';
		
		res = res + '<div class="arrow" style="left: 47.6449%;"></div>';
		
		res = res + '</div>';
		res = res + '</div>';
		
		return(res);
	}
	
	function MuestraMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(true);
		}
		datos_mapa = "markers";
		$("#datos_mapa").val(datos_mapa);
	}
	
	function OcultaMarkers() {
		for (ii=0; ii<markerList.length; ii++) {
			markerList[ii].setVisible(false);
		}
	}
	
	function MuestraBoxes() {
		if (infoboxesList.length==0) {
			GenerarInfoBoxes();
			
		} else {
			for (ii=0; ii<infoboxesList.length; ii++) {
				infoboxesList[ii].setVisible(true);
			}
		}
		
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].setVisible(true);
		}
		datos_mapa = "boxes";
		$("#datos_mapa").val(datos_mapa);
		//console.log("MuestraBoxes");
	}
	
	function OcultaBoxes() {
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].hide();
		}
	}
	
	function GenerarInfoBoxes() {
		console.log("  GenerarInfoBoxes")
		var tt0 = new Date();
		for (ii=0; ii<inmuebles.length; ii++) {
			var myLatlng = new google.maps.LatLng(inmuebles[ii].lat, inmuebles[ii].lng);
			var infobox = new InfoBox({
				content: contenidoInfoBox( inmuebles[ii] ),	//document.getElementById("infobox")
				//visible:false,
				disableAutoPan: true,
				//enableEventPropagation: true,
				maxWidth: 150,
				//pixelOffset: new google.maps.Size(-40, -45),
				zIndex: 1000,
				closeBoxURL: "",
				position: myLatlng
			});
			infobox.open(map);
			
			infoboxesList.push( infobox )
			
		}
			
		var tt1 = new Date();
		console.log("GenerarInfoBoxes()", tt1-tt0 + " ms");
	}
	
	function mapalista(inm) {
		//$(".infoboxPosition[data-id='" + inm + "']").parent().css("z-index", 2000 );
		console.log("mapalista [" + inm + "]");
		/*
		$("#myMapDisp").load(
			"/disponibilidad/data/detalle_map.asp", 
			"id="+inm, 
			function(response) {
				$("#myMapDisp").show("slow");
			}
		)
		*/
		$.ajax({
			type: "POST",
			url: "/disponibilidad/data/detalle_map.asp",
			data: {'id':inm, 'secc':'disponibilidad'},
			success: function(data, txtStatus, jqSHR) {
				$("#myMapDisp").html(data);
				$("#myMapDisp").show("slow");
			}
		})
	}
	
	function ver_seleccionados() {
		//console.log("ver_seleccionados");
		OcultaMarkers();
		//MuestraBoxes();
		datos_mapa = "boxes";
		$("#datos_mapa").val(datos_mapa);
		
		for (ii=0; ii<markerList.length; ii++) {
			var chk = "#chkDisp" + $(infoboxesList[ii].content_).data("id")
			//console.log(chk, $(chk).is(":checked"))
			infoboxesList[ii].setVisible( $(chk).is(":checked") );
			markerList[ii].setVisible( $(chk).is(":checked") );
		}
	}
	
	function centerMap() {
		if (cargando) {
			console.log("centerMap: EXIT [CARGANDO]");
			return false
		} else {
			console.log("centerMap")
		}
		
		bounds = new google.maps.LatLngBounds();
		
		var marcados = $("#frm_titulos input:checkbox:checked");
		console.log(marcados)
		
		$.each(marcados, function(ii, checkbox) {
			var inm = inmueble( $(checkbox).val() )
			var myLatLng = new google.maps.LatLng(inm.lat, inm.lng);
			console.log(ii, inm.lat, inm.lng)
			bounds.extend(myLatLng);
		})
		map.fitBounds(bounds);
		//map.panToBounds(bounds);
		
		$("#map-bounds").html(map.getBounds().toString());
		$("#map-zoom").html(map.getZoom());
		
	}
	
	function FitMap() {
		console.log("FitMap");
		
		if (reload_map) {
			console.log("FitMap", "reload_map: TRUE")
			google.maps.event.trigger(map, "resize");
			
			<% if request.Form("lat")="" then %>
				console.log("set center", "def", "def", "¿?")
				//map.setCenter( {lat: 40.45509438392602, lng: -3.692486281662004} );
				//map.setZoom(6);
				
				console.log("fit map");;
				
				map.fitBounds(bounds_all);
				
			<% else %>
				console.log("set request.form")
				console.log(<%= request.Form("lat") %>, <%= request.Form("lng") %>, <%= request.Form("zoom") %>)
				//map.panTo( {lat:< %= request.Form("lat") %>, lng:< %= request.Form("lng") %>} );
				map.setCenter( {lat:<%= request.Form("lat") %>, lng:<%= request.Form("lng") %>} );
				map.setZoom(<%= request.Form("zoom") %>);
			<% end if %>
			
			reload_map = false;
			
		}
		
		if (centrarMapa) {
			console.log("FitMap", "centrarMapa: TRUE");
			centerMap();
			centrarMapa=false;
		}
		
	}
	
	function ordenar(ord) {
		console.log("ordenar")
		
		var altura = $("#div_titulos").height();
		$("#div_titulos").css("min-height", altura + "px");
		
		if ($("#frm_preguntas input[name='orden']").val()==ord) {
			if ($("#frm_preguntas input[name='ordent']").val()=="asc") {
				$("#frm_preguntas input[name='ordent']").val("desc")
				
			} else if ($("#frm_preguntas input[name='ordent']").val()=="desc") {
				$("#frm_preguntas input[name='orden']").val("")
				$("#frm_preguntas input[name='ordent']").val("")
				
			} else {
				$("#frm_preguntas input[name='ordent']").val("asc")
				
			};
			
		} else {
			$("#frm_preguntas input[name='orden']").val(ord);
			$("#frm_preguntas input[name='ordent']").val("asc")
		}
		
		//$("#frm_preguntas").submit();
		
		var datos = $("#frm_preguntas").serialize() + "&ordenando=true"
		var sel_arr = $("#frm_titulos input:checkbox:checked");
		$.each(sel_arr, function(ii, elto) {
			datos = datos + "&dis=" + $(elto).val();
			//$("#chkDisp" + elto).click();
		})
		//console.log(datos)
		
		$.ajax({
			url: "/disponibilidad/data/ajax.asp",
			data: datos,
			type: "POST",
			success: function(recibe) {
				$("#div_titulos").html(recibe);
				$("#div_titulos").css("min-height", "");
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	
$(document).ready(function() {
	console.log("ini document.ready")
	
	$("ul.lineNavs>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		
		console.log("tab change - " + tab )
		$("#frmInfo_disp_tab").val(tab);
		$("#frm_titulos input[name='tab']").val( tab );
		
		<% 'if cargar_mapa then %>
		if (tab=="map") {
			FitMap()
		}
		<% 'end if %>
	});
	
	$("ul#nav-filtros>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		$("#zona").val("");
		$("#subzona").val("");
		//if (poligono) poligono.setMap(null);
		//CargarDatos();
	});
	
	
	$("#blockButtonActual").click(function() {
		$("#myMap").block( block_opts ); 
	});
	$("#blockButtonDef").click(function() {
		$("#myMap").block(); 
	});
	$("#blockButton1").click(function() {
		$("#myMap").block({
			message: "<img src='/img/ajax-loader.gif'>",
			css: {
				border: "none", 
				padding: "0px", 
				backgroundColor: "none",
				opacity: .8,
				left: "0px", 
				right: "0px", 
				/*
				opacity: .5, 
				*/
				/*
				backgroundColor: "#000", 
				"-webkit-border-radius": "10px", 
				"-moz-border-radius": "10px", 

				color: "#fff" 
				*/
				width: "none"
        	},
			overlayCSS: {
				backgroundColor: "#fff",
				opacity: 0.3,
				margin: "auto"
				}
		});
	});
	
	/*   jj  */
	
	$("#blockButton2").click(function() {
		$("#myMap").block({
			css: { 
				border: "none", 
				padding: "15px", 
				backgroundColor: "#000", 
				"-webkit-border-radius": "10px", 
				"-moz-border-radius": "10px", 
				opacity: .5, 
				color: "#fff" 
        	},
			overlayCSS: { backgroundColor: "#00f" }
		}); 
	});
	$("#unblockButton").click(function() {
		$("#myMap").unblock(); 
	});
	
	CargaSubzonas();
	CargaAgencias();
	
	if (swMostrarDiapositivas) {
		if (!($(".divPreguntas").hasClass("activo"))) {
			setTimeout( function () {
				$(".divPreguntas").addClass("activo");
				//$("#qCiudad").focus();
				//CargarDatos();
				//setTimeout( function () {
				//	generar();
				//}, 1000 );
				
			}, 1000 );
		}
	}
	//setTimeout( function () {
	//	generar();
	//}, 1000 );
	
	
	
	$.ajax({
		url: "/disponibilidad/data/ciudades.asp",
		type: "POST",
		success: function(recibe) {
			localidades = $.parseJSON(recibe);
			//console.log("localidades FIN");
		},
		error: function(xhr, status, err) {
			console.log("ERR localidades: " + err)
		}
	});
	//console.log("localidades INI");
	//localidades = < %= QueryToJSON(session("connPW"), "SELECT DISTINCT localidad FROM dirs_w_inmuebles WHERE (id_tipo_inmueble = 0) AND (disponible_fecha IS NOT NULL) AND (disponible_min > 0)").Flush %>;
	//console.log("localidades FIN");
	
	//CargarDatos();

	CambiaLocalidad('madrid');
	
	CambiaSubzona(84);

	//generar();
});
</script>


<% 
set rsBusq=nothing 
%>
</body>
</html>