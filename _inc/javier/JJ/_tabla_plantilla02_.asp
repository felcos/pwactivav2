<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->
<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">
<link href="/inc/slideshow/slideshow_javier.css" rel="stylesheet" type="text/css">
</head><body>
<!--#include virtual="/inc/body-header.asp" --> 
<script type="text/javascript">

$(document).ready(function() {  
 
$('[data-toggle="popover"]').popover(); 

$('.btn-notas').click(function(){
		   $('.popover').addClass("popoverNotas");
		  });	

});	
	 



 </script>
<!--<link href="/_inc/javier/estilos_jm-back.css" rel="stylesheet" type="text/css">-->

<div class="container ">
    <div class=" ">
    
    	<p> tb-Gral tb-propiedad  :: SUBASTA </p>
        
        <div class="row caja">
        
       <div  class="tb-Gral-cont">
       
        
                 
       <table class="tb-Gral tb-subastas"> 
             <thead>
             <tr>
                <th>Dirección</th>

                <th>Seccion</th>

                <th>Superficie</th>

                <th>Uso</th>

                <th>Sup. Edificable</th>

                <th>Precio</th>

                <th>Comentarios</th>
            </tr>
            </thead>
             <tbody>
                <tr>
            <td class="direc"> Avenida Bueno Monreal 58</td>

            <td class="secc"></td>

            <td class="super">8.000 M ²</td>

            <td class="uso">abierto</td>

            <td class="edif"></td>

            <td class="prec"></td>

            <td class="comen"></td>
                </tr>
                
                <tr>
            <td class="direc"> terrenos Parque de Aguas avenida de las Razas</td>

            <td class="secc"></td>

            <td class="super">3.000 M ²</td>

            <td class="uso">abierto</td>

            <td class="edif"></td>

            <td class="edif"></td>

            <td class="edif"></td>
                </tr>
                
            <tr>
                <td></td>

                <td></td>

                <td></td>

                <td></td>

                <td></td>

                <td></td>

                <td></td>
            </tr>
                         </thead>
        </tbody></table>
          
            

               </div>  <!--tb gnral-->
         
        </div>
	</div>
</div>
<div class="container ">
<div class=" tablas ">
<!--tabla Historico Disponibilidad-->
<div class="caja">
  <p> tb-Gral :: infoEdificio (historico disponiblidad)</p>
  <table class="tb-Gral tb-dispoHistorico">  
                                <thead>  
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Disponibilidad<span class="breakPalabra"></span>/M<sup>2</sup></th>	
                                        <th>% Vacío</th>	
                                        <th>Renta Mín (€/M<sup>2</sup>/Mes)</th>
                                        <th>Renta Máx (€/M<sup>2</sup>/Mes)</th>
                                        <th>Notas</th>
                                    </tr>
                                </thead> 
                                <tbody>
                                    
                                        <tr>
                                            <td>09/15</td>
                                            <td>1.256</td>
                                            <td>0,03</td>
                                            <td></td>
                                            <td></td>
                                            <td>                             
<button type="button" class="btn btn-notas" data-container="body" data-toggle="popover" data-placement="bottom" data-content="@ 2015 - 11/2015 Empresa alquila local 120 m2 con renta de salida de 27 €/M2/Mes"><span class="icon-pushpin"></span>
</button>
                                         </td>
                                        </tr>
                                        
                                        <tr>
                                            <td>10/15</td>
                                            <td>21.045</td>
                                            <td>50</td>
                                            <td></td>
                                            <td></td>
                                            <td>
                                            <button type="button" class="btn btn-notas" data-container="body" data-toggle="popover" data-placement="bottom" data-content="El espacio de KPMG"><span class="icon-pushpin"></span>
</button></td>
                                        </tr>
                                        
                                </tbody> 
                            </table>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    	<table class="tb-Gral tb-dispoHistorico">  
        	<thead>  
                <tr>
                    <th>Fecha</th>
                    <th>Disponibilidad<span class="breakPalabra"></span>/M<sup>2</sup></th>	
                    <th>% Vacio</th>	
                    <th>Renta Salida €/M<sup>2</sup>/M</th>		
                </tr>
        	</thead> 
            <tbody>
            	<tr>
					<td>12/15</td>
					<td>200</td>
					<td>50</td>
					<td>20</td>
                </tr>				
            </tbody> 
        </table>
