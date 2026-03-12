<%
if request.Form("yy")="" then
	yy = "2014"
else
	yy = request.Form("yy")
end if

if request.Form("tipo")="" then
	tipo = "w"
else
	tipo = request.Form("tipo")
end if

titulo = "Art&iacute;culos Le&iacute;dos por "
select case tipo
case "d"
	titulo = titulo & "D&iacute;a"
case "w"
	titulo = titulo & "Semana"
case "m"
	titulo = titulo & "Mes"	
end select

if request.Form("anno_completo")="" then
	d = day(date)
	if d<10 then
		dd = "0" & d
	else
		dd = cstr(d)
	end if
	
	m = month(date)
	if m<10 then
		mm = "0" & m
	else
		mm = cstr(m)
	end if
	
	hasta = "-" & mm & "-" & dd
	
else
	hasta = "-12-31"
	
	
end if

dim currYear
dim prevYear
dim fechas

if request.Form("yy")<>"" then
Set rs = Server.CreateObject("ADODB.Recordset")

'currYear
select case tipo
case "d"
	sql = "SELECT CONVERT(VARCHAR(10), fecha, 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '2015-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '2015" & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY fecha"
	
case "w"
	sql = "SELECT CONVERT(VARCHAR(10), MIN(fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '2015-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '2015" & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(ww, fecha)"
	
case "m"
	sql = "SELECT CONVERT(VARCHAR(10), MIN(fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '2015-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '2015" & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(m, fecha)"
	
end select
sql = sql & " ORDER BY ff"

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if currYear<>"" then
		currYear = currYear & ", "
	end if
	currYear = currYear & "['" & rs("ff") & "', " & rs("nn") & "]"
	'if weekday(rs("ff"))<>1 then
	'	fechas = fechas & "[[" & rs("ff") & "]], "
	'else
		fechas = fechas & rs("ff") & "[" & datepart("w", rs("ff")) & "], "
	'end if
	rs.movenext
loop
rs.close

'prevYear
select case tipo
case "d"
	sql = "SELECT CONVERT(VARCHAR(10), dateadd(yy, " & (2015-yy) & ", fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '" & yy & "-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '" & yy & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY fecha"
	
case "w"
	sql = "SELECT CONVERT(VARCHAR(10), dateadd(yy, " & (2015-yy) & ", MIN(fecha)), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '" & yy & "-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '" & yy & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(ww, fecha)"
	
case "m"
	sql = "SELECT CONVERT(VARCHAR(10), dateadd(yy, " & (2015-yy) & ", MIN(fecha)), 121) AS ff, COUNT(id) AS nn FROM reg_articulos WHERE "
	sql = sql & "(fecha >= CONVERT(DATETIME, '" & yy & "-01-01', 102)) AND (fecha <= CONVERT(DATETIME, '" & yy & hasta & "', 102))"
	sql = sql & " AND (articulo_tipo <> 'ven') "
	sql = sql & "GROUP BY DATEPART(m, fecha)"
end select
sql = sql & " ORDER BY ff"

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	if prevYear<>"" then
		prevYear = prevYear & ", "
	end if
	
	prevYear = prevYear & "['" & rs("ff") & "', " & rs("nn") & "]"
	rs.movenext
loop
rs.close

set rs=nothing

end if
%><script class="code" type="text/javascript">
$(document).ready(function () {
	if (plot1) {
		plot1.destroy();
		$('#graf1').unbind('jqplotDataClick');
		$("#informa").html("");
	};
	
	$.jqplot._noToImageButton = true;
	
	var prevYear = [ <%= prevYear %> ];
	var currYear = [ <%= currYear %> ];
	
	plot1 = $.jqplot("graf1", [prevYear, currYear], {
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
					formatString: "%d-%b",
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
	
	$('#graf1').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		var informa;
		var dd, mm, yy;
		var d, m, y;
		
		var ff = new Date(data[0]);
		
		d = ff.getDate();
		m =  ff.getMonth()+1;	// JavaScript months are 0-11
		if (d<10) {dd="0"+d} else {dd=d};
		if (m<10) {mm="0"+m} else {mm=m};
		
		if (seriesIndex==0) {
			$("#FechaI").val(dd + "/" + mm + "/" + $("#yy").val());
		} else {
			$("#FechaI").val(dd + "/" + mm + "/" + ff.getFullYear());
		};
		$("#FechaF").val($("#FechaI").val());
		
		$("#sem_res").val(pointIndex+1);
		
		/*
		informa = "<li>ev: " + ev + "</li>";
		informa = informa + "<li>seriesIndex: " + seriesIndex + "</li>";
		informa = informa + "<li>pointIndex: " + pointIndex + "</li>";
		informa = informa + "<li>fecha: " + dd + "/" + mm + "</li>";
		informa = informa + "<li>accesos: " + data[1] + "</li>";
		$("#informa").html(informa);
		*/
		$("#frm2").submit();
		
		//$("#fecha_resumen").val(dd + "/" + mm + "/" + y);
		//$("#fecha_resumen").val(fff);
		
		/*
		var formurl = "/admin/accesos/?f=" + ddf;
		var form = document.createElement("form");
		form.method = "GET";
		form.action = formurl;
		form.target = "_blank";
		document.body.appendChild(form);
		form.submit();
		*/
	});
	
	//$('.jqplot-highlighter-tooltip').addClass('ui-corner-all')
	//$("#informa_graf1").html("< %= request.Form %><br>< %= fechas %><br>< %= currYear %>")
	//$("#informa_graf1").html("< %= sql %>")
});
</script>