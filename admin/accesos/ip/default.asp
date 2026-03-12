<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link href="/lib/easyResponsiveTabs/css.css" type="text/css" rel="stylesheet" />
    
    <link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<style>
#tab .resp-tabs-container {
	min-height:100px;
}
#tabData .resp-tabs-list li {
    width:120px;
}
form .grid-1, form .grid-2, form .grid-3, form .grid-4, form .grid-5, form .grid-6, form .grid-full {
	margin-bottom:.25em;
}
</style>
<%
'server.ScriptTimeout=300
'f_hasta = dateadd("d", -1, date)
'f_desde = dateadd("d", -1, f_hasta)
ip = request.QueryString("ip")
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-4">
    	<h1 class="heading">accesos</h1>
	</div>
    <div class="grid-2 grid-flow-opposite">
    <form id="frm_accesos" name="frm_accesos" action="/admin/accesos/ip/accesos.asp" method="post" autocomplete="off" target="_blank">   
    	<div class="grid-6">
        	accesos - cliente - licencia
            <hr>
        </div>
        
        <div class="grid-1" style="margin-bottom:10px;">Per&iacute;odo:</div>
        <div class="grid-5" style="margin-bottom:10px;">
        	<input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
            &nbsp;-&nbsp;
        	<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
        </div>
        
        <div class="grid-1">IP:</div>
        <div class="grid-5">
        	<input type="text" name="ip" id="ip" value="<%= ip %>">
        </div>
        
        <div class="grid-full" style="margin-top:10px; border-top:1px solid #c1c1c1;"></div>
        
        <div class="grid-1"><a href="">reset</a></div>
        <div class="grid-4">
        	<a href="javascript: carga_reg();">reg</a> &nbsp; 
            <a href="javascript: carga_articulos();">articulos</a> &nbsp; 
            <a href="javascript: carga_accesos();">accesos</a>
        </div>
        <div class="grid-1"><input type="submit" value="cargar"></div>
    	
    </form>
    </div>
    
    <div class="grid-4">
<!--Horizontal Tab-->
<div id="tab">
    <ul class="resp-tabs-list">
        <li>Resumen</li>
        <li>Usuarios</li>
        <li>Navegadores</li>
        
    </ul>
    <div class="resp-tabs-container">
<div>
	<div id="resumen"></div>
    <div id="loading_resumen" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>ccc</div>

<div>
	<div id="resumen_navegadores"></div>
    <div id="loading_resumen_navegadores"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>
		
    </div>
</div>
<!--Horizontal Tab-->
    </div>
    
    <div style="clear:both;"></div>
    
</section>

</div>

<div class="contenedor">

	<div class="grid-full">
<!--Horizontal Tab-->
<div id="tabData">
    <ul class="resp-tabs-list">
        <li>reg &nbsp;<span id="contador_reg"></span></li>
        <li>Art&iacute;culos &nbsp;<span id="contador_articulos"></span></li>
        <li>Acesos &nbsp;<span id="contador_accesos"></span></li>
        <li>Pags &nbsp;<span id="contador_pags"></span></li>
        
    </ul>
    <div class="resp-tabs-container">
            
<div>
	<div id="result_reg"></div>
    <div id="loading_reg" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>  
  
<div>
	<div id="result_articulos"></div>
    <div id="loading_articulos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>
	<div id="result_accesos"></div>
    <div id="loading_accesos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>
	<div id="result_pags"></div>
    <div id="loading_pags" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>
    </div>
</div>
<!--Horizontal Tab-->
	</div>

<div style="clear:both;"></div>
</div>

<div class="contenedor">
	<div class="grid-full" id="result"></div>
    <div style="clear:both;"></div>
</div>

</section>

</body>
</html>

<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
	var start;
	
    
</script>


<script language="javascript">	
// ajax

function carga_reg() {
	$.ajax({
		//type: 'get',
		//async: false,
		url: '/admin/accesos/ip/reg.asp',
		data: $('#frm_accesos').serialize(),
		beforeSend: function() {
			$('#loading_reg').show();
			$('#result_reg').html('');
		},
		success: function(data, status, xhr){
			$('#result_reg').html(data);
			$('#loading_reg').hide();
		},
		error: function(xhr, status, err) {}
	});
}

function carga_articulos() {
	$.ajax({
		//type: 'get',
		//async: false,
		url: '/admin/accesos/ip/articulos.asp',
		data: $('#frm_accesos').serialize(),
		beforeSend: function() {
			$('#loading_articulos').show();
			$('#result_articulos').html('');
		},
		success: function(data, status, xhr){
			$('#result_articulos').html(data);
			$('#loading_articulos').hide();
		},
		error: function(xhr, status, err) {}
	});
}

function carga_accesos() {
	$.ajax({
		//type: 'get',
		//async: false,
		url: '/admin/accesos/ip/accesos.asp',
		data: $('#frm_accesos').serialize(),
		beforeSend: function() {
			$('#loading_accesos').show();
			$('#result_accesos').html('');
		},
		success: function(data, status, xhr){
			$('#result_accesos').html(data);
			$('#loading_accesos').hide();
		},
		error: function(xhr, status, err) {}
	});
}

	
$(document).ready(function(){
	// datepicker
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
	
	// formulario
	$('#frm_accesos').submit(function(){ 
		carga_reg;
		carga_articulos;
		carga_accesos;
		
		return false;
	});
	
	// tabs
	$('#tab').easyResponsiveTabs({
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
			
			if ($tab.text()=='Navegadores') {
				if ($('#resumen_navegadores').html()=='') {
					$.ajax({
						url: '/admin/accesos/ip/resumen_navegadores.asp',
						data: $('#frm_accesos').serialize(),
						beforeSend: function() {
							$('#resumen_navegadores').html('');
						},
						success: function(data, status, xhr){
							$('#resumen_navegadores').html(data);
							$('#loading_resumen_navegadores').hide();
						},
						error: function(xhr, status, err) {}
					});
				}
			}
			
		}
	});
	
	$('#tabData').easyResponsiveTabs({
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
	
	
	//$('#frm_accesos').submit();
	$.ajax({
		//type: 'get',
		//async: false,
		url: '/admin/accesos/ip/resumen.asp',
		data: $('#frm_accesos').serialize(),
		beforeSend: function() {
			$('#loading_resumen').show();
			$('#resumen').html('');
		},
		success: function(data, status, xhr){
			$('#resumen').html(data);
			$('#loading_resumen').hide();
		},
		error: function(xhr, status, err) {}
	});
	
	
});

</script>

