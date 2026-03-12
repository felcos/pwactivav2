<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb </title>
<!--#include virtual="/inc/head.asp" -->
<style type="text/css">
.caja>div{
	margin:10px 0px;
	}
h3{
	    background-color: #d1e1ef;
    color: #5F5F5F;
	}
</style>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">
<div class="caja clearfix">
<h3> A HREF</h3>
<!--   enlaces        -->
<a href="#" class=""> a >sin class</a> <br>
<a href="#" ><span class="icon-circle-down"></span> <span id="mas_dir">más</span> filtros de dirección</a><br>
<a href="#" class="btnAzul"> a >btnAzul</a> <br>
<a href="#" class="gris"> a >gris</a> <br> <!-- no toman color porque serian "btn gris"-->
<a href="#" class="blanco"> a >blanco</a> <br>
<a href="#" class="blancoHover"> a >blancoHover</a> <br>

<a href="#" class="btn"> a> btn</a> <br>
<a href="#" class="btn btnAzul"> a> btn btnAzul</a> <br>
<a href="#"  class="btn gris">a> btn gris</a><br>
<a href="#"  class="btn blanco"> a> btn blanco</a><br>
<a href="#"  class="btn blancoHover"> a> btn blancoHover</a><br>
<a href="#"  class="btn rojo"> a>btn rojo</a><br>
<div class="inversores" style="padding:20px"><a href="">ver más</a></div>
<div class="btnsSiguiente" style="    float: none;">
            <a href="#" id="navPrev" class="btn blancoHover">
                <span class="icon icon-arrow-left"></span>
                <span class="lineLeft hidden-xs">anterior</span>
            </a>
            <a class="btn blancoHover" id="shMisArticulos">
                <span class="icon icon-file-text visible-xs-inline"></span> 
                <span class="hidden-xs">seleccionados</span>
                <span class="icon icon-arrow-down2 lineLeft"></span>
            </a>
            <a href="#" id="navNext" class="btn blancoHover">
                <span class="hidden-xs">siguiente</span>
                <span class="icon icon-arrow-right lineLeft "></span>
            </a>
            <span> a>btn blanco</span>
        </div>
        
<!--   :enlaces        -->
<hr>
<h3> IMPUTS: BUTTOM,SUBMIT  //  BUTTON</h3>



<input type="button" value="imput:buttom >sin clase"> 
<input name="consulta" type="submit" value="buscar" class="btn"></input><br>

<button type="submit" class="btn blanco"><span class="icon icon-arrow-left2"></span> <span class="lineLeft">Volver</span></button>  <span>submit>btn blanco</span> <br>   

<!--<button type="button" value="Leer Seleccionados" class="btn blancoHover leer"><span class="icon icon-arrow-right2"></span> Leer Seleccionados >btn blancoHover leer</button> <br>-->

        
<div>  <!--  class="bts-selecciona"-->
<label class="btn blanco"><input type="checkbox" class="select_all"> Seleccionar todos</label> 
<button type="button" value="Leer Seleccionados" class="btn blancoHover leer"><span class="icon icon-arrow-right2"></span> Leer Seleccionados </button>
<span>label>btn blanco </span> /// <span> button>btn blancoHover leer</span> 
</div>

</div></div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
