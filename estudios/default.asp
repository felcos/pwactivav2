<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
sec_actual = "buscadores"
pag_actual = "estudios" 

dim f_desde
dim f_hasta
dim busqueda

swMostrarListado=false

if request.Form="" then
	f_desde=dateadd("m", -3, date)
	f_hasta=date
	busqueda = ""
else
	f_desde=cdate(Request.Form("FechaI"))
	f_hasta=cdate(Request.Form("FechaF"))
	busqueda=Request.Form("busq")
end if

if isdate(f_desde) and isdate(f_hasta) and len(trim(busqueda))>1 and datediff("d", f_desde, f_hasta)>0 then
	swMostrarListado=true
end if
%>
<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb - Estudios de Mercado</title>

<!--#include virtual="/inc/head.asp" -->

<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div  class="container">
  <section id="s_buscador" class="row">
  <div class="caja">
    <h1 class="heading">Estudios de Mercado</h1>
  </div>
  <div class="col-md-8 caja">
    <div id="div_formulario" name="div_formulario" class="content-pad-right">
    <p class="frm_informa">Publica los Estudios del Mercado de la mayor&iacute;a de los operadores del mercado sobre Oficinas, Retail, Industrial, etc...</p>
    <form id="frm_busq" name="frm_busq" class="form-horizontal" action="/articulos/titulos/resumen.asp" method="post" autocomplete="off" target="_blank">
      <input type="hidden" name="secc" value="estudios">
      
      <div class="form-group clearfix">
        <label for="busq"  class="col-sm-3 control-label">Buscar:</label>
        <div class="col-sm-9">
          <input id="busq" class="form-control" type="text" name="busq" value="<%= busqueda %>" placeholder="Escriba una o m&aacute;s palabras separadas por espacios" required autofocus maxlength="50" />
        </div>
      </div>
      <div class="form-group clearfix">
        <label for="FechaI"  class="col-sm-3 control-label">Per&iacute;odo de:</label>
        <div class="col-sm-4">
          <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
        </div>
        <label for="FechaI"  class="col-sm-1 control-label">de:</label>
        <div class="col-sm-4">
          <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
        </div>
      </div>

      <div class="form-botones clearfix">
        <div class="buscando" style="display:inline-block;"><div id="buscando" style="display:none;"><img src="/img/loading.gif"></div></div>
        <input name="reset" type="button" value="restablecer" class="btn grisB" onClick="location.assign('/estudios/');">
        <input type="submit" value="buscar" id="buscar" class="btn">
      </div>
    </form>
  </div>
</div>
<div class="col-md-4 hidden-sm hidden-xs">
	<!--#include virtual="/inc/publicidad/suscribe_flash.asp" -->
</div>
<!--.col-md-push-8-->
</section>


<section id="s_resumen" class="row">
  <div name="div_instrucciones" id="div_instrucciones" class="caja clearfix">
    <p><strong>NOTA</strong>:</p>
    <p>Para efectuar una b&uacute;squeda en esta seccion de <strong>Estudios de Mercado</strong>:</p>
    <p> &nbsp; 1. En primer lugar, utilizar palabras en singular, como CENTRO COMERCIAL, PROYECTO, etc... en vez de CENTROS COMERCIALES, PROYECTOS, etc...</p>
    <p> &nbsp; 2. Nombres de empresa simples; por ejemplo AUTONOMY, no AUTONOMY CAPITAL, o BLACKSTONE en vez del nombre completo BLACKSTONE INVESTMENT PARTNERS.</p>
  </div>
</section>
<section id="s_titulos" class="row">
  <div id="div_result" class="caja" style="display:none;"><div id="result"></div></div>
</section>
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
<script src="/inc/buscar.js" type="text/javascript"></script>
<script src="/inc/datepicker.js" type="text/javascript"></script>
