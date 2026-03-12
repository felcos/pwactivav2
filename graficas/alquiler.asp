<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <link href="/lib/jqplot/jquery.jqplot.min.css" class="include" rel="stylesheet" type="text/css" />
    <!--[if lt IE 9]><script src="/lib/jqplot/excanvas.min.js" language="javascript" type="text/javascript"></script><![endif]-->
    <script src="/lib/jqplot/jquery.jqplot.min.js" class="include" type="text/javascript"></script>
    
    <script src="/lib/jqplot/plugins/jqplot.barRenderer.min.js" class="include" language="javascript" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js" class="include" language="javascript" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.pointLabels.min.js" class="include" language="javascript" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js" type="text/javascript"></script>
    <script src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js" type="text/javascript"></script>
    
    <script src="/lib/jqplot/plugins/jqplot.highlighter.min.js" type="text/javascript"></script>
	<script src="/lib/jqplot/plugins/jqplot.cursor.min.js" type="text/javascript"></script>
	
    <link href="/lib/jslider/jquery.slider.min.css" rel="stylesheet" type="text/css"/>
	<script src="/lib/jslider/jquery.slider.min.js" type="text/javascript"></script>
    <style>
		.jslider .jslider-value {
			top: -16px !important;
		}
		.jslider .jslider-scale {
			top: 6px !important;
		}
		.jslider .jslider-scale span {
			height: 3px;
		}
	</style>
	<%
    sec_actual = "/graficas/"
    
    r_var = request.Form("var")
    'if r_var = "" then r_var = "ops"
    
    r_yy = request.Form("yy")
    if r_yy = "" then r_yy = "1996"
	FechaI = "2006"
	FechaF = "2014"
	
    r_zona = request.Form("zona")
    if r_zona = "" then r_zona = "es"
	
    r_op = request.Form("op")
    if r_op = "" then r_op = "venta"	'inversion
    %>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_titulo" class="cf">
	<div class="grid-full titulo">
    	<a href="/graficas/" class="volver"><h1 class="heading">gr&aacute;ficas</h1></a>
        <h2>Alquiler/Traspaso</h2>
	</div>
</section>

<section id="introp" class="cf">
<form id="frm_graf" name="frm_graf" action="/graficas/g_stack_secciones.asp" method="get" autocomplete="off" target="_blank">
	<div class="grid-2 grid-flow-opposite" style="margin-top:.4em;">
		<div class="caja med" style="margin-top:6px; padding-bottom:0;">
        
	        <div class="row">
<div class="grid-3">
    <label for="ver">Per&iacute;odo:
        <input name="ver" type="text" id="ver" value="" style="border: 0; font-weight: bold; width:80px;">
    </label>
</div>

<div class="grid-3">
    <div class="layout-slider">
    	<input id="Slider" type="slider" name="intervalo" value="<%= FechaI %>;<%= FechaF %>"/>
    </div>
    <input name="FechaI" type="hidden" id="FechaI" value="<%= FechaI %>">
    <input name="FechaF" type="hidden" id="FechaF" value="<%= FechaF %>">
</div>
<div style="clear:both;"></div>

            </div>
            
        </div>
        <div class="caja med" style="margin-top:6px;">
<strong><a href="javascript:$('#frm_secciones').slideToggle();">Secciones</a></strong>
<div id="frm_secciones" style="border-top: 1px solid grey;">
<table border="0" cellspacing="0" cellpadding="0">
	<% 
set rsSecc=Server.CreateObject("ADODB.recordset")
sql = "SELECT * FROM secciones_operaciones WHERE simple=1 AND activo=1 ORDER BY orden"
rsSecc.Open sql, session("connPW")
do while not rsSecc.eof
	marcado = true
	if rsSecc("orden")>7 then marcado=false
%>
	<tr>
		<td><input name="secc" value="<%= rsSecc("id") %>" <% if marcado then %>checked<% end if %> type="checkbox"></td>
		<td>
<div class="jqplot-table-legend-swatch-outline"><div class="jqplot-table-legend-swatch" style="border-color: <%= colorea(rsSecc("id")) %>; background-color: <%= colorea(rsSecc("id")) %>;"></div></div>
        </td>
		<td> &nbsp;<%= lcase(rsSecc("nombre")) %></td>
	</tr>
	<% rsSecc.movenext
	loop %>
</table>
</div>
        </div>
        <div class="caja med" style="margin-top:6px;">
<label style="margin-right:30px;">graf<input type="checkbox" name="graf" value="ver" checked/></label>
<label style="margin-right:30px;">tabla<input type="checkbox" name="tabla" value="ver"/></label>
<label style="margin-right:30px;">data<input type="checkbox" name="data" value="ver"/></label>
        </div>
        <div id="informa" class="caja med" style="margin-top:6px;"></div>
    </div>
    
	<div class="grid-4">
<div class="caja">
<div style="float:right;">
<p>
	<a href="/graficas/inversion.asp">reset</a> &nbsp; 
	<a href="javascript:$('#frm_graf').submit();">bank</a> &nbsp; 
	<input id="btn_grf" class="enviar" type="button" value="cargar" />
