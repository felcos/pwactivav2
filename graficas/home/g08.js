$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Centros Comerciales');
	$('#graf_subtitulo').html('Rentabilidad');	
	$('#graf_fuente').html('Fuente: Cinco D&iacute;as');
	
	var mad = [ 
		[2002, 6.50], [2003, 6.00], [2004, 6.00], [2005, 5.25], [2006, 4.50], [2007, 4.35], [2008, 6.00], [2009, 6.50], 
		[2010, 6.25], [2011, 6.00], [2012, 6.70], [2013, 6.50], [2014, 5.00]
	];
	
	
	//var ticks=[2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014];
	var ticks = [
		[2001, ''],[2002, '2002'], [2003, '2003'], [2004, '2004'], [2005, '2005'], [2006, '2006'], [2007, '2007'], [2008, '2008'], [2009, '2009'],
		[2010, '2010'], [2011, '2011'], [2012, '2012'], [2013, '2013'], [2014, '2014'], [2015, '']
		];
	
	graf = $.jqplot('graf', [mad], {
		//title:'Mercado de Oficinas<br>Take Up',
		stackSeries: false,
		captureRightClick: true,
		
		// animate: !$.jqplot.use_excanvas,
		animate: true,
		// Will animate plot on calls to plot1.replot({resetAxes:true})
		animateReplot: true,
			
		seriesDefaults:{
			pointLabels: {show: false},
			rendererOptions: { 
				animation: {speed: 2000}, 
				smooth: false
			}
		},
		axes: {
			xaxis: {
				//min: 1983,
				//max: 2015,
				ticks: ticks
				//renderer: $.jqplot.CategoryAxisRenderer
				//show: false
			},
			yaxis: {
				label:'%', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				//padMin: 0
				min: 4,
				max: 8,
			}
		},
		highlighter: {
            show: true, 
            showLabel: true, 
            tooltipAxes: 'y',
            sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.2f %',
	        useAxesFormatters: false
        },
		/*
		legend: {
			show: true,
			location: 'e',
			placement: 'outside'
		},
		
		series:[ 
			{label:'Espa&ntilde;a'}
		]
		*/
	});
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});