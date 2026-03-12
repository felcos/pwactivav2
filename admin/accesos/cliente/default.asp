<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
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
	<title>PropertyWeb - DESARROLLO</title>
    <!--#include virtual="/inc/simple/head.asp" -->
    
	<script src="/lib/easyResponsiveTabs/easyResponsiveTabs.js" type="text/javascript"></script>
    <link type="text/css" rel="stylesheet" href="/lib/easyResponsiveTabs/css.css" />
    
    <link rel="stylesheet" type="text/css" href="/admin/accesos/accesos.css">
    
    <link href="/lib/datepicker/datepicker.css" rel="stylesheet" type="text/css" />
	<script src="/lib/datepicker/datepicker.js" type="text/javascript"></script>
<style>
#tab .resp-tabs-container {
	min-height:100px;
}
#tabData .resp-tabs-list li {
    width:120px;
}
form .grid-1, form .grid-2, form .grid-3, form .grid-4, form .grid-5, form .grid-6, form .grid-full {
	margin-bottom:.25em;
}
</style>
<%
u = request.QueryString("u")
l = request.QueryString("l")
uid = request.QueryString("uid")
lid = request.QueryString("lid")

old = (request.QueryString("old")<>"")

f_hasta = date
if old then
	f_desde = "01/01/2010"
else
	'f_desde = "01/01/2015"
	f_desde = date
end if

session("connPWAcesos").CommandTimeout = 120

set rs = Server.CreateObject("ADODB.Recordset")
%>
</head>
<body>
<!--#include virtual="/inc/simple/body-header.asp" -->
<div id="content">
<div class="contenedor">

<section id="s_resumen" class="cf">

	<div class="grid-4 titulo"><h1 class="heading">accesos</h1></div>
    
    <div class="grid-2 grid-flow-opposite">
<form id="frm_general" name="frm_general" action="/admin/accesos/cliente/" method="get" autocomplete="off" style="margin-top:15px;">
    <div class="grid-1"><% if l<>"" then %><a href="/admin/accesos/cliente/?uid=<%= uid %>&u=<%= u %>">cliente</a><% else %>cliente<% end if %>:</div>
    <div class="grid-5">
        <input type="text" name="u" value="<%= u %>" style="width:230px;">&nbsp;
        <input type="text" name="uid" value="<%= uid %>" style="width:45px;">
    </div>
    
    <div class="grid-1">licencia:</div>
    <div class="grid-5">
        <%
        %>
        <select name="l" style="width:234px;" id="licencia">
            <% if old then 
				%><option value="<%= l %>" selected><%= l %></option><% 
			else
				sql = "SELECT DISTINCT(NOMBRE) AS email FROM clientes_licencias WHERE ID_EMPRESA = " & uid & " GROUP BY NOMBRE ORDER BY NOMBRE"
				rs.Open sql, session("connPW") %>
				<option value="" <% if l="" then %>selected<% end if %>></option>
                <% do while not rs.eof 
                    %><option value="<%= rs("email") %>" <% if rs("email")=l then %>selected<% end if %>><%= rs("email") %></option><% 
                    rs.movenext
                loop 
				rs.close
			end if %>
        </select>&nbsp;
        
        <select name="lid" style="width:65px;" id="licencia_id" <% if old then %>disabled<% end if %>>
            <option value="" <% if lid="" then %>selected<% end if %>><% if old then %>OLD<% end if %></option>
            <% if l<>"" then 
                sql = "SELECT * FROM clientes_licencias WHERE ID_EMPRESA = " & uid & " AND NOMBRE='" & l & "'"
                rs.Open sql, session("connPW") 
                do while not rs.eof 
                    %><option value="<%= rs("id") %>" <% if cstr(rs("id"))=lid then %>selected<% end if %>><%= rs("id") %></option><% 
                    rs.movenext
                loop 
                rs.close
            end if %>
        </select>
        <% if lid<>"" then %>&nbsp;<a href="/admin/accesos/cliente/?uid=<%= uid %>&u=<%= u %>&l=<%= l %>">x</a><% end if %>
    </div>
</form>
    
<div class="grid-full" style="margin-top:15px; margin-bottom:15px; border-top:1px solid #c1c1c1;"></div>
        
<form id="frm_detalles" name="frm_detalles" action="/admin/accesos/cliente/articulos.asp" method="get" autocomplete="off" target="_blank">
    <div class="grid-4" style="margin-bottom:10px;"><strong>Detalles</strong></div>
    <div class="grid-1" style="margin-bottom:10px;"><a href="">reset</a></div>
    <div class="grid-1" style="margin-bottom:10px;"><input type="submit" value="cargar"></div>
    
    <div class="grid-1" style="margin-bottom:10px;">Per&iacute;odo:</div>
    <div class="grid-5" style="margin-bottom:10px;">
        <input type="text" name="FechaI" id="FechaI" value="<%= f_desde %>" maxlength="10" class="fecha">
        &nbsp;-&nbsp;
        <input type="text" name="FechaF" id="FechaF" value="<%= f_hasta %>" maxlength="10" class="fecha">
    </div>
    
    <div class="grid-1" style="margin-bottom:10px;"></div>
    <div class="grid-2" style="margin-bottom:10px;">t&iacute;tulos:<input name="titulos" type="checkbox" value="ver"></div>
    <div class="grid-2" style="margin-bottom:10px;"></div>
    <div class="grid-1" style="margin-bottom:10px;"></div>
    <input type="hidden" name="u" value="<%= u %>"><input type="hidden" name="uid" value="<%= uid %>">
    <input type="hidden" name="l" value="<%= l %>"><% if l<>"" then %><br><input type="hidden" name="lid" value="<%= lid %>"><% end if %>
</form>

