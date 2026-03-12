<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Take Up</title>
	<!--#include virtual="/inc/head.asp" -->
    <!--
    <link href="/css/css-bootstrap/todo-bootstrap.css"  rel="stylesheet"  type="text/css" >
    -->
    <link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/tabs031-izq.css" rel="stylesheet" type="text/css">
	<!-- EXTRA  -->
	<link href="/css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">
	<link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/filtrosForm.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/elementosResultados.css" rel="stylesheet" type="text/css">
    
	<link href="/lib/fancyBox/jquery.fancybox.css" type="text/css" rel="stylesheet">
	<!-- link href="/lib/blockUI/block.css" rel="stylesheet" type="text/css" -->
    
<script src="/lib/fancyBox/jquery.fancybox.pack.js"></script>
<script src="/lib/blockUI/jquery.blockUI.min.js"></script>	
<%' if cargar_mapa then %>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX-HAhl6u-wxBKLQO31nH4vMUQ3w8cEoU&region=ES"></script>
<script src="/lib/maps/infobox.js" type="text/javascript"></script>
<!-- script src="/_inc/javier/js/javier.js"></script -->
<script src="/js/selectDrop.js"></script>
<script>
	var datos = [];
	var markerList = [];
	var infoboxesList = [];
	var seleccionados = [];
	var rentas_todas;
	var agentes_todos;
	
	var edif_todos = [];
	var edif_markers = [];
	//icon: "/img/ico-mapa02.png"
	//icon: "/img/ico-mapa-morado.png"
	var iconoActivo = "/img/ico-mapa02.png";
	
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
			backgroundColor: "#fff",
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
	
	'if settab <> "map" then %>
	//	reload_map = true;
	//	console.log("tabmap <> map => reload_map=" + reload_map);
	<% 'end if %>
	
	var act_map = {'zoom':0, 'lat': 0, 'lng': 0}
	var act_zoom = 0;
	
	var datos_mapa = "";
	var datos_cargados = false;
	
</script>
<%' end if %>
<style type="text/css">
	#myMap {
		width: 100%;
		height: 480px;
		z-index: 0;
		position: relative;
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
	<% end if %>
</style>
<%
dim busqueda

set rsBusq = Server.CreateObject("ADODB.Recordset")

settab = "map"
if request.form("tab")<>"" then 
	settab = request.form("tab")
end if

'if session("navegador")="old" then 
'	cargar_mapa = false
'	settab = "list"
'end if


'edificios todos
sql_edifs = sql_edifs & "id_tipo_inmueble=0 AND "
sql_edifs = sql_edifs & "id_pais=1 AND "
sql_edifs = sql_edifs & "lat IS NOT NULL AND "
sql_edifs = sql_edifs & "superf_br_alq IS NOT NULL AND "
sql_edifs = sql_edifs & "disponible_fecha IS NOT NULL"

sql_edifs = "SELECT id, nombre, lat, lng FROM inmuebles WHERE (" & sql_edifs & ")"
%>
</head>
<body>
	<!--#include virtual="/inc/body-header.asp" -->
<div class="container">
    	<section id="s_titulos" class="row">
		  <div class="caja">

<a id="scrollmap"></a>
<div class="miga"><h2 class="tit_miga02">Take Up <span>/ Disponibilidad</span><% if request.Cookies("dev")<>"" then %> &nbsp; [<a href="/takeup/">reset</a>]<% end if %></h2></div>
<div><%  
if request.Cookies("dev")("request")<>"" then
	for each elto in request.Form
		if request.Form(elto)<>"" then
			response.Write("<strong>" & elto & "</strong>: " & request.Form(elto) & " &nbsp; // ")
		end if
	next
end if
%></div>
<div class="tit_resultados" id="informa_resultados">
	<p><span class="tit_busqueda" id="informa-tit-busq"><%= ucase(frmInfo_busq) %></span><span class="tit_tipo" id="informa-tipo-busq"></span><span class="tit_numero" id="informa-num-busq"><!--XXX resultados, --></span><span class="tit_metros" id="informa-total-sup-busq"><!--con un total de XXXX m2--></span><span class="tit_metros" id="informa-total-edifs-busq"></span></p> 
