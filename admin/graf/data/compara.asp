<% 
ver_grafica = true
ver_tabla = true
ver_data = false
%>
<script type="text/javascript">
$(document).ready(function(){
	var datos = [ [<% call Articulos(2015) %>], [<% call Articulos(2014) %>], [<% call Articulos(2013) %>] ]
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013];
	//var ticks = [[1984, ''], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	
	var ticks = [<%
	primero=true
	for ii=1 to 42
		if primero then 
			primero=false
		else
			response.Write(", ")
		end if 
		response.Write(ii)
	next
	%>];
	
	graf = $.jqplot('graf1', datos, {	//[mad, bcn]
		//title:'Mercado de Oficinas<br>Rentabilidad',
		stackSeries: false,
		captureRightClick: true,
		
		// animate: !$.jqplot.use_excanvas,
		animate: true,
		// Will animate plot on calls to plot1.replot({resetAxes:true})
		animateReplot: true,
		
		highlighter: {
            show: true, 
            showLabel: true, 
            tooltipAxes: 'y',
            sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.0f artics.',
	        useAxesFormatters: false
        },
		
		seriesDefaults:{
			pointLabels: {show: false},
			rendererOptions: { 
				animation: {speed: 2000}, 
				smooth: true
			}
		},
		axes: {
			xaxis: {
				min: 0,
				max: 54,
				//ticks: ticks,
				renderer: $.jqplot.CategoryAxisRenderer
				//show: false
			},
			yaxis: {
				min: 0,
				max: 2200,
				label:'articulos',
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer
				//padMin: 0
			}
		},
		legend: {
			show: true,
			location: 'n',
			placement: 'inside'
		}, 
		series:[ 
			{label:'A&ntilde;o 2015'},
			{label:'A&ntilde;o 2014'},
			{label:'A&ntilde;o 2013'} 
		]
		
	});
	
	//$('#informa_graf1').html(datos);
	
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});	
});
</script>
<% sub Articulos(pYY)	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT DATEPART(yy, fecha) AS yy, DATEPART(ww, fecha) AS ww, COUNT(id) AS articulos FROM reg_articulos "
	sql = sql & "WHERE ("
	sql = sql & "fecha>=CONVERT(DATETIME, '" & pYY & "-01-01 00:00:00', 102) AND fecha<CONVERT(DATETIME, '" & pYY & "-12-31 00:00:00', 102)"
	sql = sql & ") "
	sql = sql & "GROUP BY DATEPART(yy, fecha), DATEPART(ww, fecha) "
	sql = sql & "ORDER BY  DATEPART(yy, fecha), DATEPART(ww, fecha)"
	
	rs.Open sql, session("connPWAcesos")
	
	primero = true
	
	do while not rs.eof
		if primero then 
			primero=false
		else
			%>, <%
		end if
		%>[<%= rs("ww") %>, <%= rs("articulos") %>]<%
		rs.movenext
	loop
	
	rs.close
	set rs=nothing
end sub %>