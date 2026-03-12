<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%

sql = "SELECT id, nombre, nombre_completo, id_tipo_inmueble, tipo_inmueble, id_seccion, seccion, dir1, dir2, dir3, dir4, dir5, lat, lng, "
sql = sql & "disponible_fecha, disponible_min, disponible_max FROM dirs_w_inmuebles WHERE "	
sql = sql & "id_tipo_inmueble=0 AND "
sql = sql & "lat IS NOT NULL "
'sql = sql & "tiene_coords=1 "

'sql = sql & "lat>=" & request.QueryString("lat_min") & " AND "
'sql = sql & "lat<=" & request.QueryString("lat_max") & " AND "
'sql = sql & "lng>=" & request.QueryString("lng_min") & " AND "
'sql = sql & "lng<=" & request.QueryString("lng_max")
%>
<!DOCTYPE html>
<html lang="es">
<head>
	<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
    <title>PropertyWeb - Administraci&oacute;n de Inmuebles</title><title>PropertyWeb </title>
	<!--#include virtual="/inc/head.asp" -->
	<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
	<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&region=ES"></script>
		
<style>
  html, body {
	height: 100%;
	margin: 0;
	padding: 0;
  }
  #map {
	height: 100%;
 }
</style>
</head>
<body>
<div id="map"></div>
<div id="informa"></div>
<script>
var map;
var infowindow;
var bounds;

var markers = <% QueryToJSON(session("connPW"), sql).Flush %>;;

function initMap() {
	map = new google.maps.Map(document.getElementById('map'), {
	  center: {lat: 39.99307716827685, lng: -3.4545448377418686},
	  zoom:6 
	});
	
	bounds = new google.maps.LatLngBounds();
	infowindow = new google.maps.InfoWindow();
	
	$.each(markers, function(ii, marker) {
		loadMarker(marker);
	})
}


function loadMarker(markerData) {
	var myLatLng = new google.maps.LatLng(markerData["lat"], markerData["lng"]);
	
	var marker = new google.maps.Marker({
		icon: "/img/mapa.png",
		id: markerData["id"],
		map: map, 
		title: markerData["nombre_completo"],
		
		dir1: markerData["dir3"],
		dir2: markerData["dir3"],
		dir3: markerData["dir3"],
		dir4: markerData["dir3"],
		dir5: markerData["dir3"],
		
		position: myLatLng
	});
	
	bounds.extend(myLatLng);
	
	google.maps.event.addListener(marker, "click", function() {
		showMarker(marker);
		//console.log(this)
		//alert(marker.id)
	});
	
	//google.maps.event.addListener(infowindow,"closeclick", function() {
	//	map.setZoom(actualZoom);
	//	map.panTo(actualCenter);
	//	
	map.fitBounds(bounds);
	//	
	//	//map.setCenter(defaultLatLng);
	//	//map.setZoom(defaultZoom);
	//	$("#primero").val("");
	//});	
}
	
	
function showMarker(marker) {
	$("#informa").html(marker.id);
	
	var info = "" + marker.title + "<br>";
	info = info + marker.dir3 + "<br>";
	info = info + "id: " + marker.id + "<br>";
	
	infowindow.setContent(info);
	infowindow.open(map, marker);
	
}
	
	
$(document).ready(function() {
	
})
</script>
</body>
</html>

