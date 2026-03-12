cookie CONFIG  (antes): <%= request.cookies("config") %>
<hr />
<b>.QueryString:</b>
<% for each elto in request.QueryString
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next %>
<hr />
<%
'swRedir = true
swRedir = false

if request.queryString("modo")="." then	
	response.cookies("config").domain = "propertyweb.eu"
	response.Cookies("config").Expires="01/01/2000"
	session("modo") = ""
	
else
	response.cookies("config").domain = "propertyweb.eu"
	response.cookies("config").Expires = Date+30
	
	if request.queryString("modo")<>"" then	
		response.cookies("config")("modo") = request.queryString("modo")
		session("modo") = request.queryString("modo")
		if request.queryString("modo")="dev" then	
			response.cookies("config")("base") = "foldy"
			response.cookies("config")("css") = "foldy"
			response.cookies("config")("nav") = "simple"
			response.Cookies("config")("leer_modal") = true
			
			
		end if
	end if
	if request.QueryString("set")<>"" then
		response.cookies("config")(request.QueryString("set")) = request.QueryString("val")
	end if
	
	
end if

'''''''''
'igual q en global.asa
select case session("modo")
case "old", "jm", "daniel", "foldy"
	session("leer_modal") = true
case else
	session("leer_modal") = false
end select

if request.Cookies("config")("leer_modal")<>"" then
	session("leer_modal") = request.Cookies("config")("leer_modal")
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
