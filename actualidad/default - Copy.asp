<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
sec_actual = "buscadores"
pag_actual = "actualidad" 

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
<title>PropertyWeb - Actualidad Inmobiliaria</title>

<!--#include virtual="/inc/head.asp" -->

<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">
  <section id="s_buscador" class="row">
    <div class="caja">
      <h1 class="heading">Actualidad Inmobiliaria</h1>
    </div>
    <div id="div_formulario" name="div_formulario" class="caja col-md-8"><!---->
      
      <p class="frm_informa">Permite interesantes consultas como, por ejemplo, nuevos barrios/&aacute;reas de expansi&oacute;n, proyectos, etc...</p>
      <form id="frm_busq" name="frm_busq" class="form-horizontal" action="/articulos/titulos/resumen.asp" method="post" autocomplete="off" target="_blank">
        <input type="hidden" name="secc" value="actualidad">
        
        <!--          <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
            <div class="col-sm-10">
              <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
            </div>
          </div>
   -->
        
        <div class="form-group clearfix">
          <label for="busq"  class="col-sm-2 control-label">Buscar:</label>
          <div class="col-sm-10">
            <input id="busq" type="text" class=" form-control" name="busq" value="<%= busqueda %>" placeholder="Escriba una o m&aacute;s palabras separadas por espacios" required autofocus maxlength="50" />
          </div>
        </div>
        <div class="form-group clearfix">
          <label for="FechaI" class="col-sm-2 control-label">Per&iacute;odo de:</label>
          <div class="col-sm-4"> 
            <!--          <span class=" col-xs-1"><p>De</p></span>-->
            <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="form-control">
          </div>
          <label for="FechaF" class="col-sm-2 control-label">hasta:</label>
          <div class="col-sm-4"> 
            <!-- &nbsp;-&nbsp;--> 
            <!--       <span class=" col-xs-1"><p>hasta</p></span>-->
            <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="form-control">
          </div>
        </div>
        
        <!-- jj 
        <div class="frm_fields">
          <p>
            <label for="FechaI">Per&iacute;odo:</label>
            <input type="text" name="FechaI" id="FechaI" value="< %= f_desde %>" maxlength="10" class="fecha">
            &nbsp;-&nbsp;
            <input type="text" name="FechaF" id="FechaF" value="< %= f_hasta %>" maxlength="10" class="fecha">
          </p>
        </div>-->
        <div class="form-botones clearfix">
          <div class="buscando" style="display:inline-block;"><div id="buscando" style="display:none;"><img src="/img/loading.gif"></div></div>
          <input name="reset" type="button" value="restablecer" class="btn grisB" onClick="location.assign('/actualidad/');">
          <input type="submit" value="buscar" id="buscar" class="btn">
        </div>
      </form>
    </div>
    <div class="col-md-4  hidden-sm hidden-xs">
    	<!--#include virtual="/inc/publicidad/suscribe_flash.asp" -->
    </div>
  </section>
  <!-- resumen -->
  
  <section id="s_resumen" class="row" ><!-- s_resumen -->
    <div name="div_instrucciones" id="div_instrucciones" class="caja clearfix"><!--class="col-md-12"-->
          <p><strong>NOTA</strong>:</p>
          <p>Para efectuar una b&uacute;squeda en esta seccion de <strong>Noticias</strong>:</p>
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

<script src="/inc/datepicker.js" type="text/javascript"></script>
<script src="/inc/buscar.js" type="text/javascript"></script>