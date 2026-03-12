<% sub Vencimiento(byRef pRS) 
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "ven"
		insert_reg_articulo secc, "ven", pRS("ID")
	end if
	
	'direcci�n		
	direccion = ""
	
	if pRS("EDIFICIO")<>"N/D" AND pRS("EDIFICIO")<>"" THEN
		direccion = "Edificio " & pRS("EDIFICIO") & "<br>"
	END IF
	
	'calle
	linea = ""
	IF pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" THEN
		linea = pRS("TIPODIRECCION") & " "
	END IF	
	linea = linea & pRS("NOMBRE_CALLE")
	IF pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" THEN
		linea = linea & " " & pRS("NUMERO_CALLE")
	END IF
	if linea<>"" then direccion = direccion & linea & "<br>"

	'zona	
	linea = ""
	if pRS("TIPOZONA")<>"N/D" and pRS("TIPOZONA")<>"" then 
		if pRS("ID_TIPO_ZONA")=1 then
			linea = "Parque "
		elseif pRS("ID_TIPO_ZONA")=2 then
			linea = "Pol&iacute;gono "
		end if
	end if
	linea = linea & pRS("NOMBRE_ZONA")
	if linea<>"" then direccion = direccion  & linea & "<br>"
	
	'localidad/provincia
	if ucase(pRS("PROVINCIA"))=ucase(pRS("LOCALIDAD")) THEN
		direccion = direccion & pRS("PROVINCIA")
	else
		direccion = direccion & pRS("LOCALIDAD") & " &nbsp; (" & pRS("PROVINCIA") & ")"
	end if
	
	'superficie		
	if pRS("METROS_CUADRADOS") = 0 then
		superficie = "n/d"
	else
		superficie = formatnumber(pRS("METROS_CUADRADOS"), 0)& "&nbsp;m<sup>2</sup> &nbsp; "
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
	
	%>
<div id="contenedor_articulos">
	<h3 class="encabezado_vencimientos">Posibles Vencimientos de Contratos</h3>
	<!-- direccion -->
    <div>
        <% if not(isnull(pRS("id_edificio"))) and pRS("id_edificio")>0 then  %>
            <p style="margin-bottom:8px;"><span style="font-size:smaller;">EDIFICIO</span>: <b><span style="font-size:larger;"><%= pRS("inmueble") %></span></b></p>
        <% end if %>
        
        <div style="clear:both;"></div>
        
        <div style="float:right; width:275px;">
            <div id="googleMap" style="width:100%; height:225px;"></div>
            <% if request.Cookies("dev")<>"" then 
                %><div id="dirMap<%= idMapa %>" class="med"><% if request.Cookies("dev")<>"" then %>(<%= idMapa %>) <% end if %><%= mapaGoogleMaps %></div><% 
            end if %>
        </div>
        <div style="padding:2em;">
            <% 
            coma="" 
            
            if pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" then
                response.write coma & pRS("TIPODIRECCION")	'VERSALITA_TODO
                coma=" "
            end if 
            
            if pRS("NOMBRE_CALLE")<>"N/D"  and pRS("NOMBRE_CALLE")<>"" then
            response.write coma & pRS("NOMBRE_CALLE")	'VERSALITA_TODO
            coma=" "
            END IF
            IF pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" THEN
            response.write coma & pRS("NUMERO_CALLE")
            coma = "<br>"
            END IF
            if coma <> "" then coma ="<br>"
            
            'IF pRS("TIPOZONA")<>"N/D" and pRS("TIPOZONA")<>"" THEN
            '	response.write coma & pRS("TIPOZONA") & ": "	'VERSALITA_TODO
            '	coma =" "
            'end if
            
            IF pRS("NOMBRE_ZONA")<>"N/D" AND pRS("NOMBRE_ZONA")<>"" THEN
                response.write coma & pRS("NOMBRE_ZONA") & ": "	'VERSALITA_TODO
                coma ="<br>"
            END IF
            if coma <> "" then coma ="<br>"
            IF pRS("LOCALIDAD")<>"N/D" THEN
                response.write coma & pRS("LOCALIDAD")	'VERSALITA_TODO
                coma="<br>"
            END IF
            
            if coma <> "" then coma ="<br>"
            IF pRS("CODIGO_POSTAL")<>"N/D" and  len(pRS("CODIGO_POSTAL"))>3 THEN
            response.write coma & pRS("CODIGO_POSTAL")
            coma =" "
            END IF
            IF pRS("PROVINCIA")<>"N/D" AND pRS("PROVINCIA")<> pRS("LOCALIDAD") THEN
            response.write coma & pRS("PROVINCIA")
            END IF
            
            if pRS("TIPOAREA")<>"N/D" and pRS("TIPOAREA")<>"" THEN %>
                Zona: <%=lcase(pRS("TIPOAREA"))%>
            <% END IF 
            %>
        </div>
    </div><!-- direccion : FIN -->
	<div style="clear:both;"></div>
        
    <table width="100%" cellspacing="0" cellpadding="0" border="0" style="margin-top:1em;">
        <tr height="1" bgcolor="#999999"><td colspan="3"></td></tr>
        <tr style="height:.3em;"><td colspan="3"></td></tr>
        
        <tr valign="top">
            <td>M<sup>2</sup> actuales:&nbsp;</td>
            <td></td>
            <td><%= superficie %></td>
        </tr>
        
        <tr style="height:.3em;"><td colspan="3"></td></tr>
        <tr height="1" bgcolor="#999999"><td colspan="3"></td></tr>
        <tr style="height:.3em;"><td colspan="3"></td></tr>
        
        <tr valign="top">
          <td>Posible&nbsp;vencimiento:</td>
          <td></td>
          <td><%= pRS("FECHA_FIN") %></td>
          <td align="right">&nbsp;</td>
        </tr>
        
        <tr style="height:.3em;"><td colspan="4"></td></tr>
        <tr height="1" bgcolor="#999999"><td colspan="4"></td></tr>
        <tr style="height:.3em;"><td colspan="4"></td></tr>
        
        <tr valign="top">
            <td>Inquilinos:</td>
            <td></td>
            <td><% call inquilinos(pRS) %></td>
            <td align="right">&nbsp;</td>
        </tr>
        
    </table>
        
	<br>
