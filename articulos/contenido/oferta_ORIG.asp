<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="https://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="/style.css" media="screen" />
<title>EasyProperty - El buscador f&aacute;cil inmobiliario</title>
<% session("pag_activa") = "/ofertas/?" & request.QueryString %>
<%
if request.QueryString("id")="" then response.Redirect("/")

if request.QueryString("origen")="mailing_pw" then
	if request.cookies("easyproperty")("modo")="part" then
		response.Cookies("easyproperty").Domain = "www.easyproperty.es"
		response.Cookies("easyproperty").Expires = Date + 30
		response.Cookies("easyproperty")("modo")="prof"
		session("modo")="prof"
	end if
end if
%>
</head>
<% 
id_anuncio = request.QueryString("id")
if instr(request.Cookies("easyproperty")("favoritos"), id_anuncio & "x") then 
	fav_texto = "quitar de Mi Selecci&oacute;n"
	fav_link = "/ex/del_fav.asp?id=" & id_anuncio
	fav_img = "/img/tablas/sel_on.gif"
else
	fav_texto = "a&ntilde;adir a Mi Selecci&oacute;n"
	fav_link = "/ex/add_fav.asp?id=" & id_anuncio
	fav_img = "/img/tablas/sel_off.gif"
end if

sql="SELECT * FROM easy_todo WHERE id=" & id_anuncio

'response.Write(sql)
'response.End()
	
set rsOferta = Server.CreateObject("ADODB.recordset")
rsOferta.Open sql, Application("cnx_pw")		', 1, 1

if rsOferta.eof then 
	session("mensaje_busq")="No existe el anuncio solicitado."
	response.Redirect("/")
end if
if not(rsOferta("web_es")) and rsOferta("id_user")<>session("usr_id") then
	session("mensaje_busq")="El anuncio solicitado no est&aacute; disponible."
	response.Redirect("/")
end if

'insertar visita oferta
sql = "INSERT INTO ofertas_visitas (oferta_id, fecha, session_id, usr_id) VALUES ("
sql = sql & rsOferta("id") & ", "
sql = sql & "GETDATE(), '" & session.SessionID & "', "
if session("usr_auth") then
	sql = sql & session("usr_id")
else
	sql = sql & "NULL"
end if 
sql = sql & ")"
session("cnx_easy").execute sql
%>
<% dirGoogleMaps=""
	if (len(rsOferta("NOMBRE_CALLE"))>3 AND rsOferta("id_pais")=1) then
		dirGoogleMaps = rsOferta("TIPODIRECCION") & "&nbsp;" & rsOferta("NOMBRE_CALLE") 
		'if rsOferta("id_tipo_oferta")<>3 and rsOferta("id_tipo_oferta")<>9 then
			if not(isnull(rsOferta("NUMERO_PORTAL"))) then
				dirGoogleMaps = dirGoogleMaps & "&nbsp;" & rsOferta("NUMERO_PORTAL")
			end if
		'end if
		dirGoogleMaps = dirGoogleMaps &  ", "
	'else
	'	if rsOferta("NOMBRE_ZONA")<>"" AND rsOferta("NOMBRE_ZONA")<>"" then
	'		tmpTxt = ""
	'		'IF rsOferta("TIPOZONA")<>"N/D" THEN
	'		'	tmpTxt = VERSALITA_TODO(txtBD(rsOferta("TIPOZONA"))) & " "
	'		'END IF
	'		tmpTxt = tmpTxt & VERSALITA_TODO(txtBD(rsOferta("NOMBRE_ZONA"))) & ", "
	'		dirGoogleMaps = tmpTxt & dirGoogleMaps
	'	end if
	end if 
	
	dirGoogleMaps = dirGoogleMaps & rsOferta("LOCALIDAD") 
	if rsOferta("CODIGO_POSTAL")<>"" then 
		if len(rsOferta("CODIGO_POSTAL"))>=5 then dirGoogleMaps = dirGoogleMaps & ", "  & rsOferta("CODIGO_POSTAL") 
	end if
	dirGoogleMaps = dirGoogleMaps & ", " & rsOferta("pais")
	dirGoogleMaps = txtBD(dirGoogleMaps)
	'dirGoogleMaps = Replace (dirGoogleMaps, "'", "&apos;")
	dirGoogleMaps = Replace (dirGoogleMaps, "'", "´")
