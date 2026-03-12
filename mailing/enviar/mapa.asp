<div id="googleMap<%= idMapa %>" style="width:275px; height:225px;"></div>
<% if request.Cookies("dev")<>"" then 
	%><div id="dirMap<%= idMapa %>" class="med"><% if request.Cookies("dev")<>"" then %>(<%= idMapa %>) <% end if %><%= mapaGoogleMaps %></div><% 
end if %>
<script>
function initialize() {
	var myLatlng;
	var variable_post="var_geocode";
	//console.log('< %= mapaGoogleMaps %>');
	
	
	$.post("https://maps.googleapis.com/maps/api/geocode/json?address=<%= mapaGoogleMaps %>&sensor=false", { variable: variable_post }, function(data){
		//console.log(data);
		
		myLatlng = data.results[0].geometry.location;
		
		var mapProp = {
			center:new google.maps.LatLng(myLatlng.lat, myLatlng.lng),
			zoom:16,
			mapTypeId:google.maps.MapTypeId.ROADMAP
		};
		
		var map = new google.maps.Map(document.getElementById("googleMap<%= idMapa %>"), mapProp);
		// dealanalysis/inc/markermanager.js
		
		var marker = new google.maps.Marker({
			position: myLatlng,
			map: map,
			title: '<%= mapaGoogleMaps %>'
		});
		
	});
	
	//console.log('dirMap<%= idMapa %>');
}
google.maps.event.addDomListener(window, 'load', initialize);

</script>

