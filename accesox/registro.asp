<% 
'comprobar estado y mostrar formulario 
if not session("PW_WS").boolAceptadasCondiciones then 
	select case Request.Form("frmAdminLogin")
	case "condiciones"			'si viene de aceptar condiciones 
		session("PW_WS").boolAceptadasCondiciones = true
		if request.Cookies("dev")("reg")="" then
			sql = "UPDATE clientes_licencias SET last_login = GETDATE() WHERE id=" & session("PW_WS").ClienteUsuarioId
			session("connPW").execute sql
			
			sql = "UPDATE reg_accesos SET session_login=GETDATE() WHERE session_id='" & session.SessionID & "'"
			session("connPWAcesos").execute sql
			
			Set rsReg = Server.CreateObject("ADODB.Recordset")
			sql = "SELECT TOP 1 id FROM reg_pags WHERE session_id='" & session.SessionID & "' ORDER BY id DESC"
			rsReg.Open sql, session("connPWAcesos")
			
			sql = "UPDATE reg_pags SET session_usuario='" & left(session("pw_ws").login, 50) & "', session_nombre='" & left(session("pw_ws").nombre, 100) & "' "
			sql = sql & "WHERE id=" & rsReg("id")
			session("connPWAcesos").execute sql
			
			rsReg.close
		end if
		resp_ini = session("PW_WS").IniCliente(Request.Cookies("licencia")("n"), Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"))
		'sql = "UPDATE reg_accesos SET session_login=GETDATE() WHERE session_id='" & session.SessionID & "'"
		'session("connPWAcesos").execute sql
		'
		'Set rsReg = Server.CreateObject("ADODB.Recordset")
		'rsReg.Open "SELECT TOP 1 id FROM reg_pags WHERE session_id='" & session.SessionID & "' ORDER BY id DESC", session("connPWAcesos")
		'
		'sql = "UPDATE reg_pags SET session_usuario='" & left(session("pw_ws").login, 50) & "', session_nombre='" & left(session("pw_ws").nombre, 100) & "' "
		'sql = sql & "WHERE id=" & rsReg("id")
		'session("connPWAcesos").execute sql
		'
		'rsReg.close
		
	case "registro"				'si ya ha introducido sus datos 
		if request.form("usuario") = "" then call IncorrectoFormulario
		if request.form("cliente") = "" then call IncorrectoFormulario
		if request.form("password") = "" then call IncorrectoFormulario
		
		resp = session("PW_WS").Comprobar_Empresa(request.form("cliente"), request.form("password"), intContratadas, intEntregadas, strIp)
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
		movil=request.form("movil")

		resp=session("PW_WS").Crear_Licencia(cstr(cliente), cstr(usuario), cstr(password), cstr(cargo), cstr(request.servervariables("REMOTE_ADDR")))
		
		if resp=0 then
			sql = "UPDATE reg_accesos SET "
			sql = sql & "session_login=GETDATE(), "
			sql = sql & "cookie_uid=" & session("pw_ws").ClienteId & ", "
			sql = sql & "cookie_u='" & left(session("pw_ws").login, 50) & "', "
			sql = sql & "cookie_lid=" & session("pw_ws").ClienteUsuarioId & ", "
			sql = sql & "cookie_l='" & left(session("pw_ws").nombre, 100) & "' "
			sql = sql & "WHERE session_id='" & session.SessionID & "'"
			session("connPWAcesos").execute sql
			
			'pendiente de pasar al objeto PW_WS
			sql = "UPDATE clientes_licencias SET "
			sql = sql & "http_mozilla='" & session("http_mozilla") & "', "
			sql = sql & "http_navegador='" & session("http_navegador") & "', "
			sql = sql & "http_so='" & session("http_so") & "', "
			sql = sql & "last_session=GETDATE() "
			sql = sql & "WHERE id=" & session("PW_WS").ClienteUsuarioId
			session("connPW").execute sql
			
			'Cookie
			Response.Cookies("licencia").domain = "propertyweb.eu"
			Response.Cookies("licencia").expires = date + 365 
			Response.Cookies("licencia")("n") = session("PW_WS").nombre
			Response.Cookies("licencia")("u") = session("PW_WS").login
			Response.Cookies("licencia")("p") = session("PW_WS").password
			Response.Cookies("licencia")("client_id") = session("PW_WS").ClienteId
			Response.Cookies("licencia")("user_id") = session("PW_WS").ClienteUsuarioId
			%>
<form name="cook" action="" method="POST" target="_self" ><input type="hidden" name="frmAdminLogin" value="compcookie"></form>
<script>document.cook.submit()</script>
			<% 
			response.end
		else
			response.Write("Error al crear la licencia...")
		end if
		
	case "compcookie"			'comprobacion de cookie
		'RESPONSE.Write("<LI>compcookie</LI>")
		session("PW_WS").boolAceptadasCondiciones=true
		call ComprobarLicencia
		
	case "delcookie"			'eliminar cookie licencia
		call BorrarCookie
	end select
	
end if

if not session("PW_WS").boolAceptadasCondiciones then 
	'Comprobar si tiene algo en cookies 
	if Request.Cookies("licencia")("p")<>"" then 
		resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"),request.Cookies("licencia")("user_id"))
		select case resp
		case 0		'Licencia OK: Aceptar Condiciones
			resp_ini=session("PW_WS").IniCliente(Request.Cookies("licencia")("n"), Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"))
			call AceptarCondiciones	
		case 1		'Licencia No Existe: Licencia Eliminada
			call LicenciaEliminada
		case else
			call LicenciaInvalida
		end select
	else 		
		if request.Form("frmAdminLogin")="registro" then response.End()
		call FormularioRegistro
	end if
end if

if session("PW_WS").boolAceptadasCondiciones then
	%>Registro correcto.... <a href="/acceso/licencia.asp">continuar</a><%
end if
%>

<% sub FormularioRegistro %>
<form action="" method="POST" target="_self" >
<input type="hidden" name="frmAdminLogin" value="registro">
<table width="800" cellspacing="2" cellpadding="2" align="center" border="0">
	<tr align="center" bgcolor="#330066">
	  <td><font color="white"><strong>Registro</strong></font></td></tr>
    <tr>
		<td>PROPERTY WEB PROCEDERA AL REGISTRO DE SU TERMINAL EN NUESTRA BASE DE DATOS</td>
	</tr>
    <tr>
		<td style="font-size:12px; font-weight:bold">- Si eres cliente:</td>
	</tr>
    <tr> 
		<td class="txtTabla">Inserta tus datos personales y de Acceso</td>
	</tr>
	<tr>
		<td>
<table border="0" cellpadding="4" align="center">
  <tr>
    <td><label>Email:</label></td>
    <td colspan="4"><input type="text" name="usuario" maxlength="100" size="45"></td>
  </tr>
  <tr>
    <td><label>Empresa: </label> </td>
    <td><input type="text" name="cliente" size="15" maxlength="15"></td>
    <td>&nbsp;</td>
    <td><label>Password: </label></td>
    <td><input type="password" name="password" maxlength="15" size="15"></td>
  </tr>
</table>
		</td>
	</tr>
	<tr>
		<td><center>CONDICIONES:</center></td>
	</tr>     
	<tr>
		<td>
	<center><textarea name="textarea2" rows="8" wrap="VIRTUAL" style="width:100%"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea></center>
		</td>
	</tr> 
	<tr>
		<td class="txtTablaNEGRITA">
<center><input type="submit" value="Aceptar condiciones" onClick="" name="submit"></center>		</td>
	</tr>
	<tr height="12"><td></td></tr>
	<tr>
		<td><font style="font-size:12px; font-weight:bold">- Si no eres cliente</font><font style="font-size:12px; font-weight:bold">:</font></td>
	</tr>
	<tr>
	  <td>Puedes contactar con nosotros para recibir m&aacute;s informaci&oacute;n llamando al <strong>914.295.143</strong>.</td>
    </tr>
</table>
</form>
		<% response.end 
end sub %>

<% sub IncorrectoFormulario %>
<form method="POST" action="" target="_self">
	<input type="hidden" name="frmAdminLogin" value="error">
	<center>
		<h1><font color="#FF6633">Fallo de identificaci&oacute;n</font></h1>
	    <font color="#FF6633" size="4">Debe introducir todos los campos de entrada obligatoria</font> 
    	<br><br>
		<input type="submit" value="Volver" >
	</center>
</form>
	<%
   response.end
end sub %>

<% sub IncorrectoCliente 
	fecha=FormatDateTime(now,2)
	hora=FormatDateTime(now,4)
	REMOTE_ADDR=request.servervariables("REMOTE_ADDR") 
	REMOTE_HOST=request.servervariables("REMOTE_HOST")
	HTTP_USER_AGENT=request.servervariables("HTTP_USER_AGENT")
	
	if request.form("cliente")="" then usuar="no" else usuar=request.form("cliente")
	if request.form("password")="" then password="no" else password=request.form("password")
	if request.form("usuario")="" then nombre="no" else nombre=request.form("usuario")
	if request.form("cargo")="" then cargo="no" else cargo=request.form("cargo")
	
	SQL = "INSERT INTO FALLOS (usuario,password,nombre,cargo,fecha,hora,"
	SQL = SQL & "REMOTE_HOST,REMOTE_ADDR,HTTP_USER_AGENT"
	SQL = SQL & ") VALUES ('" & usuar & "','" & password & "','"
	SQL = SQL & nombre &"','" & cargo & "','" & fecha & "','" & hora &"','" & REMOTE_HOST & "','" & REMOTE_ADDR & "','" & left(HTTP_USER_AGENT, 150) & "')"
	
	session("connPWAcesos").execute sql
	%>
<form action="" method="POST" target="_self">
	<input type="hidden" name="frmAdminLogin" value="error">
	<center>
		<h1><font color="#FF6633">Fallo de identificaci&oacute;n</font></h1>
		<p><font color="#FF6633" size="4">Vuelva a insertar su clave de acceso</font> 
		<br><br>
		<input type="submit" value="Volver" >
		<br><br>
<table border="0" cellspacing="0" cellpadding="1" bgcolor="#CCCCFF">
	<tr><td nowrap align="center">Si no es cliente y quiere m&aacute;s informaci&oacute;n del servicio pulse <a href="/top/suscribe.asp" target="FraTit"><font size="2">[AQUI]</font></a></td></tr>
</table>
	</center>
</form>
<%
   response.end
end sub %>

<% sub IncorrectoSinLicencias 
'response.Write("<strong>IncorrectoSinLicencias</strong><br>")
%>
<br>
<br>
<br>
<table class=estilotabla width="800" height=18 cellspacing=2 cellpadding=2 align="center">
  <tr bgcolor="#CC0033"> 
    <td > 
      <div align="center"><b><font color="#FFFFFF">&igrave;&igrave;AVISO!!</font></b></div>
    </td>
  </tr>
  <tr bgcolor="#CCCCCC"> 
    <td > 
<div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2">
El n&uiacute;mero de licencias contratadas por <%= request.form("usuario") %> es <%= intContratadas %> y ya han sido todas registradas, no podemos darle acceso a los resultados.<br>
En caso de duda p&oacute;ngase en contacto con la persona encargada de Property Web en su empresa o llame a Property Web ( 91.429.5143 )
</font></b></div>
    </td>
  </tr>
  <tr bgcolor="#CCCCCC"> 
    <td align="center">
<br>
<form action="" method="POST" target="_self">
<input type="hidden" name="frmAdminLogin" value="todasentregadas">
<input type="submit" value="Volver" >
	  </form>
    </td>
  </tr>
</table>
<%
'Crea un registro con la licencia denegada
Fecha=FormatDateTime(now,2)
hora=FormatDateTime(now,4)
REMOTE_ADDR=request.servervariables("REMOTE_ADDR") 
REMOTE_HOST=request.servervariables("REMOTE_HOST")
HTTP_USER_AGENT=request.servervariables("HTTP_USER_AGENT")
if request.form("nombre")<> "" then nombre=request.form("nombre") else nombre="no"
if request.form("cargo")<> "" then cargo=request.form("cargo") else cargo="no"

SQL = "INSERT INTO LICENCIA_DENEGADA(usuario,password,nombre,cargo,fecha,hora,"
SQL = SQL & "REMOTE_HOST,REMOTE_ADDR,HTTP_USER_AGENT"
SQL = SQL & ") VALUES ('" & request.form("usuario") & "','" & request.form("password") & "','"
SQL = SQL & nombre & "','" & cargo & "','" & fecha & "','" & hora &"','" & REMOTE_HOST & "','" & REMOTE_ADDR & "','" & left(HTTP_USER_AGENT, 150) & "')"

usuario.Open SQL,session("connPWAcesos"),1,1
response.end
end sub %>


<% sub AceptarCondiciones() 
	dim intContratadas
	dim intEntregadas
	resp=session("PW_WS").Comprobar_Empresa(session("PW_WS").login, session("PW_WS").password, intContratadas, intEntregadas)
	%>
<br>
<form action="" method="post" target="_self" >
<input type="hidden" name="frmAdminLogin" value="condiciones">
<table class="estilotabla" width="800" cellspacing="2" cellpadding="2" align="center">
<tr align="center" bgcolor="#330066"><td><font color="white"><strong>Bienvenid@ <%= session("PW_WS").Nombre %></strong></font></td></tr>
<tr><td align="center"><b>
    Su ordenador ha sido identificado por PROPERTY WEB <br />
    <%= session("PW_WS").Login %> tiene contratadas <%= intContratadas %> licencias, de las cuales ya ha entregado <%= intEntregadas %>.<br />
    la suya es la n&deg; <%= session("PW_WS").intlicenciaN %>
	</b></td></tr>
<tr><td align="center">Para poder acceder a los resultados tiene que aceptar las condiciones
<textarea cols="30" name="txtConcidiones" id="txtConcidiones" rows="8" wrap="VIRTUAL" style="width:100%" class="textoenano"><!--#include virtual="/inc/condiciones/condiciones.txt" --></textarea>
</td></tr>
<tr><td align="center"><input type="submit" value="Aceptar condiciones"  name="submit"></td></tr>
</table>
</form>
	<%
	'call AccesoSMS
	response.end
end sub %>

<% sub EnviarLicencia () %>
<form action="" method="POST" target="_self">
<table width="800" cellspacing="2" cellpadding="2" align="center">
	<tr bgcolor="#330066"><td  align="center"><b><font color="#FFFFFF">&igrave;&igrave;AVISO!!</font></b></td></tr>
    <tr><td align="center"><%= request.form("cliente") %> tiene contratadas <%= intContratadas%> licencias,<br />de las cuales <%= intEntregadas%> se han entregado.</td></tr>
	<tr><td align="center">&iquest;Quiere usted dar de alta la licencia n&deg; <%= intEntregadas+1 %> para su equipo?</td></tr>
	<tr><td align="center"><br><input type="submit" value="Aceptar"></td>
	</tr>   
</table>
<input type="hidden" name="frmAdminLogin" value="adelante"> 
<input type="hidden" name="cliente" value="<%= request.form("cliente") %>">
<input type="hidden" name="password" value="<%= request.form("password") %>">
<input type="hidden" name="usuario" value="<%= request.form("usuario") %>">
<input type="hidden" name="cargo" value="<%= request.form("cargo") %>">
</form>
	<% response.end
end sub %>

<% sub CrearCookie() 
	
end sub %>

<% sub BorrarCookie() 
	'Eliminamos la Cookie 
	'response.cookies("licencia").domain = "www.propertyweb.eu"
	'response.cookies("licencia").Expires = "01/01/2000"
	
	response.cookies("licencia").domain = "propertyweb.eu"
	response.cookies("licencia").Expires = "01/01/2000"
	
	'session.Abandon()
	'for each elto in response.Cookies
	'	response.Cookies(elto).expires = dateadd("d", -1, now)
	'next
	%>
<form name="delcookie" action="" method="POST" target="_self" ></form>
<script>document.delcookie.submit()</script>
	<% response.end
end sub %>

<% sub ComprobarLicencia() 
	resp=session("PW_WS").Comprobar_Licencia(Request.Cookies("licencia")("u"), Request.Cookies("licencia")("p"), Request.Cookies("licencia")("n"), Request.Cookies("licencia")("user_id"))
	%>
<form action="" method="POST" target="_self" >
<table width="800" cellspacing="2" cellpadding="2" align="center">
<% if resp=0 then %>
    <tr bgcolor="#330066"><td  align="center"><b><font color="#FFFFFF">Licencia correctamente insertada</font></b></td></tr>
	<tr><td align="center"><p>Su terminal ha sido validado para el acceso a PROPERTYWEB.<BR>
    En sus proximas consultas no le volveremos a pedir las claves de acceso mientras no cambie de ordenador o elimine sus archivos temporales.<br><br>
    Agradecemos su inter&eacute;s y esperamos que los contenidos sean de su agrado.</p><br></td></tr>
<% else %>
    <tr bgcolor="#330066"><td  align="center"><b><font color="#FFFFFF">No se ha podido guardar su Licencia</font></b></td></tr>
	<tr><td align="center"><p>Error al guardar la cookie.<br><br>Agradecemos su inter&eacute;s y esperamos que los contenidos sean de su agrado.</p><br></td></tr>
<% end if %>
	<tr><td align="center"><input type="submit" value="Aceptar" ></td></tr>
</table>
</form>
<% 
	response.End()
end sub %>

<% sub LicenciaEliminada() %>
<form action="" method="post" target="_self" >
<input type="hidden" name="frmAdminLogin" value="delcookie">
<table width="800" height="18" cellspacing="2" cellpadding="2" align="center">
	<tr bgcolor="#330066"><td  align="center"><b><font color="#FFFFFF">ATENCION LICENCIA ELIMINADA</font></b></td></tr>
	<tr> 
		<td align="center">
<br />
<p>Su ordenador ha sido identificado por PROPERTY WEB.</p>
<p><strong><%= ucase(request.Cookies("licencia")("n")) %></strong></p>
<p>En caso de duda p&oacute;ngase en contacto con la persona encargada de Property Web en su empresa,<br />o llame a Property Web ( 91.429.5143 )</p>
<p style="padding-bottom:18px;"><input type="submit" name="Volver" value="Volver a registrarse"></p>
		</td>
	</tr>
</table>
</form>
	<%
	response.end
end sub %>

<% sub LicenciaInvalida() %>
<form action="" method="post" target="_self" class="noMargin">
<input type="hidden" name="frmAdminLogin" value="delcookie">
<table width="800" height="18" cellspacing="2" cellpadding="2" align="center">
	<tr bgcolor="#330066"> 
		<td align="center">
	<b><font color="#FFFFFF">ATENCION: LICENCIA NO VALIDA</font></b>
		</td>
	</tr>
	<tr> 
		<td class="roj" align="center">
<br />
<p>Su ordenador ha sido identificado por PROPERTY WEB</p>
<p style="color:#FFFFFF;"><strong><%= ucase(request.Cookies("licencia")("n")) %></strong></p>
<p>Pero su licencia No es v&aacute;lida.</p>
<p>En caso de duda p&oacute;ngase en contacto con la persona encargada de Property Web en su empresa,<br />o llame a Property Web ( 91.429.5143 )</p>
<table border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td align="center"><input type="submit" name="Volver" value="Volver a registrarse" style="width:140px;"></td>
    <td width="100"></td>
    <td align="center"><input type="button" name="Cancelar" value="Cancelar" onclick="top.location='/';" style="width:140px;"></td>
  </tr>
</table>
<br />
		</td>
	</tr>
</table>
</form>
	<% response.end
end sub %>