<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta charset="utf-8">

<!--#include virtual="/inc/js.asp" -->

<link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
<script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>

<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>

<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>

<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.ohlcRenderer.min.js"></script>

<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.cursor.min.js"></script>

<div id="graf"></div>
<div>
<% 
'if request.Cookies("dev")("request")<>"" then
	for each elto in request.Form
		%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
	next 
'end if

FechaI = request.Form("FechaI")
FechaF = request.Form("FechaF")

if FechaI="" then FechaI="01/06/2014"
sqlW = ""

if FechaI<>"" then sqlW = sqlW & "fecha>='" & FechaI & "'"
if FechaF<>"" then 
	if datediff("d", date, FechaF)>0 then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "fecha<='" & FechaF & "'"
	end if
end if
if sqlW<>"" then sqlW = " WHERE (" & sqlW & ") "

sql = "SELECT CONVERT(VARCHAR(10), fecha, 110) AS ff, COUNT(id) AS articulos FROM reg_articulos"
sql = sql & sqlW
'	/* NOT (usuario_id IS NULL) AND */
'	session_start>=01/01/2014
sql = sql & "GROUP BY fecha "
sql = sql & "ORDER BY CONVERT(VARCHAR(10), fecha, 110)"


Set rs = Server.CreateObject("ADODB.Recordset")
'test_inyeccion_sql sql
'response.Write(sql)
'response.End()

rs.Open sql, session("connPWAcesos")	', 1, 1

nn = 0
vArticulos = ""

do while not rs.eof 
nn=nn+1
	wd = DatePart("w", rs("ff"), 2)
	if wd<6 and rs("articulos")>10  then
		if vArticulos<>"" then vArticulos = vArticulos & ", "
		vArticulos = vArticulos & "['" & rs("ff") & "', " & rs("articulos") & "]"
	end if
	rs.movenext
loop 

rs.close
set rs=nothing


'vArticulos = "[1985, 8.50], [1986, 7.50], [1987, 6.75], [1988, 5.75], [1989, 5.25], "
'vArticulos = vArticulos & "[1990, 5.25], [1991, 5.75], [1992, 6.75], [1993, 7.00], [1994, 7.00], [1995, 6.50], [1996, 5.75], [1997, 5.50], [1998, 5.25], [1999, 5.00], "
'vArticulos = vArticulos & "[2000, 5.25], [2001, 6.50], [2002, 6.00], [2003, 5.75], [2004, 5.00], [2005, 4.50], [2006, 4.25], [2007, 4.00], [2008, 5.90], [2009, 5.80], "
'vArticulos = vArticulos & "[2010, 5.75], [2011, 6.00], [2012, 6.25], [2013, 6.25], [2014, 4.75]"
%>

</div>
<script type="text/javascript">
$(document).ready(function(){
	$.jqplot.config.enablePlugins = true;
	
	graf = $.jqplot('graf', [ [<%= vArticulos %>] ], {
		// Turns on animatino for all series in this plot.
        animate: true,
        // Will animate plot on calls to plot1.replot({resetAxes:true})
        animateReplot: true,
        
        series:[
            {
                lineWidth:1, 
				
				rendererOptions: {
                    animation: {
                        speed: 2000
                    }
                }
            }
        ],
        axesDefaults: {
            pad: 0
        },
        axes: {
            // These options will set up the x axis like a category axis.
            xaxis: {
				renderer:$.jqplot.DateAxisRenderer,
				tickOptions:{formatString:'%d/%m/%y'},
				//min: "01-01-2014",
				//max: "06-22-2009",
				//tickInterval: "1 month"		//2 weeks
			},
            yaxis: {
                tickOptions: {
                    formatString: "%d"
                },
                rendererOptions: {
                    forceTickAt0: true
                }
            }
        },
		highlighter: {
			show:false,
            sizeAdjust: 2,
			tooltipAxes: 'xy',
			showMarker: true,
			showTooltip: false
        }
	});
	
});


</script>
<hr />
<%= vArticulos %>

