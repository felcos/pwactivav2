<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=false&region=ES&libraries=places"></script>
<script type="text/javascript">
var timerid;
var qry_count=0;
var qry_tries=0;

var places_cont=0;
var places=[];

var geocoder;
var map;
var markLatLng, markGeocoder, markPlaces;
var infowindow;	// = new google.maps.InfoWindow();

function initialize() {
	geocoder = new google.maps.Geocoder();
	infowindow = new google.maps.InfoWindow();
	
	var mapOptions = {
		//scrollwheel: false,
		zoom: 6,
		center: new google.maps.LatLng(40.041527345503816, -3.2745015576172043) //latlng
	};
	
	map = new google.maps.Map(document.getElementById("mapa"), mapOptions);
	
	//busqueda de Google Places
	var input = document.getElementById("pac-input");
	
	var autocomplete = new google.maps.places.Autocomplete(input);
	autocomplete.bindTo("bounds", map);
	
	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	
	
	/*
	markGeocoder = new google.maps.Marker({
		map: map
	});
	
	google.maps.event.addListener(markGeocoder, "click", function() {
		infowindow.open(map, markGeocoder);
	});
	*/
	
	
	google.maps.event.addListener(map, 'click', function(event) {
		console.log(event);
		console.log(event.latLng.lat());
		console.log(event.latLng.lng());
		
	});
	
	
	google.maps.event.addListener(autocomplete, "place_changed", function() {
		infowindow.close();
		var place = autocomplete.getPlace();
		
		if (!place.geometry) {
			return;
		}
		
		if (get_pais(place)!=="ES") {
			alert("No está en España ¡!");
			return false;
		}
		
		if (place.geometry.viewport) {
			alert("place.geometry.viewport");
			map.fitBounds(place.geometry.viewport);
		} else {
			var bounds = map.getBounds();
			bounds.extend(place.geometry.location);
			map.fitBounds(bounds);
			//if (!$("#lockmap").prop("checked")) {
			//	map.setCenter(place.geometry.location);
			//	map.setZoom(17);
			//}
		}
		
		if ($("#markGeocoder").val()!=="") {markGeocoder.setMap(null); $("#markGeocoder").val("")};
		markGeocoder = new google.maps.Marker({
			map: map
		})
		// Set the position of the marker using the place ID and location
		markGeocoder.setPlace( ({
			placeId: place.place_id,
			location: place.geometry.location
		}));
		//markGeocoder.setVisible(true);
		$("#markGeocoder").val("Place");
		
		if ($("#actual").val()!=="") {
			var id=$("#actual").val();
			
			$("#glat"+id).val(place.geometry.location.lat());
			$("#glng"+id).val(place.geometry.location.lng());
			$("#placeid"+id).val(place.place_id);
			$("#quita_placeid"+id).show();
			
			//console.log(places);
			//console.log(place.place_id);
			if ($("#recibe_place"+id).html()=="") {
				$("#recibe_place"+id).show();
				$("#recibe_place"+id).html("<div style='margin-bottom:8px;'>places: &nbsp; [<a href='#' class='mini' onclick='limpiar_places(" + id + ")'>limpiar</a>]</div>")
			}
			
			if ($.inArray(place.place_id, places)<0) {
				places.push(place.place_id)
				places_cont = places_cont+1;
				
				$("#recibe_place"+id).append(format_place(place, id));
			}
		}
		
		infowindow.setContent('<div><strong>' + place.name + '</strong><br>' +
			//place.long_name + '<br>' +
			'Place ID: ' + place.place_id + '<br>' +
			place.geometry.location + '<br>' +
			place.formatted_address + '<br>' +
			//'icon: <img src="' + place.icon + '" heigh="16" width="16"><br>' +
			//'reference : ' + place.reference  + '<br>' +
			'types: ' + place.types.toString() + '<br>' +
			'html_attributions: ' + place.html_attributions + '<br>'
			);
		infowindow.open(map, markGeocoder);
	});
	
	google.maps.event.addListener(map, "bounds_changed", function() {
		$("#mapa-zoom").html(map.getZoom());
		$("#mapa-bounds").html(map.getBounds().toString());
		$("#mapa-center").html(map.getCenter().toString());
	});
	
}

//google.maps.event.addDomListener(window, 'load', initialize);
initialize();

