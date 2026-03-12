<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 'call AccesoPrivado %>
<!DOCTYPE html>
<html>
<head>
    <title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/head.asp" -->
	
<% if request.Cookies("dev")="" then %>
    <link href="/lib/bootstrap/css/bs.css" rel="stylesheet" type="text/css">
    <link href="/css/animate.css" rel="stylesheet" type="text/css">
<% end if %>
    
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="header" class="row">
    <div class="caja">
    	<h1 class="heading">desarrollo</h1>
    </div>
</section>

<section id="row1" class="row" style="min-height:350px;">
    <div class="row">
        <div class="col-sm-6 col-md-4"><!--#include virtual="/dev/inc/cookie_dev.asp" --></div>
        <div class="hidden-sm col-md-4"><!--#include virtual="/dev/inc/server_variables.asp" --></div>
        <div class="col-sm-6 col-md-4"><!--#include virtual="/cliente/inc/navegador.asp" --></div>
    </div>
    
	<div class="row">
        <div class="col-md-8"><!--#include virtual="/dev/inc/cookies.asp" --></div>
        <div class="col-md-4"></div>
    </div>
    
</section>

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

