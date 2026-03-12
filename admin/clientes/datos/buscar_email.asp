<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")

sql = "SELECT email FROM contactos_email WHERE email LIKE '%" & request.QueryString("q") & "%' ORDER BY email"
call ListaDatos(sql)

set rsTmp=nothing


sub ListaDatos(pSQL)
	rsTmp.open pSQL, session("connPW")
	do while not rsTmp.eof
		%><%= rsTmp("email") %>|<%= rsTmp("email") %><%= vbcrlf %>
	<% rsTmp.movenext
	loop
	rsTmp.close
end sub
%>