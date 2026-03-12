<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% call AccesoPrivado %>
<% 
if request.querystring("R1")<>"" then
	urlEnvio="/pagsum/derechaasp.asp?R1=" & request.querystring("R1")
	if request.QueryString("R2")<>"" then
		urlEnvio=urlEnvio & "-" & request.QueryString("R2")
	end if
	if request.QueryString("C1")<>"" then
		urlEnvio=urlEnvio & "&C1=" & request.QueryString("C1")
	end if
	if request.QueryString("Envio")="si" then
		urlEnvio=urlEnvio & "&envio=si"
	end if
	if request.QueryString("Flash")<>"" then
		urlEnvio=urlEnvio & "&Flash=no"
	end if
	
	'response.Redirect urlEnvio
	response.Write(urlEnvio)
end if

cFecha=date
if datepart("w", cFecha, 2)>5 then
	cFecha=dateadd("d", 5-datepart("w", cFecha, 2), cFecha)
end if
%>
<!DOCTYPE html>
<html>
<head>
	<title>PropertyWeb - DESARROLLO</title>
	<!--#include virtual="/inc/head.asp" -->
    
    <link rel="stylesheet" type="text/css" href="/_inc/foldy/forms.css">
<style>
h2.titdev {
	margin-top:.25em;
	margin-bottom:.25em;
}
</style>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-143927921-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-143927921-1');
</script>

</head>
<body>
<!--#include virtual="/inc/body-header.asp" -->
<div class="container">

<section id="s_buscador" class="row">
    <div class="caja row">
    	<div class="col-sm-8 titulo"><h1 class="heading">Mailing</h1></div>
        <% if request.Cookies("dev")<>"" then %>
        <div class="col-sm-4 dev"><b class="txtRojo">ATENCI&Oacute;N</b> : Cookie <strong>DEV</strong></div>
        <% end if %>
    </div>
</section>

<section id="s_enviar" class="row">
	<div class="caja"><!--#include virtual="/mailing/inc/enviar.asp" --></div>
</section>

<section id="s_formularios" class="row">
  <div class="row">
    
	<div class="col-sm-7">
        <div class="caja">
<p><strong>P&aacute;g. Sumario </strong></p>
<form name="frmEnvio" method="get" action="/mailing/flash.asp" target="_blank">
<table border="0">
	<tr>
		<td width="15"></td>
		<td width="200" valign="top"><p>Fecha:&nbsp;<input name="f" type="text" id="f" value="<%= cFecha %>" size="10"></td>
		<td width="200" valign="top">pw:&nbsp;
		  <select name="pw" id="pw" disabled>
	<option value="es" selected="selected">Espa&ntilde;a</option>
</select>		</td>
		<td width="20"></td>
		<td width="120" valign="bottom" align="right"><input type="submit" id="Enviar" value="Ver PW Flash"></td>
	</tr>
</table>
</form>

<hr>
<p><strong>P&aacute;g. BlackBerry</strong></p>
<form name="frmEnvio" method="get" action="/mailing/pda.asp" target="_blank">
<table border="0">
  <tr>
    <td width="15">&nbsp;</td>
    <td width="200">Fecha: 
      <input name="R1" type="text" id="R1" value="<%= cFecha %>" size="10"></td>
    <td width="200">env&iacute;o:
          <select name="envio" size="1" id="envio" disabled>
            <option>[nada]</option>
            <option value="si" selected>S&iacute;</option>
            <option value="no">No</option>
          </select>          </td>
	<td width="20"><input name="pag" id="pag" type="hidden" value="PDA"></td>
    <td width="120" align="right"><input name="Enviar" type="submit" id="Enviar" value="Pagina PDA" style="width:120px"></td>
  </tr>
</table>
</form>
        </div>
        
        <div class="clear" style="height:10px;"></div>
        <% if request.Cookies("dev")<>"" then %>
        <div class="caja"><!--#include virtual="/mailing/inc/report.asp" --></div>
		<div class="clear" style="height:8px;"></div>
        <% end if %>
	</div>
    
    <div class="col-sm-5">
        <!--#include virtual="/mailing/inc/mailings.asp" -->
    </div>
  </div>
</section>


</div>
<!--#include virtual="/inc/body-footer.asp" -->
</body>
</html>

<script type="text/javascript">
$(document).ready(function() { 
	var opciones= {
		beforeSubmit: mostrarLoader, 
		success: mostrarRespuesta,
	};
	
	$('#frmEnviarMail_').ajaxForm(opciones) ; 
	
	function mostrarLoader(){
		$("#informaEnviarMail").html("Enviando...");
		
		var ErrSubmit="";
		//if (document.frm_actualidad.busq.value=="") {ErrSubmit="<span id='result_noencontrado'>* Debe indicar alg&uacute;n criterio de b&uacute;squeda.</span>"};
		
		//$("#div_instrucciones").fadeIn("slow");
		//$("#div_instrucciones").html(ErrSubmit);
		
		if (ErrSubmit=="") {
		} else {
			return false;
		}
	};
	function mostrarRespuesta (responseText){ 
		$("#informaEnviarMail").html(responseText);
	};
});

function fLeft(str, n) {
	if (n > String(str).length) return str;
	else return String(str).substring(0,n);
}

</script>
