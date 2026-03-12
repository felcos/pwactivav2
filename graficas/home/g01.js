$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Oficinas');
	$('#graf_subtitulo').html('Rentabilidad');	
	$('#graf_fuente').html('Fuente: Property Web');
	
	var mad = [ 
		[1985, 8.50], [1986, 7.50], [1987, 6.75], [1988, 5.75], [1989, 5.25], 
		[1990, 5.25], [1991, 5.75], [1992, 6.75], [1993, 7.00], [1994, 7.00], [1995, 6.50], [1996, 5.75], [1997, 5.50], [1998, 5.25], [1999, 5.00], 
		[2000, 5.25], [2001, 6.50], [2002, 6.00], [2003, 5.75], [2004, 5.00], [2005, 4.50], [2006, 4.25], [2007, 4.00], [2008, 5.90], [2009, 5.80], 
		[2010, 5.75], [2011, 6.00], [2012, 6.25], [2013, 6.25], [2014, 4.50], [2015, 3.90], [2015.33, 3.90]
	];
	
	var bcn = [
		[1985, 9.00], [1986, 8.00], [1987, 7.75], [1988, 7.25], [1989, 6.75], 
		[1990, 6.25], [1991, 6.75], [1992, 7.25], [1993, 8.50], [1994, 7.50], [1995, 7.50], [1996, 7.25], [1997, 7.00], [1998, 6.00], [1999, 5.50], 
		[2000, 5.50], [2001, 5.75], [2002, 5.75], [2003, 5.75], [2004, 5.50], [2005, 4.75], [2006, 4.50], [2007, 4.75], [2008, 6.25], [2009, 6.25], 
		[2010, 6.50], [2011, 6.50], [2012, 6.75], [2013, 6.00], [2014, 5.25], [2015, 4.75], [2015.33, 4.75]
	];
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013];
	var ticks = [[1984, ''], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015'], [2016, '']];
	
	graf = $.jqplot('graf', [mad, bcn], {
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
			tooltipFormatString: '%.2f %',
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
				//min: 1984,
				//max: 2015,
				ticks: ticks
				//renderer: $.jqplot.CategoryAxisRenderer
				//show: false
			},
			yaxis: {
				min: 3,
				max: 10,
				label:'%',
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer
				//padMin: 0
			}
		},
		legend: {
			show: true,
			location: 'e',
			placement: 'outside'
		}, 
		series:[ 
			{label:'Madrid'},
			{label:'Barcelona'} 
		]
		
	});
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});