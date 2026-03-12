<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% if request.Form("frmAdminLogin")<>"" then

'for each elto in request.Form
'	response.Write("<li>" & elto & ": " & request.Form(elto) & "</li>")
'next

	select case request.Form("frmAdminLogin")
	case "condiciones"	
		if request.Cookies("licencia")="" then 
			sw_pasa = false
		else
			sw_pasa = true
			
			if session("pw_ws").ComprobarEmpresa(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))<>0 then sw_pasa = false
			'if session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("user_id"))<>0 then sw_pasa = false
			if session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))<>0 then sw_pasa = false
			
			if sw_pasa then
				'reg_accesos
				sql = "UPDATE reg_accesos SET session_login=GETDATE() WHERE session_id='" & session.SessionID & "'"
				session("connPWAcesos").execute sql
				
				'clientes_licencias
				sql = "UPDATE clientes_licencias SET last_login=GETDATE() WHERE id=" & session("pw_ws").LicenciaId
				session("connPW").execute sql
				
				'session("pw_ws").boolAceptadasCondiciones = true
				response.Cookies("condiciones")="true"
				
			else
				response.Cookies("condiciones")=""
				
			end if
			
		end if
		
		'response.Write(session("pw_ws").boolAceptadasCondiciones)
		response.Write(request.Cookies("condiciones"))
		
	case "setcookie"	
		'si viene de su empresa tiene contratadas... 
		
		cliente=request.form("cliente")
		password=request.form("password")
		usuario=request.form("usuario")
		movil=request.form("movil")
		cargo = ""
		
	  IF 1=2 THEN
		set rsCliente=Server.CreateObject("ADODB.recordset")
		
		sql = "SELECT * FROM clientes WHERE EMPRESA='" & cliente & "'"
		rsCliente.Open sql, session("connPW")
		
		response.Write(rsCliente("licencias_enviadas")+1)
		response.Write("<hr>")
		'insertar licencia
		sql = "INSERT INTO clientes_licencias (ID_EMPRESA, NOMBRE, USUARIO, PASSWORD, NUMERO_LICENCIA, acceso_movil, "
        sql = sql & "propertyweb_eu, fecha_alta, fecha, hora, IP, http_mozilla, http_navegador, http_so, http_ip, "
		sql = sql & "os_name, os_version, browser_name, browser_version, engine_name, engine_version, "
        sql = sql & "device_type, device_model, device_vendor, last_session"
        sql = sql & ") VALUES ("
		
        sql = sql & rsCliente("id") & ", "
        sql = sql & "'" & usuario & "', "
        sql = sql & "'" & cliente & "', "
        sql = sql & "'" & password & "', "
		
        if movil = "" then
            sql = sql & rsCliente("licencias_enviadas") + 1 & ", "
            sql = sql & "NULL, "
        else
			sql = sql & "0, "
			sql = sql & "'" & movil & "', "
		end if
		
		sql = sql & "1, "
		sql = sql & "GETDATE(), "
		sql = sql & "'" & date & "', "
		hh = cstr(time)
		sql = sql & "'" & left(hh, len(hh)-3) & "', "
		
        sql = sql & "'" & request.ServerVariables("REMOTE_HOST") & "', "
		
		sql = sql & "'" & session("http_mozilla") & "', "
		sql = sql & "'" & session("http_navegador") & "', "
		sql = sql & "'" & session("http_so") & "', "
        sql = sql & "'" & request.ServerVariables("REMOTE_HOST") & "', "
        
        sql = sql & "'" & request.Form("os_name") & "', "
        sql = sql & "'" & request.Form("os_version") & "', "
        sql = sql & "'" & request.Form("browser_name") & "', "
        sql = sql & "'" & request.Form("browser_version") & "', "
        sql = sql & "'" & request.Form("engine_name") & "', "
        sql = sql & "'" & request.Form("engine_version") & "', "
        sql = sql & "'" & request.Form("device_type") & "', "
        sql = sql & "'" & request.Form("device_model") & "', "
        sql = sql & "'" & request.Form("device_vendor") & "', "
        sql = sql & "GETDATE()"
		
        sql = sql & ")"
        
		response.Write(sql)
		session("connPW").execute sql
			
		rsCliente.close
		set rsCliente = nothing
		
		
		
		RESPONSE.End()
		
		resp=session("pw_ws").CrearLicencia(cstr(cliente), cstr(usuario), cstr(password), cstr(movil), cstr(request.servervariables("REMOTE_ADDR")), _
			cstr(request.Form("os_name")), cstr(request.Form("os_version")), _
			cstr(request.Form("browser_name")), cstr(request.Form("browser_version")), _
			cstr(request.Form("engine_name")), cstr(request.Form("engine_version")), _
			cstr(request.Form("device_type")), cstr(request.Form("device_model")), cstr(request.Form("device_vendor")) )
	  
	  END IF
		
		
		resp=session("pw_ws").CrearLicencia(cstr(cliente), cstr(usuario), cstr(password), cstr(cargo), cstr(request.servervariables("REMOTE_ADDR")))
		
		if resp=0 then
			sql = "UPDATE reg_accesos SET "
			sql = sql & "cookie_uid=" & session("pw_ws").ClienteId & ", "
			sql = sql & "cookie_u='" & left(session("pw_ws").Cliente, 50) & "', "
			sql = sql & "cookie_lid=" & session("pw_ws").LicenciaId & ", "
			sql = sql & "cookie_l='" & left(session("pw_ws").Licencia, 100) & "' "
			sql = sql & "WHERE session_id='" & session.SessionID & "'"
			session("connPWAcesos").execute sql
			
			'pendiente de pasar al objeto PW_WS
			sql = "UPDATE clientes_licencias SET "
			sql = sql & "http_mozilla='" & session("pw_ws").mozilla & "', "
			sql = sql & "http_navegador='" & session("pw_ws").navegador & "', "
			sql = sql & "http_so='" & session("pw_ws").so & "', "
			sql = sql & "last_session=GETDATE() "
			sql = sql & "WHERE id=" & session("pw_ws").LicenciaId
			session("connPW").execute sql
			
			'traido de Sub CrearCookie
			response.cookies("licencia").domain = "propertyweb.eu"
			response.cookies("licencia").expires = date + 365 
			response.cookies("licencia")("n") = session("pw_ws").Licencia
			response.cookies("licencia")("u") = session("pw_ws").Cliente
			response.cookies("licencia")("p") = session("pw_ws").password
			response.cookies("licencia")("client_id") = session("pw_ws").ClienteId
			response.cookies("licencia")("user_id") = session("pw_ws").LicenciaId
			
		else
			response.Write("Error al crear la licencia...")
		end if
		
		call ComprobarLicencia
		
	case "setcookie_movil"	
		'si viene de su empresa tiene contratadas... 
		cliente=request.form("cliente")
		password=request.form("password")
		usuario=request.form("usuario")
		cargo=request.form("cargo")
		
		response.End()
		
		'resp=session("pw_ws").CrearLicencia(cstr(cliente), cstr(usuario), cstr(password), cstr(cargo), cstr(request.servervariables("REMOTE_ADDR")))
		
		if resp=0 then
			sql = "UPDATE reg_accesos SET "
			sql = sql & "cookie_uid=" & session("pw_ws").ClienteId & ", "
			sql = sql & "cookie_u='" & left(session("pw_ws").Cliente, 50) & "', "
			sql = sql & "cookie_lid=" & session("pw_ws").LicenciaId & ", "
			sql = sql & "cookie_l='" & left(session("pw_ws").Licencia, 100) & "' "
			sql = sql & "WHERE session_id='" & session.SessionID & "'"
			session("connPWAcesos").execute sql
			
			'pendiente de pasar al objeto PW_WS
			sql = "UPDATE clientes_licencias SET "
			sql = sql & "http_mozilla='" & session("pw_ws").mozilla & "', "
			sql = sql & "http_navegador='" & session("pw_ws").navegador & "', "
			sql = sql & "http_so='" & session("pw_ws").so & "', "
			sql = sql & "last_session=GETDATE() "
			sql = sql & "WHERE id=" & session("pw_ws").LicenciaId
			session("connPW").execute sql
			
			'traido de Sub CrearCookie
			response.cookies("licencia").domain = "propertyweb.eu"
			response.cookies("licencia").expires = date + 365 
			response.cookies("licencia")("n") = session("pw_ws").Licencia
			response.cookies("licencia")("u") = session("pw_ws").Cliente
			response.cookies("licencia")("p") = session("pw_ws").password
			response.cookies("licencia")("client_id") = session("pw_ws").ClienteId
			response.cookies("licencia")("user_id") = session("pw_ws").LicenciaId
			
		else
			response.Write("Error al crear la licencia...")
		end if
		
		call ComprobarLicencia
		
	
	case "registro"				
		usuario = lcase(trim(request.form("usuario")))
		cliente = ucase(trim(request.form("cliente")))
		password = request.form("password")
		
		fecha = FormatDateTime(now, 2)
		hora = FormatDateTime(now, 4)
		
		http_rem_addr = request.servervariables("REMOTE_ADDR") 
		http_rem_host = request.servervariables("REMOTE_HOST")
		http_ua = request.servervariables("HTTP_USER_AGENT")
		
		resp = session("pw_ws").ComprobarEmpresa(request.form("cliente"), request.form("password"), intContratadas, intEntregadas, strIp)
		'resp = session("pw_ws").ComprobarEmpresa(cliente, password, intContratadas, intEntregadas, strIp)
		
		if resp=0 then 
			'si no se pueden entregar mas 
			if intEntregadas >= intContratadas then 
				call IncorrectoSinLicencias
			else 
				call EnviarLicencia
			end if
		else
			call IncorrectoCliente
		end if
		
	
	case "registro_movil"	
		movil = trim(request.form("movil"))
		cliente = ucase(trim(request.form("cliente")))
		password = request.form("password")
		
		fecha = FormatDateTime(now, 2)
		hora = FormatDateTime(now, 4)
		
		http_rem_addr = request.servervariables("REMOTE_ADDR") 
		http_rem_host = request.servervariables("REMOTE_HOST")
		http_ua = request.servervariables("HTTP_USER_AGENT")
		
		resp = session("pw_ws").ComprobarEmpresa(cstr(cliente), cstr(password))
		
		if resp=0 then 
			'comprobar móvil
			set rsTmp = Server.CreateObject("ADODB.Recordset")
			sql = "SELECT * FROM contactos_email WHERE "
			'sql = sql & "email='" & request.Form("email") & "' AND "
			sql = sql & "acceso_movil='" & movil & "'"
			
			rsTmp.open sql, session("connPW")
			
			if rsTmp.eof then
				'acceso no activado
				call IncorrectoMovil
			else
				usuario = rsTmp("email")
				call EnviarLicenciaMovil
			end if
			
			rsTmp.close
			set rsTmp=nothing
			
		else
			call IncorrectoCliente
			
		end if
		
	
	case "delcookie"			
		'Eliminamos la Cookie 
		'response.cookies("licencia").domain ="www.propertyweb.eu"
		response.cookies("licencia").domain ="propertyweb.eu"
		response.cookies("licencia").expires = "01/01/2000"
		'response.cookies("licencia")("p") = ""
		
		'session.Abandon()
		'for each elto in response.Cookies
		'	response.Cookies(elto).expires = dateadd("d", -1, now)
		'next
		
		call FormularioRegistro
		
	case "frm_movil"			
		call FormularioMovil
		
	end select
	
	response.End()
