<div class="panel panel-default">
    <div class="panel-heading">Informa Cliente</div>
    <div class="panel-body">
<% 
resp = session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
%>
<% if request.Cookies("dev")<>"" then %>
<p>Informaci&oacute;n sobre la cookie licencia: <% if request.Cookies("licencia")="" then %><b>NO EXISTE</b><% end if %></p></p>
<table border="0" cellspacing="0" cellpadding="0" class="tbl_jp">
  <tr>
    <td width="50" nowrap>&nbsp; cliente:</td>
    <td width="5"></td>
    <td>[<%= session("pw_ws").ComprobarEmpresa(request.Cookies("licencia")("u"),request.Cookies("licencia")("p")) %>]</td>
    <td width="20"></td>
    <td width="40"><b><%= request.Cookies("licencia")("u") %></b></td>
    <td>(<%= request.Cookies("licencia")("client_id") %>)</td>
    <td width="20"></td>
    <td>activo: &nbsp; </td>
    <td><% if resp=0 then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
  </tr>
  <tr>
    <td nowrap>&nbsp; licencia:</td>
    <td></td>
    <td>[<%= resp %>]</td>
    <td></td>
    <td><b><%= request.Cookies("licencia")("n") %></b></td>
    <td>(<%= request.Cookies("licencia")("user_id") %>)</td>
    <td></td>
    <td>.IniCliente: &nbsp; </td>
    <td>&nbsp;<%= session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil")) %></td>
  </tr>
  <tr>
    <td colspan="9" height="1"></td>
  </tr>
</table>
<% end if %>

<% select case resp 
case 0		'Licencia OK: iniCliente %>
<table cellspacing="0" cellpadding="0" class="tbl_jp" width="100%">
  <tr>
    <th><b>secci&oacute;n</b></th>
    <th width="20"></th>
    <th><b>hoy</b></th>
    <th width="10"></th>
    <th><b>bd</b></th>
    <th width="10"></th>
    <th><b>internac.</b></th>
  </tr>
  <tr>
    <td>noticias </td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoNoticiasHoy or session("pw_ws").accesoNoticias then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoNoticias then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center">&nbsp;</td>
    <td align="center"><% if (session("pw_ws").accesoNoticiasHoy OR session("pw_ws").accesoNoticias) AND session("pw_ws").accesoInternacional then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
  </tr>
  <tr>
    <td>web ha o&iacute;do... </td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoRumoresHoy or session("pw_ws").accesoRumores then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoRumores then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center">&nbsp;</td>
    <td align="center"><% if (session("pw_ws").accesoRumoresHoy OR session("pw_ws").accesoRumores) AND session("pw_ws").accesoInternacional then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
  </tr>
  <tr>
    <td>estudios </td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoEstudiosHoy or session("pw_ws").accesoEstudios then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoEstudios then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center">&nbsp;</td>
    <td align="center"><% if (session("pw_ws").accesoEstudiosHoy OR session("pw_ws").accesoEstudios) AND session("pw_ws").accesoInternacional then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
  </tr>
  <tr>
    <td>operaciones</td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoOperacionesHoy or session("pw_ws").accesoOperaciones then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoOperaciones then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center">&nbsp;</td>
    <td align="center"><% if (session("pw_ws").accesoOperacionesHoy OR session("pw_ws").accesoOperaciones) AND session("pw_ws").accesoInternacional then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
  </tr>
  
  <tr height="10">
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
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoVencimientos then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td>subastas</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoSubastas then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td>demandas</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoDemandas then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  
  <tr height="10">
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>inversores</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInversores then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  
  <tr height="10">
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  
  <tr>
    <td>info - Empresa</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoEmpresa then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td>info - Edificio</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoEdificio then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  
  <tr>
    <td>Disponibilidad</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoDisponibilidad then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  
  <tr>
    <td>info - Propietario</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoPropietario then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td>info - Centro Comercial</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoCentroComercial then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td>info - Hotel</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoHotel then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
  <tr height="10">
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>info - Calle</td>
    <td>&nbsp;</td>
    <td align="center"></td>
    <td>&nbsp;</td>
    <td align="center"><% if session("pw_ws").accesoInfoCalle then %><img src="/img/checkbox/1_16_on.png"><% else %><img src="/img/checkbox/1_16_off.png"><% end if %></td>
    <td align="center"></td>
    <td align="center"></td>
  </tr>
</table>
<% case 1		'Licencia No Existe: Licencia Eliminada 
	'call LicenciaEliminada
case else 	'Licencia Invalida 
	'call LicenciaInvalida
end select %>
	</div>
</div>