<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html lang="es">
<head>
	<!-- meta http-equiv="Content-Type" content="text/html; charset=UTF-8" /-->
	<link rel="stylesheet" href="/_inc/jm/reset.css" media="all" />
	<link rel="stylesheet" href="/_inc/jm/global.css">
	<link rel="stylesheet" href="/_inc/jm/estilos.css" type="text/css">
    
	<title>PropertyWeb contacto</title>
    
    <!--#include virtual="/inc/js.asp" -->
</head>
	 
<body>
	<div id="centrado">
<!--#include virtual="/_inc/jm/header.asp" -->

<div id="contenedor_left">
<section id="noticias">	
<div id="contact-form" class="clearfix">  
<h1>P&oacute;ngase en <span class="txt_h1_naranja">contacto!</span></h1>
<br>
<img src="/img/contacto.gif" width="550" height="109">
<h2>Rellene nuestro formulario de contacto a continuaci&oacute;n para ponerse en contacto con nosotros.<br>
S&iacute;rvanse proporcionarnos tanta informaci&oacute;n como sea posible para que podamos ayudarle lo mejor posible.</h2>  
<ul id="errors" class="">  
    <li id="info">Hubo algunos problemas con el envío del formulario</li>  
</ul>  
<p id="success">Gracias por tu mensaje! Nos pondremos en contacto con usted lo antes posible!</p>
<% if request.Form="" then %>  
<form method="post" action="contacto.asp">  
    <label for="name">Nombre: <span class="required">*</span></label>  
    <input type="text" id="name" name="nombre" value="" placeholder="Escriba su nombre" required  />  
      
    <label for="email">Email: <span class="required">*</span></label>  
    <input type="email" id="email" name="email" value="" placeholder="alguien@ejemplo.com" required />  
      
    <label for="telephone">Tel&eacute;fono: </label>  
    <input type="tel" id="telephone" name="telefono" value="" />  
      
    <label for="message">Mensaje: <span class="required">*</span></label>  
    <textarea id="message" name="mensaje" placeholder="Tu mensaje debe contener 20 caracteres como m&iacute;nimo" required data-minlength="20"></textarea>  
      
    <span id="loading"></span>  
    <input type="submit" value="Enviar" id="submit-button" />
    <input type="reset" value="Borrar" id="submit-button" />   
    <p id="req-field-desc"><span class="required">*</span> indica un campo obligatorio</p>  
</form>
<%
else
	nombre = request.form("nombre") 
	email = request.form("email") 
	cuerpo = "Formulario recibido" & VBNEWLINE & VBNEWLINE 
	cuerpo = cuerpo & "Nombre: " & nombre & VBNEWLINE 
	cuerpo = cuerpo & "Email: " & email 
'.................. 
	set mail = server.createObject("Persits.MailSender") 
	mail.host = "smtp.propertyweb.eu"
	mail.from = "informatica@propertyweb.eu"
	mail.fromname="PropertyWeb"
	mail.username = "lcf013c"
	mail.password = "PWeu08"
	mail.addAddress "informatica@propertyweb.eu"
	'mail.addAddress "design@propertyweb.eu"
	mail.body = cuerpo
	
	On Error Resume Next 
	mail.send
	
	if Err <> 0 then 
		%><p>Error, no se ha podido completar la operación</p>
		<p><%= Err.description %></p>
		<%
	else 
		%><p>Gracias por rellenar el formulario. Se ha enviado correctamente.</p><%
	end if
	
	Set ObjMail = Nothing
	
end if
%>
</section>  
</div>
<div id="contenedor_right">

<!--include virtual="/inc/publicidad/herramientas_busq.asp" -->
<!--#include virtual="/inc/publicidad/suscribe_newsletter3.asp" -->

      
<!--include virtual="/jp/inc_request.asp" -->
<!--include virtual="/jp/inc_sql.asp" -->
</div>	

<div><!--#include virtual="/_inc/jm/footer.asp" --></div>
</div><!-- FIN centrado -->

</div>
</body>
</html>
