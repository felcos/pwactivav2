<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
</head>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.9.1/themes/base/jquery-ui.css" />

<script src="https://code.jquery.com/jquery-1.8.2.js"></script>
<script src="https://code.jquery.com/ui/1.9.1/jquery-ui.js"></script>

<link rel="stylesheet" href="/resources/demos/style.css" />

<script>
$(function() {
	$("#slider-range").slider({
		range: true,
		min: 1993,
		max: 2013,
		values: [2012,2013],
		step: 1,
		slide: function(event,ui) {
			$("#amount").val(ui.values[0] + " - " + ui.values[1]);
			
		}
	});
	$("#amount").val($("#slider-range").slider("values",0) +
		" - " + $("#slider-range").slider("values",1));
});
</script>
<body>

<form action="/jp/recibe.asp" target="_blank" method="post">
    <label for="amount">Per&iacute;odo: </label>
    <input type="text" id="amount" name="amount" style="border: 0; color: #f6931f; font-weight: bold;" />
<div id="slider-range"></div>

<input name="" type="submit" />
</form>
 
</body>
</html>
