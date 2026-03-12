<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->
<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">
<link href="/inc/slideshow/slideshow_javier.css" rel="stylesheet" type="text/css">

<script type="text/javascript">

$(document).ready(function(){
/*
$(".cabecera-sub").on("click", function (){
	     var pepe = $(this).find("a").attr("id");
		alert(pepe);*/
		

$(".filaLat").on("click", function (){   /* :not(.filaLat-cabecera)                    .filaLat.cabecera  */
	     var pepe = $(this).find("a").attr("id");
		alert(pepe);
		
		
});

/*

on("click", hola);
function hola(){
		alert("hola");
	}*/

})<!--:js-->

</script>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->

<!--<link href="/_inc/javier/estilos_jm-back.css" rel="stylesheet" type="text/css">-->


<div class="container">

 <div class="row caja">

    <div class="col-d-120"> 
    <h3 class="tit_mod ">Select</h3><!--<span style="font-weight:normal"></span>-->
    </div> 
    <div class="col-pdgd-120"> 
    <h3 class="tit_mod ">Oficinas Madrid</h3><!--<span style="font-weight:normal"></span>-->
    </div>  
<!--  dropdown  -->
 
<!--  : dropdown  -->

    <div class="col-md-12">
<!--  tabla valida  -->
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
   
    <tr class="filaLat">
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
   </div>
   
    
    <div class="tb-Gral-cont deal-ciudad">
    
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
        <!-- la segunda parte -->
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
        
        
        </div><!-- :table -->
        
        
        
        
        
    
    
    </div><!-- :col -->
    
    
    </div><!-- :caja -->
</div>  
  























<!--
  <div class="caja clearfix">
    <div class="caja_ancha">
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_jp">
        <tbody>
          <tr>
            <td width="175">Comprador</td>
            <td width="2"></td>
            <td width="175">Vendedor</td>
            <td width="2"></td>
            <td><table cellpadding="0" cellspacing="0" style="border:0px;">
                <tbody>
                  <tr>
                    <td align="right" style="border:0px;" width="50">M²</td>
                    <td style="border:0px;" width="30"></td>
                    <td style="border:0px;" width="20"></td>
                    <td style="border:0px;" width="50">Planta</td>
                  </tr>
                </tbody>
              </table></td>
            <td width="20"></td>
            <td>Precio &nbsp; €</td>
            <td width="5"></td>
            <td width="240">Intermediario</td>
          </tr>
          <tr>
            <td valign="top"><div>
                <p>gmp</p>
              </div></td>
            <td></td>
            <td valign="top"><div>
                <p>ge real estate</p>
                <p>gmp</p>
              </div></td>
            <td></td>
            <td valign="top"><table cellpadding="0" cellspacing="0" class="tbl_plantas">
                <tbody>
                  <tr>
                    <td align="right" width="40">1.309</td>
                    <td width="10"></td>
                    <td width="30">S/R</td>
                    <td width="20"></td>
                    <td width="50" align="right">3 </td>
                  </tr>
                  <tr>
                    <td align="right" width="40">2.915</td>
                    <td width="10"></td>
                    <td width="30">S/R</td>
                    <td width="20"></td>
                    <td width="50" align="right">ENTREPLANTA </td>
                  </tr>
                  <tr>
                    <td align="right" width="40">4.327</td>
                    <td width="10"></td>
                    <td width="30">S/R</td>
                    <td width="20"></td>
                    <td width="50" align="right">BAJA </td>
                  </tr>
                  <tr>
                    <td align="right" style="border-bottom:0; font-size:13px; font-weight:bold;">23.138</td>
                    <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
                    <td style="border-bottom:0; font-size:13px; font-weight:bold;">&nbsp;M²</td>
                    <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
                    <td style="border-bottom:0; font-size:13px; font-weight:bold; text-align:right;">&nbsp;</td>
                  </tr>
                </tbody>
              </table></td>
            <td></td>
            <td valign="top"><p>24.500.000</p></td>
            <td></td>
            <td valign="top"><div>
                <p>aguirre newman  (V)</p>
              </div></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
-->
  
  <div class="row caja">
    <div class="col-md-9">

    
    <br><br>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tbl_jp">
        <tbody>
          <tr>
            <td width="175">Comprador</td>
            <td width="2"></td>
            <td width="175">Vendedor</td>
            <td width="2"></td>
            <td>&nbsp;</td>
            <td width="20"></td>
            <td>Precio &nbsp; €</td>
            <td width="5"></td>
            <td width="240">Intermediario</td>
          </tr>
          <tr>
            <td valign="top"><div>
                <p>gmp</p>
              </div></td>
            <td></td>
            <td valign="top"><div>
                <p>ge real estate</p>
                <p>gmp</p>
              </div></td>
            <td></td>
            <td valign="top"></td>
            <td></td>
            <td valign="top"><p>24.500.000</p></td>
            <td></td>
            <td valign="top"><div>
                <p>aguirre newman  (V)</p>
              </div></td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- fin col 9 :: -->
    <div class="col-md-3"> 
      <!--tabla 2-->
      <table cellpadding="0" cellspacing="0" style="border:0px;" class="tbl_plantas">
        <tbody>
          <tr>
            <td align="right" style="border:0px;" width="50">M²</td>
            <td style="border:0px;" width="30"></td>
            <td style="border:0px;" width="20"></td>
            <td style="border:0px;" width="50">Planta</td>
          </tr>
          <tr>
            <td align="right" width="40">1.309</td>
            <td width="10"></td>
            <td width="30">S/R</td>
            <td width="20"></td>
            <td width="50" align="right">3 </td>
          </tr>
          <tr>
            <td align="right" width="40">2.915</td>
            <td width="10"></td>
            <td width="30">S/R</td>
            <td width="20"></td>
            <td width="50" align="right">ENTREPLANTA </td>
          </tr>
          <tr>
            <td align="right" width="40">4.327</td>
            <td width="10"></td>
            <td width="30">S/R</td>
            <td width="20"></td>
            <td width="50" align="right">BAJA </td>
          </tr>
          <tr>
            <td align="right" style="border-bottom:0; font-size:13px; font-weight:bold;">23.138</td>
            <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
            <td style="border-bottom:0; font-size:13px; font-weight:bold;">&nbsp;M²</td>
            <td style="border-bottom:0; font-size:13px; font-weight:bold;"></td>
            <td style="border-bottom:0; font-size:13px; font-weight:bold; text-align:right;">&nbsp;</td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- fin col 3 :: --> 
  </div>
  
 <div class="row caja">
    <div class="col-md-12">
    <table class="tb-Gral">             <!--   //////  TIPO    ///////-->
    		<thead>
                <tr>
                    <th >Comprador</th>
                    <th >Vendedor</th>
                    <th >Precio </th>
                    <th >Intermediario</th>                   
                </tr>
    		<thead>
            <tbody>
				<tr>
                	<td>gmp JJ //</td>
                    <td>ge real estate <br>gms</td>
                    <td>24.500.000</td>
                    <td>aguirre newman (V) </td>
                </tr>
    		</tbody>
    </table>
    </div>
