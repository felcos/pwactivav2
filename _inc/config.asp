cookie CONFIG  (antes): <%= request.cookies("config") %>
<hr />
<%
swRedir = true
'swRedir = false

for each elto in request.QueryString
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next %>
<hr />
<%

if request.queryString("modo")="." then	
	response.cookies("config").domain = "propertyweb.eu"
	response.Cookies("config").Expires="01/01/2000"
	session("modo") = ""
	response.Cookies("modo")=""
	
else
	response.cookies("config").domain = "propertyweb.eu"
	response.cookies("config").Expires = Date+30
	
	if request.queryString("modo")<>"" then	
		response.cookies("config")("modo") = request.queryString("modo")
		session("modo") = request.queryString("modo")
		response.Cookies("modo")=session("modo")
		
		select case request.queryString("modo")
		case "dev"
			response.cookies("config")("base") = "foldy"	' foldy
			response.cookies("config")("css") = "squared"	' foldy | squared
			response.cookies("config")("nav") = "jetmenu"	' simple | jetmenu
		end select
		
	end if
	
	if request.QueryString("set")<>"" then
		response.cookies("config")(request.QueryString("set")) = request.QueryString("val")
		
		if request.queryString("set")="css" and request.queryString("val")="javier"  then
			'response.cookies("config")("footer") = "ocultar"
			response.cookies("config")("nav") = "jetmenu"
		end if
		
	end if
	
	
end if

'''''''''
'igual q en global.asa
if request.Cookies("config")("leer")="" then
	select case session("modo")
	case "old", "jm", "daniel", "foldy"
		session("leer_modal") = true
	
	case "dev"
		if request.Cookies("config")("css")="foldy" then 
			session("leer_modal") = true
		else
			session("leer_modal") = false
		end if
		
	case else
		session("leer_modal") = false
	end select
	
else
	session("leer_modal") = true	'request.Cookies("config")("leer")
end if
''''''''''


'redir = "/inc_modo.asp"
redir = request.ServerVariables("HTTP_REFERER")
if redir="" then redir = "/"

if swRedir then response.Redirect(redir)
%>
<strong>EJECUTADO.</strong>
<hr />
cookie CONFIG (despu&eacute;s): <%= request.cookies("config") %>
<hr />
<p><a href="<%= redir %>">continuar a... <%= redir %></a></p>