</div>
<!--propiedad-->
  <p> tb-Gral tb-propiedad  :: INFO (cabecera)</p>
  <div class="row caja" style="width:50%;">
      <div class="col-sm-8">
			<table class="tb-Gral tb-propiedad">
                    <thead>            
                    <tr>
                        <th><strong>PROPIEDAD:</strong></th>
                        <th>desde</th>
                        <th>hasta</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>ALPHA REAL CAPITAL</td>	
                        <td>mar/2010</td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>MARE NOSTRUM</td>
                        <td>ene/1989</td>
                        <td>jul/1992</td>
                    </tr>
                 </tbody>
                </table>
	  </div>
      <div class="col-sm-4">

	  </div>
  </div>

<!--OCUPANTES-->
  <p> tb-Gral tb-Ocupacion  :: info/c.Comerciales/ OCUPANTES</p>
  <div class="row caja " style="width:50%;">
      <div class="col-sm-8">
			<table class="tb-Gral tb-Ocupacion">
  <tbody>
    <tr class="subHeader">
      <td> MODA Y COMPLEMENTOS</td>
      <td>11.260 m²</td>
    </tr>

    <tr>
      <td>H&amp;M</td>
      <td>2.115 m²</td>
    </tr>
    <tr class="total03">
      <td>ZARA</td>
      <td>1.830 m²</td>
    </tr>
    <tr>
      <td>PULL AND BEAR</td>
      <td>495 m²</td>
    </tr>
    <tr>
      <td>BENETTON</td>
      <td>520 m²</td>
    </tr>
    <tr>
      <td>BLANCO</td>
      <td>545 m²</td>
    </tr>
    <tr>
      <td>SFERA</td>
      <td>1.925 m²</td>
    </tr>
    <tr>
      <td>C&amp;A</td>
      <td>1.810 m²</td>
    </tr>
    <tr>
      <td>CORTEFIEL</td>
      <td>785 m²</td>
    </tr>
    <tr>
      <td>BERSHKA</td>
      <td>655 m²</td>
    </tr>
    <tr>
      <td>MASSIMO DUTTI</td>
      <td>580 m²</td>
    </tr>
    <tr class="total03">
      <td>subtotal: </td>
      <td>11.260 m²</td>
    </tr>
    

  
    <tr class="subHeader">
      <td>RESTAURACIÓN Y OCIO</td>
      <td>10.855 m²</td>
    </tr>


    <tr>
      <td>YELMO CINEPLEX</td>
      <td>5.400 m²</td>
    </tr>
    <tr>
      <td>OZONE BOWLING</td>
      <td>2.325 m²</td>
    </tr>
    <tr>
      <td>MR WOK</td>
      <td>880 m²</td>
    </tr>
    <tr>
      <td>VIPS-GINOS</td>
      <td>690 m²</td>
    </tr>
    <tr>
      <td>MUERDE LA PASTA</td>
      <td>515 m²</td>
    </tr>
    <tr>
      <td>BURGER KING</td>
      <td>360 m²</td>
    </tr>
    <tr>
      <td>FRIDAYS</td>
      <td>355 m²</td>
    </tr>
    <tr>
      <td>DI BOCCA</td>
      <td>330 m²</td>
    </tr>
    <tr class="total03">
      <td>subtotal: </td>
      <td>10.855 m²</td>
    </tr>
    
    <tr class="subHeader">
      <td>ALIMENTACIÓN</td>
      <td>3.110 m²</td>
    </tr>

    <tr>
      <td>MERCADONA</td>
      <td>3.110 m²</td>
    </tr>
    <tr class="total03">
      <td>subtotal: </td>
      <td>3.110 m²</td>
    </tr>
 
  <tr class="total">
    <td><strong>Total:</strong>&nbsp;</td>
    <td><strong>25.225 m²</strong></td>
  </tr>
    </tbody>
  
</table>
	  </div>

  </div>
</div><!-- .tablas: fin-->
















