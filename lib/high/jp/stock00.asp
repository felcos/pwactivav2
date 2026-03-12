<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>PW</title>

		<script type="text/javascript" src="/js/jquery.js"></script>
		<style type="text/css">
${demo.css}
		</style>
		<script type="text/javascript">
$(function () {
	$.getJSON('/lib/high/jp/aapl-c.asp', function (data) {
        
		// Create the chart
        $('#container').highcharts('StockChart', {
			chart: {
                alignTicks: false
            },
			
            rangeSelector : {
                inputEnabled: $('#container').width() > 480,
                selected : 1
            },

            title : {
                text : 'Accesos al servidor'
            },

            series: [{
                //type: 'column',
                name: 'Artículos',
                data: data,
                dataGrouping: {
                    units: [[
                        'week', // unit name
                        [1] // allowed multiples
                    ], [
                        'month',
                        [1, 2, 3, 4, 6]
                    ]]
                }
            }]
        });
    });

});

		</script>
	</head>
	<body>
<script src="/lib/high/stock/js/highstock.js"></script>
<script src="/lib/high/stock/js/modules/exporting.js"></script>

<div id="container" style="height: 400px; min-width: 310px"></div>
	</body>
</html>
