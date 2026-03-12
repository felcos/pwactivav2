<link rel="stylesheet" href="/_inc/jm/header.css" type="text/css" media="screen" />
<script src="/_inc/jm/prefixfree.jquery.js"></script>
<div id="centrado">
<% if session("navegador")="old" then %>
  <img src="/_inc/jm/header.gif" width="980" height="192" border="0" usemap="#Map" />
  <map name="Map" id="Map">
    <area shape="rect" coords="0,19,304,134" href="/" />
    <area shape="rect" coords="29,144,136,182" href="/flash" />
    <area shape="rect" coords="145,147,291,181" href="/presenta/" target="_blank" />
    <area shape="rect" coords="362,130,412,195" href="/actualidad/" />
    <area shape="rect" coords="418,133,463,196" href="/dealanalysis/" />
    <area shape="rect" coords="468,134,518,195" href="/inversores/" />
    <area shape="rect" coords="527,130,577,194" href="/demandas/" />
    <area shape="rect" coords="579,120,630,190" href="/vencimientos/" />
    <area shape="rect" coords="634,121,685,189" href="/estudios/" />
    <area shape="rect" coords="687,120,738,191" href="/info/inmuebles/" />
    <area shape="rect" coords="741,121,795,194" href="/info/empresas/" />
    <area shape="rect" coords="798,123,848,195" href="/subastas" />
    <area shape="rect" coords="660,47,796,95" href="https://www.rcanalytics.com/" target="_blank" />
    <area shape="rect" coords="834,61,974,93" href="https://www.rics.org/" target="_blank" />
    <area shape="rect" coords="823,8,880,52" href="/pw/contacto.asp" />
    <area shape="rect" coords="889,10,974,53" href="/acceso/registro.asp" />
    
  </map>
