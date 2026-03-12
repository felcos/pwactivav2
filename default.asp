<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->

<% 

Actual = Now()
ActualYYYY=Year(Actual) 
ActualMM=Month(Actual) 
ActualYYYY2= (ActualYYYY * 100) + ActualMM

'estudiando cómo recibir artículos	
listaNavegar=""
if request.Form<>"" then %>
	<form action="/articulos/" method="post" id="frm_articulos">
	<% for each elto in request.Form %>
        <input type="hidden" name="<%= elto %>" value="<%= request.Form(elto) %>" />
        <input id="submit" type="submit" style="display:none;"/>
    <% next %>
    </form>
    
<% elseif request.QueryString<>"" then %>
	<form action="/articulos/" method="post" id="frm_articulos">
	<% for each elto in request.QueryString %>
        <input type="hidden" name="<%= elto %>" value="<%= request.QueryString(elto) %>" />
        <input id="submit" type="submit" style="display:none;"/>
    <% next %>
    </form>
    
<% end if %>
<% Sub AgregarValores(lista, apartado)	
	on error resume next
	if lista<>"" then
		tmpLista=split(lista,",")
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar=listaNavegar & ","
		for ii=0 to mm
			listaNavegar=listaNavegar & apartado & "=" & clng(tmpLista(ii))
			if ii <> mm then listaNavegar=listaNavegar & ","
		next
	end if
End sub %>
<% Sub AgregarVencimientos(lista)		
	on error resume next
	session("lista_vencimientos")=""
	if lista<>"" then
		tmpLista=split(lista,",")
		mm=ubound(tmpLista)
		if listaNavegar<>"" then listaNavegar = listaNavegar & ","
		listaNavegar = listaNavegar & "vencim=" & mm+1
		for ii=0 to mm
			session("lista_vencimientos") = session("lista_vencimientos") & clng(tmpLista(ii))
			if ii <> mm then session("lista_vencimientos") = session("lista_vencimientos") & ","
		next
	end if
End sub %>
<!--#include virtual="/inversores/top_inversores.asp" -->
<!DOCTYPE html>
<html lang="es">
<head>
<link href="/favicon.ico" rel="shortcut icon" type="image/x-icon"/>
<title>PropertyWeb V2</title>
<!--#include virtual="/activa-v2/inc/layout/head-v2.asp" -->
<link href="/inversores/inversores_javier.css" rel="stylesheet" type="text/css">
<link href="/inc/slideshow/slideshow_javier.css" rel="stylesheet" type="text/css">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>
<style>
  #barraaceptacion {
    display:none;
    position:fixed;
    left:0px;
    right:0px;
    bottom:0px;
    padding-bottom:20px;
    width:100%;
    text-align:center;
    min-height:40px;
    background-color: rgba(0, 0, 0, 0.5);
    color:#fff;
    z-index:99999;
}
 
.inner {
    width:100%;
    position:absolute;
    padding-left:5px;
    font-family:verdana;
    font-size:12px;
    top:30%;
}
 
.inner a.ok {
    padding:4px;
    color:#00ff2e;
    text-decoration:none;
}
 
.inner a.info {
    padding-left:5px;
    text-decoration:none;
    color:#faff00;
}
</style>

</head>
<body class="av2-body" data-av2="true">
<!--#include virtual="/activa-v2/inc/layout/header-v2.asp" -->

