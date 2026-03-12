<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
if request.QueryString="" then 
	%><p>sin datos</p><% 
	response.End()
end if

for each elto in request.QueryString
	%><li><%= elto %>: <%= request.QueryString(elto) %></li><%
next
 
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
case "pw"
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
	
	'Asunto
	Select Case DatePart("w", varFecha, vbMonday)
	Case "1"
		varAsunto = "lunes "
	Case "2"
		varAsunto = "martes "
	Case "3"
		varAsunto = "miércoles "
	Case "4"
		varAsunto = "jueves "
	Case "5"
		varAsunto = "viernes "
	End Select
	varAsunto = "www.propertyweb.eu - " & varAsunto & varFecha	'Format(varFecha, "dd/mm/yyyy")

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
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="pweu9907"
case else
	myMail.From = "informatica@propertyweb.eu"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="lcf013c"
	myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="PWeu08"
end select

myMail.Configuration.Fields.Update

myMail.To = varDest
myMail.Subject = varAsunto	'"this is the subject"
	 
'myMail.TextBody = "this is the body"
'myMail.HTMLBody = "<h1>test</h1><p>this is the body</p>"
'myMail.CreateMHTMLBody "https://propertyweb.eu/mailing/test.htm"
myMail.CreateMHTMLBody varURL


'if Error<>"" then
	myMail.Send
'end if

if Err <> 0 then 
	%>ERROR: <%= Err.description %><%
else 
	%>
	Mail enviado (<%= varDest %>)
	<li><a href="<%= varURL %>" target="_blank"><%= varAsunto %></a></li>
	<%
end if
	 
Set myMail = Nothing 

%>

