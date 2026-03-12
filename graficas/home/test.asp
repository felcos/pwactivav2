<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Documento sin título</title>
    
    <script class="include" type="text/javascript" src="/js/jquery.js"></script>
    
    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.cursor.min.js"></script>
    
    <link class="include" rel="stylesheet" type="text/css" href="/graficas/home/graf.css" />
    
</head>

<body>
<div id="graf_titulo">T&Iacute;TULO</div>
<div id="graf_subtitulo">Subt&iacute;tulo</div>
<div id="graf"></div>
</body>
</html>
<script>
$(document).ready(function(){
	$('#graf_titulo').html('Mercado de Vivienda Residencial');
	$('#graf_subtitulo').html('Espa&ntilde;a');
	$('#graf_fuente').html('Fuente: Sociedad de Tasaci&oacute;n / Instituto de Pr&aacute;ctica Empresarial');
	
	var proyectadas = [ 
		[2002, 6.50], [2003, 6.00], [2004, 6.00], [2005, 5.25],
		[2006, 4.50], [2007, 4.35], [2008, 6.00], [2009, 6.50], 
		[2010, 6.25], [2011, 6.00], [2012, 6.70], [2013, 6.50], [2014, 5.00]
	];
	
	
	//var ticks = [[1999, ' '], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	//var ticks = [[2005, ' '], [2006, '2006'], [2007, '2007'], [2008, '2008'], [2009, '2009'], [2010, '2010'], [2011, '2011'], [2012, '2012'], [2013, '2013'], [2014, '2014'], [2015, ' ']];
	
	//var ticks = [[1984, ' '], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	
	//var ticks=[1985, 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014];
	//var ticks = [
	//	[1984, ' '], [1985, ' '], [1986, '1986'], [1987, ' '], [1988, '1988'], [1989, ' '], [1990, '1990'],
	//	[1991, ' '], [1992, '1992'], [1993, ' '], [1994, '1994'], [1995, ' '], [1996, '1996'], [1997, ' '], [1998, '1998'], [1999, ' '], [2000, '2000'],
	//	[2001, ' '], [2002, '2002'], [2003, ' '], [2004, '2004'], [2005, ' '], [2006, '2006'], [2007, ' '], [2008, '2008'], [2009, ' '], [2010, '2010'],
	//	[2011, ' '], [2012, '2012'], [2013, ' '], [2014, '2014'], [2015, ' ']
	//];
	
	var yticks = [[4, '4,0'], [4.5, '4,5'], [5, '5,0'], [5.5, '5,5'], [6, '6,0'], [6.5, '6,5'], [7.0, '7,0'], [7.5, '7,5']];
	
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
			//	ticks: ticks,
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
</script>