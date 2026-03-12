<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en"> 
<head> 
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <title>PropertyWeb - DEV</title>
    
    <script src="/js/jquery.min.js"></script>
    <script type="text/javascript" src="https://maps.google.com/maps/api/js"></script> 
              
    <style type="text/css"> 
		ul { list-style: none; }
        li { padding-left:1em; padding-bottom: .2em; }
    	
        #myMap {float:left; width: 50%; height: 480px; margin:auto; margin-top:20px;}
        #myMapList {float: left; text-align:left; width: 45%; height:480px; overflow-x:hidden; overflow-y:scroll; }
		
		label {font-size: 10px; margin-left:10px;}
		
    </style>              
</head>
	    
<body>
    <h1>Inmuebles</h1>
    
    <div id="myMap"></div> 
    
<ol id="myMapList"></ol>
    
    <div style="clear:both;"></div>
    
    <input type="button" value="loadMarkers" onclick="loadMarkers()"/> &nbsp; &nbsp; 
<input type="button" value="clearMarkers" onclick="clearMarkers()"/> &nbsp; &nbsp; 
    <input type="button" value="fitMap" onclick="fitMap()"/> &nbsp; &nbsp; 
<input type="button" value="reset" onclick="location.assign('/test/mapas/gmap/');"/>
        
<hr size="1"/>
    
    <div id="informa">
        <li>inmuebles cargados: <span id="total-inmuebles">0</span></li>
        <hr />
        <li>centro: <span id="map-center">[map-center]</span></li>
        <li>zoom: <span id="map-zoom">[map-zoom]</span></li>
        <li>rango: <span id="map-rango">[map-rango]</span></li>
        <hr size="1"/>
        
<table border="0" cellspacing="0" cellpadding="2">
    <tr>
        <td><input name="lat_min" id="lat_min" type="text" value=""></td>
        <td>&nbsp; &lt;= lat &lt;= &nbsp;</td>
        <td><input name="lat_max" id="lat_max" type="text" value=""></td>
    </tr>
    <tr>
        <td><input name="lng_min" id="lng_min" type="text" value=""></td>
        <td>&nbsp; &lt;= lng &lt;= &nbsp;</td>
        <td><input name="lng_max" id="lng_max" type="text" value=""></td>
    </tr>
</table>
<input name="panorama" id="panorama" type="text" value="">
    </div>
	<hr />
    <p>Para mirar:</p>
    	<li><a href="https://solucionesenredguiapara.blogspot.com.es/2012/03/crear-mapas-de-intensidad-google-fusion.html" target="_blank">https://solucionesenredguiapara.blogspot.com.es/2012/03/crear-mapas-de-intensidad-google-fusion.html</a></li>
        <li><a href="https://www.desarrolloweb.com/articulos/colorear-paises-en-mapas-de-google.html" target="_blank">https://www.desarrolloweb.com/articulos/colorear-paises-en-mapas-de-google.html</a></li>
    	<li><a href="https://alcazardesanjuan.weebly.com/targetmaps.html" target="_blank">https://alcazardesanjuan.weebly.com/targetmaps.html</a></li>
    	<li><a href="https://developers.google.com/maps/documentation/javascript/examples/streetview-simple?hl=es" target="_blank">https://developers.google.com/maps/documentation/javascript/examples/streetview-simple?hl=es</a></li>
        <li><a href="https://stackoverflow.com/questions/9200692/how-to-change-the-street-view-in-google-maps-3" target="_blank">https://stackoverflow.com/questions/9200692/how-to-change-the-street-view-in-google-maps-3</a></li>
        <li><a href="https://www.google.com/maps/d/viewer?ll=39.97712,-3.339844&spn=11.780117,26.367188&hl=es&t=h&msa=0&z=5&source=embed&ie=UTF8&mid=zNDamr4c8OS0.ksFbpEe85lOE" target="_blank">https://www.google.com/maps/d/viewer....</a></li>
</body>
</html>