end if %>
<div class="modal-dialog modal-lg">
    <div class="modal-content">
        <div class="modal-header">
        	<!--
        	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
            <a href="#" data-dismiss="modal">x</a>
            -->
            <%
			'if request("frmInfo_tipo")="" then
				url = "/articulos/"
			'else
			'	url = "/info/inmuebles/"
			'end if
			%>
            <p>Est&aacute;s accediendo a informaci&oacute;n restringida en Property Web</p>
            <form action="<%= url %>" method="post" id="request_formulario" >
			<% 
			sw_algo_para_leer = true
			if request.Form<>"" then
                for each elto in request.Form
                    if request.Cookies("dev")("request")<>"" then response.Write(elto & ":")
					%><input type="<% if request.Cookies("dev")("request")<>"" then %>text<% else %>hidden<% end if %>" name="<%= elto %>" value="<%= request.Form(elto) %>"/><%
                next
            elseif request.QueryString<>"" then
                for each elto in request.QueryString
					if request.Cookies("dev")("request")<>"" then response.Write(elto & ":")
                    %><input type="<% if request.Cookies("dev")("request")<>"" then %>text<% else %>hidden<% end if %>" name="<%= elto %>" value="<%= request.QueryString(elto) %>"/><%
                next
			else
				sw_algo_para_leer = false
				if request.Cookies("dev")("request")<>"" then
					%>NADA RECIBIDO<%
				end if 
            end if %>
            </form>
        </div>
		<div class="modal-body">
        	<div id="access-form" class="cliente"><!-- class="bienvenido" ¿¿?? -->
