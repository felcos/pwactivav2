<% sub VerOferta(byRef pRS) %>
<link rel="stylesheet" type="text/css" href="/articulos/ofertas/style.css" media="screen" />

<!-- include virtual="/articulos/ofertas/functions.asp" -->
<!-- include virtual="/inc/nocache.asp" -->

<% 
'response.Write(sql)
'response.End()

if pRS.eof then 
	session("mensaje_busq")="No existe el anuncio solicitado."
	response.Redirect("/")
end if
if not(pRS("web_es")) and pRS("id_user")<>session("usr_id") then
	session("mensaje_busq")="El anuncio solicitado no est&aacute; disponible."
	response.Redirect("/")
end if

'insertar visita oferta
%>
<% dirGoogleMaps=""
	if (len(pRS("NOMBRE_CALLE"))>3 AND pRS("id_pais")=1) then
		dirGoogleMaps = pRS("TIPODIRECCION") & "&nbsp;" & pRS("NOMBRE_CALLE") 
		'if pRS("id_tipo_oferta")<>3 and pRS("id_tipo_oferta")<>9 then
			if not(isnull(pRS("NUMERO_PORTAL"))) then
				dirGoogleMaps = dirGoogleMaps & "&nbsp;" & pRS("NUMERO_PORTAL")
			end if
		'end if
		dirGoogleMaps = dirGoogleMaps &  ", "
	'else
	'	if pRS("NOMBRE_ZONA")<>"" AND pRS("NOMBRE_ZONA")<>"" then
	'		tmpTxt = ""
	'		'IF pRS("TIPOZONA")<>"N/D" THEN
	'		'	tmpTxt = VERSALITA_TODO(txtBD(pRS("TIPOZONA"))) & " "
	'		'END IF
	'		tmpTxt = tmpTxt & VERSALITA_TODO(txtBD(pRS("NOMBRE_ZONA"))) & ", "
	'		dirGoogleMaps = tmpTxt & dirGoogleMaps
	'	end if
	end if 
	
	dirGoogleMaps = dirGoogleMaps & pRS("LOCALIDAD") 
	if pRS("CODIGO_POSTAL")<>"" then 
		if len(pRS("CODIGO_POSTAL"))>=5 then dirGoogleMaps = dirGoogleMaps & ", "  & pRS("CODIGO_POSTAL") 
	end if
	dirGoogleMaps = dirGoogleMaps & ", " & pRS("pais")
	dirGoogleMaps = txtBD(dirGoogleMaps)
	'dirGoogleMaps = Replace (dirGoogleMaps, "'", "&apos;")
	dirGoogleMaps = Replace (dirGoogleMaps, "'", "´")
%>

<div id="content">

<div id="left">

<div class="titulo_oferta">
	<strong>&nbsp;<%= txtBD(pRS("titulo")) %></strong></div>
<div class="oferta">
    <div class="tblTwo">
<!-- dirección -->
<div class="tblDetalle">
  <!-- include virtual="/ofertas/inc/mapa.asp" -->MAPA
  <div class="tblDetalle_titulo"><b>Direcci&oacute;n</b></p></div>
	<p><%
coma=""
'cambiamos SeccionActiva por secc
If pRS("id_tipo_oferta") <> 8 Then 
	IF pRS("EDIFICIO")<>"N/D" AND pRS("EDIFICIO")<>"" THEN
			response.write "Edificio " & VERSALITA_TODO(txtBD(pRS("EDIFICIO")))
			coma =", "
	END IF
end if
IF pRS("TIPODIRECCION")<>"N/D" and pRS("NOMBRE_CALLE")<>"N/D" THEN
	response.write coma & VERSALITA_TODO(txtBD(pRS("TIPODIRECCION")))
	coma=" "
	response.write coma & VERSALITA_TODO(txtBD(pRS("NOMBRE_CALLE")))
	coma=" "
