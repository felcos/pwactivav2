<% sub popover_empresa() %>
<table cellspacing='0' cellpadding='0' width='100%' class='table-hover'>
  <tr>
    <th style='text-align:left;'><b>secci&oacute;n</b></th>
    <th width='20'></th>
    <th><b>hoy</b></th>
    <th width='10'></th>
    <th><b>bd</b></th>
    <th width='10'></th>
    <th><b>internac.</b></th>
  </tr>
  <tr>
    <td>noticias </td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoNoticiasHoy or session("pw_ws").accesoNoticias then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoNoticias then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'>&nbsp;</td>
    <td align='center'><% if (session("pw_ws").accesoNoticiasHoy OR session("pw_ws").accesoNoticias) AND session("pw_ws").accesoInternacional then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
  </tr>
  <tr>
    <td>web ha o&iacute;do... </td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoRumoresHoy or session("pw_ws").accesoRumores then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoRumores then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'>&nbsp;</td>
    <td align='center'><% if (session("pw_ws").accesoRumoresHoy OR session("pw_ws").accesoRumores) AND session("pw_ws").accesoInternacional then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
  </tr>
  <tr>
    <td>estudios </td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoEstudiosHoy or session("pw_ws").accesoEstudios then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoEstudios then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'>&nbsp;</td>
    <td align='center'><% if (session("pw_ws").accesoEstudiosHoy OR session("pw_ws").accesoEstudios) AND session("pw_ws").accesoInternacional then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
  </tr>
  <tr>
    <td>operaciones</td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoOperacionesHoy or session("pw_ws").accesoOperaciones then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoOperaciones then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'>&nbsp;</td>
    <td align='center'><% if (session("pw_ws").accesoOperacionesHoy OR session("pw_ws").accesoOperaciones) AND session("pw_ws").accesoInternacional then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
  </tr>
  
  <tr height='10'>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  
  <tr>
    <td>vencimientos</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoVencimientos then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>subastas</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoSubastas then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>demandas</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoDemandas then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>Inversores</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInversores then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr height='10'>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>Disponibilidad</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoDisponibilidad then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>Take Up</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoTakeUp then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr height='10'>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>info-Propietario</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoPropietario then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  
  <tr>
    <td>info-Centro Comercial</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoCentroComercial then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>info-Hotel</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoHotel then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>info-Edificio</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoEdificio then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>info-Empresa</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoEmpresa then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  <tr>
    <td>info-Calle</td>
    <td>&nbsp;</td>
    <td align='center'></td>
    <td>&nbsp;</td>
    <td align='center'><% if session("pw_ws").accesoInfoCalle then %><span class='icon-checkbox-checked'></span><% else %><span class='icon-checkbox-unchecked'></span><% end if %></td>
    <td align='center'></td>
    <td align='center'></td>
  </tr>
  
  <tr height='10'>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
</table>
<% end sub

sub popover_licencia() %>
<table width='100%' border='0' cellspacing='2' cellpadding='2'>
<tr>
	<td> </td>
	<td> IniCliente() </td>
	<td> <%= ini %></td>
</tr>
<tr><td colspan='3'>&nbsp;</td></tr>
<tr>
	<td><%= request.Cookies("licencia")("user_id") %> </td>
	<td> <%= request.Cookies("licencia")("n") %> </td>
	<td> <%= session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %></td>
</tr>
<tr>
	<td><%= request.Cookies("licencia")("client_id") %> </td>
	<td> <%= request.Cookies("licencia")("u") %></td>
	<td> <%= session("pw_ws").ComprobarEmpresa(request.Cookies("licencia")("u"), request.Cookies("licencia")("p")) %></td>
</tr>
</table>

<strong>Fechas</strong>:
<table border='0' cellspacing='2' cellpadding='2'>
	<tr><td>registro:&nbsp;</td>				<td><%= request.Cookies("licencia")("registro") %></td></tr>
	<tr><td>access:&nbsp;</td>			<td><%= request.Cookies("licencia")("access") %></td></tr>
	<tr><td>f_access_content:&nbsp;</td>	<td><%= request.Cookies("licencia")("f_access_content") %></td></tr>
	<tr><td>expire:&nbsp;</td>			<td><%= request.Cookies("licencia")("expire") %></td></tr>
</table>

<table width='100%' border='0' cellspacing='2' cellpadding='2'>
<tr>
	<td width='25%'><% if request.Cookies("licencia")("log")<>"" then %><strong>NO LOG</strong><% end if %></td>
	<td width='25%'></td>
	<td width='25%'><% if request.Cookies("dev")("reg")<>"" then %><strong>NO REG</strong><% end if %></td>
	<td width='25%'></td>
</tr>
</table>	
<% end sub %>

<% sub popover_quotas() 
	xx = split(session("pw_ws").InformaQuotas(), vbcrlf)
	for each elto in xx
		if elto<>"" then
			%><li><%= elto %></li><%
		end if
	next

	
	%>
<% end sub %>
<% sub popover_articulos_leidos() 
	xx = split(session("pw_ws").ArticulosLeidos(), "#")
	for each elto in xx
		if elto<>"" then
			%><li><%= elto %></li><%
		end if
	next

	
	%>
<% end sub %>