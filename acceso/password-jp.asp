<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
'<!-- include virtual="/inc/reg_accesos.asp" -->
'<!-- include virtual="/lib/funciones.asp" -->
if request.Form("frmAdminLogin")<>"" then
	
	select case request.Form("frmAdminLogin")
	case "condiciones"		
		if request.Cookies("licencia")="" then 
			sw_pasa = false
		else
			sw_pasa = true
			
			if session("PW_WS").Comprobar_Empresa(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))<>0 then sw_pasa = false
			if session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("user_id"))<>0 then sw_pasa = false
			
			if sw_pasa then
				'reg_accesos
				sql = "UPDATE reg_accesos SET session_login=GETDATE() WHERE session_id='" & session.SessionID & "'"
				session("connPWAcesos").execute sql
				
				'clientes_licencias
				sql = "UPDATE clientes_licencias SET last_login=GETDATE() WHERE id=" & session("PW_WS").ClienteUsuarioId
				session("connPW").execute sql
				
				session("PW_WS").boolAceptadasCondiciones = true
				response.Cookies("condiciones")="true"
				
			else
				response.Cookies("condiciones")=""
				
			end if
			
		end if
		
		response.Write(session("PW_WS").boolAceptadasCondiciones)
		
		
	
	case "registro"			
		usuario = lcase(trim(request.form("usuario")))
		
		cliente = ucase(trim(request.form("cliente")))
		password = request.form("password")
		
		fecha = FormatDateTime(now, 2)
		hora = FormatDateTime(now, 4)
		
		http_rem_addr = request.servervariables("REMOTE_ADDR") 
		http_rem_host = request.servervariables("REMOTE_HOST")
		http_ua = request.servervariables("HTTP_USER_AGENT")
		
		set rsCliente=Server.CreateObject("ADODB.recordset")
		
		'resp = session("PW_WS").Comprobar_Empresa(request.form("cliente"), request.form("password"), intContratadas, intEntregadas, strIp)
		
		sql = "SELECT * FROM clientes WHERE (EMPRESA ='" & cliente & "' AND PASSWORD ='" & password & "')"
		rsCliente.Open sql, session("connPW")
		
		if rsCliente.eof then
			call IncorrectoCliente
		else
			cliente_id = rsCliente("id")
			intContratadas = rsCliente("NUM_LICENCIAS")
			intEntregadas = rsCliente("licencias_enviadas")
			
			if intEntregadas >= intContratadas then 
				
				call IncorrectoSinLicencias
			else 
				call EnviarLicencia
			end if
			
		end if
		
		rsCliente.close
		set rsCliente = nothing
		
	case "registro_movil"	
		movil = trim(request.form("movil"))
		cliente = ucase(trim(request.form("cliente")))
		password = request.form("password")
		
		fecha = FormatDateTime(now, 2)
		hora = FormatDateTime(now, 4)
		
		http_rem_addr = request.servervariables("REMOTE_ADDR") 
		http_rem_host = request.servervariables("REMOTE_HOST")
		http_ua = request.servervariables("HTTP_USER_AGENT")
		
		resp = session("PW_WS").Comprobar_Empresa(cstr(cliente), cstr(password))
		
		set rsCliente = Server.CreateObject("ADODB.recordset")
		
		'resp = session("PW_WS").Comprobar_Empresa(request.form("cliente"), request.form("password"), intContratadas, intEntregadas, strIp)
		
		sql = "SELECT * FROM clientes WHERE (EMPRESA ='" & cliente & "' AND PASSWORD ='" & password & "')"
		rsCliente.Open sql, session("connPW")
		
		if rsCliente.eof then
			call IncorrectoCliente
		else
			cliente_id = rsCliente("id")
			
			'comprobar m�vil
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
				
				set rsTest = Server.CreateObject("ADODB.Recordset")
				sql = "SELECT * FROM clientes_licencias WHERE NOMBRE='" & usuario & "' AND acceso_movil='" & movil & "'"
				rsTest.open sql, session("connPW")
				
				if rsTest.eof then
					call EnviarLicenciaMovil
				else
					call LicenciaMovilYaEnviada
				end if
				
				rsTest.close
				set rsTest = nothing
				
			end if
			
			rsTmp.close
			set rsTmp=nothing
			
			
		end if
		
		rsCliente.close
		set rsCliente = nothing
		
		
	case "setcookie"		
		'si viene de su empresa tiene contratadas... 
		for each elto in request.Form
			%><li><%= elto %>: <%= request.Form(elto) %></li><%
		next
		
		cliente=request.form("cliente")
		password=request.form("password")
		usuario=request.form("usuario")
		movil=request.form("movil")
		
		if movil = "" then
			resp=session("PW_WS").Crear_Licencia(cstr(cliente), cstr(usuario), cstr(password), "", cstr(request.servervariables("REMOTE_ADDR")))
			
		else
			'insertar licencia
			sql = "INSERT INTO clientes_licencias (ID_EMPRESA, NOMBRE, USUARIO, PASSWORD, NUMERO_LICENCIA, acceso_movil, "
			sql = sql & "propertyweb_eu, fecha, hora, IP "
			sql = sql & ") VALUES ("
			
			sql = sql & request.form("cliente_id") & ", "
			sql = sql & "'" & usuario & "', "
			sql = sql & "'" & cliente & "', "
			sql = sql & "'" & password & "', "
			
			'if movil = "" then
			'	sql = sql & rsCliente("licencias_enviadas") + 1 & ", "
			'	sql = sql & "NULL, "
			'else
				sql = sql & "0, "
				sql = sql & "'" & movil & "', "
			'end if
			
			sql = sql & "1, "
			
			sql = sql & "'" & date & "', "
			hh = cstr(time)
			sql = sql & "'" & left(hh, len(hh)-3) & "', "
			
			
			sql = sql & "'" & request.ServerVariables("REMOTE_HOST") & "'"
			
			sql = sql & ")"
			
			response.Write(sql)
			session("connPW").execute sql
			
			ini = session("PW_WS").IniCliente(cstr(usuario), cstr(cliente), cstr(password), request.Cookies("licencia")("user_id"))
			if ini=1 then 
				resp=0
			end if
		end if
		
		
		if resp=0 then
			sql = "UPDATE reg_accesos SET "
			sql = sql & "cookie_uid=" & session("pw_ws").ClienteId & ", "
			sql = sql & "cookie_u='" & left(session("pw_ws").login, 50) & "', "
			sql = sql & "cookie_lid=" & session("pw_ws").ClienteUsuarioId & ", "
			sql = sql & "cookie_l='" & left(session("pw_ws").nombre, 100) & "' "
			
			sql = sql & "WHERE session_id='" & session.SessionID & "'"
			'response.Write("<p>" & sql & "</p>")
			session("connPWAcesos").execute sql
			
			'pendiente de pasar al objeto PW_WS
			sql = "UPDATE clientes_licencias SET "
			
			sql = sql & "fecha_alta=GETDATE(), "
			sql = sql & "last_session=GETDATE(), "
			
			sql = sql & "http_mozilla='" & session("http_mozilla") & "', "
			sql = sql & "http_navegador='" & session("http_navegador") & "', "
			sql = sql & "http_so='" & session("http_so") & "', "
			
			sql = sql & "os_name='" & request.Form("os_name") & "', "
			sql = sql & "os_version='" & request.Form("os_version") & "', "
			sql = sql & "browser_name='" & request.Form("browser_name") & "', "
			sql = sql & "browser_version='" & request.Form("browser_version") & "', "
			sql = sql & "engine_name='" & request.Form("engine_name") & "', "
			sql = sql & "engine_version='" & request.Form("engine_version") & "', "
			sql = sql & "device_type='" & request.Form("device_type") & "', "
			sql = sql & "device_model='" & request.Form("device_model") & "', "
			sql = sql & "device_vendor='" & request.Form("device_vendor") & "'"
			
			'sql = sql & ", last_session=GETDATE() "
			
			sql = sql & "WHERE id=" & session("PW_WS").ClienteUsuarioId
			'response.Write("<p>" & sql & "</p>")
			session("connPW").execute sql
			
			'traido de Sub CrearCookie
			response.cookies("licencia").domain = "propertyweb.eu"
			response.cookies("licencia").expires = date + 365 
			response.cookies("licencia")("n") = session("PW_WS").nombre
			response.cookies("licencia")("u") = session("PW_WS").login
			response.cookies("licencia")("p") = session("PW_WS").password
			response.cookies("licencia")("client_id") = session("PW_WS").ClienteId
			response.cookies("licencia")("user_id") = session("PW_WS").ClienteUsuarioId
			if movil<>"" then
				response.cookies("licencia")("movil") = session("PW_WS").movil
			end if
			response.Write("resp: " & resp)
			
		else
			response.Write("Error al crear la licencia...")
		end if
		
		call ComprobarLicencia
		
		
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
		
	case "solicitar_movil"	
		
		call SolicitarAccesoMovil
		
	case "solicita_acceso_movil"	
		'configurar servidor email 
		Dim myMail
		Set myMail = CreateObject("CDO.Message") 
		
		'This section provides the configuration information for the remote SMTP server.
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserver") ="smtp.propertyweb.eu"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
		
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
		
		myMail.From = "Property Web <pw@propertyweb.eu>"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="mbm908c"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="pweu9907"
		
		myMail.Configuration.Fields.Update
		
		myMail.Subject =  "Solicitud de Acceso Movil"
		myMail.to = "informatica@propertyweb.eu"
		
		'Mail 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Solicitud recibida: " & date & " " & time & "</p>"
		
		txtMail = txtMail & "<li>Nombre: " & request.Form("nombre") & "</li>"
		txtMail = txtMail & "<li>Empresa: " & request.Form("cliente") & "</li>"
		txtMail = txtMail & "<li>Email: " & request.Form("email") & "</li>"
		txtMail = txtMail & "<li>Tlf: " & request.Form("movil") & "</li>"
		txtMail = txtMail & "<hr>"
		
		txtMail = txtMail & "<li>IP: " & request.ServerVariables("REMOTE_ADDR") & "</li>"
		
		txtMail = txtMail & "<li>Dispositivo: " & request.Form("device_type") & "</li>"
		if request.Form("device_type")<>"PC" then
			txtMail = txtMail & "<li>" & request.Form("device_vendor") & "&nbsp;" & request.Form("device_model") & "</li>"
		end if
		txtMail = txtMail & "<li>" & request.Form("os_name") & "&nbsp;" & request.Form("os_version") & "</li>"
		txtMail = txtMail & "<li>" & request.Form("browser_name") & "&nbsp;" & request.Form("browser_version") & "</li>"
		txtMail = txtMail & "<li>" & request.Form("engine_name") & "&nbsp;" & request.Form("engine_version") & "</li>"
		
		txtMail = txtMail & "<p>&nbsp;</p>"
		
		txtMail = txtMail & "</BODY></HTML>"
		
		myMail.HTMLBody = txtMail
		
		On Error Resume Next
		myMail.Send
		
		Set myMail = Nothing 
			
		call SolicitadoAccesoMovil
		
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
            <p>Est&aacute;s accediendo a informaci&oacute;n restringida en Property Web</p>
            <form action="/articulos/" method="post" id="request_formulario" >
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
        	<div id="access-form" class="cliente">
