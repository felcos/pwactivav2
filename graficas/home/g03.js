$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Oficinas');
	$('#graf_subtitulo').html('Renta Prime');
	$('#graf_fuente').html('Fuente: Property Web');	
	
	var mad = [ 
		[1985, 9.6], [1986, 13.25], [1987, 15.00], [1988, 20.00], [1989, 25.50], 
		[1990, 31.55], [1991, 33.00], [1992, 20.24], [1993, 16.25], [1994, 15.00], [1995, 15.00], [1996, 16.25], [1997, 17.45], [1998, 19.85], [1999, 27.00], 
		[2000, 36.00], [2001, 34.50], [2002, 30.85], [2003, 26.70], [2004, 25.50], [2005, 27.25], [2006, 38.00], [2007, 40.00], [2008, 32.00], [2009, 28.50], 
		[2010, 26.75], [2011, 25.75], [2012, 25.00], [2013, 24.25], [2014, 28.00], [2015, 25.50], [2015.33, 25.50]
	];
	
	var bcn = [
		[1985, 7.80], [1986, 9.00], [1987, 10.80], [1988, 15.00], [1989, 19.25], 
		[1990, 22.50], [1991, 25.85], [1992, 29.45], [1993, 21.35], [1994, 15.75], [1995, 13.25], [1996, 11.50], [1997, 13.85], [1998, 14.50], [1999, 20.25], 
		[2000, 24.00], [2001, 27.00], [2002, 25.00], [2003, 22.85], [2004, 24.00], [2005, 24.00], [2006, 25.00], [2007, 27.50], [2008, 25.00], [2009, 22.00], 
		[2010, 20.00], [2011, 19.00], [2012, 18.00], [2013, 17.75], [2014, 17.75], [2015, 19.50], [2015.33, 19.00]
	];
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013];
	var ticks = [[1984, ''], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015'], [2016, '']];
	
	graf = $.jqplot('graf', [mad, bcn], {
		//title:'Mercado de Oficinas<br>Renta Prime',
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
				smooth: true
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
				label:'€ / m2 / mes', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				//padMin: 0,
				min: 0
				//max: 50
			}
		},
		
		highlighter: {
            show: true, 
            showLabel: true, 
            tooltipAxes: 'y',
            sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.2f €/m2/mes',
	        useAxesFormatters: false
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
	//	$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});