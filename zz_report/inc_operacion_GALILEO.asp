

<% sub OperacionesTablaEntera(byRef pRS) 
	'''insert_reg_articulo "ope", pRS("ID")
	
	if len(pRS("COMENTARIOS"))>5 then
		strComentariosHTML=pRS("COMENTARIOS")& chr(13)
		strTituloHTML=pRS("TITULO")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES")& chr(13)
	else
		strComentariosHTML=pRS("COMENTARIOS_PT")& chr(13)
		strTituloHTML=pRS("TITULO_PT")& chr(13)
		'strPalabrasClavesHTML=pRS("PALABRAS_CLAVES_PT")& chr(13)
	end if
	
	strComentariosHTML = AcomodaBD(strComentariosHTML)
	strTituloHTML = AcomodaBD(strTituloHTML)
	
	bloque="ope"
	
	Set rsDetalles = Server.CreateObject("ADODB.Recordset")
	rsDetalles.Open "SELECT * FROM C_OPERACIONES_DETALLE WHERE id_operacion=" & resultado("ID"), session("connPW")
	
	if rsDetalles.eof then 
		swDetalles = false
	else
		swDetalles = true
	end if
	
	
%>
<a name="ope<%= pRS("ID") %>" id="ope<%= pRS("ID") %>"></a>
<div id="contenedor_left">

   
<div id="contenedor_articulos" style="width:685px">
<h3 class="encabezado_operaciones">Deal Analysis</h3> 
<h1 class="titulo_noticia"><%= strTituloHTML %></h1>
<div id="descar_imprim">
	  <span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("id_pais")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("id_pais")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>
	</div>
    <br />
<div id="articulo" style="font-family: georgia;">
<% 'if pRS("NUMERO_FOTOS")>0 then %>

<% 'end if %>

<!-- direccion : INI -->
<div>
<%
dirGoogleMaps=""
if (len(pRS("NOMBRE_CALLE"))>3 AND pRS("id_pais")=1) then
	dirGoogleMaps = pRS("TIPODIRECCION") & " " & pRS("NOMBRE_CALLE")
	if pRS("id_seccion")<>128  then		'solares 
	'and pRS("id_seccion")<>1 'centros comerciales
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
'mapaGoogleMaps = replace(mapaGoogleMaps, "Ñ", "_")
'response.Write(mapaGoogleMaps)
'exit sub

dirGoogleMaps = dirGoogleMaps & " (" & pRS("pais") & ")"
dirGoogleMaps = AcomodaBD(dirGoogleMaps)
%>
<div style="float:right; width:275px;"><!--#include virtual="/report/mapa.asp" --></div>
<h3>Direcci&oacute;n:</h3>
<% coma="" 
IF pRS("EDIFICIO")<>"N/D" AND pRS("EDIFICIO")<>"" THEN
	response.write "Edificio "
	response.write  pRS("EDIFICIO")	'VERSALITA_TODO
	coma =", "
END IF
IF pRS("TIPODIRECCION")<>"N/D" and pRS("TIPODIRECCION")<>"" THEN
response.write coma & pRS("TIPODIRECCION")	'VERSALITA_TODO
coma=" "
END IF			
IF pRS("NOMBRE_CALLE")<>"N/D"  and pRS("NOMBRE_CALLE")<>"" THEN
response.write coma & pRS("NOMBRE_CALLE")	'VERSALITA_TODO
coma=" "
END IF
IF pRS("NUMERO_CALLE")<>"N/D" and pRS("NUMERO_CALLE")<>"0" and pRS("NUMERO_CALLE")<>"" THEN
response.write coma & pRS("NUMERO_CALLE")
coma = "<br>"
END IF
if coma <> "" then coma ="<br>"

IF pRS("TIPOZONA")<>"N/D" and pRS("TIPOZONA")<>"" THEN
	response.write coma & pRS("TIPOZONA") & ": "	'VERSALITA_TODO
	coma =" "
end if

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
%>
<% if pRS("TIPOAREA")<>"N/D" and pRS("TIPOAREA")<>"" THEN %>
&nbsp;Zona: &nbsp;<%=lcase(pRS("TIPOAREA"))%>
<% END IF %>
</div>
<!-- direccion : FIN -->
<div id="separador"></div>

<!-- detalles op. : INI -->
<p><b>Tipo Operaci&oacute;n: <%= lcase(AcomodaBD(pRS("TIPOOPERACION"))) %></b></p>
<% if 1=2 then %>
<p><b><%= lcase(pRS("seccion"))%></b></p>
<% end if %>
<div id="separador"></div>

<!-- superficies centro comercial : INI -->
<% if pRS("SECCION")="CENTROS COMERCIALES" then %>
<table>
	<% numero=pRS("SuperficieBA")
	if isnull(numero) or numero=0 then
		resp = "n/d"
	else
		resp = formatnumber(numero,0)& "&nbsp;m2"
		%><tr>
            <td><b>Superficie Br. Alq.</b>: </td>
            <td><%= resp %></td>
		</tr><%
	end if %>
	<% numero = pRS("SuperficieConstruida")
	if isnull(numero) or numero=0 then
		resp = "n/d"
	else
		resp = formatnumber(numero,0)& "&nbsp;m2"
		%><tr>
            <td><b>Superficie Construible</b>: </td>
            <td><%= resp %></td>
		</tr><%
	end if %>
</table>
<% end if %>
<!-- superficies centro comercial : FIN -->

<% if pRS("USO_SOLAR")<>"" then %>
	<p>Uso del Solar: &nbsp;<%=lcase(pRS("USO_SOLAR"))%></p>
    <div id="separador"></div>
<% end if %>

<% if 1=2 then %>
<p>Fecha operaci&oacute;n:&nbsp;<b><%=pRS("FECHA_OPERACION")%></b></p>
<% if pRS("FECHA_INICIO")<>"" OR pRS("FECHA_FIN")<>"" then 
	%><div id="separador"></div>
    Contrato: &nbsp; <% 
	if pRS("FECHA_INICIO")<>"" then
		%>desde: <b><%= pRS("FECHA_INICIO") %></b> &nbsp; <%
	end if
	if pRS("FECHA_FIN")<>"" then
		%>hasta: <b><%= pRS("FECHA_FIN") %></b></p><%
	end if
end if %>
<% end if %>
<!-- detalles op. : FIN -->

</div><!-- div id="articulo" -->
</div><!-- div id="contenedor_articulos" -->

</div><!-- FIN: contenedor_left -->

<div class="caja_ancha">
<% 
' superficie_total
superficie_total=pRS("METROS_CUADRADOS")
if superficie_total = 0 then
	superficie_total = "n/d"
else
	superficie_total = formatnumber(superficie_total,0) & "&nbsp;m2"
end if

' precio / renta    
importe = pRS("PRECIO_EUR")
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_jp">
  <tr>
    <td width="120"><% if pRS("ID_TIPO_OPERACION")=2 then %>Inquilino<% else %>Comprador<% end if %></td>
    <td width="2"></td>
    <td width="120"><% if pRS("ID_TIPO_OPERACION")=2 then %>Arrendador<% else %>Vendedor<% end if %></td>
    <td width="2"></td>
    <td width="150">Intermediarios</td>
    <td width="2"></td>
    <td>
<table width="100%" cellpadding="0" cellspacing="0" style="font-size:10px;">
<tr>
    <td width="35%" style="border:0px;">Uso</td>
    <td width="2" style="border:0px;"></td>
    <td style="border:0px;">Planta</td>
    <td width="2" style="border:0px;"></td>
    <td style="border:0px;"></td>
  </tr>
</table>
    </td>
    <td width="20"></td>
    <td>Precio/Renta</td>
    <td width="5"></td>
    <% if pRS("ID_TIPO_OPERACION")=2 then %>
    <td>Fecha Est. Contrato</td>
    <td width="5"></td>
    <% end if %>
    <td>Fecha Op.</td>
  </tr>
  <tr>
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"C") %></td>
    <td></td>
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"P") %></td>
    <td></td>
    <td style="font-size:12px;"><% call AgentesNombre(pRS,"I") %></td>
    <td></td>
    <td>
<table width="100%" cellpadding="0" cellspacing="0">
<% 
suma=0
do while not rsDetalles.eof %>
  <tr>
    <td style="font-size:10px;"><% if rsDetalles("id_seccion")=4 then %>RETAIL<% else %><%= rsDetalles("seccion") %><% end if %></td>
    <td width="2"></td>
    <td style="font-size:10px;"><% if not isnull(rsDetalles("planta")) then %>&nbsp;<%= rsDetalles("planta") %><% end if %></td>
    <td width="2"></td>
    <td align="right" style="font-size:10px;"><% 
	if rsDetalles("superficie")>0 then 
		suma = suma + rsDetalles("superficie")
		tmpTxt = formatnumber(rsDetalles("superficie"),0) & " m2 "
		if rsDetalles("SobreRasante") then
			tmpTxt = tmpTxt & "S/R"
		else
			tmpTxt = tmpTxt & "B/R"
		end if
	else
		tmpTxt = ""
	end if
		%><%= tmpTxt %></td>
  </tr>
	<% rsDetalles.movenext
  loop %>
  <tr>
    <td colspan="5" align="right" style="font-size:11px;">Superficie Total: &nbsp;<b><%= superficie_total %></b></td>
  </tr>
</table>
	</td>
    <td></td>
    <td><%= formatNumber(importe,2) %> &nbsp; <%= lcase(AcomodaBD(pRS("tipoprecio"))) %></td>
    <td></td>
    <% if pRS("ID_TIPO_OPERACION")=2 then %>
    <td>ini: <%= pRS("FECHA_INICIO") %><br />fin: <%= pRS("FECHA_FIN") %></td>
    <td></td>
    <% end if %>
    <td><%= pRS("FECHA_OPERACION") %></td>
  </tr>
</table>

</div>

<div id="contenedor_left">
<div id="contenedor_articulos">

<!-- superficie edificable : INI -->
<% if pRS("SECCION")="SOLARES" then 
	numero=pRS("SUPERFICIE_EDIFICABLE")
	if numero =0 then
		resp = "n/d"
	else
		resp = formatnumber(numero,0)& "&nbsp;m2"
	end if
	%>
<p><b>Superficie Edificable</b>: <%= resp %></p>
<div id="separator_line"></div>
<% end if %>
<!-- superficie edificable : FIN -->

<!-- comentarios : INI -->
<div><p style="position: relative;font-family: Georgia;font-size: 11px; font-weight:bold;">Comentarios: </p>
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

<!-- Fechas Publicación / Actualización -->
<div>
<div style="float:left; width:50%; text-align:center">
	<span class="txt_fecha">Fecha Publicaci&oacute;n:</span><br />
    <span class="txt_negrita" style="font-size: 10px;position: relative;bottom: 11px;left: 5px;"><%= pRS("FECHA_PUBLICACION") %></span>
</div>
<div style="float:left; width:50%; text-align:center">
	<span class="txt_fecha">Fecha Actualizaci&oacute;n:</span><br />
    <span class="txt_negrita" style="font-size: 10px;position: relative;bottom: 11px;left: 5px;"><%= pRS("FECHA_ACTUALIZACION") %></span>
</div>
</div><!-- Fechas Publicación / Actualización : FIN -->
<div id="separador" style="clear:both;"></div>
	
<!-- comentarios de los usuarios --> 

<font size="1pt" style="font-family: Georgia;position: relative;left: 200px;top: 10px;font-size: 12px;">&copy; Property Web Espa&ntilde;a</font>

</div><!-- div id="contenedor_articulos" (2) -->
</div><!-- FIN: contenedor_left (2) -->

<div id="contenedor_right">
<% IF 1=2 THEN  %>
<div id="mibloque_menu" style="margin-top:10px;">
<!-- Precios : INI -->
<% 
 PRECIOS pRS %>
<% if pRS("PRECIO_SALIDA_EUR") <> 0 and pRS("PRECIO_SALIDA_EUR") <> "" then %>
	<p><b>Precio Salida</b>: &nbsp;<%=formatnumber(pRS("PRECIO_SALIDA_EUR"),2)%>&nbsp;&euro; &nbsp; (<%=formatnumber(pRS("PRECIO_SALIDA"),0)%>&nbsp;pts)
<% end if %>
<!-- Precios : FIN -->
</div>  
<% END IF %>


<% if pRS("NUMERO_FOTOS")>0 then %>
<div id="mibloque_menu" style="clear:both;">FOTOS: <%= pRS("FOTOS") %></div>
<% end if %>
</div><!-- FIN: contenedor_right (2) -->


<% end sub %>


<% sub Precios(byRef pRs)	
if pRs("PRECIO_EUR")="0" then%>
	<p><b>Precio/Renta</b>: n/d</p>
	<% exit sub
end if

if pRs("ID_TIPO_OPERACION")=2 or pRs("ID_TIPO_OPERACION")=4 then %>
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
      <td> &nbsp; &euro;/A&ntilde;o </td>
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
      <td>&nbsp;</td>
      <td><% if pRs("METROS_CUADRADOS")>0 then %><%=precioEu2%><% end if %></td>
      <td> &nbsp; &euro;/mes </td>
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
      <td>&nbsp;</td>
      <td><% if pRs("tipooperacion")="ALQUILER" and pRs("METROS_CUADRADOS")>0 then %><%=precioEu3%><% end if %></td>
      <td> &nbsp; &euro;/M2/A&ntilde;o </td>
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
      <td>&nbsp;</td>
      <td><% if pRs("tipooperacion")="ALQUILER" and pRs("METROS_CUADRADOS")>0 then %><%=precioEu4%><% end if %></td>
      <td> &nbsp; &euro;/M2/mes </td>
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
      <td> &nbsp; &euro; </td>
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
        <td>&nbsp;</td>
        <td><% if pRs("METROS_CUADRADOS")>0 then %><%=precioEu2%><% end if %></td>
        <td> &nbsp; &euro;/M2 </td>
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
case "P"
	%><h3>Propietario/Vendedor: </h3><%
case "CI"
	%><h3>Intermediario del Comprador</h3><%
case "pI"
	%><h3>Intermediario del Vendedor</h3><%
end select %>

	<% do while not rsAg.eof %>
<p><a href="#"><%=rsAg("NOMBRE")%></a> 
<% if rsAg("ID_ACTIVIDAD")>0 then %>&nbsp; (<%= lcase(rsAg("ACTIVIDAD")) %>)<% end if %>
</p>

<% if rsAg("TLF1")<>"" then %>
	<p>Tel&eacute;fono: <%=rsAg("TLF1")%><% if rsAg("TLF2")<>"" then %>, <%= rsAg("TLF2") %><% end if %></p>
<% end if %>
<% if rsAg("FAX")<>"" then %>
	<p>Fax: &nbsp;<%=rsAg("FAX")%></p>
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
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & pRS("ID") & " AND " & sql & " ORDER BY tipo"
	rsAg.Open sql, session("connPW")
	if rsAg.eof then 
		%><p>N/D</p><%
	else %>
<div>
  <% do while not rsAg.eof 
		if pTipo="I" then
			if isnull(rsAg("foto")) then
				img=false
			else
				img=true
			end if
			if rsAg("tipo")="CI" then
				if  pRS("ID_TIPO_OPERACION")=2 then
					cTipo = " &nbsp; (I)"
				else
					cTipo = " &nbsp; (C)"
				end if
			elseif rsAg("tipo")="PI" then
				if  pRS("ID_TIPO_OPERACION")=2 then
					cTipo = " &nbsp; (A)"
				else
					cTipo = " &nbsp; (V)"
				end if
			end if
		else
			img=false
			cTipo = ""
		end if 
		img=false
		%>
<p><a href="#"><%= lcase(rsAg("NOMBRE")) %></a><%= cTipo %><% if img then %>
  <img src="/img/clientes/<%= rsAg("foto") %>" height="32" />
  <% end if %></p>
    	<% rsAg.movenext
		loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>