<% 
email = request.Cookies("licencia")("n")
empresa = request.Cookies("licencia")("u")
password = request.Cookies("licencia")("p")

if Request.Cookies("licencia")("p")="" then 
	call FormularioRegistro
	carga_movil = true
else
	resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id"))
	select case resp
	case 0		'Licencia OK: Aceptar Condiciones
		resp_ini = session("PW_WS").IniCliente(Request.Cookies("licencia")("n"), Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"))
		call AceptarCondiciones	
		carga_movil = false
		
	case 1, 2		
		call LicenciaInvalida
		carga_movil = true
		
	case 999
		call ClienteInactivo
		carga_movil = true
	end select	
end if
%> 
			</div>
            
            <% if carga_movil then %>
            <div id="access-form-movil" style="display:none;" class="cliente"><% call FormularioMovil %></div>
            <% end if %>
            
            <div id="access-response" style="display:none;" class="cliente"></div>
    		<div id="access-confirm" style="display:none;" class="cliente"></div>
            
		</div>
    	<% if request.Cookies("dev")<>"" then %>
    	<div class="modal-footer">
			<% if request.Cookies("licencia")<>"" then %>
                <li><%= request.Cookies("licencia") %>&nbsp;<a href="/acceso/dev/licencia.asp?act=del" target="_blank">X</a></li>
            <% end if %>
    	</div>
        <% end if %>
	</div>
</div>
<script type="text/javascript">
function AceptarCondiciones() {
	//console.log("AceptarCondiciones")
	
	$.post("/acceso/password.asp", 
		"frmAdminLogin=condiciones",
		function( data ) {
			//console.log(data)
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

if ( $("html").hasClass("touchevents") ) {
	//console.log("touchevents")
	$("#access-form-movil").show();
	$("#access-form").hide();
}
</script>

<% sub FormularioRegistro %>
	<h1 class="tit_mod">Si eres cliente</h1>
    <div id="form-msg">
        <p class="destaca">Inserta tus datos personales y de acceso:</p>
    </div>
	<form action="/acceso/password.asp" method="POST" target="_blank" name="frm_registro" id="frm_registro" autocomplete="off">
        <input type="hidden" name="frmAdminLogin" value="registro">
        <input type="hidden" name="reg" value="licencia">
        
        <input type="hidden" name="device_type" id="device_type" value="">
        <input type="hidden" name="device_model" id="device_model" value="">
        <input type="hidden" name="device_vendor" id="device_vendor" value="">
        <input type="hidden" name="os_name" id="os_name" value="">
        <input type="hidden" name="os_version" id="os_version" value="">
        <input type="hidden" name="browser_name" id="browser_name" value="">
        <input type="hidden" name="browser_version" id="browser_version" value="">
        <input type="hidden" name="engine_name" id="engine_name" value="">
        <input type="hidden" name="engine_version" id="engine_version" value="">
        
        <table border="0" cellpadding="4" align="center">
          <tr>
            <td><label>email:</label></td>
            <td colspan="4"><input type="email" name="usuario" maxlength="100" size="52" value="<%= email %>" class="form-control" required="required"></td>
          </tr>
          <tr>
            <td><label>Empresa: </label> </td>
            <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= empresa %>" class="form-control" required="required"></td>
            <td></td>
            <td align="right"><label>Password: </label></td>
            <td align="right"><input type="password" name="password" value="<%= password %>" maxlength="15" size="15" class="form-control" required="required"></td>
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
    <% 'if request.Cookies("dev")<>"" or request.Cookies("design")<>"" then %>
    <hr />
    <h2 class="tit_mod">Acceso M&oacute;vil</h2>
        <p><input type="button" value="Acceso M&oacute;vil" class="TituloDatos btn" style="float:right;" id="cmd_acceso_movil">
        Si tienes activado el Acceso M&oacute;vil y quieres registrar este dispositivo, haz click aqu&iacute;: </p>
    <% 'end if %>
    <hr />
    <h1 class="tit_mod">Si no eres cliente</h1>
    <p><a href="/presenta" class="btn" style="float:right;">Conoce nuestros servicios</a>Puedes ponerte en contacto con PropertyWeb <% if 1=2 then %>rellenando el siguiente formulario,<br />o<% end if %> llamando al <strong>914.295.143.</strong></p>
    <br />
    <br />
<script type="text/javascript" src="/lib/ua-parser/ua-parser.min.js"></script>
<script type="text/javascript">
var result = UAParser()
var tmp = "";

if (result.os.name) {
	document.getElementById("os_name").value = result.os.name;
	tmp = result.os.version;
	if (result.cpu.architecture) {tmp = tmp + ' ' + result.cpu.architecture.replace("amd64", " x64") }
	document.getElementById("os_version").value = tmp;
	
	document.getElementById("os_name_movil").value = result.os.name;
	document.getElementById("os_version_movil").value = tmp;
};

if (result.browser.name) {
	document.getElementById("browser_name").value = result.browser.name;
	document.getElementById("browser_version").value = result.browser.version;
	
	document.getElementById("browser_name_movil").value = result.browser.name;
	document.getElementById("browser_version_movil").value = result.browser.version;
};

if (result.engine.name) {
	document.getElementById("engine_name").value = result.engine.name;
	document.getElementById("engine_version").value = result.engine.version;
	
	document.getElementById("engine_name_movil").value = result.engine.name;
	document.getElementById("engine_version_movil").value = result.engine.version;
};

if (result.device.type) {
	document.getElementById("device_type").value = result.device.type;
	document.getElementById("device_model").value = result.device.model;
	document.getElementById("device_vendor").value = result.device.vendor;
	
	document.getElementById("device_type_movil").value = result.device.type;
	document.getElementById("device_model_movil").value = result.device.model;
	document.getElementById("device_vendor_movil").value = result.device.vendor;
	
} else {
	document.getElementById("device_type").value = "PC";
	document.getElementById("device_type_movil").value = "PC";
};

$(document).ready(function() { 
	
	$("#frm_registro").ajaxForm({
		beforeSend: testForm, 
		success: mostrarRespuesta
	}); 
	
	function testForm(){
		//$("#loader_gif").fadeIn("slow");
		var ErrSubmit = "";
		var foco = "email";
		var emailReg = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
		
		var email = document.frm_registro.usuario.value;
		
		if (document.frm_registro.password.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir la clave de acceso.</p>"; foco="password"; };
		if (document.frm_registro.cliente.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir el nombre de cliente de tu empresa.</p>"; foco="cliente"; };
		
		if(!(emailReg.test(email))) {ErrSubmit="<p class='destaca'>El email introducido no es v&aacute;lido</p>"};
		if (email=="") {ErrSubmit="<p class='destaca'>Tienes que introducir tu email.</p>"};
		
		if (ErrSubmit=="") {
		} else {
			$("#form-msg").html(ErrSubmit);
			$("[name="+foco+"]").focus();
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
	
	
	
	$("#frm_registro_movil").ajaxForm({
		beforeSend: testFormMovil, 
		success: mostrarRespuestaMovil
	}); 
	
	function testFormMovil(){
		var ErrSubmit = "";
		var foco = "movil";
		var movilReg = new RegExp(/^\d{9}$/);
		
		var movil = document.frm_registro_movil.movil.value;
		
		if (document.frm_registro_movil.password.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir la clave de acceso.</p>"; foco="password"; };
		if (document.frm_registro_movil.cliente.value=="") {ErrSubmit="<p class='destaca'>Tienes que introducir el nombre de cliente de tu empresa.</p>"; foco="cliente"; };
		
		if(!(movilReg.test(movil))) {ErrSubmit="<p class='destaca'>El m&oacute;vil introducido no es v&aacute;lido</p>"};
		if (movil=="") {ErrSubmit="<p class='destaca'>Tienes que introducir tu m&oacute;vil.</p>"};
		
		if (ErrSubmit=="") {
		} else {
			$("#form-msg-movil").html(ErrSubmit);
			$("[name="+foco+"]").focus();
			return false;
		};
	};
	function mostrarRespuestaMovil (responseText){
		$("#access-response").html(responseText);
		$("#access-form-movil").slideUp();
		$("#access-response").slideDown();
	};
	
	
	
	$("#cmd_acceso_movil").click(function(e) {
        
		$("#access-response").slideUp();
		$("#access-confirm").slideUp();
		
		$("#access-form-movil").slideDown();
		$("#access-form").slideUp();
    });
	
	
	$("#frm_confirm").ajaxForm({
		success: function(responseText) {
			
			$("#access-confirm").html(responseText);
			$("#access-response").slideUp();
			$("#access-confirm").slideDown();
		}
	}); 
	
	
});

function volver() {
	//console.log("volver");
	$("#access-response").slideUp();
	$("#access-confirm").slideUp();
	
	//console.log( $("#reg").val() )
	
	if ( $("#reg").val()=="movil") {
		
		$("#access-form").slideUp();
		$("#access-form-movil").slideDown(function() {
			$('#access-response').html("");
			$('#access-confirm').html("");
		});
		
	} else {
		
		$("#access-form-movil").slideUp();
		$("#access-form").slideDown(function() {
			$('#access-response').html("");
			$('#access-confirm').html("");
		});
		
	}
	
}

</script>
<% end sub %>

<% sub FormularioMovil %>
	<h1 class="tit_mod">Acceso M&oacute;vil</h1>
    <div id="form-msg-movil">
        <p class="destaca">Inserta tus datos  de acceso:</p>
    </div>
	<form action="/acceso/password.asp" method="POST" target="_blank" name="frm_registro_movil" id="frm_registro_movil" autocomplete="off">
    	<input type="hidden" name="frmAdminLogin" value="registro_movil">
		<input type="hidden" name="reg" value="movil">
        
        <input type="hidden" name="device_type" id="device_type_movil" value="">
        <input type="hidden" name="device_model" id="device_model_movil" value="">
        <input type="hidden" name="device_vendor" id="device_vendor_movil" value="">
        <input type="hidden" name="os_name" id="os_name_movil" value="">
        <input type="hidden" name="os_version" id="os_version_movil" value="">
        <input type="hidden" name="browser_name" id="browser_name_movil" value="">
        <input type="hidden" name="browser_version" id="browser_version_movil" value="">
        <input type="hidden" name="engine_name" id="engine_name_movil" value="">
        <input type="hidden" name="engine_version" id="engine_version_movil" value="">
		
      <table border="0" cellpadding="4" align="center">
          <tr>
            <td><label>m&oacute;vil:</label></td>
            <td colspan="4"><input type="tlf" name="movil" maxlength="9" size="15" value="" class="form-control" required="required" placeholder="XXX XXX XXX"></td>
          </tr>
          <tr>
            <td><label>Empresa: </label> </td>
            <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= empresa %>" class="form-control" required="required"></td>
            <td></td>
            <td align="right"><label>Password: </label></td>
            <td align="right"><input type="password" name="password" value="<%= password %>" maxlength="15" size="15" class="form-control" required="required"></td>
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
    <p>Si no tienes activado el <strong>Acceso M&oacute;vil</strong>, puedes ponerte en contacto con nosotros para solicitar la activaci&oacute;n llam&aacute;ndonos al <strong>914.295.143</strong>,
    <br />
o tambi&eacute;n puedes registrarte normalmente y acceder a los contenidos desde tu dispositivo m&oacute;vil como desde si accedieras desde un PC o desde cualquier otro dispositivo.</p>
    <div class="botones">
	    <input type="button" value="Registro Normal" class="btn" onclick="volver();">
    </div>
    <br />
<% end sub %>

<% sub AceptarCondiciones() 	
	dim intContratadas
	dim intEntregadas
	resp=session("PW_WS").Comprobar_Empresa(session("PW_WS").login, session("PW_WS").password, intContratadas, intEntregadas)
	%>
    <h1>Bienvenid@<br>
    <span class="destaca"><%= session("PW_WS").Nombre %></span></h1>
    <p>Tu ordenador ha sido identificado por PROPERTY WEB.<br />
    <span class="destaca"><%= session("PW_WS").Login %></span> tiene contratadas <%= intContratadas %> licencias, de las cuales la tuya es la n&deg; <%= session("PW_WS").intlicenciaN %>.</p>
    <p>Para poder acceder a los contenidos tienes que aceptar las condiciones:</p>
    <textarea rows="8" wrap="VIRTUAL" style="width:100%" id="condiciones"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
    <br>
    <div class="botones">
        <input type="button" value="Aceptar Condiciones" class="btn" onclick="AceptarCondiciones();">
    </div>
    <br>
<% end sub %>

<% sub ComprobarLicencia() 
	'resp=session("PW_WS").Comprobar_Licencia(Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"), Request.Cookies("licencia")("n"), Request.Cookies("licencia")("user_id"))
	'nunca se deber�a dar s�lo, si tiene bloqueadas las cookies
	resp = session("PW_WS").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"))
	
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
        	<input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
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
	<p>Pero tu licencia no es v&aacute;lida.<% 'if resp=1 then %> Tienes que volver a registrarte.<% 'end if %></p>
	<br />
	<p>En caso de duda ponte en contacto con la persona encargada del servicio de Property Web en tu empresa,<br />
	o ll&aacute;manos a Property Web:  <strong>914.295.143</strong>.</p>
    <br />
	<div class="botones">
	<form action="" method="post" id="delcookie">
        <input type="hidden" name="frmAdminLogin" value="delcookie">
        <a href="#" class="btn btn-primary" data-dismiss="modal">Cancelar</a>
        &nbsp;
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

<% sub ClienteInactivo() %>
	<h1>&iexcl;&iexcl;&iexcl; Atenci&oacute;n !!!</h1>
	<p>Tu ordenador ha sido identificado por PROPERTY WEB</p>
	<p><b><%= request.Cookies("licencia")("n") %></b></p>
	<br />
	<p>Pero el servicio ha sido interrumpido para <%= cliente %> y no podemos darte acceso a los contenidos.</p>
	<br />
	<p>En caso de duda ponte en contacto con la persona encargada del servicio de Property Web en tu empresa,<br />
	o ll&aacute;manos a Property Web:  <strong>914.295.143</strong>.</p>
    <br />
	<div class="botones">
		<input type="button" id="aceptar" value="Aceptar" class="btn btn-primary">
	</div>
    <br />
<% end sub %>

<% sub EnviarLicencia %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p><strong><%= cliente %></strong> tiene contratadas <%= intContratadas %> licencias de las cuales <%= intEntregadas %> se han entregado.</p>
    <p>&iquest;Quieres dar de alta la licencia n&ordm; <%= intEntregadas + 1 %> para tu equipo?</p>
    <p>&nbsp;</p>
    <form action="/acceso/password.asp" method="post" target="_self" name="frm_confirm" id="frm_confirm">
        <input type="hidden" name="frmAdminLogin" value="setcookie">
        
<input type="hidden" name="cliente" value="<%= cliente %>">
<input type="hidden" name="cliente_id" value="<%= cliente_id %>">
<input type="hidden" name="password" value="<%= password %>">
<input type="hidden" name="usuario" value="<%= usuario %>">

<input type="hidden" name="device_type" value="<%= request.Form("device_type") %>">
<input type="hidden" name="device_model" value="<%= request.Form("device_model") %>">
<input type="hidden" name="device_vendor" value="<%= request.Form("device_vendor") %>">
<input type="hidden" name="os_name" value="<%= request.Form("os_name") %>">
<input type="hidden" name="os_version" value="<%= request.Form("os_version") %>">
<input type="hidden" name="browser_name" value="<%= request.Form("browser_name") %>">
<input type="hidden" name="browser_version" value="<%= request.Form("browser_version") %>">
<input type="hidden" name="engine_name" value="<%= request.Form("engine_name") %>">
<input type="hidden" name="engine_version" value="<%= request.Form("engine_version") %>">
      
        <div class="botones">
            <% if request.Cookies("dev")<>"" then %>
            <input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
            <input type="button" value="Volver" onclick="volver();" class="btn"/>
            &nbsp;
            <% end if %>
            <input type="submit" value="Aceptar" class="btn">
        </div>
    </form>
    <p>&nbsp;</p>
<script type="text/javascript">
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
    <div class="botones">
    	<input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <br />
    <p>Si no eres cliente, puedes contactar con Property Web llam&aacute;ndonos al <strong>914.295.143</strong>.</p>
    <p>Presentaci&oacute;n del servicio: <a href="/presenta/" class="btn" style="float:right;">Presentaci&oacute;n</a></p>
    <p>&nbsp;</p>
    <% for each elto in request.Form 
		%><li><%= elto %>: <%= request.Form(elto) %></li><%
	next %>
    
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
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <br />
    <p>El n&uacute;mero de licencias contratadas por&nbsp;<%= request.form("usuario") %> es  <%= intContratadas %>, y ya han sido registradas todas.</p>
    <br />
    <p>No podemos darte acceso a los resultados.</p>
    <p>En caso de duda ponte en contacto con la persona encargada de Property Web en tu empresa,<br />
    o ll&aacute;manos a Property Web: <strong>914.295.143</strong>.</p>
    <p>&nbsp;</p>
    <div class="botones">
    	<input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
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
    <p>El tel&eacute;fono  <strong>Acceso M&oacute;vil</strong> no ha sido activado para el tel&eacute;fono <strong><%= request.Form("movil") %></strong>.</p>
    <br />
    <div class="botones">
    	<a href="#" class="btn btn-primary" data-dismiss="modal">Cancelar</a>
         &nbsp; 
      <input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
      <input type="button" value="Volver" onclick="volver();" class="btn"/>
    </div>
    <% for each elto in request.Form
		%><li><%= elto %>: <%= request.Form(elto) %></li><%
	next %>
    <br />
    <hr />
    <p>Si no tienes activado el Acceso M&oacute;vil, puedes ponerte en contacto con <strong>Property Web</strong> para solicitar la activaci&oacute;n llam&aacute;ndonos al <strong>914.295.143</strong>,</p>
    <p>o si lo prefieres, podemos ponernos en contacto contigo llam&aacute;ndote tu m&oacute;vil para informarte y activar el Servicio M&oacute;vil.</p>
    <div class="botones">
<form action="/acceso/password.asp" method="post" target="_blank" name="frm_solicita" id="frm_solicita">

<input type="hidden" name="frmAdminLogin" value="solicitar_movil">

<input type="hidden" name="cliente" value="<%= cliente %>">
<input type="hidden" name="cliente_id" value="<%= cliente_id %>">
<input type="hidden" name="password" value="<%= password %>">
<input type="hidden" name="usuario" value="<%= usuario %>">
<input type="hidden" name="movil" value="<%= movil %>">
        
<input type="hidden" name="device_type" value="<%= request.Form("device_type") %>">
<input type="hidden" name="device_model" value="<%= request.Form("device_model") %>">
<input type="hidden" name="device_vendor" value="<%= request.Form("device_vendor") %>">
<input type="hidden" name="os_name" value="<%= request.Form("os_name") %>">
<input type="hidden" name="os_version" value="<%= request.Form("os_version") %>">
<input type="hidden" name="browser_name" value="<%= request.Form("browser_name") %>">
<input type="hidden" name="browser_version" value="<%= request.Form("browser_version") %>">
<input type="hidden" name="engine_name" value="<%= request.Form("engine_name") %>">
<input type="hidden" name="engine_version" value="<%= request.Form("engine_version") %>">
		
        <input type="submit" value="Solicitar" class="btn">
        </form>
	</div>
    <p>&nbsp;</p>
<script type="text/javascript">
$(document).ready(function() { 
	$("#frm_solicita").ajaxForm({
		success: function(responseText) {
			$("#access-confirm").html(responseText);
			$("#access-response").slideUp();
			$("#access-confirm").slideDown();
		}
	}); 
	
});
</script>
<% end sub %>

<% sub EnviarLicenciaMovil %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p>Property Web va a proceder a registrar tu dispositivo para el acceso al <strong>Servicio M&oacute;vil</strong>:</p>
    <ul>
    	<li>Email: <strong><%= usuario %></strong></li>
    	<li>Dispositivo: <%= request.Form("device_type") %></li>
    	<% if request.Form("device_type")<>"PC" then %>
        <li><%= request.Form("device_vendor") %>&nbsp;<%= request.Form("device_model") %></li>
        <% end if %>
        <li>navegador: <%= request.Form("browser_name") %>&nbsp;<%= request.Form("browser_version") %></li>
    </ul>
    <br />
<form action="/acceso/password.asp" method="post" target="_self" name="frm_confirm" id="frm_confirm">
<input type="text" name="frmAdminLogin" value="setcookie"><br />
        
<input type="text" name="cliente" value="<%= cliente %>"><br />
<input type="text" name="cliente_id" value="<%= cliente_id %>"><br />
<input type="text" name="password" value="<%= password %>"><br />
<input type="text" name="usuario" value="<%= usuario %>"><br />
<input type="text" name="movil" value="<%= MOVIL %>"><br />

<input type="text" name="device_type" value="<%= request.Form("device_type") %>"><br />
<input type="text" name="device_model" value="<%= request.Form("device_model") %>"><br />
<input type="text" name="device_vendor" value="<%= request.Form("device_vendor") %>"><br />
<input type="text" name="os_name" value="<%= request.Form("os_name") %>"><br />
<input type="text" name="os_version" value="<%= request.Form("os_version") %>"><br />
<input type="text" name="browser_name" value="<%= request.Form("browser_name") %>"><br />
<input type="text" name="browser_version" value="<%= request.Form("browser_version") %>"><br />
<input type="text" name="engine_name" value="<%= request.Form("engine_name") %>"><br />
<input type="text" name="engine_version" value="<%= request.Form("engine_version") %>"><br />
    <div class="botones">
        <% if request.Cookies("dev")<>"" then %>
        <input type="text" id="reg" value="<%= request.Form("reg") %>" />
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
        &nbsp;
        <% end if %>
        <input type="submit" value="Aceptar" class="btn">
    </div>
</form>
    <p>&nbsp;</p>
<script type="text/javascript">
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

<% sub LicenciaMovilYaEnviada %>
    <h1>&iexcl;&iexcl;AVISO!!</h1>
    <p>El Acceso M&oacute;vi para <strong><%= movil %></strong> ya ha sido registrado.</p>
    <p>Para volver a registrar tu dispositivo, debes contactar con Property Web (<strong>914.295.143</strong>) y solicitar que liberemos el Acceso M&oacute;vil.</p>
    <hr />
    <% for each elto in request.Form
		%><%= elto %>: <%= request.Form(elto) %><%
	next %>
    <br />
    <div class="botones">
        <% if request.Cookies("dev")<>"" then %>
        <input type="hidden" id="reg" value="<%= request.Form("reg") %>" />
        <input type="button" value="Volver" onclick="volver();" class="btn"/>
        &nbsp;
        <% end if %>
        <input type="submit" value="Aceptar" class="btn">
    </div>
    
    <p>&nbsp;</p>
<% end sub %>

<% sub SolicitarAccesoMovil() 
	movil = trim(request.form("movil"))
	cliente = ucase(trim(request.form("cliente")))
	
	email = "asdf@asdf.es"
	nombre = "jjjppp jjjppp"
	%>
    <h1>Solicitar Acceso M&oacute;vil</h1>
    <p>Ind&iacute;canos tus datos personales para que podamos ponernos en contacto contigo:</p>
    <br />
<form action="/acceso/password.asp" method="post" target="_blank" name="frm_solicita_acceso_movil" id="frm_solicita_acceso_movil">
<input type="hidden" name="frmAdminLogin" value="solicita_acceso_movil">
    <table border="0" cellpadding="4" align="center">
          <tr>
            <td><label>Nombre: </label> </td>
            <td><input type="text" name="nombre" maxlength="50" value="<%= nombre %>" class="form-control" required="required"></td>
          </tr>
          <tr>
            <td><label>email:</label></td>
            <td><input type="email" name="email" maxlength="100" size="52" value="<%= email %>" class="form-control" required="required"></td>
          </tr>
          <tr>
            <td><label>Tel&eacute;fono: </label> </td>
            <td><input type="text" name="movil" size="15" maxlength="15" value="<%= movil %>" class="form-control" required="required"></td>
          </tr>
          <tr>
            <td><label>Empresa: </label> </td>
            <td><input type="text" name="cliente" size="15" maxlength="15" value="<%= cliente %>" class="form-control" required="required"></td>
          </tr>
          
        </table>
    
    <br>
    <div class="botones">

<input type="hidden" name="device_type" value="<%= request.Form("device_type") %>">
<input type="hidden" name="device_model" value="<%= request.Form("device_model") %>">
<input type="hidden" name="device_vendor" value="<%= request.Form("device_vendor") %>">
<input type="hidden" name="os_name" value="<%= request.Form("os_name") %>">
<input type="hidden" name="os_version" value="<%= request.Form("os_version") %>">
<input type="hidden" name="browser_name" value="<%= request.Form("browser_name") %>">
<input type="hidden" name="browser_version" value="<%= request.Form("browser_version") %>">
<input type="hidden" name="engine_name" value="<%= request.Form("engine_name") %>">
<input type="hidden" name="engine_version" value="<%= request.Form("engine_version") %>">

        <input type="submit" value="Solicitar" class="btn">
    </div>
    <br>
<script type="text/javascript">
$(document).ready(function() { 
	$("#frm_solicita_acceso_movil").ajaxForm({
		success: function(responseText) {
			
			$("#access-response").html(responseText);
			$("#access-confirm").slideUp();
			$("#access-response").slideDown();
		}
	}); 
	
});
</script>
<% end sub %>

<% sub SolicitadoAccesoMovil() %>
    <h1>Solicitar Acceso M&oacute;vil</h1>
    <p>Hemos recibido tu solicitud.</p>
    <p>En breve nos pondremos en contacto contigo.</p>
    <br />
	<p>Gracias por utilizar Property Web</p>
    
    <div class="botones">
	   	<input type="submit" value="Aceptar" class="btn" data-dismiss="modal">
    </div>
    <br>
<% end sub %>

<% function Acomodar(rSting)	
	tmp = trim(cstr("" & rSting))
	if tmp<>"" then
		tmp = replace(tmp, "'", "''")
	end if
	Acomodar = tmp
end function %>
