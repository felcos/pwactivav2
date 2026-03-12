<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Documento sin título</title>
<%
pasa=false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!--#include virtual="/inc/js.asp" -->

<link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
<!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
<script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>

<!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shCore.min.js"></script -->
<!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushJScript.min.js"></script -->
<!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushXml.min.js"></script -->

<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>

</head>
<%
anno = 2014

%>
<body>
<%
Set rs = Server.CreateObject("ADODB.Recordset")

dim sumaMes(12)
dim sumaSem(53)
dim tickSem(53)

dim currYear
dim prevYear

f_ini = "01/01/" & anno
f_fin = "31/12/" & anno
%>
<p>f_ini: <%= f_ini %> [<%= datepart("w", f_ini, 2) %>]</p>
<%
f_ini = dateadd("d", 1-datepart("w", f_ini, 2), f_ini)
%>
<p>start: <%= f_ini %> [<%= datepart("w", f_ini, 2) %>]</p>
<hr />


<p>f_fin: <%= f_fin %> [<%= datepart("w", f_fin, 2) %>]</p>
<%
f_fin = dateadd("d", 7-1-datepart("w", f_fin, 2), f_fin)
%>
<p>fin: <%= f_fin %> [<%= datepart("w", f_fin, 2) %>]</p>
<hr />
<div id="graf1"></div>
<hr />
<%
sql = "SELECT fecha, COUNT(id) AS nn FROM reg_articulos WHERE "
sql = sql & "(fecha >= '" & f_ini & "' AND fecha <= '" & f_fin & "') "
sql = sql & "GROUP BY fecha "
sql = sql & "ORDER BY fecha"

rs.Open sql, session("connPWAcesos")
%>
<table border="1" cellspacing="0" cellpadding="2">
<tr>
        <td width="60">fecha</td>
        <td width="60">visitas</td>
        <td width="30"></td>
        <td width="60">mes</td>
        <td width="60">sumaMes(mes)</td>
        <td width="30"></td>
        <td width="60">sem</td>
        <td width="60">sumaSem(sem)</td>
        <td width="30"></td>
        <td width="60">tickSem(sem)</td>
    </tr>
<%
do while not rs.eof
	if datepart("yyyy", rs("fecha")) > anno then
		'sem = datepart("ww", rs("fecha"), 2)
	elseif datepart("yyyy", rs("fecha")) < anno then
		sem = 1
	else
		sem = datepart("ww", rs("fecha"), 2)
	end if
	'if sem=54 then sem=1
	sumaSem(sem) = sumaSem(sem) + rs("nn")
	if tickSem(sem)="" then 
		tickSem(sem) = rs("fecha")
		if datepart("ww", rs("fecha"), 2)>1 then
			tickSem(sem) = dateadd("d", 1-datepart("w", tickSem(sem), 2), tickSem(sem)) 
			tickSem(sem) = datepart("yyyy", tickSem(sem)) & "-" & datepart("m", tickSem(sem)) & "-" & datepart("d", tickSem(sem))
		end if
	end if
	
	if datepart("yyyy", rs("fecha")) = anno then
		mes = datepart("m", rs("fecha"), 2)
		if mes=12 and datepart("yyyy", rs("fecha")) < anno then mes=1
		sumaMes(mes) = sumaMes(mes) + rs("nn")
	end if
	%>
    <tr>
        <td width="150"><%= rs("fecha") %> [<%= datepart("w", rs("fecha"), 2) %>]</td>
        <td width="60"><%= rs("nn") %></td>
        <td width="30"></td>
        <td width="60"><%= mes %></td>
        <td width="60"><%= sumaMes(mes) %></td>
        <td width="30"></td>
        <td width="60"><%= sem %></td>
        <td width="60"><%= sumaSem(sem) %></td>
        <td width="30"></td>
        <td width="60"><%= tickSem(sem) %></td>
    </tr>
	<%
	rs.movenext
loop
%>
</table>
<hr />
Meses
<table border="1" cellspacing="0" cellpadding="2">
  <% for m=1 to 12 %>
  <tr>
    <td width="60"><%= m %></td>
    <td><%= sumaMes(m) %></td>
    <td>&nbsp;</td>
  </tr>
  <% next %>
</table>

<hr />
Semanas
<table border="1" cellspacing="0" cellpadding="2">
  <% for w=1 to 53 
  	if tickSem(w)<>"" then %>
      <tr>
        <td width="60"><%= w %></td>
        <td width="100"><%= sumaSem(w) %></td>
        <td width="100"><%= tickSem(w) %> [<%= datepart("w", tickSem(w), 2) %>]</td>
        <td width="100">[<%= datepart("ww", tickSem(w), 2) %>]</td>
      </tr>
      <% 
		currYear = currYear & "['" & tickSem(w) & "', " & sumaSem(w) & "], "
	  end if
  next %>
</table>
<%= currYear %>
</body>
</html>
<script class="code" type="text/javascript">
$(document).ready(function () {
	$.jqplot._noToImageButton = true;
	
	var prevYear = [ <%= prevYear %> ];
	var currYear = [ <%= currYear %> ];
	
	var plot1 = $.jqplot("graf1", [currYear], {
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
			gridLineColor: '#ddd',
			gridLineWidth: 1
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
				label: '<%= yy %>'
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
					formatString: "%d-%b-%Y",
					angle: -30
					//,textColor: '#dddddd'
				},
				tickInterval: "1 month",
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

	//$('.jqplot-highlighter-tooltip').addClass('ui-corner-all')
	$("#informa_graf1").html("<%= request.Form %><br><%= fechas %><br><%= currYear %>")
	//$("#informa_graf1").html("< %= sql %>")
});
</script>