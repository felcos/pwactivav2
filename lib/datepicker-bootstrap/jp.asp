<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>jQuery Datepicker</title>

    <link href="/lib/datepicker-bootstrap/datepicker.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/lib/datepicker-bootstrap/bootstrap.css">
    
    <script src="/js/jquery.min.js"></script>
    <script src="/lib/datepicker-bootstrap/bootstrap-datepicker.js"></script>
<script>
$(function() {
	$("#fecha").datepicker()
	
});

</script>
</head>
<body>
<h1>Bootstrap Datepicker</h1>
<p>jQuery Datepicker</p>

<input type="text" id="fecha" name="fecha" value="xyz">

<p class="informa" id="informa" style="background:#CCC;">x</p>
<p class="informa" style="background:#CCC;">y</p>

<p><label for="valor">valor 1: </label><input type="text" id="valor" name="n_valor" value="x"></p>
<p><label for="valor">valor 2: </label><input type="text" id="valor2" name="n_valor2" value="x"></p>

<p>&nbsp;</p>
<hr>
<p>This page demonstrates the very basics of the <a href="https://keith-wood.name/datepick.html">jQuery Datepicker plugin</a>.</p>
<p>It contains the minimum requirements for using the plugin and can be used as the basis for your own experimentation.</p>
<p>For more detail see the <a href="https://keith-wood.name/datepickRef.html">documentation reference</a> page.</p>

<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>

</body>
</html>
