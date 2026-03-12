<% sub OperacionesTablaEntera(byRef pRS) 
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "ope"
		insert_reg_articulo secc, "ope", pRS("ID")
	end if
	
	if len(pRS("COMENTARIOS"))>5 then
		strComentariosHTML=pRS("COMENTARIOS")& chr(13)
		strTituloHTML=pRS("TITULO")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES")& chr(13)
	else
		strComentariosHTML=pRS("COMENTARIOS_PT")& chr(13)
		strTituloHTML=pRS("TITULO_PT")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES_PT")& chr(13)
	end if
	
	bloque="ope"
	
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
	
	sFotos = pRS("fotos")
	sFotos = sFotos & pRS("fotos_inmueble")

	%>
<div id="contenedor_articulos">
	
	<h3 class="encabezado_operaciones">Deals Analysis<% if request.Cookies("dev")<>"" then %> &nbsp; [<a href="/articulos/TEST.ASP?id=<%= pRS("id") %>" target="_blank">NUEVO</a>]<% end if %></h3>
	<% if session("modo")="dev" or modo_report then %><h1 class="titulo_noticia"><%= pRS("TITULO") %></h1>
	<% else %><br><% end if %>
	
    <div id="descar_imprim">
		<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();"><span class="txt_gris_claro" style="font-weight:bold;font-size:12px;">imprimir</span>&nbsp;&nbsp;<img src="/img/imprimir.png"></a>&nbsp;&nbsp;<% end if %>
        <span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("id_pais")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("id_pais")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>
    </div>
    
	<div id="contenedor_left">
		
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
            <% END IF %>
        
        </div><!-- direccion : FIN -->

		<div id="separador"></div>

        <div><!-- detalles op. -->
            <p style="margin-top:.6em;">Fecha operaci&oacute;n:&nbsp;<b><%= pRS("FECHA_OPERACION") %></b></p>
            <p style="margin-top:.6em;">Tipo de Operaci&oacute;n:&nbsp;<b><%= pRS("TIPOOPERACION") %></b></p>
            <p style="margin-top:.6em;">Uso:&nbsp;<b><% if pRS("id_seccion")=4 then %>RETAIL<% else %><%= pRS("seccion") %><% end if %></b></p>
            
            <% if pRS("USO_SOLAR")<>"" then %>
                <p>Uso del Solar: <%=lcase(pRS("USO_SOLAR"))%></p>
             <div id="separador"></div>
            <% end if %>
            
            <!--#include virtual="/inc/fotos.asp" -->
        </div><!-- detalles op. : FIN -->

        <!-- superficies centro comercial -->
        <% if pRS("SECCION")="CENTROS COMERCIALES" then %>
        <table>
            <% numero=pRS("SuperficieBA")
            if isnull(numero) or numero =0 then
                resp = "n/d"
            else
                resp = formatnumber(numero,0)& " m2"
                %><tr>
                    <td><b>Superficie Br. Alq.</b>: </td>
                    <td><%= resp %></td>
                </tr><%
            end if %>
            
            <% numero = pRS("SuperficieConstruida")
            if isnull(numero) or numero =0 then
                resp = "n/d"
            else
                resp = formatnumber(numero,0)& " m2"
                %><tr>
                    <td><b>Superficie Construible</b>: </td>
                    <td><%= resp %></td>
                </tr>
            <%
            end if
            %>
        </table>
        <% end if %>
        <!-- superficies centro comercial : FIN -->

	</div><!-- FIN: contenedor_left -->
	
    <div style="clear:both;"></div>
    
	<div class="caja_ancha">
<% 
'OPS. ALQ. solo PROPIETARIO
'ops. compra/venta/inversion/traspaso	ARRENDADOR
'INQUILINO SOLO EN OPS. ALQUILER
if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then
	tipo_op = "venta"
else
	tipo_op = "alq"
end if
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_jp">
  <tr>
    <td width="175"><% if tipo_op="venta" then %>Comprador<% else %>Inquilino<% end if %></td>
    <td width="2"></td>
    <td width="175"><% if tipo_op="venta" then %>Vendedor<% else %>Propietario<% end if %></td>
    <td width="2"></td>
    <td>
