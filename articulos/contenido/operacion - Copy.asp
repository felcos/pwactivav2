<% sub OperacionesTablaEntera(byRef pRS) 
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "ope"
		insert_reg_articulo secc, "ope", pRS("ID")
	end if
	
	if len(pRS("COMENTARIOS"))>5 then
		strComentariosHTML=pRS("COMENTARIOS")
		strTituloHTML=pRS("TITULO")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES")& chr(13)
	else
		strComentariosHTML=pRS("COMENTARIOS_PT")
		strTituloHTML=pRS("TITULO_PT")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES_PT")& chr(13)
	end if
	
	bloque="ope"
	
	'OPS. ALQ. solo PROPIETARIO
	'ops. compra/venta/inversion/traspaso	ARRENDADOR
	'INQUILINO SOLO EN OPS. ALQUILER
	if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then
		tipo_op = "venta"
	else
		tipo_op = "alq"
	end if
	
	dirGoogleMaps=""
	if (len(pRS("NOMBRE_CALLE"))>3 AND pRS("id_pais")=1) then
		dirGoogleMaps = pRS("TIPODIRECCION") & " " & pRS("NOMBRE_CALLE")
		if pRS("id_seccion")<>128  then		'solares 
		'and pRS("id_seccion")<>1 then 'centros comerciales
			dirGoogleMaps = dirGoogleMaps & " " & pRS("NUMERO_CALLE")
		end if
		dirGoogleMaps = dirGoogleMaps & ", "
	end if 
	dirGoogleMaps = dirGoogleMaps & pRS("LOCALIDAD") 
	if pRS("CODIGO_POSTAL")<>"" and len(pRS("CODIGO_POSTAL"))=5 then 
		dirGoogleMaps = dirGoogleMaps & ", " & pRS("CODIGO_POSTAL") 
	end if
	
	mapaGoogleMaps = dirGoogleMaps
	if instr(mapaGoogleMaps, "'") then
		mapaGoogleMaps = replace(mapaGoogleMaps, "'", " ")
	end if
	
	dirGoogleMaps = dirGoogleMaps & " (" & pRS("pais") & ")"
	
	if isnull(pRS("lat")) then
		coordsGoogleMaps = ""
	else
		coordsGoogleMaps = "@ " & pRS("lat") & " // " & pRS("lng")
	end if
	
	sFotos = "" & pRS("fotos")
	sFotos = sFotos & pRS("fotos_inmueble")
	
	%>
