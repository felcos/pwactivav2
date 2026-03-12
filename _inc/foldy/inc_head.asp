<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="robots" content="noindex, nofollow">
<link href="/_inc/foldy/base.css" rel="stylesheet" type="text/css">
<link href="/_inc/foldy/grid.css" rel="stylesheet" type="text/css">
<link href="/_inc/foldy/estilos.css" rel="stylesheet" type="text/css">
<link href="/_inc/foldy/elements.css" rel="stylesheet" type="text/css">
<link href="/css/fonts/icomoon.css"/ rel="stylesheet" type="text/css">

<link href="/_inc/foldy/header.css" rel="stylesheet" type="text/css">

<% if session("modo")="jp" then %>
<link href="/_inc/jp/base.css" rel="stylesheet" type="text/css">
<link href="/_inc/jp/iconos.css"/ rel="stylesheet" type="text/css">
<link href="/_inc/jp/elements.css"/ rel="stylesheet" type="text/css">
<% end if %>

<% if request.Cookies("config")("estilos2")<>"" then %>
<link href="/_inc/foldy/estilos2.css" rel="stylesheet" type="text/css">
<link href="/_inc/foldy/forms2.css" rel="stylesheet" type="text/css">
<% end if %>

<% if request.Cookies("config")("headfoot")<>"" then %><link href="/_inc/<%= session("modo") %>/fix.css" rel="stylesheet" type="text/css"><% end if %>

<!--#include virtual="/inc/js.asp" -->