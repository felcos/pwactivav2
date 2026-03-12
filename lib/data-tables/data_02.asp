<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>{
    "data": [<%
Set rs = Server.CreateObject("ADODB.Recordset")

if request.Form = "" then 
	sql = "SELECT TOP(5) * FROM clientes_control WHERE (activo=1)"	
else
	sql = "SELECT * FROM clientes_control WHERE (activo=1)"	
end if
rs.Open sql, session("connPWAcesos")

nn = 0

do while not rs.eof 
	nn=nn+1
%><% if nn>1 then %>, <% end if %> [
"<%= rs("ID") %>",
"<%= rs("NOMBRE_EMPRESA") %>",
"<%= rs("EMPRESA") %>",
"<%= rs("LICENCIAS_ENVIADAS") %>",
"<%= rs("NUM_LICENCIAS") %>",
"<%= rs("ultimo_acceso") %>"
]<% 
	rs.movenext
loop

rs.close
set rs=nothing
%>
    ]
}