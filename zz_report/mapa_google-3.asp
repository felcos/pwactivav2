<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDX-HAhl6u-wxBKLQO31nH4vMUQ3w8cEoU&sensor=false" type="text/javascript"></script>
<!-- script type=text/javascript src="/dev/markermanager.js"></SCRIPT -->

<script type="text/javascript">
	var map = null;
	var geocoder = null;
	
	//function initialize(elto) {
	  if (GBrowserIsCompatible()) {
		map = new GMap2(document.getElementById(elto));
		map.addControl(new GSmallMapControl());
		geocoder = new GClientGeocoder();
		
	  }
	//}
	
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
