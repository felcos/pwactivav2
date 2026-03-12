<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
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
	<title>PropertyWeb - Admin</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link href="/lib/easyResponsiveTabs/css.css" type="text/css" rel="stylesheet" />
    
    <link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
    
    <script src="/lib/high/charts/js/highcharts.js"></script>
	<script src="/lib/high/charts/js/modules/data.js"></script>
    <script src="/lib/high/charts/js/modules/exporting.js"></script>
	
    <link href="/lib/data-tables/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
    <script src="/lib/data-tables/jquery.dataTables.js" type="text/javascript" language="javascript"></script>
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
.sd {
	background-color:#EEEEEE;
}
</style>
<%
'server.ScriptTimeout=300

if request.form("f")="" then
	f_hoy = date
	f_hasta = date
	f_desde = f_hasta
else
	f_hoy = request.form("f")
	f_hasta = f_hoy
	f_desde = f_hoy
end if
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

    <section id="introp" class="cf">
        <div class="grid-full titulo"><h1 class="heading">accesos</h1></div>
    </section>
    
    <section id="tabs_resumen" class="cf">
        <div class="grid-2 grid-flow-opposite">
        	<div class="caja">
            	<form id="frm_resumen" name="frm_resumen" action="/admin/accesos/datos/resumen.asp" method="post" autocomplete="off" target="_blank">
                <div class="grid-1">Per&iacute;odo:</div>
                <div class="grid-3">
                    <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
                    <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
                </div>
                <div class="grid-1"><a href="">reset</a> &nbsp; </div>
                <div class="grid-1"><input type="submit" value="cargar"></div>
            </form>
            	<div style="clear:both"></div>
            </div>
            
            <div class="caja" style="margin-top:8px;">
            	<form id="frm_detalles" name="frm_detalles" action="/admin/accesos/datos/reg.asp" method="post" autocomplete="off" target="_blank">
                <div class="grid-1" style="margin-bottom:10px;">Fecha:</div>
                <div class="grid-5" style="margin-bottom:10px;"><input type="text" name="Fecha" id="Fecha" value="<%= f_hoy %>" maxlength="10" class="fecha" required></div>
                
                <div class="grid-1">mostrar:</div>
                <div class="grid-2">
                    <select name="ver" id="ver" onChange="$('#frm_detalles').submit();">
                      <option value="*" selected>todos</option>
                      <option value="conlicencia">con licencia</option>
                      <option value="sinlicencia">sin licencia</option>
                    </select>
                </div>
                
                <div class="grid-1">t&iacute;tulos:</div>
                <div class="grid-2"><input name="titulos" type="checkbox" value="ver" onClick="$('#frm_detalles').submit();"></div>
                
                <div class="grid-full" style="margin-top:10px; border-top:1px solid #c1c1c1;"></div>
                
                <div class="grid-1"><a href="javascript:reset_detalles();">reset</a></div>
                <div class="grid-4">
                    <a href="javascript: $('#frm_detalles').submit();">submit</a> &nbsp; 
                </div>
                <div class="grid-1"><input type="submit" value="cargar"></div>
                
            </form>
            	<div style="clear:both"></div>
            </div>
        </div>
        
        <div class="grid-4">
			<!--Horizontal Tab-->
            <div id="tab">
                <ul class="resp-tabs-list">
                    <li>Resumen</li>
                    <li>Gr&aacute;fica</li>
                    <li>Usuarios</li>
                    <li>Navegadores</li>
                    
                </ul>
                <div class="resp-tabs-container">
            <div>
                <div id="resumen"></div>
                <div id="loading_resumen" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
            </div>
            
            <div>
                <div id="graf"><div id="container" style="height: 400px; width:100%; margin: 0 auto">graf</div></div>
            </div>
            
            <div>usuarios</div>
            
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


    <section id="tabs_detalles" class="cf">
        <div class="grid-full">
            <!--Horizontal Tab-->
            <div id="tabData">
                <ul class="resp-tabs-list">
                    <li>clientes &nbsp;<span id="contador_clientes"></span></li>
                    <li>licencias &nbsp;<span id="contador_licencias"></span></li>
                    <li>Sesiones &nbsp;<span id="contador_accesos"></span></li>
                    <li>reg &nbsp;<span id="contador_reg"></span></li>
                    <li>Art&iacute;culos &nbsp;<span id="contador_articulos"></span></li>
                    <li>Pags &nbsp;<span id="contador_pags"></span></li>
                </ul>
                <div class="resp-tabs-container">
            
            <div>
                <div id="result_clientes" style="min-height:350px;"></div>
                <div id="loading_clientes" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
            </div>
            <div>
                <div id="loading_licencias" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
                <div id="result_licencias" style="min-height:350px;"></div>
            </div>
            
            <div>
                <div id="loading_accesos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
                <div id="result_accesos" style="min-height:350px;"></div>
            </div>
            <div>
                <div id="result_reg" style="min-height:350px;"></div>
                <div id="loading_reg" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
            </div>    
            
            <div>
                <div id="result_articulos" style="min-height:350px;"></div>
                <div id="loading_articulos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
            </div>
            
            <div>
                <div id="result_pags" style="min-height:350px;"></div>
                <div id="loading_pags" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
            </div>
            
                </div>
            </div>
            <!--Horizontal Tab-->
        </div>
    
        <div style="clear:both;"></div>
    
    </section>

    <section id="resultados" class="cf">
        <div class="grid-full"><div id="result"></div></div>
        <div style="clear:both;"></div>
    </section>

