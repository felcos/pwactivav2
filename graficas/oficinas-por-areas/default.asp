<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!DOCTYPE html>
<%
'ON ERROR RESUME NEXT

sec_actual = "/graficas/"

'Recordsets		
set rsTmp = Server.CreateObject("ADODB.Recordset")

r_var = request.Form("graf_var")
'if r_var = "" then r_var = "ops"

r_yy = request.Form("yy")
if r_yy = "" then r_yy = "1996"
yyI = "1996"
yyF = "2015"

r_zona = request.Form("graf_zona")
if r_zona = "" then r_zona = "es"

r_op = request.Form("graf_op")
if r_op = "" then r_op = "venta"	'inversion
%>
<html lang="es">
<head>
	<title>PropertyWeb - Deal Analysis</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
    <link href="/graficas/css_foldy.css" rel="stylesheet" type="text/css">
    
    <!--#include virtual="/lib/jqplot/inc_jqplot.asp" -->
    
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
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_parametros" class="cf">
	<div class="grid-full titulo">
    	<a href="/graficas/" class="volver"><h1 class="heading">gr&aacute;ficas</h1></a>
        <h2>Mercado de Oficinas - Evoluci&oacute;n por &Aacute;reas</h2>
	</div>
    
    <div class="grid-full">
    
<form id="frm_graf" name="frm_graf" action="/graficas/oficinas-por-areas/grafica.asp" method="get" autocomplete="off" target="_blank">
	<input type="hidden" name="graf_op" id="graf_op" value="alquiler">
    
	<div class="grid-4">
<select name="graf_zona" id="graf_zona" onchange="$('#frm_graf').submit();">
    <option value="mad" <% if r_zona="mad" then %>selected<% end if %>>Madrid</option>	
    <option value="bcn" <% if r_zona="bcn" then %>selected<% end if %>>Barcelona</option>
</select>
	</div>
	
    <div class="grid-2 grid-flow-opposite">
        <div class="caja med">
        	
            <div class="row">
<div class="grid-2">
    <input name="ver" type="text" id="ver" value="" style="border: 0; font-weight: bold; width:80px;">
</div>

<div class="grid-4">
    <div class="layout-slider">
    	<input id="Slider" type="slider" name="intervalo" value="<%= yyI %>;<%= yyF %>"/>
    </div>
    <input name="graf_FechaI" type="hidden" id="graf_FechaI" value="<%= yyI %>">
    <input name="graf_FechaF" type="hidden" id="graf_FechaF" value="<%= yyF %>">
</div>
<div style="clear:both;"></div>

            </div>
            
        </div>
        <div class="caja med" style="margin-top:6px;">
<strong><a href="javascript:$('#frm_secciones').slideToggle();">&Aacute;reas</a></strong>
<div id="frm_secciones" style="border-top: 1px solid grey; display:none;">
<table border="0" cellspacing="0" cellpadding="0">
	<% 
set rsSecc=Server.CreateObject("ADODB.recordset")
sql = "SELECT * FROM TIPOS_DE_AREAS WHERE activo=1"
rsSecc.Open sql, session("connPW")
do while not rsSecc.eof
	marcado = true
%>
	<tr>
		<td><input name="area" value="<%= rsSecc("id") %>" <% if marcado then %>checked<% end if %> type="checkbox" disabled></td>
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
<label style="margin-right:15px;">graf<input type="checkbox" name="graf" value="ver" checked/></label>
<label style="margin-right:15px;">tabla<input type="checkbox" name="tabla" value="ver"/></label>
<label style="margin-right:15px;">data<input type="checkbox" name="data" value="ver"/></label>
        </div>
        <div id="informa" class="caja med" style="margin-top:6px;"></div>
    </div>
    
	<div class="grid-4">
<div class="caja">
<p>
<label style="margin-right:30px;">N&uacute;m. Ops.&nbsp;<input type="radio" name="graf_var" value="ops" <% if r_var="ops" then %>checked<% end if %> onClick="$('#frm_graf').submit();"/></label>
<label style="margin-right:30px;">Superficie<input type="radio" name="graf_var" value="m2" <% if r_var="m2" then %>checked<% end if %> onClick="$('#frm_graf').submit();"/></label>
</p>
</div>
<div class="caja" style="margin-top:8px;">
<p>
	<a href="/graficas/oficinas-por-areas/">reset</a> &nbsp; 
	<a href="javascript:$('#frm_graf').submit();">blank</a> &nbsp; 
	<input id="btn_grf" class="enviar" type="button" value="cargar" />
</p>
</div>
<div style="clear:both;"></div>

	</div>
    
</form>

	</div>
</section>

<section id="s_grafica" class="cf">
    <div id="div_graf" style="display:Znone; clear:both;" class="grid-full">
    	<div style="width:75%; margin-left:10%;">
        <div id="grafico">[graf]</div>
        </div>
    </div>
    
</section>

<section id="s_instrucciones" class="cf">
    <div style="clear:both;"></div>
    <div name="div_instrucciones" id="div_instrucciones" style="padding:15px 0 0 15px; font-size:15px; font-weight:bold; min-height:60px;">
        instrucciones
    </div>
    <div id="blocker" style="display:none; text-align:center;">
       <img src="/img/ajax-loader.gif"/>
    </div>
</section>

<section id="s_resultados" class="cf">
	<div id="div_result" class="grid-full" style="display:Znone;">
        <div id="result" style="clear:both;">[result]</div>
    </div>
</section>

</div>
</div>

</body>
</html>
<%
set rsTmp=nothing
%>

<% function colorea(id_secc) 
	select case id_secc
	case 0		'N/D
		colorea = "rgb(216, 216, 216)"
	case 1		'A1
		colorea = "rgb(75, 178, 197)"
	case 2		'A2
		colorea = "rgb(38, 180, 227)"
	case 4
		colorea = "rgb(75, 93, 228)"
		
	case 5		'out
		colorea = "rgb(149, 140, 18)"	
	case 6		'prime
		colorea = "rgb(255, 88, 0)"
	case 7		'dec
		colorea = "rgb(149, 53, 121)"
		
	end select
end function %>


<script type="text/javascript">
$(document).ready( function() {
	var frm_url = "/graficas/oficinas-por-areas/grafica.asp";
	var destino = $('#grafico');
	
	$(".enviar").click( function() {
		//destino.html("");
		$('#frm_graf').submit();
	});
	
	$('#frm_graf').submit(function(){
		//console.log('frm_resumen ajax form...');
		//destino.html("");
		$.ajax({
		  //type: 'get',
		  async: false,
		  url: frm_url,
		  data: $(this).serialize(),
		  beforeSend: function() {
			  if ($("input:radio[name=graf_var]:checked" ).val() == undefined) {
				  	return false ;
			  };
			  //$('#div_graf').fadeIn("fast");
			  //console.log("pasamos por aqui");
		  },
		  success: function(data, status, xhr){
			destino.html(data);
			$('#result').html('');
		  },
		  error: function(xhr, status, err) {
			//alert(status + ": " + err);
			destino.html(status + ": " + err);
			$('#result').html('');
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
		
		$("#graf_FechaI").val(valores[0]);
		$("#graf_FechaF").val(valores[1]);
		
		//$("#ver").val(value.replace(";", " - "));
		$("#ver").removeClass("txtRojo");
	},
	skin: "blue"
});

//valores iniciales - si no establecidos
var valores = $("#Slider").val().split(";");

$("#graf_FechaI").val(valores[0]);
$("#graf_FechaF").val(valores[1]);

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



