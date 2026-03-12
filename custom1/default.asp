<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/inc/sin_acceso.asp" -->
<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<!--#include virtual="/lib/aspjson/JSON_UTIL_0.1.1.asp" -->
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>containsLocation()</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
  </head>
  <body>

    <div id="map"></div>
    
    <script>
      // This example requires the Geometry library. Include the libraries=geometry
      // parameter when you first load the API. For example:
      // 
        
      function initMap() {
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat: 41.391106, lng: 2.181697},
          zoom: 14,
        });
        var puntos;
        var triangleCoords = [
        {lat:41.3958440000000000, lng:	2.1346560000000000}, 
          {lat:41.3769730000000000, lng:	2.1353860000000000}, 
            {lat:41.3735520000000000, lng:	2.1508650000000000}, 
              {lat:41.3911060000000000, lng:	2.1816970000000000}, 
                {lat:41.3986180000000000, lng:	2.1811500000000000},
                  {lat:41.4051990000000000, lng:	2.1685700000000000},
                    {lat:41.4010320000000000, lng:	2.1471070000000000}
        ];

        var bermudaTriangle = new google.maps.Polygon({paths: triangleCoords});
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
        google.maps.event.addListener(map, 'click', function(e) {
          var resultColor =
              google.maps.geometry.poly.containsLocation(e.latLng, bermudaTriangle) ?
              'blue' :
              'red';

          var resultPath =
              google.maps.geometry.poly.containsLocation(e.latLng, bermudaTriangle) ?
              // A triangle.
              "m 0 -1 l 1 2 -2 0 z" :
              google.maps.SymbolPath.CIRCLE;

          new google.maps.Marker({
            position: e.latLng,
            map: map,
            icon: {
              path: resultPath,
              fillColor: resultColor,
              fillOpacity: .2,
              strokeColor: 'white',
              strokeWeight: .5,
              scale: 10
            }
          });
        });
      }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC_5kUZnI4pDgH19ptKkMuneHuz0tJ5P6g&libraries=geometry&callback=initMap"
         async defer></script>
  </body>
</html>
<%
Function QueryToJSON(dbcomm, params)
        Dim rs, jsa
        Set rs = dbcomm.Execute(,params,1)
        Set jsa = jsArray()
        Do While Not (rs.EOF Or rs.BOF)
                Set jsa(Null) = jsObject()
                For Each col In rs.Fields
                        jsa(Null)(col.Name) = col.Value
                Next
        rs.MoveNext
        Loop
        Set QueryToJSON = jsa
        rs.Close
End Function

sql_edifs = "SELECT id, nombre, lat, lng FROM dirs_w_inmuebles WHERE  lat IS NOT NULL"

%>
<script>
  console.log('hhhhdddhhh');
  //console.log("sql_edifs", "< %= sql_edifs %>")
  puntos = <%= QueryToJSON(session("connPW"), sql_edifs).Flush %>;
  console.log('hhhhhhh');
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
  
  </script>