<% 
if Request.Cookies("licencia")("p")="" then 
	call FormularioRegistro
else
	if session("pw_ws").LicenciaId = 0 then
		call LicenciaInvalida
	else
		call AceptarCondiciones	
	end if 
end if
%> 
			</div>
            
            <div id="access-response" style="display:none;" class="cliente"></div>
    		<div id="access-confirm" style="display:none;" class="cliente"></div>
            
		</div>
    </div>
</div>
<script type="text/javascript">
function AceptarCondiciones() {
	$.post("/acceso/password.asp", 
		"frmAdminLogin=condiciones",
		function( data ) {
			console.log(data)
			if (data.toLowerCase()=="true") {
				<% if sw_algo_para_leer then %>
					//console.log($('#request_formulario').serialize())
					$("#request_formulario").submit();
				<% else %>
					location.reload();
				<% end if %>
				
			} else { 
			}
		}
		
	);
	return false;
}

</script>

<% sub FormularioRegistro %>
	<h1 class="tit_mod">Si eres cliente</h1>
    <div id="form-msg">
        <p class="destaca">Inserta tus datos personales y de acceso:</p>
    </div>
    <form action="/acceso/password.asp" method="POST" target="_blank" name="frm_registro" id="frm_registro" autocomplete="off">
    <input type="hidden" name="frmAdminLogin" value="registro">
        <table border="0" cellpadding="4" align="center">
          <tr>
            <td><label>email:</label></td>
            <td colspan="4"><input type="email" name="usuario" maxlength="100" size="52" value="<%= request.Cookies("licencia")("n") %>" class="form-control" required="required"></td>
          </tr>
          <tr>
            <td><label>Empresa: </label> </td>
            <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= request.Cookies("licencia")("u") %>" class="form-control" required="required"></td>
            <td></td>
            <td align="right"><label>Password: </label></td>
            <td align="right"><input type="password" name="password" maxlength="15" size="15" class="form-control" required="required"></td>
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
        <p>
        	<span style="float:right;">
            <input type="button" class="btn" value="cerrar" data-dismiss="modal">
             &nbsp; 
            <input type="submit" value="enviar" name="submit" class="TituloDatos btn">
        	</span>
         	(*) <strong>PROPERTY WEB</strong> proceder&aacute; al registro de tu terminal en su base de datos</p>
      	
    </form>
    <% if request.Cookies("dev")<>"" or request.Cookies("design")<>"" then %>
    <hr />
    <h2 class="tit_mod">Acceso M&oacute;vil</h2>
    <form action="/acceso/password.asp" method="POST" target="_blank" id="frm_movil">
	    <input type="hidden" name="frmAdminLogin" value="frm_movil"><input type="hidden" name="nombre" id="">
        <p><input type="submit" value="Acceso M&oacute;vil" class="TituloDatos btn" style="float:right;">Si tienes activado el acceso m&oacute;vil y quieres registrar este dispositivo, haz click aqu&iacute;: </p>
        <!--
        <p><strong>Nota</strong>:<br />
        Si no tienes activado el Acceso M&oacute;vil tambi&eacute;n puedes registrarte normalmente y acceder a los contenidos desde tu dispositivo m&oacute;vil.</p>
        -->
    </form>
    <% end if %>
    <hr />
    <h1 class="tit_mod">Si no eres cliente</h1>
    <p><a href="/presenta" class="btn" style="float:right;">Conoce nuestros servicios</a>Puedes ponerte en contacto con PropertyWeb <% if 1=2 then %>rellenando el siguiente formulario,<br />o<% end if %> llamando al <strong>914.295.143.</strong></p>
    <br />
    
    <br />
