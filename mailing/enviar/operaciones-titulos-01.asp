<!DOCTYPE html>
<html lang="es">
<head>
<link rel="stylesheet" href="/mailing/flash/mailing.css" type="text/css" media="all" />
<link rel="stylesheet" href="/mailing/mailing_flash_jm.css" type="text/css" media="all" />

<%
'on error resume next
enlace_base = "https://www.propertyweb.eu/articulos/"

if request.QueryString("f")="" then 
	pFecha=date
	'response.Write("Falta f=FECHA<hr>")
else
	pFecha=request.querystring("f")
end if

select case weekday(pFecha)
case 1
	txtFecha = "domingo"
case 2
	txtFecha = "lunes"
case 3
	txtFecha = "martes"
case 4
	txtFecha = "mi&eacute;rcoles"
case 5
	txtFecha = "jueves"
case 6
	txtFecha = "viernes"
case 7
	txtFecha = "s&aacute;bado"
end select
txtFecha = FormatDateTime(pFecha, 1)
%>
<title>Property Web Flash - <%= pFecha %></title>
</head>
<!-- include virtual="/inc/reg_accesos.asp" -->
<!-- include virtual="/lib/funciones.asp" -->
<!--#include virtual="/flash/lib.asp" -->
<!--#include virtual="/mailing/flash/lib.asp" -->
<body>
<div id="centrado">
<div id="cabecera_mailin"><img src="/img/flash/cabecera_mailing.png" border="0" usemap="#Map">
  <map name="Map">
	<area shape="rect" coords="-7,5,370,127" href="https://www.propertyweb.eu">
    <area shape="rect" coords="458,50,506,100" href="https://www.propertyweb.eu/actualidad/">
    <area shape="rect" coords="506,50,549,100" href="https://www.propertyweb.eu/dealanalysis/">
    <area shape="rect" coords="549,50,594,100" href="https://www.propertyweb.eu/demandas/">
    <area shape="rect" coords="594,50,636,100" href="https://www.propertyweb.eu/vencimientos/">
    <area shape="rect" coords="635,50,683,100" href="https://www.propertyweb.eu/estudios/">
    <area shape="rect" coords="682,50,728,100" href="https://www.propertyweb.eu/info/">
    <area shape="rect" coords="727,50,772,100" href="https://www.propertyweb.eu/info/">
    <area shape="rect" coords="771,50,815,100" href="https://www.propertyweb.eu/subastas/">
    <area shape="rect" coords="815,50,858,100" href="https://www.propertyweb.eu/info/">
    <area shape="rect" coords="858,50,902,100" href="https://www.propertyweb.eu/inversores/">
  </map>
</div>
<% if 1=2 then %>
<div id="publi_mailing">
	<img src="/img/flash/publi_mailing.jpg">
</div>
<% else %>
<div class="caja_ancha" style="background-color:#ffffff;">

<div class="txt_h3" style="margin-left:10px;margin-bottom:5px;margin-top:5px;font-family: Tahoma, Geneva, sans-serif;font-size:18px;line-height:28px; color:#979797;">
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:14px;left:3px;"><span style="color:#2b4e61;font-size:26px;">PW</span>&nbsp;
es el <span style="color:#2b4e61;">"Google Inmobiliario"</span> y un contacto central entre todos los <span style="color:#2b4e61;">&quot;players&quot;</span> 
en el mercado espa&ntilde;ol.</div>

<div class="txt_h3" style="margin-left:10px;margin-bottom:5px;margin-top:5px;font-family: Tahoma, Geneva, sans-serif;font-size:18px;line-height:28px; color:#979797;">
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:11px;left:3px;"><span style="color:#2b4e61;font-size:26px;">PW</span>&nbsp;
es el registro no oficial de las transacciones en el mercado inmobiliario terciario de Espa&ntilde;a desde 1990.</div>

<div class="txt_h3" style="margin-left:10px;margin-bottom:5px;margin-top:5px;font-family: Tahoma, Geneva, sans-serif;font-size:18px;line-height:28px; color:#979797;">
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:11px;left:3px;"><span style="color:#2b4e61;font-size:26px;">PW</span>&nbsp;
es el registro de edificios, centros comerciales, hoteles, etc... con hist&oacute;rico desde 1990.</div>

</div>
<% end if %>

<form method="post" action="https://www.propertyweb.eu/articulos/" target="_blank">
<div class="seccion">
<div class="seccion_tit" style="margin-bottom:32px; border-bottom:1px solid #e1e1e1;">
	<p style="margin-top:4px; margin-bottom:4px;"><strong>Operaciones de Inversi&oacute;n en Espa&ntilde;a</strong><span style="font-size:20px; margin-left:150px;">agosto 2015</span></p>
	<p style="margin:8px 0 8px 12px; font-size:18px;">Por si te has perdido algo en agosto...</p>
</div>
<%' Operaciones	
bloque="ope"
strin="ope"	
ErrMesage=""
num_titulo=0
apart= ""

SQL_SELECT = "SELECT ID, TITULO, TITULO_PT AS TITULO_AUX, FECHA_ACTUALIZACION, seccion AS APARTADO, ID_TIPO_OPERACION, TIPOOPERACION "
SQL_SELECT = SQL_SELECT & "FROM C_OPERACIONES "

SQL_WHERE = " WHERE "

SQL_WHERE = SQL_WHERE & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) AND "

SQL_WHERE = SQL_WHERE & "(FECHA_PUBLICACION >= CONVERT(DATETIME, '01/08/2015', 103) AND "
SQL_WHERE = SQL_WHERE & "FECHA_ACTUALIZACION <= CONVERT(DATETIME, '31/08/2015', 103)) "	

SQL_ORDER = "ORDER BY seccion "
%>
<% 'nacional			
SQL = SQL_SELECT & SQL_WHERE & "AND web_es <> 0 AND id_pais=1 " & SQL_ORDER

test_inyeccion_sql sql
resultado.Open sql, session("connPW") %>
<div class="ubicacion">
<% apart=""
do while not resultado.EOF
	'if 1=2 then
	if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then 
		%><div class="apartado"><img src="/img/flash/apunta.gif"><strong>&nbsp;<%= resultado("APARTADO") %></strong></div><%
	end if
	'end if
	apart=resultado("APARTADO")
	num_titulo=num_titulo+1
	enlace = enlace_base & "?" & strin & "=" & resultado("ID") & "&origen=DailyFlash&f=" & pFecha
	%>
    <div class="articulo"><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>">&nbsp;<a href="<%= enlace %>" target="_blank"><% Titulo(resultado) %></a></div>
    	<% resultado.movenext
loop %>
	</div>
<% resultado.close %>
<div class="ubicacion_separador"></div>

</div>


<div style="clear:both;"></div>
<input type="submit" id="btn_suscribete" name="submit" value="Leer art&iacute;culos seleccionados">
</form>


<div><!--#include virtual="/mailing/flash/footer.asp" --></div>
</div>

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