</div>
<!--include virtual="/takeup/preguntas_jp.asp" -->
<div class="PwTabs">
	
	<a id="verSubmenu" href="" class="btn bt_lupa" data-clicks="false"><span class="ico icon-cross"></span><span class="hidden-xs"> TAKE UP</span></a>
    
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
	        <input type="button" value="Filtros" onClick="VerFiltros();" class="btn btn-sm">
            <!--
            <input type="button" value="AsociarDatos" onClick="AsociarDatos();" class="btn btn-sm" id="cmd-asociar">
            <input type="button" value="generar" onClick="generar();" class="btn btn-sm" id="cmd-generar">
            -->
            <input type="button" value="edifs." onClick="CargarEdificios();" class="btn btn-sm" id="cmd-cargar-edificios">
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
    
	<div class="tab-content activo confiltros">
    	
		<!--#include virtual="/takeup/inc/filtros.asp" -->
        
		<div class="tab-pane <% if settab="map" then %>active<% end if %>" id="map">
			<% 'if request.Form="" then %><!-- include virtual="/takeup/inc/diapositivas.asp" --><% 'end if %>
			<div id="myMap" class="myMap"></div>
            <div class="divDisponMapa" id="myMapDisp"></div>
            <!--<div class="leyendaMapa" id="">
                <p class=""><img src="/img/ico-mapa02.png" style="width: 8px;"> Take Up/Disponibilidad</p>
            	<p class=""><img src="/img/mapa.png"> Edificios registrados</p>
            </div>-->
            <div class="dev" style="padding:4px; <% if request.Cookies("dev")="" then %>display:none;<% end if %>">
            	<span id="map-zoom"></span> // <span id="map-bounds"></span>
            </div>
            <div class="dev" style="padding:4px; <% if request.Cookies("dev")="" then %>display:none;<% end if %>">
            	fit: 
                <input type="button" value="ini" onClick="f_bounds_ini();" class="btn btn-sm"> &nbsp; 
                <input type="button" value="fitMap" onClick="fitMap();" class="btn btn-sm"> &nbsp; 
                
            </div>
		</div>
		<div class="tab-pane <% if settab="list" then %>active<% end if %>" id="list">
        	
			<div class="caja-operaciones">
            	
            	<div class="divDispon clearfix">
            	   	<form name="frm_titulos" id="frm_titulos" method="GET" action="/articulos/">
        	            <div id="div_titulos"></div>
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
        	<% for each elto in request.form 
            %><li><%= elto %>: <%= request.form(elto) %></li>
        <% next %>
        </section>
        <section id="informaJP"></section>
        <% end if %>
	</div>
    <!--#include virtual="/inc/body-footer.asp" -->
