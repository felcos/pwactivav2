<% if 1=2 then
set rsTmp = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=1" & r_pais & " AND NOMBRE LIKE '%" & request.QueryString("country") & "%'"
rsTmp.open sql, session("connPW")
do while not rsTmp.eof
	%><%= rsTmp("nombre") %>|<%= rsTmp("provincia") %><%= vbcrlf %>
<% rsTmp.movenext
loop
rsTmp.close
set rsTmp=nothing
end if
%>
{
"query": "n",
"suggestions": [
{ "value": "United Arab Emirates", "data": "AE" },
{ "value": "United Kingdom", "data": "UK" },
{ "value": "Spain", "data": "ES" },
{ "value": "United States", "data": "US" }
]
}