%>
<body onunload="GUnload()">
<div id="content">
<!--#include virtual="/inc/divs/header.asp" -->
<div id="left">
<div class="left_articles">
    <div class="right"><%
		if request.QueryString("origen")="mailing_pw" or session("pag_listado")="" then 
			%><a href="/"><strong>&laquo;</strong>&nbsp;inicio EasyProperty</a><%
		else
			link = session("pag_listado")
			'if instr(session("pag_listado"), "?pag=1") then link = replace(link, "?pag=1", "")
			%><a href="<%= link %>"><strong>&laquo;</strong>&nbsp;volver</a><%
		end if %>
    </div>
    <h2>EasyProperty</h2>
</div>
<div class="titulo_oferta">
	<div style="float:right; padding-right:8px;"><a href="<%= fav_link %>" title="<%= fav_texto %>"><img src="<%= fav_img %>" border="0" id="<%= id_anuncio %>"></a></div><strong>&nbsp;<%= txtBD(rsOferta("titulo")) %></strong></div>
<div class="oferta">
    <div class="tblTwo">
<!-- dirección -->
<div class="tblDetalle">
  <!--#include virtual="/ofertas/inc/mapa.asp" -->
  <div class="tblDetalle_titulo"><b>Direcci&oacute;n</b></p></div>
	<p><%
coma=""
'cambiamos SeccionActiva por secc
If rsOferta("id_tipo_oferta") <> 8 Then 
	IF rsOferta("EDIFICIO")<>"N/D" AND rsOferta("EDIFICIO")<>"" THEN
			response.write "Edificio " & VERSALITA_TODO(txtBD(rsOferta("EDIFICIO")))
			coma =", "
	END IF
end if
IF rsOferta("TIPODIRECCION")<>"N/D" and rsOferta("NOMBRE_CALLE")<>"N/D" THEN
	response.write coma & VERSALITA_TODO(txtBD(rsOferta("TIPODIRECCION")))
	coma=" "
	response.write coma & VERSALITA_TODO(txtBD(rsOferta("NOMBRE_CALLE")))
	coma=" "
END IF
If rsOferta("id_tipo_oferta") <> 8 and rsOferta("id_tipo_oferta") <> 1 Then
	IF rsOferta("NUMERO_PORTAL")<>"N/D" and rsOferta("NUMERO_PORTAL")<>"" and rsOferta("NUMERO_PORTAL")<>"0" THEN
		response.write coma & rsOferta("NUMERO_PORTAL")
		coma = ", "
	END IF
end if
If rsOferta("id_tipo_oferta") = 5 Or rsOferta("id_tipo_oferta") = 9 Then
	If rsOferta("PISO") <> "0" And rsOferta("PISO") <> "" And rsOferta("PISO") <> "-" Then
			response.write coma & "piso " & rsOferta("PISO")& "&deg;" 
			coma = "<br>"
	End If
end if 
	
if coma <> "" then coma ="<br>"
if rsOferta("NOMBRE_ZONA")<>"" AND rsOferta("NOMBRE_ZONA")<>"N/D" then
	IF rsOferta("TIPOZONA")<>"N/D" THEN
		response.write coma & VERSALITA_TODO(txtBD(rsOferta("TIPOZONA")))
		coma =" "
	END IF
	response.write coma & VERSALITA_TODO(txtBD(rsOferta("NOMBRE_ZONA")))
	coma ="<br>"
end if
if coma <> "" then coma ="<br>"
 IF rsOferta("LOCALIDAD")<>"N/D" THEN
	response.write coma & VERSALITA_TODO(txtBD(rsOferta("LOCALIDAD")))
	coma=" "
END IF
 IF rsOferta("CODIGO_POSTAL")<>"N/D" THEN
 	if len(rsOferta("CODIGO_POSTAL"))>=5 then 
		response.write coma & rsOferta("CODIGO_POSTAL")
		coma ="<br>"
	end if
END IF
if coma <> "" then coma ="<br>"
IF rsOferta("PROVINCIA")<>"N/D" AND rsOferta("PROVINCIA")<> rsOferta("LOCALIDAD") THEN
	response.write coma & txtBD(rsOferta("PROVINCIA"))
END IF
response.write "<br>" & txtBD(rsOferta("pais"))
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
texto = txtBD(rsOferta("comentarios"))
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
<!--#include virtual="/ofertas/inc/fotos.asp" -->
<!-- contacto -->
<% IF 1=2 THEN %>
<% if rsOferta("NOMBRE_CONTACTO")<>"N/D" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Contacto</b></p></div>
<table border="0" cellspacing="2" cellpadding="0" style="padding-left:8px;">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(rsOferta("NOMBRE_CONTACTO")) %></td>
  </tr>
<%if rsOferta("TIPOCONTACTO")<>"N/D" then %>
  <tr>
    <td valign="top"><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(rsOferta("TIPOCONTACTO"))) %></td>
  </tr>
