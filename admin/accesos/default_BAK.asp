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
    
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>

<%
'server.ScriptTimeout=300

f_desde = dateadd("d", -1, date)
'f_hasta = dateadd("d", 1, f_desde)
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-full">
    	<h1 class="heading">accesos</h1>
	</div>
    <div style="clear:both;"></div>
    
<form id="frm_accesos" name="frm_accesos" action="/admin/accesos/datos/reg.asp" method="post" autocomplete="off" target="_blank">
<div class="caja">
<!--
/admin/accesos/accesos.asp
-->
<div class="grid-2">
    <label for="ver">Fecha: </label>
    <input type="text" name="Fecha" id="Fecha" value="<%= f_desde %>" maxlength="10" class="fecha">&nbsp;-&nbsp;<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
</div>
<div class="grid-2">
	ssss
</div>
<div class="grid-2">
<label for="ver">Mostrar </label>
    <select name="ver" id="ver" onChange="$('#frm_accesos').submit();">
<option value="*">todos</option>
<option value="conlicencia" selected>con licencia</option>
<option value="sinlicencia">sin licencia</option>
    </select>

</div>

<div class="grid-full">
	<a href="/admin/accesos/">reset</a> &nbsp; <input type="submit" value="cargar"> &nbsp; <img src="/img/ajax-loader.gif" id="loading" style="display:none;"/>

</div>

<div style="clear:both;"></div>
</div>
</form>

</section>
</div>


<div class="contenedor">
<!--Horizontal Tab-->
<div id="horizontalTab">
    <ul class="resp-tabs-list">
        <li>reg</li>
        <li>Acesos</li>
        <li>Pags</li>
        
    </ul>
    <div class="resp-tabs-container">
            
<div>
	
	<div id="result_reg"></div>
</div>    

<div>
	
	<div id="result_accesos"></div>
</div>

<div>
	
	<div id="result_pags"></div>
</div>
    </div>
</div>
<!--Horizontal Tab-->
<hr>
	<div class="grid-full" id="result">
<table width="100%" class="reg" id="tblreg"> 
<tr>
    <th style="width:30px;">nn</th>
    <th style="width:55px;">hora</th>
    
    <th style="width:55px;">start</th>
    <th style="width:55px; ">login</th>
    
    <th style="width:150px; text-align:left;">usuario</th>
    <th style="width:180px; text-align:left;">licencia</th>
    <th style="width:100px; text-align:left;">IP</th>
    
    <th style="text-align:left;">url</th>
    <th style="text-align:left; width:150px;">qry</th>
    <th style="text-align:left; width:150px;">form</th>
</tr>


</table>
	</div>
</div>

</section>

</body>
</html>

<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
	var start;
	
	
$(document).ready(function(){
	
	$('#Fecha').DatePicker({
		format: 'd/m/Y',
		date: $('#Fecha').val(),
		current: $('#Fecha').val(),
		
		calendars: 1,
		starts: 1,
		//position: 'r',
		
		onBeforeShow: function(){
			$('#Fecha').DatePickerSetDate($('#Fecha').val(), true);
		},
		onChange: function(formated, dates){
			ant_date=$('#Fecha').val();
			$('#Fecha').val(formated);
			if (ant_date!=$('#Fecha').val()) {
				$('#Fecha').DatePickerHide();
				$('#frm_accesos').submit();
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
	
	// tabs
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
	
	
	// formulario
	var opciones= {
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	};
	
	$('#frm_accesos').ajaxForm(opciones) ; 
	
	function mostrarLoader(){
		//console.log("mostrarLoader");
		$("#loading").show();
		};
	function mostrarRespuesta (responseText){ 
		//console.log("mostrarRespuesta");
		$("#result").html(responseText);
		//$('#tblreg > tbody:last').append(responseText)
		//$('#tblreg').append(responseText)
		$("#loading").hide();
	};
	
	
	
});


</script>

