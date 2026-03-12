cookie DEV  (antes):
<% for each elto in request.Cookies("dev")
	%><li><%= elto %>: <%= request.Cookies("dev")(elto) %></li><%
next %>
<hr />
.QueryString: 
<% for each elto in request.QueryString
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next %>
<hr />
.Form: 
<% for each elto in request.Form
	%><li><%= elto %>: <%= request.Form(elto) %></li><%
next %>
<hr />
<%

redir=request.ServerVariables("HTTP_REFERER")
swRedir = true
'swRedir = false

select case request.QueryString("act")
case "crear"			
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev").Expires = Date + 7
	response.cookies("dev")("mode") = "dev"
	response.cookies("dev")("css") = "bs"
	response.cookies("dev")("sql") = "mostrar"
	response.cookies("dev")("request") = "mostrar"
	'response.cookies("dev")("log") = "no"
	
case "eliminar"			
	response.cookies("dev").domain = "propertyweb.eu"
	response.Cookies("dev").Expires="01/01/2000"

case "mostrar_menu"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("menu") = "mostrar"	
case "ocultar_menu"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("menu") = ""


case "mostrar_sql"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("sql") = "mostrar"	
case "ocultar_sql"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("sql") = ""

case "mostrar_request"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("request") = "mostrar"	
case "ocultar_request"		
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("request") = ""
	
case "log"
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("log") = ""
	
case "no_log"
	response.cookies("dev").domain = "propertyweb.eu"
	response.cookies("dev")("log") = "no"	
	
case else
	swRedir = false
end select

if swRedir then	response.Redirect(redir)
%>
<strong>EJECUTADO.</strong>
<hr />
cookie DEV (despu&eacute;s):
<% for each elto in request.Cookies("dev")
	%><li><%= elto %>: <%= request.Cookies("dev")(elto) %></li><%
next %>
<hr />
<p><a href="<%= redir %>">continuar a... <%= redir %></a></p>
