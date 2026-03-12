<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
Server.ScriptTimeOut=30

on error resume next

if request.QueryString="" then 
	%><p>sin datos</p><% 
	response.End()
end if

'fecha
varFecha = request.QueryString("fecha")
if not isdate(varFecha) then 
	%><p>Fecha incorrecta(<%= varFecha %>)</p><%
	response.End()
end if

'from
varFrom = request.QueryString("from")

'destinatarios
varDest = request.QueryString("dest")
if varDest = "" then
	%>Falta destinatario<%
	response.End()
end if 

'página y asunto
select case request.QueryString("pag")
case "flash"
	varURL = "https://www.propertyweb.eu/mailing/flash.asp?f=" & varFecha
	varAsunto = "Property Web Flash ESPAÑA - " & varFecha & " - www.propertyweb.eu"
case "easy"
	varURL = "https://www.propertyweb.eu/mailing/easy/envio.asp?fecha=" & varFecha & "&pag=EasyProperty&R1=EasyProperty"
	varAsunto = "Anuncios EasyProperty ESPAÑA - " & varFecha & " - www.easyproperty.es"
case "pda"
	varURL = "https://www.propertyweb.eu/mailing/p/pagsum.asp?R1=" & varFecha & "&pag=PDA"
	varAsunto = "Contenidos Property Web ESPAÑA - " & varFecha & " - www.propertyweb.eu"
case "report"
	varURL = "https://www.propertyweb.eu/mailing/report.asp?f=" & varFecha
	varURL = varURL & "&internacional=1&actualidad=1&subastas=1&rumores=1&demandas=1&estudios=1&vencimientos=1&operaciones=1"
	varAsunto = "www.propertyweb.eu - " & FormatDateTime(varFecha, 1)
	
	
case "old"
	varURL = "https://www.propertyweb.eu/mailing/flash/flash.asp?f=" & varFecha
	varAsunto = "Property Web Flash ESPAÑA - " & varFecha & " - www.propertyweb.eu"
	
case "design_modelo"
	varURL = "https://www.propertyweb.eu/_inc/javier/newsletter/mail-disponibilidad.html"
	varAsunto = "Nueva Disponibilidad de Oficinas en Property Web - www.propertyweb.eu"
	
	
	
	
case "test"
	'varURL = "https://www.propertyweb.eu/jp/email/antwort/two-cols-simple/build.html"
	varURL = "https://www.propertyweb.eu/jp/email/flash.asp"
	varAsunto = "Property Web - TEST MAILING - " & FormatDateTime(varFecha, 1)

case "operaciones"
	varURL = "https://www.propertyweb.eu/mailing/operaciones/testa.asp"
	varAsunto = "Property Web - Operaciones de Locales"
	

case "disponibilidad2"
	varURL = "https://www.propertyweb.eu/mailing/newsletter/disponibilidad02/mail.html"
	varAsunto = "Property Web - Te ayudamos a buscar disponibilidad ??"
	
case else
	%>PARAMETRO MAL: pag<%
	response.End()
end select

'email
Dim myMail
Set myMail = CreateObject("CDO.Message") 

'This section provides the configuration information for the remote SMTP server.
myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserver") ="smtp.propertyweb.eu"
myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60

myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication

select case varFrom
case "pw"
	myMail.From = "Property Web <pw@propertyweb.eu>"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="mbm908c"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="AJBv.wNU3ySGiu9"
case else
	myMail.From = "informatica@propertyweb.eu"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="lcf013c"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="AJBv.wNU3ySGiu9"
end select

myMail.Configuration.Fields.Update

myMail.To = varDest
myMail.Subject = varAsunto	'"this is the subject"
	 
'myMail.TextBody = "this is the body"
'myMail.HTMLBody = "<h1>test</h1><p>" & varURL & "</p>"

'myMail.CreateMHTMLBody "https://propertyweb.eu/mailing/test.htm"
'response.Write(varURL)
'response.End()

myMail.CreateMHTMLBody varURL

'if Error<>"" then
	myMail.Send
'end if

if Err <> 0 then 
	%>ERROR: <a href="<%= varURL %>" target="_blank"><%= Err.description %></a><%
else 
	%>mail enviado correctamente<br /><li><%= varDest %></li><%
end if
	 
Set myMail = Nothing 
%>