<!--deal ALQUILER-->              <!-- ////////////      actualizado            //////////////////////-->
<div class="caja">
 <div class="tablas tb-Gral-cont "> 
  <p> tb-Gral planta / tb-Gral  :: operacion/deal ALQUILER</p>
  <div class="row "> 
    <div class="col-xs-2">
      <table class="tb-Gral planta">
        <thead>
          <tr>
            <th >Plt</th>
            <th>Uso</th>
            <th>M²</th>
            <th>plzs/<span class="breakPalabra"></span>habs.</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>7 </td>
			<td>oficinas</td>
            <td>535</td>
            <td>24</td>
            <td>B/R</td>
          </tr>
          <tr>
            <td>6 </td>
            <td>oficinas</td>
            <td>835</td>
            <td>24</td>
            <td>B/R</td>
          </tr>
          <tr>
            <td>5 </td>
            <td>oficinas</td>
            <td>835</td>
            <td>24</td>
            <td>B/R</td>
          </tr>
          <tr class="total"	>
            <td>T </td>
            <td>oficinas</td>
            <td>2.205</td>
            <td>24</td>
            <td>B/R</td>
          </tr>
          
          <tr class="total02">
            <td></td>
            <td>oficinas</td>
            <td></td>
            <td>24</td>
            <td>B/R</td>
          </tr>
          
          
          
        </tbody>
      </table>
    </div>

    <div class="col-xs-10">

        <table class="tb-Gral">
          <thead>
            <tr>
              <th>Inquilino</th>
              <th>Propietario</th>
              <th>Renta<br><div class="renta"><span>(€/</span><span>m2/</span><span>mes)</span></div></th>
              <th>Fecha Contrato</th>
              <th>Intermediario</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><p>broseta abogados</p></td>
              <td>gmp JJ //</td>
              <td>27,00</td>
              <td>09/15-09/20</td>
              <td>gabinete inmobiliario  (P)</td>
            </tr>
          </tbody>
        </table>

    </div>

  </div><!-- row 22 tabla:fin  -->
</div><!-- .tablas: fin-->
 </div><!-- .caja: fin--> 
  
  
  
  
  
  
  
  <!-- CONTENEDORES EN GENERAL-->

</div><!-- .container: fin-->


























































<div class="container tablas">

<!-- deal ALQUILER DERECHA ...
  <p>tb-Gral / tb-Gral planta  :: operacion/deal ALQUILER</p>
  <div class="row caja"> 
    <div class="col-sm-8">
      <div class="tb-Gral-cont ">
        <table class="tb-Gral">
          <thead>
            <tr>
              <th >Comprador</th>
              <th >Vendedor</th>
              <th>Propietario</th>
              <th >Precio </th>
              <th >Intermediario</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>gmp JJ //</td>
              <td>ge real estate <br>
                gms</td>
              <td>24.500.000</td>
              <td>aguirre newman (V) </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="col-sm-4">
      <table class="tb-Gral planta">
        <thead>
          <tr>
            <th >Planta
              </td>
            <th>M²
              </td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>3</td>
            <td>1.309 S/R</td>
          </tr>
          <tr>
            <td>ENTREPLANTA</td>
            <td>2.915 S/R</td>
          </tr>
          <tr>
            <td>BAJA</td>
            <td>4.327 S/R</td>
          </tr>
          <tr>
            <td>TOTAL </td>
            <td>23.138 M²</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
-->

<!-- deal INVERSION DERECHA ...
  <p>tb-Gral / tb-Gral planta :: operacion/deal INVERSION</p>
  <div class="row caja"> 
    <div class="col-sm-8">
      <div class="tb-Gral-cont ">
        <table class="tb-Gral">
          <thead>
            <tr>
              <th>Inquilino</th>
              <th>Propietario</th>
              <th>Renta <span class="renta">(€/m2/mes)</span></th>
              <th>Fecha Contrato</th>
              <th>Intermediario</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><p>broseta abogados</p></td>
              <td></td>
              <td>27,00</td>
              <td>ini: 01/09/2015<br>
                fin: 01/09/2020</td>
              <td>gabinete inmobiliario  (P)</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="col-sm-4">
      <table class="tb-Gral planta">
        <thead>
          <tr>
            <th >Planta
              </td>
            <th>M²
              </td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td class="tbl_plantas">7 </td>
            <td class="tbl_plantas">535 S/R</td>
          </tr>
          <tr>
            <td class="tbl_plantas">6 </td>
            <td class="tbl_plantas">835 S/R</td>
          </tr>
          <tr>
            <td class="tbl_plantas">5 </td>
            <td class="tbl_plantas">835 S/R</td>
          </tr>
          <tr>
            <td>TOTAL </td>
            <td class="tbl_plantas">2.205&nbsp;M²</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