<% if old then 
	sql = "SELECT DISTINCT(NOMBRE) AS email FROM clientes_licencias WHERE ID_EMPRESA = " & uid & " GROUP BY NOMBRE ORDER BY NOMBRE"
	rs.Open sql, session("connPW")
	%>

<div class="grid-full" style="padding-top:15px; margin-top: 10px; border-top: 1px solid #c1c1c1;"><strong>Licencia Antigua</strong></div>
<div class="grid-full caja">
<form id="frm_asignar" name="frm_asignar" action="/admin/accesos/bin/asignar_licencia.asp" method="get" autocomplete="off" target="_blank">
<input type="hidden" name="u" value="<%= u %>"><input type="hidden" name="uid" value="<%= uid %>"><input type="hidden" name="l" value="<%= l %>">
Asignar a:
<select name="destino" style="width:234px;" id="destino">
	<option value=""></option>
	<% do while not rs.eof 
        %><option value="<%= rs("email") %>"><%= rs("email") %></option><% 
        rs.movenext
    loop %>
</select>&nbsp;
<input type="submit" value="asignar">
</form>
</div>
	<% 
	rs.close
end if
%>
    </div>
    
    <div class="grid-4">
    
<div id="tab"><!--Horizontal Tab-->
    <ul class="resp-tabs-list">
        <li>Resumen</li>
        <li>Licencias</li>
        <li>Antiguas</li>
        
    </ul>
    <div class="resp-tabs-container">
        <div>
            <div id="resumen"></div>
            <div id="loading_resumen" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
        </div>    
        <div id="licencias"></div>
        <div id="licencias_ant"></div>
	</div>
</div><!--Horizontal Tab-->
    
    </div>
    
    <div style="clear:both;"></div>
    
</section>

<section id="s_datos" class="cf">

	<div class="grid-full">
<!--Horizontal Tab-->
<div id="tabData">
    <ul class="resp-tabs-list">
        <li>Acesos &nbsp;<span id="contador_accesos"></span></li>
        <li>Art&iacute;culos &nbsp;<span id="contador_articulos"></span></li>
        <li>reg &nbsp;<span id="contador_reg"></span></li>
        <li>Pags &nbsp;<span id="contador_pags"></span></li>
        <li>Navegadores</li>
    </ul>
    <div class="resp-tabs-container">
            
<div>
	
	<div id="result_accesos"></div>
</div>

<div>
	<div id="result_articulos"></div>
    <div id="loading_articulos" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div> 

<div>
	<div id="result_reg"></div>
    <div id="loading_reg" style="display:none;"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>

<div>
	
	<div id="result_pags"></div>
</div>
<div>
	<div id="resumen_navegadores"></div>
    <div id="loading_resumen_navegadores"><img src="/img/camera-loader.gif" width="30" height="30"></div>
</div>
    </div>
</div>
<!--Horizontal Tab-->
	</div>

</section>

<section id="s_result" class="cf">
    <div class="grid-full" id="result"></div>
</section>

</div>
</div>

</body>
</html>

<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
	var start;

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
	
	$("#licencia").change(function() {
		$("#licencia_id").val("");
		$("#licencia_id").attr("disabled", "disabled");
		$("#frm_general").submit();
	});
	
	// formulario
	$('#frm_detalles').submit(function(){ 
		/*
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/accesos/cliente/reg.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#loading_reg').show();
				$('#result_reg').html('');
			},
			success: function(data, status, xhr){
				$('#result_reg').html(data);
				$('#loading_reg').hide();
			},
			error: function(xhr, status, err) {}
		});
		*/
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/accesos/cliente/articulos.asp',
			data: $('#frm_detalles').serialize(),
			beforeSend: function() {
				$('#loading_articulos').show();
				$('#result_articulos').html('');
			},
			success: function(data, status, xhr){
				$('#result_articulos').html(data);
				$('#loading_articulos').hide();
			},
			error: function(xhr, status, err) {}
		});
		
		return false;
	});
	
	
	// tabs
	$('#tab').easyResponsiveTabs({
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
	
	$('#tabData').easyResponsiveTabs({
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
			
			if ($tab.text()=='Navegadores') {
				if ($('#resumen_navegadores').html()=='') {
					var datos = $('#frm_general').serialize() + "&FechaI=" + $("#FechaI").val() + "&FechaF=" + $("#FechaF").val();
					
					$.ajax({
						url: '/admin/accesos/cliente/resumen_navegadores.asp',
						data: datos,
						beforeSend: function() {
							$('#resumen_navegadores').html('');
						},
						success: function(data, status, xhr){
							$('#resumen_navegadores').html(data);
							$('#loading_resumen_navegadores').hide();
						},
						error: function(xhr, status, err) {}
					});
				}
			}
			
		}
	});
	
	/*	*/
	//resumen
	$.ajax({
		//type: 'get',
		async: true,
		url: '/admin/accesos/cliente/resumen_yy.asp',
		data: $('#frm_general').serialize(),
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
	

	//licencias
	$.ajax({
		//type: 'get',
		async: true,
		url: '/admin/accesos/cliente/licencias.asp',
		data: $('#frm_general').serialize(),
		beforeSend: function() {
			$('#licencias').html('');
		},
		success: function(data, status, xhr){
			$('#licencias').html(data);
		},
		error: function(xhr, status, err) {}
	});
	
	//licencias antiguas
	$.ajax({
		//type: 'get',
		async: true,
		url: '/admin/accesos/cliente/licencias_anteriores.asp',
		data: $('#frm_general').serialize(),
		beforeSend: function() {
			$('#licencias_ant').html('');
		},
		success: function(data, status, xhr){
			$('#licencias_ant').html(data);
		},
		error: function(xhr, status, err) {}
	});
	
});

</script>

