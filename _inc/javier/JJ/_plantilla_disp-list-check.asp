<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>

<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="../../../css/css-pags/tabs02.css">

<!-- duplicado 
<link href="/_inc/javier/titulos.css" rel="stylesheet" type="text/css"/>
<link href="/_inc/javier/titulos_info.css" rel="stylesheet" type="text/css"/>
<link href="/_inc/javier/titulos_operaciones.css" rel="stylesheet" type="text/css"/> -->
<!-- :: duplicado  -->

</head><body>
<!--#include virtual="/inc/body-header.asp" --> 


<script>
$(document).ready(function() {


$(".dispA-img").click(function(e){
	 alert("Fancy box de la imagen");
	e.stopPropagation();
	});
	
$(".dispA_check input[type='checkbox']").click(function(e){
	/* alert("CHECK ACTIVO");*/
	e.stopPropagation();
	});	

$(".dispA_check").click(function(e){

	if( $(this).find("input[type='checkbox']").prop('checked') ){
		 $(this).find("input[type='checkbox']").prop("checked", false);
	} else {
		$(this).find("input[type='checkbox']").prop("checked", "checked");

	}

	e.stopPropagation();
});	
	
	

/*
	
		
			
	
			if( parseInt($(".divCajaCheck .contadorSelect").css("marginTop"))==0){
					$(".divCajaCheck .contadorSelect").animate({marginTop:'-45px'});
				}else {
					$(".divCajaCheck .contadorSelect").animate({marginTop:'0px'});
					}*/

	

/*
		var a= 0;
	$("#btCheck").on('click',function(){
		
		
			$(".divCajaCheck").slideToggle();
	
			if(a==1){
					$(".divCajaCheck .contadorSelect").animate({marginTop:'-45px'});
					a=0;
				
				}else {
					$(".divCajaCheck .contadorSelect").animate({marginTop:'0px'});
					a=1;
					
					}
			
			
			
	
	});*/



$(".dispA").click(function(){
/*	alert($(this).html());*/
	
	
	if($(this).find(".tb-despliega").hasClass("activo")){
		$(this).find(".tb-despliega").slideUp("swing").removeClass("activo"); 
		$(this).find(".dispA-direccion").removeClass("activo");
		}else {	
		$(".dispA").find(".tb-despliega.activo").slideUp("swing").removeClass("activo");
		$(".dispA").find(".dispA-direccion.activo").removeClass("activo");
		$(this).find(".tb-despliega").slideDown("swing").addClass("activo");  /*,*/
		$(this).find(".dispA-direccion").addClass("activo"); 
		}
	
 
	});





});	

</script>



<!--  : fin alert-->

<div class="container">
  <section id="s_titulos" class="row">
    <div id="result" class="caja"> 
      <!-- include virtual="/info/busq/inc_inmuebles_header.asp" -->
      
      <div class="DealTabs">
        <ul class="nav nav-tabs lineNavs" style="">
          <li class="active"><a href="#listado" data-toggle="tab" aria-expanded="true">Listado</a></li>
          <li class=""><a href="#mapa" data-toggle="tab" aria-expanded="false">Mapa</a></li>
        </ul>
        <div class="tab-content">
          <div class="tab-pane active" id="listado"> 
            <!--  listado   ///////////////////////////////////////////////////////////-->
            
            
       
           
         <div class="divDispon clearfix">
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
                <div class="dispA_check"><input type="checkbox" name="" value="" class="chexbox" id=""></div>
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
            
            <div class="dispA">
                <div class="dispA_check"><input type="checkbox" name="" value="" class="chexbox" id=""></div>
           		<div class="dispA-img">
              <!--      <img src="img/info/h2hocio.jpg" class="img-responsive"> -->
                </div>  
                <div class="dispA-intermediario">
                    <img src="../img/empresas/aguirre_newman.jpg"><img src="../img/empresas/cw.jpg"><img src="../img/empresas/jones_lang_lasalle.jpg">
                    <span class="icon-circle-down"></span>
                </div>      
           		<div class="dispA-direccion">CASTELLANA 77</div> 
                <div class="dispA-localidad">Barcelona</div> 
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
            
            <div class="dispA">
                <div class="dispA_check"><input type="checkbox" name="" value="" class="chexbox" id=""></div>
           		<div class="dispA-img">
                    <img src="../img/info/h2hocio.jpg" class="img-responsive"> 
                </div>  
                <div class="dispA-intermediario">
                    <img src="../img/empresas/aguirre_newman.jpg"><img src="../img/empresas/cw.jpg"><img src="../img/empresas/jones_lang_lasalle.jpg">
                    <span class="icon-circle-down"></span>
                </div>      
           		<div class="dispA-direccion">CASTELLANA 77</div> 
                <div class="dispA-localidad">Barcelona de abajo</div> 
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
            
            <div class="dispA">
                <div class="dispA_check"><input type="checkbox" name="" value="" class="chexbox" id=""></div>
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


           </div> <!-- :: divDispon/ --> 
           
                      
            <!-- :: listado ////////////////////////// --> 
          </div>
          <div class="tab-pane" id="mapa"> </div>
        </div>
      </div>
    </div>
  </section>
</div>
<!-- :: container  --> 

<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