END IF
If pRS("id_tipo_oferta") <> 8 and pRS("id_tipo_oferta") <> 1 Then
	IF pRS("NUMERO_PORTAL")<>"N/D" and pRS("NUMERO_PORTAL")<>"" and pRS("NUMERO_PORTAL")<>"0" THEN
		response.write coma & pRS("NUMERO_PORTAL")
		coma = ", "
	END IF
end if
If pRS("id_tipo_oferta") = 5 Or pRS("id_tipo_oferta") = 9 Then
	If pRS("PISO") <> "0" And pRS("PISO") <> "" And pRS("PISO") <> "-" Then
			response.write coma & "piso " & pRS("PISO")& "&deg;" 
			coma = "<br>"
	End If
end if 
	
if coma <> "" then coma ="<br>"
if pRS("NOMBRE_ZONA")<>"" AND pRS("NOMBRE_ZONA")<>"N/D" then
	IF pRS("TIPOZONA")<>"N/D" THEN
		response.write coma & VERSALITA_TODO(txtBD(pRS("TIPOZONA")))
		coma =" "
	END IF
	response.write coma & VERSALITA_TODO(txtBD(pRS("NOMBRE_ZONA")))
	coma ="<br>"
end if
if coma <> "" then coma ="<br>"
 IF pRS("LOCALIDAD")<>"N/D" THEN
	response.write coma & VERSALITA_TODO(txtBD(pRS("LOCALIDAD")))
	coma=" "
END IF
 IF pRS("CODIGO_POSTAL")<>"N/D" THEN
 	if len(pRS("CODIGO_POSTAL"))>=5 then 
		response.write coma & pRS("CODIGO_POSTAL")
		coma ="<br>"
	end if
END IF
if coma <> "" then coma ="<br>"
IF pRS("PROVINCIA")<>"N/D" AND pRS("PROVINCIA")<> pRS("LOCALIDAD") THEN
	response.write coma & txtBD(pRS("PROVINCIA"))
END IF
response.write "<br>" & txtBD(pRS("pais"))
	%></p>
<form id="frmGoogleMaps" name="frmGoogleMaps" method="get" action="https://maps.google.es" target="_blank">
  <input name="q" type="hidden" value="<%= dirGoogleMaps %>"/>
  <input name="f" type="hidden" value="q" />
</form>
<p style="padding-left:60px; padding-top:50px;"><strong><a href="javascript:frmGoogleMaps.submit();">Ampliar Mapa</a></strong></p>
<div class="limpiaFloats"></div>
</div>
<!-- dirección -->
<!-- comentarios -->
<div class="tblDetalle">
<%  
texto = txtBD(pRS("comentarios"))
'if session("lang")<>"es" then texto = texto & "_" & session("lang")
if texto<>"" then
	'texto = replace(texto, vbcrlf, "<br>")
	texto = replace(texto, vbcrlf, "</p><p>")
	texto = "<p>" & texto & "</p>"
end if
%>
	<div class="tblDetalle_titulo"><b>Comentarios</b></p></div>
	<%= texto %>
    <br />
</div>
<!-- comentarios -->
FOTOS<!-- include virtual="/ofertas/inc/fotos.asp" -->
<!-- contacto -->
<% IF 1=2 THEN %>
<% if pRS("NOMBRE_CONTACTO")<>"N/D" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Contacto</b></p></div>
<table border="0" cellspacing="2" cellpadding="0" style="padding-left:8px;">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(pRS("NOMBRE_CONTACTO")) %></td>
  </tr>
<%if pRS("TIPOCONTACTO")<>"N/D" then %>
  <tr>
    <td valign="top"><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(pRS("TIPOCONTACTO"))) %></td>
  </tr>
