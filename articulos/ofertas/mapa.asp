<script type="text/javascript">

var map = null;
var geocoder = null;

function initialize() {
  if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map_canvas"));
	map.addControl(new GSmallMapControl());
	//map.setCenter(new GLatLng(40.396764, 12.859138), 13);
	geocoder = new GClientGeocoder();
	
  }
}

function showAddress(address) {
  if (geocoder) {
	geocoder.getLatLng(
	  address,
	  function(point) {
		if (!point) {
		  alert(address + " not found");
		} else {
		  map.setCenter(point, 14);
		  var marker = new GMarker(point);
		  map.addOverlay(marker);
		  //marker.openInfoWindowHtml(address);
		}
	  }
	);
  }
}
</script>
<div id="map_canvas" style="width: 220px; height: 180px; float: right;"></div>