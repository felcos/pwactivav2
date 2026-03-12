<% 
'session("IniCliente") = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
%>
<div class="cabecera" id="cabecera">
	<img id="logo_pw" src="/img/logo_pw.png" onclick="window.location.href='/';"/>
	<div style="clear:both;"></div>
</div>