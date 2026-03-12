<%
'crear = true
crear = false

eliminar = true
'eliminar = false

if crear then
	response.cookies("licencia").domain = "propertyweb.eu"
	response.cookies("licencia").expires = date + 365
	response.cookies("licencia")("n") = "informatica@propertyweb.eu"	'session("PW_WS").nombre
	response.cookies("licencia")("u") = "JP"	'session("PW_WS").login
	response.cookies("licencia")("p") = "JP"	'session("PW_WS").password
	response.cookies("licencia")("client_id") = 1	'session("PW_WS").ClienteId
	response.cookies("licencia")("user_id") = 19234	'session("PW_WS").ClienteUsuarioId
	response.cookies("licencia")("movil") = "0"	
end if

if eliminar then
	'response.cookies("licencia").domain ="www.propertyweb.eu"
	response.cookies("licencia").domain ="propertyweb.eu"
	response.cookies("licencia").expires = "01/01/2000"
	'response.cookies("licencia")("p") = ""
end if


'Caché		¿¿??
'Response.Expires = 0
'Response.Expiresabsolute = #1/1/2000 10:00:00#
'Response.AddHeader "pragma","no-cache"
'Response.AddHeader "cache-control","private"
'Response.CacheControl = "no-cache"


'Response.Cookies("licencia")("n") = ""
'Response.Cookies("licencia")("u") = ""
'Response.Cookies("licencia")("p") = ""
'Response.Cookies("licencia")("client_id") = ""
'Response.Cookies("licencia")("user_id") = ""

%>
<p>Licencia:</p>
<% for each elto in request.Cookies("licencia") %>
	<li><%= elto %>: <%= request.Cookies("licencia")(elto) %>
<% next %>
<hr />
<li>.IniCliente: <%= session("PW_WS").IniCliente(request.Cookies("licencia")("user_id"), request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("movil")) %></li>
<li>.Comprobar_Licencia: <%= session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %></li>
