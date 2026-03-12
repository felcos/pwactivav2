<script>



	function fitMap() {
		console.log("FitMapXXX");
		if (inmuebles.length==0 || markerList.length==0) {
			map.setZoom(6);
			map.setCenter({lat: 40.45509438392602, lng: -3.692486281662004});
			console.log("fitMap: cancelado - sin datos (center ini)");
			return false;
		}
		
		if (cargando) {
			//console.log("fitMap: cancelado", "cargando: " + cargando);
			//return false;
		}
		
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
	
	function AbrirEdificio(id) {
		//console.log("this");
		$(".pagsum_detalle[data-id='" + id + "']").submit();
		return true;
	}
	
	function generar() {
		counter=0;
		var icono;
		var planta;
		var myLatlng;
		var marker;
		//var t0 = new Date;
		$.each(inmuebles, function(ii, inmueble) {
			if ( inmueble.lat==null ) {
				//console.log("FALTA", objeto.id, objeto.nombre);
				
			} else {
				if (inmueble.en_proyecto == 1) {
					icono = "/img/ico-mapa03.png"
				} else {
					icono= "/img/ico-mapa02.png"	
				}
				if(inmueble.logo!="" & inmueble.logo != null)
				{
					planta=inmueble.complejo_orden + ": " + inmueble.logo;
					//icono= "/img/deposito1.png";
				}else{planta=inmueble.nombre_calc}

				    myLatlng = new google.maps.LatLng(inmueble.lat, inmueble.lng);
				
				    marker = new google.maps.Marker({
					id: inmueble.id,
					map: map, 
					title:  planta,
					visible: false,
					position: myLatlng,
					icon: icono
				});
				markerList[counter] = marker;
				counter++;
				
				google.maps.event.addListener(marker, "click", function() {
					//console.log(marker.id);
					//AbrirEdificio(marker);
					//AbrirEdificio();
					$(".pagsum_detalle[data-id='" + inmueble.id + "']").submit();
				});
			}
		});
		
		
		if ($("#frm_preguntas input[name='lat']")) {
			console.log("  llamada fitMap desde generar()");
			fitMap();
		} else {
			console.log("  centrar()");
			map.setCenter( {lat: $("#frm_titulos input[name='lat']").val(), lng:$("#frm_titulos input[name='lng']").val()} );
			map.setZoom($("#frm_titulos input[name='zoom']").val());
		}
		
		cargando = false;
		$("#myMap").unblock();
		
		//var t1 = new Date();
		//console.log("generar:", t1-t0 + " ms");

		
		actZoom = map.getZoom();
		console.log(" mostrar desde generarXX: " + actZoom);
				
		if (actZoom<10) {
			MuestraMarkers();
		} else {
			//OcultaMarkers();
			MuestraBoxes();
		}	

		
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
		var fotologo="";
		fotologo="../fotos/inquilinos/deposito1.png"
		var txtNombre="";
		var res = '';
		res = res + '<div class="infoboxPosition" data-id="' + inmueble.id + '">';
		res = res + '<div class="popover top disp" id="">';
		
		res = res + '<table class="popover-tbDisp" onclick="mapalista(' + inmueble.id + ')">';
		res = res + '<tbody>';
		

			var sup_min = "<img src='/img/lock.svg' width='14' height='14'/>";
			var sup_max = "<img src='/img/lock.svg' width='14' height='14'/>";
		
		
		<% if request.Cookies("dev")<>"" then %>
		res = res + '<tr>';
		res = res + '<td colspan="2">id: ' + inmueble.id + '</td>';
		res = res + '</tr>';
		<% end if 

		%>
	if(inmueble.logo!="" & inmueble.logo != null)
			{
				txtNombre=inmueble.logo
				fotologo="../fotos/inquilinos/"+inmueble.logo+".png"
			}
		else{
			if(inmueble.planta!="" & inmueble.planta != null)
				{
					txtNombre=inmueble.planta
				}
			else{
					txtNombre=inmueble.nombre
				}
			}
	if(inmueble.es_complejo==1)
			{
				txtNombre=inmueble.complejo_orden
			}
			

		
		//res = res + '<tr>';
		//res = res + '<td colspan="2" style="text-align:center;line-height: 100%;"><small>' + inmueble.complejo_orden + '</small></td>';
		//res = res + '</tr>';
		res = res + '<tr>';
		//res = res + '<td colspan="2" style="text-align:center;line-height: 100%;border-top: black 1px dashed;"><small>' + txtNombre + '</small></td>';
		res = res + '<td colspan="2" style="text-align:center;line-height: 100%;"><small>' + txtNombre + '</small></td>';
		res = res + '</tr>';	
		res = res + '<tr>';
		res = res + '<td colspan="2" style="text-align:center;">' + inmueble.subtotal + ' M&sup2;</td>';		
		res = res + '</tr>';		
		res = res + '<tr>';
		res = res + '<td colspan="2" style="text-align:center;"><img src="'+ fotologo +'" width="56" /></td>';
		res = res + '</tr>';		

		
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
		GenerarInfoBoxes();
		if (infoboxesList.length==0) {
			GenerarInfoBoxes();
			
		} else {
			for (ii=0; ii<infoboxesList.length; ii++) {
				infoboxesList[ii].setVisible(true);
			}
		}
		
		for (ii=0; ii<infoboxesList.length; ii++) {
			infoboxesList[ii].setVisible(true);
			infoboxesList[ii].visible=true;
		}
		datos_mapa = "boxes";
		$("#datos_mapa").val(datos_mapa);
		console.log("MuestraBoxes");
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

			if (inmuebles[ii].logo!="" & inmuebles[ii].logo!=null)
			{
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

			
		}
			
		var tt1 = new Date();
		console.log("GenerarInfoBoxes()", tt1-tt0 + " ms");
	}
	

	function mapalista(inm) {
		//$(".infoboxPosition[data-id='" + inm + "']").parent().css("z-index", 2000 );
		console.log("mapalista [" + inm + "]");
		/*
		$("#myMapDisp").load(
			"/nidisp/data/detalle_map.asp", 
			"id="+inm, 
			function(response) {
				$("#myMapDisp").show("slow");
			}
		)
		*/
		$.ajax({
			type: "POST",
			url: "/info/data/detalle_map.asp",
			data: {'id':inm, 'secc':'nidisp'},
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
		console.log("FitMapYYY");
		



		if (reload_map) {
			console.log("FitMap", "reload_map: TRUE")
			google.maps.event.trigger(map, "resize");
			
			<% if request.form("lat")="" then %>
				//console.log("set center", "def", "def", "¿?")
				//map.setCenter( {lat: 40.45509438392602, lng: -3.692486281662004} );
				//map.setZoom(6);

				console.log("fit map centrado ");;
				
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
			console.log("FitMap", "centrarMapa: TRUEx");

			//centerMap();
			centrarMapa=false;
		}
		
	}
	

	var datos_mapa = "";
	var datos_cargados = false;
	console.log("Inicio Mapa:"+Date.now())
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
		
		//console.log("counter <%= counter %>", datos_mapa)
		
		console.log("zoomx:" + map.getZoom())
		if (map.getZoom()<15) {
			if (datos_mapa=="boxes") {
				//console.log(".getZoom()<13");
				OcultaBoxes();
				MuestraMarkers();
			}
			
		} else {				
			if (datos_mapa=="markers") {
				//console.log(".getZoom()>=13");
				//OcultaMarkers();
				MuestraBoxes();	
			}
		};
		
	})

	

	


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
			url: "/nidisp/data/ajax.asp",
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
	
$(document).ready(function() {
	
	$("ul.lineNavs>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		console.log("tab change - " + tab )
		$("#tab").val(tab);
		$("#frm_titulos input[name='tab']").val( tab );
		
		if (tab=="map") {
			FitMap()
			//setTimeout( function () {
				//console.log("fitMap: resize")
			//	google.maps.event.trigger(map, "resize");
			//	console.log("  llamada fitMap desde tabChange>map");
			//	fitMap();
			//}, 450 );
			//fitMap();
		}
	});
	console.log("Empezar...")
	//CargarDatos();
	generar();
	
});
</script>