</div>  
  
  

  
  
  
  
  
  
  <div class="row caja">
    <div class="col-md-12">
     
<table width="100%" cellspacing="0" cellpadding="0" border="0" class="venc">
<tbody>
<!--    
<tr valign="bottom">
    <td></td>
    <td>Inquilinos</td>
    <td width="10"></td>
    <td>Dirección</td>
    <td align="right" width="110">M² actuales&nbsp;</td>
    <td width="10"></td>
    <td align="right" width="110"> &nbsp; &nbsp; Posible&nbsp;<br>&nbsp;vencimiento&nbsp;</td>
</tr>-->
<tr valign="bottom">
    <td class="check"></td>
    <td class="direccion">Dirección</td>
    <td class="vacio"></td>
    <td class="inquilinos">Inquilinos</td>
    <td class="actuales" align="right">M² actuales&nbsp;</td>
    <td class="vacio"></td>
    <td class="vencimiento" align="right">Posible&nbsp; vencimiento</td>
</tr>

<tr valign="top">
    <td class="check">[1]<input name="ven" value="84" type="checkbox"></td>
    <td class="direccion"><a href="/articulos/?ven=84" class="simplemodal">MIRO</a></td>
    <td class="vacio"></td>
    <td class="inquilinos"><a href="/articulos/?ven=84" class="simplemodal">CARRETERA EXTREMADURA<br>MADRID</a></td>
    <td class="actuales" align="right"><a href="/articulos/?ven=84" class="simplemodal">1.400&nbsp;m²&nbsp;</a></td>
    <td class="vacio"></td>
    <td class="vencimiento" align="right"><a href="/articulos/?ven=84" class="simplemodal">01/10/2015</a>&nbsp;</td>
</tr> 
    

<tr valign="top">
    <td class="check">[2]<input name="ven" value="630" type="checkbox"></td>
    <td class="direccion"><a href="/articulos/?ven=630" class="simplemodal">EMPRESA DE FINANZAS</a></td>
    <td class="vacio"></td>
    <td class="inquilinos"><a href="/articulos/?ven=630" class="simplemodal">CALLE MARIA TUBAU<br>MADRID</a></td>
    <td class="actuales"align="right"><a href="/articulos/?ven=630" class="simplemodal">11.500&nbsp;m²&nbsp;</a></td>
    <td class="vacio"></td>
    <td class="vencimiento"align="right"><a href="/articulos/?ven=630" class="simplemodal">01/11/2015</a>&nbsp;</td>
</tr> 
    


<tr valign="top">
    <td class="check">[2]<input name="ven" value="630" type="checkbox"></td>
    <td class="direccion"><a href="/articulos/?ven=630" class="simplemodal">EMPRESA DE FINANZAS</a></td>
    <td class="vacio"></td>
    <td class="inquilinos"><a href="/articulos/?ven=630" class="simplemodal">AVENIDA VIA DE LOS POBLADOS<br>MADRID</a></td>
    <td class="actuales"align="right"><a href="/articulos/?ven=630" class="simplemodal">11.500&nbsp;m²&nbsp;</a></td>
    <td class="vacio"></td>
    <td class="vencimiento"align="right"><a href="/articulos/?ven=630" class="simplemodal">01/11/2015</a>&nbsp;</td>
</tr> 


<tr valign="top">
    <td class="check">[2]<input name="ven" value="630" type="checkbox"></td>
    <td class="direccion"><a href="/articulos/?ven=630" class="simplemodal">EMPRESA DE SERVICIOS sdafasd</a></td>
    <td class="vacio"></td>
    <td class="inquilinos"><a href="/articulos/?ven=630" class="simplemodal">AVENIDA VIA DE LOS POBLADOS<br>MADRID</a></td>
    <td class="actuales"align="right"><a href="/articulos/?ven=630" class="simplemodal">11.500&nbsp;m²&nbsp;</a></td>
    <td class="vacio"></td>
    <td class="vencimiento"align="right"><a href="/articulos/?ven=630" class="simplemodal">01/11/2015</a>&nbsp;</td>
</tr> 



    

    
</tbody></table>
     
    </div>
  </div>
  
  
  
  
</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
