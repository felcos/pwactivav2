<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=2">

<link href="/css/base.css" rel="stylesheet" type="text/css">
<link href="/css/estilos.css" rel="stylesheet" type="text/css">
<link href="/css/fuentes.css" rel="stylesheet" type="text/css">

<link href="/css/form_boots.css" rel="stylesheet" type="text/css">
<link href="/css/titulos.css" rel="stylesheet" type="text/css"/> <!--  comenta -->
<link href="/css/titulos_info.css" rel="stylesheet" type="text/css"/><!--  info/info_javier.asp -->
<link href="/css/titulos_operaciones.css" rel="stylesheet" type="text/css"/><!--  info/info_javier.asp -->
<link href="/css/leer_javier.css" rel="stylesheet" type="text/css"/><!-- css en articulos pasado a mi carpeta -->
<link href="/css/js-components.css" rel="stylesheet" type="text/css"><!-- css temporal, estilos por defecto bt-->

<link href="/css/header.css" rel="stylesheet" type="text/css"/>
<link href="/css/footer.css" rel="stylesheet" type="text/css">
<link href="/css/estilo_imprimir.css" rel="stylesheet" type="text/css" media="print">

<% if request.Cookies("dev")<>"" then %>
<link href="/css/dev.css" rel="stylesheet" type="text/css"/>
<link href="/css/animate.css" rel="stylesheet" type="text/css">
<link href="/lib/bootstrap/css/bs.css" rel="stylesheet" type="text/css">
<% end if

'No Caché
Response.addHeader "pragma", "no-cache"
Response.CacheControl = "Private"
response.expires=0
%>
<script src="/lib/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/bootstrap.min.js" type="text/javascript"></script>

<script src="/lib/scrollTo/jquery.scrollTo.js" type="text/javascript"></script>

<script src="/js/jquery.form.js" type="text/javascript"></script>
<script src="/js/modernizr.js" type="text/javascript"></script>

<% if request.Cookies("dev")<>"" then %>
<script src="/lib/notify/bootstrap-notify.min.js" type="text/javascript"></script>
<% end if %>

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
<script src="/js/support/html5shiv.min.js"></script>
<script src="/js/support/respond.min.js"></script>
<![endif]-->
<!--#include virtual="/inc/js.asp" -->