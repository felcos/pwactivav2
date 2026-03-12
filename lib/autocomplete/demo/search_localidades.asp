<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
set rsTmp = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=1" & r_pais & " AND NOMBRE LIKE '%" & request.QueryString("q") & "%'"
rsTmp.open sql, session("connPW")
do while not rsTmp.eof
	%><%= rsTmp("nombre") %>|<%= rsTmp("provincia") %><%= vbcrlf %>
<% rsTmp.movenext
loop
rsTmp.close
set rsTmp=nothing
%>