<script type="text/javascript">
$(document).ready(function() { 
	
	$("#frm_registro").ajaxForm({
		beforeSend: testForm, 
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
			$("#form-msg").html(ErrSubmit);
			return false;
		};
	};
	function mostrarRespuesta (responseText){
		$("#access-response").html(responseText);
		$("#access-form").slideUp();
		$("#access-response").slideDown();
		
		//$("#access-form").slideUp("fast", 
		//	function() {
		//		$("#access-response").slideDown("fast");
		//	}
		//);
		
	};
	
	$("#frm_movil").ajaxForm({
		beforeSend: function() {}, 
		success: function(responseText) {
			$("#access-form").html(responseText)
		}
	}); 
	
}); 

function volver() {
	//console.log("volver");
	$("#access-response").slideUp();
	$("#access-confirm").slideUp();
	$("#access-form").slideDown(function() {
		$('#access-response').html("");
		$('#access-confirm').html("");
	});
	
}
</script>
<% end sub %>

<% sub FormularioMovil %>
	<h1 class="tit_mod">Acceso M&oacute;vil</h1>
    <div id="form-msg">
        <p class="destaca">Inserta tus datos  de acceso:</p>
    </div>
	<form action="/acceso/password.asp" method="POST" target="_blank" name="frm_registro_movil" id="frm_registro_movil" autocomplete="off">
    <input type="hidden" name="frmAdminLogin" value="registro_movil">
      <table border="0" cellpadding="4" align="center">
          <tr>
            <td><label>m&oacute;vil:</label></td>
            <td colspan="4"><input type="tlf" name="movil" maxlength="9" size="15" value="111111111" class="form-control" required="required" placeholder="XXX XXX XXX"></td>
          </tr>
          <tr>
            <td><label>Empresa: </label> </td>
            <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= request.Cookies("licencia")("u") %>" class="form-control" required="required"></td>
            <td></td>
            <td align="right"><label>Password: </label></td>
            <td align="right"><input type="password" name="password" maxlength="15" size="15" class="form-control" required="required"></td>
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
        <div class="botones">
            <input type="button" class="btn" value="cerrar" data-dismiss="modal">
             &nbsp; 
            <input type="submit" value="enviar" name="submit" class="TituloDatos btn">
        </div>
	</form>
    <br />
    <hr />
    <p>Si no tienes activado el Acceso M&oacute;vil, puedes ponerte en contacto con nosotros para solicitar la activaci&oacute;n llam&aacute;ndonos al <strong>914.295.143</strong>,
    <br />
    o tambi&eacute;n puedes registrarte normalmente y acceder a los contenidos desde tu dispositivo m&oacute;vil como desde un PC o cualquier otro dispositivo.</p>
    <div class="botones">
        <form action="/acceso/password.asp" method="POST" target="_blank" id="registro_normal">
            <input type="hidden" name="frmAdminLogin" >
            <input type="submit" value="volver al registro normal" class="TituloDatos btn" style="float:right;">
        </form>
    </div>
    <br />
    <p>&nbsp;</p>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#frm_registro_movil").ajaxForm({
		beforeSend: testForm, 
		success: mostrarRespuesta
	}); 
	
	function testForm(){
		var ErrSubmit = "";
		
		var movilReg = new RegExp(/^\d{9}$/);
		var movil = document.frm_registro_movil.movil.value;
		if(!(movilReg.test(movil))) {ErrSubmit="<p class='destaca'>El m&oacute;vil introducido no es v&aacute;lido</p>"};
		if (movil=="") {ErrSubmit="<p class='destaca'>Tienes que introducir tu m&oacute;vil.</p>"};
		
		if (ErrSubmit=="") {
		} else {
			$("#form-msg").html(ErrSubmit);
			return false;
		};
	};
	function mostrarRespuesta (responseText){
		$("#access-response").html(responseText);
		$("#access-form").slideUp();
		$("#access-response").slideDown();
	};
	
	
	$("#registro_normal").ajaxForm({
		beforeSend: function() {}, 
		success: function(responseText) {
			$("#ModalBox").html(responseText)
		}
	});
})
</script>
<% end sub %>

