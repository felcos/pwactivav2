$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Oficinas');
	$('#graf_subtitulo').html('Take Up');	
	$('#graf_fuente').html('Fuente: Property Web');
	
	var mad = [ 
		[1985, 220], [1986, 170], [1987, 150], [1988, 200], [1989, 175], 
		[1990, 160], [1991, 147.8], [1992, 180], [1993, 240], [1994, 290], [1995, 317], [1996, 347], [1997, 410], [1998, 677], [1999, 595.4], 
		[2000, 795], [2001, 460], [2002, 509], [2003, 610], [2004, 625], [2005, 695], [2006, 800], [2007, 860], [2008, 490], [2009, 388.2], 
		[2010, 365.8], [2011, 353.1], [2012, 258.7], [2013, 390.9], [2014, 336.8], [2015, 98.3], [2015.33, 96.7]
	];
	
	var bcn = [
		[1985, 50], [1986, 60], [1987, 70], [1988, 70], [1989, 95], 
		[1990, 260], [1991, 325], [1992, 550], [1993, 140], [1994, 225], [1995, 170], [1996, 180], [1997, 175], [1998, 251.8], [1999, 345.3], 
		[2000, 310], [2001, 300.1], [2002, 281], [2003, 239], [2004, 320], [2005, 407], [2006, 386], [2007, 370], [2008, 314], [2009, 181.7], 
		[2010, 174.5], [2011, 172.5], [2012, 162.4], [2013, 170.5], [2014, 237.3], [2015, 73.5], [2015.33, 59.5]
	];
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013];
	var ticks = [[1984, ''], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015'], [2016, '']];
	
	graf = $.jqplot('graf', [mad, bcn], {
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
				label:'Miles de Metros Cuadrados', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				//padMin: 0
				min: 0
				//max: 2015,
			}
		},
		highlighter: {
            show: true, 
            showLabel: true, 
            tooltipAxes: 'y',
            sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.0f.000 m2',
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
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});