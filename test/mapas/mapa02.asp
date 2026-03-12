<!DOCTYPE html>
<html>
  <head>
<title>Google Maps</title>
<style type="text/css">
html, body, #map-canvas {
    width: 100%;
    height: 500px;
    margin: 0px;
    padding: 0px
}
</style>
<script src="https://maps.googleapis.com/maps/api/js?v=3&sensor=false&libraries=places"></script>
<script type="text/javascript">
function initialize() {
var mapOptions = {
        center: new google.maps.LatLng(37.7831,-122.4039),
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
        };

    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    var acOptions = {
      //types: ['default']
    };
    var autocomplete = new google.maps.places.Autocomplete(document.getElementById('autocomplete'),acOptions);
    autocomplete.bindTo('bounds',map);
    var infoWindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
      map: map
    });

    google.maps.event.addListener(autocomplete, 'place_changed', function() {
      infoWindow.close();
      var place = autocomplete.getPlace();
      if (place.geometry.viewport) {
        map.fitBounds(place.geometry.viewport);
      } else {
        map.setCenter(place.geometry.location);
        map.setZoom(17);
      }
      // marker.setPosition(place.geometry.location);
      infoWindow.setContent('<div><strong>' + place.name + '</strong><br>');
      infoWindow.setPosition(place.geometry.location);
      infoWindow.open(map);
    });
}
google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
<input type="text" id="autocomplete"></input>
<div id="map-canvas"></div>
</body>
</html>
