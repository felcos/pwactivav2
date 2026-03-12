<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta charset="utf-8">
<% 
if request.QueryString("graf")="ver" then
	ver_grafica = true
else
	ver_grafica = false
end if

if request.QueryString("tabla")="ver" then
	ver_tabla = true
	ver_data = false
else
	ver_tabla = false
	if request.QueryString("data")="ver" then
		ver_data = true
	else
		ver_data = false
	end if
end if


if request.Cookies("dev")("request")<>"" then
	for each elto in request.QueryString
		%><%= elto %>:<strong><%= request.QueryString(elto) %></strong> &nbsp; <%
	next 
end if
%>
<div id="graf"></div>

<%
set rsSecc=Server.CreateObject("ADODB.recordset")
set rs=Server.CreateObject("ADODB.recordset")

fecha_i = request.QueryString("graf_FechaI")
if fecha_i="" then fecha_i=1996
fecha_f = request.QueryString("graf_FechaF")
if fecha_f="" then fecha_f=2014
cols = fecha_f - fecha_i

r_var = request.QueryString("graf_var") 
r_op = request.QueryString("graf_op")
r_zona = request.QueryString("graf_zona")
n_fila = 0

dim var(15)

select case r_var
case "ops"
	label = "N\xFAm. Operaciones"
	tooltip = "Operaciones"
case "eur"
	label = "Millones de Euros"
	tooltip = "Mill. Euros"
case "m2"
	label = "Miles de m\xB2"
	tooltip = "000 m\xB2"
end select

select case r_zona
case "es"
	title = "Espa\xF1a"
case "mad"
	title = "Madrid"
case "bcn"
	title = "Barcelona"
end select

title = title & " - "

select case r_op
case "venta"
	title = title & "Inversi\xF3n / Ocupaci\xF3n Propia"
case "alquiler"
	title = title & "Alquiler / Traspaso"
end select

ticks = ""
for ii=0 to cols
	if ticks<>"" then ticks = ticks & ", "
	ticks = ticks & (fecha_i + ii)
next %>
<% if ver_data then %><li>ticks: <%= ticks %></li><% end if %>

<% if ver_tabla then %>
<style>
#mytable {
	margin-top:20px;
	font:Verdana, Geneva, sans-serif;
	font-size:12px;
	}
</style>
<table border="1" cellspacing="0" cellpadding="2" id="mytable">
  <tr>
    <td width="220">seccion</td>
    <% for ii=0 to cols
		%><td width="35" align="right"><%= fecha_i + ii %></td><%
	next %>
  </tr>
<% end if %>

<%
'sql = "SELECT * FROM secciones_operaciones WHERE simple=1 AND activo=1  ORDER BY orden DESC"
sql = "SELECT * FROM secciones_operaciones WHERE id IN (" & request.QueryString("secc") & ") ORDER BY orden DESC"

rsSecc.Open sql, session("connPW")

etiquetas = ""
colores = ""

do while not rsSecc.eof 
	etiqueta = rsSecc("nombre")
	etiqueta = replace(etiqueta, "Í", "I")
	if etiquetas<>"" then etiquetas = etiquetas & ", "
	etiquetas = etiquetas & "{label:'" & lcase(etiqueta) & "'}"
	
	if colores<>"" then colores = colores & ", "
	colores = colores & "'" & colorea(rsSecc("id")) & "'"
	%>
	<% if ver_tabla then %>
	<tr>
        <td><%= rsSecc("nombre") %></td>
    <% end if %>
        <% calcula_fila %>
    <% if ver_tabla then %>
    </tr>
    	<% if 1=2 then %>
    	<tr><td></td><td colspan="<%= cols+1 %>"><%= sql %></td></tr>
    	<% end if %>
	<% end if %>
	<%
	'calcula_fila 
	rsSecc.movenext
	n_fila = n_fila + 1
