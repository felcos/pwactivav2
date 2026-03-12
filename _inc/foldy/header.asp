<% 
resp = session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id"))
ini = session("PW_WS").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("user_id"), request.Cookies("licencia")("movil"))
%>
<link href="/_inc/foldy/header.css" rel="stylesheet" type="text/css">
<div class="cabecera" id="cabecera">
<% if request.Cookies("dev")<>"" then %><div class="informa_servidor"><br />ccc<!--#include virtual="/inc/dev/menu.asp" --></div><% end if %>
<img id="logo_pw" src="/img/logo_pw.png" onclick="window.location.href='/';"/>
</div>
