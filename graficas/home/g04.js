$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Oficinas por &Aacute;reas');
	$('#graf_subtitulo').html('Madrid');
	$('#graf_fuente').html('Fuente: Property Web');
	
	var m0 = [87.1, 2.9, 8.4, 14.7, 6.2, 17.0, 13.0, 11.6, 496.7, 92.0, 17.9, 12.5, 7.5, 1.3, 17.5, 2.3];
	var m1 = [285.0, 109.0, 69.9, 117.2, 77.4, 114.2, 140.0, 102.0, 58.5, 76.9, 84.1, 82.1, 42.5, 54.2, 34.5, 32.1];
	var m2 = [101.6, 62.7, 80.1, 80.3, 62.4, 88.9, 68.1, 82.4, 84.6, 46.3, 52.5, 61.4, 63.5, 57.7, 112.9, 43.4];
	var m3 = [105.9, 79.7, 82.2, 43.0, 127.8, 51.1, 57.2, 91.1, 13.7, 43.3, 21.1, 38.0, 21.0, 13.5, 32.0, 46.3]; 
	var m4 = [91.5, 22.2, 24.6, 19.8, 22.5, 24.8, 34.4, 52.1, 18.8, 11.6, 20.6, 20.0, 7.4, 25.5, 17.3, 31.3];
	var m5 = [68.0, 24.8, 13.3, 47.8, 40.7, 30.4, 15.6, 26.4, 25.2, 21.2, 48.1, 31.4, 16.1, 83.0, 25.7, 17.9];
	var m6 = [443.2, 97.7, 117.6,303.8,128.4, 60.3, 166.4, 154.7, 152.1, 81.3, 121.6, 105.7, 104.3, 146.3, 105.4, 36.1];
	
	var ticks = [2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015];
	var etiquetas = [ {label:'N/D'}, {label:'OUT'}, {label:'A1'}, {label:'A2'}, {label:'A3'}, {label:'PRIME'}, {label:'DEC'} ]
	
	graf = $.jqplot('graf', [m0, m1, m2, m3, m4, m5, m6], {
		//title:'Mercado de Oficinas por &Aacute;reas<br>Madrid',
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
				//highlightMouseDown: true
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