<%' @ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb - Administraci&oacute;n de Inmuebles</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
<style>
#myMapList > li { padding-left: 10px; padding-bottom: .2em; padding-top:.2em; border-bottom: 1px solid #CCC;}
#myMapList > li > label {font-size: 10px; margin-left:10px;}

#mapa {
	width: 100%;
}
#myMapList {
	text-align:left;
}

.icomoon-office, .icomoon-coin-euro, .icomoon-home {
	padding-right: 10px;
}
#myMapList > li { padding-left:0;}

@media screen and (max-width: 767px) {
	#controles_mapa, #informa_mapa {
		display:none;
	}
	
	#mapa {
		height:300px;
		margin-top:8px;
		margin-bottom:8px;
	}
	.caja {
		padding-left:0;
		padding-right:0;
	}
	#myMapList > ol {list-style: none; padding-left:.2em;}
	
	#s_informa {display:none;}
}
@media screen and (min-width: 768px) {
	#frm_busq {
		padding-top:1em;
	}
	#mapa {
		height:450px;
		padding-top:22px;
	}
	#myMapList {
		height:480px;
	}
	
	#result {
		overflow-y:scroll;
	}
}

</style>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

    <section id="introp" class="cf">
        <div class="grid-half titulo">
            <h1 class="heading"> Inmuebles</h1>
        </div>
        
        <div class="grid-half grid-flow-opposite titulo">
            <form id="frm_busq" class="cssform" name="frm_busq" action="/admin/inmuebles/default.asp" method="post" autocomplete="off" target="_blank">
                <div>
                    <input name="loadMarkers2" type="button" value="cargar" onClick="loadMarkers();"> &nbsp;<!-- onChange="loadMarkers();" -->
                    <input type="checkbox" id="map_edif" name="edif" value="1"/>	
                    <label for="map_edif">Edif.</label>
                    <input type="checkbox" id="map_cc" name="cc" value="1"/>
                    <label for="map_cc">C.C.</label>
                    <input type="checkbox" id="map_hotel" name="hotel" value="1" />
                    <label for="map_hotel">Hotel</label>
                    
                </div>
                <% if 1=2 then %>
                <div style="display:none;">
                    <input type="checkbox" name="nacional" value="1" <% if val_nac then %>checked<% end if %> onclick="fbusq();"/>Nacional&nbsp; 
                    <input type="checkbox" name="internacional" value="1" <% if val_int then %>checked<% end if %>/>Internacional&nbsp;
                </div>
                <div style="display:Znone;">
                	<input name="loadMarkers2" type="button" value="loadMarkers" onClick="loadMarkers();">
                    &nbsp;<input type="submit" value="submit">
                </div>
				<% end if %>
            </form>
        </div>
    
    </section>
	
    <section id="conts" class="cf" style="padding-bottom:4px; border-bottom: 1px solid #ccc;">
        
        <div class="grid-3 grid-flow-opposite" style="margin-bottom:0;">
            <div id="mapa"></div>
            <div id="controles_mapa" style="margin-top:6px;">
                <div class="grid-1" align="center"><a href="#" onclick="fitmap()" class="peq">fitmap</a></div>
                <div class="grid-1" align="center"><a href="#" onclick="zoommap()" class="peq">zoom in</a></div>
                <div class="grid-1" align="center"><a href="#" onclick="allmap()" class="peq">zoom out</a></div>
                <div class="grid-1" align="center"></div>
                <div class="grid-1" align="center"><a href="#" class="peq" onClick="clearmap()">clear</a></div>
                <div class="grid-1" align="center"><label class="peq">lock </label><input type="checkbox" id="lockmap"/></div>
            </div>
            <div id="informa_mapa" class="peq">
                <li>center: <span id="mapa-center"></span></li>
                <li>zoom: <span id="mapa-zoom"></span></li>
                <li>bounds: <span id="mapa-bounds"></span></li>
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
                <input id="primero" name="primero" type="text" value="true">
                <input name="loadMarkers" type="button" value="loadMarkers" onClick="loadMarkers();">
            </div>
        </div>
        
        <div class="grid-3" style="margin-bottom:0;">
        	<div class="caja">
                <div id="thead" style="padding-right:17px; border-bottom:1px solid #ccc;">
                    <table width="100%" class="listado" id="listado">
                    <thead>
                    <tr>
                        <th align="left">inmuebles &nbsp; <span id="total-inmuebles"></span></th>
                    </tr>
                    </thead>
                    <tbody></tbody>
                    </table>
                </div>
                <div id="result"><ol id="myMapList"></ol></div>
            </div>
        </div>
        
    </section>

    <section id="s_informa" class="cf" style="margin-top:6px; margin-bottom:6px; display:Znone;">
        <div id="informa-sql">[informa-sql]</div>
        <hr>
        <div id="informa-busq">[informa-busq]</div>
        <div id="informa3">[informa3]</div>
        <div id="informa4">[informa4]</div>
    </section>

