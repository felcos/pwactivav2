<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb </title>
<!--#include virtual="/inc/head.asp" -->
<!--include virtual="/_inc/javier/inc_head.asp" -->



<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">
<link href="/inc/slideshow/slideshow_javier.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--include virtual="/_inc/javier/header.asp" -->
<!--#include virtual="/inc/body-header.asp" -->

<div class="container">

<div id="result" class="caja">
        	
<div class="inm_tbl cabecera">
    <div class="inm_row">
        <div class="inm_contador"></div>   
        <div class="inm_nombre"><span>Dirección / inmueble</span></div>
        <div class="inm_tipo"><span>tipo</span></div>
        <div class="inm_ubic"><span>localidad</span></div>
        <div class="inm_caja-disp"> 
          <span class="inm_disp_disp">disponibilidad</span>
            <div class="inm_disp_min"><span>min.</span></div>
            <div class="inm_disp_max"><span>max.</span></div>
            <div class="inm_disp_fecha">@ fecha</div>
            <div class="inm_pais"></div>
        </div>
    </div>
</div>
	
  
    
    
    <div class="inm_tbl">
    
    
    
<div class="inm_row">
	<div class="inm_check">
<form class="pagsum_detalle" id="frm1" method="post" action="/info/inmueble/">
	<input type="hidden" name="frmInfo_tipo" value="edif">
	<input type="hidden" name="frmInfo_busq" value="azca">
    <input type="hidden" name="seltipo" value="inmueble">
    <!-- input type="hidden" name="tipo" value="< %= request.Form("tipo") %>" -->
    
        <input type="hidden" name="id_edificio" value="522">
        <input type="hidden" name="edificio" value="TORRE AZCA">
        <input type="hidden" name="calle" value="">
        <input type="hidden" name="numerocalle" value="">
        <input type="hidden" name="d" value="">
        <input type="hidden" name="l" value="MADRID">
        
    
</form>
    </div>
<a href="../inmueble" onclick="$('#frm1').submit();return false;">
    <div class="inm_contador">1</div>
    <div class="inm_nombre">TORRE AZCA</div>
    <div class="inm_tipo">MIXTO</div>
    <div class="inm_ubic">MADRID</div>
    
    <div class="inm_disp_min"></div>
    <div class="inm_disp_max"></div>
    <div class="inm_disp_fecha"></div>
    
    <div class="inm_pais"><img src="/img/paises/32/1.png" height="14"></div>
</a>
</div>

<div class="inm_row">
	<div class="inm_check">
<form class="pagsum_detalle" id="frm2" method="post" action="/info/inmueble/">
	<input type="hidden" name="frmInfo_tipo" value="edif">
	<input type="hidden" name="frmInfo_busq" value="azca">
    <input type="hidden" name="seltipo" value="inmueble">
    <!-- input type="hidden" name="tipo" value="< %= request.Form("tipo") %>" -->
    
        <input type="hidden" name="id_edificio" value="1085">
        <input type="hidden" name="edificio" value="SOLLUBE">
        <input type="hidden" name="calle" value="CARLOS TRIAS BELTRAN">
        <input type="hidden" name="numerocalle" value="7">
        <input type="hidden" name="d" value="CARLOS TRIAS BELTRAN 7">
        <input type="hidden" name="l" value="MADRID">
        
    
</form>
    </div>
<a href="../inmueble" onclick="$('#frm2').submit();return false;">
    <div class="inm_contador">2</div>
    <div class="inm_nombre">CARLOS TRIAS BELTRAN 7, SOLLUBE</div>
    <div class="inm_tipo">OFICINAS</div>
    <div class="inm_ubic">MADRID</div>
    
    <div class="inm_disp_min">90</div>
    <div class="inm_disp_max">1.493</div>
    <div class="inm_disp_fecha">16/04/2015</div>
    
    <div class="inm_pais"><img src="/img/paises/32/1.png" height="14"></div>
</a>
</div>

<div class="inm_row">
	<div class="inm_check">
<form class="pagsum_detalle" id="frm3" method="post" action="/info/inmueble/">
	<input type="hidden" name="frmInfo_tipo" value="edif">
	<input type="hidden" name="frmInfo_busq" value="azca">
    <input type="hidden" name="seltipo" value="inmueble">
    <!-- input type="hidden" name="tipo" value="< %= request.Form("tipo") %>" -->
    
        <input type="hidden" name="id_edificio" value="4519">
        <input type="hidden" name="edificio" value="CASTELLANA 77">
        <input type="hidden" name="calle" value="CASTELLANA">
        <input type="hidden" name="numerocalle" value="77">
        <input type="hidden" name="d" value="CASTELLANA 77">
        <input type="hidden" name="l" value="MADRID">
        
    
</form>
    </div>
<a href="../inmueble" onclick="$('#frm3').submit();return false;">
    <div class="inm_contador">3</div>
    <div class="inm_nombre">CASTELLANA 77</div>
    <div class="inm_tipo">OFICINAS</div>
    <div class="inm_ubic">MADRID</div>
    
    <div class="inm_disp_min">880</div>
    <div class="inm_disp_max">12.320</div>
    <div class="inm_disp_fecha">01/05/2015</div>
    
    <div class="inm_pais"><img src="/img/paises/32/1.png" height="14"></div>
</a>
</div>


<div class="inm_row">
	<div class="inm_check">
<form class="pagsum_detalle" id="frm24" method="post" action="/info/direccion/">
	<input type="hidden" name="frmInfo_tipo" value="edif">
	<input type="hidden" name="frmInfo_busq" value="azca">
    <input type="hidden" name="seltipo" value="zona">
    <!-- input type="hidden" name="tipo" value="< %= request.Form("tipo") %>" -->
    
        <input type="hidden" name="zona" value="AZCA">
        
    
</form>
    </div>
<a href="../zona" onclick="$('#frm24').submit();return false;">
    <div class="inm_contador">24</div>
    <div class="inm_nombre">AZCA</div>
    <div class="inm_tipo">BARRIO</div>
    <div class="inm_ubic">MADRID</div>
    
    <div class="inm_disp_min">&nbsp;</div>
    <div class="inm_disp_max">&nbsp;</div>
    <div class="inm_disp_fecha">&nbsp;</div>
    
    <div class="inm_pais"><img src="/img/paises/32/1.png" height="14"></div>
</a>
</div>
</div><script type="text/javascript">
		$('#timer4').html('0,078');
	</script>
        </div>

  
</div>
<!--#include virtual="/inc/body-footer.asp" -->
<!--include virtual="/_inc/javier/footer.asp" -->
</body>
</html>