$(document).ready(function() {
	/*
	var opciones = {
		beforeSubmit: comprobarForm, 
		success: mostrarRespuesta,
	};
	*/
	//$('#frm_busq').ajaxForm(opciones); 
	$('#frm_busq').ajaxForm({
		beforeSubmit: function () {
			$("#buscando").show();
			$("#contador_articulos").html("");
			clearmap();
		}, 
		success: function (responseText) {
			$("#result").html(responseText);
			$("#div_result").fadeIn("fast");
			
			$("#buscando").hide();
			//initialize();
		}
	}); 
	/*
	function comprobarForm() {
		$("#buscando").show();
		$("#contador_articulos").html("");
		clearmap();
	};
	
	function mostrarRespuesta (responseText) {
		$("#result").html(responseText);
		$("#div_result").fadeIn("fast");
		
		$("#buscando").hide();
		
	};
	*/
});

function quita_coords(id) {
	$.ajax({
		url: '/admin/inmuebles/bin/quita_coords.asp',
		data: $("#frminm"+id).serialize(),
		beforeSend: function() {},
		success: function(recibe, status, xhr){
			var data = JSON.parse(recibe);
			
			$("#lat"+id).val(data.lat);
			$("#lng"+id).val(data.lng);
			
			$("#tiene_coords_"+id).prop("checked", data.tiene_coords);
			$("#tiene_latlng_"+id).prop("checked", data.tiene_latlng);
			
			if (!data.tiene_latlng) {
				if ($("#markLatLng").val()!=="") {
					markLatLng.setMap(null);
					$("#markLatLng").val("");
				}
			};
			$("#quita_coords"+id).hide();
		},
		error: function(xhr, status, err) {}
	})
}

function quita_placeid(id) {
	$.ajax({
		url: '/admin/inmuebles/bin/quita_placeid.asp',
		data: $("#frminm"+id).serialize(),
		beforeSend: function() {},
		success: function(recibe, status, xhr){
			var data = JSON.parse(recibe);
			
			$("#placeid"+id).val(data.place_id);
			
			if (data.place_id) {
				$("#quita_placeid"+id).show();
			} else {
				$("#quita_placeid"+id).hide();
			};
			
		},
		error: function(xhr, status, err) {}
	})
}

function cambia_tienedir(id) {
	//console.log($("#frminm"+id).serialize());
	var tiene_dir = 0
	if ($("#tiene_dir"+id).prop("checked")) {tiene_dir = 1}
	
	var datos = "id=" + id + "&tiene_dir=" + tiene_dir;
	
	$.ajax({
		url: '/admin/inmuebles/bin/tienedir.asp',
		data: datos,
		beforeSend: function() {},
		success: function(recibe, status, xhr){
			var data = JSON.parse(recibe);
			$("#tiene_dir"+id).prop("checked", data.tiene_dir);
			//console.log(data.request);
			//console.log(data.sql);
		},
		error: function(xhr, status, err) {}
	})
}

function cambia_tienecoords(id) {
	//console.log($("#frminm"+id).serialize());
	var tiene_coords = 0
	if ($("#tiene_coords_"+id).prop("checked")) {tiene_coords = 1}
	
	var datos = "id=" + id + "&tiene_coords=" + tiene_coords;
	
	$.ajax({
		url: '/admin/inmuebles/bin/tienecoords.asp',
		data: datos,
		beforeSend: function() {},
		success: function(recibe, status, xhr){
			var data = JSON.parse(recibe);
			$("#tiene_coords_"+id).prop("checked", data.tiene_coords);
			if (data.tiene_coords) {$("#confirmar_mapa_"+id).hide()} else {$("#confirmar_mapa_"+id).show()}
		},
		error: function(xhr, status, err) {}
	})
}

function clearmap() {	
	map.getStreetView().setVisible(false);
	map.panTo(new google.maps.LatLng(40.041527345503816, -3.2745015576172043));
	//map.setCenter(new google.maps.LatLng(40.041527345503816, -3.2745015576172043));
	map.setZoom(6);
	
	var id = $("#actual").val();
	
	if ($("#markLatLng").val()!=="") {markLatLng.setMap(null); $("#markLatLng").val("")};
	if ($("#markGeocoder").val()!=="") {markGeocoder.setMap(null); $("#markGeocoder").val("")};
	
	if (id!=="") {
		//markPlaces.setMap(null);
		//$("#detalles_"+$("#actual").val()).style.display='none';
		$("#tr"+id).removeClass("actual");
		$("#nombre"+id).removeClass("resalta");
		
		$("#tiene_dir"+id).prop("disabled", true);
		//$("#tiene_coords_"+id).prop("disabled", true);
		
		$("#detalles_"+id).hide()
		$("#actual").val("")
	};
}

