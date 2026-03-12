<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<%
enlace_base = "https://www.propertyweb.eu/articulos/"

if request.QueryString("f")="" then 
	pFecha=date
	'response.Write("Falta f=FECHA<hr>")
else
	pFecha=request.querystring("f")
end if

select case weekday(pFecha)
case 1
	txtFecha = "domingo"
case 2
	txtFecha = "lunes"
case 3
	txtFecha = "martes"
case 4
	txtFecha = "mi&eacute;rcoles"
case 5
	txtFecha = "jueves"
case 6
	txtFecha = "viernes"
case 7
	txtFecha = "s&aacute;bado"
end select
txtFecha = FormatDateTime(pFecha, 1)
%>
<%
'dim busqueda
dim origen

dim bloque
dim strin
dim ErrMesage
'dim titulo  
dim num_titulo
dim apart
dim seccion2

Set resultado = Server.CreateObject("ADODB.Recordset")

public enlace
public target
public hoy

dim apart_primero

set xvideo = Server.CreateObject("ADODB.Recordset")
sqlvideo = "SELECT * FROM VideosLists where Mailing=1 ORDER BY fecha DESC"
xvideo.Open sqlvideo, session("connPW")	',1,1


%>
<!--#include virtual="/mailing/flash/lib.asp" -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Property Web Flash - <%= pFecha %></title>
    
