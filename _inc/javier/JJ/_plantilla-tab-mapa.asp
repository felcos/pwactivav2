<!DOCTYPE html>
<html lang="es"><head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="../../../css/css-pags/tabs02.css">
<!--<link rel="stylesheet" type="text/css" href="css/todo-bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/mapaCoord-prueba.css">-->
<link rel="stylesheet" type="text/css" href="../../../css/css-pags/mapaCoord.css">

<script>


$(window).resize(function() {
    $("#width").text($(this).width());
    $("#height").text($(this).height());
	/*if ($(this).width()<=750) {
		 $("#width").addClass("naranja");
 
		} else {
		 $("#width").removeClass("naranja");	
     	 $("#width").addClass("azul"); 	
		}*/

});


/*$(window).resize(function() {
    if(this.resizeTO) clearTimeout(this.resizeTO);
    this.resizeTO = setTimeout(function() {
		alert("hola");
        $(this).trigger('resizeEnd');
    }, 500);
});
*/


$(document).ready(function() {
/*	if (screen.width<=767) {
			alert("Resolucion: movil");
		}
	*/
	if ($(window).width()<=750) {
			inicioMvl();
	}
	
	$(".cerrar").click(cerrar());
	
	$(".menu01 li").click(function(e){
		
		if ($(this).hasClass("active")){
				$(".menu01 li").removeClass("active");
				$(".menu01 div").removeClass("active");
				e.stopPropagation();
		}
    });
	
	
	
	$(".btBuscar_").click(verResultados);	
/*	if($.browser.device = (/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase()))){
    alert('Hola! Entras desde un dispositivo móvil o tablet!');
}*/
});





function cerrar(){
	$(".menu01 li").removeClass("active");
	$(".menu01 div").removeClass("active");

	}


function verResultados(){
	$(".menu01 li").removeClass("active");
	$(".resultados-li").addClass("active");
	$("#content01 div").removeClass("active");
	$("#resultados").addClass("active");
	
	$(".submenu li:first-child").addClass("active");
	$("#mapa").addClass("active");
	
	$(".resultados-li").removeClass("hidden");

	}

function inicioMvl(){
	//alert("busquedas");
	
	$(".resultados-li").addClass("hidden");

	$(".busqueda-li").addClass("active");	
	$("#busqueda").addClass("active");	
	
	$(".submenu").addClass("");
	//$(".DealNavs li").removeClass("active");

	//$("#content01 div").removeClass("active");
	$("#resultados").addClass("active");
	}





function alerta(){
	alert("alerta funciona");
	}

</script>

</head><body>

<!--#include virtual="/inc/body-header.asp" -->

<div class="container"><!-- titulo  -->
  <section id="s_buscador" class="row">
    <div class="col-md-12 caja">
    	
      <h1 class="heading">Deal Analysis</h1>
      <div style="position:relative">
        <div style="">
            Width: <span id="width"></span><br>
            Height <span id="height"></span>
        </div>
</div>

    </div><!-- :titulas--> 
  </section> 
</div>


<div class="container">
  <section class="row">
    <div class="caja">
 <!-- /////////////////////////    TAB NAV -->   
    
  <!-- /////////////////////////   : TAB NAV -->   

