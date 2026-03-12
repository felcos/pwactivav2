<%' @ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
    <link href="/lib/easyResponsiveTabs/css.css" rel="stylesheet" type="text/css" />
    
    <link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
    
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<style>
.avisar, .avisar a {
	color:#990000;
}


</style>
<%
'server.ScriptTimeout=300
f_hasta = dateadd("d", -1, date)
f_desde = dateadd("d", -1, f_hasta)
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

	<section id="s_header" class="cf">
        <div class="grid-4 titulo">
			<h1 class="heading">Clientes</h1>
        </div>
        <div class="grid-2">
            <form id="frm_accesos" name="frm_accesos" action="" method="post" autocomplete="off" target="_blank" style="margin-top:15px;">
                <p><input type="submit" value="cargar"> &nbsp; <a href="/admin/clientes/">reset</a></p>
            </form>
        </div>
    </section>

	<section id="s_datos" class="cf">
        <div class="grid-full">
            <!--Horizontal Tab-->
            <div id="tab">
                <ul class="resp-tabs-list">
                    <li>Clientes</li>
                    <li>Licencias</li>
                </ul>
                <div class="resp-tabs-container">
                    <div>
                        <div id="result_clientes"></div>
                        <div id="loading_clientes" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
                    </div>
                    <div>
                        <div id="result_licencias"></div>
                        <div id="loading_licencias" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
                    </div>
                </div>
            </div>
            <br />
        </div>
        
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
		
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/clientes/datos/clientes.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {
				$('#loading_clientes').show();
				$('#result_clientes').html('');
			},
			success: function(data, status, xhr){
				$('#result_clientes').html(data);
				$('#loading_clientes').hide();
			},
			error: function(xhr, status, err) {
				//alert(status + ": " + err);
				//destino.html(status + ": " + err);
			}
		});
		
		/**/
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/clientes/datos/licencias.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {},
			success: function(data, status, xhr){
				//$('#tbl_licencias > tbody:last').append(data)
				$('#result_licencias').html(data)
			},
			error: function(xhr, status, err) {
				//alert(status + ": " + err);
				//destino.html(status + ": " + err);
			}
		});
		
		
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
		}
	});
	
	// ini
	$('#frm_accesos').submit();
	
});

</script>

