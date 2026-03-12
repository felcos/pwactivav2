<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "https://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>PW - probando data-picker</title>
</head>
	
<script type="text/javascript" src="/js/jquery.js"></script>

<link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
<link href="/lib/datepicker/layout.css" rel="stylesheet" type="text/css" />
<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<script language="javascript">
$(document).ready(function() {
	$('#date').DatePicker({
		flat: true,
		date: '2008-07-31',
		current: '2008-07-31',
		calendars: 1,
		starts: 1,
		view: 'years'
	});
	
	
	var f_desde = new Date();
	f_desde.addDays(-15);
	var f_hasta = new Date()
	$('#widgetCalendar').DatePicker({
		flat: true,
		format: 'd/m/Y',	/* 'd B, Y' */
		date: [new Date(f_desde), new Date(f_hasta)],
		
		calendars: 3,
		mode: 'range',
		starts: 1,
		onChange: function(formated) {
			$('#widgetField span').get(0).innerHTML = formated.join(' - ');
		}
	});
	var state = false;
	$('#widgetField>a').bind('click', function(){
		$('#widgetCalendar').stop().animate({height: state ? 0 : $('#widgetCalendar div.datepicker').get(0).offsetHeight}, 500);
		state = !state;
		return false;
	});
	$('#widgetCalendar div.datepicker').css('position', 'absolute');
});
</script>

<body>
<p>Pruebas DatePicker </p>
<p>&nbsp;</p>

<br>
<div id="widget">
    <div id="widgetField">
        <span>(&uacute;ltimos 15 d&iacute;as)</span>
        <a href="#">seleccionar un intervalo</a>
    </div>
    <div id="widgetCalendar">
    </div>
</div>
                
</body>
</html>


