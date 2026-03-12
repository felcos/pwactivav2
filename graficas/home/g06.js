$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Vivienda Residencial');
	$('#graf_subtitulo').html('Espa&ntilde;a');
	$('#graf_fuente').html('Fuente: Sociedad de Tasaci&oacute;n / Instituto de Pr&aacute;ctica Empresarial');
	
	var proyectadas = [ 
		[1985, 233.600], [1986, 233.000], [1987, 346.400], [1988, 383.800], [1989, 387.800], 
		[1990, 275.300], [1991, 248.400], [1992, 264.700], [1993, 234.100], [1994, 295.000], [1995, 352.600], [1996, 319.500], [1997, 346.000], [1998, 460.800], [1999, 561.300], 
		[2000, 578.400], [2001, 564.300], [2002, 560.100], [2003, 609.300], [2004, 647.600], [2005, 667.500],
		[2006, 820.100], [2007, 667.300], [2008, 232.000], [2009, 110.800], 
		[2010, 83.100], [2011, 109.800], [2012, 71.100], [2013, 57.800], [2014, 58.800]
	];
	
	var terminadas = [
		[1985, 191.400], [1986, 195.200], [1987, 202.600], [1988, 239.500], [1989, 236.600], 
		[1990, 281.100], [1991, 271.600], [1992, 219.600], [1993, 217.500], [1994, 223.500], [1995, 208.100], [1996, 248.600], [1997, 286.000], [1998, 297.900], [1999, 356.100], 
		[2000, 415.800], [2001, 498.700], [2002, 426.700], [2003, 448.000], [2004, 488.700], [2005, 522.600], 
		[2006, 584.500], [2007, 637.400], [2008, 631.400], [2009, 387.600], 
		[2010, 196.500], [2011, 233.100], [2012, 117.800], [2013, 73.700], [2014, 45.800]
	];
	
	var iniciadas = [
		[1985, 222.300], [1986, 214.600], [1987, 251.800], [1988, 269.100], [1989, 283.300], 
		[1990, 239.400], [1991, 201.400], [1992, 206.100], [1993, 189.100], [1994, 222.900], [1995, 284.100], [1996, 268.300], [1997, 287.400], [1998, 407.400], [1999, 510.600], 
		[2000, 535.700], [2001, 524.600], [2002, 524.200], [2003, 625.400], [2004, 636.300], [2005, 735.100],
		[2006, 798.700], [2007, 759.900], [2008, 285.100], [2009, 110.800], 
		[2010, 83.100], [2011, 91.400], [2012, 46.000], [2013, 35.200], [2014, 35.800]
	];
	
	var stock = [
		[2006, 73.555], [2007, 358.522], [2008, 691.637], [2009, 875.606], 
		[2010, 931.615], [2011, 924.266], [2012, 872.697], [2013, 778.152], [2014, 739.244]
	];
	
	//var ticks = [[1999, ' '], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	//var ticks = [[2005, ' '], [2006, '2006'], [2007, '2007'], [2008, '2008'], [2009, '2009'], [2010, '2010'], [2011, '2011'], [2012, '2012'], [2013, '2013'], [2014, '2014'], [2015, ' ']];
	
	var ticks = [[1984, ' '], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014];
	//var ticks = [
	//	[1984, ' '], [1985, ' '], [1986, '1986'], [1987, ' '], [1988, '1988'], [1989, ' '], [1990, '1990'],
	//	[1991, ' '], [1992, '1992'], [1993, ' '], [1994, '1994'], [1995, ' '], [1996, '1996'], [1997, ' '], [1998, '1998'], [1999, ' '], [2000, '2000'],
	//	[2001, ' '], [2002, '2002'], [2003, ' '], [2004, '2004'], [2005, ' '], [2006, '2006'], [2007, ' '], [2008, '2008'], [2009, ' '], [2010, '2010'],
	//	[2011, ' '], [2012, '2012'], [2013, ' '], [2014, '2014'], [2015, ' ']
	//];
	
	var yticks = [[0, '0'], [200, '200'], [400, '400'], [600, '600'], [800, '800'], [1000, '1000']];
	
	graf = $.jqplot('graf', [stock, proyectadas, terminadas, iniciadas], {
		//title:'Mercado de Vivienda Residencial',
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
				//min: 1984,
				//max: 2015,
				ticks: ticks,
				//labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				//tickRenderer: $.jqplot.CanvasAxisTickRenderer,
				//tickOptions:{ 
				//	angle: -45,
				//	fontSize: '9px'
			  	//}
				//renderer: $.jqplot.CategoryAxisRenderer
				//show: false
				
			},
			yaxis: {
				/*min: 0,
				max:800000,
				*/
				ticks: yticks,
				label:'miles de viviendas', 
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer
				//padMin: 0
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
			sizeAdjust: 7.5 ,
			tooltipLocation : 'ne',
			tooltipFormatString: '%.0f.000',
			useAxesFormatters: false
		},
		
		series:[ 
			{
				label:'Stock',
                renderer: $.jqplot.BarRenderer,
                //showHighlight: false,
                rendererOptions: {
                    // Speed up the animation a little bit.
                    // This is a number of milliseconds.  
                    // Default for bar series is 3000.  
                    animation: {
                        speed: 2500
                    },
                    barWidth: 15,
                    barPadding: -15,
                    barMargin: 0,
                    highlightMouseOver: false
                }
			},
			{label:'Proyectadas'},
			{label:'Terminadas'}, 
			{label:'Iniciadas'}
		]
		
	});
	
	//$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		//$('#info').html('series: '+seriesIndex+', point: '+pointIndex+', data: '+data);
	//});
	
});