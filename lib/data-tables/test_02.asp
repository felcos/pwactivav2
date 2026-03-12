<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">
	<title>DataTables example - Zero configuration</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/lib/data-tables/css/jquery.dataTables.css">
    
	<script type="text/javascript" language="javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/lib/data-tables/jquery.dataTables.js"></script>
</head>
<body>
<h1>DataTables example <span>Zero configuration</span></h1>
<p>DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function.</p>
<p>Searching, ordering, paging etc goodness will be immediately added to the table, as shown in this example.</p>
<hr>
<div class="contenedor">
<table id="example" class="display compact hover" cellspacing="0" width="100%">
<thead>
    <tr>
        <th class="dt-head-left" style="width:40px;">id</th>
        <th class="dt-head-left">cliente</th>
        <th class="dt-head-left">usuario</th>
        <th class="dt-head-left" style="width:40px;"></th>
        <th class="dt-head-left" style="width:40px;"></th>
        <th class="dt-head-left" style="width:80px;">&uacute;lt.acc.</th>
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
$(document).ready(function() {
	$('#example').DataTable({
		"paging": false,
		
		"scrollY": "350px",
        "scrollCollapse": true,
		
        //"ordering": false,
        //"info":     false
		"language": {
			"url": "/lib/data-tables/spanish.json"
		},
		"lengthMenu": [[25, 50, -1], [25, 50, "Todos"]],
		"ajax": '/lib/data-tables/data_02.asp'
		
	});
});
</script>

