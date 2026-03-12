<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>{
    "data": [
<%
Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM clientes_control WHERE (activo=1)"	
rs.Open sql, session("connPWAcesos")

nn = 0

do while not rs.eof 
	nn=nn+1
%><% if nn>1 then %>, <% end if %>{
"name": "<%= rs("NOMBRE_EMPRESA") %>",
"position": "<%= rs("EMPRESA") %>",
"salary": "<%= rs("LICENCIAS_ENVIADAS") %>",
"start_date": "<%= rs("NUM_LICENCIAS") %>",
"office": "<%= rs("ultimo_acceso") %>",
"extn": "<%= rs("ID") %>"
}<% 
	rs.movenext
loop

rs.close
set rs=nothing
%>
    ]
}