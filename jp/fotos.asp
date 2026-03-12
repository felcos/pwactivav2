<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>

<body>
<%
dim fso
set fso = CreateObject("Scripting.FileSystemObject")

set rs = Server.CreateObject("ADODB.recordset")

sql = "SELECT * FROM inmuebles WHERE id=820"
rs.Open sql, session("connPW")

fotos = split(rs("fotos"), "&")

response.Write("<p>" & rs("fotos") & "</p>")

rs.close
set rs=nothing

%>

<table>
<%

for ii=0 to ubound(fotos)
	if fotos(ii)<>"" then
		
		img = fotos(ii)
		
		archivo = fotos(ii)
		
		
		ruta = server.MapPath("/fotos/inmuebles/") & "\" 
		ruta_f = "/fotos/inmuebles/"
		
		my_num = Int((rnd*1000))
		
		img = "/lib/showThumb.aspx?maxsize=100&amp;img=" & ruta_f & archivo & "&amp;rnd=" & my_num
		'img = ruta_f & archivo
		
		set arch = fso.GetFile(ruta & archivo)
		set myImg = loadpicture(ruta & archivo)
		
		'onclick="amplia('//<%= archivo % >a.jpg');"
		'antes = fso.FileExists(ruta & archivo & "a.jpg")
		%>
<tr>
	<td>
    	<li><%= archivo %></li>
    	<li><%= round(myImg.width / 26.4583) %> x <%= round(myImg.height / 26.4583) %></li>
        <li><%= formatnumber(arch.Size/1024, 1) %> KB</li>
    </td>
	<td><img src="<%= img %>" /></td>
</tr>
	<% end if
next


%>
</table>


</body>
</html>