<% if modo_report then %>
	<div style="clear:both"></div>
<% else %>
	<div id="separator_line" style="clear:both"></div>
	<p class="copyright_articulo">&copy; Property Web Espa&ntilde;a</p>
<% end if %>
</div>
<script>
var myLatlng;
var variable_post="var_geocode";

console.log("[<%= mapaGoogleMaps %>]")
$.post("https://maps.googleapis.com/maps/api/geocode/json?address=<%= mapaGoogleMaps %>&sensor=false&region=ES", { variable: variable_post }, function(data){
	//console.log(data);
	
	myLatlng = data.results[0].geometry.location;
	
	var mapProp = {
		center:new google.maps.LatLng(myLatlng.lat, myLatlng.lng),
		zoom:16,
		mapTypeId:google.maps.MapTypeId.ROADMAP
	};
	
	var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
	// dealanalysis/inc/markermanager.js
	
	var marker = new google.maps.Marker({
		position: myLatlng,
		map: map,
		title: '<%= mapaGoogleMaps %>'
	});
	
});

</script>
<% end sub %>

<% sub InquilinosTipo(byRef pRS)	
	cTitulo=pRS("TITULO")
	if instr(lcase(cTitulo), "compr") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "compr")-2)
	elseif instr(lcase(cTitulo), "prealquil") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "prealquil")-2)
	elseif instr(lcase(cTitulo), "alquil") then
		cTitulo=left(cTitulo, instr(lcase(cTitulo), "alquil")-2)
	end if
	
	response.Write(cTitulo)
end sub %>

<% sub inquilinos(byRef pRS)	
	Set rsAgentes = Server.CreateObject("ADODB.Recordset")
	' class="txtTabla" 
	%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="CURSOR:help;">
  <% 'Propietarios
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND tipo ='C'"

'	test_inyeccion_sql sql
	rsAgentes.Open sql, session("connPW"), 1, 1
	do while not rsAgentes.eof  
		boxover_header = rsAgentes("NOMBRE")
		boxover_body = "Tipo: " & rsAgentes("ACTIVIDAD")
		if rsAgentes("TLF1")<>"" then boxover_body = boxover_body & "<br> &nbsp; Telf.&nbsp;" & rsAgentes("TLF1")
		if rsAgentes("TLF2")<>"" then boxover_body = boxover_body & "<br> &nbsp; Telf.&nbsp;" & rsAgentes("TLF2")
		boxover_titulo = "header=[" & boxover_header & "] body=[" & boxover_body & "]" %>
		<tr><td title="<%= boxover_titulo %>"><%= rsAgentes("NOMBRE") %></td></tr>
		<% rsAgentes.movenext
	loop %>
  
</table>
<% end sub %>


<% sub Vencimientos_SinAcceso %>
<br />
<br />
<table width="75%" border="0">
	<tr>
		<td class="registro" align="center">
<br />
<br />
No tiene acceso a la secci�n de Posibles Vencimientos.
<br />
<br />
<br />
Para m&aacute;s informaci&oacute;n p&oacute;ngase en contacto con Property Web.
<br />
<br />
<br />
<br />
		</td>
	</tr>
	<tr>
		<td class="registro" align="right"><em><b>&copy; Property Web, S.L.</b></em></td>
	</tr>
</table>
<% end sub %>