function allmap() {	
	map.getStreetView().setVisible(false);
	map.panTo(new google.maps.LatLng(40.041527345503816, -3.2745015576172043));
	map.setZoom(6);
	
	return false;
}

function zoommap() {
	if ($("#markLatLng").val()=="") {
		if ($("#markGeocoder").val()=="") {} else {
			map.panTo(markGeocoder.getPosition());
			map.setZoom(16);
		}
		
	} else {
		map.panTo(markLatLng.getPosition());
		map.setZoom(16);
	}
	
	return false;
}

function fitmap() {	
	map.getStreetView().setVisible(false);
	
	if ($("#markLatLng").val()=="" && $("#markGeocoder").val()=="") {return false};
	
	//var bounds = new google.maps.LatLngBounds();
	var bounds = map.getBounds();
	
	if ($("#markLatLng").val()!=="") { bounds.extend(markLatLng.getPosition()) };
	if ($("#markGeocoder").val()!=="") {bounds.extend(markGeocoder.getPosition()) };
	
    map.fitBounds(bounds);
	
	return false;
}

function fLeft(str, n) {
	if (n > String(str).length) return str;
	else return String(str).substring(0,n);
}

/**   **/

function obtener_geocodes(id) {
	//console.log("obtener_geocodes "+id);
	var address = document.getElementById('inm'+id).value;
	geocoder.geocode( {"address": address}, function(results, status) {
		if (status == google.maps.GeocoderStatus.OK) {
			//console.log("GeocoderStatus.OK")
			
			$("#recibe_geocoder"+id).html("");
			for (var ii=0; ii<results.length; ++ii) {
				//$("#informa3").append( format_geocodes (results[ii], ii) )
				$("#recibe_geocoder"+id).append( format_geocodes (results[ii], ii, id) )
			};
			
			$("#obtener_geocodes"+id).hide();
			
			if ($("#markGeocoder").val()!=="") {markGeocoder.setMap(null); $("#markGeocoder").val("")};
			
			$("#glat"+id).val(results[0].geometry.location.lat());
			$("#glng"+id).val(results[0].geometry.location.lng());
			$("#markGeocoder").val("Geocoder");
			
			markGeocoder = new google.maps.Marker({
				map: map,
				position: results[0].geometry.location,
				zIndex: 1
			});
			
			//if ($("#markLatLng").val()=="") {
				if (!$("#lockmap").prop("checked")) {
					//map.panTo(results[0].geometry.location);
					map.setCenter(results[0].geometry.location)
					map.setZoom(16);
				}
			//};
			//map.setCenter(results[0].geometry.location);
			
			
			google.maps.event.addListener(map, 'rightclick', function(event) {
				if ($("#markGeocoder").val()!=="") {markGeocoder.setMap(null); $("#markGeocoder").val("")};
				markGeocoder = new google.maps.Marker({
					map: map,
					position: event.latLng,
					zIndex: 1
				});
				$("#glat"+id).val(event.latLng.lat());
				$("#glng"+id).val(event.latLng.lng());
				
				$("#markGeocoder").val("markGeocoder");
			});
			
		} else {
			alert('Error al obtener las coordenadas: ' + status);
			//console.log('Error al obtener las coordenadas: ' + status);
		}
	});
}

function ver_detalle_geocoder(id, ii) {
	//console.log(id)
	$("#recibe_geocoder_tbl_" + id + "_" + ii).toggle();
	return false;
}
	
function ver_geocoder(rLat, rLng) {
	if ($("#markGeocoder").val()!=="") {
		markGeocoder.setMap(null);
		$("#markGeocoder").val("")
	};
	
	markGeocoder = new google.maps.Marker({
		map: map,
		position: {"lat": parseFloat(rLat), "lng": parseFloat(rLng)},
		zIndex: 1
	});
	
	var id = $("#actual").val();
	
	$("#glat"+id).val(markGeocoder.getPosition().lat());
	$("#glng"+id).val(markGeocoder.getPosition().lng());
	
	$("#placeid"+id).val("");
	$("#quita_placeid"+id).hide();
	
	if (!$("#lockmap").prop("checked")) {
		//var bounds = map.getBounds();
		//bounds.extend(markGeocoder.getPosition());
		//map.fitBounds(bounds);
		map.panTo(markGeocoder.getPosition())
	};
	$("#markGeocoder").val("Geocoder");
	
	$("#guardar_mapa_"+id).show();
	
	return false;
}