<div class="operaciones <% if modo_report then %>caja<% end if %>">

	<div class="miga">
		<h2 class="tit_miga"></span>Deal Analysis<% 
			if request.Cookies("dev")<>"" then %>&nbsp; <span class="dev">
				 [<a href="/articulos/?ope=<%= pRS("id") %>&origen=dev" target="_blank"><%= pRS("id") %></a>]
				 &nbsp; // &nbsp; origen: <%= session("origen") %>
			</span><% end if %></h2>
		<div class="imprimir">
			<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();">imprimir <span class="icon icon-printer"></span></a><% end if %>
			<span><% if pRS("id_pais")=1 then %>nacional<% else %>internacional<% end if %> <% if pRS("id_pais")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %></span>
		</div>
	</div>    
    <% if request.Cookies("dev")<>"" then %>
        <div class="caja dev">QueryString: 
        <% for each elto in request.QueryString 
            if request.QueryString(elto)<>"" then %>[<b><%= elto %></b> = <%= request.QueryString(elto) %>] &nbsp; <% end if 
        next %>
        </div>
    <% end if %>
	<div class="row datos">
		<div class="col-sm-12">
			<% if not(isnull(pRS("id_edificio"))) and pRS("id_edificio")>0 then  %>
				<h1 class="encabezado_operaciones01"><span class="titu"> <%= pRS("inmueble") %></span><% 
				if request.Cookies("dev")<>"" then 
					if not(modo_report) then %> &nbsp; 
                	<a href="/info/inmueble/?id=<%= pRS("id_edificio") %>" target="_blank" class="btn btn-xs btn-dev"><%= pRS("id_edificio") %></a><% 
					end if
				end if %></h1>
            <% end if %>
			
			<% if session("modo")="dev" or modo_report then %><h2 class="titulo_noticia"><%= pRS("TITULO") %></h2><% end if %>
            
			<div class="direccion">
            	<% 
				if pRS("NOMBRE_CALLE")<>"N/D"  and pRS("NOMBRE_CALLE")<>"" then
					if pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" then
						direccion = pRS("TIPODIRECCION") & " "
					end if 
					
					direccion = direccion & pRS("NOMBRE_CALLE")	'VERSALITA_TODO
					
					if pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" then
						direccion = direccion & " " & pRS("NUMERO_CALLE")
					end if
				end if
				
				if direccion<>"" then direccion = direccion & "<br>"
				
				if pRS("NOMBRE_ZONA")<>"N/D" AND pRS("NOMBRE_ZONA")<>"" then
					direccion = direccion & pRS("NOMBRE_ZONA") & "<br>"
				end if
				
				if pRS("LOCALIDAD")<>"N/D" THEN
					direccion = direccion & pRS("LOCALIDAD") & "<br>"
				end if
				
				if pRS("CODIGO_POSTAL")<>"N/D" and  len(pRS("CODIGO_POSTAL"))>3 then
					direccion = direccion & pRS("CODIGO_POSTAL") & " "
				end if
				if pRS("PROVINCIA")<>"N/D" AND pRS("PROVINCIA")<> pRS("LOCALIDAD") then
					direccion = direccion & pRS("PROVINCIA")
				end if 
				%>
				<span  class="tab01 tabDirec">DIRECCIÓN:</span>
				<p><%= direccion %></p>
                <% if pRS("TIPOAREA")<>"N/D" and pRS("TIPOAREA")<>"" THEN %>
                    <span class="tab01 tabDirec">ZONA:</span>
					<p><%= pRS("TIPOAREA") %></p>
				<% END IF %>
				
			</div>
			
			<table class="tb-operacion">
				<tr><td>Fecha <span class="hidden-xs450">Operación</span>:</td><td><%= pRS("FECHA_OPERACION") %></td></tr>
				<tr><td>Tipo <span class="hidden-xs450">de Operación</span>:</td><td><%= pRS("TIPOOPERACION") %></td></tr>
				<tr><td>Uso:</td><td><% if pRS("id_seccion")=4 then %>RETAIL<% else %><%= pRS("seccion") %><% end if %></td></tr>
                <!-- solar : INI -->
				<% if pRS("SECCION")="SOLARES" then
					'if pRS("USO_SOLAR")<>"" then 
						%><tr><td>Uso del Solar:</td><td><%=lcase(pRS("USO_SOLAR"))%></td></tr><%
					'end if 
					
					numero=pRS("SUPERFICIE_EDIFICABLE")
					if isnull(numero) or numero =0 then
					'if numero =0 then
						resp = "n/d"
					else
						
						resp = formatnumber(numero,0)& " m2"
					end if %>
                    <tr><td>Superficie Edificable:</td><td><%= resp %></td></tr>
                <% end if %>
                <!-- solar : FIN -->
                <!-- centro comercial : INI -->
				<% if pRS("SECCION")="CENTROS COMERCIALES" then
					numero=pRS("SuperficieBA")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Br. Alq.: </td>
                        <td><%= resp %></td>
                    </tr>
                    
                    <% numero = pRS("SuperficieConstruida")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Construible: </td>
                        <td><%= resp %></td>
                    </tr>
                <% end if %>
                <!-- centro comercial : FIN -->
			</table>
            
		</div>
		    
	</div>
	
	<div class="separador02"></div>
	
	
	<!-- datos: -->
	<div class="detalles clearfix">    
		
		<div class="bloqueLeft slider01">
        	<% if sFotos="" then %><img src="/_inc/javier/img/gnral/default-edif.jpg" width="373" height="209"/>
            <% else %><!--#include virtual="/inc/fotos_carousel.asp" -->
            <% end if %>
		  <div class="separator"></div>
            <div class="pieImg">
            	<% if 1=2 then %><p>[ <a href="#" class="naranja">ver INFO - EDIFICIO</a> ]</p><% end if %>
            </div>
		</div>
		
		
		<div class="tablas bloqueRight">
			<h3>Plantas</h3>
				<div class="row ">
					<div class="col-xs-2">
<%
Set rsDetalles = Server.CreateObject("ADODB.Recordset")
rsDetalles.Open "SELECT * FROM C_OPERACIONES_DETALLE WHERE id_operacion=" & pRS("id") & " ORDER BY orden DESC", session("connPW")

' superficie_total
superficie_total = pRS("METROS_CUADRADOS")
if superficie_total = 0 then
	superficie_total = "n/d"
else
	superficie_total = formatnumber(superficie_total,0) & " m2"
end if

sumaSR=0
sumaBR=0
%>
<table class="tb-Gral planta">
<thead>
    <tr>
        <th>Plt</th>
        <th>M²</th>
    </tr>
