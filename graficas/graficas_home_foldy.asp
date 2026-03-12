<!DOCTYPE html>
<html lang="es">
<head>
	<title>PropertyWeb</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]>
    <script src="/lib/jqplot/excanvas.min.js" language="javascript" type="text/javascript"></script>
    <![endif]-->
    <script src="/lib/jqplot/jquery.jqplot.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.barRenderer.min.js" language="javascript" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.pointLabels.min.js" language="javascript" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js" language="javascript" type="text/javascript"></script>
	<script src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js" type="text/javascript"></script>
	
	<link href="/graficas/home/graf.css" rel="stylesheet" type="text/css"/>
    <!--
    <link href="/inc/slideshow/slideshow.css" rel="stylesheet" type="text/css">
    -->
</head>
<body>
<section id="graficas" class="cf">
	<!--  include virtual="/inc/slideshow/slideshow.asp" -->
    <div class="row" style="margin-top:24px;">
        <div class="grid-1" align="right"><div class="graf_prev"></div></div>
        <div class="grid-4">
            <div id="para_ver" style="width:85%;"></div>
        </div>
        <div class="grid-1" align="left"><div class="graf_next"></div></div>
    </div>
    
    <hr>
    
    <a href="www.pixedelic.com" target="_blank">Slideshow CAMERA : www.pixedelic.com</a>
</section>



</body>
</html>

<script type="text/javascript">
$(document).ready(function () {
    $.ajax({
		url: "/graficas/home/graficas.asp",
		success: function(data, status, xhr) { $("#para_ver").html(data) }
	});
});
</script> 

