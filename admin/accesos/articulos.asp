<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - DESARROLLO</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="/lib/easyResponsiveTabs/css.css" />
    
    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.ohlcRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.cursor.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
<%
'server.ScriptTimeout=300
f_desde = "01/01/2010"
f_hasta = DATE
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-4">
    	<h1 class="heading">control de accesos</h1>
	</div>
    
    
	<div class="grid-4">
        <div class="caja">
<form id="frm_accesos" name="frm_accesos" action="/admin/accesos/test.asp" method="post" autocomplete="off" target="_blank">
<!--
/admin/accesos/accesos.asp
-->
    <label for="FechaI">Per&iacute;odo:</label>
    <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">&nbsp;-&nbsp;<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
	<input type="submit" value="cargar"> &nbsp; <a href="/admin/accesos/">reset</a>
</form>
        </div>
	</div>
</section>

</div>


<div class="contenedor">
	<div class="grid-full">
    	<!--Horizontal Tab-->
        <div id="horizontalTab">
            <ul class="resp-tabs-list">
                <li>Responsive Tab-1</li>
                <li>Responsive Tab-2</li>
                <li>Responsive Tab-3</li>
            </ul>
            <div class="resp-tabs-container">
            
<div>
    <div class="tabla">
        <div class="fila">
            <div class="reg_fecha tit">fecha</div>
            <div class="reg_col tit">articulos</div>
            <div class="reg_col_p tit">reg_</div>
            <div class="reg_col tit">accesos</div>
            <div class="reg_col tit">a. null</div>
            <div class="reg_col tit">visitas</div>
            <div class="reg_col tit">v. null</div>
        </div>
    
    <div id="div_mas">
      <a href="/admin/accesos/semana.asp?f=<%= fecha %>" class="carga_mas">siguientes</a>
    </div>
    
    </div>
</div>    
        
<div>
	<div id="div_graf">
<p>variables:</p>
<hr>
<p><a href="#" onClick="freg_articulos_distintos();">reg_articulos_distintos</a><p>
<div id="reg_articulos_distintos">_</div>
<hr>
<p><a href="#" onClick="freg_articulos();">reg_articulos</a><p>
<div id="reg_articulos">_</div>
    </div>
</div>
<div>
	<div id="div_result">
        <div id="result">RESULT</div>
	</div>
</div>

            </div>
        </div>
        <br />
	</div>
    <div style="clear:both;"></div>
</div>

</section>

</body>
</html>

<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
	var start;
	
    $(document).ready(function () {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion           
            width: 'auto', //auto or any width like 600px
            fit: true,   // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                //var $info = $('#tabInfo');
                //var $name = $('span', $info);

                //$name.text($tab.text());

                //$info.show();
            }
        });
		
    });
</script>

<link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<script language="javascript">	
$(document).ready(function(){
	$('#FechaI').DatePicker({
		
	format: 'd/m/Y',
	date: $('#FechaI').val(),
	current: $('#FechaI').val(),
	
	calendars: 1,
	starts: 1,
	//position: 'r',
	
	onBeforeShow: function(){
		$('#FechaI').DatePickerSetDate($('#FechaI').val(), true);
	},
	onChange: function(formated, dates){
		ant_date=$('#FechaI').val();
		$('#FechaI').val(formated);
		if (ant_date!=$('#FechaI').val()) {
			$('#FechaI').DatePickerHide();
			$('#frm_deal').submit();
		}
	}
});
	$('#FechaF').DatePicker({

	format: 'd/m/Y',
	date: $('#FechaF').val(),
	current: $('#FechaF').val(),
	
	calendars: 1,
	starts: 1,
	//position: 'r',
	
	onBeforeShow: function(){
		$('#FechaF').DatePickerSetDate($('#FechaF').val(), true);
	},
	onChange: function(formated, dates){
		ant_date=$('#FechaF').val();
		$('#FechaF').val(formated);
		
		if (ant_date!=$('#FechaF').val()) {
			$('#FechaF').DatePickerHide();
			$('#frm_deal').submit();
		}
	}
});
});
</script>

<script type="text/javascript">
$(document).ready(function() { 
	var opciones= {
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	};
	
	$('#frm_accesos').ajaxForm(opciones) ; 
	
	function mostrarLoader(){$('ul.resp-tabs-list li:nth-child(2)').click();};
	function mostrarRespuesta (responseText){ 
		$("#div_graf").html(responseText);
		//$("#div_result").fadeIn("fast");
	};
	
	
	$(".carga_mas").click(function() {
		start = new Date().getTime();
		var href=this.href;
		console.log(href);
		
		$.ajax({
			url: href,
			beforeSend: function () {
				$("#div_mas").html('<img src="/img/ajax-loader.gif"/>')
			},
			success: function(data, status, xhr) {
				$("#div_mas").before(data); 
				var end = new Date().getTime();
				console.log((end-start)/1000);
			}
		});
		
		return false;
	});
	
});
function freg_articulos() {
	//$("#reg_articulos").html(serie_reg_articulos);
	var ver="";
	for (i=0;i<serie_articulos.length;i++)
	{
		ver = ver + '[' + serie_articulos[i].toString() + '] ';
	};
	$("#reg_articulos").html("<p>"+ver+"</p>"); 
	return false;
}
function freg_articulos_distintos() {
	var ver="";
	for (i=0;i<serie_articulos_distintos.length;i++)
	{
		ver = ver + '[' + serie_articulos_distintos[i].toString() + '] ';
		//console.log(serie_articulos_distintos[i]);
	};
	$("#reg_articulos_distintos").html("<p>"+ver+"</p>"); 
	return false;
}
</script>

