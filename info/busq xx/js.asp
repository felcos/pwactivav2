<script>
	
	function fitMap() {
		if (datos.length==0 || markerList.length==0) {
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
	
	function AbrirEdificio(marker) {
		console.log(this);
		
		return false;
	}
	function generar() {
		counter=0;
		var icono;
		//var t0 = new Date;
		$.each(datos, function(ii, objeto) {
			if ( objeto.lat==null ) {
				//console.log("FALTA", objeto.id, objeto.nombre);
				
			} else {
				if (objeto.en_proyecto == 1) {
					icono = "/img/ico-proyecto.png"
				} else {
					icono= "/img/ico-mapa02.png"	
				}
				var myLatlng = new google.maps.LatLng(objeto.lat, objeto.lng);
				var marker = new google.maps.Marker({
					id: objeto.id,
					map: map, 
					title: objeto.nombre_calc<% if request.Cookies("dev")<>"" then %>+ " [" + objeto.id + "]"<% end if %>,
					visible:true,
					position: myLatlng,
					icon: icono
				});
				markerList[counter] = marker;
				counter++;
				
				google.maps.event.addListener(marker, "click", function() {
					//console.log(marker.id);
					//AbrirEdificio(marker);
					//AbrirEdificio();
					$(".pagsum_detalle[data-id='" + marker.id + "']").submit();
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
			return false;
		}

		if (cargando) {
			console.log("bounds_changed cancelado (cargando)");
			return false;
		}
		
		act_map.zoom = map.getZoom();
		act_map.lat = map.getCenter().lat();
		act_map.lng = map.getCenter().lng();
		
		$("#frm_titulos input[name='lat']").val(act_map.lat);
		$("#frm_titulos input[name='lng']").val(act_map.lng);
		$("#frm_titulos input[name='zoom']").val(act_map.zoom);
		
		$("#map-zoom").html(act_map.zoom);
		$("#map-bounds").html(act_map.lat + ", " + act_map.lng);
		
	})
	
	
$(document).ready(function() {
	
	$("ul.lineNavs>li>a[data-toggle='tab']").on("shown.bs.tab", function (e) {
		var tab = $(e.target).data("id");
		$("#tab").val(tab);
		$("#frm_titulos input[name='tab']").val( tab );
		
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
	});
	
	
	generar();
	
});
</script>