<main class="av2-wrapper" style="max-width: 1200px; margin: 40px auto; padding: 0 20px;">
  <section id="slogan" class="row  clearfix slogan"  >
    <div class="" style="margin-top:6px; margin-bottom: 0px;">
      <div class="frases"> 
      <img src="/img/imagotipo_naran.png"  class="imago"><span style="color:#2b4e61;font-size:18px;">PW</span> es el <span style="color:#2b4e61;">"Google Inmobiliario"</span> y un contacto central entre todos los <span style="color:#2b4e61;">&quot;players&quot;</span> en el mercado espa&ntilde;ol.<br />
      <img src="/img/imagotipo_naran.png" class="imago"><span style="color:#2b4e61;font-size:18px;">PW</span> es el registro no oficial de las transacciones en el mercado inmobiliario terciario de Espa&ntilde;a desde 1990.<br />
       <img src="/img/imagotipo_naran.png" class="imago"><span style="color:#2b4e61;font-size:18px;">PW</span> es el registro de propietarios, edificios, centros comerciales, hoteles, etc... con un histórico con gráficos, etc... desde 1990. <br />
     

    </div>
  </section>
  
    <br>
    
    <!-- Widget de Inteligencia Artificial (Carga asíncrona) -->
    <div class="row">
        <div class="col-md-12">
            <!--#include virtual="/activa-v2/inc/components/ai-briefing.asp"-->
        </div>
    </div>
    
  <section id="graficas2" class="row">

  <div class="col-md-12">
    <div class="row visto">
      <div class="col-md-9">
        <div class="cajaInterior" style="background-image: linear-gradient(to right, #011e46 , #2b4e78);">
          <iframe src="/informe_takeup/defaultm.asp" style="border: 0px;background-image: linear-gradient(to right, #011e46 , #2b4e78);" width="100%" height="416px" scrolling="Yes" ></iframe>
        
        </div>
      </div>
      <div class="col-md-3">
        <div class="cajaInterior" style="background-color:#dce3e8;">
         
          <iframe src="/informe_takeup/donut04m.asp" style="border: 0px;background-color: #dce3e8;;" width="100%" height="208px" scrolling="No" ></iframe>
          <img src="/informe_takeup/leyenda3.png" style="border: 0px;background-color: #dce3e8;margin-left: -5px;"   ></img>
        </div>
      </div>

    </div>
  </div>


  </section>
  <br>

  <section id="graficas3" class="row">

    <div class="col-md-12">
      <div class="row visto">
        <div class="col-md-9">
          <div class="cajaInterior" style="background-image: linear-gradient(to right, #091e36 , #2a5788);">
            <iframe src="/informe_takeup/defaultb.asp" style="border: 0px;background-image: linear-gradient(to right, #091e36 , #2a5788);" width="100%" height="416px" scrolling="Yes" ></iframe>
          
          </div>
        </div>
        <div class="col-md-3">
          <div class="cajaInterior" style="background-color:#dce3e8;">
            <iframe src="/informe_takeup/donut04b.asp" style="border: 0px;background-color: #dce3e8;" width="100%" height="208px" scrolling="No" ></iframe>
           
            <img src="/informe_takeup/leyenda3.png" style="border: 0px;background-color: #dce3e8;margin-left: -5px;"   ></img>
          </div>
        </div>
  
      </div>
    </div>
  
  
  </section>
  <br>

  <section id="resumen" class="row">
    <div class="col-md-12">
    <div class="col-md-8">
      <div class="row visto">
        <div class="col-md-6">
          <div class="cajaInterior">
            <h1 class="titu_lomas">Lo <span style="color:orange;font-size:30px;font-weight:bold;">+</span> visto de ayer</h1>
            <!--#include virtual="/inc/mas_vistos/ayer.asp" --> 
          </div>
        </div>
        <div class="col-md-6">
          <div class="cajaInterior">
            <h1 class="titu_lomas">Lo <span style="color:orange;font-size:30px;font-weight:bold;">+</span> visto de la semana</h1>
            <!-- #include virtual="/inc/mas_vistos/semana.asp" --> 
          </div>
        </div>
      </div>
    </div>
    <!--fin md-8-->
    <div class="col-md-4">
      <div class="inversores">
        <h2 class="" >Inversores m&aacute;s activos <span style="float:right;">a&ntilde;o <% =ActualYYYY %> </span></h2>
        <div><% call TopInversores("es") %></div>
        <div style="margin-top:.6em;"><% call TopInversores("eu") %></div>
      </div>
    </div>
  </div>
  </section>

  <br>
  <section id="tarifa_plana" class="row clearfix" style="background-color:#2B4E61;">
    <a href="/presenta/?p=tarifas" class="" target="_blank"     style="display: block;">
        <img src="/img/tarifa_plana_coste.jpg" style="margin-bottom:0;max-width: 100%;
      height: auto;" class="grid-full">
        </a>
      <!-- <div class="grid-full" align="right" style="margin-top:0;"><a href="/presenta/" class="btn">ver presentaci&oacute;n</a></div -->
  </section>

  <section id="publicidad" class="clearfix">
      <div class="row">
        <div class="caja">
              <h2 class="sabermas"><img src="/img/imagotipo_naran.png">
                  <a href="/demandas/nueva.asp">PW Quiere saber, &iquest;qu&eacute; buscas? &iquest;qu&eacute; necesitas?</a></h2>
              </span>
              <div class="colum_index_uno" style="text-align:justify;font-size:1;">
                  <img src="/img/background.jpg" style="float:left;margin-right:10px;margin-top:5px;" width="200">
                  &iquest;Quieres destacar una noticia?, &iquest; o contarnos un &quot;cotilleo&quot;? &iquest;o darnos una oferta? <br>
                  
                  &iquest;Has cambiado de empresa o quieres contarnos una operaci&oacute;n? o &iquest;buscas algo?<br><br>
                  PW es "el punto central de contacto" en el mercado y utilizado por la mayor&iacute;a de los players.<br><br>
                  <span style="float:right;"><a href="mailto:andyg@propertyweb.eu" class="btn gris">haz click aqu&iacute;</a></span>
              </div>
          
              <div style="clear:both;"></div>
      </div>
    </div>
      
      <div class="row">
  <div class="caja" align="center">
  <a href="/pw/contacto.asp"><img src="/img/baner_quierestrabajar.jpg" style="margin:auto 15px;"></a>
  <a href="/pw/contacto.asp"><img src="/img/baner_franquicia.png" style="margin:auto 15px;"></a>
  <a href="/pw/contacto.asp"><img src="/img/baner_quierestrabajar.png" style="margin:auto 15px;"></a>
  <a href="/pw/contacto.asp"><img src="/img/baner_tv_220x.jpg" style="margin:auto 15px;"></a>
  </div>
    </div>

      <div class="row">
        <div class="caja" style="text-align:center;">
  <a href="https://www.cushwake.com" target="_blank"><img src="/img/banners/cw.jpg" alt="Cushman &amp; Wakefield" style="width:150px; margin:auto 30px;"></a>
  <a href="https://www.gleeds.com/en/" target="_blank"><img src="/img/banners/gleeds.png" alt="Gleeds" style="width:150px; margin:auto 30px;"></a>
  <a href="https://www.dracorion.com/" target="_blank"><img src="/img/banners/dracorion.jpg" alt="Savills" style="width:150px; margin:auto 30px;"></a>
  <a href="https://www.simmons-simmons.com/" target="_blank"><img src="/img/banners/simmons.gif" alt="Simmons" style="width:150px; margin:auto 30px;"></a>
  <a href="https://www.catella.com" target="_blank"><img src="/img/banners/BannerPW.png" alt="Catella" style="width:150px; margin:auto 30px;"></a>
          </div>
      </div>
  </section>

  
