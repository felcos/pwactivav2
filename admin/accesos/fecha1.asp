<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>PropertyWeb - DESARROLLO</title>
    <link href="/_inc/foldy/foldy.css" rel="stylesheet" type="text/css">
	<!--#include virtual="/inc/js.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="/lib/easyResponsiveTabs/css.css" />
    
    <link class="include" rel="stylesheet" type="text/css" href="/lib/jqplot/jquery.jqplot.min.css" />
    <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="/lib/jqplot/excanvas.min.js"></script><![endif]-->
    <script class="include" type="text/javascript" src="/lib/jqplot/jquery.jqplot.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.barRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.pointLabels.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
	<script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.logAxisRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.ohlcRenderer.min.js"></script>
    
    <script class="include" type="text/javascript" src="/lib/jqplot/plugins/jqplot.cursor.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
<%
fecha = request.QueryString("f")
if fecha="" then fecha=date
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-4">
    	<h1 class="heading">control de accesos</h1>
	</div>
    
    
	<div class="grid-4">
        <div class="caja">
<form id="frm_accesos" name="frm_accesos" action="/admin/accesos/fecha.asp" method="get" autocomplete="off">
    <input type="text" name="Fecha" id="Fecha" value="<%= fecha %>" maxlength="10" class="fecha">
	<input type="submit" value="cargar">
</form>
        </div>
	</div>
</section>

</div>


<div class="contenedor">
	<div class="grid-full">
    	<!--Horizontal Tab-->
        <div id="horizontalTab">
            <ul class="resp-tabs-list">
                <li>Art&iacute;culos</li>
                <li>Accesos</li>
            </ul>
            <div class="resp-tabs-container">
            
<div>
	<%
	Set rs = Server.CreateObject("ADODB.Recordset")
	
	'reg_articulos
	sql = "SELECT * FROM reg_articulos WHERE fecha='" & fecha & "'"
	'test_inyeccion_sql sql
	rs.Open sql, session("connPWAcesos")	', 1, 1	
	%>
    <div class="tabla">
        <div class="fila">
        	<div class="articulos_n tit">n&deg;</div>
            <div class="articulos_col tit">hora</div>
            <div class="articulos_colw tit">articulo</div>
            <div class="articulos_colw tit">licencia</div>
            <div class="articulos_col_p tit">id_</div>
            <div class="articulos_colw tit">cliente</div>
            <div class="articulos_col_p tit">id_</div>
            
        </div>
    <% 
	nn=0
	do while not rs.eof 
		nn=nn+1
		articulo = rs("articulo_tipo") & " " & rs("articulo_id")
		hora = mid(rs("hora"), instr(rs("hora"), " ")+1, len(rs("hora")))
		%>
		<div class="fila">
        	<div class="articulos_n"><%= nn %></div>
            <div class="articulos_col"><%= hora %></div>
            <div class="articulos_colw"><%= articulo %></div>
            <div class="articulos_colw"><%= rs("licencia") %></div>
            <div class="articulos_col_p"><%= rs("id_licencia") %></div>
            <div class="articulos_colw"><%= rs("cliente") %></div>
            <div class="articulos_col_p"><%= rs("id_cliente") %></div>
        </div>
		<% rs.movenext
		'if nn=10 then exit do
	loop %>
    
    </div>
    <%
	rs.close
	%>
</div>    

<div>
	<div id="div_result">
        <div id="result">RESULT</div>
	</div>
</div>

            </div>
        </div>
        <br />
	</div>
    <div style="clear:both;"></div>
</div>

</section>

</body>
</html>

<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
    $(document).ready(function () {
        $('#horizontalTab').easyResponsiveTabs({
            type: 'default', //Types: default, vertical, accordion           
            width: 'auto', //auto or any width like 600px
            fit: true,   // 100% fit in a container
            closed: 'accordion', // Start closed if in accordion view
            activate: function(event) { // Callback function if tab is switched
                var $tab = $(this);
                //var $info = $('#tabInfo');
                //var $name = $('span', $info);

                //$name.text($tab.text());

                //$info.show();
            }
        });
		
    });
</script>

<link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<script language="javascript">	
$(document).ready(function(){
	$('#Fecha').DatePicker({
		format: 'd/m/Y',
		date: $('#Fecha').val(),
		current: $('#Fecha').val(),
		
		calendars: 1,
		starts: 1,
		//position: 'r',
		
		onBeforeShow: function(){
			$('#Fecha').DatePickerSetDate($('#Fecha').val(), true);
		},
		onChange: function(formated, dates){
			ant_date=$('#Fecha').val();
			$('#Fecha').val(formated);
			if (ant_date!=$('#FechaI').val()) {
				$('#Fecha').DatePickerHide();
				//$('#frm_deal').submit();
			}
		}
	});
});
</script>