<% sub AceptarCondiciones() 	
	dim intContratadas
	dim intEntregadas
	%>
    <h1>Bienvenid@<br>
    <span class="destaca"><%= session("pw_ws").Licencia %></span></h1>
    <p>Tu ordenador ha sido identificado por PROPERTY WEB.<br />
    <span class="destaca"><%= session("pw_ws").Cliente %></span> tiene contratadas <%= intContratadas %> licencias, de las cuales la tuya es la n&deg; <%= session("pw_ws").LicenciaNum %>.</p>
    <p>Para poder acceder a los contenidos tienes que aceptar las condiciones:</p>
    <textarea rows="8" wrap="VIRTUAL" style="width:100%" id="condiciones"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
    <br>
    <div class="botones">
        <input type="button" value="Aceptar Condiciones" class="btn" onclick="AceptarCondiciones();">
    </div>
    <br>
<% end sub %>

<% sub ComprobarLicencia() 
	'resp=session("pw_ws").ComprobarLicencia(Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"), Request.Cookies("licencia")("n"), Request.Cookies("licencia")("user_id"))
	'nunca se debería dar sólo, si tiene bloqueadas las cookies
	resp = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
	
	if resp=0 then 
		session("es_cliente")=true
		session("acceso_activo")=true
		%>
		<h1>Licencia correctamente insertada</h1>
		<p>Tu terminal ha sido validado para el acceso a PROPERTYWEB.</p>
		<p>En las proximas consultas no te volveremos a pedir las claves de acceso mientras no cambies de ordenador o elimines los archivos temporales.</p>
        <br />
		<p>Agradecemos tu inter&eacute;s y esperamos que los contenidos sean de tu agrado.</p>   
		<p>Para poder acceder a los resultados tienes que aceptar las condiciones:</p>
        <textarea rows="6" wrap="VIRTUAL" style="width:100%"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
        <br />
        <div class="botones">
            <input type="button" value="Aceptar condiciones" class="btn" onclick="AceptarCondiciones();">
        </div>
        
	<% else %>
        <h1>No se ha podido guardar su Licencia</h1>
        <p>Error al guardar la cookie.</p>
        <p>&nbsp;</p>
        <p>Vuelva a intentarlo, por favor.</p>
        <br />
        <div class="botones">
	        <input type="button" value="Volver" class="btn" onclick="volver();">
        </div>
        
	<% end if %>  
	<br />
