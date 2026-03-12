<%
'server.ScriptTimeout=300
f_hoy = date
f_desde = request.QueryString("FechaI")
f_hasta = request.QueryString("FechaF")

dim data	
Set rs = Server.CreateObject("ADODB.Recordset")

sqlw = "(fecha >= '" & f_desde & "' AND fecha <= '" & f_hasta & "')"

if request.QueryString("articulotipo")<>"" then
	sqlw = sqlw & " AND articulo_tipo = '" & request.QueryString("articulotipo") & "'"
end if
if sqlw<>"" then sqlw = "WHERE (" & sqlw & ") "

select case request.QueryString("intervalo")
case "mes"
	intervalo = "mm"
	titulo = " por Mes"
	formatString = "%b %y"
case "sem"
	intervalo = "ww"
	titulo = " por Semana"
	formatString = "%d-%b-%Y"
end select

sql = "SELECT CONVERT(VARCHAR(10), MIN(fecha), 121) AS ff, COUNT(id) AS nn FROM reg_articulos " & sqlw 
sql = sql & "GROUP BY DATEPART(yy, fecha), DATEPART(" & intervalo & ", fecha)"

rs.Open sql, session("connPWAcesos")
nn=0
do while not rs.eof
	'if data<>"" then
	'	data = data & ", "
	'end if
	nn=nn+1
	data = data & "['" & rs("ff") & "', " & rs("nn") & "], "
	rs.movenext
loop
rs.close
set rs=nothing
select case request.QueryString("articulotipo")
case "not"
	titulo = "Noticias" & titulo
case "rum"
	titulo = "Rumores" & titulo
case "ope"
	titulo = "Operaciones" & titulo
case "est"
	titulo = "Estudios" & titulo
case "dem"
	titulo = "Demandas" & titulo
case "sub"
	titulo = "Subastas" & titulo
case "ven"
	titulo = "Vencimientos" & titulo
case else
	titulo = "Art&iacute;culos" & titulo
end select

if nn>48 then
	tickInterval = "3 months"
else
	tickInterval = "1 month"
end if

%>
<script class="code" type="text/javascript">
$(document).ready(function () {
	
	if (plot1) {
		plot1.destroy();
		$('#graf1').unbind('jqplotDataClick');
		$("#informa").html("");
	};
	
	$.jqplot._noToImageButton = true;
	
	//var 
	plot1 = $.jqplot("graf1", [ [<%= data %>] ], {
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
			gridLineWidth: 1.2
		},
		legend: {
			show: false,
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
				fill: true
				//,label: '< %= rYear %>'
			},
			{
				//label: '2015'
			}
		],
		axesDefaults: {
			rendererOptions: {
				baselineWidth: 1.5,
				//baselineColor: '#444444',
				drawBaseline: false
			}
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.DateAxisRenderer,
				tickRenderer: $.jqplot.CanvasAxisTickRenderer,
				//min: "2010-01-01",
				//padMin: 5,
				tickOptions: {
					formatString: "<%= formatString %>",
					angle: -30
					//,textColor: '#dddddd'
				},
				tickInterval: "<%= tickInterval %>",
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
	
	//$("#informa_graf1").html("< %= nn %> datos");
	$("#informa_graf1").html("<%= sql %>");
	
	$('#graf1').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		var informa;
		var dd = new Date(data[0]);
		
		var d = dd.getDate();
		var m =  dd.getMonth()+1;	// JavaScript months are 0-11
		var y = dd.getFullYear();
		var dd, mm, yy;
		
		if (d<10) {dd="0"+d} else {dd=d};
		if (m<10) {mm="0"+m} else {mm=m};
		var fff = dd + "-" + mm + "-" + y;
		
		/*
		informa = "<li>ev: " + ev + "</li>";
		informa = informa + "<li>seriesIndex: " + seriesIndex + "</li>";
		informa = informa + "<li>pointIndex: " + pointIndex + "</li>";
		informa = informa + "<li>fecha: " + ddf + "</li>";
		informa = informa + "<li>accesos: " + data[1] + "</li>";
		$("#informa").html(informa);
		*/
		
		//$("#fecha_resumen").val(dd + "/" + mm + "/" + y);
		$("#fecha_resumen").val(fff);
		//$("#frm_res").submit();
		$("#submit_resumen").click();
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
});

</script>