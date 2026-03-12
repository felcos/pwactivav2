<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PW</title>
    <script type="text/javascript">
var t_ini = new Date()
    </script>
    <script type="text/javascript" src="/js/jquery.js"></script>
    <script src="/lib/high/charts/js/highcharts.js"></script>
    <style type="text/css">
#result {
	text-align: right;
	color: gray;
	min-height: 2em;
}
#table-sparkline {
	margin: 0 auto;
    border-collapse: collapse;
}
th {
    font-weight: bold;
    text-align: left;
}
td, th {
    padding: 5px;
    border-bottom: 1px solid silver;
    height: 20px;
}

thead th {
    border-top: 2px solid gray;
    border-bottom: 2px solid gray;
}
.highcharts-tooltip>span {
	background: white;
	border: 1px solid silver;
	border-radius: 3px;
	box-shadow: 1px 1px 2px #888;
	padding: 8px;
}
    </style>
</head>
<body>
<li>total time: <span id="tiempo">xxx</span></li>
<li>jquery time: <span id="tiempo_jquery">xxx</span></li>
<div id="result"></div>
<%
yy = 2015

if yy = 2015 then 
	meses = month(date)
else
	meses = 12
end if

Set rs = Server.CreateObject("ADODB.Recordset")
session("connPWAcesos").CommandTimeout = 300

sql = "SELECT TOP 5 ID, EMPRESA, NOMBRE_EMPRESA, NUM_LICENCIAS, LICENCIAS_ENVIADAS"
for ii=1 to 12
	sql = sql & ", dbo.regAccesosCliente_mes(ID, " & yy-1 & ", " & ii & ") AS m" & ii
next
for ii=1 to meses
	sql = sql & ", dbo.regAccesosCliente_mes(ID, " & yy & ", " & ii & ") AS m" & (ii+12)
next
sql = sql & " FROM PW_clientes WHERE id>2 AND ACTIVO=1"


rs.Open sql, session("connPWAcesos")
%>
<table id="table-sparkline">
<thead>
    <tr>
        <th>Id</th>
        <th>Cliente</th>
        <th>Income per quarter</th>
        <th>Costs</th>
        <th>Costs per quarter</th>
	</tr>
</thead>
<tbody id="tbody-sparkline">
<% 
do while not rs.eof
	g1 = ""
	for ii=1 to (meses+12)
		if g1<>"" then g1 = g1 & ", "
		g1 = g1 & rs("m" & ii)
	next
%>
<tr>
    <th><%= rs("id") %></th>
    <th><%= rs("empresa") %></th>
    <td data-sparkline="<%= g1 %>"/>
    <td>-42</td>
    <td data-sparkline="<%= g1 %>; column"/>
</tr>
	<% rs.movenext
loop 

rs.close
set rs=nothing
%>
</tbody>
</table>

</body>
</html>
<script type="text/javascript">
$(function () {
    /**
     * Create a constructor for sparklines that takes some sensible defaults and merges in the individual
     * chart options. This function is also available from the jQuery plugin as $(element).highcharts('SparkLine').
     */
    Highcharts.SparkLine = function (options, callback) {
        var defaultOptions = {
            chart: {
                renderTo: (options.chart && options.chart.renderTo) || this,
                backgroundColor: null,
                borderWidth: 0,
                type: 'area',
                margin: [2, 0, 2, 0],
                width: 120,
                height: 20,
                style: {
                    overflow: 'visible'
                },
                skipClone: true
            },
            title: {
                text: ''
            },
            credits: {
                enabled: false
            },
            xAxis: {
                labels: {
                    enabled: false
                },
                title: {
                    text: null
                },
                startOnTick: false,
                endOnTick: false,
                tickPositions: []
            },
            yAxis: {
                endOnTick: false,
                startOnTick: false,
                labels: {
                    enabled: false
                },
                title: {
                    text: null
                },
                tickPositions: [0]
            },
            legend: {
                enabled: false
            },
            tooltip: {
                backgroundColor: null,
                borderWidth: 0,
                shadow: false,
                useHTML: true,
                hideDelay: 0,
                shared: true,
                padding: 0,
                positioner: function (w, h, point) {
                    return { x: point.plotX - w / 2, y: point.plotY - h};
                }
            },
            plotOptions: {
                series: {
                    animation: false,
                    lineWidth: 1,
                    shadow: false,
                    states: {
                        hover: {
                            lineWidth: 1
                        }
                    },
                    marker: {
                        radius: 1,
                        states: {
                            hover: {
                                radius: 2
                            }
                        }
                    },
                    fillOpacity: 0.25
                },
                column: {
                    negativeColor: '#910000',
                    borderColor: 'silver'
                }
            }
        };
        options = Highcharts.merge(defaultOptions, options);

        return new Highcharts.Chart(options, callback);
    };

    var start = +new Date(),
        $tds = $("td[data-sparkline]"),
        fullLen = $tds.length,
        n = 0;

    // Creating 153 sparkline charts is quite fast in modern browsers, but IE8 and mobile
    // can take some seconds, so we split the input into chunks and apply them in timeouts
    // in order avoid locking up the browser process and allow interaction.
    function doChunk() {
        var time = +new Date(),
            i,
            len = $tds.length,
            $td,
            stringdata,
            arr,
            data,
            chart;

        for (i = 0; i < len; i += 1) {
            $td = $($tds[i]);
            stringdata = $td.data('sparkline');
            arr = stringdata.split('; ');
            data = $.map(arr[0].split(', '), parseFloat);
            chart = {};

            if (arr[1]) {
                chart.type = arr[1];
            }
            $td.highcharts('SparkLine', {
                series: [{
                    data: data,
                    pointStart: 1
                }],
                tooltip: {
                    headerFormat: '<span style="font-size: 10px">' + $td.parent().find('th').html() + ', Q{point.x}:</span><br/>',
                    pointFormat: '<b>{point.y}.000</b> USD'
                },
                chart: chart
            });

            n += 1;

            // If the process takes too much time, run a timeout to allow interaction with the browser
            if (new Date() - time > 500) {
                $tds.splice(0, i + 1);
                setTimeout(doChunk, 0);
                break;
            }

            // Print a feedback on the performance
            if (n === fullLen) {
                $('#result').html('Generated ' + fullLen + ' sparklines in ' + (new Date() - start) + ' ms');
            }
        }
    }
	
    doChunk();
	var t_fin_jquery = new Date()
	$("#tiempo_jquery").html(t_fin_jquery - t_ini);
	/**/
});
var t_fin = new Date()

$("#tiempo").html(t_fin - t_ini);

</script>
