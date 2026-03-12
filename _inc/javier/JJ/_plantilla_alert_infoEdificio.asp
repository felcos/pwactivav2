<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb</title>
<!--#include virtual="/inc/head.asp" -->
</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container"><div class="caja" style="margin-left:-15px; margin-right:">

  <div class="detalles clearfix">
    <div class="bloqueLeft slider01"> <img src="../img/slider/slider330x220-01.jpg" width="330" height="220">
      <div class="separator"></div>
    </div>
    <div class="bloqueRight ">
      <div class="alert azul">
        <div>
          <button type="button" class="close btn" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">×</span></button>
          <p>Para ver las caracteristicas del inmueble, conocer los distintos usos y superficies, la distribución de plantas, etc... debe tener contratado <strong>Info-Inmuebles</strong>.</p>
          <p style="margin-top:10px;">Póngase en <a href="#">contacto con PropertyWeb</a>.</p>
        </div>
      </div>
    </div>
  </div>
  
 <div class="row detalles">
		
        <div class="historico clearfix">
<form method="POST" id="frm_resumen" name="frm_resumen" action="/info/inmueble/articulos.asp" target="_blank">
<input type="hidden" name="frmInfo_tipo" value="edif"><input type="hidden" name="frmInfo_busq" value="AZCA"><input type="hidden" name="seltipo" value="inmueble"><input type="hidden" name="id_edificio" value="5346"><input type="hidden" name="edificio" value="COMANDANTE AZCARRAGA 5"><input type="hidden" name="calle" value="COMANDANTE AZCARRAGA"><input type="hidden" name="numerocalle" value="5"><input type="hidden" name="l" value="MADRID"><input type="hidden" name="d" value="COMANDANTE AZCARRAGA 5">

<div class="cab">
	<h3>Archivo Histórico</h3>
</div>
  


<div class="col-sm-4">
  <ul class="">
    <li class="operaciones">Operaciones:</li>
    <li>
      <span class="num">1</span>
      <input id="op_alquiler" name="op_alquiler" type="checkbox" checked="checked">
      <label for="op_alquiler">Alquiler:</label>
    </li>
    
    <li>
      <span class="num">1</span>
      <input id="op_inversion" name="op_inversion" type="checkbox" checked="checked">
      <label for="op_inversion">Inversión:</label>
    </li>
	
  </ul>
</div>
<div class="col-sm-4">
  <ul class="ul2">
    <li>
      <span class="num">1</span>
      <input id="noticias" name="noticias" type="checkbox" checked="checked">
      <label for="noticias">Noticias Inmobiliarias</label>
    </li>
      
    <li>
      <span class="num">0</span>
      <input id="rumores" name="rumores" type="checkbox" disabled="disabled">
      <label for="rumores">"Web" ha oído...: </label>
    </li>
    
    <li>
      <span class="num">0</span>
      <input id="estudios" name="estudios" type="checkbox" disabled="disabled">
      <label for="estudios">Estudios de Mercado</label>
    </li>
    
  </ul>
</div>






<div class="col-sm-4 "> <!-- PABLO!! ..si vas a quitar el boton quita esta clase  bloqBotontes -->
	<div class="alert azul">
        <div>
          <button type="button" class="close btn" data-dismiss="alert" aria-label="Close"> <span aria-hidden="true">×</span></button>
          <p>Para acceder a los contenidos del <strong>Archivo Histórico</strong> debe ser cliente</p>
          <p style="margin-top:10px;">Póngase en <a href="#">contacto con PropertyWeb</a>.</p>
        </div>
      </div>
    
</div>
</form>



  
<!--        <p style="margin-top:25px;">Para acceder a los contenidos del Archivo Histórico debe ser cliente.</p>
        <p style="margin-top:10px;">Póngase en contacto con PropertyWeb.</p>


<!-- Modal -->
<div class="modal fade" id="avisoForm" role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4 class="modal-title">Nada seleccionado</h4>
        </div>
        <div class="modal-body">
          <p>Debes seleccionar algún apartado para cargar el archivo histórico.</p>
          <p>Marca las secciones que quieras ver y vuelve a intentarlo.</p>
          <!-- 
          <div class="botones">
              <button type="button" class="btn" data-dismiss="modal">Aceptar</button>
          </div>
          -->
        </div>
        <div class="modal-footer">
          <button type="button" class="btn" data-dismiss="modal">Aceptar</button>
        </div>
      </div>
      
    </div>
</div>

</div>
        
    </div> 
  
  
  
  
  
  
  
</div></div><!-- :caja :container-->
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>
