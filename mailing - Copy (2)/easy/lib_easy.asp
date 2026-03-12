<% sub FichaAnuncio(byRef pRS) %>
<table width="525" border="0" cellspacing="0" cellpadding="0">
    <tr><td><a href="<%= enlace_easy %>" target="_blank"><img src="/mailing/easy/fichas/top.gif" width="525" height="30" border="0"></a></td></tr>
    <tr><td align="left" background="/mailing/easy/fichas/contents.gif">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  	<td width="10"></td>
  	<td align="left">
<!-- Detalle Oferta : INI -->
<% call detalle_oferta(pRS) %>
<!-- Detalle Oferta : Fin -->
	</td>
    <td width="5"></td>
  </tr>
</table>
		</td>
  </tr>
  <tr><td><a href="<%= enlace_easy %>" target="_blank">
<% if pRS("secc")="vivienda" then %><img src="/mailing/easy/fichas/bottom_1.gif" width="525" height="26" border="0"/>
<% else %><img src="/mailing/easy/fichas/bottom_2.gif" width="525" height="26" border="0"><% end if %>
	</a></td></tr>
  <tr height="2"><td></td></tr>
</table>
<%
	'response.Write(pTexto)
end sub %>

<% sub info_opciones(byRef pRS) %>
<table border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td width="8"></td>
		<td><% SELECT CASE ucase(pRS("operacion")) %>
		<% case "VENTA" %><img src="/mailing/easy/img/venta.gif" alt="Venta" width="23" height="20" border="0" />
		<% case "ALQUILER" %><img src="/mailing/easy/img/alquiler.gif" alt="Alquiler" width="23" height="20" border="0" />
		<% case "INVERSION" %><img src="/mailing/easy/img/inversion.gif" alt="Inversi&oacute;n" width="23" height="20" border="0" />
		<% case "TRASPASO" %><img src="/mailing/easy/img/traspaso.gif" alt="Traspaso" width="23" height="20" border="0" />
		<% end select %></td>
		<td width="5"></td>
		<td class="precio" valign="middle"><%= calcPrecio %></td>
		<td>&nbsp;<% 'Obra Nueva %>&nbsp;</td>
		<td><% if pRS("numero_fotos")>0 then %>
			<a href="<%= enlace_easy %>" target="_blank"><img src="/mailing/easy/img/sifoto.gif" alt="Fotos" width="23" height="20" border="0" /></a>
		<% end if %></td>
		<td><% if dd<>"S/D" and dd<>"N/D"  then %>
			<a href="<%= enlace_easy %>" target="_blank"><img src="/mailing/easy/img/sidire.gif" alt="<%= verDir %>" width="23" height="20" border="0" /></a>
		<% end if %></td>
		<td><% if 1=1 then %>
			<a href="<%= enlace_easy %>" target="_blank"><img src="/mailing/easy/img/info.gif" alt="M&aacute;s Informaci&oacute;n" width="23" height="20" border="0" /></a>
		<% end if %></td>
	    <td width="15"></td>
	</tr>
</table>
<% end sub %>

<% sub CalcularTitulo(byRef pRS) 	
if lcase(session("PW_WS").strCodIdioma)="es" then
	'es
	IF LEN(pRS("TITULO"))<3 OR ISNULL(pRS("TITULO")) THEN 
		RESPONSE.WRITE "<font class='azullink' color='#999999'>" & pRS("TITULO_PT") & "</FONT>"
	'	CalcularTitulo="<font class='azullink' color='#999999'>" & pRS("TITULO_AUX") & "</FONT>"
	ELSE
		RESPONSE.WRITE pRS("TITULO")
	'	CalcularTitulo=pRS("TITULO")
	END IF

else
	'pt
	IF LEN(pRS("TITULO_PT"))<3 OR ISNULL(pRS("TITULO_PT")) THEN 
		RESPONSE.WRITE "<font class='azullink' color='#999999'>" & pRS("TITULO") & "</FONT>"
	'	CalcularTitulo="<font class='azullink' color='#999999'>" & pRS("TITULO_AUX") & "</FONT>"
	ELSE
		RESPONSE.WRITE pRS("TITULO_PT")
	'	CalcularTitulo=pRS("TITULO")
	END IF
	
end if


end sub %>

<% sub info_pie %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr height="3"><td colspan="2"></td></tr>
  <tr>
    <td width="45"></td>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="25%" valign="top" class="texto_pie"></td>
    <td width="25%" valign="top" class="texto_pie"></td>
    <td width="25%" valign="top" class="texto_pie"></td>
    <td width="25%" valign="top" class="texto_pie"></td>
  </tr>
</table>
    </td>
  </tr>
</table>
<% end sub %>

<% sub detalle_oferta(byRef pRS) %>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr><td colspan="2"><a href="<%= enlace_easy %>" target="_blank" class="style1"><% CalcularTitulo(pRS) %></a></td></tr>
    <tr>
    	<td><%= pRS("secc") %></td>
		<td align="right" valign="bottom"><%= pRS("provincia") %></td>
	</tr>
	<tr><td colspan="2"><% info_opciones(pRS) %></td></tr>
</table>
<% end sub %>
