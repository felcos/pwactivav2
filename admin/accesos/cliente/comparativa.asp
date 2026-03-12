<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% if 1=2 then
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
end if 

uid = request.Form("uid")

yy_act = year(date)
yy = request.Form("yy")


if uid="" then response.End()
if yy="" then yy=yy_act-1

fi = cdate("01/01/" & yy)
ff = cdate("31/12/" & yy)

fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)


Set rs = Server.CreateObject("ADODB.Recordset")

dim currYear
dim prevYear

dim valores_act(55)
dim valores_ant(55)

ww_max = 0
ww_min = 55

'act_y
fi = cdate("01/01/" & yy_act)
ff = cdate("31/12/" & yy_act)
fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)

sql = "SELECT DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "WHERE (fecha>='" & fi & "' AND fecha<='" & ff & "' AND id_cliente=" & uid & ") " 
sql = sql & "GROUP BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
sql = sql & "ORDER BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"
if 1=2 then %><hr /><%= sql %><% end if
rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	
	valores_act(datepart("ww", rs("wd"))) = rs("articulos")
	if datepart("ww", rs("wd"))>ww_max then ww_max=datepart("ww", rs("wd"))
	'if rs("ww")<ww_min then ww_min=rs("ww")
	
	if currYear<>"" then
		currYear = currYear & ", "
	end if
	
	currYear = currYear & "['" & diasemana(datepart("ww", rs("wd")), yy_act) & "', " & rs("articulos") & "]"
	
	rs.movenext
loop

rs.close 

%>
<%
fi = cdate("01/01/" & yy)
ff = cdate("31/12/" & yy)
fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
ff = dateadd("d", 7-datepart("w", ff, 2), ff)

'ant_y
sql = "SELECT DATEADD(d, 1 - DATEPART(dw, fecha), fecha) AS wd, COUNT(id) AS articulos "
sql = sql & "FROM reg_articulos "
sql = sql & "WHERE (fecha>='" & fi & "' AND fecha<='" & ff & "' AND id_cliente=" & uid & ") " 
sql = sql & "GROUP BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha) "
sql = sql & "ORDER BY DATEADD(d, 1 - DATEPART(dw, fecha), fecha)"
if 1=2 then %><hr /><%= sql %><% end if
rs.Open sql, session("connPWAcesos")

do while not rs.eof 
	valores_ant(datepart("ww", rs("wd"))) = rs("articulos")
	if datepart("ww", rs("wd"))>ww_max then ww_max=datepart("ww", rs("wd"))
	'if rs("ww")<ww_min then ww_min=rs("ww")
	if prevYear<>"" then
		prevYear = prevYear & ", "
	end if
	
	prevYear = prevYear & "['" & diasemana(datepart("ww", rs("wd")), yy) & "', " & rs("articulos") & "]"
	
	rs.movenext
loop

rs.close 
%>
<%
set rs=nothing

datos = "[ " & currYear & " ]"
if prevYear<>"" then
	datos = "[ " & prevYear & " ], " & datos
end if

%>
<% function diasemana(ww, yy) 
	dim fi
	fi = cdate("01/01/" & yy)
	fi = dateadd("d", 7+1-datepart("w", fi, 2), fi)
	
	f_tmp = dateadd("d", 7*(ww-2), fi)
	
	'yyyy-mm-dd
	if day(f_tmp)<10 then
		d_tmp = "0" & cstr(day(f_tmp))
	else
		d_tmp = cstr(day(f_tmp))
	end if
	
	if month(f_tmp)<10 then
		m_tmp = "0" & cstr(month(f_tmp))
	else
		m_tmp = cstr(month(f_tmp))
	end if
	
	diasemana = yy_act & "-" & m_tmp & "-" & d_tmp
end function %>
<% if 1=2 then %>
<hr /><%= prevYear %>
<hr /><%= currYear %>
<hr />
<%= datos %>
<% end if %>
<script class="code" type="text/javascript">
$(document).ready(function () {
	if (plot1) {
		plot1.destroy();
		$('#graf1').unbind('jqplotDataClick');
		$("#informa").html("");
	};
	
	$.jqplot._noToImageButton = true;
	
	var ticks = [
		['2015-01-01', ' '], 
		['2015-02-01', 'Enero'], 
		['2015-03-01', 'Febrero'], 
		['2015-04-01', 'Marzo'],   
		['2015-05-01', 'Abril'],   
		['2015-06-01', 'Mayo'],  
		['2015-07-01', 'Junio'],  
		['2015-08-01', 'Julio'],  
		['2015-09-01', 'Agosto'],   
		['2015-10-01', 'Septiembre'], 
		['2015-11-01', 'Octubre'], 
		['2015-12-01', 'Noviembre'], 
		['2015-12-31', 'Diciembre']
		];
	//var prevYear = [ < %= prevYear %> ];
	//var currYear = [ < %= currYear %> ];
	var datos = [ <%= datos %> ];
	
	plot1 = $.jqplot("graf1", datos, {
		seriesColors: ["rgba(78, 135, 194, 0.8)", "rgb(211, 235, 59)"],
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
				//tickInterval: "1 month",
				ticks: ticks,
				min: '2015-01-01',
				max: '2016-02-01',
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