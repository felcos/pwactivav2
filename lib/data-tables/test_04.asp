<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">
	<title>DataTables example - Zero configuration</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/lib/data-tables/css/jquery.dataTables.css">
    <style type="text/css" class="init">

td.details-control {
	background: url('/lib/data-tables/images/details_open.png') no-repeat center center;
	cursor: pointer;
}
tr.shown td.details-control {
	background: url('/lib/data-tables/images/details_close.png') no-repeat center center;
}

	</style>
	<script type="text/javascript" language="javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/lib/data-tables/jquery.dataTables.js"></script>
</head>
<body>
<h1>DataTables example <span>Zero configuration</span></h1>
<p>DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function.</p>
<p>Searching, ordering, paging etc goodness will be immediately added to the table, as shown in this example.</p>
<hr>
<div class="contenedor">
<table id="example" class="display compact" cellspacing="0" width="100%">
<thead>
    <tr>
        <th></th>
        <th class="dt-head-left">Name</th>
        <th class="dt-head-left">Position</th>
        <th class="dt-head-left">Office</th>
        <th class="dt-head-left">Salary</th>
    </tr>
</thead>
</table>

</div>
<hr>

<p>DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function.</p>
<p>Searching, ordering, paging etc goodness will be immediately added to the table, as shown in this example.</p>

</body>
</html>
<script type="text/javascript" language="javascript" class="init">
/* Formatting function for row details - modify as you need */
function format ( d ) {
	// `d` is the original data object for the row
	return '<table cellpadding="5" cellspacing="0" border="0" style="padding-left:50px;">'+
		'<tr>'+
			'<td>Full name:</td>'+
			'<td>'+d.name+'</td>'+
		'</tr>'+
		'<tr>'+
			'<td>Extension number:</td>'+
			'<td>'+d.extn+'</td>'+
		'</tr>'+
		'<tr>'+
			'<td>Extra info:</td>'+
			'<td>And any further details here (images etc)...</td>'+
		'</tr>'+
	'</table>';
}

$(document).ready(function() {
	var table = $('#example').DataTable( {
		"paging": false,
		"scrollY": "350px",
        "scrollCollapse": true,
		"language": {
			"url": "/lib/data-tables/spanish.json"
		},
		
		"ajax": "/lib/data-tables/data_04.asp",
		"columns": [
			{
				"className":      'details-control',
				"orderable":      false,
				"data":           null,
				"defaultContent": ''
			},
			{ "data": "name" },
			{ "data": "position" },
			{ "data": "office" },
			{ "data": "salary" }
		],
		"order": [[1, 'asc']]
	});
	
	// Add event listener for opening and closing details
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
});
</script>

