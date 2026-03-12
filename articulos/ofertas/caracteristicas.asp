<table border="0" cellspacing="2" cellpadding="0" style="margin-left:4px">
  <tr valign="top">
    <td align="right"><strong>Tipo Vivienda</strong>:&nbsp;</td>
    <td></td>
    <td><%= lcase(txtBD(pRS("tipo_vivienda_es"))) %></td>
  </tr>
  <tr height="4"><td colspan="3"></td></tr>
<% if pRS("id_tipo_oferta")=9 then %>
  <tr valign="top">
    <td align="right"><strong><%response.write session("parrafo").item(351)' tipo Ofert%></strong>:&nbsp;</td>
    <td></td>
    <td><%select case session("lang")
	case "es"
		response.write lcase(txtBD(pRS("TIPOOPERACION")))
	case "en"
		response.write lcase(txtBD(pRS("TIPOOPERACION_EN")))
	case "pt"
		response.write lcase(txtBD(pRS("TIPOOPERACION_PT")))
	end select 
	%></td>
  </tr>
  <tr height="4"><td colspan="3"></td></tr>
<% end if %>
  <tr valign="top">
    <td align="right"><b>Dimensiones</b>:&nbsp;</td>
    <td></td>
    <td>&nbsp;<% if isnull(pRS("METROS_CUADRADOS")) then
	numero=0
else
	numero=pRS("METROS_CUADRADOS")
end if
if numero =0 then
	response.write "n/d"
else
	response.write formatnumber(numero,0) & "&nbsp;m&sup2;"
end if %></td>
  </tr>
  <tr height="4"><td colspan="3"></td></tr>
  <tr valign="top">
    	<td width="80" align="right"><strong>Precio/Renta</strong>:&nbsp;</td>
    	<td width="6"></td>
        <td>
<% if pRS("PRECIO_EUR")="0" then %>: n/d 
<% else		'pRS("PRECIO_EUR")="0" %>
<% if pRS("TIPOOPERACION")="ALQUILER" then
	'calculo los euros año 
	If Instr(1,pRS("TIPOPRECIO"),"M2") then
		precioEu1=formatnumber(cdbl(pRS("PRECIO_EUR"))*12*pRS("METROS_CUADRADOS"),2)
	else
		precioEu1=formatnumber(cdbl(pRS("PRECIO_EUR"))*12,2)
	end if
	'calculo los euros mes 
	If Instr(1,pRS("TIPOPRECIO"),"M2") then
		precioEu2=formatnumber(cdbl(pRS("PRECIO_EUR"))*pRS("METROS_CUADRADOS"),2)		
	else
		precioEu2=formatnumber(cdbl(pRS("PRECIO_EUR")),2)
	end if
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% if 1=2 then
	'pRS("id")<>5332 then
	'Particularizado para que la oferta 5332 se vea como quiere el cliente %>
	<tr> 
		<td align="right" nowrap class="<%=color%>"><%=precioEu1%>&nbsp;</td>
		<td class="<%=color%>">&nbsp;&euro;/<%response.write session("parrafo").item(368)'Año%></td>
	</tr>
    <tr> 
		<td align="right"><%=precioEu2%>&nbsp;</td>
		<td class="<%=color%>">&nbsp;&euro;/<%response.write session("parrafo").item(367)'mes%></td>
	</tr>
<% end if %>
<% if pRS("METROS_CUADRADOS")>0 then 
	'calculo los euros m2 ano 
	If Instr(1,pRS("TIPOPRECIO"),"M2") then							
		precioEu3=formatnumber(cdbl(pRS("PRECIO_EUR"))*12, 2)
	else
		precioEu3=formatnumber(((pRS("PRECIO_EUR")*12)/pRS("METROS_CUADRADOS")),2)
	end if
	'calculo los euros m2 ano 
	If Instr(1,pRS("TIPOPRECIO"),"M2") then							
		precioEu4=formatnumber((pRS("PRECIO_EUR")),2)			
	else
		precioEu4=formatnumber(((pRS("PRECIO_EUR"))/pRS("METROS_CUADRADOS")),2)
	end if %>
	<% if 1=2 then
	'pRS("id")<>5332 then
	'Particularizado para que la oferta 5332 se vea como quiere el cliente %>
	<tr>
		<td align="right"><%=precioEu3%>&nbsp;</td>
		<td class="<%=color%>">&nbsp;&euro;/M2/<%response.write session("parrafo").item(368)'Año%></td>
	</tr>
	<% end if %>
	<tr><td colspan="2" height="3"></td></tr>
	<tr> 
		<td align="right"><%=precioEu4%>&nbsp;</td>
		<td class="<%=color%>">&nbsp;&euro;/M2/<%response.write session("parrafo").item(367)'mes%>  </td>
	</tr>
<%end if%>
</table>
<% else	'pRS("TIPOOPERACION")="ALQUILER" 
	'calculo los euros
	If Instr(1,pRS("TIPOPRECIO"),"M2") then
		precioEu1=formatnumber(cdbl(pRS("PRECIO_EUR"))*pRS("METROS_CUADRADOS"),2)
	else
		precioEu1=formatnumber(cdbl(pRS("PRECIO_EUR")),2)
	end if
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
        <td align="right" nowrap class="<%=color%>"><%=precioEu1%>&nbsp;</td>
        <td class="<%=color%>">&nbsp;&euro;</td>
    </tr>
	<tr><td colspan="2" height="3"></td></tr>
<% if pRS("METROS_CUADRADOS")>0 then
	'calculo los euros
	If Instr(1,pRS("TIPOPRECIO"),"M2") then
		precioEu2=formatnumber((pRS("PRECIO_EUR")),2)
	else
		precioEu2=formatnumber(((pRS("PRECIO_EUR"))/pRS("METROS_CUADRADOS")),2)
	end if%>
	<tr>
		<td align="right"><%=precioEu2%>&nbsp;</td>
		<td class="<%=color%>">&nbsp;&euro;/M2</td>
	</tr>
<% end if %>
</table>
<% end if	'pRS("TIPOOPERACION")="ALQUILER" %>
<% end if 	'pRS("PRECIO_EUR")="0" %>
    	</td>
  </tr>
</table>