-->

</div>


<div class="container">
   <!--  PABLO : TABLA PARA disponibilidad -->
    

   <div class="caja">
  <!--   -->
  <div class="detalles clearfix">
    <div class="bloqueLeft slider01">
    

   
      <div id="carousel01" class="carousel slide" data-pause="true"><!--data-ride="carousel"  carousel-example-generic-->
        <ol class="carousel-indicators">
          <li data-target="#carousel01" data-slide-to="0" class="active"></li>
          <li data-target="#carousel01" data-slide-to="1" class=""></li>
        </ol>
        
        <div class="carousel-inner" role="listbox">
          <div class="item active"><a class="fancybox" href="/fotos/inmuebles/002294-1.jpg" data-fancybox-group="gallery" title=""><img src="/lib/showThumb.aspx?maxsize=450&amp;img=/fotos/inmuebles/002294-1.jpg&amp;rnd=705" alt=""></a></div>
          
        </div>
          </div>
      <div class="separator"></div>
    </div>
    <div class="bloqueRight tablas tb-Gral-cont ">
      <h3>Disponibilidad por Plantas:</h3>
      <div class="row">
        <div class="col-sm-8">
          <div class=""><!--tb-Gral-cont-->
            <table class="tb-Gral tb-info">
              <thead>
                <tr>
                  <th>&nbsp;</th>
                  <th></th>
                  <!-- 
        <th></th>
        <th></th>
        -->                  </tr>
                <tr>
                  <th>Plt</th>
                  <th>Uso</th>
                  <!--
        <th>M&sup2; SBA</th>
        <th>M&sup2; Const.</th>
        -->                  </tr>
              </thead>
              <tbody>
                <tr>
                  <td>14</td>
                  <td>oficinas</td>
                  <!-- 
        <td>< %= ver_sba %></td>
        <td>< %= ver_cons %></td>
        -->                  </tr>
                <tr>
                  <td>9</td>
                  <td>oficinas</td>
                  <!-- 
        <td>< %= ver_sba %></td>
        <td>< %= ver_cons %></td>
        -->                  </tr>
                <tr>
                  <td>5</td>
                  <td>oficinas</td>
                  <!-- 
        <td>< %= ver_sba %></td>
        <td>< %= ver_cons %></td>
        -->                  </tr>
                <tr>
                  <td>4</td>
                  <td>oficinas</td>
                  <!-- 
        <td>< %= ver_sba %></td>
        <td>< %= ver_cons %></td>
        -->                  </tr>
                <tr class="total">
                  <td>TOTAL:</td>
                  <td></td>
                  <!-- 
        <td>< %= sbaTotal %></td>
        <td>< %= consTotal %></td>
        -->                  </tr>
               <!-- <tr class="total02">
                  <td></td>
                  <td>oficinas  (corregir)</td>-->
                  <!-- 
    <td>< %= total_sba %></td>
    <td>< %= total_cons %></td>
    
    -->                  </tr>
              </tbody>
            </table>
          </div>
        </div>
        <div class="col-sm-4">
          <div class=""> <!--tb-Gral-cont-->
            
            <!-- disponiblilidad -->
            <table class="tb-Gral dispon">
              <thead>
                <tr>
                  <th colspan="2">Disponibilidad</th>
                </tr>
                <tr>
                  <th>M²</th>
                  <th>Renta salida</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>539</td>
                  <td>20,00&nbsp;€/m²</td>
                </tr>
                <tr>
                  <td>420</td>
                  <td>19,00&nbsp;€/m²</td>
                </tr>
                <tr>
                  <td>448</td>
                  <td>17,50&nbsp;€/m²</td>
                </tr>
                <tr>
                  <td>446</td>
                  <td>19,00&nbsp;€/m²</td>
                </tr>
                
                <!-- total-->
                <tr>
                  <td colspan="2" class="total-disp"><p>1.853 m² disponibles @ 03/02/2016</p>
                    <p>92&nbsp;% alquilado</p>
                    <p> <span>mín: <strong>420 m²</strong></span> <span>máx.: <strong>1.853 m²</strong></span> </p></td>
                </tr>
              </tbody>
            </table>
            <!-- disponiblilidad --> 
            
          </div>
        </div>
      </div>
      <!--ROW--> 
      
    </div>
  </div>
  
  
 </div>