<script>
	function formatear(num) {
		num +='';
		var splitStr = num.split('.');
		var splitLeft = splitStr[0];
		var splitRight = splitStr.length > 1 ? "," + splitStr[1] : '';
		var regx = /(\d+)(\d{3})/;
		while (regx.test(splitLeft)) {
			splitLeft = splitLeft.replace(regx, '$1' + "." + '$2');
		}
		return splitLeft + splitRight;
	}
	
	function VerFiltros() {
		if ($(".filtros-navs").hasClass("activo")) {
			$(".filtros-navs").removeClass("activo");
			$(".PwTabs>.tab-content").removeClass("confiltros");
		} else {
			$(".filtros-navs").addClass("activo");
			$(".PwTabs>.tab-content").addClass("confiltros");
		}
	}

	function recolocarContador() {
		var window_top = $(window).scrollTop();
		var div_top = $("#sticky-marcador").offset().top;
		if (window_top > div_top) {
		   $(".divCajaCheck").addClass("stick");
		} else {
		   $(".divCajaCheck").removeClass("stick");
		}
	}
	
	$(window).scroll(recolocarContador);
	recolocarContador();
	
	function btSubmenu(elemento) {
		var clicks = elemento.data("clicks");
		if (clicks) {
			$(".filtros-navs").addClass("activo");
			elemento.find("span.ico").removeClass("icon-search").addClass("icon-cross giro"); //icon-arrow-left2 
			$(".PwTabs>.tab-content").addClass("confiltros");
		} else {
			$(".filtros-navs").removeClass("activo");
			elemento.find("span.ico").removeClass("icon-cross giro").addClass("icon-search"); //icon-arrow-left2 
			$(".PwTabs>.tab-content").removeClass("confiltros");
		}
		elemento.data("clicks", !clicks);
		
		
		if ($(".PwTabs ul.nav>li.active a").data("id")=="map") {
		//if (!cargando) {
			setTimeout( function () {
				console.log("btSubmenu map resize")
				google.maps.event.trigger(map, "resize");
				console.log("  llamada fitMap desde btSubmenu()", "cargando: " + cargando)
				fitMap();
			}, 350 );
		}
		
	}
	
	$("#dropdown-year").fnSelectDrop();
	$(window).on("resize", function(){ $("#dropdown-year").fnSelectDrop();});
	
	$("#dropdown-ciudad").fnSelectDrop();
	$(window).on("resize", function(){ $("#dropdown-ciudad").fnSelectDrop();});
	
	function sel_inm(inm) {
		//console.log("sel_inm", inm);
		$("#chkDisp" + inm).click();
		//mapalista(inm);
		return false;
	}
	
	function TestForm() {
		var tmp_data = $("#frm_preguntas").serialize();
		tmp_data = tmp_data.replace("tab=list", "tab=");
		tmp_data = tmp_data.replace("tab=map", "tab=");
		
		if (frm_data==tmp_data) {
			console.log("TestForm: NO PASA (frm_preguntas sin cambios)");
		} else {
			console.log("TestForm: SÍ PASA");
			
		}
		return frm_data;
	}
	
	function CargarDatos() {
		//var t0 = new Date;
		if (cargando) {
			console.log("CargarDatos: cancelado (cargando=true)");
			return false;
		}
		var tmp_data = $("#frm_preguntas").serialize();
		tmp_data = tmp_data.replace("tab=list", "tab=");
		tmp_data = tmp_data.replace("tab=map", "tab=");
		
		if (frm_data==tmp_data) {
			console.log("CargarDatos: cancelado (frm_preguntas sin cambios)");
			return false;
		}
		
		//console.log("CargarDatos");
		$("#myMap").block(block_opts);
		$("#frm_titulos").block(block_opts);
		//$("#resumenGeneral").block(block_opts);	//{ message: null }
		
		cargando = true;
		frm_data = tmp_data;
		//map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
		//map.setZoom(6);
		
		$("#myMapDisp.divDisponMapa").hide("fast", "", function() {$("#myMapDisp").html("")});
		
		$.each(markerList, function(ii, marker) {
			marker.setMap(null);
		});
		$.each(infoboxesList, function(ii, infobox) {
			infobox.hide();
			infobox.close;
		});
		markerList = [];
		infoboxesList = [];
		
		datos = [];
		seleccionados = [];
		
		$("#div_titulos").html("");
		
		if ($("#tab").val()!="map") {
			reload_map = true;
			console.log("tabmap [" + $("#tab").val() + "] <> map => reload_map=" + reload_map);
		}
		
		<% 'if session("pw_ws").accesoTakeUp then %>
		CargaAgencias();
		<% 'end if %>
		
		$.ajax({
			type: "GET",
			url: "/takeup/data/resumen_registrados.asp",
			data: $("#frm_preguntas").serialize(),
			success: function(recibe, txtStatus, jqSHR) {
				var data = JSON.parse(recibe);
				$("#of-total").html(data.inmuebles);
				$("#sup-total").html(data.sba_total);
				
				if (data.inmuebles<1) {
					$("#informa-total-edifs-busq").html("");
				} else {
					$("#informa-total-edifs-busq").html("&nbsp;de " + data.inmuebles + " edifs. registrados");
				}
			}
		})
		
		$.ajax({
			url: "/takeup/resultados.asp",
			data: $("#frm_preguntas").serialize(),
			type: "POST",
			success: function(recibe) {
				$("#div_titulos").html(recibe);
				//$("#div_titulos").block(block_opts);
				
				generar();
				
				$("#cmd-cargar").addClass("blancoHover");
				setTimeout( function () {
					//console.log("frm_titulos.unblock");
					$("#frm_titulos").unblock();
				}, 350 );
				
				//$("#resumenGeneral").unblock();
				//if ($("#id_subzona").val()!="") {
				//	EdificiosSubzona();
				//}
				
				//limpiar frm_preguntas
				//$("#frm_preguntas input[name='zoom']").val("");
				//$("#frm_preguntas input[name='lat']").val("");
				//$("#frm_preguntas input[name='lng']").val("");
				$("#frm_preguntas input[name='zoom']").remove();
				$("#frm_preguntas input[name='lat']").remove();
				$("#frm_preguntas input[name='lng']").remove();
				
				//$("#frm_preguntas input[name='dis']").val("");
				//$("#frm_preguntas input[name='ope']").val("");
				$("#frm_preguntas input[name='dis']").remove();
				$("#frm_preguntas input[name='ope']").remove();
			}
			,
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
		//var t1 = new Date();
		//console.log("CargarDatos:", t1-t0 + " ms");
		
		return false;
	}
	
	function CargarEdificios() {
		var nn=0;
		
		$.ajax({
			url: "/takeup/data/edificios.asp",
			//data: $("#frm_preguntas").serialize(),
			//GET
			type: "POST",
			success: function(recibe) {
				edif_todos = $.parseJSON(recibe);
				$.each(edif_todos, function(ii, edif) {
					//console.log(ii, punto);
					
					icono = "/img/mapa.png";
					//if (edif.id=="4983") {
					//	console.log("  edif.id=4983", "n= " + nn);
					//	icono = "/img/mapicons/white/house.png"
					//}
					
					var myLatlng = new google.maps.LatLng(edif.lat, edif.lng);
					var marker = new google.maps.Marker({
						id: edif.id,
						map: map, 
						title: <% if request.Cookies("dev")<>"" then %>"[" + edif.id + "] " + <% end if %>edif.nombre,
						visible:true,
						position: myLatlng,
						icon: icono
					});
					edif_markers[nn] = marker;
					nn++;
				});
				//console.log("puntos cargados: " + nn)
			}
		})
		
	}
	
	function CambiaLocalidad() {
		//console.log("CambiaLocalidad")
		//$("#zona>option").each(function(index, elto) {
		//	$(elto).prop("selected", null)
		//});
		$("#frm_preguntas input[name='agencia']").val("");
//		map.setCenter(opciones.center);
//		map.setZoom(opciones.zoom);
		
		CargaSubzonas();
		//CargaAgencias();
		
		$("#id_zona").val("");
		$("#zona").val("");
		$("#id_subzona").val("");
		$("#subzona").val("");
		
		if ($("#ciudad-filtro").val().trim().toLowerCase()=="madrid" | $("#ciudad-filtro").val().trim().toLowerCase()=="barcelona" ){
			$("#filtrosDisponibilidad").show();
		} else {
			$("#filtrosDisponibilidad").hide();
		}
		
		CargarDatos();
		
	}
	
	function CargaSubzonas() {
		//console.log("CargaSubzonas");
		//$("#id_subzona").val("");
		//$("#subzona").val("");
		
		$("#li-subzonas").load(
			"/takeup/data/ul_subzonas.asp", 
			$("#frm_preguntas").serialize(), 
			function() {
				if ($("#frm_preguntas input[name='id_subzona']").val()!="") {
					$("#ul-subzonas li[data-id='" + $("#frm_preguntas input[name='id_subzona']").val() + "'] a").click();
				}
			}
		);
		
		$.each(poligonos, function(i, poligono){
			poligono.setMap(null);
		})
		
		$.ajax({
			url: "/takeup/data/subzonas.asp",
			data: $("#frm_preguntas").serialize(),
			type: "POST",
			success: function(recibe) {
				subzonas = $.parseJSON(recibe);
				$.each(subzonas, function(ii, sz) {
					sz.coordenadas = [];
				})
				
				$.ajax({
					url: "/takeup/data/subzonas-coordenadas.asp",
					data: $("#frm_preguntas").serialize(),
					type: "POST",
					success: function(recibe) {
						var puntos = $.parseJSON(recibe);
						$.each(puntos, function(ii, punto) {
							SubzonaById(punto.id_subzona).coordenadas.push(punto);
							var myLatLng = new google.maps.LatLng(punto["lat"], punto["lng"]);
							//bounds_subzonas.extend(myLatLng);
						})
						
						$.each(subzonas, function(ii, sz) {
							poligonos.push(new google.maps.Polygon({
								paths: sz.coordenadas,
								strokeColor: "black",
								strokeOpacity: .3,
								strokeWeight: 1,
								fillColor: "black",
								fillOpacity: 0.15
							}));
							poligonos[poligonos.length-1].setMap(map);
							
							poligonos[poligonos.length-1].id = sz.id;
							poligonos[poligonos.length-1].nombre = sz.nombre;
							
							//poligonos[poligonos.length-1].addListener('click', informaSubzona);
							poligonos[poligonos.length-1].addListener('click', function() { CambiaSubzona(this.id) });
							
							//if (sz.id==$("#save_zona>input[name='id']").val()) {
							//	poligonos[poligonos.length-1].setZIndex(1);
							//}
							attachPolygonInfoWindow(poligonos[poligonos.length-1], SubzonaById(sz.id).nombre);
						})
					
					},
					error: function(xhr, status, err) {
						console.log("ERR: " + err)
					}
				});
				
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		//return false;
	}
	
	function CargaAgencias() {
		var campos_validos = ["ciudad", "year", "id_zona", "id_subzona", "datos"];
		var lst = [];
		var temp = "";
		
		$.each($("#frm_preguntas").serialize().split("&"), function(ii, campo) {
			var elto = campo.split("=");
			var name = elto[0];
			var value = elto[1];
			if (value!="") {
				for (index in campos_validos) {
					if (campos_validos[index]==name) {
						lst.push(campo)
						return;
					}
				}
			}
			temp = lst.join("&");
		});
		
		if (temp==frm_agencias) {
			console.log("CargaAgencias cancelado - frm_data_agencia sin cambios");
			return false;
		}
		
		frm_agencias = temp;
		
		$("#tabla-agencias").load(
			"/takeup/data/tabla_agencias.asp", 
			$("#frm_preguntas").serialize(), 
			function(recibe) {}
		);
	}
	
	function CambiaZona(id) {
		//var xxx = $($("#ul-zonas>li[class='active']>a")[0]).data("value");
		//console.log("CambiaZona", xxx)
		
		$("#id_zona").val( id );
		var z = $("#ul-zonas>[data-id='" + id + "']>a").text();
		console.log( "CambiaZona JJ:" + z);
		//alert("z")
		if (z==""){
				$("#li-zonas>a").html('Zonas' + ' <span class="caret"></span>'  )
			} else {
				$("#li-zonas>a").html(z + ' <span class="caret"></span>'  )
				}
		$("#li-subzonas>a").html('Subzonas' + ' <span class="caret"></span>'  )
		
		$("#zona").val( z );
		console.log("CambiaZona", "reset id_subzona, subzona");
		$("#id_subzona").val("");
		$("#subzona").val("");
		
		//$("#frm_preguntas input[name='agencia']").val("");
		//$("#frm_preguntas input[name='agencia_nombre']").val("");
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		$.each(markersZona, function(ii, marker) {
			marker.setMap(null);
		})
		markersZona = [];
		
		CargarDatos();
	}
	
	google.maps.Polygon.prototype.my_getBounds=function(){
		var bounds = new google.maps.LatLngBounds()
		this.getPath().forEach(function(element,index){bounds.extend(element)})
		return bounds
	}
	function attachPolygonInfoWindow(polygon, html) {
		//console.log("attachPolygonInfoWindow", polygon, html);
		
		polygon.infoWindow = new google.maps.InfoWindow({
			content: html
		});
		
		//polygon.infoWindow.setPosition(polygon.my_getBounds().getCenter());
		//polygon.infoWindow.open(map);
		
		/**/
		google.maps.event.addListener(polygon, 'mouseover', function(e) {
			var latLng = e.latLng;
			//this.setOptions({fillOpacity:0.1});
			polygon.infoWindow.setPosition(latLng);
			polygon.infoWindow.open(map);
		});
		google.maps.event.addListener(polygon, 'mouseout', function() {
			//this.setOptions({fillOpacity:0.35});
			polygon.infoWindow.close();
		});
		
	}
	
	function CambiaSubzona(id) {
		//xxx = $("#ul-subzonas>li[class='active']>a")[0];
		//console.log("CambiaSubzona", "[" + id + "]");
		
		$("#id_subzona").val( id );
		var sz = $("#ul-subzonas>[data-id='" + id + "']>a").text();
		if (sz==""){
				$("#li-subzonas>a").html('Subzonas' + ' <span class="caret"></span>'  )
			} else {
				$("#li-subzonas>a").html(sz + ' <span class="caret"></span>'  );
				}
		$("#li-zonas>a").html('Zonas' + ' <span class="caret"></span>'  )

		//console.log("subzona", id, sz)
		$("#subzona").val( sz );
		$("#id_zona").val("");
		$("#zona").val("");
		
		//$("#frm_preguntas input[name='agencia']").val("");
		//$("#frm_preguntas input[name='agencia_nombre']").val("");
		//CargarDatos();
		
		if (poligono) poligono.setMap(null);
		var tmp_coords = [];
		//console.log("CambiaSubzona", markersZona.length)
		//$.each(markersZona, function(ii, marker) {
		//	marker.setMap(null);
		//})
		//markersZona = [];
		
		if (id=="" || id==undefined) {
			console.log("sin subzona >> CargarDatos()");
			CargarDatos();
			return false;
		}
		
		var nbounds = new google.maps.LatLngBounds();
		//nbounds = map.getBounds();
		var bounds_ops;
		
		
		$.ajax({
			url: "/takeup/data/subzona-coordenadas.asp",
			data: "id=" + id,
			type: "GET",
			success: function(recibe) {
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
					strokeColor: "#FF6701",
					strokeOpacity: .9,
					strokeWeight: 2,
					fillColor: "#FF981E",
					fillOpacity: 0.5
				});
				poligono.setMap(map);
				map.fitBounds(nbounds);
				
				//attachPolygonInfoWindow(poligono, SubzonaById(id).nombre);
				//EdificiosSubzona();
				
				CargarDatos();
				
				
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	function fitMap() {
		if (datos.length==0 || markerList.length==0) {
			map.setZoom(6);
			map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
			console.log("fitMap: cancelado - sin datos (center ini)");
			return false;
		}
		
		//if (cargando) {
		//	console.log("fitMap: cancelado", "cargando: " + cargando);
		//	return false;
		//}
		
		console.log("fitMap", "cargando: " + cargando);
		
		bounds_ops = new google.maps.LatLngBounds();
		$.each(
			markerList, 
			function(i,item){
				bounds_ops.extend(item.getPosition());
			}
		);
		map.fitBounds(bounds_ops);
		
	}
	
	function f_bounds_ini() {
		//console.log("opciones.center")
		map.setCenter(opciones.center);
		//map.panTo(opciones.center);
		map.setZoom(opciones.zoom);
	}
	function f_bounds_datos() {
		if (datos.length==0) {
			console.log("f_bounds_datos: sin datos");
			return false;
		}
		console.log("  llamada fitMap desde f_bounds_datos()");
		fitMap();
		
		return false;
		console.log("f_bounds_datos");
		var tmp_bounds = new google.maps.LatLngBounds();
		$.each(datos, function(ii, inmueble) {
			var myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
			tmp_bounds.extend(myLatlng);
			map.fitBounds(tmp_bounds);
			//map.panToBounds(tmp_bounds);
		});
		//map.fitBounds(tmp_bounds);
		//map.panToBounds(tmp_bounds);
	}
	
	//function f_ver_filtros() {
	//	btSubmenu($('#verSubmenu'));
	//}
	
	
	function generar() {
		counter=0;
		//var t0 = new Date;
		$.each(datos, function(ii, objeto) {
			if ( objeto.lat==null ) {
//				console.log("FALTA", objeto.id, objeto.nombre);
				
			} else {
				var myLatlng = new google.maps.LatLng(objeto.lat, objeto.lng);
				var marker = new google.maps.Marker({
					id: objeto.id,
					map: map, 
					title: objeto.nombre_completo,
					visible:false,
					position: myLatlng,
					//icon: "/img/ico-mapa02.png"
					//icon: "/img/ico-mapa-morado.png"
					icon: iconoActivo
				});
				markerList[counter] = marker;
				counter++;
			}
		});
		
		//$(".divPreguntas").addClass("activo");
		
		//console.log("  llamada: AsociarDatos()")
		AsociarDatos();
		
		actZoom = map.getZoom();
		if (actZoom<15) {
			MuestraMarkers();
		} else {
			MuestraBoxes();
		}	
		
		//if (!cargando) {
			if ($("#id_subzona").val()=="") {
				if ($("#frm_preguntas input[name='lat']")) {
					console.log("  llamada fitMap desde generar()");
					fitMap();
				} else {
					console.log("  centrar()");
					map.setCenter( {lat: $("#frm_titulos input[name='lat']").val(), lng:$("#frm_titulos input[name='lng']").val()} );
					map.setZoom($("#frm_titulos input[name='zoom']").val());
				}
			}
		//}
		
		cargando = false;
		$("#myMap").unblock();
		
		//var t1 = new Date();
		//console.log("generar:", t1-t0 + " ms");
		
		$("#cmd-generar").addClass("blancoHover");
		
	}	
	
	
	function inmueble(id) {
		for (var i = 0; i < datos.length; i++) {
			if (datos[i].id == id) {return datos[i];}
		}
		//console.log("inmueble no encontrado: " + id);
	}
	
	function operacion(id) {
		for (var i = 0; i < datos.length; i++) {
			if (datos[i].ID == id) {return datos[i];}
		}
		console.log("operacion no encontrada: " + id);
	}
	
	function SubzonaById(id) {
		for (var i = 0; i < subzonas.length; i++) {
			if (subzonas[i].id == id) {return subzonas[i];}
		}
		//throw "subzona no encontrada: " + id;
		//console.log("subzona no encontrada: " + id);
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
		//console.log("  GenerarInfoBoxes")
		//var tt0 = new Date();
		for (ii=0; ii<datos.length; ii++) {
			var myLatlng = new google.maps.LatLng(datos[ii].lat, datos[ii].lng);
			var infobox = new InfoBox({
				content: contenidoInfoBox( datos[ii] ),	//document.getElementById("infobox")
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
			infoboxesList.push(infobox);
		}
			
		//var tt1 = new Date();
		//console.log("GenerarInfoBoxes()", tt1-tt0 + " ms");
	}
	
	function mapalista(inm) {
		$.ajax({
			type: "GET",
			url: "/takeup/data/detalle_map.asp",
			data: {'id':inm, 'secc':'takeup'},
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
	
	
	function sel_op(op) {
		$("#chkOp" + op).click();
		return false;
	}
	
	function ver_op(op) {
		var href = "ope=" + op;
		var opts = $("#frm_preguntas");
		href = href + "&" + opts.serialize();
		
		href = href + "&zoom=" + $("#frm_titulos input[name='zoom']").val();
		href = href + "&lat=" + $("#frm_titulos input[name='lat']").val();
		href = href + "&lng=" + $("#frm_titulos input[name='lng']").val();
		
		<% if session("pw_ws").accesoTakeUp then  %>
			if ( getCookie("condiciones")=="" ) {
				$("#ModalBox").load(
					"/acceso/password.asp",
					href,
					function(recibe, textStatus, xhr) {}
				);
				$("#ModalBox").modal("show");
				return false;
				
			} else {
				href = "/articulos/?" + href;
				window.location = href;
			}
		<% else %>
			return false;
		<% end if %>
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
			
			<% if request.form("lat")="" then %>
				console.log("set center", "def", "def", "¿?")
				//map.setCenter( {lat: 40.45509438392602, lng: -3.692486281662004} );
				//map.setZoom(6);
				
				console.log("fit map");;
				
				map.fitBounds(bounds_all);
				
			<% else %>
				console.log("set request.form")
				console.log(<%= request.form("lat") %>, <%= request.form("lng") %>, <%= request.form("zoom") %>)
				//map.panTo( {lat:< %= request.form("lat") %>, lng:< %= request.form("lng") %>} );
				map.setCenter( {lat:<%= request.form("lat") %>, lng:<%= request.form("lng") %>} );
				map.setZoom(<%= request.form("zoom") %>);
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
			url: "/takeup/resultados.asp",
			data: datos,
			type: "GET",
			success: function(recibe) {
				$("#div_titulos").html(recibe);
				$("#div_titulos").css("min-height", "");
			},
			error: function(xhr, status, err) {
				console.log("ERR: " + err)
			}
		});
		
	}
	
	
	<% if request.form("zoom")="" then %>
		//opciones = {zoom: 6, center: {lat: 40.45509438392602, lng: -3.692486281662004}};	//peninsulas
		opciones = {zoom: 4, center: {lat: 36.095226722498644, lng: -6.59621130000005}};	//europa
		//opciones = {zoom: 4, center: {lat: 40.50785648293567, lng: -3.692621014788756}};	//mad
		//opciones = {zoom: 4, center: {lat: 41.434695065809805, lng: 2.135699999999929}};	//bcn
	<% else %>
		opciones = {zoom: <%= request.form("zoom") %>, center: {lat:<%= request.form("lat") %>, lng:<%= request.form("lng") %>}};	//, mapTypeControl: false
	<% end if %>
	var map = new google.maps.Map(document.getElementById("myMap"), opciones );
	//console.log("cargando mapa...")
	//$("#myMap").block(block_opts);
	
	var bounds_all = new google.maps.LatLngBounds();
	var bounds = new google.maps.LatLngBounds();
	
	google.maps.event.addListener(map, "bounds_changed", function() {
		if (act_map.zoom==map.getZoom() & act_map.lat==map.getCenter().lat() & act_map.lng==map.getCenter().lng()) {return}	//act_zoom
		if (map.getZoom()==0) {
			console.log("bounds_changed cancelado (map.getZoom()==0)");
			return false;
		}

		if (cargando) {
			console.log("bounds_changed cancelado (cargando)");
			return false;
		}
		
		console.log("bounds_changed");
		
		act_map.zoom = map.getZoom();
		act_map.lat = map.getCenter().lat();
		act_map.lng = map.getCenter().lng();
		
		$("#frm_titulos input[name='lat']").val(act_map.lat);
		$("#frm_titulos input[name='lng']").val(act_map.lng);
		$("#frm_titulos input[name='zoom']").val(act_map.zoom);
		
		$("#map-zoom").html(act_map.zoom);
		$("#map-bounds").html(act_map.lat + ", " + act_map.lng);
		
		//console.log("counter < %= counter %>", datos_mapa)
		
		<% 'if counter>0 then %>
		if (map.getZoom()<15) {
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
	
	/*
	google.maps.event.addListener(map, "idle", function() {
		if (!cargando) {
			return false;
		}
		
		var tt0 = new Date();
	  	
		//CargarDatos();
		
		var tt1 = new Date();
		console.log("idle:", tt1-tt0 + " ms");
	})
	*/
	
$(document).ready(function() {
	//console.log("ini document.ready")
	
	$("ul.lineNavs>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		//console.log("tab change - " + tab )
		$("#tab").val(tab);
		$("#frm_titulos input[name='tab']").val( tab );
		
		var $tr = $("#resumenGeneral tr.activo");
		$tr.find("a.btFiltros").each(function(ii, elto) {
            if ($(elto).data("tab")==tab) {
				$(elto).addClass("activo");
			} else {
				$(elto).removeClass("activo");
			}
        });
		
		<% 'if cargar_mapa then %>
		if (tab=="map") {
			//FitMap()
			setTimeout( function () {
				//console.log("fitMap: resize")
				google.maps.event.trigger(map, "resize");
				console.log("  llamada fitMap desde tabChange>map");
				fitMap();
			}, 450 );
			//fitMap();
		}
		<% 'end if %>
	});
	
	$("ul#nav-filtros>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		$("#zona").val("");
		$("#subzona").val("");
		//if (poligono) poligono.setMap(null);
		//CargarDatos();
	});
	
	$("#cmd-read-sel").click(function(e) {
		console.log("cmd-read-sel");
		
		$("#frm_titulos").submit();
		//$("#titSubmit").click();
	});
	
	$("#cmd-clear-sel").click(function(e) {
		//console.log("cmd-clear-sel");
		$("#frm_titulos input:checkbox").removeAttr("disabled");
		$("#frm_titulos input:checkbox").removeAttr("checked");
		
		$(".popover-check>button").removeClass("checked")
		$(".btnCheck").show();
		
		//$("#sel-count").html("0");
		$(".divCajaCheck").slideUp();
		$(".divCajaCheck .contadorSelect").animate({marginTop:"-45px"})
		
		$("#myMapDisp").hide("slow", "", function() {$("#myMapDisp").html("")});
		
	});
	
	var tmp = $("#ciudad-filtro").val().trim().toLowerCase();
	if (tmp=="madrid" || tmp=="barcelona" ) {
		$("#filtrosDisponibilidad").show();
	} else {
		$("#filtrosDisponibilidad").hide();
	}
	
	CargarEdificios();
	
	<% if request.Form="" then %>
		CargarDatos();
		//fitMap;
		
	<% else %>
		CargaSubzonas();
		if ($("#frm_preguntas input[name='id_zona']").val()!="") {
			$("#ul-zonas li[data-id='" + $("#frm_preguntas input[name='id_zona']").val() + "'] a").click();
		} else if ($("#frm_preguntas input[name='id_subzona']").val()!="") {
			$("#ul-subzona li[data-id='" + $("#frm_preguntas input[name='id_subzona']").val() + "'] a").click();
		} else {
			CargarDatos();
		}
		
		//limpiar frm_preguntas >> pasado a CargarDatos()
		
		//console.log("ocultar diapositivas y mostrar filtros")
//		swMostrarDiapositivas = false;
//		$(".divPreguntas").removeClass("activo");    //cierra preguntas
//		$("#verSubmenu").removeClass("animaHide");
//		$("#verSubmenu").click();
		
	<% end if %>
	
//	//$(".divPreguntas").removeClass("activo");    //cierra preguntas
//	$("#verSubmenu").removeClass("animaHide");   // bton  verSubmenu lo hace visible
//	
//	$(".filtros-navs").addClass("activo");
//	$(".PwTabs>.tab-content").addClass("confiltros");
	
	//if (swMostrarDiapositivas) {
	//	if (!($(".divPreguntas").hasClass("activo"))) {
	//		setTimeout( function () {
	//			$(".divPreguntas").addClass("activo");
	//		}, 1000 );
	//	}
	//}
	
});
</script>
<% 
set rsBusq=nothing 
%>
</body>
</html>