<div class="DealTabs">


    <div class="menu01" id="">
          <!-- Nav tabs -->
          <ul class="nav nav-tabs ">
            <li class="busqueda-li"><a href="#busqueda" data-toggle="tab" aria-expanded="false"><span class="icon-search"></span> Busqueda</a></li>
            <li class="registros-li"><a href="#registros" data-toggle="tab" aria-expanded="true"><span class="icon-file-text2"></span> Registro</a></li><!--active -->
            <li class="resultados-li"><a href="#resultados" data-toggle="tab">Resultados</a></li>
          </ul>  
    	  <!-- Tab panes -->
          <div class="tab-content content01" id="content01">     
                 <div class="tab-pane" id="busqueda"> <!--     01 -->
                     <a href="#" data-toggle="tab" class="cerrar"><span class="icon-cancel-circle"></span></a>     
                     <a href="#" class="btBuscar_" > <img src="../img/gnral/busqueda.jpg"></a>
                 </div>
                 <div class="tab-pane " id="registros"> <!--active     02 -->
                     <a href="#" data-toggle="tab" class="cerrar"><span class="icon-cancel-circle"></span></a>  
                     <a href="#" class="btBuscar_" ><img src="../img/gnral/transacciones.jpg"></a> 
                            
                 </div>
                 <div class="tab-pane" id="resultados"> <!--     02 -->
                           <!-- <p>68 operaciones con un total de 746.072 m2</p>-->
                 </div>
          </div>
    </div>
   
  <!-- Nav tabs -->
  <ul class="nav nav-tabs submenu lineNavs" style="" id="">
    <li class=""><a href="#mapa" data-toggle="tab" aria-expanded="true">Mapa</a></li>   <!-- active    01 -->
    <li class=""><a href="#operaciones" data-toggle="tab" aria-expanded="false">Operaciones</a></li>
    <li class=""><a href="#agencias" data-toggle="tab" aria-expanded="false">Agencias</a></li>
    <li><a href="#distribucion" data-toggle="tab">Distribución</a></li>
  </ul>
  
  

  <!-- Tab panes -->
  <div class="tab-content" id="content02">                
  
    <div class="tab-pane" id="mapa" > <!-- /////////////////////////    active  01 -->
   
     <div class="mapaPrueba-div myMap">
        
        
            
       <div class="infoBox">
           <div class="infoboxPosition"  style="left:60px;  top:100px">
            <div class="popover top" id="">
                <div class="popover-check">
                 <button type="button" class="btn btnCheck"><!--<span class="icon-checkmark2"></span><span class="icon-checkmark"></span>--></button>
                 </div>
                 <a href="../www.propertyweb.eu">
                 <table class="popover-tb01">
                               <tbody>
                                    <tr>
                                        <td>27,00</td>
                                        <td>€</td>
                                    </tr>
                                    <tr>
                                        <td>18.744</td>
                                        <td>m2</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><img src="../img/gnral/logo01.jpg"><!--<img src="img/gnral/logo01.jpg"/><img src="img/gnral/logo01.jpg"/>--></td>
                                    </tr>
                                </tbody>
                           </table> 
                    </a>
                     <div class="arrow" style="left: 47.6449%;"></div>
             </div></div></div>   <!--:punto011-->
             
             
       <div class="infoBox">
       		         <div class="infoboxPosition" style="left:100px; top:200px">
            <div class="popover fade top" id="">
            
                <div class="popover-check">
                 <button type="button" class="btn btnCheck ckecked"><!--<span class="icon-checkmark" style="color:green;background-color:white"></span>--></button>
                 </div>
                 <a href="../www.propertyweb.eu">
                 <table class="popover-tb01">
                               <tbody>
                                    <tr>
                                        <td>27,00</td>
                                        <td>€</td>
                                    </tr>
                                    <tr>
                                        <td>18.744</td>
                                        <td>m2</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><img src="../img/gnral/logo01.jpg"><!--<img src="img/gnral/logo01.jpg"/><img src="img/gnral/logo01.jpg"/>--></td>
                                    </tr>
                                </tbody>
                   </table>
                 </a>
                <div class="arrow" style="left: 47.6449%;"></div>
             </div></div>  </div>   <!--:punto011-->
            
       <div class="infoBox">
          <div class="infoboxPosition" style="left:200px;  top:200px">       
            <div class="popover fade top" id="">

                <div class="popover-check">
                 <button type="button" class="btn btnCheck "><!--<span class="icon-checkmark2"></span><span class="icon-checkmark"></span>--></button>
                 </div>
                 <a href="../www.propertyweb.eu">
                 <table class="popover-tb01">
                               <tbody>
                                    <tr>
                                        <td>27,00</td>
                                        <td>€</td>
                                    </tr>
                                    <tr>
                                        <td>18.744</td>
                                        <td>m2</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2"><img src="../img/gnral/logo01.jpg"><!--<img src="img/gnral/logo01.jpg"/><img src="img/gnral/logo01.jpg"/>--></td>
                                    </tr>
                                </tbody>
                           </table>
                  </a>
                <div class="arrow" style="left: 47.6449%;"></div>
             </div></div></div>    <!--:punto011-->
           <!--coordenadas-->
        </div>
    	<!--:mapaPrueba-div   :infobox -->
    
    	<!--:mapaPrueba-div-->
    </div>
    
    <div class="tab-pane" id="operaciones">  <!-- /////////////////////////     02 -->
        <p>panel Operaciones</p> 
        <div class="caja-operaciones">
        	<img src="../img/gnral/tab-operaciones.jpg">
               <!--coordenadas-->
        </div><!--:mapaPrueba-div-->
    </div>
    
    
    <div class="tab-pane" id="agencias">  <!-- /////////////////////////     03 -->
    	<p>panel Agencias</p>
         <div class="caja-agencias">
        	<img src="../img/gnral/tab-agencias.jpg">
        </div>
        
    </div>
    
    
    <div class="tab-pane" id="distribucion"> <!-- /////////////////////////     04 -->
    	<p>panel Distribucion</p>
 		<div class="caja-distribucion">
        	<img src="../img/gnral/distribucion.jpg">
        </div>
    </div>
    
    
  </div>  <!--:tab-content-->

</div>




    </div><!-- :titulas--> 
  </section> 
</div>







<!-- :container--> 
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>




