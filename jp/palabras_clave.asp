<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>
<%
Server.ScriptTimeOut = 600
%>
<body>
Server.ScriptTimeOut: <%= Server.ScriptTimeOut %>
<hr />
<%
Set rs = Server.CreateObject("ADODB.Recordset")
sql = "SELECT * FROM NOTICIAS_INMOBILIARIAS"	' WHERE ID=37400"
rs.open sql, session("connPW")

'max = 0
max = 4000
%>
<table border="1" cellspacing="0" cellpadding="2">
  <tr>
    <td width="100">id</td>
    <td width="100">fecha</td>
    <td width="100">palabras clave</td>
  </tr>
<%
'for ii=1 to 1000
do while not rs.eof
  
  longit = len(rs("PALABRAS_CLAVES"))
  'if longit>max then
  	'max=longit
	%>
<tr>
    <td><%= rs("ID") %></td>
    <td><%= rs("FECHA_NOTICIA") %></td>
    <td><%= longit %></td>
</tr>
	<%

  
  rs.movenext
loop
'next %>
</table>
<%
rs.close
set rs=nothing

%>

</body>
</html>
