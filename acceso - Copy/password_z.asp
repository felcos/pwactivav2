<script type="text/javascript" src="/js/jquery.form.js"></script>
<% 
boolAceptadasCondiciones = false


if not boolAceptadasCondiciones then 
	select case Request.Form("frmAdminLogin")
	case "condiciones"			'si viene de aceptar condiciones 
		%><script language="javascript">$("#div_frmAdminLogin").fadeOut(0);</script><%
		boolAceptadasCondiciones = true
		if request.Cookies("dev")("reg")="" then
			sql = "UPDATE clientes_licencias SET last_login = GETDATE() WHERE id=" & session("pw_ws").LicenciaId
'''''		session("connPW").execute sql
			
			sql = "UPDATE reg_accesos SET session_login=GETDATE() WHERE session_id='" & session.SessionID & "'"
'''''		session("connPWAcesos").execute sql
			
			Set rsReg = Server.CreateObject("ADODB.Recordset")
			sql = "SELECT TOP 1 id FROM reg_pags WHERE session_id='" & session.SessionID & "' ORDER BY id DESC"
'''''		rsReg.Open sql, session("connPWAcesos")
			
			sql = "UPDATE reg_pags SET session_usuario='" & left(session("pw_ws").licencia, 50) & "', session_nombre='" & left(session("pw_ws").cliente, 100) & "' "
'''''		sql = sql & "WHERE id=" & rsReg("id")
'''''		session("connPWAcesos").execute sql
'''''		rsReg.close
		end if
		
	case "registro"				'si ya ha introducido sus datos 
		if request.form("usuario") = "" then call IncorrectoFormulario
		if request.form("cliente") = "" then call IncorrectoFormulario
		if request.form("password") = "" then call IncorrectoFormulario
		
		resp = session("pw_ws").Comprobar_Empresa(request.form("cliente"), request.form("password"), intContratadas, intEntregadas, strIp)
		if resp<>0 then call IncorrectoCliente
		'si no se pueden entregar mas 
		if intEntregadas >= intContratadas then 
			call IncorrectoSinLicencias()
		else 
			call EnviarLicencia ()
		end if
		
	case "adelante"				'si viene de su empresa tiene contratadas... 
		'Crear Licencia
		cliente=request.form("cliente")
		password=request.form("password")
		usuario=request.form("usuario")
		cargo=request.form("cargo")
		
		resp=session("pw_ws").CrearLicencia(cstr(cliente), cstr(usuario), cstr(password), cstr(cargo), cstr(request.servervariables("REMOTE_ADDR")))
		
		if resp=0 then
			sql = "UPDATE reg_accesos SET "
			sql = sql & "session_login=GETDATE(), "
			sql = sql & "cookie_uid=" & session("pw_ws").ClienteId & ", "
			sql = sql & "cookie_u='" & left(session("pw_ws").login, 50) & "', "
			sql = sql & "cookie_lid=" & session("pw_ws").ClienteUsuarioId & ", "
			sql = sql & "cookie_l='" & left(session("pw_ws").nombre, 100) & "' "
			sql = sql & "WHERE session_id='" & session.SessionID & "'"
'''''		session("connPWAcesos").execute sql
			
			'pendiente de pasar al objeto PW_WS
			sql = "UPDATE clientes_licencias SET "
			sql = sql & "http_mozilla='" & session("http_mozilla") & "', "
			sql = sql & "http_navegador='" & session("http_navegador") & "', "
			sql = sql & "http_so='" & session("http_so") & "', "
			sql = sql & "last_session=GETDATE() "
			sql = sql & "WHERE id=" & session("pw_ws").ClienteUsuarioId
'''''		session("connPW").execute sql
			
			'traido de Sub CrearCookie
			response.cookies("licencia").domain = "propertyweb.eu"
			response.cookies("licencia").expires = date + 365 
			response.cookies("licencia")("n") = session("pw_ws").nombre
			response.cookies("licencia")("u") = session("pw_ws").login
			response.cookies("licencia")("p") = session("pw_ws").password
			response.cookies("licencia")("client_id") = session("pw_ws").ClienteId
			response.cookies("licencia")("user_id") = session("pw_ws").ClienteUsuarioId
			
		else
			response.Write("Error al crear la licencia...")
		end if
		
		call ComprobarLicencia
				
	case "delcookie"			'eliminar cookie licencia
		call BorrarCookie
		
	end select
	
end if

