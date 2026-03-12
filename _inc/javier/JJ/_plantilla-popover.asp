<!DOCTYPE html>
<html lang="es"><head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->

<link rel="stylesheet" type="text/css" href="../../../css/css-pags/tabs02.css">
<!--<link rel="stylesheet" type="text/css" href="css/todo-bootstrap.css">
<link rel="stylesheet" type="text/css" href="css/mapaCoord-prueba.css">-->
<link rel="stylesheet" type="text/css" href="../../../css/css-pags/mapaCoord.css">
<link rel="stylesheet" type="text/css" href="../titulos_info.css">

<script>
$(document).ready(function() {
	$(function () {
	  $('[data-toggle="popover"]').popover()
	})
	
	$(".cerrar").click(cerrar);
});

function cerrar(){
	$(".deal-navs li").removeClass("active");
	}


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

<div class="container"><!-- titulo  -->
  <section class="row">
    <div class="col-md-12 caja myMap" >
    	
<button type="button" class="btn" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">popover</button><!---->
<!--title="Popover title"-->

<button type="button" class="btn" data-toggle="popover" title="Popover title" data-content="And here's some amazing content. It's very engaging. Right?">popover</button><!---->
<!--title="Popover title"-->

<button type="button" class="btn btn-notas" data-container="body" data-toggle="popover" data-placement="bottom" data-content="@ 2015 - 11/2015 Empresa alquila local 120 m2 con renta de salida de 27 €/M2/Mes" data-original-title="" title="" ><span class="icon-pushpin"></span>
</button>




    </div>
  </section> 
</div>

<!-- :container--> 
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>