<% else %>
	
  <div style="float:right; margin-top:9px;">
  	<% if request.Cookies("dev")="" then %>
    	<span style="position:relative;right:12px;font-size:12px;">&nbsp;Contacto</span>
        <img src="/img/baner_telefono.png" style="position: relative;top: 15px;right: 8px;"> &nbsp; 
        <a href="/pw/contacto.asp" class="drop" style="font-size:11px;font-family:ruda;"><img src="/img/contact.png" style="position:relative;top:10px"></a>
        &nbsp; &nbsp; &nbsp;
        <a href="/acceso/licencia.asp" class="simplemodal" style="font-size:11px;font-family: ruda;"><img src="/img/acceso.png" style="position:relative;top:10px">&nbsp;licencia</a>
        <div style="height:10px;"></div>
        
        <div style="float:right; position:relative; top:-12px;">
            <a href="https://www.rcanalytics.com/" target="_blank"><img src="/img/Real-Capital-Analytics-banner.jpg" width="120" style="position: relative;top: 5px;right:57px;margin-left: 5px;"></a>
        <span style="position:relative;right:10px;font-size:12px;">Miembro de</span><a href="https://www.rics.org" target="_blank"><img src="/img/rics.png" width="52" style="position: relative;top: 5px;right:1px;margin-left: 5px;"></a></div>        
    <% else %>
    	<span style="font-size:9px; text-align:right; float:right"><!--#include virtual="/inc/dev-menu.asp" --></span>
    <% end if %>
  </div>
  

  <header>
        <section>
            <div id="cabecera">
            
    <!--include virtual="/inc/menu_cabecera.asp" -->
    
    <div id="logo">
        <a href="https://www.propertyweb.eu"><img src="/_inc/jm/img/logo.png" style="position: relative;top: 19px;"/></a>
    </div>
    
       <div> <img src="/_inc/jm/img/menu_buscadores.gif" style="position:relative;float:right; bottom: 16px;"></div>
    
    
    
    <!-- quitado: <div id="btn_lateral"></div> -->
    
    <% if 1=2 then	' session("ArticulosSeleccionados")<>"" then %>
    <div style="display:none ;position:absolute; top:75px; left:25px; z-index:100; opacity:1; text-align:left;" id="div_articulos_seleccionados" name="div_articulos_seleccionados">
        <a href="/articulos/" class="simplemodal"><img src="/img/articulos_seleccionados.png"><br />
        <img src="/img/indicador.png" style="position:absolute;" ></a>
    
    </div>
    <% end if %>
    
    
    <!-- Menu principal-->
    <img src="/img/linea_menu_blanca.png" style="position: relative;left: 140px;top: 45px; visibility:hidden;">
    <ul id="menu" style="background-repeat: repeat-x;">
    <li><a href="/flash" class="drop" style="position:relative; left:10px;"><img src="/img/imagotipo_naran.png" style="position:relative;bottom:8px;left:3px;">PW Semana&nbsp;&nbsp;<img src="/img/drop_naranja.png"></a>
    
    
    <li><a href="/presenta/" target="_blank" class="drop" style="position:relative;">Presentaci&oacute;n<img src="/img/imagotipo_naran.png" style="position:relative;bottom:8px;left:3px;">PW&nbsp;&nbsp;<img src="/img/drop_naranja.png"></a>
    
    
    
    
    <!-- Fin de contenedor a 5 columnas -->
    </li><!-- Fin del articulo a 5 columnas -->
    
    
    <!--<li><a href="javascript:mostrarMiPW();" style="font-size:9px;">mi PW 2</a></li>-->
    
    <!-- Este menu se eliminara
    <li><a href="#" class="drop" style="position:relative;">PW Avanzado&nbsp;&nbsp;<img src="/img/drop.png"></a><!-- Begin Home Item   
    <div class="dropdown_2columns"><!-- Begin 2 columns container 
    <div class="col_5">  
         
    </div>
    <div id="bloque_inf">
        <div id="conten_sobre">
        <div class="col_2">
            <h2 style="font-size:15px;color:#F47C04;">info-Inmuebles</h2> 
        </div>  
        <div class="col_1">  
            <a href="/info/empresas.asp"><img src="/img/i.png" alt="" style="position:relative; left:10px;" /></a>  
        </div>
        <div class="col_1">  
            <p style="font-size:12px; position:relative;right:80px;width:240px;"><a href="/info/empresas.asp">Recopila toda la informaci&oacute;n sobre un edificio o propiedad singular con todo un hist&oacute;rico desde 1993 que incluye superficies disponibles, rentas, antiguas operaciones, inquilinos actuales,etc...</a></p>
        </div>
    </div>
    </div>
    
    
    <div id="bloque_inf">
        <div class="col_2">  
            <h2 style="font-size:15px;color:#F47C04;">Info-Empresas</h2>  
        </div>  
        <div class="col_1">  
            <a href="/info/inmuebles.asp"><img src="/img/folder.png" alt="" style="position:relative; left:10px;" /></a>  
        </div>  
        <div class="col_1">  
            <a href="/info/inmuebles.asp">
            <p style="font-size:12px; position:relative;right:80px;width:240px;">Toda la informaci&oacute;n publicada sobre las empresas de mayor inter&eacute;s en el mercado, que le proporcionar&aan ideas, puntos de vista, pistas y nuevos contactos...</p></a></p>
        </div>
    </div>
    
    <% if 1=2 then %>
    <div id="bloque_inf" style="float:right;">
        <div class="col_2">  
            <h2 style="font-size:15px;"><span class="txt_h1_naranja">Descarga</span> nuestro cat&aacute;logo</h2>  
        </div>  
        <div class="col_1">  
            <a href="/pw/tunecesitas.asp"><img src="/img/upload.png" alt="" style="position:relative; left:10px;" /></a>  
        </div>  
        <div class="col_1">  
            <p style="font-size:12px; position:relative;right:80px;"><a href="/pw/tunecesitas.asp">descubre por qu&eacute; <strong>Property Web</strong> es una herramienta imprescindible...</a></p>  
        </div>
    </div>
    <% end if %>
    
    </div><!-- End 2 columns container -->
    </li><!-- End Home Item -->
    
    
    <!--<span style="color:black;font-family:ruda;font-size:20px;position:relative;bottom: 90px;left: 50px;border-bottom:1px dashed black;">BUSCADORES&nbsp;<img src="/img/apunta.gif"></span>-->
    <div class="botones_buscadores2" style="position: relative;bottom: 38px;">
    <a href="/actualidad/" title="Actualidad Inmobiliaria"><img class="img_buscadores<% if pag_actual = "actualidad" then response.Write("_orange") %>" src="/img/menu/noticiaspw.png" width:"30" height:"35" style="position:relative;right:20px;margin-right:20px;"></a>
    <a href="/dealanalysis/" title="Deal Analysis"><img class="img_buscadores<% if sec_actual = "/dealanalysis/" then response.Write("_orange") %>" src="/img/menu/dealpw.png" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/inversores/" title="Inversores"><img src="/img/menu/inversorespw.png" class="img_buscadores<% if sec_actual = "/inversores/" then response.Write("_orange") %>" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/demandas/" title="Demandas"><img class="img_buscadores<% if pag_actual = "demandas" then response.Write("_orange") %>" src="/img/menu/demandaspw.png" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/vencimientos/" title="Posibles Vencimientos de Contrato"><img class="img_buscadores<% if sec_actual = "/vencimientos/" then response.Write("_orange") %>" src="/img/menu/vencimientospw.png" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/estudios/" title="Estudios de Mercado"><img class="img_buscadores<% if pag_actual = "estudios" then response.Write("_orange") %>" src="/img/menu/estudiospw.png" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/info/" title="Info"><img class="img_buscadores<% if sec_actual = "/info/" then response.Write("_orange") %>" src="/img/menu/infoinmueblespw.png" width:"30" height:"35" style="margin-right:20px;"></a>
    <a href="/subastas/" title="Subastas"><img class="img_buscadores<% if sec_actual = "/subastas/" then response.Write("_orange") %>" src="/img/menu/subastaspw.png" width:"30" height:"35" style="margin-right:20px;"></a>
	<a href="https://www.easyproperty.es" target="_blank" title="EasyProperty"><img class="img_easyproperty" src="/_inc/jm/img/easyproperty3.png" width:"36" height:"42" style="margin-right:20px;"></a>
    </div>
    
    <!--<div style="position:relative;bottom:48px;left:550px;color:#F47C04;">En Construcci&oacute;n</div>-->
    
    </ul>
        </div>	
        </section>
  </header>
<% end if %>
</div>
