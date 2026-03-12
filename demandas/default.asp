<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<%
sec_actual = "buscadores"
pag_actual = "demandas" 

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
<title>PropertyWeb - Anuncios de Demandas</title>

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
<div class="container">
  <section id="s_buscador" class="row">
  <div class="caja">
    <h1 class="heading">Demandas</h1>
  </div>
  <div class="col-md-8 caja">
    <div id="div_formulario" name="div_formulario">
    <p class="frm_informa">Por favor, seleccione un primero el uso y despu&eacute;s rellene el cuadro de b&uacute;squeda.</p>
    <form id="frm_busq" name="frm_busq" class="form-horizontal" action="/articulos/titulos/resumen.asp" method="post" autocomplete="off" target="_blank">
      <input type="hidden" name="secc" value="demandas">
      <div class="form-group clearfix"><!-- buscar-->
        <label for="busq" class="col-sm-2 control-label">Buscar:</label>
        <div class="col-sm-10">
          <input id="busq" type="text" class="form-control" name="busq" value="<%= busqueda %>" placeholder="Escriba una o m&aacute;s palabras separadas por espacios" required autofocus maxlength="50" />
        </div>
      </div> <!-- fin form-group -->
      
      <div class="form-group clearfix">
        <label for="FechaI" class="col-sm-2 control-label">Uso:</label>
        <div class="col-sm-10">
          <%
set rsUsos = Server.CreateObject("ADODB.Recordset")

srcUso = "SELECT ID, NOMBRE FROM TIPOS_DE_SECCIONES WHERE "
srcUso = srcUso & "(ID IN ("
srcUso = srcUso & "SELECT id_seccion FROM NOTICIAS_INMOBILIARIAS WHERE tipo_noticia = 'B' GROUP BY ID_SECCION)"
srcUso = srcUso & ") "
srcUso = srcUso & "ORDER BY NOMBRE"

rsUsos.Open srcUso, session("connPW")
%>
          <select id="uso" name="uso" size="1" onChange="cambiaUso();" class="form-control">
            <option value="" <% if request.Form("uso")="" then %>selected<% end if %>>seleccionar uso</option>
            <% do while not rsUsos.eof %>
            <option value="<%= rsUsos("ID") %>" <% if cstr(rsusos("id"))=request.Form("uso") then %>selected<% end if %>><%= lcase(rsusos("NOMBRE")) %></option>
            <% rsUsos.movenext
    loop
rsUsos.close
set rsUsos=nothing
%>
          </select>
        </div>
      </div>  <!-- fin form-group -->
       
       
        
       <div class="form-group clearfix"> <!-- fecha   form-group-->
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
        </div> <!-- fin form-group -->
        
   <!--   <p>
        <label for="FechaI">Per&iacute;odo:</label>
        <input type="text" name="FechaI" id="FechaI" value="< %= f_desde %>" maxlength="10" class="fecha">
        &nbsp;-&nbsp;
        <input type="text" name="FechaF" id="FechaF" value="< %= f_hasta %>" maxlength="10" class="fecha">
      </p>-->
    
      
    
      
      
      <div class="form-botones clearfix">
        <div class="buscando" style="display:inline-block;"><div id="buscando" style="display:none;"><img src="/img/loading.gif"></div></div>
        <input type="button" value="restablecer" class="btn grisB" onClick="location.assign('/demandas/');">
        <input type="submit" value="buscar" id="buscar" class="btn">
      </div>
      
        
        </form>
  </div>
        </div><!-- fin div_formulario -->    
  
  
  
<div class="col-md-4 hidden-sm hidden-xs">
	<!--#include virtual="/inc/publicidad/suscribe_flash.asp" -->
</div>
<!--publi-->


</section>

<section id="s_resumen" class="row">
  <div name="div_instrucciones" id="div_instrucciones" class="caja clearfix">
    <p><strong>NOTA</strong>:</p>
    <p>Para efectuar una b&uacute;squeda en esta seccion de <strong>B&uacute;squeda de Demandas</strong>:</p>
    <ul>
      <li> Pruebe primero con nombres simples; por ejemplo AUTONOMY, no AUTONOMY CAPITAL, o BLACKSTONE en vez del nombre completo BLACKSTONE INVESTMENT PARTNERS.</li>
    </ul>
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
<script type="text/javascript">
function cambiaUso() {
	if ($("#busq").val()=="") {
		$("#busq").focus();
	} else {
		//$('#frm_busq').submit();
	}
};
</script>