<% end sub %>

<% sub LicenciaInvalida() 
	response.cookies("licencia").domain ="www.propertyweb.eu"
	response.cookies("licencia").expires = "01/01/2000"
	%>
	<h1>Licencia Inv&aacute;lida</h1>
	<p>Tu ordenador ha sido identificado por PROPERTY WEB</p>
	<p><b><%= request.Cookies("licencia")("n") %></b></p>
	<br />
	<p>Pero tu licencia no es v&aacute;lida.<% if resp=1 then %> Tienes que volver a registrarte.<% end if %></p>
	<br />
	<p>En caso de duda ponte en contacto con la persona encargada del servicio de Property Web en tu empresa<br />
	o ll&aacute;manos a Property Web ( 914.295.143 )</p>
    <br />
	<div class="botones">
	<form action="" method="post" id="delcookie">
        <input type="hidden" name="frmAdminLogin" value="delcookie">
        <a href="#" class="btn btn-primary" data-dismiss="modal">Cancelar</a>
        <% 'if resp=1 then %><input type="button" id="aceptar" value="Aceptar" class="btn btn-primary"><% 'end if %>
	</form>
	</div>
    <br />
<script type="text/javascript">
$(document).ready(function() { 
	$("#aceptar").click(function(e) {
		
	$.post(
		"/acceso/password.asp",
		$("#delcookie").serialize(),
		function(data, status){
			//console.log(data)
			$("#access-form").html(data);
			
		}
	);
		
        
		
		
    });
}); 
</script>
<% end sub %>

<% sub EnviarLicencia %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p><%= cliente %> tiene contratadas <%= intContratadas %> licencias de las cuales <%= intEntregadas %> se han entregado.</p>
    <p>&iquest;Quieres dar de alta la licencia n&ordm; <%= intEntregadas + 1 %> para tu equipo?</p>
    <p>&nbsp;</p>
    <form action="/acceso/password.asp" method="post" target="_self" name="frm_confirm" id="frm_confirm">
        <input type="hidden" name="frmAdminLogin" value="setcookie">
        <hr />
        <input type="hidden" name="device_type" id="device_type" value=""><br />
        <input type="hidden" name="device_model" id="device_model" value=""><input type="hidden" name="device_vendor" id="device_vendor" value="">
        <input type="hidden" name="os_name" id="os_name" value=""><input type="hidden" name="os_version" id="os_version" value="">
        <input type="hidden" name="browser_name" id="browser_name" value=""><input type="hidden" name="browser_version" id="browser_version" value="">
        <input type="hidden" name="engine_name" id="engine_name" value=""><input type="hidden" name="engine_version" id="engine_version" value="">

        <input type="hidden" name="cliente" value="<%= cliente %>">
        <input type="hidden" name="password" value="<%= password %>">
        <input type="hidden" name="usuario" value="<%= usuario %>">
        <div class="botones">
            <input type="button" value="Volver" onclick="volver();" class="btn"/>
            &nbsp;
            <input type="submit" value="Aceptar" class="btn">
        </div>
    </form>
    <p>&nbsp;</p>
<script type="text/javascript" src="/lib/ua-parser/ua-parser.min.js"></script>
<script type="text/javascript">
var result = UAParser()

