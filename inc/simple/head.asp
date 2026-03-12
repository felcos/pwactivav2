<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="robots" content="noindex, nofollow">
<link href="/css/simple/base.css" rel="stylesheet" type="text/css">
<link href="/css/simple/grid.css" rel="stylesheet" type="text/css">
<link href="/css/simple/estilos.css" rel="stylesheet" type="text/css">
<link href="/css/simple/elements.css" rel="stylesheet" type="text/css">
<link href="/css/fonts/icomoon.css" rel="stylesheet" type="text/css">
<!--
<link href="/css/simple/forms.css" rel="stylesheet" type="text/css">
<link href="/css/simple/elements.css" rel="stylesheet" type="text/css">
-->
<link href="/css/simple/header.css" rel="stylesheet" type="text/css">

<% if request.Cookies("config")("estilos2")<>"" then %>
<link href="/css/simple/estilos2.css" rel="stylesheet" type="text/css">
<!--
<link href="/css/simple/forms2.css" rel="stylesheet" type="text/css">
-->
<% end if %>

<% if session("modo")="jp" then %>
<link href="/css/simple/iconos.css"/ rel="stylesheet" type="text/css">
<% end if %>

<script src="/lib/jquery/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/bootstrap.min.js" type="text/javascript"></script>
<script src="/js/jquery.form.js" type="text/javascript"></script>
<script src="/lib/scrollTo/jquery.scrollTo.js" type="text/javascript"></script>
<script src="/js/modernizr.js" type="text/javascript"></script>
<!--#include virtual="/inc/js.asp" -->