<script src="https://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAAgF6cheH-DOnmwecTUkLRFBRBFoWkgvS6w87DebRFWxRSJ5yxFxTBAzsH2NpPcifqF20n-zLj8uM-Fg&sensor=false" type="text/javascript"></script>
<!-- script type=text/javascript src="/dev/markermanager.js"></SCRIPT -->


<script type="text/javascript">

var map = null;
var geocoder = null;

function initialize() {
  if (GBrowserIsCompatible()) {
	map = new GMap2(document.getElementById("map_canvas"));
	map.addControl(new GSmallMapControl());
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
<div id="map_canvas" style="width:275px; height:225px;"></div>
<!-- "width:55px; height:45px;" -->

<script language="JavaScript" type="text/javascript">
	initialize();
	
	//showAddress('< %= verGoogleMaps %>');
	showAddress('<%= dirGoogleMaps %>');
</script>