<%end if%>
<%if rsOferta("TLF_CONTACTO1")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=rsOferta("TLF_CONTACTO1")%>
	<%if rsOferta("TLF_CONTACTO2")<>"" then 
	response.write ", " & rsOferta("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if rsOferta("FAX_CONTACTO")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=rsOferta("FAX_CONTACTO")%></td>
  </tr>
<%end if%>
<%if rsOferta("EMAIL_CONTACTO")<>"" then 
	if len(rsOferta("EMAIL_CONTACTO"))>35 then
		txtMail=left(rsOferta("EMAIL_CONTACTO"),35) & "..."
	else
		txtMail=rsOferta("EMAIL_CONTACTO")
	end if
%>
  <tr>
    <td colspan="2">e-mail:&nbsp;<a href="mailto:<%=rsOferta("EMAIL_CONTACTO")%>"><acronym title='<%=rsOferta("EMAIL_CONTACTO")%>'> <%= txtMail %></acronym></a></td>
  </tr>
<%end if%>
</table>
<%if rsOferta("NOMBRE_CONTACTO_2")<>"N/D" AND rsOferta("NOMBRE_CONTACTO_2")<>"" then %>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(rsOferta("NOMBRE_CONTACTO_2")) %></td>
  </tr>
<%if rsOferta("TIPOCONTACTO2")<>"N/D" then %>
  <tr>
    <td><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(rsOferta("TIPOCONTACTO2"))) %></td>
  </tr>
