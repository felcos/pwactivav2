<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>jp</title>
<script type="text/javascript" src="/lib/jquery/jquery-1.7.2.min.js"></script>
</head>

<body>
<h1>test server [<%= session("pw_ws").ServidorWeb %>]</h1>
<h2><%= session.SessionID %> [<%= session("pw_ws").sessionid %>]</h2>

<h3>session('ws')</h3>
<ul>
	<li>.Host: <%= session("pw_ws").Host %></li>
	<li>.SessionId: <%= session("pw_ws").SessionId  %></li>
	<li>.UserAgent: <%= session("pw_ws").UserAgent %></li>

	<li>.Cookies: <%= session("pw_ws").Cookies %></li>
	<li>.CookieLicencia: <%= session("pw_ws").CookieLicencia %></li>
    
    <li>.IP: <%= session("pw_ws").IP %></li>
	<li>.Navegador: <%= session("pw_ws").Navegador %></li>
	<li>.Mozilla: <%= session("pw_ws").Mozilla %></li>
	
	<li>.Allhttps: <%= session("pw_ws").AllHttp %></li>
</ul>
<hr />
<ul>
	<li>.Licencia: <%= session("pw_ws").Licencia %> [<%= session("pw_ws").LicenciaId %>]</li>
	<li>.Cliente: <%= session("pw_ws").Cliente %> [<%= session("pw_ws").ClienteId %>]</li>
	<li>.AccesoActivo: <%= session("pw_ws").AccesoActivo %></li>
</ul>

<hr />
<ul>
	<li>.accesoDisponibilidad: <%= session("pw_ws").accesoDisponibilidad %></li>
	<li>.accesoInfoInmuebles: <%= session("pw_ws").accesoInfoEdificio %></li>
	
</ul>
<hr />
<%
str = ""
for each cookie in request.Cookies
	if str<>"" then str = str & ";"
	str = str & cookie & "="
	tmp = ""
	for each elto in request.Cookies(cookie)
		if tmp<>"" then tmp = tmp & "&"
		tmp = tmp & elto & "=" & request.Cookies(cookie)(elto)
	next
	str = str & tmp	
next
%>
<li>str: [<%'= str %>]</li>
<hr />
<%
SUB ANALIZA(vData)
    'mvarCookies = vData
    %>****<%
    tmp = vData & ";"
    %><li>tmp = <%= tmp %></li><%
	
    tmp = Mid(tmp, InStr(tmp, "licencia"))
	%><li>tmp = <%= tmp %></li><%
    tmp = Left(tmp, InStr(tmp, ";") - 1)
    %><li>tmp = <%= tmp %></li><%
	
    'mvarCookies = Replace(vData, mvarCookieLicencia, "")
	
    'mvarCookies = Replace(mvarCookies, ";;", ";")
    'If Left(mvarCookies, 1) = ";" Then mvarCookies = Mid(mvarCookies, 2)
    
    'mvarCookieLicencia = Mid(tmp, 10)
    %>****<%
End SUB

'ANALIZA(str)
%>
<li>mvarCookieLicencia: <%= mvarCookieLicencia %></li>
<li>mvarCookies: <%= mvarCookies %></li>

<h2>quotas</h2>

<p><a href="/pw_ws.asp">pw_ws</a></p>
<hr />
<%
xx = split(session("pw_ws").InformaQuotas(), vbcrlf)
for each elto in xx
	if elto<>"" then

		%><li><%= elto %></li><%
	end if
next
%>
<!--#include virtual="/jp/infobar.asp" -->

</body>
</html>