<%end if%>
<%if pRS("TLF_CONTACTO1")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=pRS("TLF_CONTACTO1")%>
	<%if pRS("TLF_CONTACTO2")<>"" then 
	response.write ", " & pRS("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if pRS("FAX_CONTACTO")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=pRS("FAX_CONTACTO")%></td>
  </tr>
<%end if%>
<%if pRS("EMAIL_CONTACTO")<>"" then 
	if len(pRS("EMAIL_CONTACTO"))>35 then
		txtMail=left(pRS("EMAIL_CONTACTO"),35) & "..."
	else
		txtMail=pRS("EMAIL_CONTACTO")
	end if
%>
  <tr>
    <td colspan="2">e-mail:&nbsp;<a href="mailto:<%=pRS("EMAIL_CONTACTO")%>"><acronym title='<%=pRS("EMAIL_CONTACTO")%>'> <%= txtMail %></acronym></a></td>
  </tr>
<%end if%>
</table>
<%if pRS("NOMBRE_CONTACTO_2")<>"N/D" AND pRS("NOMBRE_CONTACTO_2")<>"" then %>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(pRS("NOMBRE_CONTACTO_2")) %></td>
  </tr>
<%if pRS("TIPOCONTACTO2")<>"N/D" then %>
  <tr>
    <td><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(pRS("TIPOCONTACTO2"))) %></td>
  </tr>
