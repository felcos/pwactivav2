$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Oficinas por &Aacute;reas');
	$('#graf_subtitulo').html('Barcelona');
	$('#graf_fuente').html('Fuente: Property Web');
	
	var b0 = [13.7, 9.9, 0.9, 0.8, 2.9, 5.2, 7.9, 12.0, 1.7, 2.9, 3.7, 3.1, 3.1, 1.5, 21.6, 1.6];
	var b1 = [24.8, 24.8, 50.7, 28.2, 27.5, 55.6, 78.7, 38.3, 54.0, 50.0, 59.9, 64.0, 27.1, 50.2, 51.9, 36.9];
	var b2 = [11.2, 14.7, 47.7, 33.6, 32.6, 22.2, 21.1, 18.4, 39.7, 24.1, 26.5, 23.6, 54.9, 40.3, 43.7, 22.0];
	var b3 = [14.1, 17.7, 25.0, 9.7, 30.1, 27.9, 10.1, 13.1, 29.0, 24.7, 24.4, 29.7, 28.0, 26.6, 28.4, 35.5];
	var b4 = [9.8, 1.9, 0.7, 2.0, 3.1, 0.9, 1.3, 1.8, 2.7, 3.8, 14.7, 4.0, 3.1, 1.6, 3.3, 2.7];
	var b5 = [3.4, 12.2, 13.7, 16.3, 14.7, 10.0, 6.5, 2.9, 3.8, 21.9, 5.9, 4.4, 5.9, 12.1, 9.6, 3.4];
	var b6 = [11.0, 14.2, 75.0, 19.6, 65.9, 42.9, 41.6, 30.0, 68.9, 54.6, 39.5, 43.6, 40.3, 38.2, 80.7, 28.3];
	
	var ticks = [2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015];
	var etiquetas = [ {label:'N/D'}, {label:'OUT'}, {label:'A1'}, {label:'A2'}, {label:'A3'}, {label:'PRIME'}, {label:'DEC'} ]
	
	graf = $.jqplot('graf', [b0, b1, b2, b3, b4, b5, b6], {
		//title:'Mercado de Oficinas por &Aacute;reas<br>Barcelona',
		stackSeries: true,
		captureRightClick: true,
		
		// animate: !$.jqplot.use_excanvas,
		animate: true,
		
		seriesDefaults:{
			renderer:$.jqplot.BarRenderer,
			rendererOptions: {
				// Put a 30 pixel margin between bars.
				barMargin: 10,
				// Highlight bars when mouse button pressed.
				// Disables default highlighting on mouse over.
				highlightMouseDown: true
			},
			pointLabels: {show: false}
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				ticks: ticks
			},
			yaxis: {
				label:'Miles de Metros Cuadrados', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				// Don't pad out the bottom of the data range.  By default,
				// axes scaled as if data extended 10% above and below the
				// actual range to prevent data points right on grid boundaries.
				// Don't want to do that here.
				padMin: 0
			}
		},
		legend: {
			show: true,
			location: 'e',
			placement: 'outside'
		}, 
		
		highlighter: {
			show: true, 
			showLabel: true, 
			tooltipAxes: 'y',
			showMarker: false,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.0f.000',
			useAxesFormatters: false
		},
		
		series: etiquetas
	});
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});