var tmp = "";

if (result.os.name) {
	document.getElementById("os_name").value = result.os.name;
	tmp = result.os.version;
	if (result.cpu.architecture) {tmp = tmp + ' ' + result.cpu.architecture.replace("amd64", " x64") }
	document.getElementById("os_version").value = tmp;
};

if (result.browser.name) {
	document.getElementById("browser_name").value = result.browser.name;
	document.getElementById("browser_version").value = result.browser.version;
};

if (result.engine.name) {
	document.getElementById("engine_name").value = result.engine.name;
	document.getElementById("engine_version").value = result.engine.version;
};

if (result.device.type) {
	document.getElementById("device_type").value = result.device.type;
	document.getElementById("device_model").value = result.device.model;
	document.getElementById("device_vendor").value = result.device.vendor;
} else {
	document.getElementById("device_type").value = "PC";
};

$(document).ready(function() { 
	$("#frm_confirm").ajaxForm({
		success: function(responseText) {
			
			$("#access-confirm").html(responseText);
			$("#access-response").slideUp();
			$("#access-confirm").slideDown();
		}
	}); 
	
}); 

</script>
<% end sub %>

<% sub IncorrectoCliente 	
	sql = "INSERT INTO FALLOS (usuario, password, nombre, fecha, hora, REMOTE_HOST, REMOTE_ADDR, HTTP_USER_AGENT) VALUES ("
	sql = sql & "'" & Acomodar(request.form("cliente")) & "', "
	sql = sql & "'" & Acomodar(request.form("password")) & "', "
	sql = sql & "'" & Acomodar(request.form("usuario")) & "', "
	sql = sql & "'" & fecha & "', "
	sql = sql & "'" & hora & "', "
	sql = sql & "'" & http_rem_host & "', "
	sql = sql & "'" & http_rem_addr & "', "
	sql = sql & "'" & left(http_ua, 150) & "'"
	sql = sql & ")"
	'session("connPWAcesos").execute sql
	%>
    <h1>Fallo de identificaci&oacute;n</h1>
    <br />
    <p>Nombre de Empresa o clave de acceso incorrectos.</p>
    <br />
    <p>Vuelve a introducir los datos de acceso de tu Empresa.</p>
    <p>Si no eres cliente y quieres m&aacute;s informaci&oacute;n del servicio, pulsa <a href="javascript:alert('suscribe');">aqu&iacute;</a>.</p>
    <p>&nbsp;</p>
    <div class="botones">
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <p>&nbsp;</p>
<% end sub %>

<% sub IncorrectoSinLicencias	
	sql = "INSERT INTO LICENCIA_DENEGADA (usuario, password, nombre, fecha, hora, REMOTE_HOST, REMOTE_ADDR, HTTP_USER_AGENT) VALUES ("
	sql = sql & "'" & Acomodar(usuario) & "', "
	sql = sql & "'" & Acomodar(password) & "', "
	sql = sql & "'" & Acomodar(cliente) & "', "
	sql = sql & "'" & fecha & "', "
	sql = sql & "'" & hora &"', "
	sql = sql & "'" & http_rem_host & "', "
	sql = sql & "'" & http_rem_addr & "', "
	sql = sql & "'" & left(http_ua, 150) & "'"
	sql = sql & ")"
	'session("connPWAcesos").execute sql
	%>
    <h1>AVISO</h1>
    <br />
    <p>El n&uacute;mero de licencias contratadas por&nbsp;<%= request.form("usuario") %> es  <%= intContratadas %>, y ya han sido registradas todas</p>
    <br />
    <p>No podemos darte acceso a los resultados.</p>
    <p>En caso de duda ponte en contacto con la persona encargada de Property Web en tu empresa <br />
    o ll&aacute;manos a Property Web ( 914.295.143 )</p>
    <p>&nbsp;</p>
    <div class="botones">
	    <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <p>&nbsp;</p>
<% end sub %>