function ver_detalle_place(id, ii) {
	$("#recibe_place_tbl_" + + id + "_" + ii).toggle();
	return false;
}

function ver_place(pId, pLat, pLng) {
	if ($("#markGeocoder").val()!=="") {
		markGeocoder.setMap(null);
		$("#markGeocoder").val("")
	};
	
	markGeocoder = new google.maps.Marker({
		map: map,
		position: {"lat": parseFloat(pLat), "lng": parseFloat(pLng)},
		zIndex: 1
	});
	
	var id = $("#actual").val();
	
	$("#glat"+id).val(pLat);
	$("#glng"+id).val(pLng);
	
	$("#placeid"+id).val(pId);
	$("#quita_placeid"+id).show();
	
	if (!$("#lockmap").prop("checked")) {
		//var bounds = map.getBounds();
		//bounds.extend(markGeocoder.getPosition());
		//map.fitBounds(bounds);
		map.panTo(markGeocoder.getPosition())
	};
	$("#markGeocoder").val("Geocoder");
	
	$("#guardar_mapa_"+id).show();
	
	return false;
}

function ver_geometry(obj) {
	var res = "";
	var objeto = obj.geometry;
	
	for (var key in objeto) {
		if (res!=="") {res = res + "<br>"}
		res = res + key + ": " + objeto[key];
	};
	return res;
}

function ver_address_components(obj) {
	var res = "";
	var objeto = obj.address_components;
	var salto = false;
	
	for (var key in objeto) {
		//salto = false;
		for (var ii in objeto[key]) {
			if (ii=="long_name") {
				if (salto) {res = res + "<br>"};
				res = res + objeto[key][ii];
				salto = true;
			};
		};
		//res = res + "<hr>";
	};
	return res;
}

function get_pais(obj) {
	var res = "";
	var objeto = obj.address_components;
	var salto = false;
	
	for (var key in objeto) {
		if (objeto[key].types[0]=="country") {
			console.log(objeto[key].types[0]);
			
			res = objeto[key].short_name;
			//res = objeto[key].long_name;
			
			/*
			if (salto) {res = res + "<br>"};
			
			for (var ii in objeto[key]) {
				//if (ii=='["country","political"]') {
					res = res + objeto[key][ii] + " [" + ii + "] // ";
			//		res = res + key[2] + " // " + key[0] + " // " + key[1] ;
					salto = true;
				//};
			};
			salto = true;
			*/
		}
	}
	//''
	return res;
}

function espacia (texto, findThis, replaceThis) {
	var res = texto;	//.replace(",", ", ");
	return res;
}

function format_geocodes (obj, index, id) {
	var formatted_address = obj.formatted_address;
	var address_components = JSON.stringify(obj.address_components);
	
	var place_id = obj.place_id;
	if (place_id.length>=50) {
		place_id = place_id.substr(0, 50) + "<br>" + place_id.substr(50);
	};
	
	return '<div>[<strong>' + (index+1) + '</strong>] ' +
		'<a href="#" class="recibe_geocoder" onclick="ver_detalle_geocoder(' + id + ', ' + index + ')">' + formatted_address + '</a>' +
		'<div style="float: right;"><a href="#" onclick="ver_geocoder(' + obj.geometry.location.lat() + ', ' + obj.geometry.location.lng() + ')">ver</a></div>' +
		'</div>' + 
		'<div id="recibe_geocoder_tbl_' + id + '_' + index + '" style="display:none; background-color:#FFF; padding:5px 0;">' +
		'<table border="0" cellspacing="0" cellpadding="2" width="100%" style="background-color:#EEEEEE;">' + 
		'<tr><td colspan="2">' + formatted_address + '</td></tr>' + 
		'<tr><td>place_id: </td><td>' + place_id + '</td></tr>' + 
		
		'<tr><td>geometry: </td><td>' + ver_geometry(obj) + '</td></tr>' + 
		'<tr><td>types: </td><td>' + espacia(obj.types) + '</td></tr>' + 
		'<tr><td >aprox: </td><td>' + obj.partial_match + '</td></tr>' + 
		
		'<tr><td>postcode...: </td><td>' + obj.postcode_localities + '</td></tr>' + 
		
		'<tr><td>parts: </td><td>' + ver_address_components(obj) + '</td></tr>' + 
		
		
		'</table></div>'
} 

