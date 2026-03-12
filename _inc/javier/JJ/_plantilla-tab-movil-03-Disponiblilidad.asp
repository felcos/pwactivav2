<!DOCTYPE html>
<html lang="es"><head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->


<link rel="stylesheet" type="text/css" href="../../../css/css-pags/tabs031-izq.css">

<!--<link rel="stylesheet" type="text/css" href="css/todo-bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/mapaCoord-prueba.css">-->
<link rel="stylesheet" type="text/css" href="../../../css/css-pags/mapaCoord.css">
<script>
$(document).ready(function() {
	
	// $(".deal-navs").animate({   'left' : "-330px"   });
	
	$("#verSubmenu").on('click', function (e){
		e.preventDefault();
	 
		if ($(".deal-navs").position().left==0) {
			 $(".deal-navs").animate({   'left' : "-330px"   });
			 $("#verSubmenu").find("span").removeClass("icon-arrow-left2").addClass("icon-search");
			 //.switchClass( "icon-arrow-left2", "icon-search" );
			 //.toggleClass( "icon-arrow-left2", "icon-search" ) ;
			 //.removeClass("icon-search" );
			// .addClass(icon-arrow-left2)
			 //css({"color": "red", "border": "2px solid red"});
			 //.toggleClass( icon-arrow-left2, icon-search ) ;
		} else {
			$(".deal-navs").animate({   'left' : "0"   });
			$("#verSubmenu").find("span").removeClass("icon-search").addClass("icon-arrow-left2");
		}
		
				
	 });
	   

	// icon-arrow-left2


});
</script>

</head><body>

<!--#include virtual="/inc/body-header.asp" -->

<div class="container"><!-- titulo  -->
  <section id="s_buscador" class="row">
    <div class="col-md-12 caja">
      <h1 class="heading">Deal Analysis</h1>
    </div><!-- :titulas--> 
  </section> 
</div>



<div class="container">
  <section class="row">
    <div class="caja">
 <!-- /////////////////////////    TAB NAV -->   
    
  <!-- /////////////////////////   : TAB NAV -->   

<div class="PwTabs">   <!--deal-tabs-->
	
<a id="verSubmenu" href=""  class="btn bt_lupa" ><span class="icon-search"></span></a>  <!--visible-xs -->
  <!-- Nav tabs -->
  <ul class="nav nav-tabs clearfix" style="">
    <li class="active"><a href="#mapa" data-toggle="tab" aria-expanded="true">Mapa</a></li>
    <li class=""><a href="#operaciones" data-toggle="tab" aria-expanded="false">Operaciones</a></li>
    <li class=""><a href="#agencias" data-toggle="tab" aria-expanded="false">Agencias</a></li>
    <li><a href="#distribucion" data-toggle="tab">Distribución</a></li>
  </ul>
  
  

  <!-- Tab panes -->
  <div class="tab-content">                
  
  <div class="deal-navs" style="">
       <!-- Nav tabs -->
      <ul class="nav nav-tabs clearfix   lineNavs" style="display:none">  <!--hidden-xs -->
        <li class="active"><a href="#busqueda" data-toggle="tab" aria-expanded="false"><span class="icon-search"></span> Busqueda</a></li>
       <!-- <li class=""><a href="#registros" data-toggle="tab" aria-expanded="true"><span class="icon-file-text2"></span> Registro</a></li>-->
        <li style="
    display: none;
"><a href="#resultados" data-toggle="tab">Resultados</a></li>
      </ul>  

<!-- Tab panes -->
      <div class="tab-content">                
             <div class="tab-pane active " id="busqueda"> <!--     01 -->
                        <img src="../img/gnral/busqueda.jpg">
             </div>
             <!-- <div class="tab-pane " id="registros">    
                        <img src="img/gnral/transacciones.jpg">
             </div>    02 -->
             <div class="tab-pane" id="resultados"> <!--     02 -->
                        <p>Enlace03</p>
             </div>
      </div>
   </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    <div class="tab-pane active" id="mapa"> <!-- /////////////////////////     01 -->
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
    </div>
   

    <div class="tab-pane" id="operaciones">  <!-- /////////////////////////     02 -->
        <p>panel002</p> 
        <div class="caja-operaciones">
        	<img src="../img/gnral/tab-operaciones.jpg">
               <!--coordenadas-->
        </div><!--:mapaPrueba-div-->
    </div>
    
    
    <div class="tab-pane" id="agencias">  <!-- /////////////////////////     03 -->
    	<p>panel003</p>
         <div class="caja-agencias">
        	<img src="../img/gnral/tab-agencias.jpg">
        </div>
        
    </div>
    
    
    <div class="tab-pane" id="distribucion"> <!-- /////////////////////////     04 -->
    	<p>panel004</p>
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




