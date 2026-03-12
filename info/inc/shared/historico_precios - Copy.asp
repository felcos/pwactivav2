<!--#include virtual="/info/inc/calcular_sql.asp" -->
<%
'on error resume next
'resp = session("pw_ws").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("user_id"))

set rsPrecios = Server.CreateObject("ADODB.Recordset")
session("connPW").CommandTimeout = 120

swCheck=true

sql = "SELECT *, CONVERT(VARCHAR(10),FECHA_OPERACION, 21) AS FECHA FROM C_OPERACIONES WHERE " 
sql = sql & calcular_sqlw("ops_alquiler")
sql = sql & " ORDER BY FECHA_OPERACION"

rsPrecios.Open sql, session("connPW")

oficinas = ""
locales = ""
nn = 1

if not rsPrecios.eof then

	y_min = year(rsPrecios("FECHA_OPERACION"))
	
	do while not rsPrecios.eof 
		
		select case rsPrecios("ID_TIPO_PRECIO")
		case 1, 11
			if isnull(rsPrecios("PRECIO_EUR")) then
				importe = 0
			else
				importe = round(rsPrecios("PRECIO_EUR"), 2)
			end if
			
		case 2, 9
			if  rsPrecios("METROS_CUADRADOS")>0 then
				importe = round(rsPrecios("PRECIO_EUR")/rsPrecios("METROS_CUADRADOS"))
			else
				importe = 0
			end if
		
		case 4, 10
			if isnull(rsPrecios("PRECIO_EUR")) then
				importe = 0
			else
				importe = round(rsPrecios("PRECIO_EUR")/12, 2)
			end if
			
		case else
			importe = 0
			
		end select
		
		'moneda = "" & rsPrecios("TIPOPRECIO")
		'moneda = replace(moneda, "PTS", "&euro;")
		
		if importe>0 then 
			nn = nn + 1
			if rsPrecios("id_seccion")=16 then
				if oficinas<>"" then oficinas = oficinas & ", "
				oficinas = oficinas & "['" & rsPrecios("FECHA") & "', " & replace(importe, ",", ".") & "]"
				
			elseif rsPrecios("id_seccion")=4 then
				if locales<>"" then locales = locales & ", "
				locales = locales & "['" & rsPrecios("FECHA") & "', " & replace(importe, ",", ".") & "]"
				
			end if
		 end if
		rsPrecios.movenext
	loop
	
	ticks = ""
	for yy = y_min to 2016
		
		if yy mod 5=0 then 
			tick = yy
		else
			tick = ""
		end if
		
		if ticks<>"" then ticks = ticks & ", "
		ticks = ticks & "['" & yy & "-01-01', '" & tick & "']"
		'[1984, '']
	next
	
	if oficinas<>"" then %>
		<script>
        $(document).ready(function(){
            var oficinas = [<%= oficinas %>];
            var locales = [<%= locales %>];
            var ticks = [<%= ticks %>];
            
            //$("#informa_oficinas").html("< %= oficinas %>");
            //$("#informa_locales").html("< %= locales %>");
            //$("#informa_ticks").html("< %= y_min %><br>< %= ticks %>");
            
            var plot1 = $.jqplot("graf_rentas", [oficinas, locales], {
                title: "<h3>Evoluci&oacute;n de Rentas (&euro;/m&sup2;/mes)</h3>",
                stackSeries: false,
                captureRightClick: true,
                height:250,
                animate: true,
                animateReplot: true,
                
                seriesDefaults:{
                    pointLabels: {show: false},
                    rendererOptions: { 
                        animation: {speed: 2000}, 
                        smooth: false
                    },
                    lineWidth:2
                },
                
                axes:{
                    xaxis:{
                        ticks: ticks,
                        renderer:$.jqplot.DateAxisRenderer,
                        tickOptions: {formatString: "%Y"}
                    },
                    yaxis:{
                        autoscale:true,
                        label:"oficinas",
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                    },
                    y2axis:{
                        autoscale:true, 
                        tickOptions: {
                            showGridline:false
                        },
                        label:"locales",
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                        labelOptions: {
                            angle:90
                        }
                    }
                },
                highlighter: {
                    show: true, 
                    showLabel: true, 
                    tooltipAxes: "y",
                    sizeAdjust: 7.5 ,
                    tooltipLocation : "ne",
                    tooltipFormatString: "%.2f €/m&sup2;/mes",
                    useAxesFormatters: false
                },
                legend: {
                    show: true,
                    location: 'nw',
                    placement: 'outside'
                    //,
                    //xoffset: -480,        // pixel offset of the legend box from the x (or x2) axis.
                    //yoffset: 580
                },
                
                series:[{label: "oficinas"}, {yaxis: "y2axis", label: "locales"}]
                
            });
            
        });
        </script>
	<% end if 
end if
	
rsPrecios.close
set rsPrecios=nothing

Set rsPrecios = nothing
%>