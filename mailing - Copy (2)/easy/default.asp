<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- #include virtual="/mailing/easy/lib_easy.asp" -->
<% 'On Error Resume Next
Set rs = Server.CreateObject("ADODB.Recordset")

public hoy
if request.QueryString("fecha")="" then
	hoy=formatdatetime(now(),2)
else
	if isdate(request.QueryString("fecha")) then
		hoy=formatdatetime(request.QueryString("fecha"), 2)
	else
		hoy=formatdatetime(now(),2)
	end if
end if
%>
<title>Novedades EasyProperty <%= hoy %> - www.easyproperty.es</title>
<style type="text/css">
<!--
-->
</style>
<script type="text/JavaScript">
<!--
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

MM_preloadImages(
	'/mailing/easy/cabecera.gif',
	'/mailing/easy/bottom/top.gif',
	'/mailing/easy/bottom/contents.gif',
	'/mailing/easy/bottom/bottom.gif',
	
	'/mailing/easy/publicidad/top.gif',
	'/mailing/easy/publicidad/bottom.gif',
	
	'/mailing/easy/publicidad/showtime.gif',
	'/mailing/easy/publicidad/propertyweb.gif',
	'/mailing/easy/publicidad/t4ac.gif',
	'/mailing/easy/publicidad/thecomcom.gif'
	
	);

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
</head>
<body>
<% 
if request.QueryString("fecha")="" then
	FechaI=date()
	FechaF=date()
else
	FechaI=request.QueryString("fecha")
	FechaF=request.QueryString("fecha")
end if
	
sql = "SELECT * FROM anuncios_envio "
sql = sql & "WHERE ("

sql = sql & "(web_es<>0) AND ("
sql = sql & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"
sql = sql & " OR "
sql = sql & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) "
sql = sql & "OR "
sql = sql & "NOT(FechaVisibleHasta < CONVERT(DATETIME, '" & FechaI & "', 103) OR FechaVisibleDesde > CONVERT(DATETIME, '" & FechaF & "', 103)) "
sql = sql & ")"
sql = sql & ") ORDER BY id_seccion, id_pais, provincia desc"

test_inyeccion_sql sql
rs.Open sql, session("connPW")
', 1,1
'response.Write(rs.source)
%>
<!-- Resultados -->
<link href="/mailing/easy/style.css" rel="stylesheet" type="text/css">
<table border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><img src="/mailing/easy/cabecera.gif"></td>
  </tr>
  <tr>
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="4">
  <tr>
    <td valign="top" align="center">
<!-- Tabla Contenidos : INI -->
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<% do while not rs.EOF
	num_titulo=num_titulo+1
	id_anuncio=rs("secc") & "=" & rs("ID")
	'enlace = "https://" & request.ServerVariables("SERVER_NAME") & "/navegar/reenvio.asp?" & id_anuncio & "&origen=anuncios"
	'enlace2= "https://" & request.ServerVariables("SERVER_NAME") & "/anuncios/ver.asp?" & id_anuncio & "&origen=anuncios"
	'enlace_easy = "https://www.propertyweb.eu/mailing/easy/mostrar.asp?" & id_anuncio & "&origen=easyproperty"
	enlace_easy = "https://www.easyproperty.es/ofertas/?id=" & rs("id") & "&origen=mailing_pw"
		
	dd=rs("dir")
	verDir=rs("localidad")
	if rs("localidad")<>rs("provincia") then verDir=verDir & " (" & rs("provincia") & ")"
	
	if rs("precio_eur")=0 then
		calcPrecio="N/D"
	else
		calcPrecio=FormatNumber(rs("PRECIO_EUR"),0) & "&nbsp;" & rs("TIPOPRECIO")
		calcPrecio=replace(calcPrecio,"M2","m&sup2;")
		calcPrecio = lcase(calcPrecio) 
		' " &euro;"
	end if
	%>
    <tr><td><% FichaAnuncio(rs) %></td></tr>
	<% 'iteraciones	
	rs.movenext
loop 
%>
</table>
<!-- Tabla Contenidos : FIN -->
    </td>
    <td valign="top" align="center" width="159">
