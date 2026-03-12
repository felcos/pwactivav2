<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es"><head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - Admin</title>
    <link href="/_inc/foldy/base.css" rel="stylesheet" type="text/css">
    <link href="/_inc/foldy/grid.css" rel="stylesheet" type="text/css">
    <link href="/_inc/foldy/estilos.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->

    
	
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
#graf1 {
	min-height: 320px;
}

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
yy_res = 2014
'ff_res = left(cstr(date), 5)
ff_res = date
sem_res = datepart("ww", date, 2)
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">
    <section id="introp" class="cf">
    
        <div class="grid-4">
            <h1 class="heading">Accesos</h1>
        </div>
        <div class="grid-2 grid-flow-opposite">
            <!--#include virtual="/admin/inc_menu.asp" -->
        </div>
        
        <hr style="clear:both;">
	</section>
    
    <section class="cf">
        <div class="grid-3">
<div id="graf1"></div>
<div id="informa_graf1"></div>
            
        </div>
        <div class="grid-3 grid-flow-opposite">
            <div class="med" style="margin-top:27px; padding-left:80px;">
<form action="/admin/graf/data/comparativa.asp" method="post" name="frm1" id="frm1" target="_blank">
	<select name="yy" size="5" onChange="$('#frm1').submit();" style="vertical-align:top; overflow:hidden; border:0;" id="yy">
		<% for yy=2014 to 2010 step -1 %>
	        <option value="<%= yy %>" <% if yy=yy_res then %>selected<% end if %>><%= yy %></option>
        <% next %>
    </select>
    &nbsp;
    <input name="anno_completo" type="checkbox" value="y" checked onChange="$('#frm1').submit();">&nbsp;completo
     &nbsp; &nbsp; &nbsp; 
     <select name="tipo" size="3" onChange="$('#frm1').submit();" style="vertical-align:top; overflow:hidden; border:0;">
	    <option value="d" <% if rTipo="d" then %>selected<% end if %>>por d&iacute;as</option>
        <option value="w" <% if rTipo="w" or rTipo="" then %>selected<% end if %>>por semanas</option>
        <option value="m" <% if rTipo="m" then %>selected<% end if %>>por meses</option>
    </select>
    &nbsp; &nbsp; &nbsp; &nbsp; 
    <a href="">reset</a>
    &nbsp; &nbsp; 
    <input type="submit" value="cargar">
</form>
            </div>
        </div>
        <div class="grid-3 grid-flow-opposite">
        	<hr>
        	<div style="margin-left:80px;">
<form id="frm2" name="frm2" action="/admin/accesos/datos/resumen.asp" method="post" autocomplete="off" target="_blank" class="med">
    <div class="grid-4">
        <input type="text" name="FechaI" id="FechaI" value="<%= ff_res %>" maxlength="10" class="fecha">
        &nbsp;-&nbsp;
        <input type="hidden" name="FechaF" id="FechaF" value="<%= ff_res %>" maxlength="10" class="fecha"> 
        sem: <input type="text" name="sem" id="sem_res" value="<%= sem_res %>" style="width:25px;">
    </div>
    <div class="grid-1"><a href="">reset</a> &nbsp; </div>
    <div class="grid-1"><input type="submit" value="cargar"></div>
</form>
<div id="resumen"></div>
<div id="informa_resumen"></div>
			</div>
        </div>
    </section>
    
    <hr style="clear:both;">
    
    <section class="cf">
        <div class="grid-4"></div>
        <div class="grid-2 grid-flow-opposite">
xxx
        </div>
    </section>
    
</div>

<div class="contenedor">

<div class="grid-full">
    <div id="graf2"></div>
    <div id="informa_graf2"></div>
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
	// form resumen	
	$("#frmdata").submit(function(){
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
	
	// form resumen	
	$('#frm1').submit(function(){
		$.ajax({
		  //async: true,
		  type: "POST",
		  //url: "/admin/graf/data/comparativa.asp",
		  url: $(this).attr("action"),
		  data: $(this).serialize(),
		  beforeSend: function() {
			  //$('#loading_graf1').show();
		  },
		  success: function(data, status, xhr){
			  console.log(data)
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
	
	// form resumen	
	$('#frm2').submit(function(){ 
		$.ajax({
			url: $(this).attr("action"),
			data: $(this).serialize(),
			beforeSend: function() {
				//$('#loading_resumen').show();
				$('#resumen').html('');
			},
			success: function(data, status, xhr){
				
				$('#resumen').html(data);
				//$('#loading_resumen').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		return false;
	});
	
	// ini	
	$('#frm1').submit();
	$('#frm2').submit();
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