<table cellpadding="0" cellspacing="0" style="border:0px;">
  <tr>
    <td align="right" style="border:0px;" width="50">M&sup2;</td>
    <td style="border:0px;" width="30"></td>
    <td style="border:0px;" width="20"></td>
    <td style="border:0px;" width="50">Planta</td>
  </tr>
</table>
  	</td>
    <td width="20"></td>
    <td><% if tipo_op="venta" then %>Precio<% else %>Renta<% end if %> &nbsp; <%= moneda %></td>
    <td width="5"></td>
	<% if pRS("ID_TIPO_OPERACION")=2 then %>
    <td width="100">Fecha Contrato</td>
    <td width="5"></td>
    <% end if %>
    <td width="240">Intermediario</td>
  </tr>
  <tr>
    <td valign="top"><% call AgentesNombre(pRS,"C") %></td>
    <td></td>
    <td valign="top"><% call AgentesNombre(pRS,"P") %></td>
    <td></td>
    <td valign="top"><% call TablaDetalles(pRS) %></td>
    <td></td>
    <td valign="top"><p><%= ver_importe %></p>
<% if pRS("PRECIO_SALIDA_EUR") <> 0 and pRS("PRECIO_SALIDA_EUR") <> "" then %>
	<p><%=formatnumber(pRS("PRECIO_SALIDA_EUR"),2)%>  <% if pRS("ID_TIPO_OPERACION")=1 or pRS("ID_TIPO_OPERACION")=3 then %>
	  precio<% else %>
	  renta<% end if %> 
	  est. salida</p>
<% end if %>
    </td>
    <td></td>
    <% if pRS("ID_TIPO_OPERACION")=2 then %>
    <td valign="top med">ini: <%= pRS("FECHA_INICIO") %><br />fin: <%= pRS("FECHA_FIN") %></td>
    <td></td>
    <% end if %>
    <td valign="top"><% call AgentesNombre(pRS,"I") %></td>
  </tr>
</table>
	</div><!-- caja_ancha -->
    
    <div style="clear:both;"></div>

	<div id="contenedor_left">

		<!-- superficie edificable -->
<% if pRS("SECCION")="SOLARES" then 
    numero=pRS("SUPERFICIE_EDIFICABLE")
    if numero =0 then
        resp = "n/d"
    else
        resp = formatnumber(numero,0)& " m2"
    end if
    %>
<p><b>Superficie Edificable</b>: <%= resp %></p>
<div id="separator_line"></div>
<% end if %>
		<!-- superficie edificable : FIN -->

        <!-- comentarios  -->
        <div>
        <p style="font-weight:bold; margin-bottom:.75em;">Comentarios: </p>
            <%
            dim palabra(500)
            a = 1
            posicion = 0
            texto=strComentariosHTML & chr(13)
            
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
                response.write palabra(bucle) & "<br>"
                palabra(bucle)=""
            next
            %>
        </div>
        <!-- comentarios : FIN -->

		<div id="separator_line"></div>
    
	</div><!-- FIN: contenedor_left (2) -->
    
    <p class="txt_gris_claro" style="clear:both;">Fecha Publicaci&oacute;n: <%= pRS("FECHA_PUBLICACION") %></p>
	
<% if modo_report then %>
	<div style="clear:both"></div>
<% else %>
	<div id="separator_line" style="clear:both"></div><br />
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


<% sub Precios(byRef pRs)	
if pRs("PRECIO_EUR")="0" then%>
	<p><b>Precio/Renta</b>: n/d</p>
	<% exit sub
end if

if tipo_op="alq" then %>
<table class="tbl_jp">
    <tr>
	<%'calculo los euros ano	
if Instr(1,pRs("TIPOPRECIO"),"M2") then
	precioEu1=formatnumber((pRs("PRECIO_EUR")*12)*pRs("METROS_CUADRADOS"),2)
	precioPt1=formatnumber((pRs("PRECIO")*12)*pRs("METROS_CUADRADOS"),0)				
else
	precioEu1=formatnumber((pRs("PRECIO_EUR")*12),2)
	precioPt1=formatnumber((pRs("PRECIO")*12),0) 
end if %>
      <td width="75"><b>Renta:</b></td>
      <td><%=precioEu1%></td>
      <td>  &euro;/A&ntilde;o </td>
    </tr>
    <tr>
	<% 'calculo los euros mes	