</thead>
<tbody>
<% do while not rsDetalles.eof 
	'planta
	if isnull(rsDetalles("planta")) then 
		planta = "N/D"
	else 
		planta = rsDetalles("planta")
	end if
	
	'superf
	if rsDetalles("superficie")>0 then 
		superf = formatnumber(rsDetalles("superficie"),0)
		
		if rsDetalles("SobreRasante") then
			sumaSR = sumaSR + rsDetalles("superficie")
			'superf = superf & " S/R"
		else
			sumaBR = sumaBR + rsDetalles("superficie")
			'superf = superf & " B/R"
		end if
		
	else
		superf = ""
	end if
	%>
    <tr>
        <td class="tbl_plantas"><%= planta %> </td>
        <td class="tbl_plantas"><%= superf %></td>
    </tr>
	<% rsDetalles.movenext
loop 

	%>
	<tr class="total">
        <td>T </td>
        <td class="tbl_plantas"><% if pRS("METROS_CUADRADOS")>0 then %><%= FormatNumber(pRS("METROS_CUADRADOS"), 0) %><% else %>N/D<% end if %></td>
    </tr>
    
</tbody>
</table>
					</div>
					<div class="col-xs-10">
						<div class="tb-Gral-cont ">
<% 
' precio / renta    
if isnull(pRS("PRECIO_EUR")) then
	importe = 0
	ver_importe = "n/d"
else
	importe = pRS("PRECIO_EUR")
	if importe=0 then
		ver_importe = "n/d"
	elseif tipo_op="venta" and importe>1000 then
		ver_importe = formatNumber(importe,0)
	else
		ver_importe = formatNumber(importe,2)
	end if
end if

moneda = lcase(pRS("tipoprecio"))
if instr(moneda, "pts") then
	moneda = replace(moneda, "pts", "&euro;")
end if
if moneda="n/d" then moneda=""
%>
<table class="tb-Gral tb-Edif">
<thead>
    <tr>
        <th><% if tipo_op="venta" then %>Comprador<% else %>Inquilino<% end if %></th>
        <% if tipo_op="venta" then %><th>Vendedor</th><% end if %> <!--solo en inversión-->
        <th><% if tipo_op="venta" then %>Precio<% else %>Renta<% end if %><br><span class="renta">(<%= moneda %>)</span></th>
        <% if pRS("ID_TIPO_OPERACION")=2 then %><th>Fecha Contrato</th><% end if %>
        <th>Intermediario</th>
    </tr>
</thead>
<tbody>
	<tr>
        <td><% call Agentes(pRS,"C") %></td>
        <% if tipo_op="venta" then %><td><% call Agentes(pRS,"P") %></td><% end if %> <!--solo en inversión -->
        <td>
        	<p><%= ver_importe %></p>
			<% if pRS("PRECIO_SALIDA_EUR") <> 0 and pRS("PRECIO_SALIDA_EUR") <> "" then %>
                <p><% if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then %>
                  Pr.<% else %>
                  Renta<% end if %> 
                  Est. Salida:<br /><%=formatnumber(pRS("PRECIO_SALIDA_EUR"),0)%></p>
            <% end if %>
		</td>
        <% if pRS("ID_TIPO_OPERACION")=2 then 
			fIni = mid(pRS("FECHA_INICIO"), 4, 3) &  mid(pRS("FECHA_INICIO"), 9, 2)
			fFin = mid(pRS("FECHA_FIN"), 4, 3) & mid(pRS("FECHA_FIN"), 9, 2)
			%><td><%= fIni %>-<%= fFin %></td><% 
		end if %>
        <td><% call Agentes(pRS,"I") %></td>
    </tr>
</tbody>
</table>
<%
rsDetalles.close
set rsDetalles=nothing
%>
						</div>
					</div>
		
				</div>

			</div>
		</div>
   
		<div class="detalles clearfix">
			<div class="bloqueLeft ">
				<div class="cajaImg">
                    <div id="googleMapDeals<%= pRS("id") %>" class="mapaVer" style=" height:225px;"></div>
                    <div id="dirMap<%= pRS("id") %>" class="med"><% if request.Cookies("dev")<>"" then %>[<%= pRS("id") %>] <% end if %><%= mapaGoogleMaps %></div>
                    <% if request.Cookies("dev")<>"" then %><div id="coordsMap" class="dev peq"><%= coordsGoogleMaps %></div><% end if %>
				</div>
				<div class="pieImg"><p>MAPA/STREET VIEW<img src="/_inc/javier/img/info/muneco.gif" /></p></div>
			</div>
			
		    <div class="bloqueRight">
				<div class="descripcion"><!--cambiar-->
					<!--<div class="separador02"></div>   -->
					<h3>COMENTARIOS</h3>
                    <% 
					if 1=2 then
						dim palabra(500)
						a = 1
						posicion = 0
						texto=strComentariosHTML 
						
						For bucle = 1 To Len(texto) 
							If Mid(texto,bucle,1) = CHR(13) Then
								Palabra(a) = Trim(Mid(texto,Posicion+1,bucle-Posicion-1))
								Posicion = bucle
								a = a + 1
							End If
						Next
						For bucle = 1 To a
							palabra(bucle) = Replace(palabra(bucle), Chr(10) & Chr(124), "<div align=center><img src='/fotos/operaciones/")
							palabra(bucle) = Replace(palabra(bucle), Chr(124), "'></div>")
							'response.write palabra(bucle) & "<br>"
							palabra(bucle)=""
						next
					end if
					
					
					texto = strComentariosHTML
					lista = split(texto, chr(13))
					
					for each elto in lista
						
						for ii=1 to 3
							if len(elto)<1 then exit for
							char = asc(mid(elto, 1,1))
							if char=10 or char=45 or char=32 then		 'or char=46	"."
								elto = mid(elto, 2, len(elto)-1)
							end if
						next
						if elto<>"" then
							%><p><%= elto %></p><%
						end if
					next
					%>
				</div>
			</div>
		</div>
     
   

	</div>
    
    <% if modo_report then %>
    <% else %>
	    <br />
    	<div id="separator_line" style="clear:both"></div>
		<p class="copyright_articulo">&copy; Property Web España</p>
	<% end if %>
