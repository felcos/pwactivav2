<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<meta charset="utf-8">
<div id="graf"></div>
<div>
<% 
'if request.Cookies("dev")("request")<>"" then
	for each elto in request.Form
		%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
	next 
'end if

FechaI = request.Form("FechaI")
FechaF = request.Form("FechaF")

if FechaI="" then FechaI="01/10/2014"
sqlW = ""

if FechaI<>"" then sqlW = sqlW & "session_start>=CONVERT(DATETIME, '" & FechaI & "', 103)"
if FechaF<>"" then 
	if datediff("d", date, FechaF)>0 then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "session_start<=CONVERT(DATETIME, '" & FechaF & "', 103)"
	end if
end if
if sqlW<>"" then sqlW = " WHERE (" & sqlW & ") "

sql = "SELECT CONVERT(varchar(10), session_start, 101) AS fecha, CONVERT(varchar(10), session_start, 111) AS ff, COUNT(id) AS accesos FROM reg_accesos "
sql = sql & sqlW
'	/* NOT (usuario_id IS NULL) AND */
'	session_start>=01/01/2014
sql = sql & "GROUP BY CONVERT(varchar(10), session_start, 111), CONVERT(varchar(10), session_start, 101) "
sql = sql & "ORDER BY CONVERT(varchar(10), session_start, 111)"


Set rs = Server.CreateObject("ADODB.Recordset")
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos")	', 1, 1

nn = 0
vAccesos = ""

do while not rs.eof 
	nn=nn+1
	if vAccesos<>"" then vAccesos = vAccesos & ", "
	vAccesos = vAccesos & "['" & rs("fecha") & "', " & rs("accesos") & "]"
	rs.movenext
loop 

rs.close
set rs=nothing


'vAccesos = "[1985, 8.50], [1986, 7.50], [1987, 6.75], [1988, 5.75], [1989, 5.25], "
'vAccesos = vAccesos & "[1990, 5.25], [1991, 5.75], [1992, 6.75], [1993, 7.00], [1994, 7.00], [1995, 6.50], [1996, 5.75], [1997, 5.50], [1998, 5.25], [1999, 5.00], "
'vAccesos = vAccesos & "[2000, 5.25], [2001, 6.50], [2002, 6.00], [2003, 5.75], [2004, 5.00], [2005, 4.50], [2006, 4.25], [2007, 4.00], [2008, 5.90], [2009, 5.80], "
'vAccesos = vAccesos & "[2010, 5.75], [2011, 6.00], [2012, 6.25], [2013, 6.25], [2014, 4.75]"
%>

</div>
<script type="text/javascript">
$(document).ready(function(){
	//var ticks = [[1984, ''], [1985, '1985'], [1990, '1990'], [1995, '1995'], [2000, '2000'], [2005, '2005'], [2010, '2010'], [2015, '2015']];
	//var etiquetas = [ {label:'etiqueta 1'}, {label:'etiqueta 2'} ]
	
	
	graf = $.jqplot('graf', [[ <%= vAccesos %> ]], {
		seriesDefaults:{
			renderer:$.jqplot.BarRenderer,
			rendererOptions: {
				// Put a 30 pixel margin between bars.
				barMargin: 30,
				// Highlight bars when mouse button pressed.
				// Disables default highlighting on mouse over.
				highlightMouseDown: true
			},
			pointLabels: {show: false}
		},
        axes: { 
            xaxis: { 
                renderer:$.jqplot.DateAxisRenderer,
                rendererOptions: {
                    tickInset: 0
                },
                tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                tickOptions: {
                  angle: -30
                } 
            }, 
            yaxis: {  
                renderer: $.jqplot.LogAxisRenderer
            } 
        }, 
        cursor:{
            show: true, 
            zoom: true
        }
	});
	
	/*
	$('#graf').bind('jqplotDataClick', function (ev, seriesIndex, pointIndex, data) {
		var informa = "a\xF1o: " + ticks[pointIndex] + ", serie: " + etiquetas[seriesIndex].label + "<br>" + data[1] + " < %= tooltip %>";
		//$('#informa').html(informa);
		//console.log(data)
		
	});
	 $('#grafico').bind('resize', function(event, ui) {
		//graf.replot( { resetAxes: true });
		//console.log("aa");
    });
	
	*/
});


</script>
<hr />
<%= vAccesos %>

