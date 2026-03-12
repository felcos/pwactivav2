<!DOCTYPE html>
<html class="no-js">
<head>
	<title>PropertyWeb - DESARROLLO</title>
	<!--#include virtual="/inc/simple/head.asp" -->
    
    <script src="modernizr-all.js" type="text/javascript"></script>
    <script type="text/javascript">
		$(document).ready(function() {
			
			var clases = $("html").attr("class").split(/\s+/).sort();
			
			for (var i=0; i<clases.length; i++) {
				$("#informa_clases").append("<li>" + clases[i] + "</li>") 
			};
			
			$("#informa_clases").html("<ol>" + $("#informa_clases").html() + "</ol>");
			
		});
	</script>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_desarrollo" class="cf">
    <div class="row">
        <div class="grid-full titulo">
            <h1 class="heading">test modernizr</h1>
        </div>
    </div>
	
    <div class="row">
        <div class="grid-2">
            <div class="caja sombra sombra" id="informa_clases"></div>
        </div>
        
        <div class="grid-2">
            <div class="caja sombra sombra">
            	xxx
            </div>
        </div>
        
        <div class="grid-2">
            <div class="caja sombra sombra">
    <li>Pantalla: <span id="informa_width" style="width:100px;">0</span> x <span id="informa_height">0</span></li>
            </div>
            
        </div>
    </div>
	
</section>


</div>
</div>

</body>
</html>
