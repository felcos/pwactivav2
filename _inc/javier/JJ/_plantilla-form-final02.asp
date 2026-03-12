<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp"-->




<link href="/lib/bootstrap-datepicker/bootstrap-datepicker3.css" rel="stylesheet" type="text/css">
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.min.js"></script>
<script src="/lib/bootstrap-datepicker/bootstrap-datepicker.es.js"></script>

<link  href="../../../css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">

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
	
	$("#boton_").click(function(e){
			$("#pais").focus();
		/*	alert("hola");
			e.stopPropagation();*/
	});
		
		



/*  Drop Selec*/	

/* Solo para movil*/



var esMovil = 2;
fnMovil();	
$(window).resize(fnMovil);

function fnMovil() {                         /*oculta/muestra menu con css según movil/escritorio*/
	
	/* 0>escritorio 1>movil 2>nada*/
	if (   ($(window).width()>=750) &&  (esMovil !=0 )     )   {     /*escritorio*/
		esMovil=0;
		
		$("#pais02 > option").each(function(){	 //  IMPORTANTE:  crea elemento en ul.dropdown-menu LI de forma automatica
			$("ul.dropdown-menu").append("<li><a href='#'> "+ $(this).text() + "</a></li>");
   			 });
		$("#pais02").addClass("hide");
		$(".selectDrop .dropdown-menu").removeClass("hide");
	} else if (($(window).width()<=750) &&  (esMovil !=1 )){
		esMovil=1;
		$("ul.dropdown-menu").empty();    // borra elementos de ul.dropdown-menu
		$("#pais02").removeClass("hide");
		$(".selectDrop .dropdown-menu").addClass("hide");
	}
	
}

console.log( "2"  );


$("#pais02").change(function(){
		//var pepe = $("#pais02").val();
		$("#paisDrop .paisNombre").text($(this).val());
		$("#pais").val($(this).val());  /* envia valor a traves del campo oculto*/
		});
		

	
/* :: Solo para movil*/
	
	$(".dropdown-menu li a").click(function(e){
		   e.preventDefault();
		   $("#paisDrop .paisNombre").text($(this).text());
		   $("#pais").val($(this).text());  /* envia valor a traves del campo oculto*/
		});
	
	
	$(".selectDrop").on("mouseenter",function(){    //selectDrop para hacer el efecto over (movil)
		$(".selectDrop").addClass("focus");
	});
	
	$(".selectDrop").on("mouseleave",function(){
			$(".selectDrop").removeClass("focus");
	});
	
/* selec multiple/ SIZE   para dar el estilo "selected" a los li; + estilo "focus"     */
	$(".selectTipo li,.selectAnd li ").click(function(){  
			if ($(this).hasClass('selected')){
				//$(".selectTipo li,.selectAnd li").removeClass("selected");  siempre tiene que estar seleccionado uno
			}else{
				$(".selectTipo li,.selectAnd li").removeClass("selected");
				$(this).addClass("selected");
				
				$("#uso").val($(this).text());
				//alert($("#uso").val());
			}
	});
	
	$(".selectTipo li").on("mouseenter",function(){
		$(".selectCaja").addClass("focus");
	});
	$(".selectTipo li").on("mouseleave",function(){
			$(".selectCaja").removeClass("focus");
		});


/*  si se utiliza el DropSelect se puede suprimir este script que sirve solo para que se vea la flechita en android 4.l*/
$(function () {
  var nua = navigator.userAgent
  var isAndroid = (nua.indexOf('Mozilla/5.0') > -1 && nua.indexOf('Android ') > -1 && nua.indexOf('AppleWebKit') > -1 && nua.indexOf('Chrome') === -1)
  if (isAndroid) {
  //$('select.form-control').removeClass('form-control').css('width', '100%');
    $('select.form-control').removeClass('form-control').css({"width": "100%"}); //cualquier estilo no lo coge
	$('.form-control.selectCaja').addClass('androidBr');   //para que no añada sombra y haga bien el scroll
	$('.form-control.selectCaja ul').removeClass('selectTipo').addClass('selectAnd'); ; //para que no haga over
	
  }
  

})




/*  cerrar depuraAA*/


$('#bt-enviar').on("click",function(){
	

	
	if($("[aria-label='ciudad']").val()==""){
		    $("[aria-label='ciudad']").css({"border-color": "red"});
			//$(this).css({"border": "red"});
			$('.depuraAA').text("Tienes que rellenar este campo");
			$('.depuraAA').slideToggle();
			//alert("hola");
		}
	
	
	

	});


//











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
    
    
    
    <!-- ubicacion-->
          <div class="pasos">
      
      <div class="tooltip right" role="tooltip"> 
      		<div class="tooltip-arrow"></div> 
            <div class="tooltip-inner"> Tooltip on the right </div> 
      </div>
      <!--  -->
          <div class="pasoIco"> <span>1</span> </div>
          <div  class="pasoMens">
            <p>Para realizar la busqueda por favor siga esos <strong>4 pasos:</strong></p>
            <p>Complete una Ubicación y un Pais.</p>
          </div>
     </div>  
    
    
    
     <label for="ubicacion">Ubicación</label>
     <div class="form-group input-group">
      <div class="input-group-btn"> 
      <div class="dropdown selectDrop">
        
		<select id="pais02">
        <option value="Albania">Albania</option>
        <option value="Alemania">Alemania</option>
        <option value="España" selected>España</option>
         <option value="Portugal">Portugal</option>
        </select>


       <input type="hidden" name="pais" value="Alemania" id="pais">
  <div class="dropdown-toggle form-control" data-toggle="dropdown" id="paisDrop" aria-expanded="false"><!--   id="dropdownMenu1"           sr-only-->
    <span class="paisNombre">España</span>
    <span class="caret"></span>
  </div>
 
  <ul class="dropdown-menu" role="menu" >  <!--style="display: none;"     aria-labelledby="dropdownMenu1"-->

   <!-- <li>
      <a href="#">Albania</a>
    </li>
    <li>
      <a href="#">Alemania</a>
    </li>
     <li>
      <a href="#">España</a>
    </li>
    <li>
      <a href="#">Portugal</a>
    </li>-->
  </ul>
</div>
      
  
      </div><!-- /btn-group -->
      <input type="text" class="form-control" aria-label="ciudad" placeholder="ej. madrid barcelona" >
      <div class="depuraAA">DEPURA  asdf asddf asdf asdf asdf asddf asdf asdf </div>  
                              <!--    -->
    
    </div><!-- /input-group -->
    
    
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
	</div><!-- /operación form-group-->
  

        
   

   
    
    
		<div class="pasos">
          <div class="pasoIco"> <span>2</span> </div>
          <div class="pasoMens">
            <p>Seleccione uno de estos usos.</p>
          </div>
        </div>
        <!-- selec multiple  :: multiple es para seleccionar varios, para que se vean varios size --> 
     <!--<div class="form-group">
        <label for="uso">Uso</label>
        <select  size="8" id="uso02" class="selectForm form-control ">
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
     </div>--> 
<div class="form-group">
     	<label for="uso">Uso </label> 
<div class="form-control selectCaja "> 

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
        <button id="bt-enviar" type="button" value="Buscar" class="btn btnAzul pull-right"><span class="icon-search"></span> Buscar</button>
        
        <div class="divBuscando">
          <div id="buscando" style="display:none;"><img src="/img/loading.gif"></div>
        </div>
      </div>  
       
    </form>   
    </div><!--col-md-8 :formulario--> 
    
  </section>
</div>
<!-- :container--> 
<!--include virtual="/inc/body-footer.asp"# -->
</body>
</html>