If Instr(1,pRs("TIPOPRECIO"),"M2") then
	precioEu2=formatnumber((pRs("PRECIO_EUR"))*pRs("METROS_CUADRADOS"),2)
	precioPt2=formatnumber((pRs("PRECIO"))*pRs("METROS_CUADRADOS"),0)				
else
	precioEu2=formatnumber((pRs("PRECIO_EUR")),2)
	precioPt2=formatnumber((pRs("PRECIO")),0) 
end if %>
      <td> </td>
      <td><% if pRs("METROS_CUADRADOS")>0 then %><%=precioEu2%><% end if %></td>
      <td>  &euro;/mes </td>
    </tr>
<% if pRs("METROS_CUADRADOS")>0 then %>
    <tr>
    <% 'calculo los euros m2 ano	
If Instr(1,pRs("TIPOPRECIO"),"M2") then							
	precioEu3=formatnumber((pRs("PRECIO_EUR"))*12,2)
	precioPt3=formatnumber((pRs("PRECIO"))*12,0)				
else
	precioEu3=formatnumber(((pRs("PRECIO_EUR")*12)/pRs("METROS_CUADRADOS")),2)
	precioPt3=formatnumber(((pRs("PRECIO")*12)/pRs("METROS_CUADRADOS")),0) 
end if %>
      <td> </td>
      <td><% if pRs("tipooperacion")="ALQUILER" and pRs("METROS_CUADRADOS")>0 then %><%=precioEu3%><% end if %></td>
      <td>  &euro;/M2/A&ntilde;o </td>
    </tr>
    <tr> 
    <% 'calculo los euros m2 ano	
If Instr(1,pRs("TIPOPRECIO"),"M2") then							
	precioEu4=formatnumber((pRs("PRECIO_EUR")),2)
	precioPt4=formatnumber((pRs("PRECIO")),0)				
else
	precioEu4=formatnumber(((pRs("PRECIO_EUR"))/pRs("METROS_CUADRADOS")),2)
	precioPt4=formatnumber(((pRs("PRECIO"))/pRs("METROS_CUADRADOS")),0)
end if %>
      <td> </td>
      <td><% if pRs("tipooperacion")="ALQUILER" and pRs("METROS_CUADRADOS")>0 then %><%=precioEu4%><% end if %></td>
      <td>  &euro;/M2/mes </td>
    </tr>
<% end if	'pRs("METROS_CUADRADOS")>0 %>
</table>
<% else %>
<table class="tbl_jp">
    <tr>
	<% 'calculo los euros	
If Instr(1,pRs("TIPOPRECIO"),"M2") then
	precioEu1=formatnumber((pRs("PRECIO_EUR"))*pRs("METROS_CUADRADOS"),2)
	precioPt1=formatnumber((pRs("PRECIO"))*pRs("METROS_CUADRADOS"),0)
else
	precioEu1=formatnumber((pRs("PRECIO_EUR")),2)
	precioPt1=formatnumber((pRs("PRECIO")),0)
end if %>
      <td width="75"><b>Precio</b>:</td>
      <td><%=precioEu1%></td>
      <td>  &euro; </td>
	</tr>
<% if pRs("METROS_CUADRADOS")>0 then 
	'calculo los euros	
	If Instr(1,pRs("TIPOPRECIO"),"M2") then
		precioEu2=formatnumber((pRs("PRECIO_EUR")),2)
		precioPt2=formatnumber((pRs("PRECIO")),0)
	else
		precioEu2=formatnumber(((pRs("PRECIO_EUR"))/pRs("METROS_CUADRADOS")),2)
		precioPt2=formatnumber(((pRs("PRECIO"))/pRs("METROS_CUADRADOS")),0)
	end if %>
	<tr>
        <td> </td>
        <td><% if pRs("METROS_CUADRADOS")>0 then %><%=precioEu2%><% end if %></td>
        <td>  &euro;/M2 </td>
	</tr>
<% end if %>
</table>
<% end if %>
<% end sub %>

<% sub Agentes(byRef pRs, pTipo) 
	Set rsAg = Server.CreateObject("ADODB.Recordset")	
	select case pTipo
		case "C"
			sql = "tipo='C'"
		case "P"
			sql = "tipo='P'"
		case "CI"
			sql = "tipo='CI'"
		case "PI"
			sql = "tipo='PI'"
	end select
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND " & sql
	rsAg.Open sql, session("connPW")
	if not rsAg.eof then %>
