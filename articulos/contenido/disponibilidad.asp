<% sub DisponibilidadTablaEntera(byRef pRS) 

dirGoogleMaps = pRS("dir1")
'if pRS("dir2")<>"" then
'	dirGoogleMaps = dirGoogleMaps & "," & pRS("dir2")
'end if
dirGoogleMaps = dirGoogleMaps & ", " & pRS("dir3")

if pRS("id_pais")>1 then
	dirGoogleMaps = dirGoogleMaps & " (" & pRS("pais") & ")"
end if

'if pRS("id_tipo_inmueble")=1 then
'	dirGoogleMaps = pRS("nombre") & " " & dirGoogleMaps
'end if
'
'mapaGoogleMaps = dirGoogleMaps
'mapaGoogleMaps = replace(mapaGoogleMaps, "'", " ")
'mapaGoogleMaps = replace(mapaGoogleMaps, "Á", "A")
'mapaGoogleMaps = replace(mapaGoogleMaps, "É", "E")
'mapaGoogleMaps = replace(mapaGoogleMaps, "Í", "I")
'mapaGoogleMaps = replace(mapaGoogleMaps, "Ó", "O")
'mapaGoogleMaps = replace(mapaGoogleMaps, "Ú", "U")
'mapaGoogleMaps = replace(mapaGoogleMaps, "Ñ", "N")

'if not isnull(pRS("lat")) then
	coordsGoogleMaps="@"  & pRS("lat") & "," & pRS("lng")
'end if

sFotos = "" & pRS("fotos")
'if pRS("tiene_coords") then
	tiene_coords = true
	lat = replace(pRS("lat"), ",", ".")
	lng = replace(pRS("lng"), ",", ".")
'else
'	tiene_coords = false
'end if
%>
    <div class="row">
    		<%
			miga = "Disponibilidad"
    		%>
            <div class="col-sm-12">
            	<div class="miga">
					 <h2 class="tit_miga02"><%= miga %></h2>
				</div>
                <h1 class="heading"><span class="tipo">EDIFICIO </span><span class="nombreH"><%= pRS("nombre_completo") %></span><% 
					if request.Cookies("dev")<>"" then 
						%><span style="float:right;">[<a href="/info/inmueble/?id=<%= pRS("id") %>" target="_blank"><%= pRS("id") %></a>]</span><% 
					end if %></h1>
    
   			  <p class="direInfo"><%= pRS("dir1") %>
				<% if pRS("dir2")<>"" then %><br><%= pRS("dir2") %><% end if %><br>
              <%= pRS("dir3") %></p>
            </div>

    </div>

    
    <div class="separador02"></div>
    
    <div class="detalles clearfix">
        <div class="bloqueLeft slider01"> 
            <% if sFotos="" then %><img src="/_inc/javier/img/gnral/default-edif.jpg" width="373" height="209"/>
            <% else %><!--#include virtual="/inc/fotos_carousel.asp" -->
            <% end if %>
            <div class="separator"></div>
		</div>
        
		<div class="bloqueRight">
			<% if session("pw_ws").accesoDisponibilidad then 
				secc = session("secc")
				if secc="" then secc = "dis"
				insert_reg_articulo secc, "dis", pRS("ID")
				%>
				<div class="tablas tb-Gral-cont"><h3>Disponibilidad por Plantas:</h3><!--#include virtual="/disponibilidad/inc/plantas.asp" --></div>
				
				<div class="tablas tb-Gral-cont"><h3>Agentes:</h3><!--#include virtual="/info/inc/shared/agentes2.asp" --></div>
				
				
            <% else %>
            	<h3>Disponibilidad por Plantas:</h3>
                <div class="alert azul" style="width:100%">
                    <div>
                        <p><img src="/img/lock.svg" width="14" height="14"> Lo sentimos, pero esta información sólo está disponible para <a href="#" onclick="registro();">clientes</a>.</p>
                        <p>Para ver la disponibilidad y la distribuci&oacute;n de plantas del inmueble, debe tener contratado <strong>Info-Inmuebles</strong>.</p>
                        <p style="margin-top:10px;">Póngase en <a href="#" class="simplemodal">contacto con PropertyWeb</a>.</p>
                    </div>
                </div>




            <% end if %>
            
        </div>
        
    </div>
	
     <div class="detalles clearfix">
        <div class="bloqueLeft ">
            <div class="cajaImg"><div id="googleMap" style="width:100%; height:280px;"></div>
			<% if request.Cookies("dev")<>"" then 
				%><div id="dirMap" class="peq" style="margin-top:6px;"><%= dirGoogleMaps %></div><div id="coordsMap" class="peq"><%= coordsGoogleMaps %></div><% 
			end if %></div>
            <div class="pieImg"><p>MAPA/STREET VIEW<img src="/_inc/javier/img/info/muneco.gif" /></p></div>
    
        </div>
    </div>

 



	<% 'end if %>
<script type="text/javascript">
var lat = <%= lat %>;
var lng = <%= lng %>;
$(document).ready(function() {
	//console.log("initialize - mapa_coords.js");
	var position = {"lat": parseFloat(lat), "lng": parseFloat(lng)};
	
	var mapProp = {
		center: position,
		zoom:17,
		scrollwheel: false,
		mapTypeId:google.maps.MapTypeId.ROADMAP
	};
		
	var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
		
	markLatLng = new google.maps.Marker({
			icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
			map: map,
			position: position,
			zIndex: 2
		});
})
</script>

<% end sub %>