<style type="text/css">
  body {margin: 0; padding: 0; min-width: 100%!important;}
  
   body {font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    line-height: 1.42857143;
    color: #141414;
    background-color: #f7f7f7;}
	
	/*table { border-collapse:collapse; }table-layout:fixed;*/
	
  img {height: auto; border: 0px;}
  .content {width: 100%; max-width: 970px;}
  .bloque {
  
    background-color: #ffffff;
    border: 1px solid #efefef;
    font-size: 13px;
    text-align: left;
/*    padding: 20px;
    padding-top: 6px;*/
    box-shadow: 1px 2px 1px #b8bcbf;
    margin-bottom: 5px;
    border-radius: 0px 0px 9px 9px;
    -moz-border-radius: 0px 0px 9px 9px;
    -webkit-border-radius: 0px 0px 9px 9px;
	border-top: 2px solid #90A8BB;  
	margin-top: 12px;
}
  
    .line{border-top: dotted 1px #90A8BB; font-size:12px}
  
	.nacional {
		display:inline-block;
		width:70px;
		/*    text-align: left;*/
			padding-left:3px;}
  
h2.tit_box {
    color: #FF6802;
    font-size: 20px;
    margin-bottom: 4px;
    border-bottom: 2px solid #90A8BB;
    margin-bottom: 0px;
    line-height: 22px;
    padding: 7px 7px 3px 5px;
    border-radius: 5px 5px 0px 0px;
}
  
h3.tit_buscadores2{
    color: #195677;
    font-size: 17px;
    margin-bottom: 5px;
    margin-top: 7px;
	}

.contenido{font-size: 12px;
    border-radius: 9px;
    -moz-border-radius: 9px;
    -webkit-border-radius: 9px;
    text-align: left;}

.bloque .enlace{ padding-top: 2px;
    padding-bottom: 6px;}
.bloque .cuadro { width:22px; text-align:left}
.bloque a{ text-decoration: none; color:#333; }	
.bloque a:hover{color:#FF6802}	

.btnAzul{
    display: inline-block;
    padding: 6px 12px;
    margin-bottom: 0;
    font-size: 14px;
    font-weight: normal;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;
    background-color: #2B4E61;
    color: #FFF;
	}
	
	/*
	@media only screen and (min-device-width: 601px) {
    .content {width: 970px !important;}
    .col425 {width: 425px!important;}
    .col380 {width: 380px!important;}
    }*/

</style>
</head>
<body yahoo bgcolor="#f7f7f7" style=" font-family:Arial, Helvetica, sans-serif">
<form method="get" action="https://www.propertyweb.eu/articulos/" target="_blank">
<input type="hidden" name="origen" value="DailyFlash" />
<input type="hidden" name="f" value="<%= pFecha %>" />
<table width="100%" bgcolor="#f7f7f7" border="0" cellpadding="0" cellspacing="0">

  <td align="center">
    <!--[if (gte mso 9)|(IE)]>
      <table width="970" align="center" cellpadding="0" cellspacing="0" border="0">
        <tr>
          <td>
    <![endif]-->     
    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="width: 100%; max-width: 970px;">
        <tr>
            <td><!--1-->
            	<img src="/_inc/javier/mailing/cabecera-xxx.jpg" usemap="#cabecera" border="0" /><!--cabecera-sin.gif -->
            </td>
</tr>
    
		<tr><!--2-->
			<td style=""><!--2-->
<table width="100%" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" style="width: 100%;">

    <tr>
        <td align="left" style="font-size:16px; line-height:1.6em;padding-left: 16px;padding-top: 10px;padding-bottom: 10px; border-bottom: 1px solid #efefef;" colspan="3">
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:9px;left:3px;"><span style="color:#2b4e61;font-size:18px;">PW</span> es el <span style="color:#2b4e61;">"Google Inmobiliario"</span> y un contacto central entre todos los <span style="color:#2b4e61;">"players"</span> en el mercado español.<br>
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:9px;left:3px;"><span style="color:#2b4e61;font-size:18px;">PW</span> es el registro no oficial de las transacciones en el mercado inmobiliario terciario de España desde 1990.<br>
<img src="/img/imagotipo_naran.png" style="position:relative;bottom:9px;left:3px;"><span style="color:#2b4e61;font-size:18px;">PW</span> es el registro de propietarios, edificios, centros comerciales, hoteles, etc... con un histórico con gráficos, etc... desde 1990.    <br><br>


</tr>
<tr>
 <td>
  <a href="https://www.catella.com/" target="_blank" ><img src="BannerPW.png" align="right"/></a> 
  <br>
 </td>
 <td>
  <a href="https://www.dracorion.com/" target="_blank" ><img src="publi1.png" align="right"/></a> 
  <br>
 </td>
 <td>
  <a href="https://www.malcolmhollis.com/" target="_blank" ><img src="MHPropertyWebLogo-300x150.jpg" align="right"/></a> 
  <br>
 </td>
</tr>
<tr>
<td align="left" style="font-size:16px; line-height:1.6em;padding-left: 16px;padding-top: 10px;padding-bottom: 10px; border-bottom: 1px solid #efefef;" >
<a href="https://youtu.be/<%= xvideo("link") %>"><img src="video03.png" style="margin:" ></a>   
<br>
<span style="color:#2b4e61;font-size:18px;">Andy da las calves de Hoy en vivo!</span>
<br>
</td>
</tr>
</table>

			</td><!--2 :: -->
		</tr> <!--2 :: -->  
    
        <tr><!--3-->
        	<td ><!--3 style="padding:14px"-->
            
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="contenido">
    <tr><!--3-->
    	<td  valign="top" style="width: 50%; padding:14px "><!--3.1 izquierda-->
                    
<!-- ACTUALIDAD -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     <img src="/_inc/javier/mailing/boloH1.gif"  /> PW News Summary 
     </caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/actualidad.asp" --></td>
	</tr>

</table>
<!-- ACTUALIDAD : FIN -->
    
<!-- VENCIMIENTOS -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Vencimientos de Contrato</caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/vencimientos.asp" --></td>
	</tr>
</table>
<!-- VENCIMIENTOS : FIN -->
 
<!-- EASYPROPERTY -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Ofertas</caption>
     <tr>
     	<td style="padding:16px; padding-top:6px">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" style="width: 100%">
    <tr>
        <td align="right" style="width: 236px">
            <a href="https://www.easyproperty.es" target="_new"><img src="/img/logos/easylogo.png" width="236" height="66" style="border: 0px;"></a>
            <span style="font-size:11px;"><a href="https://www.easyproperty.es" target="_new" >acceso gratuito</a></span>
        </td>
        <td style="font-size:11px; padding-left:15px">
            <p>Publica totalmente gratis <br>
            tus <strong>anuncios</strong> y <strong>ofertas</strong></p>
            <p style="font-size:11px;"><a href="mailto:anuncios@easyproperty.es?Subject=EasyProperty - publicar anuncio" style="color:#F47C04;"><strong>Haz click aquí</strong></a></p>
        </td>
    </tr>
</table>
		</td>
	</tr>
    
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/easyproperty.asp" --></td>
	</tr>
</table>
<!-- EASYPROPERTY : FIN -->

        </td><!--3.1  :: -->
        
        <td valign="top" style="width: 50%; padding:14px  "><!--3.2 derecha-->
                    
<!-- RUMORES -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Web ha o&iacute;do... y &quot;New Business&quot;
     </caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/rumores.asp" --></td>
	</tr>
</table>
<!-- RUMORES : FIN -->

<!-- DEAL ANALYSIS -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Deal Analysis
     </caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/operaciones.asp" --></td>
	</tr>
</table>
<!-- DEAL ANALYSIS : FIN -->

<!-- t4ac -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Time4aChange<img src="https://www.propertyweb.eu/img/logos/logoT4AC.png" width="45" align="right"></caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/t4a.asp" --></td>
	</tr>
</table>
<!-- t4ac : FIN -->

<!-- ESTUDIOS -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Estudios de Mercado</caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/estudios.asp" --></td>
	</tr>
</table>
<!-- ESTUDIOS : FIN -->

<!-- SUBASTAS -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Subastas/Concursos</caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/subastas.asp" --></td>
	</tr>
</table>
<!-- SUBASTAS : FIN -->

<!-- DEMANDAS  -->
<table width="100%" bgcolor="#fff" border="0" cellpadding="0" cellspacing="0" class="bloque" >
     <caption align="top" style="font-size:21px; color:#FF6802; text-align:left; font-family:Verdana, Geneva, sans-serif">
     	<img src="/_inc/javier/mailing/boloH1.gif"  /> Demandas</caption>
     <tr>
     	<td style="padding:16px; padding-top:6px"><!--#include virtual="/mailing/flash/demandas.asp" --></td>
	</tr>
</table>
<!-- DEMANDAS : FIN -->
                    
    	</td><!--3.2 ::-->
    </tr>
</table>
         
        	</td>
        </tr>
 
        <tr><!--4-->
            <td align="center" style="padding: 5px" >
            	<input type="submit" class="btnAzul" value="Leer art&iacute;culos seleccionados">
            </td>
        </tr>
        
        <tr><!--5-->
			<td><img src="/_inc/javier/mailing/footer.gif" usemap="#footer"  border="0" /></td>
        </tr>
	</table>
    
    <!--[if (gte mso 9)|(IE)]>
          </td>
        </tr>
    </table>
    <![endif]-->
    </td>
  </tr>
</table>
</form>
<!--analytics-->



<map name="cabecera" id="cabecera">
  <area shape="rect" coords="3,2,305,122" href="https://www.propertyweb.eu/" />
  <area shape="rect" coords="0,123,144,220" href="https://www.propertyweb.eu/flash/" />
  <area shape="rect" coords="147,123,297,221" href="https://www.propertyweb.eu/presenta/" />
  <area shape="rect" coords="307,0,520,242" href="https://www.propertyweb.eu/" /> 
    
  <area shape="rect" coords="524,37,681,61" href="https://www.propertyweb.eu/dealanalysis/" />
  <area shape="rect" coords="524,61,681,86" href="https://www.propertyweb.eu/actualidad/" />
  <area shape="rect" coords="524,86,681,110" href="https://www.propertyweb.eu/estudios/" />
  <area shape="rect" coords="524,110,681,134" href="https://www.propertyweb.eu/inversores/" />  
  <area shape="rect" coords="524,134,681,157" href="https://www.propertyweb.eu/demandas/" />  
  <area shape="rect" coords="524,157,711,180" href="https://www.propertyweb.eu/vencimientos/" />  
  <area shape="rect" coords="524,180,681,203" href="https://www.propertyweb.eu/subastas/" />
  
  <area shape="rect" coords="524,203,692,241" href="https://www.easyproperty.es/" />
  
  <area shape="rect" coords="699,0,978,148" href="mailto://comercial@propertyweb.eu?subject=Consulta sobre los Servicios de Property Web" />
  
  <area shape="rect" coords="731,181,915,216" href="#" />
  <area shape="rect" coords="731,150,914,181" href="#" />
  </map>
  
  

<map name="footer" id="footer">
    <area shape="rect" coords="23,7,338,74" href="#" />
    <area shape="rect" coords="341,7,641,74" href="#" />
    <area shape="rect" coords="644,7,959,74" href="#" />
    
    <area shape="rect" coords="19,156,193,227" href="#" />
    <area shape="rect" coords="280,161,333,222" href="#" />
    <area shape="rect" coords="383,160,554,217" href="#" />
    
    
    <area shape="rect" coords="56,246,228,273" href="#" />
    <area shape="rect" coords="232,246,395,273" href="#" />
    <area shape="rect" coords="398,245,508,273" href="#" />
    <area shape="rect" coords="512,245,693,273" href="#" />
    
    <area shape="rect" coords="56,272,143,298" href="#" />
    <area shape="rect" coords="148,272,411,298" href="#" />
    <area shape="rect" coords="417,272,583,298" href="#" />
    
    <area shape="rect" coords="56,297,554,333" href="#" />
    
    
    
</map>
</body>
</html>
<!--<table width="100%" bgcolor="#f6f8f1" border="0" cellpadding="0" cellspacing="0" style="width: 100%; max-width: 970px;">
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>-->



<% sub Titulo(byRef pRS)	
	IF len(resultado("TITULO"))<3 OR isnull(resultado("TITULO")) THEN 
		response.write pRS("TITULO_AUX")
	ELSE
		response.write pRS("TITULO")
	END IF
end sub %>


