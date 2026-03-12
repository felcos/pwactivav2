<% 
rId = rsInmueble("id")

'rId = "3992"	'parque bulevar
'rId = "3564"	'h2o


set rsActiv = Server.CreateObject("ADODB.Recordset")	

sql = "SELECT id_tipo_inquilino, tipo_inquilino, SUM(superficie) AS sup FROM c_inmuebles_inquilinos WHERE id_inmueble = " & rId
sql = sql & " GROUP BY id_tipo_inquilino, tipo_inquilino ORDER BY SUM(superficie) DESC"

rsActiv.Open sql, session("connPW")

if not rsActiv.eof then
%>
<style>
	.inquilino {
		font-size:12px;
		line-height:normal;
		}
		
	#superficies {
		/* float: left; */
		}
	
	#canvas-holder {
		float:right;
	}
	#mostrarInquilinos {
		color:#f47c04;		
	}
</style>
<script type="text/javascript">
function show(id) {
	if(document.getElementById("show-" + id).style.display == 'none') {
		//alert('AAA AAA');
		document.getElementById("show-" + id).style.display = '';
		document.getElementById("suma-" + id).style.display = 'none';
	}
	else {
		//alert('BBB BBB');
		document.getElementById("show-" + id).style.display = 'none';
		document.getElementById("suma-" + id).style.display = '';
	}
}
</script>
<div class="detalles clearfix operaciones">
    <div class="col-sm-6">
		<div class="cajaImg"><div id="container3d"></div></div>
        <!-- style="min-width: 310px; height: 400px; max-width: 750px; margin: 0 auto;" -->
    </div>
    <div class="col-sm-6">
<div class="tablas">
    <% if 1=2 then %><span style="float:right;"><a id="mostrarInquilinos" href="javascript:verTodos();">ocultar ocupantes</a></span><% end if %>
    <h3 class="toggle expander collapsed" id="ocupantes">Ocupantes</h3>
    <section id="noticias" class="collapser">
        <p>Principales Ocupantes del Centro Comercial @2012:</p>
<table class="tb-Gral tb-Ocupacion">
<tbody>
	<%
	filas = ""
	suma = 0
	datos = ""
	datos2 = ""
	ii=1
	do while not rsActiv.eof 
		if rsActiv("id_tipo_inquilino")=3 then
			actividad = "HOGAR, BRICOLAGE..."
		else
			actividad = rsActiv("tipo_inquilino")
		end if
		suma = suma + rsActiv("sup")
		
		if datos<>"" then datos = datos & ", "
		datos = datos & "['" & actividad & "', " & rsActiv("sup") & "]"
		
		if datos2<>"" then datos2 = datos2 & ", "
		'if datos2="" then
		if ii=2 then
			datos2 = datos2 & "{ name: '" &actividad & "', y: " & rsActiv("sup") & ", sliced: true, selected: true }"
		else
			datos2 = datos2 & "['" & actividad & "', " & rsActiv("sup") & "]"
		end if
		
		if filas<>"" then filas = filas & "#"
		filas = filas & "show-act" & rsActiv("id_tipo_inquilino")
		%>
        <tr class="subHeader">
            <td><%= rsActiv("tipo_inquilino") %></td>
            <td><% if 1=2 then %><%= formatnumber(rsActiv("sup"), 0) %>&nbsp;m&sup2;<% end if %></td>
        </tr>
        <%
		set rsInq2 = Server.CreateObject("ADODB.Recordset")	
		sql = "SELECT * FROM c_inmuebles_inquilinos WHERE id_inmueble = " & rId & " AND id_tipo_inquilino=" & rsActiv("id_tipo_inquilino")
		rsInq2.Open sql, session("connPW")
	
		subtotal = 0
		do while not rsInq2.eof 
			subtotal = subtotal + rsInq2("superficie") %>
			<tr>
				<td><%= rsInq2("nombre") %></td>
				<td><%= formatnumber(rsInq2("superficie"), 0) %>&nbsp;m&sup2;</td>
			</tr>
			<% 
			rsInq2.movenext
		loop %>
			<tr class="total03">
				<td>Subtotal: </td>
				<td><%= formatnumber(subtotal, 0) %>&nbsp;m&sup2;</td>
			</tr>
		<% 
		rsInq2.close
		set rsInq2=nothing
		%>
        <% rsActiv.movenext
		ii=ii+1
    loop
	
	fila = split(filas, "#")
	%>
    <tr class="total">
		<td><strong>TOTAL:</strong>&nbsp;</td>
		<td><strong><%= formatnumber(suma, 0) %>&nbsp;m&sup2;</strong></td>
	</tr>
</tbody>
</table>
    
    </section>
</div>
<% 
if suma>0 then %>
<script src="/lib/high/charts/js/highcharts.js"></script>
<script src="/lib/high/charts/js/highcharts-3d.js"></script>
<!-- <script src="/lib/high/charts/js/modules/exporting.js"></script> -->
<%'response.End()%>
<script type="text/javascript">
$(document).ready(function() { 

    Highcharts.getOptions().colors = Highcharts.map(Highcharts.getOptions().colors, function (color) {
        return {
            radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
            stops: [
                [0, color],
                [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] // darken
            ]
        };
    });
	
	$('#container3d').highcharts({
        credits: { enabled: false },
		chart: {
			plotBorderWidth: 0,
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: { text: null },
//        tooltip: {  pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>' },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'superficie',
            data: [<%= datos2 %>]
        }]
    });
	
});

function verTodos() {
	if ($('#mostrarInquilinos').html()=='mostrar ocupantes') {
		$('#mostrarInquilinos').html('ocultar ocupantes');
		<% for ii=0 to ubound(fila) %>
			document.getElementById("<%= fila(ii) %>").style.display = '';
		<% next %>
	} else {
		$('#mostrarInquilinos').html('mostrar ocupantes');
		<% for ii=0 to ubound(fila) %>
			document.getElementById("<%= fila(ii) %>").style.display = 'none';
		<% next %>
	};
	return false;
}
</script>
<% end if %>
    </div>
</div>
<%
end if

rsActiv.close
set rsActiv=nothing

%>
<% sub TablaInquilinos(pTipo) 
	set rsInq = Server.CreateObject("ADODB.Recordset")	
	sql = "SELECT * FROM c_inmuebles_inquilinos WHERE id_inmueble = " & rId & " AND id_tipo_inquilino=" & pTipo
	rsInq.Open sql, session("connPW")
	%>
<table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-bottom:10px; padding-left:5px;">
		<%
		subtotal = 0
		do while not rsInq.eof 
			subtotal = subtotal + rsInq("superficie") %>
            <tr class="inquilino">
                <td style="border-top:1px dotted grey; padding-left:3px;"><%= rsInq("nombre") %></td>
                <td width="100" align="right" style="border-top:1px dotted grey;"><%= formatnumber(rsInq("superficie"), 0) %>&nbsp;m&sup2;</td>
        	</tr>
			<% 
			rsInq.movenext
		loop %>
        	<tr>
                <td align="right" style="border-top:1px dotted grey;">subtotal: </td>
                <td width="100" align="right" style="border-top:1px dotted grey;"><%= formatnumber(subtotal, 0) %>&nbsp;m&sup2;</td>
        	</tr>
</table>
<% 
	rsInq.close
	set rsInq=nothing

end sub %>