<script type="text/javascript"> 
	var defaultLatlng = new google.maps.LatLng(40.45509438392602, -3.692486281662004);
	var defaultZoom = 16;
	var counter = 0;
	
	var actualZoom;
	var actualCenter;
	
	var map;				// variable for map
	var infowindow;			// variable for marker info window
	var markerList = {};	// List with all marker to check if exist
	
	var panorama /*= map.getStreetView()*/;
	var bounds = new google.maps.LatLngBounds();
	
	var dataRoot = "/test/mapas/gmap/";
	var markerFile = dataRoot + "data.asp";
	
	var myOptions = {
		//mapTypeId: google.maps.MapTypeId.HYBRID,
		zoom: defaultZoom,
		center: defaultLatlng
	};
	
	
	function loadMap() {
		map = new google.maps.Map(document.getElementById("myMap"), myOptions);
		
		infowindow = new google.maps.InfoWindow();
		
		google.maps.event.addListener(map, "bounds_changed", function() {
			var zoomLevel = map.getZoom();
			var limites = map.getBounds();
			document.getElementById("map-center").innerHTML = map.getCenter();
			document.getElementById("map-zoom").innerHTML = zoomLevel;
			document.getElementById("map-rango").innerHTML = limites;
			
			document.getElementById("lat_min").value = limites.getSouthWest().lat();
			document.getElementById("lng_min").value = limites.getSouthWest().lng();
			
			document.getElementById("lat_max").value = limites.getNorthEast().lat();
			document.getElementById("lng_max").value = limites.getNorthEast().lng();
			
			//map.setCenter(myLatLng);
			//infowindow.setContent('Zoom: ' + zoomLevel);
		});
		
	}
	
	function fitMap() {
		$.each(
			markerList, 
			function(i,item){
				//console.log(item.getPosition());
				bounds.extend(item.getPosition());
			}
		);
		
		map.fitBounds(bounds);
		
	}
	
	function loadMarkers() {
		$("#myMapList").html("");
		clearMarkers();
		counter=0;
		
		actualZoom = map.getZoom();
		actualCenter = map.getCenter();
		
		var url = markerFile + "?";
		
		url = url + "lat_min=" + map.getBounds().getSouthWest().lat() + "&";
		url = url + "lat_max=" + map.getBounds().getNorthEast().lat() + "&";
		url = url + "lng_min=" + map.getBounds().getSouthWest().lng() + "&";
		url = url + "lng_max=" + map.getBounds().getNorthEast().lng();
		
		console.log(url)
		
		$.getJSON(
			url, 
			function(data) {
				$.each(data, function(i,item){ loadMarker(item) });
				document.getElementById("total-inmuebles").innerHTML = counter;
				//map.fitBounds(bounds);
				//fitMap();
			}
		);
		
	}
	
	function clearMarkers() {
		$.each(
			markerList, 
			function(i,item){ item.setMap(null) }
		);
		markerList = {};
	}
	
	function loadMarker(markerData){
		var myLatlng = new google.maps.LatLng(markerData["lat"], markerData["lng"]);			
		var marker = new google.maps.Marker({
			id: markerData["id"],
			map: map, 
			title: markerData["nombre"],
			position: myLatlng
		});
		
		markerList[marker.id] = marker;
		
		bounds.extend(myLatlng);
		//if (counter>5) {
		//	map.fitBounds(bounds);
		//}
		
		google.maps.event.addListener(marker, "click", function() {
			showMarker(marker.id);
			//alert(marker.id)
		});
		
		google.maps.event.addListener(infowindow,"closeclick", function() { 
			map.setZoom(actualZoom);
			map.panTo(actualCenter);
			
			//map.fitBounds(bounds);
			
			//map.setCenter(defaultLatlng);
			//map.setZoom(defaultZoom);
		}); 	
		
		counter++;
		
		var listItem = $("<li/>");
		//$("<span/>").text(counter + " ").appendTo(listItem);
		$("<a/>").attr('href','#').click( function() { 
				showMarker( marker.id );
				return false;
			}).text( markerData["nombre"] ).appendTo( listItem );
		$("<label/>").text( markerData["dir3"]+", "+markerData["dir5"] ).appendTo(listItem);
		//$('#myMapList').prepend( listItem );
		$("#myMapList").append( listItem );
	}
	
	
	function showMarker(markerId) {
		//actualZoom = map.getZoom();
		//actualCenter = map.getCenter();
		if (document.getElementById("panorama").value=="panorama") {
			panorama.setVisible(false)
			document.getElementById("panorama").value=""
		};
		
		var marker = markerList[markerId];
		
		// check if marker was found
		if( marker ){
			/*
			// get marker detail information from server
			$.get(
				dataRoot + "data/" + marker.id + ".html", 
				function(data) {
					// show marker window
					infowindow.setContent(data);
					infowindow.open(map, marker);
				}
			);
			*/
			
			var info = "" + marker.title;
			info = info + "<br><a href='#' onclick='StreetView(" + markerId + ")'>StreetView</a>";
			
			infowindow.setContent(info);
			infowindow.open(map, marker);
			
			//map.panTo(marker.position);
			//map.setZoom(16);
			
			
		} else {
			alert('Error marker not found: ' + markerId);
		}
	}
	
	function StreetView(markerId) {
		var marker =  markerList[markerId];
		var pointer = new google.maps.Marker({
			position: marker.position,
			map: map
		});
		
		panorama = map.getStreetView();
		
		panorama.setPosition(marker.position);
		panorama.setPov({
			heading: 30,
			pitch:-10}
		);
		
		panorama.setVisible(true);
		document.getElementById("panorama").value="panorama";
	}
	
	loadMap();
	//loadMarkers();
	
</script> 
