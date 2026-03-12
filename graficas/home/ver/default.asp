<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <!--#include virtual="/lib/jqplot/inc_jqplot.asp" -->
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

<section id="s_head" class="cf">
	<div class="grid-full titulo">
    	<a href="/graficas/" class="volver"><h1 class="heading">gr&aacute;ficas</h1></a>
	</div>
</section>

<div style="clear:both;"></div>

<section id="s_menu" class="cf">
  <div class="grid-4">
	    <h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jm.asp">activa</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span>
        </h3>
    </div>
    
    <div class="grid-2 grid-flow-opposite">
        Mercado de Oficinas
        <ul>
            <li><a href="" data-id="g01" class="loadgraf">Rentabilidad</a></li>
            <li><a href="" data-id="g02" class="loadgraf">Take Up</a></li>
            <li><a href="" data-id="g03" class="loadgraf">Renta Prime</a></li>
            <li><a href="" data-id="g04" class="loadgraf">Distribuci&oacute;n por &Aacute;reas - Madrid</a></li>
            <li><a href="" data-id="g05" class="loadgraf">Distribuci&oacute;n por &Aacute;reas - Barcelona</a></li>
        </ul>
        Mercado de Vivienda Residencial
        <ul>
            <li><a href="" data-id="g06" class="loadgraf">Espa&ntilde;a</a></li>
        	<li><a href="" data-id="g07" class="loadgraf">Evoluci&oacute;n del Precio</a></li>
            <li><a href="" data-id="g09" class="loadgraf">Compraventa - operaciones a julio de cada a&ntilde;o</a></li>
        </ul>
        Mercado de Centros Comerciales
        <ul>
            <li><a href="" data-id="g08" class="loadgraf">Rentabilidad</a></li>
        </ul>
        <hr>
        M&aacute;s gr&aacute;ficas
        <ul>
            <li><a href="/graficas/home/gx.js" class="loadgraf">Mercado de Vivienda Residencial - Euribor</a></li>
        </ul>
    </div>
    
    <div class="grid-4" style="padding:0 40px;">
    	<div style=" background-color:#CCC; padding:20px; text-align:center; width:90%; min-height:300px;"><img id="para_ver_jm" src=""></div>
    </div>
    
    <div class="grid-4">
    	<div id="para_ver_jp"></div>
    </div>

</section>

<section id="sinforma" class="cf">
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
		e.preventDefault();
		var graf = $(this).data("id");
		
		$("#para_ver_jp").html('<div id="graf_titulo"></div><div id="graf_subtitulo"></div><div id="graf"></div><div id="graf_fuente"></div>');
		
		$("#para_ver_jm").attr("src", "/graficas/home/" + graf + ".png");
		
		$.ajax({
			url: "/graficas/home/" + graf + ".js",
			dataType: "script",
			success: function(data, status) {}
		});
		
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