</div>  <!--container-->

<div class="container">  <!--:container--> 
  <!--  tabla EDIFICIOS _tabla_plantilla021.asp  -->
  
  <div class="caja tablas  tb-Gral-cont"> <!--  PABLO : fundamental clase:"tablas  tb-Gral-cont, tb revisa class="breakPalabra"" --> 
    <!--  NFO EDIFICIO  -->
    <p>tb-Gral tb-info / tb-Gral dispon :: ficha INFO EDIFICIO</p>
    <p>XXXX PTE PASAR</p>
    <div class="row ">
      <div class="col-sm-8">
        <table class="tb-Gral tb-info">
          <thead>
            <tr>
              <th>&nbsp;</th>
              <th></th>
              <th></th>
              <th></th>
              <th></th>
            </tr>
            <tr>
              <th>Planta</th>
              <th>Uso</th>
              <th>M² SBA</th>
              <th>M² Const.</th>
              <th>plzs/<span class="breakPalabra"></span>habs.</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>3</td>
              <td>oficinas</td>
              <td>1.309</td>
              <td>1.309</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>2</td>
              <td>oficinas</td>
              <td>2.926</td>
              <td>2.926</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>1</td>
              <td>oficinas</td>
              <td>3.098</td>
              <td>3.098</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>ENTREPLANTA</td>
              <td>oficinas</td>
              <td>2.915</td>
              <td>2.915</td>
              <td>&nbsp;</td>
            </tr>
            <tr >
              <td>BAJA</td>
              <td>oficinas</td>
              <td>4.327</td>
              <td>4.327</td>
              <td>&nbsp;</td>
            </tr>
            <tr class="bjRasante first">
              <td>SOTANO 1</td>
              <td>oficinas</td>
              <td>4.610</td>
              <td>4.610</td>
              <td>&nbsp;</td>
            </tr>
            <tr class="bjRasante">
              <td>SOTANO 2</td>
              <td>parking</td>
              <td>3.953</td>
              <td>3.953</td>
              <td>&nbsp; 143</td>
            </tr>
            <tr class="total">
              <td>TOTAL:</td>
              <td></td>
              <td>23.138</td>
              <td></td>
              <td></td>
            </tr>
            <tr class="total01">
              <td>Total S/R::</td>
              <td></td>
              <td>9.000</td>
              <td></td>
              <td></td>
            </tr>
            <tr class="total01">
              <td>Total B/R::</td>
              <td></td>
              <td>2.500</td>
              <td></td>
              <td></td>
            </tr>
            <tr class="total02">
              <td></td>
              <td>oficinas</td>
              <td>4.610</td>
              <td>4.610</td>
              <td></td>
            </tr>
            <tr class="total02">
              <td></td>
              <td>oficinas</td>
              <td>14.575</td>
              <td>14.575</td>
              <td></td>
            </tr>
            <tr class="total02">
              <td></td>
              <td>parking</td>
              <td></td>
              <td></td>
              <td>143 <!--n.d. en el caso de que sotano tenga parking pero no sepamos la info--></td>
            </tr>
            
          </tbody>
        </table>
      </div>
      <!-- : container scroll-->
      
      <div class="col-sm-4">
        <table class="tb-Gral dispon">
          <thead>
            <tr>
              <th colspan="2"> Disponibilidad </th>
            </tr>
            <tr>
              <th>M²</th>
              <th>Renta salida </th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>770</td>
              <td>37,00 €/m²</td>
            </tr>
            <tr>
              <td>385</td>
              <td>36,00 €/m²</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td></td>
            </tr>
            <tr class="bjRasante first">
              <td>&nbsp;</td>
              <td></td>
            </tr>
            <tr class="bjRasante">
              <td>&nbsp;</td>
              <td></td>
            </tr>
            <!-- total-->
            <tr >
              <td colspan="2" class="total-disp"><p>0 m² disponibles @ 01/06/2015</p>
                <p>100% alquilado</p>
                <p><span>mín: <strong>0 m²</strong></span> <span>max.: <strong>0 m²</strong></span> </p>
                
                <!--<span class="breakPalabra"></span>   --></td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>  <!--:ROW--> 
  </div> <!-- :caja tablas  tb-Gral-cont--> 

</div><!--:container--> 


<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
