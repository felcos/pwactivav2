<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <!--#include virtual="/lib/jqplot/inc_jqplot.asp" -->
    <link href="/graficas/home/graf.css" rel="stylesheet" type="text/css" />
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_titulo" class="cf">
	<div class="grid-full titulo">
    	<h1 class="heading">gr&aacute;ficas</h1>
	</div>
</section>

<section id="s_graficas" class="cf">
    <div class="grid-full">
        <h3><a href="/graficas/home/ver/">Gr&aacute;ficas Home</a>:&nbsp;
        <a href="/graficas/home/ver/jm.asp">activa</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span>
        </h3>
        <h3><a href="/graficas/evolucion-por-usos/">Evoluci&oacute;n  Transacciones por Usos y Tipo de Operaci&oacute;n</a></h3>
        <h3><a href="/graficas/oficinas-por-areas/">Mercado de Oficinas - Evolucion anual distribuida por &Aacute;reas</a></h3>
        <hr>
        <h3><a href="/graficas/alquiler.asp">alquiler.asp</a></h3>
        <h3><a href="/graficas/inversion.asp">inversion.asp</a></h3>
	</div>
</section>

</div>
</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function () {
    $.ajax({
		url: "/graficas/home/graficas.asp",
		success: function(data, status, xhr) { $("#para_ver").html(data) }
	});
	/**/
});
</script>

