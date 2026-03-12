<% sub SinAcceso(pSeccion) %>
<div style="border:solid 2px green; padding:10px; font-size:16px; text-align:center;">
    <br />
    <h1>Error de Acceso</h1>
	<p>&nbsp;</p>
    <p>Usted es cliente de PW, pero no tiene acceso a la secci&oacute;n <b><%= pSeccion %></b></p>
	<p>&nbsp;</p>
	
    <p>P&oacute;ngase en contacto con Property Web para obtener m&aacute;s informaci&oacute;n.</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</div>	
<% end sub %>

<% sub AccesoSoloHoy(pSeccion) %>
<div style="border:solid 2px green; padding:10px; font-size:16px; text-align:center;">
    <br />
    <h1>Error de Acceso</h1>
	<p>&nbsp;</p>
    <p>Usted es cliente de PW, pero solo tiene contratado el acceso a <b><%= pSeccion %></b> de <b>Hoy</b> (<%=formatdatetime(now,2)%>).</p>
  <p>&nbsp;</p>
	
    <p>Si quiere m&aacute;s informaci&oacute;n sobre el acceso a las <b>Bases de Datos</b>,<br />
    p&oacute;ngase en contacto con Property Web...</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</div>	
<% end sub %>

<% sub AccesoSoloNacional(pSeccion) %>
<div style="border:solid 2px green; padding:10px; font-size:16px; text-align:center;">
    <br />
    <h1>Error de Acceso</h1>
	<p>&nbsp;</p>
    <p>Usted es cliente de PW, pero solo tiene contratado el acceso <b>Nacional</b>.</p>
	<p>&nbsp;</p>
	
    <p>Si quiere m&aacute;s informaci&oacute;n sobre el acceso a la secci&oacute;n <b>Internacional</b>,<br />p&oacute;ngase en contacto con Property Web...</p>
    <p>&nbsp;</p>
    <p>&nbsp;</p>
</div>	
<% end sub %>


<% sub Operaciones_SinAcceso %>
<div align="center">
	<p>No tiene acceso a la secci�n Operaciones</p>
	<br />
	<p><em><b>� Property Web, S.L.</b></em></p>
</div>
<% end sub %>
<% sub Operaciones_AccesoSoloHoy %>
<div align="center">
	<p><%=pRS("TITULO")%></p>
	<p>S&oacute;lo tiene contratado el acceso a las Operaciones de Hoy (<%=formatdatetime(now,2)%>)</p>
<br>
<table>
  <tr> 
	<td width="50%"><strong>Fecha operaci&oacute;n: </strong><%=pRS("FECHA_OPERACION")%></td>
	<td width="50%"><strong>Fecha actualizaci�n: </strong><%=pRS("FECHA_ACTUALIZACION")%></td>
  </tr>
</table>
<br />
<p><em><b>� Property Web, S.L.</b></em></p>
</div>
<% end sub %>
<% sub Operaciones_AccesoSoloNacional %>
<div align="center">
	<p><%=pRS("TITULO")%></p>
	<p>S&oacute;lo tiene contratado el acceso a las Operaciones Nacionales.</p>
    <br />
    <p><em><b>� Property Web, S.L.</b></em></p>
</div>
<% end sub %>

<% sub NoticiasTablaSoloHoy(byRef pRS)	
'titulo=tria & " " & pRS("TIPOSECCION")%>
<table align="center" width="440" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td class="tit_tabla"><img src="https://www.propertyweb.eu/images/bloques2/es/noticias.gif" alt="Noticias Inmobiliarias">    </td>
  </tr>
  <tr> 
    <td> 
      <table width="440" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
        <tr> 
          
          <td> 
            <table width="100%">
              <tr> 
                <td  colspan="2" class="titulo" valign="middle"><%=pRS("TITULO")%></td>
              </tr>
              <tr> 
                <td  colspan="2" class="txtTabla2" valign="middle"><br>
                  No tiene contratado el acceso a la Base de Datos de Noticias (<%=formatdatetime(now,2)%>)<br>
                  <br>
                </td>
              </tr>
              <tr> 
                <td class="txtTabla2"><strong>Fecha noticia: </strong><%=pRS("FECHA_NOTICIA")%></td>
                <td class="txtTabla2"><strong>Fecha actualizaci�n: </strong><%=pRS("FECHA_ACTUALIZACION")%></td>
              </tr>
            </table>
          </td>
          <td background="../../abierto/images/tb_busq_04.gif" width="6" align="right"><img src="../../abierto/images/tb_busq_04.gif" width="6" height="1"></td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<% end sub %>
<% sub NoticiasTablaSoloNacional(byRef pRS)	%>
<table align="center" width="440" border="0" cellpadding="0" cellspacing="0">
	<tr><td class="tit_tabla"><img src="https://www.propertyweb.eu/images/bloques2/es/noticias.gif" alt="Noticias Inmobiliarias"></td></tr>
	<tr><td>
<table width="440" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
	<tr>
    	<td>
<table width="100%">
	<tr><td  colspan="2" class="titulo" valign="middle"><%=pRS("TITULO")%></td></tr>
	<tr><td  colspan="2" class="txtTabla2" valign="middle"><br>