if request.form("frmAdminLogin")="" then
	if not boolAceptadasCondiciones then 
		'Comprobar si tiene algo en cookies 
		if Request.Cookies("licencia")("p")="" then 
			call FormularioRegistro
		else
			resp = session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
			select case resp
			case 0		'Licencia OK: Aceptar Condiciones
				resp_ini = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
				call AceptarCondiciones	
			case 1, 2		
				call LicenciaInvalida
			end select	
		end if
	end if
end if
%>

<% sub FormularioRegistro %>
<div id="div_registro" name="div_registro" class="cliente">
	<h1 class="tit_mod">Si eres cliente</h1>
    <div name="div_instrucciones_registro" id="div_instrucciones_registro">
        <p>Inserta tus datos personales y de acceso:</p>
    </div>
<form action="/acceso/resp.asp" method="POST" target="_self" name="frm_registro" id="frm_registro">
<input type="hidden" name="frmAdminLogin" value="registro">
    <table border="0" cellpadding="4" align="center">
      <tr>
        <td><label>email:</label></td>
        <td colspan="4"><input type="text" name="usuario" maxlength="100" size="52" value="<%= request.Cookies("licencia")("n") %>" class="form-control"></td>
      </tr>
      <tr>
        <td><label>Empresa: </label> </td>
        <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= request.Cookies("licencia")("u") %>" class="form-control"></td>
        <td></td>
        <td align="right"><label>Password: </label></td>
        <td align="right"><input type="password" name="password" maxlength="15" size="15" class="form-control"></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td style="font-size:12px;">(may&uacute;sculas)</td>
        <td></td>
        <td></td>
        <td style="font-size:12px;">(may&uacute;sculas)</td>
      </tr>
    </table>
    <br />
    <p> (*) <strong>PROPERTY WEB</strong> proceder&aacute; al registro de tu terminal en su base de datos</p>
	
	<div class="botones">
		<input type="button" id="cierra" class="btn" value="cerrar">
         &nbsp; 
        <input type="submit" value="enviar" onClick="" name="submit" class="TituloDatos btn">
	</div>
</form>
	<hr />
    <h1  class="tit_mod">Si no eres cliente</h1>
    <div name="div_instrucciones_registro" id="div_instrucciones_registro">
        <p>Puedes ponerte en contacto con PropertyWeb <% if 1=2 then %>rellenando el siguiente formulario,<br />o<% end if %> llamando al <strong>914.295.143.</strong></p>
        <p><a href="/presenta">Conoce nuestros servicios</a>.</p>
    </div>