</div>
<script>
var myLatlng;
var variable_post="var_geocode";

//console.log("[< %= mapaGoogleMaps %>]")
<% if isnull(pRS("lat")) or modo_report then	'request.Form("presentacion")="informe" then %>
	$.post(
		"https://maps.googleapis.com/maps/api/geocode/json?address=<%= mapaGoogleMaps %>&region=ES", 
		function(data){
			//console.log(data);
			if (data["status"]=="OK") {
				myLatlng = data.results[0].geometry.location;
			} else {
				console.log("coords... id:<%= pRS("id") %>")
				myLatlng = inmuebleLatLng;
			};
			
			var mapProp = {
				center:new google.maps.LatLng(myLatlng.lat, myLatlng.lng),
				zoom:16,
				mapTypeId:google.maps.MapTypeId.ROADMAP
			};
			
			var map = new google.maps.Map(document.getElementById("googleMapDeals<%= pRS("id") %>"), mapProp);
			// dealanalysis/inc/markermanager.js
			
			var marker = new google.maps.Marker({
				<% if not(isnull(pRS("lat"))) then %>icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",<% end if %>
				position: myLatlng,
				map: map,
				title: '<%= mapaGoogleMaps %>'
			});
		
		}
	);
<% else %>
	var lat = <%= replace(pRS("lat"), ",", ".") %>;
	var lng = <%= replace(pRS("lng"), ",", ".") %>;
	
	var position = {"lat": parseFloat(lat), "lng": parseFloat(lng)};
	//console.log(position);
	
	var mapProp = {
		center: position,
		zoom:17,
		scrollwheel: false,
		mapTypeId:google.maps.MapTypeId.ROADMAP
	};
		
	var map = new google.maps.Map(document.getElementById("googleMapDeals<%= pRS("id") %>"), mapProp);
	
	markLatLng = new google.maps.Marker({
		icon: "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png",
		map: map,
		position: position,
		zIndex: 2
	});

<% end if %>
</script>
<% end sub %>

<% sub Agentes(byRef pRs, pTipo) 
	Set rsAg = Server.CreateObject("ADODB.Recordset")	
	select case pTipo
		case "C"
			sql = "tipo='C'"
		case "P"
			sql = "tipo='P'"
		case "I"
			sql = "(tipo='CI' or tipo='PI')"
	end select
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND " & sql
	
	if pTipo="I" then
		 sql = sql & " ORDER BY ACTIVIDAD, tipo"
	end if 
	
	rsAg.Open sql, session("connPW")
	if not rsAg.eof then %>
<div>
<% 
cActividad =""
do while not rsAg.eof 
	
	if pTipo="I" then
		if cActividad<>lcase(rsAg("ACTIVIDAD")) then
			cActividad = lcase(rsAg("ACTIVIDAD"))
			%><p><strong><%= cActividad %></strong></p><%
		end if
		
		if isnull(rsAg("foto")) then
			img=false
		else
			img=true
		end if
		if rsAg("tipo")="CI" then
			if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (C)" 
			else 
				cTipo = "  (I)"
			end if
			
		elseif rsAg("tipo")="PI" then
			if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (V)"
			else 
				cTipo = "  (P)"
			end if
			
		end if
		
		
	else
		img=false
		cTipo = ""
	end if 
	img=false
	
	nombre = lcase(rsAg("NOMBRE"))
	
	%><!-- include virtual="/inc/fotos.asp" -->
<p><%= nombre %><%= cTipo %><% if img then %><img src="/img/clientes/<%= rsAg("foto") %>" height="32" /><% end if %></p>
	<% rsAg.movenext
    loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>