S&oacute;lo tiene contratado el acceso a Noticias Nacionales.<br><br>
Para acceder al art&iacute;culo solicitado, debe contratar la secci&oacute;n Internacional.<br><br><br>
		</td></tr>
</table>
		</td>
		<td background="../../abierto/images/tb_busq_04.gif" width="6" align="right"><img src="../../abierto/images/tb_busq_04.gif" width="6" height="1"></td>
	</tr>
</table>
	</td></tr>
</table>
<% end sub %>

<% sub ArticuloInexistente %>
    <blockquote>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
        <p>El Art&iacute;culo solicitado no existe.</p>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
    </blockquote>
<% end sub %>

<% sub NoCliente() %>
<div style="border:solid 2px green; padding:10px; font-size:16px;">
    <br />
    <h1>Error de Acceso</h1>
	<p>&nbsp;</p>
    <br />
    <br />
    Usted no es cliente de PW.
    <br />
    <br />
    <br />
    P&oacute;ngase en contacto con Property Web para obtener m&aacute;s informaci&oacute;n.
    <br />
    <p>Soy cliente. <a href="/acceso/">Registrarme</a></p>
    <br />
</div>	
<% end sub %>

<% sub NoClienteArticulo() %>

<div id="div_registro" name="div_registro" style="border: 1px solid blue; margin-top:20px;">

    <div id="div_frm_registro" name="div_frm_registro">
    <form name="frm_registro" id="frm_registro" method="post" action="/acceso/resp.asp" target="_blank" autocomplete="off" style="border: solid 1px orange; margin:2px;">
    <div name="div_instrucciones_registro" id="div_instrucciones_registro" style="padding:10px;">
        Inserte sus datos personales y de acceso:
    </div>
      <input type="hidden" name="frmAdminLogin" value="registro">
        <label>Nombre:</label> <input type="text" name="usuario" maxlength="15" size="15" required value=""><br />
        <label>Empresa:</label> <input type="text" name="cliente" maxlength="15" size="15" required value=""><br />
        <label>Cargo: </label><input type="text" name="cargo" size="15" maxlength="15"><br />
        <label>Password: </label><input type="password" name="password" maxlength="15" size="15" required value=""><br />
        <hr>
    <p> (*) PROPERTY WEB PROCEDERA AL REGISTRO DE SU TERMINAL EN NUESTRA BASE DE DATOS</p>
    <div align="center">
    <input type="submit" value="Enviar" name="enviar" id="enviar">
    </div>
    </form>
    </div>

	<div id="result_registro" style="border: solid 1px red; margin:2px;"></div>


    <br />
    <br />
    <p>P&oacute;ngase en contacto con Property Web para obtener m&aacute;s informaci&oacute;n.</p>
    <br />
</div>
<!-- jQuery form -->
<script type="text/javascript">
$(document).ready(function() { 
	// esperamos que el DOM cargue
	// definimos las opciones del plugin AJAX FORM
	var opciones= {
		beforeSubmit: mostrarLoader, //funcion que se ejecuta antes de enviar el form
		success: mostrarRespuesta, //funcion que se ejecuta una vez enviado el formulario
	};
	
	//asignamos el plugin ajaxForm al formulario frm_login y le pasamos las opciones
	$('#frm_registro').ajaxForm(opciones) ; 
	
	//lugar donde defino las funciones que utilizo dentro de "opciones"
	function mostrarLoader(){
		//$("#loader_gif").fadeIn("slow");
		var ErrSubmit="";
		
		if (document.frm_registro.password.value=="") {ErrSubmit="Tiene que introducir la clave de acceso.";}
		if (document.frm_registro.cliente.value=="") {ErrSubmit="Tiene que introducir el nombre de cliente de su empresa.";}
		if (document.frm_registro.usuario.value=="") {ErrSubmit="Tiene que introducir su nombre.";}
		
		if (ErrSubmit=="") {
			//$("#div_instrucciones").css({ display: 'none', });
		} else {
			informa_registro(ErrSubmit);
			//$("#div_instrucciones").fadeIn("slow");
			return false;
			//elto.focus();
		}
	};
	function mostrarRespuesta (responseText){ 
		//$("#loader_gif").fadeOut("slow");
		
		$("#result_registro").fadeIn("fast");
		$("#result_registro").html(responseText);
	};
}); 

function informa_registro(texto) {
	$("#div_instrucciones_registro").html(texto);
	//if (texto=="") {$("#div_instrucciones").fadeOut("slow");}
}
</script>

<!-- otras funciones -->
<script language="javascript">
function comprobar_licencia(){	
	var variable_post="comprobar licencia";
	$.post("/acceso/informa_licencia.asp", { variable: variable_post }, function(data){
		$("#informa_licencia").html(data);
	});			
};

function comprobar_condiciones(){
	var variable_post="comprobar condiciones";
	$.post("/acceso/informa_condiciones.asp", { variable: variable_post }, function(data){
		$("#informa_condiciones").html(data);
	});
}

</script>
<% end sub %>