<% sub IncorrectoMovil 	
	'sql = "INSERT INTO FALLOS (usuario, password, nombre, fecha, hora, REMOTE_HOST, REMOTE_ADDR, HTTP_USER_AGENT) VALUES ("
	'sql = sql & "'" & Acomodar(request.form("cliente")) & "', "
	'sql = sql & "'" & Acomodar(request.form("password")) & "', "
	'sql = sql & "'" & Acomodar(request.form("usuario")) & "', "
	'sql = sql & "'" & fecha & "', "
	'sql = sql & "'" & hora & "', "
	'sql = sql & "'" & http_rem_host & "', "
	'sql = sql & "'" & http_rem_addr & "', "
	'sql = sql & "'" & left(http_ua, 150) & "'"
	'sql = sql & ")"
	'session("connPWAcesos").execute sql
	%>
    <h1>Servicio no Activado</h1>
    <br />
    <p>El tel&eacute;fono <strong><%= request.Form("movil") %></strong> no tiene activado el <strong>Acceso M&oacute;vil</strong>.</p>
    <br />
    <div class="botones">
    	<a href="#" class="btn btn-primary" data-dismiss="modal">Cancelar</a>
         &nbsp; 
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <br />
    <hr />
    <p>Si no tienes activado el Acceso M&oacute;vil, puedes ponerte en contacto con <strong>Property Web</strong> para solicitar la activaci&oacute;n llam&aacute;ndonos al <strong>914.295.143</strong>,</p>
    <p><span style="float:right;"><a href="#" class="btn" onclick="solicitar_contacto();" >solicitar</a></span>
        o si lo prefieres, podemos ponernos en contacto contigo llam&aacute;ndote tu m&oacute;vil para informarte y activar el Servicio M&oacute;vil.</p>
    <p>&nbsp;</p>
<% end sub %>

<% sub EnviarLicenciaMovil %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p>Property Web va a proceder a registrar tu dispositivo para el acceso al <strong>Servicio M&oacute;vil</strong>:</p>
    <form action="/acceso/password.asp" method="post" target="_self" name="frm_confirm" id="frm_confirm">
    	frmAdminLogin <input type="text" name="frmAdminLogin" value="setcookie">
        <hr />
        device_type <input type="text" name="device_type" id="device_type" value=""><br />
        device	<input type="text" name="device_model" id="device_model" value=""> 
        		<input type="text" name="device_vendor" id="device_vendor" value=""><br />
        os 		<input type="text" name="os_name" id="os_name" value="">
        		<input type="text" name="os_version" id="os_version" value=""><br />
        browser <input type="text" name="browser_name" id="browser_name" value=""> 
        		<input type="text" name="browser_version" id="browser_version" value=""><br />
        engine 	<input type="text" name="engine_name" id="engine_name" value=""> 
        		<input type="text" name="engine_version" id="engine_version" value="">
        <hr />
        cliente <input type="text" name="cliente" value="<%= cliente %>"><br />
        password <input type="text" name="password" value="<%= password %>"><br />
        usuario <input type="text" name="usuario" value="<%= usuario %>"><br />
        movil <input type="text" name="movil" value="<%= movil %>">
        <div class="botones">
            <input type="button" value="Volver" onclick="volver();" class="btn"/>
            &nbsp;
            <input type="submit" value="Aceptar" class="btn">
        </div>
    </form>
    <p>&nbsp;</p>
<script type="text/javascript" src="/lib/ua-parser/ua-parser.min.js"></script>
<script type="text/javascript">
var result = UAParser()

var tmp = "";

if (result.os.name) {
	document.getElementById("os_name").value = result.os.name;
	tmp = result.os.version;
	if (result.cpu.architecture) {tmp = tmp + ' ' + result.cpu.architecture.replace("amd64", " x64") }
	document.getElementById("os_version").value = tmp;
};

if (result.browser.name) {
	document.getElementById("browser_name").value = result.browser.name;
	document.getElementById("browser_version").value = result.browser.version;
};

if (result.engine.name) {
	document.getElementById("engine_name").value = result.engine.name;
	document.getElementById("engine_version").value = result.engine.version;
};

if (result.device.type) {
	document.getElementById("device_type").value = result.device.type;
	document.getElementById("device_model").value = result.device.model;
	document.getElementById("device_vendor").value = result.device.vendor;
} else {
	document.getElementById("device_type").value = "PC";
};

$(document).ready(function() { 
	$("#frm_confirm").ajaxForm({
		success: function(responseText) {
			
			$("#access-confirm").html(responseText);
			$("#access-response").slideUp();
			$("#access-confirm").slideDown();
		}
	}); 
	
}); 

</script>
<% end sub %>

<% function Acomodar(rSting)	
	tmp = trim(cstr("" & rSting))
	if tmp<>"" then
		tmp = replace(tmp, "'", "''")
	end if
	Acomodar = tmp
end function %>
