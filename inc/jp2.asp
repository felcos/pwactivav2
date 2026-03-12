<!DOCTYPE html>
<html lang="es">
<head>
<title>PropertyWeb </title>
<!--#include virtual="/inc/head.asp" -->

<link href="/css/css-pags/tabs031-izq.css" rel="stylesheet" type="text/css">
<link href="/css/css-pags/mapaCoord.css" rel="stylesheet" type="text/css">

<style type="text/css">
.info-buscar span button {              /* cambiar  form_boots.css  */
    color: #fff;
    background: #2B4E61 ;
    width: 40px;
    height: 34px;
}

.info-buscar span button.icon-notification {
    background: #A94442;
}

</style>

<!--#include virtual="/inc/js.asp" -->

<script type="text/javascript">
$(document).ready(function(){     

			 //	Quitar EL MENSAJE QUE SALE y sustituir por: " por favor chequea una opción antes "

	$("#frmInfo_busq").focus(function(){    //añadir condición si ya esta seleccionado on o
		
		 $(this).siblings("span").find("button").removeClass("icon-search").addClass("icon-notification");
		 $(this).parent().addClass("has-error");
		//alert("hola");
	});
	
	$("#frmInfo_busq").blur(function(){   
		
		 $(this).siblings("span").find("button").removeClass("icon-notification").addClass("icon-search");
		 $(this).parent().removeClass("has-error");

	});
	
	
});	
</script>
</head>
<body>
<!-- include virtual="/inc/body-header.asp" -->
<div class="container">
  <h1>Property</h1>
  <div class="col-sm-12 col-md-7">
    <div class="row buscadores"> 
      <!--colInfo -->
      <div class="col-sm-6 colInfo" id="head_div_info">
        <h1>Seleccionar Info:</h1>
        <form action="/info/" method="post" id="frmInfo">
          <ul>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="prop" id="frmInfo_prop">
              <label for="frmInfo_prop" id="lblInfo_prop" class="lblInfo "><span class="icon-key"></span> Propietario Actual</label>
            </li>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="cc" id="frmInfo_cc">
              <label for="frmInfo_cc" id="lblInfo_cc" class="lblInfo "><span class="icon-coin-euro"></span> Centro Comercial</label>
            </li>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="hot" id="frmInfo_hot">
              <label for="frmInfo_hot" id="lblInfo_hot" class="lblInfo "><span class="icon-home"></span> Hotel</label>
            </li>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="edif" id="frmInfo_edif">
              <label for="frmInfo_edif" id="lblInfo_edif" class="lblInfo "><span class="icon-office"></span> Edificio o Dirección</label>
            </li>
            <li class="indent">
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="disponib" id="frmInfo_disponib">
              <label for="frmInfo_disp" id="lblInfo_disp" class="lblInfo "><span class="icon-checkmark"></span> Disponibilidad</label>
            </li>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="empr" id="frmInfo_empr">
              <label for="frmInfo_empr" id="lblInfo_empr" class="lblInfo "><span class="icon-briefcase"></span> Empresa</label>
            </li>
            <li>
              <input name="frmInfo_tipo" type="radio" class="infoRadio frmInfo_tipo" value="retail" id="frmInfo_retail" disabled="disabled">
              <label for="frmInfo_retail" id="lblInfo_retail" class="lblInfo "><span class="icon-road"></span> Info - Calle <span class="enconstruccion">(en construcción)</span></label>
            </li>
            
            
            
            <li>
              <div class="inputField">
                <div class="input-group info-buscar" id="info-buscar">  <!-- has-error has-feedback --> 
                  <input type="text" class="form-control" value="" placeholder="" id="frmInfo_busq" name="frmInfo_busq" autocomplete="off">
                 <!-- <span class="form-control-feedback "   aria-hidden="true"> </span>-->             
                  <span class="input-group-btn">
                  	<button class="btn btn-default icon-search" type="submit" id="frmInfo-submit"> </button> <!-- .icon-notification --> 
                  </span> 
                </div>
          
          
          
          
                <div id="info-propietarios" style="display:none;">
                  <select id="frmInfo_propietario" name="frmInfo_propietario" disabled="" class="form-control info-buscar ">
                    <option value="" selected="">Seleccione Propietario</option>
                    <option value="" selected="">Seleccione Propietario</option>
                    <option value="" selected="">Seleccione Propietario</option>            
                  </select>
                </div>
                
                
                               
                
                
    <div class="form-group has-error has-feedback">      <!--  has-error (rojo) has-feddback (para colocar icono .relative) --> 
        <label class="control-label" >Input with error</label> 
        
        <input type="text" class="form-control" id="prueba02">
        
      	 <span class="form-control-feedback icon-arrow-right2 " aria-hidden="true"> </span> 
     </div>

                <!--  tip-caja -->
                
                <div class="tip-caja fade right in" role="" id="frmInfo-tip" style="display: none;">
                  <div class="arrow"></div>
                  <div class="tip-title" id="frmInfo-tip-title">Para comenzar la búsqueda.</div>
                  <div class="tip-content" id="frmInfo-tip-content">Selecciona un <span class="naranjaB">Tipo de Búsqueda</span> e indica el nombre a buscar</div>
                </div>
                
                <!-- 
 style="display:block;"
  tip : fin--> 
                
              </div>
              <!--inputField : fin--> 
              
            </li>
          </ul>
        </form>
      </div>
      <!--colBusqueda-->
      <div class="col-sm-6 colBusqueda" id="head_div_busq">
        <h1>Búsquedas:</h1>
        <ul>
          <li><a href="/dealanalysis/">Deal Analysis</a> </li>
          <li><a href="/actualidad/">Noticias</a> </li>
          <li><a href="/estudios/">Estudio de mercado</a> </li>
          <li><a href="/inversores/">Inversores</a> </li>
          <li><a href="/demandas/">Demandas</a> </li>
          <li><a href="/vencimientos/">Vencimientos de contrato</a> </li>
          <li><a href="/subastas/">Subastas/Concursos</a> </li>
          <li><a href="https://www.easyproperty.es/" target="_blank" class="logEasy"><img src="/img/shared/EasyProperty.png" alt="">EasyProperty</a></li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!--include virtual="/inc/body-footer.asp" -->
</body>
</html>
