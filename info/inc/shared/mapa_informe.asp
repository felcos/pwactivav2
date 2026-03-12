<div id="googleMap" style="width:100%; height:280px;"></div>
<% 
Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM

if request.Cookies("dev")<>"" then %>
	<div id="dirMap" class="dev peq" style="margin-top:6px;"><%= dirGoogleMaps %></div>
    <div id="coordsMap" class="dev peq"><%= coordsGoogleMaps %></div><% 
end if

if tiene_coords then

	%><script>
	var lat = <%= lat %>;
	var lng = <%= lng %>;



	var inmuebleLatLng = {"lat":lat, "lng":lng, "type": ""};
	
	function initMap() {
		var position = {"lat": parseFloat(lat), "lng": parseFloat(lng)};
		var mapProp = {
			center: position,
			zoom:17,
			scrollwheel: false,
			mapTypeId:google.maps.MapTypeId.ROADMAP
		};
			
		var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
		var tmp_bounds = new google.maps.LatLngBounds();
		
		markLatLng = new google.maps.Marker({
			icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
			map: map,
			position: position,
			optimized: false,
			zIndex:99999999
		});
		
		if (puntos) {
			var counter = 1;
			$.each(puntos, function(ii, punto) {
				var myLatlng = new google.maps.LatLng(punto.lat, punto.lng);
				var marker = new google.maps.Marker({
					map: map, 
					visible:true,
					position: myLatlng,
					title: punto.nombre,
					label: counter.toString(),
					//icon: "/img/ico-mapa02.png"
				});
				tmp_bounds.extend(myLatlng);
				map.fitBounds(tmp_bounds);
				counter++;
			});
			myLatlng = new google.maps.LatLng(position.lat, position.lng);
			tmp_bounds.extend(myLatlng);
			map.fitBounds(tmp_bounds);
		}
		
		var listener = google.maps.event.addListener(map, "idle", function() { 
			if (map.getZoom() > 16) map.setZoom(16); 
			google.maps.event.removeListener(listener); 
		});
		
	}
	</script>
<% else %>
	<script>
	var mapaGoogleMaps = "<%= mapaGoogleMaps %>";
	var idInmueble = "<%= idInmueble %>";
	var inmuebleLatLng = {lat:0, lng:0, type: ""};
	var puntos;
	
	function initMap() {
		var myLatlng;
		var variable_post="var_geocode";
		$.post("https://maps.googleapis.com/maps/api/geocode/json?address=" + mapaGoogleMaps + "&region=ES", 
			function(data){
				if (data["status"]=="OK") {
					myLatlng = data.results[0].geometry.location;
					inmuebleLatLng = myLatlng;
				} else {
					myLatlng = {lat: "0", lng: "0", type: ""};
				};
			var mapProp = {
				center:new google.maps.LatLng(myLatlng.lat, myLatlng.lng),
				zoom:16,
				scrollwheel: false,
				mapTypeId:google.maps.MapTypeId.ROADMAP
			};
			
			var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
			var marker = new google.maps.Marker({
				position: myLatlng,
				map: map,
				title: mapaGoogleMaps,
				//icon: "/img/ico-mapa02.png"
			});
		});
	}
	</script>
<% end if %>
<% if request.Form("seltipo")="edif" then 
	if NOT ISNULL(rsInmueble("es_complejo")) then 

		sql_edifs = "SELECT id, nombre, lat, lng, fecha_edif FROM dirs_w_inmuebles WHERE id_complejo=" & rsInmueble("id") & " AND lat IS NOT NULL"
		%><script>
		//console.log("sql_edifs", "< %= sql_edifs %>")
		puntos = <%= QueryToJSON(session("connPW"), sql_edifs).Flush %>;
		/*
		var mapa = new google.maps.Map(document.getElementById("googleMap"));
		$.each(puntos, function(ii, punto) {
			console.log(ii, punto);
			var myLatlng = new google.maps.LatLng(punto.lat, punto.lng);
			var marker = new google.maps.Marker({
				map: mapa, 
				visible:true,
				position: myLatlng,
				icon: "/img/mapa.png"
				
			});
		});
		*/
		</script>
	<% end if
end if %>