<%end if%>
<%if rsOferta("TLF_CONTACTO1_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=rsOferta("TLF_CONTACTO1_2")%>
	<%if rsOferta("TLF_CONTACTO2")<>"" then 
	response.write ", " & rsOferta("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if rsOferta("FAX_CONTACTO_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=rsOferta("FAX_CONTACTO_2")%></td>
  </tr>
<%end if%>
<%if rsOferta("EMAIL_CONTACTO_2")<>"" then %>
  <tr>
    <td>e-mail:&nbsp;</td>
    <td><%=rsOferta("EMAIL_CONTACTO_2")%></td>
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
	<!--#include virtual="/ofertas/inc/caracteristicas.asp" -->
</div>
<!-- precios -->
<!-- especificaciones -->
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Especificaciones</b></div>
    <div style="padding-left:4px;"><!--#include virtual="/ofertas/inc/especificaciones.asp" --></div>
</div>
<!-- especificaciones -->
<div style="height:12px"></div>
<!-- propietario -->
<% IF 1=2 THEN %>
<% if rsOferta("PROPIETARIO1")<>"N/D" and  rsOferta("PROPIETARIO1")<>"" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Propiedad</b></div>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=rsOferta("PROPIETARIO1")%></div></td>
  </tr>
<%if rsOferta("PROPIETARIO2")<>"N/D" and rsOferta("PROPIETARIO2")<>"" then %>
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=rsOferta("PROPIETARIO2")%></div></td>
  </tr>
<% end if 'PROPIETARIO2 %>
<% if rsOferta("PROPIETARIO3")<>"N/D" and rsOferta("PROPIETARIO3")<>"" then %>
  <tr>
    <td><div align="right"><%response.write session("parrafo").item(369)'Nombre%></div></td>
    <td><div align="right"><%=rsOferta("PROPIETARIO3")%></div></td>
  </tr>
<% end if 'PROPIETARIO3 %>
</table>
</div>
<% end if %>
<% END IF %>
<!-- propietario -->
<!-- contacto -->
<% IF 1=2 THEN %>
<% if rsOferta("NOMBRE_CONTACTO")<>"N/D" then %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Contacto</b></p></div>
<table border="0" cellspacing="2" cellpadding="0" style="padding-left:8px;">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(rsOferta("NOMBRE_CONTACTO")) %></td>
  </tr>
<% if 1=2 then		'rsOferta("TIPOCONTACTO")<>"N/D" then %>
  <tr>
    <td valign="top"><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(rsOferta("TIPOCONTACTO"))) %></td>
  </tr>
<%end if%>
<%if rsOferta("TLF_CONTACTO1")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=rsOferta("TLF_CONTACTO1")%>
	<%if rsOferta("TLF_CONTACTO2")<>"" then 
	response.write ", " & rsOferta("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if rsOferta("FAX_CONTACTO")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=rsOferta("FAX_CONTACTO")%></td>
  </tr>
<%end if%>
<%if rsOferta("EMAIL_CONTACTO")<>"" then 
	if len(rsOferta("EMAIL_CONTACTO"))>35 then
		txtMail=left(rsOferta("EMAIL_CONTACTO"),35) & "..."
	else
		txtMail=rsOferta("EMAIL_CONTACTO")
	end if
%>
  <tr>
    <td colspan="2">e-mail:&nbsp;<a href="mailto:<%=rsOferta("EMAIL_CONTACTO")%>"><acronym title='<%=rsOferta("EMAIL_CONTACTO")%>'> <%= txtMail %></acronym></a></td>
  </tr>
<%end if%>
</table>
<%if rsOferta("NOMBRE_CONTACTO_2")<>"N/D" AND rsOferta("NOMBRE_CONTACTO_2")<>"" then %>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td><%response.write session("parrafo").item(369)'Nombre%>:&nbsp;</td>
    <td><%= txtBD(rsOferta("NOMBRE_CONTACTO_2")) %></td>
  </tr>
<%if 1=2 then	'rsOferta("TIPOCONTACTO2")<>"N/D" then %>
  <tr>
    <td><%response.write session("parrafo").item(378)'Tipo%>:&nbsp;</td>
    <td><%= lcase(txtBD(rsOferta("TIPOCONTACTO2"))) %></td>
  </tr>
<%end if%>
<%if rsOferta("TLF_CONTACTO1_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(379)'Teléfono%>:&nbsp;</td>
    <td><%=rsOferta("TLF_CONTACTO1_2")%>
	<%if rsOferta("TLF_CONTACTO2")<>"" then 
	response.write ", " & rsOferta("TLF_CONTACTO2") 
	end if%>
	</td>
  </tr>
<%end if%>
<%if rsOferta("FAX_CONTACTO_2")<>"" then %>
  <tr>
    <td><%response.write session("parrafo").item(380)'Fax%>:&nbsp;</td>
    <td><%=rsOferta("FAX_CONTACTO_2")%></td>
  </tr>
<%end if%>
<%if rsOferta("EMAIL_CONTACTO_2")<>"" then %>
  <tr>
    <td>e-mail:&nbsp;</td>
    <td><%=rsOferta("EMAIL_CONTACTO_2")%></td>
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
        <td><%=rsOferta("FECHA_PUBLICACION")%></td>
    </tr>
    <tr>
        <td width="6"></td>
        <td>Actualizaci&oacute;n:</td>
        <td width="6"></td>
        <td><%=rsOferta("FECHA_ACTUALIZACION")%></td>
    </tr>
</table>	
</div>
<% end if 'fechas %>
<div class="tblDetalle">
	<div class="tblDetalle_titulo"><b>Servicios PW</b></p></div>
	<li><a href="/servicios/publicar.asp">Poner anuncio gratis en EasyProperty </a></li>
	<li><a href="/servicios/boletin.asp">Recibir avisos EasyProperty </a></li>
	<li><a href="/servicios/estudios.asp">Informes detallados</a></li>
<% if request.Cookies("dev")<>"" then %>
	<ul>
    	<li><a href="" onclick="javascript:document.location='/ofertas/edit/set_id.asp?id=<%= rsOferta("id") %>';return false;">editar oferta</a></li>
        <li><a href="/ofertas/edit_OLD.asp?id=<%= rsOferta("id") %>" target="_blank">editar oferta (OLD)</a></li>
    </ul>
<% end if %>
</div>
<!-- info adicional -->
    	</div>
	<div class="limpiaFloats"></div>
</div>
<div class="left_box" style="text-align:center; line-height:normal;">
	<p>Reservados todos los derechos. Prohibida la reproducci&oacute;n total o parcial de los contenidos de  sin permiso previo.</p>
	<p>EasyProperty no garantiza la exactitud de los contenidos ni se hace responsable de los contenidos que aparezcan.</p>
</div>
<!--#include virtual="/inc/ultimos_anuncios.asp" -->
</div>	

<div id="right"><!--#include virtual="/inc/divs/right.asp" --></div>
<div id="footer"><!--#include virtual="/inc/divs/footer.asp" --></div>
</div>
</body>
<%
rsOferta.close
set rsOferta=nothing
%>
</html>
<script src="https://maps.google.com/maps?file=api&amp;v=2.x&amp;key=ABQIAAAAgF6cheH-DOnmwecTUkLRFBTZigVrLvXLB7iNUlfK4jwZGNs_kBTHUGI3v1T03KJU3XlvSxUzGhff0g&hl=es" type="text/javascript"></script>
<script language=JavaScript type=text/javascript>
	// onload="initialize();showAddress('< %= dirGoogleMaps %>');"
	initialize();
	showAddress('<%= dirGoogleMaps %>');
</script>