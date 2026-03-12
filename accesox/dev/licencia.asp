<%
if request("act")="set" then
	u = request("u")
	p = request("p")
	
	client_id = request("client_id")
	user_id = request("user_id")
	
	n = request("n")
	movil = request("movil")
else
	u = request.Cookies("licencia")("u")
	p = request.Cookies("licencia")("p")
	
	client_id = request.Cookies("licencia")("client_id")
	user_id = request.Cookies("licencia")("user_id")
	
	n = request.Cookies("licencia")("n")
	movil = request.Cookies("licencia")("movil")
end if
%>
<li>u: [<%= client_id %>] <%= u %> (<%= p %>)</li>
<li>n: [<%= user_id %>] <%= n %></li>
<li>movil: <%= movil %></li>
<hr />
<li>.ComprobarLicencia: <%= session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %></li>
<%'= session("PW_WS").IniCliente(cstr(user_id), cstr(n), cstr(u), cstr(p), cstr(movil) ) %>
<hr />
Acci&oacute;n: <%= request("act") %>
<%
select case request("act")
case "del"
	'response.cookies("licencia").domain ="www.propertyweb.eu"
	response.cookies("licencia").domain ="propertyweb.eu"
	response.cookies("licencia").expires = "01/01/2000"
	'response.cookies("licencia")("p") = ""

case "set"
	response.cookies("licencia").domain = "propertyweb.eu"
	response.cookies("licencia").expires = date + 7
	response.cookies("licencia")("n") = n	'session("PW_WS").nombre
	response.cookies("licencia")("u") = u	'session("PW_WS").login
'	if movil<>"" then
		response.cookies("licencia")("movil") = movil
'	end if
	response.cookies("licencia")("p") = p	'session("PW_WS").password
	response.cookies("licencia")("client_id") = client_id	'session("PW_WS").ClienteId
	response.cookies("licencia")("user_id") = user_id	'session("PW_WS").ClienteUsuarioId
	response.cookies("licencia")("movil") = movil
	'response.cookies("licencia")("log") = "no_log"
	
end select

session.Abandon()

'Cach�		��??
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

if request("act")<>"" then %>
    <hr />
    <p>Licencia:</p>
    <% for each elto in request.Cookies("licencia") %>
        <li><%= elto %>: <%= request.Cookies("licencia")(elto) %>
    <% next 
end if %>
<li>.ComprobarLicencia: <%= session("pw_ws").ComprobarLicencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("movil"), request.Cookies("licencia")("user_id")) %></li>