function format_place (obj, id) {
/*
place.long_name
place.geometry.location 
place.icon 
place.reference
place.types	//.toString()
place.html_attributions
*/
	var place_id = obj.place_id;
	if (place_id.length>=50) {
		place_id = place_id.substr(0, 50) + "<br>" + place_id.substr(50);
	};
	
	var nombre = obj.name;
	var formatted_address = obj.formatted_address;
	var address_components = JSON.stringify(obj.address_components);
	
	return '<div>[<strong><a href="#" class="recibe_place" onclick="ver_detalle_place(' + id + ', ' + places_cont + ')">' + (places_cont) + '</a></strong>] ' +
		'<a href="#" onclick="ver_place(\'' + place_id + '\', ' + obj.geometry.location.lat() + ', ' + obj.geometry.location.lng() + ')">' + nombre + '</a> ' +
		'<div style="float: right;"><a href="#" onclick="ver_place(\'' + place_id + '\', ' + obj.geometry.location.lat() + ', ' + obj.geometry.location.lng() + ')">ver</a></div>' +
		'</div>' + 
		'<div id="recibe_place_tbl_' + id + '_' + places_cont + '" style="display:none; background-color:#FFF; padding:5px 0;">' +
		'<table border="0" cellspacing="0" cellpadding="2" width="100%" style="background-color:#EEEEEE;">' + 
		'<tr><td colspan="2">' + formatted_address + '</td></tr>' + 
		'<tr><td>place_id: </td><td>' + place_id + '</td></tr>' + 
		
		'<tr><td>parts: </td><td>' + ver_address_components(obj) + '</td></tr>' +
		
		'<tr><td>parts: </td><td>' + get_pais(obj) + '</td></tr>' +
		
		'</table></div>'
} 

function limpiar_places(id) {
    $("#recibe_place"+id).html("");
	$("#recibe_place"+id).hide();
	
	places_cont=0;
	places=[];
}

function inmueble_ver (id) {
	var fila=document.getElementById('detalles_'+id);
	if (fila.style.display=='') {
		fila.style.display='none';
		if ($("#actual").val()!=="") {
			if ($("#markGeocoder").val()!=="") {
				markGeocoder.setMap(null);
				$("#markGeocoder").val("")
			};
			if ($("#markLatLng").val()!=="") {
				markLatLng.setMap(null);
				$("#markLatLng").val("")
			};
			
			//document.getElementById('detalles_'+$("#actual").val()).style.display='none';
			$("#detalles_"+$("#actual").val())
			$("#tr"+$("#actual").val()).removeClass("actual");
			$("#nombre"+$("#actual").val()).removeClass("resalta");
			$("#actual").val("");
		};
	} else {
		fila.style.display='';
	};
	
	return false;
}

function inmueble_cargar (id) {
	if ($("#td_"+id).html()=="") {
		
		$.ajax({
			url: "/admin/inmuebles/edificio.asp",
			data: "id="+id,
			beforeSend: function() {
				$("#detalles_"+id).show();
			},
			success: function(data, status, xhr){
				
				$("#td_"+id).html(data);
			},
			error: function(xhr, status, err) {}
		})
	} else {
		
		$("#detalles_"+id).hide();
		$("#td_"+id).html("");
		
	}
	
	return false;
}

function guardar (id) {
	$.ajax({
		url: "/admin/inmuebles/bin/coords.asp",
		data: $("#frminm"+id).serialize(),
		beforeSend: function() {
			//if ($("#tiene_coords_"+id).prop("checked")) {alert("faltan coordenadas"); return false;};
			if ($("#glat"+id).val()=="" || $("#glng"+id).val()=="") {alert("faltan coordenadas"); return false;};
		},
		success: function(recibe, status, xhr){
			//console.log(recibe);
			//console.log(recibe[0]);
			var data = JSON.parse(recibe);
			var id = data.id;
			
			$("#lat"+id).val(data.lat);
			$("#lng"+id).val(data.lng);
			$("#placeid"+id).val(data.place_id);
			if (data.place_id) {
				$("#quita_placeid"+id).show();
			} else {
				$("#quita_placeid"+id).hide();
			};
			
			if ($("#markLatLng").val()!=="") {
				markLatLng.setMap(null);
				$("#markLatLng").val("");
			};
			markLatLng = new google.maps.Marker({
				icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
				map: map,
				position: {"lat": parseFloat(data.lat), "lng": parseFloat(data.lng)},
				zIndex: 2
			});
			$("#markLatLng").val("LatLng")
			
			$("#glat"+id).val("");
			$("#glng"+id).val("");
			markGeocoder.setMap(null);
			$("#markGeocoder").val("")
			
			$("#tiene_dir_"+id).prop("checked", data.tiene_dir);
			$("#tiene_coords_"+id).prop("checked", data.tiene_coords);
			$("#tiene_latlng_"+id).prop("checked", data.tiene_latlng);
			
			$("#informa3").html(data.sql);
			$("#informa4").html(data.request);
			
			//console.log(data.tiene_coords);
			if (data.tiene_coords) {
				//console.log("muestro quita_coords");
				$("#quita_coords"+id).show()
			}
			if (data.tiene_coords) {$("#confirmar_mapa_"+id).hide()} else {$("#confirmar_mapa_"+id).show()}
			
			//console.log(data.place_id);
			if (data.place_id==null) {
				console.log("quito place_id");
				$("#quita_placeid"+id).hide()
			} else {
				console.log("muestro place_id");
				$("#quita_placeid"+id).show()
			}
			
			return false;
		},
		error: function(xhr, status, err) {
			console.log(status + ": " + err);
		}
	});
	
	return false;
} 

