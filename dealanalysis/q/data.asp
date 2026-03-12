<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%><%
set rsTmp = Server.CreateObject("ADODB.Recordset")

query = request.QueryString("query")
pais = request.QueryString("pais")
prov = request.QueryString("prov")

sugg = ""
data = ""

sqlw = "id_pais=" & pais
if cint(pais)=1 and prov<>"" then
	sqlw = sqlw & " AND id_provincia=" & prov
end if

sql = "SELECT * FROM C_LOCALIDADES WHERE " & sqlw & " AND NOMBRE LIKE '" & query & "%' ORDER BY NOMBRE"
rsTmp.open sql, session("connPW")
do while not rsTmp.eof
	if sugg<>"" then sugg = sugg & ", "
	sugg = sugg & "'" & lcase(rsTmp("nombre")) & "'"
	
	if data<>"" then data = data & ", "
	data = data & "'" & rsTmp("id") & "'"
	
	rsTmp.movenext
loop
rsTmp.close

sql = "SELECT * FROM C_LOCALIDADES WHERE " & sqlw & " AND (NOMBRE LIKE '%" & query & "%' AND NOMBRE NOT LIKE '" & query & "%') ORDER BY NOMBRE"
rsTmp.open sql, session("connPW")
do while not rsTmp.eof
	if sugg<>"" then sugg = sugg & ", "
	sugg = sugg & "'" & lcase(rsTmp("nombre")) & "'"
	
	if data<>"" then data = data & ", "
	data = data & "'" & rsTmp("id") & "'"
	
	rsTmp.movenext
loop
rsTmp.close

set rsTmp=nothing
%>{
query:'<%= request.QueryString("query") %>',
suggestions: [<%= sugg %>],
data: [<%= data %>]
}