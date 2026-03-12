$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Vivienda Residencial');
	$('#graf_subtitulo').html('Compraventa - <small>operaciones a julio de cada a&ntilde;o</small>');
	$('#graf_fuente').html('Fuente: INE');
	
	var mad = [ 
		[2007, 63731], [2008, 45500], [2009, 37669], 
		[2010, 43561], [2011, 28097], [2012, 27072], [2013, 25819], [2014, 28731], [2015, 32714]
	];
	
	
	//var ticks=[2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014];
	//var ticks = [
	//	[2007, '2007'], [2008, '2008'], [2009, '2009'], [2010, '2010'], [2011, '2011'], [2012, '2012'], [2013, '2013'], [2014, '2014'], [2015, '2015']
	//	];
	
	graf = $.jqplot('graf', [mad], {
		stackSeries: false,
		captureRightClick: true,
		
		//animate: !$.jqplot.use_excanvas,
		animate: true,
		animateReplot: true,
			
		seriesDefaults:{
			pointLabels: {show: true},
			rendererOptions: { 
				animation: {speed: 2000}, 
				smooth: false
			}
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer
			},
			yaxis: {
				label:'miles de operaciones (en julio)', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				
				min: 20000,
				max: 80000,
			}
		},
		highlighter: {
            show: true, 
            showLabel: true, 
            tooltipAxes: 'y',
            sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
	        useAxesFormatters: false,
			//tooltipFormatString: '%.0f',
			formatString: '%.0d, %.0f'
        },
		
	});
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});