<%
'sql="UPDATE reg_accesos SET session_logout=GETDATE() WHERE session_id='" & session.SessionID & "'"
'session("connPWAcesos").execute sql

redir=request.ServerVariables("HTTP_REFERER")
'response.cookies("form").expires=now
if redir="" then 	redir = "/"
'if request.Cookies("dev")<>"" then redir = "/flash/"

session.Abandon()

'response.Redirect(redir)
%>
<p>Continuar</p>
<li><a href="<%= redir %>">volver a... <%= redir %></a></li>