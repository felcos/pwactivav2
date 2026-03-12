<script src="/jp/apprise/apprise-1.5.full.js" type="text/javascript"></script>
<link href="/jp/apprise/apprise.css" rel="stylesheet" type="text/css" />
<%
if request.Cookies("licencia")="" then 
	'response.Redirect("/acceso/")
	response.Write("SIN LICENCIA")
	'response.End()
end if
if not session("PW_WS").boolAceptadasCondiciones then
	call AceptarCondiciones 
end if
%>
<% sub Cliente_DatosLicencia(byRef pRS) %>
    <h1><%= pRS("NOMBRE_EMPRESA") %></h1>
    <p>Empresa: <%= pRS("EMPRESA") %> &nbsp; [<%= pRS("PASSWORD") %>]</p>
    <p>Licencias <%= pRS("LICENCIAS_ENVIADAS") %> enviadas / <%= pRS("NUM_LICENCIAS") %> contratadas</p>
    <hr>
<table border="1" cellspacing="2" cellpadding="0" class="jp_tabla">
  <tr>
    <td width="100">Activo</td>
    <td width="50"><input name="" type="checkbox" value="" <% if session("acceso_activo") then %>checked<% end if %>></td>
    <td width="50">web_</td>
    <td width="50">pw_</td>
  </tr>
  <tr>
    <td>es</td>
    <td><input name="" type="checkbox" value="" <% if session("acceso_noticias") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("web_es") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("pw_es") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>pt</td>
    <td><input name="" type="checkbox" value="" <% if session("acceso_noticias") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("web_pt") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("pw_pt") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>bz</td>
    <td><input name="" type="checkbox" value="" <% if session("acceso_noticias") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("web_bz") then %>checked<% end if %>></td>
    <td><input name="" type="checkbox" value="" <% if pRS("pw_bz") then %>checked<% end if %>></td>
  </tr>
</table>
<hr>
<table border="1" cellspacing="2" cellpadding="0" class="jp_tabla">
  <tr>
    <td width="100">seccion</td>
    <td width="50" align="center">acceso</td>
    <td width="50" align="center">_hoy</td>
    <td width="50" align="center">internac</td>
  </tr>
  <tr>
    <td>noticias</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_noticias") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_noticias_hoy") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_internacional") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>web ha o&iacute;do</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_rumores") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_rumores_hoy") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_internacional") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>estudios</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_estudios") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_estudios_hoy") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_internacional") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>operaciones</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_operaciones") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_operaciones_hoy") then %>checked<% end if %>></td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_internacional") then %>checked<% end if %>></td>
  </tr>
  <tr>
    <td>subastas</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_subastas") then %>checked<% end if %>></td>
    <td align="center">-</td>
    <td align="center">-</td>
  </tr>
  <tr>
    <td>demandas</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_demandas") then %>checked<% end if %>></td>
    <td align="center">-</td>
    <td align="center">-</td>
  </tr>
  <tr>
    <td>vencimientos</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_vencimientos") then %>checked<% end if %>></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td>Directorio</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_directorio") then %>checked<% end if %>></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td>Info-Empresas</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_infoempresas") then %>checked<% end if %>></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
  <tr>
    <td>Info-Inmuebles</td>
    <td align="center"><input name="" type="checkbox" value="" <% if session("acceso_infoinmuebles") then %>checked<% end if %>></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
  </tr>
</table>
<% end sub %>

<% sub Cliente_Invalido %>
    <br />
    <h1>Su licencia no es valida....</h1>
    <br />
    <p>Para m&aacute;s informaci&oacute;n p&oacute;ngase en contacto con Property Web.</p>
    <br /><br />
    <em><b>© Property Web, S.L.</b></em>
    <br><br>
<% end sub %>

<% sub Cliente_Inactivo %>
    <br />
    <h1>Suscripcion cancelada... </h1>
    <p>Lo sentimos, Su suscripción ha sido dada de baja....</p>
    <br />
    <p>Por favor, p&oacute;ngase en contacto con Property Web.</p>
    <br /><br />
    <em><b>© Property Web, S.L.</b></em>
    <br><br>
<% end sub %>

<% sub AceptarCondiciones %>    
	<p>Para poder acceder a los resultados tiene que aceptar las condiciones.</p>
	<textarea cols="30" rows="4" wrap="VIRTUAL" style="width:100%">[[ condiciones ]]</textarea>
	<input name="aceptar_condiciones" type="button" value="Aceptar condiciones" onClick="javascript:comprobar_condiciones();">
    <div id="resp_condiciones">
    <p>request.cookies(&quot;licencia&quot;)&nbsp;:&nbsp;<b><% if request.Cookies("licencia")="" then %>NO <% end if %></b>existe</p>
<li>.Comprobar_Empresa: <%= session("PW_WS").Comprobar_Empresa(request.Cookies("licencia")("u"),request.Cookies("licencia")("p")) %></li>
<li>.Comprobar_Licencia: <%= session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id")) %></li>
<hr />
</div>
<% end sub %>

<script language="javascript">
function comprobar_condiciones(){	
	var variable_post="Mi texto recargado";
	$.post("/acceso/informa_aceptadas_condiciones.asp", { variable: variable_post }, function(data){
		//$("#resp_condiciones").html(data);
		$("#resp_condiciones").append(data);
	});			
}
</script>
