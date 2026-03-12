<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
if request.QueryString("p")="" then
	r_pais="1"
else
	r_pais=request.QueryString("p")
end if

set rsTmp = Server.CreateObject("ADODB.Recordset")
if r_pais="1" then
	sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=1 AND NOMBRE LIKE '" & request.QueryString("q") & "%' ORDER BY NOMBRE"
	call ListaDatos(sql)
	sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=1 AND NOMBRE LIKE '%" & request.QueryString("q") & "%' AND NOT(NOMBRE LIKE '" & request.QueryString("q") & "%') ORDER BY NOMBRE"
	call ListaDatos(sql)
else
	sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=" & r_pais & " AND NOMBRE LIKE '%" & request.QueryString("q") & "%' ORDER BY NOMBRE"
	call ListaDatos(sql)
end if
set rsTmp=nothing


sub ListaDatos(pSQL)
	rsTmp.open pSQL, session("connPW")
	do while not rsTmp.eof
		%><%= rsTmp("nombre") %>|<%= rsTmp("id") %><%= vbcrlf %>
	<% rsTmp.movenext
	loop
	rsTmp.close
end sub
%>