function confirmar (id) {
	$.ajax({
		url: "/admin/inmuebles/bin/confirmar_coordenadas.asp",
		data: "id="+id,	//$("#frminm"+id).serialize()
		beforeSend: function() {
			//if ($("#tiene_coords_"+id).prop("checked")) {alert("faltan coordenadas"); return false;};
			if ($("#lat"+id).val()=="" || $("#lng"+id).val()=="") {alert("faltan coordenadas"); return false;};
		},
		success: function(recibe, status, xhr){
			//console.log(recibe);
			//console.log(recibe[0]);
			var data = JSON.parse(recibe);
			var id = data.id;
			
			$("#tiene_coords_"+id).prop("checked", data.tiene_coords);
			if (data.tiene_coords) {$("#confirmar_mapa_"+id).hide()} else {$("#confirmar_mapa_"+id).show()}
			
			$("#informa3").html(data.sql);
			$("#informa4").html(data.request);
			
			return false;
		},
		error: function(xhr, status, err) {
			console.log(status + ": " + err);
		}
	});
	
	return false;
} 

function inmueble_ver_mapa (id) {
	if ($("#actual").val()!=="") {
		var id_ant = $("#actual").val();
		
		if (id==id_ant) {
			return false
		};
			
		$("#detalles_"+id_ant).hide();
		$("#td_"+id).html("");
		
		$("#tr"+id_ant).removeClass("actual");
		$("#nombre"+id_ant).removeClass("resalta");
		
		$("#tiene_dir_"+id_ant).prop("disabled", true);
		$("#tiene_coords_"+id_ant).prop("disabled", true);
		
		$("#actual").val("");
		
		$("#recibe_place"+id_ant).html("");
		$("#recibe_place"+id_ant).hide();
		
		places_cont=0;
		places=[];
		
		$("#lockmap").prop("checked", false);
		
		$("#informa3").html("");
	};
	$("#actual").val(id);
	
	$("#tr"+id).addClass("actual");
	$("#nombre"+id).addClass("resalta");
	
	//map.getStreetView().setVisible(false);
	if ($("#markLatLng").val()!=="") {markLatLng.setMap(null); $("#markLatLng").val("");};
	if ($("#markGeocoder").val()!=="") {markGeocoder.setMap(null); $("#markGeocoder").val("");};
	
	$("#detalles_"+id).show();
	
	//$("#pac-input").focus();
	$("#pac-input").val($("#nombre"+id).html());
	
	//coords
	if ($("#lat"+id).val()!=="") {
		var position = {"lat": parseFloat($("#lat"+id).val()), "lng": parseFloat($("#lng"+id).val())};
		markLatLng = new google.maps.Marker({
			icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
			map: map,
			position: position,
			zIndex: 2
		});
		$("#markLatLng").val("LatLng");
		
		if (!$("#lockmap").prop("checked")) {
			map.panTo(position);
			map.setZoom(17);
		}
	}
	
	$("#tiene_dir_"+id).prop("disabled", false);
	$("#tiene_coords_"+id).prop("disabled", false);
	
	//if ($("#tiene_coords_"+id).prop("checked")) {
	if ($("#tiene_latlng_"+id).prop("checked")) {
		$("#confirmar_mapa_"+id).show();
		// //return false
	} else {
		$("#confirmar_mapa_"+id).hide();
		obtener_geocodes(id);
	};
	
	//centermap();
	
	$("#result").scrollTo($("#tr"+id),400);
	
	return false;

}
	
</script>