</div>
<div id="result_registro"></div>
<script type="text/javascript">
$(document).ready(function() { 
	//close ¿¿??
	$('#cierra').click(function(e) {
		parent.$.modal.close();
		return false;
    });
	
	$('#frm_registro').ajaxForm({
		beforeSubmit: testForm, 
		success: mostrarRespuesta
	}); 
	
	function testForm(){
		//$("#loader_gif").fadeIn("slow");
		var ErrSubmit = "";
		var emailReg = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
		
		var email = document.frm_registro.usuario.value;
		
		if (document.frm_registro.password.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir la clave de acceso.</p>"};
		if (document.frm_registro.cliente.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir el nombre de cliente de tu empresa.</p>"};
		
		if(!(emailReg.test(email))) {ErrSubmit="<p class='destaca'>El email introducido no es v&aacute;lido</p>"};
		if (email=="") {ErrSubmit="<p class='destaca'>Tienes que introducir tu email.</p>"};
		
		if (ErrSubmit=="") {
		} else {
			$("#div_instrucciones_registro").html(ErrSubmit);
			$("#div_instrucciones").fadeIn("slow");
			return false;
		};
	};
	function mostrarRespuesta (responseText){ 
		$("#result_registro").html(responseText);
		$("#div_registro").fadeOut(0);
		$("#result_registro").fadeIn();
	};
}); 

function volver() {
	$("#result_registro").fadeOut(0);
	$("#div_registro").fadeIn();
	$('#result_registro').html('');
};
</script>
	<% 'response.end
end sub %>

<% sub AceptarCondiciones() 	
	dim intContratadas
	dim intEntregadas
	resp=session("pw_ws").ComprobarEmpresa(session("pw_ws").cliente, session("pw_ws").password, intContratadas, intEntregadas)
	%>
<div class="bienvenido">
	<h1>Bienvenid@<br>
    <span class="destaca"><%= session("pw_ws").cliente %></span></h1>
    <p>Tu ordenador ha sido identificado por PROPERTY WEB.<br />
    <span class="destaca"><%= session("pw_ws").licencia %></span> tiene contratadas <%= intContratadas %> licencias, de las cuales la tuya es la n&deg; <%= session("pw_ws").licenciaNum %>.</p>
	<p>Para poder acceder a los contenidos tienes que aceptar las condiciones:</p>
<form action="" method="post" target="_self">
	<input type="hidden" name="frmAdminLogin" value="condiciones">
	<textarea cols="30" rows="8" wrap="VIRTUAL" style="width:80%"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
    <br />
	<input type="submit" value="Aceptar Condiciones"  name="submit" class="btn">
</form>
</div>
<% 'response.end
end sub %>

<% sub BorrarCookie() 
	'Eliminamos la Cookie 
	'response.cookies("licencia").domain ="www.propertyweb.eu"
	'response.cookies("licencia").expires = "01/01/2000"
	response.cookies("licencia").domain ="propertyweb.eu"
	response.cookies("licencia").expires = "01/01/2000"
	'response.cookies("licencia")("p") = ""
	
	'session.Abandon()
	'for each elto in response.Cookies
	'	response.Cookies(elto).expires = dateadd("d", -1, now)
	'next
	%>
<form name="delcookie" action="" method="POST" target="_self" ></form>
<script>document.delcookie.submit()</script>
	<% 'response.end
end sub %>

<% sub ComprobarLicencia() 
	'resp = session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
	'nunca se debería dar sólo, si tiene bloqueadas las cookies
	resp = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
	if resp=0 then 
		session("es_cliente")=true
		session("acceso_activo")=true
	
	%>
<div class="bienvenido">
<h1>Licencia correctamente insertada</h1>
<br />
<p>Tu terminal ha sido validado para el acceso a PROPERTYWEB.<BR>
En las proximas consultas no te volveremos a pedir las claves de acceso mientras no cambies de ordenador o elimines los archivos temporales.<br><br>
Agradecemos tu inter&eacute;s y esperamos que los contenidos sean de tu agrado.</p>   
<p>Para poder acceder a los resultados tienes que aceptar las condiciones:</p>
<form action="" method="post" target="_self" >
	<input type="hidden" name="frmAdminLogin" value="condiciones">
	<textarea cols="30" rows="6" wrap="VIRTUAL" style="width:80%"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
    <p>&nbsp;</p>
	<input type="submit" value="Aceptar condiciones"  name="submit" class="btn">
</form>
	<% else %>
<h1>No se ha podido guardar su Licencia</h1>
<p>Error al guardar la cookie.<br><br>
Agradecemos tu inter&eacute;s y esperamos que los contenidos sean de tu agrado.</p>
<form action="" method="POST" target="_self" >
<input type="submit" value="Aceptar" class="btn">
</form>
</div>
<%	end if %>
    
<% 'response.End()
end sub %>


<% sub LicenciaInvalida() 
	response.cookies("licencia").domain ="www.propertyweb.eu"
	response.cookies("licencia").expires = "01/01/2000"
	%>
<div class="bienvenido">
	<h1>Licencia Inv&aacute;lida</h1>
    <p>Tu ordenador ha sido identificado por PROPERTY WEB</p>
    <p><b><%= request.Cookies("licencia")("n") %></b></p>
    <br />
    <p>Pero tu licencia no es v&aacute;lida.<% if resp=1 then %> Tienes que volver a registrarte.<% end if %></p>
    <br />
    <p>En caso de duda ponte en contacto con la persona encargada del servicio de Property Web en tu empresa<br />
    o ll&aacute;manos a Property Web ( 914.295.143 )</p>
    <% if request.Cookies("dev")<>"" then %>
	<hr />
    <li>ComprobarLicencia: <%= session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %></li>
    <li>ComprobarEmpresa: <%= session("pw_ws").ComprobarEmpresa(request.Cookies("licencia")("u"), request.Cookies("licencia")("p")) %></li>
	
    <hr />
	<% end if %>
<form action="" method="post" target="_self" style="margin:20px;">
    <input type="hidden" name="frmAdminLogin" value="delcookie">
    <input type="button" name="Cancelar" value="Cancelar" id="cierra" style="width:140px;" class="btn">
    <% if resp=1 then %>
     &nbsp; &nbsp; 
    <input type="submit" name="Volver" value="Volver a registrarse" class="btn">
    <% end if %>
</form>
</div>
<script type="text/javascript">
$(document).ready(function() { 
	$('#cierra').click(function(e) {
		parent.$.modal.close();
		return false;
    });
}); 
</script>
<% end sub %>

