<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<%
Dim res
Set res = jsObject()

res("request") = request.QueryString
res("initial_value") =  request.Cookies("config")(request.QueryString("set"))

if request.QueryString("config")="del" then
	response.cookies("config").domain = "propertyweb.eu"
	response.Cookies("config").Expires="01/01/2000"
	session("modo") = "normal"
	
else
	if request.QueryString("set")<>"" then
	
		response.cookies("config").domain = "propertyweb.eu"
		response.cookies("config").Expires = Date+365
		
		response.cookies("config")(request.QueryString("set")) = request.QueryString("val")
		session(request.QueryString("set")) = request.QueryString("val")
	else
		
	end if
end if

res("value") =  request.Cookies("config")(request.QueryString("set"))

res.Flush
%>