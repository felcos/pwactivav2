<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
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
#tab .resp-tabs-container {
	min-height:100px;
}
#tabData .resp-tabs-list li {
    width:120px;
}
#graf1, #graf2, #graf3 {
	min-height:300px;
}
/*
form .grid-1, form .grid-2, form .grid-3, form .grid-4, form .grid-5, form .grid-6, form .grid-full {
	margin-bottom:.25em;
}
*/
</style>
<%
u = request.QueryString("u")
l = request.QueryString("l")
uid = request.QueryString("uid")
lid = request.QueryString("lid")

f_desde = "01/01/2015"
f_hasta = date

session("connPWAcesos").CommandTimeout = 120
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<section id="content">
<div class="contenedor">

<section id="introp" class="cf">

	<div class="grid-4">
    	<h1 class="heading">accesos</h1>
       
	</div>
    <div class="grid-2 grid-flow-opposite">
    	<!--#include virtual="/admin/inc_menu.asp" -->
    
   	<form id="frm_accesos" name="frm_accesos" action="/admin/accesos/cliente/comparativa.asp" method="post" autocomplete="off" target="_blank">
        <div class="grid-6">
       	    cliente - licencia
              <hr>
        </div>
        
        <div class="grid-1"><% if l<>"" then %><a href="/admin/accesos/cliente/?uid=<%= uid %>&u=<%= u %>">cliente</a><% else %>cliente<% end if %>:</div>
        <div class="grid-5">
            <input type="text" name="u" value="<%= u %>" style="width:230px;">&nbsp;
            <input type="text" name="uid" value="<%= uid %>" style="width:45px; text-align:right;">
        </div>
        
        <div class="grid-1">licencia:</div>
        <div class="grid-5">
            <input type="text" name="l" value="<%= l %>" style="width:230px;">&nbsp;
            <input type="text" name="lid" value="<%= lid %>" style="width:45px; text-align:right;">&nbsp;<% if lid<>"" then %><a href="/admin/accesos/cliente/?uid=<%= uid %>&u=<%= u %>&l=<%= l %>">x</a><% end if %>
        </div>
        
        <div class="grid-full" style="margin-top:15px; margin-bottom:15px; border-top:1px solid #c1c1c1;"></div>
        	Comparar con: <select name="yy" onChange="$('#frm1').submit();" style="border:0;" id="yy">
		<% for yy=2014 to 2010 step -1 %>
	        <option value="<%= yy %>" <% if yy=yy_res then %>selected<% end if %>><%= yy %></option>
        <% next %>
    </select>
            &nbsp;
            <input name="anno_completo" type="checkbox" value="y" checked onChange="$('#frm1').submit();">&nbsp;completo
             &nbsp; &nbsp; &nbsp; 
             <select name="tipo" onChange="$('#frm1').submit();" style="border:0;">
                <option value="d" <% if rTipo="d" then %>selected<% end if %>>por d&iacute;as</option>
                <option value="w" <% if rTipo="w" or rTipo="" then %>selected<% end if %>>por semanas</option>
                <option value="m" <% if rTipo="m" then %>selected<% end if %>>por meses</option>
            </select>
        
        <div class="grid-full" style="margin-top:15px; margin-bottom:15px; border-top:1px solid #c1c1c1;"></div>
        
        <div class="grid-4" style="margin-bottom:10px;"><strong><a href="/admin/accesos/cliente/default.asp?<%= request.QueryString %>" target="_blank">resumen num&eacute;rico</a></strong></div>
        <div class="grid-1" style="margin-bottom:10px;"><a href="">reset</a></div>
        <div class="grid-1" style="margin-bottom:10px;"><input type="submit" value="submit"></div>
        
    </form>
    </div>
    
    <div class="grid-4">
		<div id="graf1"></div>
		<div id="informa_graf1"></div>
    </div>
    
    <div style="clear:both;"></div>
    
</section>

</div>

<div class="contenedor">
	<div class="grid-full" id="result"></div>
    <div style="clear:both;"></div>
    
</div>

</section>

</body>
</html>
<script language="javascript">
var plot1;

$(document).ready(function(){
	// datepicker
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
				$('#frm_deal').submit();
			}
		}
	});
	$('#FechaF').DatePicker({
		format: 'd/m/Y',
		date: $('#FechaF').val(),
		current: $('#FechaF').val(),
		
		calendars: 1,
		starts: 1,
		//position: 'r',
		
		onBeforeShow: function(){
			$('#FechaF').DatePickerSetDate($('#FechaF').val(), true);
		},
		onChange: function(formated, dates){
			ant_date=$('#FechaF').val();
			$('#FechaF').val(formated);
			
			if (ant_date!=$('#FechaF').val()) {
				$('#FechaF').DatePickerHide();
				$('#frm_deal').submit();
			}
		}
	});
	
	// formulario
	$('#frm_accesos').submit(function(){ 
		/*
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/accesos/cliente/resumen2.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {
				$('#loading_resumen').show();
				$('#resumen').html('');
			},
			success: function(data, status, xhr){
				$('#resumen').html(data);
				$('#loading_resumen').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		
		$.ajax({
		  //async: true,
		  type: "POST",
		  //url: "/admin/accesos/cliente/comparativa.asp",
		  url: $(this).attr("action"),
		  data: $(this).serialize(),
		  beforeSend: function() {
			  //$('#loading_graf1').show();
		  },
		  success: function(data, status, xhr){
			  $('#informa_graf1').html(data);
			  //$('#loading_graf1').hide();
		  },
		  error: function(xhr, status, err) {
			  $('#graf1').html("ERROR<br>" + status + ": " + err);
			  //$('#loading_graf1').hide();
		  }
    	});
		
		return false;
	});
	
	$('#frm_accesos').submit();
});

</script>