<!-- Tabla Publicidad : INI -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td><img src="/mailing/easy/publicidad/top.gif" border="0"></td></tr>
<tr><td><a href="https://www.its-showtime.es" target="_blank"><img src="/mailing/easy/publicidad/showtime.gif" border="0" title="It's ShowTime" alt="It's ShowTime"></a></td></tr>
<tr><td><a href="https://www.propertyweb.eu" target="_blank"><img src="/mailing/easy/publicidad/propertyweb.gif" border="0" title="PropertyWeb" alt="PropertyWeb"></a></td></tr>
<tr><td><a href="https://www.t4ac.es" target="_blank"><img src="/mailing/easy/publicidad/t4ac.gif" border="0" title="Time For A Change" alt="Time For A Change"></a></td></tr>
<tr><td><a href="https://www.thecomcom.com" target="_blank"><img src="/mailing/easy/publicidad/thecomcom.gif" border="0" title="The Complete Communication Company" alt="The Complete Communication Company"></a></td></tr>
<tr><td><img src="/mailing/easy/publicidad/bottom.gif" border="0"></td></tr>
</table>
<!-- Tabla Publicidad : FIN -->
    </td>
  </tr>
</table>
    </td>
  </tr>
  <tr>
    <td>
<!-- Tabla Pie : INI -->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr><td><img src="/mailing/easy/bottom/top.gif"></td></tr>
    <tr><td background="/mailing/easy/bottom/contents.gif"><% call info_pie %></td></tr>
    <tr><td><img src="/mailing/easy/bottom/bottom.gif"></td></tr>
</table>
<!-- Tabla Pie : FIN -->
    </td>
  </tr>
</table>
<!-- Resultados : FIN-->
<%
rs.Close
%>
</body>
</html>
<% sub test_inyeccion_sql(rSql)	
	cPasa=true
	crSql=lcase(rSql)
	
	if instr(crSql, "declare") then cPasa=false
	if instr(crSql, "update") then cPasa=false
	if instr(crSql, "chr(") then cPasa=false
	if instr(crSql, "http") then cPasa=false
	
	if not(cPasa) then
		
		sqlReg = "INSERT INTO ataques (session_id, fecha, hora, ip, querystring, form, cookie_pw, cookie_licencia, referer) VALUES ("
		sqlReg = sqlReg & "'" & session.SessionID & "', '" & date & "', '" & time & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("REMOTE_ADDR") & "', "
		
		sqlReg = sqlReg & "'" & AcomodaTexto(request.QueryString) & "', "
		sqlReg = sqlReg & "'" & AcomodaTexto(request.Form) & "', "

		sqlReg = sqlReg & "'" & request.Cookies("pw") & "', "
		sqlReg = sqlReg & "'" & request.Cookies("licencia") & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("HTTP_REFERER") & "'"
		
		sqlReg = sqlReg & ")"
		
		session("connPWAcesos").execute sqlReg
		
		'configurar servidor email 
		Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = "smtp.propertyweb.eu"
		Mail.Port = 25 
		Mail.Username = "lcf013c"
		Mail.Password = "PWeu08"
		
		'Variables Mail  
		Mail.From = "informatica@propertyweb.eu"
		Mail.FromName = "Servidor NAVIA"
		
		Mail.AddAddress "informatica@propertyweb.eu", "jp"
		Mail.Subject = "Aviso de Ataque SQL"
	
		'Mail 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Se ha detectado un ataque SQL.</p>" & "<br>"
		txtMail = txtMail & "<p>" & date & " " & time & "</p>"
		txtMail = txtMail & "<p>REMOTE_ADDR: " & request.ServerVariables("REMOTE_ADDR") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>HTTP_REFERER:<br>" & request.ServerVariables("HTTP_REFERER") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>QueryString:<br>" & request.QueryString & "</p>" & "<hr>"
		txtMail = txtMail & "<p>Form:<br>" & request.Form & "</p>" & "<hr>"
		txtMail = txtMail & "</BODY></HTML>"
		
		Mail.Body = txtMail
		Mail.IsHTML = True
		
		'Enviar 
		On Error Resume Next
		Mail.Send 
		
		response.End()
	end if
	
end sub %>