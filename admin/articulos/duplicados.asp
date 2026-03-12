<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
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
    <link href="/_inc/foldy/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/foldy/estilos.css" rel="stylesheet" type="text/css">
    <% if request.Cookies("dev")("estilos2")<>"" then %><link href="/_inc/foldy/estilos2.css" rel="stylesheet" type="text/css"><% end if %>
    
	<!--#include virtual="/inc/js.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link href="/lib/easyResponsiveTabs/css.css" rel="stylesheet" type="text/css" />
    
    <link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<style>
#tab .resp-tabs-container {
	min-height:150px;
}
</style>
<%
u = request.QueryString("u")
l = request.QueryString("l")
uid = request.QueryString("uid")
lid = request.QueryString("lid")

%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">
	
    <section id="s_header" class="cf">
        <div class="grid-4 titulo"><h1 class="heading">art&iacute;culos - Accesos duplicados</h1></div>
        <div class="grid-2 grid-flow-opposite titulo"><!--#include virtual="/admin/inc_menu.asp" --></div>
    </section>
    
    <section id="s_formulario" class="cf">
    	
        <div class="grid-4">
            <div class="caja">
                <form id="frm_articulos" name="frm_articulos" action="/admin/articulos/datos/articulos.asp" method="post" autocomplete="off" target="_blank">
                    <p><input type="submit" value="cargar"> &nbsp; <a href="">reset</a></p>
                </form>
            </div>
        </div>
        
        <div class="grid-2">
            <div class="caja">
                <form action="/admin/accesos/bin/del_reg_articulos_duplicados.asp" method="post" name="frm_duplicados" id="frm_duplicados">
                  <!-- reg_articulos duplicados &nbsp; --><input name="duplicados" id="duplicados" type="text" value=""> 
                  <input name="submit" type="submit" id="cmd_duplicados" value="eliminar" disabled>
                </form>
                <p id="timming"></p>
            </div>
        </div>
        
    </section>
	
    <section id="s_datos" class="cf">
		<div class="grid-full">
            <!--Horizontal Tab-->
            <div id="tabData">
                <ul class="resp-tabs-list">
                    <li>Duplicados</li>
                    <li>Acesos</li>
                    <li>Pags</li>
                </ul>
                <div class="resp-tabs-container">
                    <div>
                        <div id="result_articulos"></div>
                        <div id="loading_articulos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
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
		</div>
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
	$('#frm_articulos').submit(function(){ 
		$('#duplicados').val('');
		$('#cmd_duplicados').attr("disabled", "disabled");
		
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/accesos/articulos/datos/articulos.asp',
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
		
		return false;
	});
	
	
	// tabs
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
	
	
	$('#frm_articulos').submit();
	
});

</script>

