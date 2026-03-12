<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->

<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>
<link  href="../../../css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function(){
		
	//$("#paisDrop").click(function(e){
	//		alert("pais");
			
			/*e.stopPropagation();*/
		
	//	});
	
	$("#paisDrop").click(function(e){
			/*e.preventDefault();
			alert("pais");
			*/
		});
		
		
	$(".dropdown-menu li a").click(function(e){
		   e.preventDefault();
		   $("#paisDrop .paisNombre").text($(this).text());
		});
	
	

	$(".selectTipo li,.selectAnd li ").click(function(){  //select  multiple
			if ($(this).hasClass('selected')){
				//$(".selectTipo li,.selectAnd li").removeClass("selected");  siempre tiene que estar seleccionado uno
			}else{
				$(".selectTipo li,.selectAnd li").removeClass("selected");
				$(this).addClass("selected");
				
				$("#uso").val($(this).text());
				//alert($("#uso").val());
			}
	});
	
	
	
	$(".selectDrop").on("mouseenter",function(){    //select  Drop
		$(".selectDrop").addClass("focus");
	});
	
	$(".selectDrop").on("mouseleave",function(){
			$(".selectDrop").removeClass("focus");
		});



$(function () {
  var nua = navigator.userAgent
  var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
  if (isAndroid) {
   /* $('select.form-control').removeClass('form-control').css({"width": "100%"}); //cualquier estilo no lo coge
	$('.form-control.selectCaja').addClass('androidBr');   //para que no añada sombra y haga bien el scroll*/
	$('.form-control.selectCaja ul').removeClass('selectTipo').addClass('selectAnd'); ; //para que no haga over
  }
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
     <!--    <select id="pais02" class="form-control">
          <option>españa 01</option>
          <option>africa</option>
          <option>3</option>
          <option>4</option>
          <option>5</option>
        </select>-->
        
     <div class="dropdown selectDrop">
       <input type="hidden" name="pais" value="españa" id="pais">
  <div class="dropdown-toggle form-control" data-toggle="dropdown" id="paisDrop"><!--   id="dropdownMenu1"           sr-only-->
    <span  class="paisNombre">España</span>
    <span class="caret"></span>
  </div>
 
  <ul class="dropdown-menu" role="menu" >  <!--aria-labelledby="dropdownMenu1"-->

    <li>
      <a href="#">Africa</a>
    </li>
    <li>
      <a href="#">Alemania</a>
    </li>
    <li>
      <a href="#">Portugal</a>
    </li>
  </ul>
</div>       
        
        
        
     </div> 
    <!--    dropdown  ///////////////////////////////   --> 
     
 

    <!-- ///////////////////////////////   --> 
    <br><br>
    <div class="form-group form-control selectCaja "> 
	 <input type="hidden" name="uso" value="oficinas" id="uso">
     <ul class=" selectTipo">
        <li class="selected">oficinas</li>
        <li>centros comerciales</li>
        <li>deuda/credito</li>
        <li>viviendas residenciales</li>
        <li>hoteles</li>
        <li>naves industriales</li>
		<li>locales comerciales</li>
        <li>solares</li>
        <li>polígonos industriales</li>
        <li>almacenes</li>
        <li>parking</li>
        <li>hospital/centro de salud</li>
        <li>escuela</li>
        <li>residencia tercera edad</li>
        <li>instalaciones técnicas, etc...</li>
     </ul>
</div>
    
    
    
      <!--    original  ///////////////////////////////   --> 
 <!--    
    <div class="dropdown">
  <button class="btn dropdown-toggle " type="button"
         data-toggle="dropdown">  
    Menú desplegable
    <span class="caret"></span>
  </button>
 
  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
    <li role="presentation">
      <a role="menuitem" tabindex="-1" href="#">Acción</a>
    </li>
    <li role="presentation">
      <a role="menuitem" tabindex="-1" href="#">Otra acción</a>
    </li>
    <li role="presentation">
      <a role="menuitem" tabindex="-1" href="#">Otra acción más</a>
    </li>
    <li role="presentation" class="divider"></li>
    <li role="presentation">
      <a role="menuitem" tabindex="-1" href="#">Acción separada</a>
    </li>
  </ul>
</div> -->

    <!-- ///////////////////////////////   -->   
    
    
<!-- 	<div> <a id="boton_" href="#" class="btn azul">activa</a></div>   -->
    
    
    
    
    
		
        

    
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


