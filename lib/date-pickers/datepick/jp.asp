<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<title>jQuery Datepicker</title>

<link href="/lib/date-pickers/datepick/css/jquery.datepick.css" rel="stylesheet" type="text/css">

<!--


<link href="/lib/date-pickers/datepick/redmond.datepick.css" rel="stylesheet" type="text/css">
<link href="/lib/date-pickers/datepick/flora.datepick.css" rel="stylesheet" type="text/css">
<link href="/lib/date-pickers/datepick/humanity.datepick.css" rel="stylesheet" type="text/css">
<link href="/lib/date-pickers/datepick/redmond.datepick.css" rel="stylesheet" type="text/css">
<link href="/lib/date-pickers/datepick/smoothness.datepick.css" rel="stylesheet" type="text/css">
-->

<script src="/js/jquery.min.js"></script>

<script src="/lib/date-pickers/datepick/jquery.plugin.min.js"></script>
<script src="/lib/date-pickers/datepick/jquery.datepick.min.js"></script>
<script src="/lib/date-pickers/datepick/lang/jquery.datepick-es.js"></script>

<script>
$(function() {
	$("#inlineDatepicker").datepick({
		/*
		commandsAsDateFormat: true,
		prevText: "< M",
		todayText: "M y",
		nextText: "M >",
		
		*/
		onSelect: showDate,
		//minDate: new Date(2015, 12-1, 25),
		
		altField: "#valor",
		altFormat: "dd/mm/yyyy"
		
	});
	
});

function showDate(date) {
	$(".informa").html(date);
	}
</script>
</head>
<body>
<h1>jQuery Datepicker</h1>
<p>jQuery Datepicker</p>

<div id="inlineDatepicker"></div>

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
