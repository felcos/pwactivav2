<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>

<title>tabla aside</title>
<!--#include virtual="/inc/head.asp" -->

<!--       EXTRA  !!!!!!!!!!!!!!!!!!!  -->
<link  href="../../../css/css-pags/elementosForm.css" rel="stylesheet" type="text/css">



<script type="text/javascript">

$(document).ready(function(){
/*
$(".cabecera-sub").on("click", function (){
	     var pepe = $(this).find("a").attr("id");
		alert(pepe);*/
/* ////   TABLA   */		
$(".filaLat").on("click", function (){   /*  para que nos de el id al pinchar  la tabla */
	     var pepe = $(this).find("a").attr("id");
});

/* ////   ESTRUCTURA Y SELECT  */	
	
fnMovil();	
$(window).resize(fnMovil);

function fnMovil() {                         /*oculta/muestra menu con css según movil/escritorio*/

	if  ($(window).width()>=750)  {     /*escritorio */
		if($("ul.dropdown-menu li").length<1){ //  IMPORTANTE:  crea elemento en ul.dropdown-menu LI de forma automatica (se podría hacer manual y quitar esta parte)
				$("#pais02 > option").each(function(){	 
						$("ul.dropdown-menu").append("<li><a href='#'> "+ $(this).text() + "</a></li>");
					 });		
				$(".dropdown-menu li a").on("click",function(e){
					   e.preventDefault();
					   $("#paisDrop .paisNombre").text($(this).text());
					   $("#pais").val($(this).text());  /* envia valor a traves del campo oculto*/
					});
			 }
			
			$("#pais02").addClass("hide");
			$(".selectDrop .dropdown-menu").removeClass("hide");
		} else {                 /* if (($(window).width()<=750) &&  (esMovil !=1 )) */
			$("ul.dropdown-menu").empty();    // borra elementos de ul.dropdown-menu
			$("#pais02").removeClass("hide");
			$(".selectDrop .dropdown-menu").addClass("hide");
		}
	}


$("#pais02").change(function(){
		$("#paisDrop .paisNombre").text($(this).val());
		$("#pais").val($(this).val());  /* envia valor a traves del campo oculto*/
		});

	
/* :: Solo para movil*/
	$(".selectDrop").on("mouseenter",function(){    //selectDrop para hacer el efecto over (movil)
		$(".selectDrop").addClass("focus");
	});
	$(".selectDrop").on("mouseleave",function(){
			$(".selectDrop").removeClass("focus");
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


/* ////  interactividad */

	
$(".vermas").click(function(){   
	$(".verFila").toggleClass("verFilaDown");
	//$(this).next().fadeToggle();
	//alert(".verFila a");
	});
	

})<!--:jQ-->




</script>

<style type="text/css">
.vermas {
	position:relative;
	background-color:white;
	z-index:10;	
}
.verFila {
	
	margin-top: -20px;
	-webkit-transition: all .5s; /* Safari */
    transition: all .5s;
}

.verFilaDown {
	margin-top: 0px;
}


</style>


</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->




<div class="container">


<div class="col-md-8 caja">
	<h3>Lateral derecho</h3>
</div>

<div class="col-md-4 caja">  <!--PABLO!! esta estructura no coincide con la que tenemos, simplemente es para tener base de referencia-->

    <div class="col-selec"> <!--  select -->
         <div class="dropdown selectDrop">
                <select id="pais02" class="hide">
                    <option value="2016">2016</option>
                    <option value="2015">2015</option>
                    <option value="2014" selected="">2014</option>
                    <option value="2013">2013</option>
                </select>
               <input type="hidden" name="pais" value="Alemania" id="pais">
          <div class="dropdown-toggle form-control selecFecha" data-toggle="dropdown" id="paisDrop" aria-expanded="false">
            <span class="paisNombre">2016</span>
            <span class="icon-arrow-down2 separadorSpan"></span>
          </div>
         
          <ul class="dropdown-menu" role="menu"> 
          </ul>
        </div>
    </div> <!-- : select -->
    <div class="col-titu"> 
    <h3 class="tit_mod ">Oficinas Madrid</h3><!--<span style="font-weight:normal"></span>-->
    </div> 
    
<!-- tabla -->
<div class="tb-Gral-cont">
   <table  class="tabla"> 
   <thead class="">
   <tr class="filaLat-cabecera">
   	<th></th>
    <th>Ops</th>
    <th>M€</th>
    <th>M<sup>2</sup></th>
   </tr>
  </thead> 
  <tbody  class="">
   <tr class="filaLat titu">
   	<td><a href="#" id="op26485">Inversión/Ocup. Prop</a></td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
   </tr>
   
   <tr class="filaLat">
   	<td><a href="#" id="op2648t">Inversión</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 

    <tr class="filaLat vermas" >
   	<td><a href="#" id="op2648e"> + Ver más</a></td>
    <td></td>
    <td></td>
    <td></td>
   </tr>  
   
    <tr class="filaLat verFila">
   	<td><a href="#" id="op2648e">Ocup. Prop</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 
   
    <tr class="filaLat verFila">
   	<td><a href="#" id="op2648e">Ocup. Prop</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 

    <tr class="filaLat verFila">
   	<td><a href="#" id="op2648e">Ocup. Prop</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 
   
  
     
  <tr class="filaLat titu">
   	<td><a href="#" id="op26485">Take Up</a></td>
    <td>100</td>
    <td>100</td>
    <td>100</td>
   </tr>
   
   <tr class="filaLat">
   	<td><a href="#" id="op2648t">Alquiler</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 
   
    <tr class="filaLat">
   	<td><a href="#" id="op2648e">Ocup. Prop</a></td>
    <td>50</td>
    <td>50</td>
    <td>50</td>
   </tr> 

   </tbody>
   </table>
   </div><!--:tabla -->


  
</div><!-- :col-md-4  -->
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

  
  
  <!--  
<div class="tb-Gral-cont ">
    
    	<div class="filaLat-cabecera">
           <div ></div>
          <div >Ops.</div>
          <div >M€</div>
          <div >M<sup>2</sup></div>
        </div>
        
    	<div class="filaLat titu ">
          <div ><a href="#" id="op26485">Inversión/Ocup. Prop</a></div>
          <div  > 100</div>
          <div >100</div>
          <div >100</div>
        </div>
    	<div class="filaLat ">
          <div ><a href="#" id="CCCC" >Inversión</a></div>
          <div >50</div>
          <div >50</div>
          <div >50</div>
        </div>
    	<div class="filaLat  ">
          <div ><a href="#">Ocup. Prop</a></div>
          <div >50</div>
          <div>50</div>
          <div>50</div>
        </div>

    	<div class="filaLat titu ">
          <div ><a href="#" id="opBBBB">Take Up</a></div>
          <div >100</div>
          <div ></div>
          <div >100</div>
        </div>
    	<div class="filaLat  ">
          <div ><a href="#">  Alquiler</a></div>
          <div>50</div>
          <div></div>
          <div>50</div>
        </div>
    	<div class="filaLat  ">
          <div ><a href="#">Ocup. Prop</a></div>
          <div>50</div>
          <div></div>
          <div>50</div>
        </div>

 </div>  -->
        
        
        
        
        
    
    
    </div><!-- :container -->
    
    

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