</div>
<!--//BLOQUE COOKIES-->
<div id="barraaceptacion" style="display: block;">
  <div class="inner">
      Solicitamos su permiso para obtener datos estadísticos de su navegación en esta web, en cumplimiento del Real 
      Decreto-ley 13/2012. Si continúa navegando consideramos que acepta el uso de cookies.
      <a href="javascript:void(0);" class="ok" onclick="PonerCookie();"><b>OK</b></a> | 
      <a href="https://politicadecookies.com" target="_blank" class="info">Más información</a>
  </div>
</div>

<script>
  if(getCookie('pw_lodp')!="1"){
  document.getElementById("barraaceptacion").style.display="block";
}

function getCookie(c_name){
  var c_value = document.cookie;
  var c_start = c_value.indexOf(" " + c_name + "=");
  if (c_start == -1){
      c_start = c_value.indexOf(c_name + "=");
  }
  if (c_start == -1){
      c_value = null;
  }else{
      c_start = c_value.indexOf("=", c_start) + 1;
      var c_end = c_value.indexOf(";", c_start);
      if (c_end == -1){
          c_end = c_value.length;
      }
      c_value = unescape(c_value.substring(c_start,c_end));
  }
  return c_value;
}

function setCookie(c_name,value,exdays){
  var exdate=new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  document.cookie=c_name + "=" + c_value;
}


function PonerCookie(){
  setCookie('pw_lodp','1',365);
  document.getElementById("barraaceptacion").style.display="none";
}
</script>
</main>
<!--#include virtual="/activa-v2/inc/layout/footer-v2.asp" -->
</body>
</html>
