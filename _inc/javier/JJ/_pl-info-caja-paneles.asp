<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb </title>
<!--#include virtual="/inc/head.asp" -->


<style type="text/css" >

	

	


.divCajaCheck.stick {

    position: fixed;
    top: 0;
    z-index: 10000;
}


@media (max-width:450px) {    /* 450*/
		
	.divCajaCheck.stick {
		width:100%;
		left: 0;
	}

}	


</style>


<script>
$(document).ready(function(){
	
	$(".close").on('click',function(){
		$(this).parent().hide("slow");
		});
	
	
	
	
/* div fijo */	

 $(window).scroll(recolocarContador);
   recolocarContador();


function recolocarContador() {
    var window_top = $(window).scrollTop();
    var div_top = $('#sticky-marcador').offset().top;
    if (window_top > div_top) {
		//alert("salta")
       $('.divCajaCheck').addClass('stick');
    } else {
       $('.divCajaCheck').removeClass('stick');
    }
}

















   


/*
$(window).scroll(function()
            {
                if ($(this).scrollTop() > 250){
					$(".divCajaCheck").addClass("fixed");   //.fadeIn();
					// $('#menu').addClass("fixed").fadeIn();
					// $('.contenedor').addClass("margen").fadeIn();
					//alert(" > 250 px");
				}
                else {
					$(".divCajaCheck").removeClass("fixed");
					// $('#menu').removeClass("fixed");
					// $('.contenedor').removeClass("margen");
				}
            });*/





	



/*	
posicionarMenu();

$(window).scroll(function() {    
    posicionarMenu();
});

function posicionarMenu() {
    var altura_del_header = $('.header').outerHeight(true);
    var altura_del_menu = $('.divCajaCheck').outerHeight(true);

    if ($(window).scrollTop() >= altura_del_header){
        $('.divCajaCheck').addClass('fixed');
        $('#div_result').css('margin-top', (altura_del_menu) + 'px');
    } else {
        $('.divCajaCheck').removeClass('fixed');
        $('#div_result').css('margin-top', '0');
    }
}	
 */	
	
/*	posicionarMenu();

$(window).scroll(function() {    
    posicionarMenu();
});

function posicionarMenu() {
    var altura_del_header = $('.header').outerHeight(true);
    var altura_del_menu = $('.menu').outerHeight(true);

    if ($(window).scrollTop() >= altura_del_header){
        $('.menu').addClass('fixed');
        $('.wrapper').css('margin-top', (altura_del_menu) + 'px');
    } else {
        $('.menu').removeClass('fixed');
        $('.wrapper').css('margin-top', '0');
    }
}*/
	
	
	
	
	
	
/*  despliega el div contador */
	$("#btCheck").on('click',function(){
	
		
			$(".divCajaCheck").slideToggle();
	
			if( parseInt($(".divCajaCheck .contadorSelect").css("marginTop"))==0){
					$(".divCajaCheck .contadorSelect").animate({marginTop:'-45px'});
				}else {
					$(".divCajaCheck .contadorSelect").animate({marginTop:'0px'});
				
					}
			

	});

/*  check el div superior */
$(".deals_check").click(function(e){

	if( $(this).find("input[type='checkbox']").prop('checked') ){
		 $(this).find("input[type='checkbox']").prop("checked", false);
	} else {
		$(this).find("input[type='checkbox']").prop("checked", "checked");
	}
	e.stopPropagation();
});	

	
	
	
	
	
/*	
	
	$( "#btCheck" ).click(function() {
  $(".divCajaCheck").toggle(function() {
	  
	 $(".divCajaCheck").animate({opacity: '1'});
       
  });
});*/
	
/*	$("#btCheck").on('click',function(){
		$(".divCajaCheck").animate({
				//marginTop: '0px',
				opacity: '1'
    });
	
	

		});
	
	*/
	
	})

</script>



</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->



<div class="container">
<div id="div_result" class="caja">

<a href="#" id="btCheck" class="btn">btCheck</a>


<div id="sticky-marcador"></div>
 <!--  UUU -->
         <div class="divCajaCheck" style=" background-color:#FFF;display:none;"><!-- id="sticky"   position: absolute; left: 500px;-->
        <form name="frm_titulos2" id="frm_titulos2" method="post" action="/articulos/">
            
            <div class="contadorSelect" style="margin-top:-45px;">
            	<div  class="contadorSelectGris"style="background-color:#dedede">
                <span class="numero" id="sel-count">0</span>
                <span class="icon-checkmark"></span>
                </div>
                
                <input name="" type="submit" value="Ver fichas" class="btn btn-sm"> <!-- btn-xs-->
            <input name="" type="submit" value="Borrar" class="btn blancoHover  btn-sm">
            <p class="alert">Límite de 20</p></div>
 
 
        </form>
       <!-- <p class="grisClaro_color hidden">El límite es 20 </p>-->
