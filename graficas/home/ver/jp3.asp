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

<section id="s_menu" class="cf">
	<div class="grid-full titulo">
    	<h1 class="heading volver"><a href="/graficas/">gr&aacute;ficas</a></h1>
	</div>
</section>

<section id="introp" class="cf">
  <div class="grid-4">
	    <h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jm.asp">jm</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp3.asp">jp3</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp3.asp">slider</a>]</span>
        </h3>
    </div>
    
    <div class="grid-2 grid-flow-opposite">
        <ul>
            <li><a href="/images/TEST/graf01-test.png" class="loadgraf">Mercado de Oficinas - Rentabilidad</a></li>
            <li><a href="/images/TEST/graf02-test.png" class="loadgraf">Mercado de Oficinas - Take Up</a></li>
            <li><a href="/images/TEST/graf03-test.png" class="loadgraf">Mercado de Oficinas - Renta Prime</a></li>
            <li><a href="/images/TEST/graf04-test.png" class="loadgraf">Mercado de Oficinas por &Aacute;reas - Madrid</a></li>
            <li><a href="/images/TEST/graf05-test.png" class="loadgraf">Mercado de Oficinas por &Aacute;reas - Barcelona</a></li>
        </ul>
    </div>
    
    <div style="clear:both;"></div>
    
    <div class="grid-full">
    	<div style="padding:20px; text-align:center; min-height:250px;"><img id="para_ver" src=""></div>
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

