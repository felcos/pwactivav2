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
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
    
    <link href="/admin/accesos/dataTables.css" rel="stylesheet" type="text/css">
    <script src="/lib/data-tables/media/js/jquery.dataTables.js" type="text/javascript" language="javascript"></script>
	
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
<%
fecha = request.QueryString("f")
if fecha="" then fecha=date
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
<form id="frm_accesos" name="frm_accesos" action="/admin/accesos/fecha.asp" method="get" autocomplete="off">
    <input type="text" name="Fecha" id="Fecha" value="<%= fecha %>" maxlength="10" class="fecha">
	<input type="submit" value="cargar">
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
                <li>Art&iacute;culos</li>
                <li>Accesos</li>
            </ul>
            <div class="resp-tabs-container">
            
<div>
<table id="example" class="display" cellspacing="0">
<thead>
    <tr>
        <th width="30">N&deg;</th>
        <th width="30">Hora</th>
        <th width="50"> </th>
        <th width="100">Licencia</th>
        <th width="100">Cliente</th>
        <th width="250">Art&iacute;culo</th>
    </tr>
</thead>

<tfoot>
    <tr>
    	<th>N&deg;</th>
        <th>Hora</th>
        <th> </th>
        <th>Licencia</th>
        <th>Cliente</th>
        <th>Art&iacute;culo</th>
    </tr>
</tfoot>
</table>
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
$(document).ready(function(){
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
			if (ant_date!=$('#FechaI').val()) {
				$('#Fecha').DatePickerHide();
				//$('#frm_deal').submit();
			}
		}
	});
	
	
	$(document).ready(function() {
		$('#example').dataTable( {
			"ajax": "/admin/accesos/arrays_fecha.asp?f=<%= fecha %>",
			"paging":   false,
        	//"ordering": false,
        	"info":     false
		});
	});
});
</script>


