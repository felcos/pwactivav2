<!DOCTYPE html>
<html>
<head>
    <!-- meta charset="utf-8" -->
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">
	<title>DataTables example - Zero configuration</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/lib/data-tables/css/jquery.dataTables.css">
    
	<script type="text/javascript" language="javascript" src="/js/jquery.js"></script>
    <script type="text/javascript" language="javascript" src="/lib/data-tables/jquery.dataTables.js"></script>
</head>
<body>
<div class="contenedor">
    <h1>DataTables example <span>Zero configuration</span></h1>
    <p>DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function.</p>
    <p>Searching, ordering, paging etc goodness will be immediately added to the table, as shown in this example.</p>
    <hr>
<%
Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT * FROM reg_accesos WHERE session_start>='22/05/2015' AND cookie_l<>''"	
rs.Open sql, session("connPWAcesos")

nn = 0
%>
	<div id="demo">
<table id="example" class="display compact hover" cellspacing="0" width="100%">
<thead>
    <tr>
        <th class="dt-head-left">id</th>
        <th class="dt-head-left">start</th>
        <th class="dt-head-left">licencia</th>
        <th class="dt-head-left">cliente</th>
        <th class="dt-head-left">login</th>
        <th class="dt-head-left">SessionId</th>
    </tr>
</thead>

<tfoot>
    <tr>
        <th>id</th>
        <th>start</th>
        <th>licencia</th>
        <th>cliente</th>
        <th>login</th>
        <th>SessionId</th>
    </tr>
</tfoot>

<tbody>      
<%
do while not rs.eof 
	nn=nn+1
%>
<tr>
    <td><%= rs("id") %></td>
    <td><%= rs("session_start") %></td>
    <td><%= rs("cookie_l") %></td>
    <td><%= rs("cookie_u") %></td>
    <td><%= rs("session_login") %></td>
    <td><a href="/" target="_blank"><%= rs("session_id") %></a></td>
</tr>
	<% rs.movenext
loop
%>
</tbody>
</table>
	
    </div>
</div>
<hr>
<%
for ii=0 to rs.fields.count-1
	response.Write("<li>" & rs(ii).name & "</li>")
next

rs.close
set rs=nothing
%>

<p>DataTables has most features enabled by default, so all you need to do to use it with your own tables is to call the construction function.</p>
<p>Searching, ordering, paging etc goodness will be immediately added to the table, as shown in this example.</p>

</body>
</html>
<script type="text/javascript" language="javascript">
$.fn.dataTable.Api.register( 'column().data().sum()', function () {
    return this.reduce( function (a, b) {
        var x = parseFloat( a ) || 0;
        var y = parseFloat( b ) || 0;
        return x + y;
    } );
} );
 
$(document).ready(function() {
	var table = $('#example').DataTable({
		//"paging":   false,
        //"ordering": false,
        //"info":     false
		"language": {
			"url": "/lib/data-tables/spanish.json"
		},
		"lengthMenu": [[25, 50, -1], [25, 50, "Todos"]]
	});
	
	$('<button>Click to sum age in all rows</button>')
		.prependTo( '#demo' )
		.on( 'click', function () {
			alert( 'Column sum is: '+ table.column( 3 ).data().sum() );
		});
	
	$('<button>Click to sum age of visible rows</button>')
		.prependTo( '#demo' )
		.on( 'click', function () {
			alert( 'Column sum is: '+ table.column( 3, {page:'current'} ).data().sum() );
		});
});
</script>

