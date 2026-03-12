<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!-- include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<title>PropertyWeb - Admin</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <!-- link href="/_inc/foldy/forms.css" rel="stylesheet" type="text/css" -->
    
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="/lib/data-tables/css/jquery.dataTables.css" rel="stylesheet" type="text/css">
    
    <style type="text/css" class="init">

td.details-control {
	background: url('/lib/data-tables/images/details_open.png') no-repeat center center;
	cursor: pointer;
}
tr.shown td.details-control {
	background: url('/lib/data-tables/images/details_close.png') no-repeat center center;
}

	</style>
    
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
    
	<script type="text/javascript" language="javascript" src="/lib/data-tables/jquery.dataTables.js"></script>
    
<%
'server.ScriptTimeout=300
f_desde = "01/09/2015"
'f_desde = date
f_hasta = date
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-3">
    	<h1 class="heading">User Agents</h1>
	</div>
    
    <div class="grid-3 grid-flow-opposite">
    <form id="frm" name="frm" action="/admin/accesos/ua/accesos.asp" method="post" autocomplete="off" target="_blank">
        <div class="grid-2">
        	<input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
            &nbsp;-&nbsp;
        	<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
        </div>
        <div class="grid-1">
        	<select name="ver" id="ver" onChange="$('#frm').submit();">
        	  <option value="*" selected>todos</option>
        	  <option value="conlicencia">con licencia</option>
        	  <option value="sinlicencia">sin licencia</option>
        	</select>
        </div>
        <div class="grid-1"><input name="submit" type="submit" value="submit"></div>
        <div class="grid-1"><a href="/admin/accesos/ua/">refresh</a></div>
        <div class="grid-1"><a href="javascript: enviar();">submit</a></div>
    </form>
    
    </div>
    
</section>

</div>

<div class="contenedor">
<table id="example" class="display compact" cellspacing="0" width="100%">
<thead>
    <tr>
        <th></th>
        <th class="dt-head-left"></th>
        <th class="dt-head-left" width="150">#</th>
        
        <th class="dt-head-left">moz.</th>
        <th class="dt-head-left">nav.</th>
        <th class="dt-head-left">calc</th>
        <th class="dt-head-left">so</th>
        <th class="dt-head-left">calc</th>
        <th class="dt-head-left">mov.</th>
        
        <th class="dt-head-left" width="200">licencia</th>
        <th class="dt-head-left" width="120">cliente</th>
    </tr>
</thead>
</table>
</div>
<div id="informa"></div>

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
				$('#frm').submit();
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
				$('#frm').submit();
			}
		}
	});
	
	
	//$('#frm').submit();
	
});

function enviar() {
	$('#example').dataTable().fnDestroy();
	
	var table = $('#example').DataTable( {
		"paging": false,
		"scrollY": "450px",
		
		"bScrollCollapse ": true,
		"language": {
			"url": "/lib/data-tables/spanish.json"
		},
		
		"ajax": {
			"url": "/admin/accesos/ua/data/accesos.asp",
			"data": function (d) {
				d.ver = $('#ver').val();
				d.FechaI = $('#FechaI').val();
				d.FechaF = $('#FechaF').val();
			}
		},
		
		"initComplete": function(settings, json) {
			//alert( 'DataTables has finished its initialisation.' );
			//console.log(settings);
			var datos = json;
			$('#informa').html(
				'<li>'+datos['request']+'</li><p>'+datos['sql']+'</p><li>Total sin filtro: '+datos['total']+'</li>'
			);
		  },
		"columns": [
			{
				"className": 'details-control',
				"orderable": false,
				"data": "",
				"defaultContent": ''
			},
			{ "data": "nn", "className": 'peq' },
			
			{ "data": "http_mozilla", "orderable": false },
			
			{ "data": "http_navegador", "orderable": false },
			{ "data": "calc_navegador", "orderable": false },
			
			{ "data": "http_so", "orderable": false },
			{ "data": "calc_so", "orderable": false },
			
			{ "data": "movil", "orderable": false },
			{ "data": "session_start", "orderable": true },
			
			{ "data": "licencia", "className": 'mini' },
			{ "data": "cliente", "className": 'mini' }
		],
		"order": [[1, 'asc']]
	});

	// Add event listener for opening and closing details
	$('#example tbody').unbind();
	$('#example tbody').on('click', 'td.details-control', function () {
		var tr = $(this).closest('tr');
		var row = table.row( tr );

		if ( row.child.isShown() ) {
			// This row is already open - close it
			row.child.hide();
			tr.removeClass('shown');
		}
		else {
			// Open this row
			row.child( format(row.data()) ).show();
			tr.addClass('shown');
		}
	});
	
	return false;
};
	
/* Formatting function for row details - modify as you need */
function format ( d ) {
	// `d` is the original data object for the row
	return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
		'<tr>'+
			'<td>'+d.http_ua+'</td>'+
		'</tr>'+
	'</table>';
	};

</script>