</p>
</div>
<p>
<input type="hidden" name="op" id="op" value="alquiler">
<select name="zona" id="zona" onchange="$('#frm_graf').submit();">
    <option value="es" <% if r_zona="es" then %>selected<% end if %>>Espa&ntilde;a</option>	
    <option value="mad" <% if r_zona="mad" then %>selected<% end if %>>Madrid</option>	
    <option value="bcn" <% if r_zona="bcn" then %>selected<% end if %>>Barcelona</option>
</select>
&nbsp;
<label style="margin-right:30px;">N&uacute;m. Ops.&nbsp;<input type="radio" name="var" value="ops" <% if r_var="ops" then %>checked<% end if %> onClick="$('#frm_graf').submit();"/></label>
<label style="margin-right:30px;">Superficie<input type="radio" name="var" value="m2" <% if r_var="m2" then %>checked<% end if %> onClick="$('#frm_graf').submit();"/></label>
</p>

<div style="clear:both;"></div>

</div>
	</div>
    
</form>

<!-- 
</section>

<section id="introp" class="cf">
	<div style="clear:both;"></div>
-->
    <div class="grid-4" id="grafico"></div>
</section>

<section id="introp" class="cf">
	<div class="grid-full" id="result">[result]</div>
</section>

</div>
</div>

</body>
</html>

<% function colorea(id_secc) 
	select case id_secc
	case 1
		colorea = "rgb(251, 209, 120)"
	case 2
		colorea = "rgb(0, 133, 204)"
	case 4
		colorea = "rgb(216, 184, 63)"
	case 8
		colorea = "rgb(255, 88, 0)"
	case 16
		colorea = "rgb(38, 180, 227)"
	case 32
		colorea = "rgb(197, 180, 127)"
	case 64
		colorea = "rgb(149, 140, 18)"
	case 128
		colorea = "rgb(75, 93, 228)"
	case 256
		colorea = "rgb(199, 71, 163)"
	case 1024
		colorea = "rgb(149, 53, 121)"
	case 4096
		colorea = "rgb(131, 149, 87)"
	case 8192
		colorea = "rgb(234, 162, 40)"
	case 16384
		colorea = "rgb(87, 149, 117)"
	case 32768
		colorea = "rgb(75, 178, 197)"
	case 65536
		colorea = "rgb(205, 223, 84)"
	end select
end function %>

<script type="text/javascript">
$(document).ready( function() {
	var frm_url = "/graficas/g_stack_secciones.asp";
	var destino = $('#grafico');
	
	$(".enviar").click( function() {
		//destino.html("");
		$('#frm_graf').submit();
	});
	
	$('#frm_graf').submit(function(){
		//console.log('frm_resumen ajax form...');
		destino.html("");
		$.ajax({
		  //type: 'get',
		  async: false,
		  url: frm_url,
		  data: $(this).serialize(),
		  beforeSend: function() {
			  if ($("input:radio[name=var]:checked" ).val() == undefined) {
				  	return false 
			  };
		  },
		  success: function(data, status, xhr){
			destino.html(data);
		  },
		  error: function(xhr, status, err) {
			//alert(status + ": " + err);
			destino.html(status + ": " + err);
		  }
    	});

		return false;
	});
	
	$('#frm_graf').submit();
});


function limpiar() {
	$('#grafico').html('')
};
</script>
<script type="text/javascript">
jQuery("#Slider").slider({
	from: 1995,
	to: 2015,
	//scale: ["1.995", '|', '|', '|', '|', "2.000", '|', '|', '|', '|', "2.005", '|', '|', '|', '|', "2.010", '|', '|', '|', '|', "2.015" ],
	scale: [1995, 2000, 2005, 2010, 2015 ],
	step: 1,
	limits: false,
	dimension: "",
	format: {format: "0", locale: "es"},
	//skin: "round_plastic"
	onstatechange : function(value) {
		$("#ver").val(value.replace(";", " - "));
		$("#ver").addClass("txtRojo");		
	},
	callback: function(value) {
		var valores = value.split(";");
		
		$("#FechaI").val(valores[0]);
		$("#FechaF").val(valores[1]);
		
		//$("#ver").val(value.replace(";", " - "));
		$("#ver").removeClass("txtRojo");
	},
	skin: "blue"
});

//valores iniciales - si no establecidos
var valores = $("#Slider").val().split(";");

$("#FechaI").val(valores[0]);
$("#FechaF").val(valores[1]);

$("#ver").val($("#Slider").val().replace(";", " - "));
$("#ver").removeClass("txtRojo");

/*
if (ui.values[0]==1995 && ui.values[1]==2015) {
	$("#amount").val("todo");
} else if (ui.values[0]==1995) {
	$("#amount").val("hasta " + ui.values[1]);
} else if (ui.values[1]==2015) {
	$("#amount").val("desde " + ui.values[0]);
} else {
	$("#amount").val(ui.values[0] + " - " + ui.values[1]);
};
*/

var toType = function(obj) {
  return ({}).toString.call(obj).match(/\s([a-zA-Z]+)/)[1].toLowerCase()
}

$(window).on('resize', function () {
	if($('#graf').length > 0){
		graf.replot({ resetAxes: true })
		$.each(graf.series, function(index, series) { 
			series.barWidth = undefined; 
		});
	}
});

</script>
