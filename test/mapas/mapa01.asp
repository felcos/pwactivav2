<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="initial-scale=1.0">
<meta charset="utf-8">
<title>KML Layers</title>
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
<script>

function initMap() {
  var map = new google.maps.Map(document.getElementById("map"), {
    zoom: 6,
    center: {lat: 40.06945047839406, lng: -3.934185500412004}
  });

  var ctaLayer = new google.maps.KmlLayer({
    url: "/test/mapas/datos/Madrid.kml",
    map: map
  });
}
</script>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX-HAhl6u-wxBKLQO31nH4vMUQ3w8cEoU&region=ES&signed_in=true&callback=initMap">
</script>
  </body>
</html>