</div>
</div>

</body>
</html>
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=false&region=ES"></script>
<script type="text/javascript"> 
	var timerid;
	
	var defaultLatLng = new google.maps.LatLng(39.99307716827685, -3.4545448377418686);
	var defaultZoom = 6;
	var counter = 0;
	
	var actualZoom;
	var actualCenter;
	
	var map;				// variable for map
	var infowindow;			// variable for marker info window
	var markerList = {};	// List with all marker to check if exist
	
	var panorama /*= map.getStreetView()*/;
	var bounds = new google.maps.LatLngBounds();
	
	var dataRoot = "/admin/inmuebles/data/";
	var markerFile = dataRoot + "data.asp";
	
	var myOptions = {
		//mapTypeId: google.maps.MapTypeId.HYBRID,
		zoom: defaultZoom,
		center: defaultLatLng
	};
	
	
	function loadMap() {
		map = new google.maps.Map(document.getElementById("mapa"), myOptions);
		
		infowindow = new google.maps.InfoWindow();
		
		google.maps.event.addListener(map, "bounds_changed", function() {
			//idle
			var zoomLevel = map.getZoom();
			var limites = map.getBounds();
			document.getElementById("mapa-center").innerHTML = map.getCenter();
			document.getElementById("mapa-zoom").innerHTML = zoomLevel;
			document.getElementById("mapa-bounds").innerHTML = limites;
			
			document.getElementById("lat_min").value = limites.getSouthWest().lat();
			document.getElementById("lng_min").value = limites.getSouthWest().lng();
			
			document.getElementById("lat_max").value = limites.getNorthEast().lat();
			document.getElementById("lng_max").value = limites.getNorthEast().lng();
			
			//map.setCenter(myLatLng);
			//infowindow.setContent('Zoom: ' + zoomLevel);
			
			/*
			if ($("#primero").val()!=="") {
				if (zoomLevel>7) {
					$("#primero").val("");
					
				};
				return false;
			}
			
			clearTimeout(timerid);
			timerid = setTimeout(function() { 
				loadMarkers()
			}, 500);
			*/
		});
		
		//google.maps.event.addListener(map, "idle", function() {
		//	clearMarkers();
		//	$("#myMapList").html("");
		//	//$("#informa-sql").html("");
		//	$("#total-inmuebles").html("");
		//	loadMarkers();
			
		//})
		//loadMarkers();
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
		clearMarkers();
		
		$("#myMapList").html("");
		//$("#informa-sql").html("");
		$("#total-inmuebles").html("");
		
		counter=0;
		
		actualZoom = map.getZoom();
		actualCenter = map.getCenter();
		
		var url = markerFile + "?";
		
		url = url + "lat_min=" + map.getBounds().getSouthWest().lat() + "&";
		url = url + "lat_max=" + map.getBounds().getNorthEast().lat() + "&";
		url = url + "lng_min=" + map.getBounds().getSouthWest().lng() + "&";
		url = url + "lng_max=" + map.getBounds().getNorthEast().lng() + "&";
		
		//console.log($("#map_edif").is(":checked"));
		if ($("#map_edif").is(":checked")) {url = url + "edif=1&"};
		//console.log($("#map_cc").is(":checked"));
		if ($("#map_cc").is(":checked")) {url = url + "cc=1&"};
		//console.log($("#map_hotel").is(":checked"));
		if ($("#map_hotel").is(":checked")) {url = url + "hotel=1&"};
		
		console.log(url);
		
		$.getJSON(
			url, 
			function(data) {
				//$("#informa-sql").append("<li>" + data.sql + "</li>");
				$("#informa-sql").html(data.sql);
				$("#informa-busq").html(data.request);
				$.each(data.markers, function(i,item){ loadMarker(item) });
				$("#total-inmuebles").html(counter);
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
	
	function icono(xx) {
		var ico;
		if (xx=="1") {
			//ico = "https://maps.google.com/mapfiles/ms/icons/green-dot.png"
			ico = "/img/mapicons/white/eu.png"
		} else if (xx=="2") {
			//ico = "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
			ico = "/img/mapicons/white/house.png"
		} else {
			//ico = "https://maps.google.com/mapfiles/ms/icons/blue-dot.png";
			ico = "/img/mapicons/white/apartment-3.png"
		};
		return ico;
	}
	
	function iconoli(xx) {
		var cla;
		if (xx=="1") {
			cla = "icomoon-coin-euro"
		} else if (xx=="2") {
			cla = "icomoon-home";
		} else {
			cla = "icomoon-office";
		};
		return cla;
	}
	
	function loadMarker(markerData){
		var myLatLng = new google.maps.LatLng(markerData["lat"], markerData["lng"]);
		
		var marker = new google.maps.Marker({
			icon: icono(markerData["id_tipo_inmueble"]),
			id: markerData["id"],
			map: map, 
			title: markerData["nombre_completo"],
			position: myLatLng
		});
		
		markerList[marker.id] = marker;
		
		bounds.extend(myLatLng);
		//if (counter>5) {
		//	map.fitBounds(bounds);
		//}
		
		google.maps.event.addListener(marker, "click", function() {
			showMarker(marker.id);
			//alert(marker.id)
		});
		
		google.maps.event.addListener(infowindow,"closeclick", function() { 
		//	map.setZoom(actualZoom);
		//	map.panTo(actualCenter);
		//	
		//	//map.fitBounds(bounds);
		//	
		//	//map.setCenter(defaultLatLng);
		//	//map.setZoom(defaultZoom);
			$("#primero").val("");
		}); 	
		
		counter++;
		
		//listado
		//var fila = "<tr>" + 
		//	"<td>" + marker.id + "</td>" + 
		//	"<td>" + markerData["nombre"] + "</td>" + 
		//	"<td>" + "xx" + "</td>" + 
		//	"</tr>"
		//$('#listado > tbody:last-child').append(fila);
		
		var listItem = $("<li/>");
		 
		//$("<span/>").attr("class", "icon-office").appendTo(listItem);
		//
		$("<span/>").attr("class", iconoli(markerData["id_tipo_inmueble"])).appendTo(listItem);
		//.icon-office, .icon-coin-euro, .icon-home
		
		$("<a/>").attr('href','#').click( function() { 
				showMarker( marker.id );
				return false;
			}).text( markerData["nombre_completo"] ).appendTo( listItem );
		$("<label/>").text( markerData["dir3"]+", "+markerData["dir5"] ).appendTo(listItem);
		//$('#myMapList').prepend( listItem );
		$("#myMapList").append( listItem );
	}
	
	
	function showMarker(markerId) {
		//actualZoom = map.getZoom();
		//actualCenter = map.getCenter();
	//	if (document.getElementById("panorama").value=="panorama") {
	//		panorama.setVisible(false)
	//		document.getElementById("panorama").value=""
	//	};
		
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
			$("#primero").val("true");
			
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
	
	
	$(document).ready(function() {
		
	})
</script>