loop
rsSecc.close
set rsSecc=nothing
%>
<% if ver_tabla then %>
</table>
<% end if %>

<% if ver_data then %><li>etiquetas: <%= etiquetas %></li><% end if %>

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

<% sub calcula_fila
	seccion = rsSecc("nombre")
	seccion = replace(seccion, "Í", "_")
	
	select case r_var
	case "ops"
		sql = "SELECT COUNT(DISTINCT OPERACIONES_DETALLE.id_operacion) AS valor, YEAR(OPERACIONES.FECHA_OPERACION) AS yy "
		sql = sql & "FROM OPERACIONES INNER JOIN "
		sql = sql & "OPERACIONES_DETALLE ON OPERACIONES.ID = OPERACIONES_DETALLE.id_operacion INNER JOIN "
		sql = sql & "TIPOS_DE_OPERACIONES ON OPERACIONES.ID_TIPO_OPERACION = TIPOS_DE_OPERACIONES.ID INNER JOIN "
		sql = sql & "secciones_operaciones ON OPERACIONES_DETALLE.id_seccion = secciones_operaciones.ID LEFT OUTER JOIN "
		sql = sql & "Paises ON OPERACIONES.ID_PAIS = Paises.Id "
		sql = sql & "WHERE ("
		
		sql = sql & "(OPERACIONES.web_es = 1) AND "
		sql = sql & "(OPERACIONES_DETALLE.seccion_operacion = 1) AND "
		
		
		sql = sql & "(OPERACIONES_DETALLE.id_seccion IN (" & request.QueryString("secc") & ")) AND "
		
		select case r_zona
		case "es"
			sql = sql & "(OPERACIONES.ID_PAIS = 1) "
		case "mad"
			sql = sql & "(OPERACIONES.ID_PROVINCIA = 2) "
		case "bcn"
			sql = sql & "(OPERACIONES.ID_PROVINCIA = 3) "
		end select
		sql = sql & "AND "
		
		sql = sql & "(OPERACIONES.ID_TIPO_OPERACION IN "
		select case r_op
		case "venta"
			sql = sql & "(1, 3)"	
		case "alquiler"
			sql = sql & "(2, 4)"
		end select
		sql = sql & ") AND "
		
		sql = sql & "(secciones_operaciones.NOMBRE LIKE '%" & seccion & "%')"
		
		sql = sql & ") "
		
		sql = sql & "GROUP BY YEAR(FECHA_OPERACION) "
		sql = sql & "ORDER BY YEAR(FECHA_OPERACION)"
		
		
	case "m2"
		sql = "SELECT SUM(OPERACIONES_DETALLE.Superficie) AS valor, YEAR(OPERACIONES.FECHA_OPERACION) AS yy "
		sql = sql & "FROM OPERACIONES INNER JOIN "
		sql = sql & "OPERACIONES_DETALLE ON OPERACIONES.ID = OPERACIONES_DETALLE.id_operacion INNER JOIN "
		sql = sql & "TIPOS_DE_OPERACIONES ON OPERACIONES.ID_TIPO_OPERACION = TIPOS_DE_OPERACIONES.ID INNER JOIN "
		sql = sql & "secciones_operaciones ON OPERACIONES_DETALLE.id_seccion = secciones_operaciones.ID LEFT OUTER JOIN "
		sql = sql & "Paises ON OPERACIONES.ID_PAIS = Paises.Id "
		
		sql = sql & "WHERE ("
		
		sql = sql & "(OPERACIONES.web_es = 1) AND "
		sql = sql & "(OPERACIONES_DETALLE.seccion_operacion = 1) AND "
		
		select case r_zona
		case "es"
			sql = sql & "(OPERACIONES.ID_PAIS = 1) "
		case "mad"
			sql = sql & "(OPERACIONES.ID_PROVINCIA = 2) "
		case "bcn"
			sql = sql & "(OPERACIONES.ID_PROVINCIA = 3) "
		end select
		sql = sql & "AND "
		
		sql = sql & "(OPERACIONES.ID_TIPO_OPERACION IN "
		select case r_op
		case "venta"
			sql = sql & "(1, 3)"	
		case "alquiler"
			sql = sql & "(2, 4)"
		end select
		sql = sql & ") AND "
		
		sql = sql & "(secciones_operaciones.NOMBRE LIKE '%" & seccion & "%')"
		
		sql = sql & ") "
		
		sql = sql & "GROUP BY YEAR(FECHA_OPERACION) "
		sql = sql & "ORDER BY YEAR(FECHA_OPERACION)"
		
	case "eur"
		sql = "SELECT SUM("
		sql = sql & "CASE WHEN ID_TIPO_PRECIO = 5 THEN PRECIO_EUR WHEN ID_TIPO_PRECIO = 8 THEN PRECIO_EUR WHEN ID_TIPO_PRECIO = 4 THEN CASE WHEN METROS_CUADRADOS > 0 THEN PRECIO_EUR * METROS_CUADRADOS ELSE 0 END WHEN ID_TIPO_PRECIO = 10 THEN CASE WHEN METROS_CUADRADOS > 0 THEN PRECIO_EUR * METROS_CUADRADOS ELSE 0 END ELSE 0 END"
		'sql = sql & "METROS_CUADRADOS"
		sql = sql & ") AS valor, YEAR(FECHA_OPERACION) AS yy "
		sql = sql & "FROM C_OPERACIONES WHERE "
	
		sql = sql & "(web_es<>0) AND "
		
		select case r_zona
		case "es"
			sql = sql & "(ID_PAIS = 1) "
		case "mad"
			sql = sql & "(ID_PROVINCIA = 2) "
		case "bcn"
			sql = sql & "(ID_PROVINCIA = 3) "
		end select
		sql = sql & "AND "
		
		sql = sql & "(ID_TIPO_OPERACION IN "
		select case r_op
		case "venta"
			sql = sql & "(1, 3)"	
		case "alquiler"
			sql = sql & "(2, 4)"
		end select
		sql = sql & ") AND "
		
		sql = sql & "(seccion LIKE '%" & seccion & "%') "
		
		sql = sql & "GROUP BY YEAR(FECHA_OPERACION) "
		sql = sql & "ORDER BY YEAR(FECHA_OPERACION)"
		
	end select
	
	rs.Open sql, session("connPW")
	
	
	cont=0
	do while not(rs.eof)
		if rs("yy")>=int(fecha_i) then
			exit do
		else
			rs.movenext
		end if
		
		cont = cont + 1
		if cont > 100 then 
			response.Write("<li>CONT>100</li>")
			exit do
		end if
	loop
	
	if ver_data then %><li>var_<%= n_fila %>: <% end if
	
	fila = ""
	for ii=0 to cols
		if rs.eof then
			valor = 0
		else
			if rs("yy")=int(fecha_i+ii) then
				select case r_var
				case "ops"
					valor = clng(rs("valor"))
				case "m2"
					valor = clng(rs("valor"))/1000
				case "eur"
					valor = clng(rs("valor")/1000)/1000
				end select
				'valor=FormatNumber(valor, 0)
				'if r_var="eur" then
					'valor = replace(cstr(clng(10*valor)/10), ",", ".")
				'end if
				rs.movenext
			else
				valor=0
			end if
		end if
		
		valor = replace(cstr(valor), ",", ".")
		
		if fila<>"" then fila = fila & ", "
		fila = fila & valor 
		
		if ver_tabla then %><td align="right"><%= valor %></td><% end if
	next
	
	if ver_data then %><%= fila %></li><% end if
	var(n_fila)="[" & fila & "]"
	
	rs.close
	
