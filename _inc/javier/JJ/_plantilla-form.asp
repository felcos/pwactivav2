<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->

<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>

<script>
$(document).ready(function(){
	$("#FechaI, #FechaF").datepicker({
		language: "es",
		format: "dd/mm/yyyy",
		autoclose: true
	})
	.on("show", function(e) {
		console.log(ant_date);
    })
	
});
</script>
<!--<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">
<link href="/inc/slideshow/slideshow_javier.css" rel="stylesheet" type="text/css">            anterior-->
</head><body>
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">
  <section id="s_buscador" class="row">
    <div class="col-md-8 caja">
      <h1 class="heading">Deal Analysis</h1>
    </div><!-- :titulas--> 
    
    <div class="col-md-4 lateral">
      <div class="caja sombra">
        <p style="font-family:'ruda',sans-serif; font-size:15px; font-weight:bold;">Transacciones Registradas en España</p>
      </div>
    </div><!-- :lateral--> 
    
    <div class="col-md-8 caja">
    <form class="dealForm">
    
    
    
      <div class="pasos">
          <div class="pasoIco"> <span>1</span> </div>
          <div  class="pasoMens">
            <p>Para realizar la busqueda por favor siga esos <strong>4 pasos:</strong></p>
            <p>Complete una Ubicación y un Pais.</p>
          </div>
        </div>    
        
     <div class="form-group">
        <label for="ubicacion">Ubicación</label>
        <input class="form-control" id="ubicacion" placeholder="ej. madrid barcelona">
      </div>                                   <!-- : Ubicación-->

     
     <div class="form-group">
        <label for="pais">Pais</label>
        <select id="pais" class="form-control">
          <option>españa</option>
          <option>africa</option>
          <option>3</option>
          <option>4</option>
          <option>5</option>
        </select>
     </div> 
    
    
		<div class="pasos">
          <div class="pasoIco"> <span>2</span> </div>
          <div class="pasoMens">
            <p>Seleccione uno de estos usos.</p>
          </div>
        </div>
     <div class="form-group">
        <label for="uso">Uso</label>
        <select multiple size="8" id="uso" class="form-control selectForm">
            <option value="oficinas">oficinas</option>
            <option value="centros comerciales">centros comerciales</option>
            <option value="deuda/credito">deuda/credito</option>
            <option value="viviendas residenciales">viviendas residenciales</option>
            <option value="hoteles">hoteles</option>
            <option value="naves industriales">naves industriales</option>
            <option value="locales comerciales">locales comerciales</option>
            <option value="solares">solares</option>
            <option value="ocio">ocio</option>
            <option value="polígonos industriales">polígonos industriales</option>
            <option value="almacenes">almacenes</option>
            <option value="parking">parking</option>
            <option value="hospital/centro de salud">hospital/centro de salud</option>
            <option value="escuela">escuela</option>
            <option value="residencia tercera edad">residencia tercera edad</option>
            <option value="instalaciones técnicas, etc...">instalaciones técnicas, etc...</option>
        </select>
     </div>  


	 <div class="pasos">
          <div class="pasoIco"> <span>3</span> </div>
          <div class="pasoMens">
            <p>Seleccione un tipo de operación</p>
          </div>
      </div>
     <div class="form-group">
     	<p class="labelForm">Operación</p>     
        <div class="radio">
          <label>
            <input type="radio" name="operacion" id="" value="" checked>
            Inversión <span>/ ocupación propia</span>
          </label>
        </div>
        <div class="radio">
          <label>
            <input type="radio" name="operacion" id="" value="">
            Alqulier <span>/ traspaso</span>
          </label>
        </div>
	</div>
    
 	  <div class="pasos">
          <div class="pasoIco"> <span>4</span> </div>
          <div class="pasoMens">
            <p>Puede modificar las fechas, por defecto aparecen los últimos 3 meses.</p>
          </div>
      </div>
     <div class="form-group clearfix periodo">
     	<p class="labelForm">Periodo</p>  
        
       <input type="text" name="" id="FechaI" value="" class="form-control bl50">
       <span class="icon-calendar form-ico"  aria-hidden="true"></span>
       
        
       <input type="text"  name="" id="FechaF" value=""  class="form-control bl50">
       <span class="icon-calendar form-ico"  aria-hidden="true"></span>

     </div>
        

    
 		<div  class="form-botones clearfix">
        <a href="#" class="btn gris"><span class="icon-circle-down"></span> Más filtros</a>
        <input name="reset" type="button" value="Restablecer"  onclick="" class="btn gris">
<!--        <input name="consulta" type="submit" value="Buscar" class="btn pull-right">-->
        <button type="button" value="Buscar" class="btn btnAzul pull-right"><span class="icon-search"></span> Buscar</button>
        
        <div class="divBuscando">
          <div id="buscando" style="display:none;"><img src="/img/loading.gif"></div>
        </div>
      </div>  
      
 

 
 
 
      
       
    </form>   
    </div><!--col-md-8 :formulario--> 
    
  </section>
</div>
<!-- :container--> 
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>




