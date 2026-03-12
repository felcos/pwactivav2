<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

    <title>Ion.RangeSlider - test</title>
    <link rel="stylesheet" href="normalize.min.css" />
    <link rel="stylesheet" href="ion.rangeSlider.css" />
    <link rel="stylesheet" href="ion.rangeSlider.skinNice.css" />
</head>
<body>

<h1>ion rangeSlider</h1>
<li><a href="https://ionden.com/a/plugins/ion.rangeSlider/en.html" target="_blank">https://ionden.com/a/plugins/ion.rangeSlider/en.html</a></li>

<div style="text-align:center; padding:50px;">
	<div style="width: 200px;"><input type="text" id="range_1" /></div>
</div>


<!-- All JS -->
<script src="/js/jquery.js"></script>
<script src="ion.rangeSlider.min.js"></script>

<script>
    $(document).ready(function(){

        $("#range_1").ionRangeSlider({
            min: 2000,
            max: 2014,
            from: 2010,
            to: 2014,
			maxPostfix: "+",
            type: 'double',
            step: 1,
            prettify: true,
            //hasGrid: true,
			hideMinMax: true
        });

    });
</script>




</body>
</html>
