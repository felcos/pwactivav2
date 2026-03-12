<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    
    <link href="/graficas/home/graf.css" rel="stylesheet" type="text/css" />
    <% 
	sec_actual = "/graficas/"
    pag_actual = "graficas"
	%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="introp" class="cf">
	<div class="grid-full titulo">
    	<a href="/graficas/" class="volver"><h1 class="heading">gr&aacute;ficas</h1></a>
	</div>
</section>

<section id="introp" class="cf">
  <div class="grid-4">
	    <h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jm.asp">activa</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span>
        </h3>
    </div>
    
    <div class="grid-2 grid-flow-opposite">
        Mercado de Oficinas
        <ul>
            <li><a href="/graficas/home/g02.png" class="loadgraf">Rentabilidad</a></li>
            <li><a href="/graficas/home/g03.png" class="loadgraf">Take Up</a></li>
            <li><a href="/graficas/home/g01.png" class="loadgraf">Renta Prime</a></li>
            <li><a href="/graficas/home/g04.png" class="loadgraf">Distribuci&oacute;n por &Aacute;reas - Madrid</a></li>
            <li><a href="/graficas/home/g05.png" class="loadgraf">Distribuci&oacute;n por &Aacute;reas - Barcelona</a></li>
        </ul>
        Mercado de Vivienda Residencial
        <ul>
            <li><a href="/graficas/home/g06.png" class="loadgraf">Espa&ntilde;a</a></li>
            <li><a href="/graficas/home/g07.png" class="loadgraf">Evoluci&oacute;n del Precio</a></li>
            <li><a href="/graficas/home/g09.png" class="loadgraf">Compraventa - operaciones a julio de cada a&ntilde;o</a></li>
       	</ul>
        Mercado de Centros Comerciales
        <ul>
            <li><a href="/graficas/home/g08.png" class="loadgraf">Mercado de Centros Comerciales - Rentabilidad</a></li>
        </ul>
    </div>
    
    <div class="grid-4">
    	<div style=" background-color:#CCC; padding:20px; text-align:center; min-height:250px;"><img id="para_ver" src=""></div>
    </div>
    
    <div class="grid-full" id="informa">[informa]</div>
</section>



</div>
</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function () {
    /*
	$.ajax({
		url: "/graficas/home/graficas.asp",
		success: function(data, status, xhr) { $("#para_ver").html(data) }
	});
	*/
	
	$('.loadgraf').click(function(e) {
		var href=this.href;
		$("#para_ver").attr('src',href);
		
		/*
		$.ajax({
			url: href,
			success: function(data, status, xhr) { 
				//$("#para_ver").html(data); 
				//console.log('bbb'); 
			}
		});
		*/
		// Bind a listener to the "jqplotDataClick" event.  Here, simply change
		// the text of the info3 element to show what series and ponit were
		// clicked along with the data for that point.
		
		/*
		$('#graf').bind('jqplotDataClick', 
			function (ev, seriesIndex, pointIndex, data) {
				$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
			}
		);
		*/
		return false;
    });
});
</script> 

