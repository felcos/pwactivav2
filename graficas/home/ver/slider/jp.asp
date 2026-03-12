<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <link href="/lib/jqplot/jquery.jqplot.min.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]><script src="/lib/jqplot/excanvas.min.js" language="javascript" type="text/javascript"></script><![endif]-->
    <script src="/lib/jqplot/jquery.jqplot.min.js" type="text/javascript"></script>
    
    <script src="/lib/jqplot/plugins/jqplot.barRenderer.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.pointLabels.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js" type="text/javascript"></script>
    
	<script src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js" type="text/javascript"></script>
	<script src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js" type="text/javascript"></script>
    
    <script src="/lib/jqplot/plugins/jqplot.highlighter.min.js" type="text/javascript"></script>
    <!--
    <script src="/lib/jqplot/plugins/jqplot.cursor.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.dragable.min.js" type="text/javascript"></script>
    -->
    
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
    <div class="grid-full">
    	<h3>Gr&aacute;ficas Home:&nbsp; 
        <a href="/graficas/home/ver/jm.asp">activa</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jm.asp">slider</a>]</span> - 
        <a href="/graficas/home/ver/jp.asp">jp</a> <span style="font-size:75%;">[<a href="/graficas/home/ver/slider/jp.asp">slider</a>]</span>
        </h3>
    </div>
</section>


<section id="s_graficas" class="cf">
	<div class="grid-1" align="right"><div class="graf_prev"></div></div>
    <div class="grid-4">
    	<div id="para_ver" style="width:85%;"></div>
    </div>
    <div class="grid-1" align="left"><div class="graf_next"></div></div>
    
    <div style="clear:both;"></div>
    
    <p align="center" style="width:90%;"><a href="#" class="graf_stop">stop - [graf <span id="graf_num"></span>]</a></p>
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