</div>
</div>

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
				$('#frm_detalles').submit();
			}
		}
	});
	
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
				//$('#frm_resumen').submit();
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
			console.log($tab.text());
			
			if ($tab.text()=='Navegadores') {
				if ($('#resumen_navegadores').html()=='') {
					$.ajax({
						url: '/admin/accesos/ip/resumen_navegadores.asp',
						data: $('#frm_resumen').serialize(),
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
			if ($tab.text().substr(0,8)=="Sesiones") {
				
				
				if ($("#result_accesos").html()=='') {
					
					$.ajax({
						url: '/admin/accesos/datos/accesos_tabla.asp',
						data: $('#frm_detalles').serialize(),
						beforeSend: function() {
							$('#contador_accesos').html('');
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
			}
		}
	});
	
	
	// form resumen	
	$('#frm_resumen').submit(function(){ 
		$.ajax({
			url: '/admin/accesos/datos/resumen.asp',
			data: $('#frm_resumen').serialize(),
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
		
		return false;
	});
	
	// form detalles
	$('#frm_detalles').submit(function(){
		
		$('#result_licencias').html('');
		$('#result_clientes').html('');
		$('#result_accesos').html('');
		$('#result_reg').html('');
		$('#result_articulos').html('');
		$('#result_pags').html('');
		
		$('#contador_licencias').html('...');
		$('#contador_clientes').html('...');
		$('#contador_accesos').html('...');
		$('#contador_reg').html('...');
		$('#contador_articulos').html('...');
		$('#contador_pags').html('...');
		
		
		
		/*
		$.ajax({
			url: '/admin/accesos/datos/reg.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#contador_reg').html('');
				$('#loading_reg').show();
				$('#result_reg').html('');
			},
			success: function(data, status, xhr){
				$('#result_reg').html(data);
				$('#loading_reg').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		
		
		$.ajax({
			url: '/admin/accesos/datos/clientes.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#contador_clientes').html('');
				$('#loading_clientes').show();
				$('#result_clientes').html('');
			},
			success: function(data, status, xhr){
				$('#result_clientes').html(data);
				$('#loading_clientes').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		$.ajax({
			url: '/admin/accesos/datos/licencias.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#contador_licencias').html('');
				$('#loading_licencias').show();
				$('#result_licencias').html('');
			},
			success: function(data, status, xhr){
				$('#result_licencias').html(data);
				$('#loading_licencias').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		$.ajax({
			url: '/admin/accesos/datos/articulos.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#contador_articulos').html('');
				$('#loading_articulos').show();
				$('#result_articulos').html('');
			},
			success: function(data, status, xhr){
				$('#result_articulos').html(data);
				$('#loading_articulos').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		/*
		$('#tabData ul.resp-tabs-list li:nth-child(3)').click();
		
		$.ajax({
			url: '/admin/accesos/datos/accesos_tabla.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				//$('#contador_accesos').html('');
				$('#loading_accesos').show();
				$('#result_accesos').html('');
			},
			success: function(data, status, xhr){
				$('#result_accesos').html(data);
				$('#loading_accesos').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		return false;
	})
	
	//Scroll To Fixed
	/*
	$("#frm_detalles").scrollToFixed({
		marginTop: $("#cabecera").outerHeight(true),	//+10,
		limit: function() {
			var limit = $("#tabs_detalles").offset().top - $("#flow").outerHeight(true)-200;	// - 10;
			return limit;
		}
		//,	zIndex: 999
	});
	*/
	
	// ini	
	$('#frm_resumen').submit();
	$('#frm_detalles').submit();
});

function reset_detalles() {
	$('#result_licencias').html('');
	$('#result_clientes').html('');
	$('#result_accesos').html('');
	$('#result_reg').html('');
	$('#result_articulos').html('');
	$('#result_pags').html('');
	
	$('#contador_licencias').html('');
	$('#contador_clientes').html('');
	$('#contador_accesos').html('');
	$('#contador_reg').html('');
	$('#contador_articulos').html('');
	$('#contador_pags').html('');
};

</script>

