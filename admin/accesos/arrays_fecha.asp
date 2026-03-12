<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
fecha = request.QueryString("f")
if fecha="" then fecha="08/09/2015"

Set rs = Server.CreateObject("ADODB.Recordset")
Set rsArt = Server.CreateObject("ADODB.Recordset")

'reg_articulos
sql = "SELECT top(25) * FROM reg_articulos WHERE fecha='" & fecha & "'"	' ORDER BY hora"
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos")	', 1, 1	
%>
{
    "data": [
        
<% 
ops=""
nn=0
ocultas=0

cargadas = "#"

do while not rs.eof 
	elemento = rs("id_licencia") & "-" & rs("articulo_tipo") & rs("articulo_id") & "#"
	
	if instr(cargadas, "#" & elemento) then
		ver_fila=false
	else
		ver_fila=true
		cargadas = cargadas & elemento
	end if
	
	'if ver_fila then
	'	titulo = "ver"
	'else
	'	ocultas = ocultas + 1
	'	titulo = "[" & ocultas & "]"
	'end if
	'ver_fila=true
	
	if ver_fila then
		nn=nn+1
		
		select case rs("articulo_tipo")
		case "not", "rum", "est", "dem"
			sqlArt = "SELECT * FROM NOTICIAS_INMOBILIARIAS WHERE ID=" & rs("articulo_id")
		case "ope"
			sqlArt = "SELECT * FROM OPERACIONES WHERE ID=" & rs("articulo_id")
		case else
			'titulo = ""
		end select
		
		rsArt.Open sqlArt, session("connPW")
		titulo = rsArt("titulo")
		rsArt.close
		
		titulo = replace(titulo, """", "&quot;")
		
		articulo = rs("articulo_tipo") & " " & rs("articulo_id")
		hora = mid(rs("hora"), instr(rs("hora"), " ")+1, len(rs("hora"))) 
		
		%>
		<% if nn>1 then %>
		,
		<% end if %>
		[
			"<%= nn %>",
			"<%= hora %>",
			"<%= articulo %>",
			"<%= rs("licencia") %> (<%= rs("id_licencia") %>)",
			"<%= rs("cliente") %> (<%= rs("id_cliente") %>)",
			"<%= titulo %>"
		]
	<% end if
	rs.movenext
loop %>
        
    ]
}
<%
rs.close

set rs=nothing
set rsArt=nothing
%>