<!--        <p id="xxxx"></p>-->
    </div>   
            
            
 <!-- / UUU -->  
      
<div class="fila"><div class="deals_check"><input type="checkbox" name="ope" value="1" class="chexbox" id="chkOp26299"></div></div>
<div class="fila"><div class="deals_check"><input type="checkbox" name="ope" value="2" class="chexbox" id="chkOp26299"></div></div>
<div class="fila"><div class="deals_check"><input type="checkbox" name="ope" value="3" class="chexbox" id="chkOp26299"></div></div>
<div class="fila"><div class="deals_check"><input type="checkbox" name="ope" value="4" class="chexbox" id="chkOp26299"></div></div>




<div class="caja" style="background:#FFF url(../img/gnral/mapa-prueba.jpg) no-repeat;background-size:contain; height:900px ; position:relative">


<div class="divDisponMapa " style="display:block;"><!--divDispon clearfix-->
			<button type="button" class="close"><span aria-hidden="true">×</span></button>
 			<div class="dispTitu">  <!--col-sm-8     -->
                    <table class="tbDispon">
                      <thead>
                        <tr class="cabeza">
                          <th class="tbDisp-Plta">Planta</th>
                          <th class="tbDisp-Tipo">Tipo</th>
                          <th class="tbDisp-Min">Max</th>
                          <th class="tbDisp-Max">Min</th>
                          <th class="tbDisp-Renta">Renta<br>Salida</th> 
                          <th class="tbDisp-Fecha">@Fecha</th> 
                        </tr>
                      </thead>
                    </table>
             </div>
            <!--  : titulares   ///////////////////////////////////////////////////////////-->
           
            <div class="dispA">
           		<div class="dispA-img">
                    <img src="../img/info/h2hocio.jpg" class="img-responsive"> 
                </div>  
                <div class="dispA-intermediario">
                    <img src="../img/empresas/aguirre_newman.jpg"><img src="../img/empresas/cw.jpg"><img src="../img/empresas/jones_lang_lasalle.jpg">
                    <span class="icon-circle-down"></span>
                </div>      
           		<div class="dispA-direccion">CASTELLANA 77</div> 
                <div class="dispA-localidad">Madrid</div> 
                <div class="dispB">  
                    <table class="tbDispon">
                        <tr>
                          <td class="tbDisp-Plta"></th>
                          <td class="tbDisp-Tipo">Oficinas</td>
                          <td class="tbDisp-Min">880</td>
                          <td class="tbDisp-Max">1200</td>
                          <td class="tbDisp-Renta">50</td>
                          <td class="tbDisp-Fecha">05/15</td>
                        </tr>
                     </table>
					<div class="tb-despliega">
                        <table class="tbDispon">
                            <tr>
                              <td class="tbDisp-Plta">PT 2</th>
                              <td class="tbDisp-Tipo">Oficinas</td>
                              <td class="tbDisp-Min">880</td>
                              <td class="tbDisp-Max">1200</td>
                              <td class="tbDisp-Renta">50</td>
                              <td class="tbDisp-Fecha">05/15</td>
                            </tr>
                            <tr>
                              <td class="tbDisp-Plta">PT 1</th>
                              <td class="tbDisp-Tipo">Oficinas</td>
                              <td class="tbDisp-Min">880</td>
                              <td class="tbDisp-Max">1200</td>
                              <td class="tbDisp-Renta">50</td>
                              <td class="tbDisp-Fecha">05/15</td>
                            </tr>
                            <tr>
                              <td class="tbDisp-Plta">BJ</th>
                              <td class="tbDisp-Tipo">Oficinas</td>
                              <td class="tbDisp-Min">880</td>
                              <td class="tbDisp-Max">1200</td>
                              <td class="tbDisp-Renta">50</td>
                              <td class="tbDisp-Fecha">05/15</td>
                            </tr>
                        </table>
                    </div>
               </div>
            </div><!-- :: disA/ --> 
            



           </div>





<div class="divCajaMapa" style="display:block;"><!--divDispon clearfix-->
			<!--<button type="button" class="close"><span aria-hidden="true">×</span></button>-->
             <div class="contadorSelect">
                <span class="numero">15</span>
                <span class="icon-checkmark"></span>
                <input name="" type="submit" value="Ver fichas" class="btn btn-sm"> <!-- btn-xs-->
             </div>
            <p class="grisClaro_color">El límite es 20 </p>
 </div>
 
 
 
 
<div class="divCajaMapa" style="display:block;top:300px"><!--divDispon clearfix-->
			<!--<button type="button" class="close"><span aria-hidden="true">×</span></button>-->
            
            <p>No se han encontrado resultados para esta busqueda.</p>
            <p>Por favor, amplíe la busqueda. </p>
</div>
            
     
 </div> 






  
</div></div></div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
