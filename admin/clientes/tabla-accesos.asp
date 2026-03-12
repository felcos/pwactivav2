<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE HTML>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>PW</title>
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
<%
yy = 2014

'****************

meses = month(date)
if yy < 2015 then 
	meses = meses + 12*(2015-yy)
end if

for ii=1 to meses
	if ticks<>"" then 
		ticks = ticks & ", "
	end if
	
	select case ((ii-1) mod 12)
	case 0
		tick = "Ene "
	case 1
		tick = "Feb "
	case 2
		tick = "Mar "
	case 3
		tick = "Abr "
	case 4
		tick = "May "
	case 5
		tick = "Jun "
	case 6
		tick = "Jul "
	case 7
		tick = "Ago "
	case 8
		tick = "Sept "
	case 9
		tick = "Oct "
	case 10
		tick = "Nov "
	case 11
		tick = "Dic "
	end select
	tick = tick & (yy+((ii-1)\12))
	
	ticks = ticks & "'" & tick & "'"
next

Set rs = Server.CreateObject("ADODB.Recordset")
session("connPWAcesos").CommandTimeout = 300

sql = "SELECT * FROM clientes_control WHERE (activo=1 AND id>2 and LICENCIAS_ENVIADAS>0) ORDER BY ultimo_acceso DESC"

rs.Open sql, session("connPWAcesos")
%>
<table id="table-sparkline">
<thead>
    <tr>
        <th>nn</th>
      	<th>Id</th>
        <th>Cliente</th>
        <th>Empresa</th>
        <th>Licencias</th>
        <th>&Uacute;lt.Acceso</th>
        <th> </th>
        <th width="250">data</th>
        <th>recibe</th>
	</tr>
</thead>
<tbody id="tbody-sparkline">
<% 
nn=1
do while not rs.eof
%>
<tr data-id="<%= rs("id") %>">
    <td><%= nn %></td>
    <th><%= rs("id") %></th>
    <th><%= rs("empresa") %></th>
    <td><%= rs("nombre_empresa") %></td>
    
    <td><%= rs("licencias_enviadas") %>/<%= rs("num_licencias") %></td>
    <td><%= rs("ultimo_acceso") %></td>
    
    <td data-sparkline="71, 78, 39, 66 "/>
    <td id="data<%= rs("id") %>"></td>
    <td id="recibe<%= rs("id") %>"/>
</tr>
	<% rs.movenext
	nn = nn+1
loop 

rs.close
set rs=nothing
%>
</tbody>
</table>

</body>
</html>
<script type="text/javascript">
var chart;


Highcharts.SparkLine = function (options, callback) {
	var defaultOptions = {
		chart: {
			renderTo: (options.chart && options.chart.renderTo) || this,
			backgroundColor: null,
			borderWidth: 0,
			type: 'area',
			margin: [2, 0, 2, 0],
			width: 180,
			height: 20,
			animation: true,
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
			categories: [<%= ticks %>],
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

$(document).ready(function(){
    var $trs = $("tr[data-id]")
	
	var i,
		len = $trs.length,
		$tr, clid,
		stringdata,
		arr,
		data, 
		datos, ticks ;

	for (i = 0; i < len; i += 1) {
		$tr = $($trs[i]);
		clid = $tr.data('id');
		
		$.ajax({
			url: '/lib/high/jp/data-ajax2.asp',
			data: 'id='+clid + '&yy='+<%= yy %>,
			//async: false,
			beforeSend: function() {},
			success: function(data, status, xhr){
				var rcb = data.split('; ');
				var id = rcb[0];
				var yy = rcb[1];
				
				var tdrecibe = "#recibe"+id;
				var tddata = "#data"+id;
				
				chart = {};
				
				//var tmp = rcb[2].split(', ');
				//datos = $.map(tmp, function (xx) {return (xx.split('#'));});
				//datos = $.map(tmp, function (xx) {return (xx.split('#'), parseFloat);});
				datos = $.map(rcb[2].split(', '), parseFloat);
				//datos = $.map(rcb[2], parseFloat);
				//console.log(datos);
				
				//$(tdrecibe).html(rcb[2]);
				
				$(tddata).highcharts('SparkLine', {
					//xAxis: {
					//	categories: [rcb[3]]
					//},
					series: [{
						data: datos
						/*,	pointStart: 100*/
					}],
					tooltip: {
						headerFormat: '<span style="font-size: 10px">{point.x}</span><br/>', // $td.parent().find('th').html()
						pointFormat: '<b>{point.y}</b> arts.'
					},
					chart: chart
				});

			},
			error: function(xhr, status, err) {}
		});
		
		//data = $.map(arr[0].split(', '), parseFloat);
		//
		//chart = {};
		
		/*
		if (arr[1]) {
			chart.type = arr[1];
		} else {
			
		}
		*/
	   
		
	}
	
    
});

</script>
