<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - Admin</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="/lib/easyResponsiveTabs/css.css" />
    
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
    
    
    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shCore.min.js"></script -->
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushJScript.min.js"></script -->
    <!--script type="text/javascript" src="/lib/jqplot/examples/syntaxhighlighter/scripts/shBrushXml.min.js"></script -->

    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.highlighter.min.js"></script>
    

<style>
#graf1, #graf2, #graf3 {
	min-height:500px;
}
/*
#tab .resp-tabs-container {
	min-height:100px;
}
#tabData .resp-tabs-list li {
    width:120px;
}

form .grid-1, form .grid-2, form .grid-3, form .grid-4, form .grid-5, form .grid-6, form .grid-full {
	margin-bottom:.25em;
}

.sd {
	background-color:#EEEEEE;
}
.jqplot-target {
	
	margin: 20px;
	height: 480px;
	width: 95%;
	
	color: #dddddd;
}
.ui-widget-content {
	background: rgb( rgb(0,0,0)57,57,57);
}
*/
table.jqplot-table-legend {
	border: 0px;
	background-color: rgba(100,100,100, 0.0);
}
.jqplot-highlighter-tooltip {
	background-color: rgba(57,57,57, 0.9);
	padding: 7px;
	color: #dddddd;
}
</style>
<%
'server.ScriptTimeout=300
f_hasta = date
f_desde = "01/01/2010"
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-2">
    	<h1 class="heading">gr&aacute;ficas</h1>
	</div>
    <div class="grid-2" style="padding-top:24px;">gr&aacute;fica: &nbsp;
    	<select id="grafica" name="grafica" onChange="$('#frmdata').submit();">
        	<option value="articulos">Art&iacute;culos Le&iacute;dos</option>
            <option value="compara">Comparativa</option>
        </select>
	</div>
    
    <div class="grid-2 grid-flow-opposite" style="margin-bottom:0;">
    	<!--#include virtual="/admin/inc_menu.asp" -->
    
    <form id="frmdata" name="frmdata" action="" method="post" autocomplete="off" target="_blank">
        <div class="grid-1">Per&iacute;odo:</div>
        <div class="grid-3">
        	<input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
            &nbsp;-&nbsp;
        	<input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
        </div>
        <div class="grid-1"><a href="">reset</a> &nbsp; </div>
        <div class="grid-1"><input type="submit" value="cargar"></div>
        
        <div class="grid-1">Art&iacute;culos:</div>
        <div class="grid-3">
<select name="articulotipo" onChange="$('#frmdata').submit();">
    <option value="">Todos</option>
    <option value="not">Noticias</option>
    <option value="rum">Rumores</option>
    <option value="ope">Operaciones</option>
    <option value="est">Estudios</option>
    <option value="dem">Demandas</option>
    <option value="sub">Subastas</option>
    <option value="ven">Vencimientos</option>              
</select>
        </div>
        <div class="grid-2">
<select id="intervalo" name="intervalo" onChange="$('#frmdata').submit();">
    <option value="mes">por Meses</option>
    <option value="sem">por Semanas</option>            
</select>
        </div>
    </form>
    
    </div>
    
    <div style="clear:both;"></div>
    
</section>

</div>

<div class="contenedor">

	<div class="grid-full">
<!--Horizontal Tab-->
<div id="tab">
    <ul class="resp-tabs-list">
        <li>graf 1 &nbsp;</li>
        <li>graf 2 &nbsp;</li>
        <li>graf 3 &nbsp;</li>
    </ul>
    <div class="resp-tabs-container">
<div>
	<div><div id="graf1"></div></div>
    <div id="informa_graf1"></div>
</div>
<div>
	<div id="graf2"></div>
    <div id="loading_graf2" style="display:Znone;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>
<div>
	<div id="graf3"></div>
    <div id="loading_graf3" style="display:Znone;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>
    </div>
</div>
<!--Horizontal Tab-->
	</div>

<div style="clear:both;"></div>
<div id="informa"></div>
<div id="detalle">
<form id="frm_res" name="frm_res" action="/admin/accesos/" method="get" autocomplete="off" target="_blank">
	<input type="hidden" name="f" id="fecha_resumen" value="" maxlength="10" class="fecha">
	<input id="submit_resumen" type="submit" style="display:none;">
</form>
</div>

</div>

</section>

</body>
</html>

<script type="text/javascript">
	var plot1;

$(document).ready(function(){
	$('#FechaI').DatePicker({
		format: 'd/m/Y',
		date: $('#FechaI').val(),
		current: $('#FechaI').val(),
		
		calendars: 1,
		starts: 1,
		//position: 'r',
		
		onBeforeShow: function(){
			$('#FechaI').DatePickerSetDate($('#FechaI').val(), true);
		},
		onChange: function(formated, dates){
			ant_date=$('#FechaI').val();
			$('#FechaI').val(formated);
			if (ant_date!=$('#FechaI').val()) {
				$('#FechaI').DatePickerHide();
				$('#frmdata').submit();
			}
		}
	});
	
	// tabs
	$('#tab').easyResponsiveTabs({
		type: 'default', //Types: default, vertical, accordion           
		width: 'auto', //auto or any width like 600px
		fit: true,   // 100% fit in a container
		closed: 'accordion', // Start closed if in accordion view
		activate: function(event) { // Callback function if tab is switched
			var $tab = $(this);
			//var $info = $('#tab');
			//var $name = $('span', $info);
			//$name.text($tab.text());
			//$info.show();
			//console.log($tab.text());
			/*
			if ($tab.text()=='Navegadores____Z') {
				if ($('#resumen_navegadores').html()=='') {
					$.ajax({
						url: '/admin/accesos/ip/resumen_navegadores.asp',
						data: $('#frm_resumen').serialize(),
						beforeSend: function() {
							$('#resumen_navegadores').html('');
						},
						success: function(data, status, xhr){
							$('#resumen_navegadores').html(data);
							$('#loading_resumen_navegadores').hide();
						},
						error: function(xhr, status, err) {}
					});
				}
			}
			*/
		}
	});
	
	// form resumen	
	$('#frmdata').submit(function(){
		$.ajax({
		  //async: true,
		  url: furl(),
		  data: $(this).serialize(),
		  beforeSend: function() {
			  //$('#loading_graf1').show();
		  },
		  success: function(data, status, xhr){
			  $('#graf1').html(data);
			  //$('#loading_graf1').hide();
		  },
		  error: function(xhr, status, err) {
			  $('#graf1').html("ERROR<br>" + status + ": " + err);
			  //$('#loading_graf1').hide();
		  }
    	});
		return false;
	});
	
	// ini	
	//$('#frm_resumen').submit();
});

function furl() {
	if ($("#grafica").val()=="articulos") {return "/admin/graf/data/articulos.asp"}
	else if ($("#grafica").val()=="compara") {return "/admin/graf/data/compara.asp"}
	};

function limpia() {
	$('#graf1').html('');
	$('#informa_graf1').html('');
	//$('#graf2').html('');
	//$('#informa_graf2').html('');
	//$('#graf3').html('');
	//$('#informa_graf3').html('');
};
</script>