end sub %>

<% if ver_grafica then %>
<script type="text/javascript">
$(document).ready(function(){
	<%
	valores = ""
	for jj=0 to n_fila 
		if valores<>"" then valores=valores & ", "
		valores = valores & var(jj)
	next
	%>
	
	var ticks = [<%= ticks %>];
	var etiquetas = [ <%= etiquetas %> ]
	
	graf = $.jqplot('graf', [<%= valores %>], {
		title: '<%= title %>',
		// Tell the plot to stack the bars.
		stackSeries: true,
		captureRightClick: true,
		
		seriesColors: [<%= colores %>],
		
		// animate: !$.jqplot.use_excanvas,
		animate: true,
		
		seriesDefaults:{
			renderer:$.jqplot.BarRenderer,
			rendererOptions: {
				// Put a 30 pixel margin between bars.
				barMargin: 10,
				// Highlight bars when mouse button pressed.
				// Disables default highlighting on mouse over.
				highlightMouseDown: true
			},
			pointLabels: {show: false}
		},
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				ticks: ticks
			},
			yaxis: {
				label: '<%= label %>', 
				tickOptions: {
                    formatString: "%'d"
					//"%'d"
                },
				labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
				// Don't pad out the bottom of the data range.  By default,
				// axes scaled as if data extended 10% above and below the
				// actual range to prevent data points right on grid boundaries.
				// Don't want to do that here.
				padMin: 0
			}
		},
		legend: {
			show: false,	//true,
			location: 'e',
			placement: 'outside'
		}, 
		series: etiquetas,
		highlighter: {
			show: true,
			showMarker:false,
			tooltipAxes: 'y',
			//useAxesFormatters: true
			// You can customize the tooltip format string of the highlighter
			// to include any arbitrary text or html and use format string
			// placeholders (%s here) to represent x and y values.
			formatString: "%s <% = tooltip %>"
		}
		//,
		//cursor:{
        //    show: true, 
         //   zoom: true
        //}
	});
	
	$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		var informa = "a\xF1o: " + ticks[pointIndex] + ", serie: " + etiquetas[seriesIndex].label + "<br>" + data[1] + " <%= tooltip %>";
		//informa = informa + "<br>" + data;
		
		$('#informa').html(informa);
		//console.log(data)
		resetform();
		
		$('#FechaI').val('01/01/' +  ticks[pointIndex]);
		$('#FechaF').val('31/12/' +  ticks[pointIndex]);
		
		$('#provincia').val('%');
		$('#pais').val('1');
		
		var op = $('#graf_op').val();
		$('#operacion').val(op);
		
		$('#sec').val(etiquetas[seriesIndex].label);
		
		if (etiquetas[seriesIndex].label=="solares") {
			$("#div_usosolar").fadeIn("slow");
		} else {
			$("#div_usosolar").fadeOut("slow");
		};
		
		cambiooperacion();
/*
		var frm_url = "/graficas/titulos.asp?";
		frm_url = frm_url + "pais=1&";
		frm_url = frm_url + "provincia=%25&";
		frm_url = frm_url + "operacion=" + $('#op').val() + "&";
		frm_url = frm_url + "sec=" + etiquetas[seriesIndex].label + "&";
		frm_url = frm_url + "FechaI=01/01/" + ticks[pointIndex] + "&";
		frm_url = frm_url + "FechaF=31/12/" + ticks[pointIndex];
		
		$.ajax({
		  type: 'get',
		  async: false,
		  url: frm_url,
		  //data: $(this).serialize(),
		  beforeSend: function() {
			  
		  },
		  success: function(data, status, xhr){
			$('#result').html(data);
		  },
		  error: function(xhr, status, err) {
			//alert(status + ": " + err);
			$('#result').html(status + ": " + err);
		  }
    	});
		//$('#result').html()
*/
	});
	 $('#grafico').bind('resize', function(event, ui) {
		//graf.replot( { resetAxes: true });
		//console.log("aa");
    });
	
	
});


</script>
<% end if %>
