<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Documento sin título</title>
	<!--#include virtual="/inc/js.asp" -->

    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
	<script type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
    
    <script type="text/javascript" src="/lib/jqplot/plugins/jqplot.ohlcRenderer.min.js"></script>
    
    <script type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    
    <script type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>
    <script type="text/javascript" src="/lib/jqplot/plugins/jqplot.cursor.min.js"></script>

</head>
<body>
<%
sql = "SELECT *, CONVERT(VARCHAR(10), fecha, 121) AS ff FROM regFechas('2012-01-01', '2015-05-01')"
%>
<div id="grafico" style="height:450px; width:1200px;"></div>

<hr />
<div id="datos">
	<% call Articulos %>
    <hr />
    <%= sql %>
</div>

</body>
</html>

<script type="text/javascript">
$(document).ready(function(){
	//var datos=[['2008-08-01', 40], ['2008-09-01', 65], ['2008-10-01', 57], ['2008-11-01', 90], ['2008-12-01', 82]];
	var datos=[ <% Articulos %> ];
	
	plot1 = $.jqplot('grafico', [datos], { 
        series: [{ 
            renderer: $.jqplot.OHLCRenderer,
            rendererOptions: {
                candleStick: true
            } 
        }], 
        axes: { 
            xaxis: { 
                renderer:$.jqplot.DateAxisRenderer,
                rendererOptions: {
                    tickInset: 0
                },
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                tickOptions: {
                  angle: -30
                } 
            }, 
            yaxis: {  
				//min: 0,
				//max: 2000
                //renderer: $.jqplot.LogAxisRenderer,
                //tickOptions:{ prefix: '$' } 
            } 
        }, 
		series: [{renderer:$.jqplot.OHLCRenderer, rendererOptions:{candleStick:true}}],
        cursor:{
			zoom:true,
			tooltipOffset: 10,
			tooltipLocation: 'nw'
        },
		highlighter: {
			showMarker:true,
			tooltipAxes: 'xy',
			yvalues: 4,
			formatString:'<table class="jqplot-highlighter"> \
			<tr><td>date:</td><td>%s</td></tr> \
			<tr><td>open:</td><td>%s</td></tr> \
			<tr><td>hi:</td><td>%s</td></tr> \
			<tr><td>low:</td><td>%s</td></tr> \
			<tr><td>close:</td><td>%s</td></tr></table>'
		}
    });
});
</script>

<% 
sub Articulos()	
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, session("connPWAcesos")
	
	primero = true
	
	do while not rs.eof
		if primero then 
			primero=false
		else
			%>, <%
		end if
		
		%>['<%= rs("ff") %>', <%= rs("accesos") %>, <%= rs("pags") %>, <%= rs("articulos") %> ]<%
		rs.movenext
	loop
	
	rs.close
	set rs=nothing
end sub %>