<%end if%>
<%if pRS("TLF_CONTACTO1_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=pRS("TLF_CONTACTO1_2")%>
	<%if pRS("TLF_CONTACTO2")<>"" then 
	response.write ", " & pRS("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if pRS("FAX_CONTACTO_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=pRS("FAX_CONTACTO_2")%></td>
  </tr>
<%end if%>
<%if pRS("EMAIL_CONTACTO_2")<>"" then %>
  <tr>
    <td>e-mail:&nbsp;</td>
    <td><%=pRS("EMAIL_CONTACTO_2")%></td>
  </tr>
<%end if%>
</table>
<% end if 'Contacto2 %>

</div>
<% end if %>
<% END IF %>
<!-- contacto -->
    </div>
    <div class="tblOne">
<!-- precios -->
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Caracter&iacute;sticas</b></div>
	<!--#include virtual="/articulos/ofertas/caracteristicas.asp" -->
</div>
<!-- precios -->
<!-- especificaciones -->
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Especificaciones</b></div>
    <div style="padding-left:4px;"><!--#include virtual="/articulos/ofertas/especificaciones.asp" --></div>
</div>
<!-- especificaciones -->
<div style="height:12px"></div>
<!-- propietario -->
<% IF 1=2 THEN %>
<% if pRS("PROPIETARIO1")<>"N/D" and  pRS("PROPIETARIO1")<>"" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Propiedad</b></div>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=pRS("PROPIETARIO1")%></div></td>
  </tr>
<%if pRS("PROPIETARIO2")<>"N/D" and pRS("PROPIETARIO2")<>"" then %>
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=pRS("PROPIETARIO2")%></div></td>
  </tr>
<% end if 'PROPIETARIO2 %>
<% if pRS("PROPIETARIO3")<>"N/D" and pRS("PROPIETARIO3")<>"" then %>
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=pRS("PROPIETARIO3")%></div></td>
  </tr>
<% end if 'PROPIETARIO3 %>
</table>
</div>
<% end if %>
<% END IF %>
<!-- propietario -->
<!-- contacto -->
<% IF 1=2 THEN %>
<% if pRS("NOMBRE_CONTACTO")<>"N/D" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Contacto</b></p></div>
<table border="0" cellspacing="2" cellpadding="0" style="padding-left:8px;">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(pRS("NOMBRE_CONTACTO")) %></td>
  </tr>
<% if 1=2 then		'pRS("TIPOCONTACTO")<>"N/D" then %>
  <tr>
    <td valign="top"><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(pRS("TIPOCONTACTO"))) %></td>
  </tr>
<%end if%>
<%if pRS("TLF_CONTACTO1")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=pRS("TLF_CONTACTO1")%>
	<%if pRS("TLF_CONTACTO2")<>"" then 
	response.write ", " & pRS("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if pRS("FAX_CONTACTO")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=pRS("FAX_CONTACTO")%></td>
  </tr>
<%end if%>
<%if pRS("EMAIL_CONTACTO")<>"" then 
	if len(pRS("EMAIL_CONTACTO"))>35 then
		txtMail=left(pRS("EMAIL_CONTACTO"),35) & "..."
	else
		txtMail=pRS("EMAIL_CONTACTO")
	end if
%>
  <tr>
    <td colspan="2">e-mail:&nbsp;<a href="mailto:<%=pRS("EMAIL_CONTACTO")%>"><acronym title='<%=pRS("EMAIL_CONTACTO")%>'> <%= txtMail %></acronym></a></td>
  </tr>
<%end if%>
</table>
<%if pRS("NOMBRE_CONTACTO_2")<>"N/D" AND pRS("NOMBRE_CONTACTO_2")<>"" then %>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(pRS("NOMBRE_CONTACTO_2")) %></td>
  </tr>
<%if 1=2 then	'pRS("TIPOCONTACTO2")<>"N/D" then %>
  <tr>
    <td><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(pRS("TIPOCONTACTO2"))) %></td>
  </tr>
<%end if%>
<%if pRS("TLF_CONTACTO1_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=pRS("TLF_CONTACTO1_2")%>
	<%if pRS("TLF_CONTACTO2")<>"" then 
	response.write ", " & pRS("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if pRS("FAX_CONTACTO_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=pRS("FAX_CONTACTO_2")%></td>
  </tr>
<%end if%>
<%if pRS("EMAIL_CONTACTO_2")<>"" then %>
  <tr>
    <td>e-mail:&nbsp;</td>
    <td><%=pRS("EMAIL_CONTACTO_2")%></td>
  </tr>
<%end if%>
</table>
<% end if 'Contacto2 %>

</div>
<% end if %>
<% END IF %>
<!-- contacto -->
<div style="height:12px"></div>
<!-- info adicional -->
<% if 1=2 then 'fechas %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Fechas</b></div>
<table border="0" cellspacing="2" cellpadding="0">
    <tr>
        <td width="6"></td>
        <td>Publicaci&oacute;n:</td>
        <td width="6"></td>
        <td><%=pRS("FECHA_PUBLICACION")%></td>
    </tr>
    <tr>
        <td width="6"></td>
        <td>Actualizaci&oacute;n:</td>
        <td width="6"></td>
        <td><%=pRS("FECHA_ACTUALIZACION")%></td>
    </tr>
</table>	
</div>
<% end if 'fechas %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Servicios PW</b></p></div>
	<li><a href="/servicios/publicar.asp">Poner anuncio gratis en EasyProperty </a></li>
	<li><a href="/servicios/boletin.asp">Recibir avisos EasyProperty </a></li>
	<li><a href="/servicios/estudios.asp">Informes detallados</a></li>
</div>
<!-- info adicional -->
    	</div>
	<div class="limpiaFloats"></div>
</div>
<div class="left_box" style="text-align:center; line-height:normal;">
	<p>Reservados todos los derechos. Prohibida la reproducci&oacute;n total o parcial de los contenidos de  sin permiso previo.</p>
	<p>EasyProperty no garantiza la exactitud de los contenidos ni se hace responsable de los contenidos que aparezcan.</p>
</div>

</div>	



</div>
<% if 1 = 2 then %>
<script src="https://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAgF6cheH-DOnmwecTUkLRFBTZigVrLvXLB7iNUlfK4jwZGNs_kBTHUGI3v1T03KJU3XlvSxUzGhff0g&hl=es" type="text/javascript"></script>
<script language=JavaScript type=text/javascript>
	// onload="initialize();showAddress('< %= dirGoogleMaps %>');"
	//initialize();
	//showAddress('<%= dirGoogleMaps %>');
</script>
<% end if %>

<% end sub %>
<%
function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function txtBD(rTexto)	
	txtP=rTexto
	if txtP<>"" then
		txtP=replace(txtP, "á", "&aacute;")
		txtP=replace(txtP, "Á", "&Aacute;")
		txtP=replace(txtP, "à", "&agrave;")
		txtP=replace(txtP, "À", "&Agrave;")
		txtP=replace(txtP, "é", "&eacute;")
		txtP=replace(txtP, "É", "&Eacute;")
		txtP=replace(txtP, "è", "&egrave;")
		txtP=replace(txtP, "È", "&Egrave;")
		txtP=replace(txtP, "í", "&iacute;")
		txtP=replace(txtP, "Í", "&Iacute;")
		txtP=replace(txtP, "ì", "&igrave;")
		txtP=replace(txtP, "Ì", "&Igrave;")
		txtP=replace(txtP, "ó", "&oacute;")
		txtP=replace(txtP, "Ó", "&Oacute;")
		txtP=replace(txtP, "ò", "&ograve;")
		txtP=replace(txtP, "Ò", "&Ograve;")
		txtP=replace(txtP, "ú", "&uacute;")
		txtP=replace(txtP, "Ú", "&Uacute;")
		txtP=replace(txtP, "ù", "&ugrave;")
		txtP=replace(txtP, "Ù", "&Ugrave;")
		txtP=replace(txtP, "ñ", "&ntilde;")
		txtP=replace(txtP, "Ñ", "&Ntilde;")
		txtP=replace(txtP, "ç", "&ccedil;")
		txtP=replace(txtP, "Ç", "&Ccedil;")
		
		txtP=replace(txtP, "€", "&euro;")
		txtP=replace(txtP, "¿", "&iquest;")
		txtP=replace(txtP, "º", "&deg;")
		txtP=replace(txtP, "ª", "&ordf;")
	end if
	txtBD=txtP
end function

function VERSALITA(Caden) 
    VERSALITA = UCase(Left(Caden, 1)) & LCase(Right(Caden, Len(Caden) - 1))
End function 

function VERSALITA_TODO(Caden) 
on error resume next
Dim a 
Dim wordsI(100)
Dim CuentPal
Dim IniPal
Dim cami 
Caden = Caden & " "
CuentPal = 1
IniPal = 0
For a = 1 To Len(Caden)
    If Mid(Caden, a, 1) = " " Then
        wordsI(CuentPal) = LCase(Mid(Caden, IniPal + 1, (a - IniPal)))
        If wordsI(CuentPal) <> "el " And _
   		wordsI(CuentPal) <> "la " And  _
    	wordsI(CuentPal) <> "los " And wordsI(CuentPal) <> "las " And _
    	wordsI(CuentPal) <> "del " And wordsI(CuentPal) <> "de " Then
            wordsI(CuentPal) = VERSALITA(wordsI(CuentPal))
        End If
        If wordsI(CuentPal) = "I " Or wordsI(CuentPal) = "Ii " Or _
        wordsI(CuentPal) = "Iii " Or wordsI(CuentPal) = "Iv " Or _
        wordsI(CuentPal) = "V " Or wordsI(CuentPal) = "Vi " Or _
        wordsI(CuentPal) = "Vii " Or wordsI(CuentPal) = "Viii" Or _
        wordsI(CuentPal) = "Ix " Or wordsI(CuentPal) = "X " Or _
        wordsI(CuentPal) = "Xi " Or wordsI(CuentPal) = "Xii " Or _
        wordsI(CuentPal) = "Xiii " Or wordsI(CuentPal) = "Xiv" Then
            wordsI(CuentPal) = UCase(wordsI(CuentPal))
        End If
        cami = cami & wordsI(CuentPal)
        IniPal = a
        cuenpal = cuenpal + 1
    End If
Next

VERSALITA_TODO = Left(cami, Len(cami) - 1)
End Function
%>