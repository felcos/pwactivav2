<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - Admin</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="/lib/easyResponsiveTabs/css.css" />
    
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
    
<style>
#tabData .resp-tabs-list li {
    width:120px;
}
form .grid-1, form .grid-2, form .grid-3, form .grid-4, form .grid-5, form .grid-6, form .grid-full {
	margin-bottom:.25em;
}
.sd {
	background-color:#EEEEEE;
}
</style>
<%
'server.ScriptTimeout=300

'f_hasta = date
'f_desde = dateadd("d", -7, f_hasta)
f_desde = "25/03/2015"
f_hasta = "31/03/2015"
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-4">
    	<h1 class="heading">reparar accesos	</h1>
	</div>
    
    <div class="grid-2 grid-flow-opposite">
    	<!--#include virtual="/admin/inc_menu.asp" -->
    
    <form id="frm" name="frm" action="" method="post" autocomplete="off" target="_blank">
        <input type="hidden" name="var_http" id="var_http" value="">
        <div class="grid-1">Per&iacute;odo:</div>
        <div class="grid-3">
        	<input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
            &nbsp;-&nbsp;
        	<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
        </div>
        <div class="grid-1"><a href="">reset</a> &nbsp; </div>
        <div class="grid-1"><input type="submit" value="cargar"></div>
    </form>
    
    </div>
    
</section>

</div>

<div class="contenedor">

	<div class="grid-full">
<!--Horizontal Tab-->
<div id="tabData">
    <ul class="resp-tabs-list">
        <li>Mozilla &nbsp;<span id="contador_mozilla"></span></li>
        <li>Sist. Operativo &nbsp;<span id="contador_so"></span></li>
        <li>Navegador &nbsp;<span id="contador_navegador"></span></li>
        <li>... &nbsp;<span id="contador_zzz"></span></li>
    </ul>
    <div class="resp-tabs-container">

<div>
	<div id="result_mozilla"></div>
    <div id="loading_mozilla" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>
	<div id="result_so"></div>
    <div id="loading_so" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>
	<div id="result_navegador"></div>
    <div id="loading_navegador" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
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
				//$('#frm').submit();
				$('#resumen').html('');
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
				//$('#frm_deal').submit();
				$('#resumen').html('');
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
	
	// formulario
	$('#frm').submit(function(){ 
		//S.O.
		$('#var_http').val('so');
		$.ajax({
			url: '/admin/accesos/reparar/http.asp',
			data: $('#frm').serialize(),
			beforeSend: function() {
				$('#loading_so').show();
				$('#result_so').html('');
			},
			success: function(data, status, xhr){
				$('#result_so').html(data);
				$('#loading_so').hide();
			},
			error: function(xhr, status, err) {}
		});
		
	
		//mozilla
		$('#var_http').val('mozilla');
		$.ajax({
			url: '/admin/accesos/reparar/http.asp',
			data: $('#frm').serialize(),
			beforeSend: function() {
				$('#loading_mozilla').show();
				$('#result_mozilla').html('');
			},
			success: function(data, status, xhr){
				$('#result_mozilla').html(data);
				$('#loading_mozilla').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		//navegador
		$('#var_http').val('navegador');
		$.ajax({
			url: '/admin/accesos/reparar/http.asp',
			data: $('#frm').serialize(),
			beforeSend: function() {
				$('#loading_navegador').show();
				$('#result_navegador').html('');
			},
			success: function(data, status, xhr){
				$('#result_navegador').html(data);
				$('#loading_navegador').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		return false;
	});
	
});


</script>

