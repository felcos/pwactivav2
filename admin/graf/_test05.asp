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
if request.Form("yy")="" then
	rYear = "2014"
else
	rYear = request.Form("yy")
end if

if request.Form("tipo")="" then
	rTipo = "d"
else
	rTipo = request.Form("tipo")
end if

select case rTipo
case "d"
	titulo = "Art&iacute;culos por D&iacute;a"
case "w"
	titulo = "Art&iacute;culos por D&iacute;a"
end select

dim currYear
dim prevYear
	
if request.Form("yy")<>"" then
Set rs = Server.CreateObject("ADODB.Recordset")

'currYear
select case rTipo
case "d"
	sql = "SELECT CONVERT(VARCHAR(10), fecha, 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '2015-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '2015-12-31', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY fecha"
case "w"
	sql = "SELECT CONVERT(VARCHAR(10), MIN(fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '2015-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '2015-12-31', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(ww, fecha)"
end select

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if currYear<>"" then
		currYear = currYear & ", "
	end if
	currYear = currYear & "['" & rs("ff") & "', " & rs("nn") & "]"
	rs.movenext
loop
rs.close
%>
<p><%= sql %></p>
<%
'prevYear
select case rTipo
case "d"
	sql = "SELECT CONVERT(VARCHAR(10), dateadd(yy, " & (2015-rYear) & ", fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '" & rYear & "-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '" & rYear & "-12-31', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY fecha"
case "w"
	sql = "SELECT CONVERT(VARCHAR(10), dateadd(yy, " & (2015-rYear) & ", MIN(fecha)), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '" & rYear & "-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '" & rYear & "-12-31', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(ww, fecha)"
end select

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if prevYear<>"" then
		prevYear = prevYear & ", "
	end if
	
	prevYear = prevYear & "['" & rs("ff") & "', " & rs("nn") & "]"
	rs.movenext
loop
rs.close
%>
<p><%= sql %></p>
<%
set rs=nothing

end if
%>
    <div class="ui-widget ui-corner-all">
        <div class="ui-widget-header ui-corner-top">
<form action="" method="post" name="frm" id="frm">
	Comparar con: <select name="yy" onChange="$('#frm').submit();">
		<% for yy=2014 to 2010 step -1 %>
	        <option value="<%= yy %>" <% if cstr(yy)=rYear then %>selected<% end if %>><%= yy %></option>
        <% next %>
    </select>
     &nbsp; &nbsp; 
     <select name="tipo" onChange="$('#frm').submit();">
	    <option value="d" <% if rTipo="d" then %>selected<% end if %>>por d&iacute;as</option>
        <option value="w" <% if rTipo="w" then %>selected<% end if %>>por semanas</option>
        <option value="m" <% if rTipo="m" then %>selected<% end if %>>por meses</option>
    </select>
    &nbsp; &nbsp; 
    <a href="">reset</a>
</form>
        </div>
        <div class="ui-widget-content ui-corner-bottom ui-corner-top" >
            <div id="chart1"></div>
        </div>
    </div>

</body>

<% if request.Form("yy")<>"" then %>
<script class="code" type="text/javascript">
	$(document).ready(function () {
		$.jqplot._noToImageButton = true;
		
		var prevYear = [ <%= prevYear %> ];
		var currYear = [ <%= currYear %> ];
		
		var plot1 = $.jqplot("chart1", [prevYear, currYear], {
			seriesColors: ["rgba(78, 135, 194, 0.7)", "rgb(211, 235, 59)"],
			title: '<%= titulo %>',
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
				placement: 'inside'
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
					label: '<%= rYear %>'
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
					//renderer: $.jqplot.LogAxisRenderer, 
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
<% end if %>
</html>
