<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    
    <link rel="stylesheet" href="/inc/slideshow/slideshow_foldy.css" type="text/css">
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

<div style="clear:both;"></div>

<section id="introp" class="cf">
  <div class="grid-full">
    	<h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jm.asp">activa</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span>
        </h3>
    </div>
    <div class="grid-full"><!-- #include virtual="/inc/slideshow/slideshow.asp" --></div>
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

