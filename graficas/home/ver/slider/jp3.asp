<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <link href="/graficas/home/graf.css" rel="stylesheet" type="text/css" />
    
	<script src="/lib/easing/jquery.easing.min.js"></script>
	<script src="/_inc/camera.js"></script>
    <link href="/_inc/foldy/camera.css" rel="stylesheet" type="text/css">
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
    	<a href="/graficas/" class="volver"><h1 class="heading">gr&aacute;ficas</h1></a>
	</div>
    <div class="grid-full">
    	<h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jm.asp">jm</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp3.asp">jp3</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp3.asp">slider</a>]</span>
        </h3>
    </div>
</section>

<section id="s_graficas" class="cf">

    <div class="grid-full">
<div class="camera-wrapper">
    <div id="camera" class="camera-wrap">
        
        <div data-src="/images/TEST/graf01-test.png"></div>
        <div data-src="/images/TEST/graf02-test.png"></div>
        <div data-src="/images/TEST/graf03-test.png"></div>
        <div data-src="/images/TEST/graf04-test.png"></div>
        <div data-src="/images/TEST/graf05-test.png"></div>
        
    </div>
</div>
    </div>
</section>


</div>
</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function () {
	var camera = $('#camera');
    
	camera.camera({
		autoAdvance: false,
		height: '31.25%',
		minHeight: '200px',
		pagination: false,
		thumbnails: false,
		playPause: false,
		hover: false,
		loader: 'none',
		navigation: true,
		navigationHover: false,
		mobileNavHover: false,
		fx: 'simpleFade'
	});
});
</script> 
