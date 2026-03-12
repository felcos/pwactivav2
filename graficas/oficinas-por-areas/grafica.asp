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
set rsArea=Server.CreateObject("ADODB.recordset")
set rs=Server.CreateObject("ADODB.recordset")

fecha_i = request.QueryString("graf_FechaI")
if fecha_i="" then fecha_i=1996
fecha_f = request.QueryString("graf_FechaF")
if fecha_f="" then fecha_f=2014
cols = fecha_f - fecha_i

r_var = request.QueryString("graf_var") 
'r_op = 2	alquiler
r_zona = request.QueryString("graf_zona")
n_fila = 0

dim var(15)

select case r_var
case "ops"
	label = "N\xFAm. Operaciones"
	tooltip = "Operaciones"
case "m2"
	label = "Miles de m\xB2"
	tooltip = "000 m\xB2"
end select

select case r_zona
case "mad"
	title = "Madrid"
case "bcn"
	title = "Barcelona"
end select

title = "Mercado de Oficinas - " & title 

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
sql = "SELECT * FROM TIPOS_DE_AREAS WHERE ACTIVO=1"

rsArea.Open sql, session("connPW")

etiquetas = ""
colores = ""

do while not rsArea.eof 
	etiqueta = rsArea("nombre")
	etiqueta = replace(etiqueta, "Í", "I")
	if etiquetas<>"" then etiquetas = etiquetas & ", "
	etiquetas = etiquetas & "{label:'" & lcase(etiqueta) & "'}"
	
	if colores<>"" then colores = colores & ", "
	colores = colores & "'" & colorea(rsArea("id")) & "'"
	%>
	<% if ver_tabla then %>
	<tr>
        <td><%= rsArea("nombre") %></td>
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
	rsArea.movenext
	n_fila = n_fila + 1
loop
rsArea.close
set rsArea=nothing
%>
<% if ver_tabla then %>
</table>
<% end if %>

<% if ver_data then %><li>etiquetas: <%= etiquetas %></li><% end if %>
<div style="background-color:">
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

<% sub calcula_fila
	sql = "SELECT COUNT(ID) AS ops, SUM(METROS_CUADRADOS) AS valor, YEAR(FECHA_OPERACION) AS yy "
	sql = sql & "FROM C_OPERACIONES "
	sql = sql & "WHERE ("
	
	sql = sql & "(web_es = 1) AND "
	
	sql = sql & "(ID_TIPO_OPERACION = 2) AND "
	sql = sql & "(seccion LIKE '%oficinas%') AND "
	
	sql = sql & "(ID_TIPO_AREA = " & rsArea("id") & ") AND "
	
	select case r_zona
	case "mad"
		sql = sql & "(ID_PROVINCIA = 2) "
	case "bcn"
		sql = sql & "(ID_PROVINCIA = 3) "
	end select
	
	sql = sql & ") "
	
	sql = sql & "GROUP BY YEAR(FECHA_OPERACION) "
	sql = sql & "ORDER BY YEAR(FECHA_OPERACION)"
	
	
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
					valor = clng(rs("ops"))
				case "m2"
					valor = clng(rs("valor"))/1000
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
		//title: '<%= title %>',
		
		stackSeries: true,
		captureRightClick: true,
		
		//seriesColors: [< %= colores %>],
		
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
			show: true,	//true,
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
	
	//$('#graf').unbind();
	
	$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		var frm_url = "/graficas/titulos.asp?";
		var zona;
		switch(etiquetas[seriesIndex].label.toUpperCase()) {
			case "N/D":
				zona = 0;
				break;
			case "A1":
				zona = 1;
				break;
			case "A2":
				zona = 2;
				break;
			case "A3":
				zona = 4;
				break;
			case "OUT":
				zona = 5;
				break;
			case "PRIME":
				zona = 6;
				break;
			case "DEC":
				zona = 7;
				break;
		};
		switch($('#graf_zona').val()) {
			case "mad":
				prov = 2;
				break;
			case "bcn":
				prov = 3;
				break;
		};
		
		frm_url = frm_url + "pais=1&";
		frm_url = frm_url + "provincia=" + prov + "&";
		frm_url = frm_url + "operacion=" + $('#graf_op').val() + "&";
		frm_url = frm_url + "sec=oficinas&";
		frm_url = frm_url + "zonainmobiliaria=" + zona + "&";
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

	});
	 $('#grafico').bind('resize', function(event, ui) {
		//graf.replot( { resetAxes: true });
		//console.log("aa");
    });
	
	
});


</script>
<% end if %>
