<%'@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
pasa = false

if request.Cookies("dev")<>"" then pasa=true
if request.Cookies("licencia")("client_id")="1" then pasa=true
if request.Cookies("licencia")("client_id")="2" then pasa=true

if not(pasa) then response.Redirect("/")
%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="utf-8">
	<title>PropertyWeb - Admin</title>
    <!--#include virtual="/inc/head.asp" -->
    
    <link href="/admin/accesos/accesos.css" rel="stylesheet" type="text/css">
    <link href="/css/css-pags/tabs02.css" rel="stylesheet" type="text/css">
<%
'server.ScriptTimeout=300
f_hasta = dateadd("d", -1, date)
f_desde = dateadd("d", -1, f_hasta)
%>
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_header" class="row">
    <div class="col-md-8 caja">
     	<h1 class="heading">Clientes que no Acceden</h1>
    </div>
	
    <div class="col-md-4">
        <div class="col-md-10">
            <form id="frm_accesos" name="frm_accesos" action="" method="post" autocomplete="off" target="_blank">
                desde hace:&nbsp;
                <select name="ver" id="ver" onChange="$('#frm_accesos').submit();">
                    <option value="7d">7 d&iacute;as</option>
                    <option value="15d" selected>15 d&iacute;as</option>
                    <option value="1m">1 mes</option>
                    <option value="3m">3 meses</option>
                    <option value="6m">6 meses</option>
                    <option value="1y">1 a&ntilde;o</option>
                </select>
            </form>
        </div>
        <div class="col-md-2"><a href="/admin/clientes/no-acceden.asp">reset</a></div>
    </div>
    
</section>

<section id="s_datos" class="row">
    <div class="col-md-12 caja">
        <div id="DealTabs">
            <ul class="nav nav-tabs submenu lineNavs" style="" id="">
                <li class="active"><a href="#tbl_clientes" data-toggle="tab" aria-expanded="true">Clientes</a></li>
                <li><a href="#tbl_licencias" data-toggle="tab" aria-expanded="false">Licencias</a></li>
            </ul>
            <div class="tab-content">
                
                <div id="tbl_clientes" class="tab-pane active"><img src="/img/camera-loader.gif" width="30" height="30"></div>
                
                <div id="tbl_licencias" class="tab-pane"></div>
                
            </div>
        </div>
    </div>
    
</section>

</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
<script type="text/javascript">
	var serie_articulos_distintos=new Array();
	var serie_articulos=new Array();
	
	var start;

	
$(document).ready(function(){
	

	// formulario
	$('#frm_accesos').submit(function(){ 
		
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/clientes/datos/no-acceden-clientes.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {},
			success: function(data, status, xhr){
				//$('#tbl_clientes > tbody:last').append(data)
				$('#tbl_clientes').html(data)
			},
			error: function(xhr, status, err) {
				//alert(status + ": " + err);
				//destino.html(status + ": " + err);
			}
		});
		
		$.ajax({
			//type: 'get',
			//async: false,
			url: '/admin/clientes/datos/no-acceden-licencias.asp',
			data: $('#frm_accesos').serialize(),
			beforeSend: function() {},
			success: function(data, status, xhr){
				//$('#tbl_licencias > tbody:last').append(data)
				$('#tbl_licencias').html(data)
			},
			error: function(xhr, status, err) {
				//alert(status + ": " + err);
				//destino.html(status + ": " + err);
			}
		});
		
		return false;
	});
	
	// ini
	$('#frm_accesos').submit();
	
});

</script>