<div>
<% select case pTipo
case "C"
	%><h3>Comprador/Inquilino: </h3><%
case "p"
	%><h3>Propietario/Vendedor: </h3><%
case "CI"
	%><h3>Intermediario del Comprador</h3><%
case "pI"
	%><h3>Intermediario del Vendedor</h3><%
end select %>

	<% do while not rsAg.eof %>
<p><a href="#"><%=rsAg("NOMBRE")%></a> 
<% if rsAg("ID_ACTIVIDAD")>0 then %> (<%= lcase(rsAg("ACTIVIDAD")) %>)<% end if %>
</p>

<% if rsAg("TLF1")<>"" then %>
	<p>Tel&eacute;fono: <%=rsAg("TLF1")%><% if rsAg("TLF2")<>"" then %>, <%= rsAg("TLF2") %><% end if %></p>
<% end if %>
<% if rsAg("FAX")<>"" then %>
	<p>Fax: <%=rsAg("FAX")%></p>
<% end if %>
<% if rsAg("EMAIL")<>"" then %>
	<p>Email: <a href="mailto:<%=rsAg("EMAIL")%>"><%=rsAg("EMAIL")%></a></p>
<% end if %>

    	<% rsAg.movenext
		loop %>
</div>
<div id="separador"></div>	
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>

<% sub AgentesNombre(byRef pRs, pTipo) 
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
	
	%>
<p><%= nombre %><%= cTipo %><% if img then %><img src="/img/clientes/<%= rsAg("foto") %>" height="32" /><% end if %></p>
	<% rsAg.movenext
    loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>

<% sub TablaDetalles(byRef pRs) 
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
<table cellpadding="0" cellspacing="0" class="tbl_plantas">
<% 
do while not rsDetalles.eof %>
  <tr>
    
    <td align="right" width="40"><% 
	if rsDetalles("superficie")>0 then 
		if rsDetalles("SobreRasante") then
			sumaSR = sumaSR + rsDetalles("superficie")
		else
			sumaBR = sumaBR + rsDetalles("superficie")
		end if
		
		tmpTxt = formatnumber(rsDetalles("superficie"),0)
	else
		tmpTxt = ""
	end if
		%><%= tmpTxt %></td>
    <td width="10"></td>
    <td width="30"><%
	if rsDetalles("SobreRasante") then
		tmpTxt = "S/R"
	else
		tmpTxt = "B/R"
	end if
	%><%= tmpTxt %></td>
    <td width="20"></td>
    <td width="50" align="right"><% if  isnull(rsDetalles("planta")) then %>N/D<% else %><%= rsDetalles("planta") %><% end if %> </td>
  </tr>
	<% rsDetalles.movenext
  loop %>
  <% 'if 1=2 then %>
  <tr>
    <td align="right" style="border-bottom:0; font-size:13px; font-weight:bold;"><%= FormatNumber(pRS("METROS_CUADRADOS"), 0) %></td>
    <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
    <td style="border-bottom:0; font-size:13px; font-weight:bold;">&nbsp;M&sup2;</td>
    <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
    <td style="border-bottom:0; font-size:13px; font-weight:bold; text-align:right;">&nbsp;</td>
  </tr>
  <% 'end if %>
</table>
<% if 1=2 then %>
<table width="150">
  <tr>
    <td width="50"><strong>Total</strong></td>
    <td><strong>&nbsp;S/R</strong>:</td>
    <td align="right"><strong><%= FormatNumber(sumaSR, 0) %>&nbsp;M&sup2;</strong></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><strong>&nbsp;B/R</strong>:</td>
    <td align="right"><strong><%= FormatNumber(sumaBR, 0) %>&nbsp;M&sup2;</strong></td>
  </tr>
</table>
<% end if %>
	<%
	rsDetalles.close
	set rsDetalles=nothing
end sub %>

<% sub ResumenDetalles(byRef pRS) 
	' superficie_total
	superficie_total = pRS("METROS_CUADRADOS")
	if superficie_total = 0 then
		superficie_total = "n/d"
	else
		superficie_total = formatnumber(superficie_total,0) & " m2"
	end if
	%>
Superficie Total: <b><%= superficie_total %></b>
<% end sub %>

