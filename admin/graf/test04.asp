<!DOCTYPE html>

<html>
<head>

    <title>Animated Dashboard Sample - Filled Line with Log Axis</title>

    <link type="text/css" rel="stylesheet" class="include" href="/lib/jqplot/jquery.jqplot.min.css" />

    <link type="text/css" rel="stylesheet" href="/lib/jqplot/examples/syntaxhighlighter/styles/shCoreDefault.min.css" />
    <link type="text/css" rel="stylesheet" href="/lib/jqplot/examples/syntaxhighlighter/styles/shThemejqPlot.min.css" />
    <!--#include virtual="/inc/js.asp" -->
    
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.js"></script><![endif]-->

    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shCore.min.js"></script -->
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushJScript.min.js"></script -->
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushXml.min.js"></script -->

    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>


<!-- link class="include" rel="stylesheet" type="text/css" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.0/themes/smoothness/jquery-ui.css" / -->
<style type="text/css">
	.jqplot-target {
		margin: 20px;
		height: 480px;
		width: 95%;
		color: #dddddd;
	}

	.ui-widget-content {
		background: rgb(57,57,57);
	}

	table.jqplot-table-legend {
		border: 0px;
		background-color: rgba(100,100,100, 0.0);
	}

	.jqplot-highlighter-tooltip {
		background-color: rgba(57,57,57, 0.9);
		padding: 7px;
		color: #dddddd;
	}
</style>

</head>
<body>
<%

dim currYear
dim prevYear
	
Set rs = Server.CreateObject("ADODB.Recordset")

'currYear
sql = "SELECT *, CONVERT(VARCHAR(10), fecha, 121) AS ff FROM regFechas('2015-01-01', '2015-12-31')"
rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if currYear<>"" then
		currYear = currYear & ", "
	end if
	
	currYear = currYear & "['" & rs("ff") & "', " & rs("articulos") & "]"
	rs.movenext
loop
rs.close

'prevYear
sql = "SELECT *, CONVERT(VARCHAR(10), dateadd(yy, 5, fecha), 121) AS ff FROM regFechas('2010-01-01', '2010-12-31')"
rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if prevYear<>"" then
		prevYear = prevYear & ", "
	end if
	
	prevYear = prevYear & "['" & rs("ff") & "', " & rs("articulos") & "]"
	rs.movenext
loop
rs.close

set rs=nothing
%>
    <div class="ui-widget ui-corner-all">
        <div class="ui-widget-header ui-corner-top">Hi Powered Data</div>
        <div class="ui-widget-content ui-corner-bottom" >
            <div id="chart1"></div>
        </div>
    </div>

</body>

<script class="code" type="text/javascript">
	$(document).ready(function () {
		$.jqplot._noToImageButton = true;
		
		var prevYear = [ <%= prevYear %> ];
		var currYear = [ <%= currYear %> ];
		
		var plot1 = $.jqplot("chart1", [prevYear, currYear], {
			seriesColors: ["rgba(78, 135, 194, 0.7)", "rgb(211, 235, 59)"],
			title: 'Art&iacute;culos por D&iacute;a',
			highlighter: {
				show: true,
				sizeAdjust: 1,
				tooltipOffset: 9
			},
			grid: {
				background: 'rgba(57,57,57,0.0)',
				drawBorder: false,
				shadow: false,
				gridLineColor: '#666666',
				gridLineWidth: 2
			},
			legend: {
				show: true,
				placement: 'outside'
			},
			seriesDefaults: {
				rendererOptions: {
					smooth: true,
					animation: {
						show: true
					}
				},
				showMarker: false
			},
			series: [
				{
					fill: true,
					label: '2010'
				},
				{
					label: '2015'
				}
			],
			axesDefaults: {
				rendererOptions: {
					baselineWidth: 1.5,
					baselineColor: '#444444',
					drawBaseline: false
				}
			},
			axes: {
				xaxis: {
					renderer: $.jqplot.DateAxisRenderer,
					tickRenderer: $.jqplot.CanvasAxisTickRenderer,
					tickOptions: {
						formatString: "%b %e",
						angle: -30,
						textColor: '#dddddd'
					},
					tickInterval: "7 days",
					drawMajorGridlines: false
				},
				yaxis: {
					renderer: $.jqplot.LogAxisRenderer, 
					pad: 0,
					rendererOptions: {
						minorTicks: 1
					},
					tickOptions: {
						formatString: "%'d",
						showMark: false
					}
				}
			}
		});

		$('.jqplot-highlighter-tooltip').addClass('ui-corner-all')
	});

</script>
</html>
