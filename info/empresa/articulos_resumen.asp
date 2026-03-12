<!--#include virtual="/info/empresa/calcular_sql.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% 
if 1=2 then
	for each elto in request.Form
		if request.Form(elto)<>"" then
			%><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
		end if
	next
end if

dim sqlTmp
dim swCheck
dim rsTmp

dim vMin
dim vMax

vMin = request.Form("vMin")
vMax = request.Form("vMax")

if request.Form("intervalo")<>"" then
	intervalo = split(request.Form("intervalo"),";")
	if intervalo(1) >= intervalo(0) then
		vMin = intervalo(0)
		vMax = intervalo(1)
	else
		vMin = intervalo(1)
		vMax = intervalo(0)
	end if
end if

if vMax="" then vMax=2018
if vMin="" then vMin=1996
%>
<h1 class="expand" style="margin-bottom:14px;">Archivo Hist&oacute;rico</a>:</h1>
<% if request.Cookies("dev")("request")<>"" then %>
<div style="background:#FFFFCC; font-size:11px; margin:2px;border:#000000 1px solid;">
	form: &nbsp; <% for each elto in request.Form
		if request.Form(elto)<>"" then
			%><%= elto %>:[<%= request.Form(elto) %>]&nbsp;<%
		end if
	next %>
</div>
<% end if %>
<form method="POST" id="frm_resumen" name="frm_resumen" action="/info/empresa/articulos.asp" target="_blank">
	<input type="hidden" name="seltipo" value="empr"/>
<% for each elto in request.form 
	select case elto
	case "noticias", "rumores", "estudios", "op_inversion", "op_alquiler"
	case "intervalo"
	case else %>
		<input type="hidden" name="<%= elto %>" value="<%= request.form(elto) %>"/>
	<% end select
next %>
<%
'on error resume next
set rsTmp = Server.CreateObject("ADODB.Recordset")
session("connPW").CommandTimeout = 120
%>
<table border="0" cellspacing="0" cellpadding="2" style="margin-left:20px;">
  <tr valign="top">
    <td>Operaciones&nbsp;</td>
    <td>inversi&oacute;n:&nbsp;</td>
    <td><% 
	call operaciones("inversion")
	%></td>
    <td><input name="historico_inversion" type="checkbox" <% if swCheck then %>checked="checked"<% end if %><% if not(session("pw_ws").accesoInfoEmpresa) then %> disabled="disabled"<% end if %>/></td>
    <% if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%'= sqlTmp %></td>
    <% end if %>
  </tr>
  <tr valign="top">
    <td></td>
    <td>alquiler:&nbsp;</td>
    <td><% 
	call operaciones("alquiler")
	%></td>
    <td><input name="historico_alquiler" type="checkbox"  <% if swCheck then %>checked="checked"<% end if %><% if not(session("pw_ws").accesoInfoEmpresa) then %> disabled="disabled"<% end if %>/></td>
    <% if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%'= sqlTmp %></td>
	<% end if %>
  </tr>
  <tr valign="top">
    <td colspan="2">Noticias Inmobiliarias: </td>
    <td><%
	call noticias 
	if not(session("pw_ws").accesoInfoEmpresa) then swCheck=false
	%></td>
    <td><input name="historico_noticias" type="checkbox"  <% if swCheck then %>checked="checked"<% end if %><% if not(session("pw_ws").accesoInfoEmpresa) then %> disabled="disabled"<% end if %>/></td>
    <% if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%'= sqlTmp %></td>
    <% end if %>
  </tr>
  
  <tr valign="top">
    <td colspan="2">&quot;Web" ha o&iacute;do...: </td>
    <td><% 
	call cotilleos 
	if not(session("pw_ws").accesoInfoEmpresa) then swCheck=false
	%></td>
    <td><input name="historico_rumores" type="checkbox"  <% if swCheck then %>checked="checked"<% end if %><% if not(session("pw_ws").accesoInfoEmpresa) then %> disabled="disabled"<% end if %>/></td>
    <% if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%'= sqlTmp %></td>
    <% end if %>
  </tr>
  
  <tr valign="top">
    <td colspan="2">Estudios de Mercado: </td>
    <td><% 
	call estudios
	if not(session("pw_ws").accesoInfoEmpresa) then swCheck=false
	%></td>
    <td><input name="historico_estudios" type="checkbox"  <% if swCheck then %>checked="checked"<% else %><% end if %><% if not(session("pw_ws").accesoInfoEmpresa) then %> disabled="disabled"<% end if %>/></td>
    <% if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%'= sqlTmp %></td>
    <% end if %>
  </tr>
  
  <% if 1=2 then %>
  <tr valign="top">
    <td colspan="2">Archivo de Ofertas: </td>
    <td><% 'call ofertas %></td>
    <td><input name="ofertas" type="checkbox"  <% if swCheck then %>checked="checked"<% else %>disabled="disabled"<% end if %>/></td>
    <% 'if request.Cookies("dev")("sql")<>"" then %>
    <td style="font-size:10px; line-height:normal; padding-left: 10px;"><%= sqlTmp %></td>
    <% 'end if %>
  </tr>
  <% end if %>
</table>

<div style="margin:10px;">
<% if session("pw_ws").accesoInfoEmpresa then %>
    
    <span name="div_instrucciones" id="div_instrucciones" style="display:none;"><img style="padding: 0 0 0 100px;" src="/img/ajax-loader.gif"></span>
    <div style="width: 200px; float:left;"><input type="text" id="intervalo" name="intervalo" /></div>
    
    
    
    <input type="submit" value="Ver art&iacute;culos" class="btn" style="float:right; margin-top:10px;">
<% elseif request.Cookies("licencia")<>"" then %>
	<p style="margin-top:25px;">Para acceder a los contenidos del Archivo Hist&oacute;rico debe tener contratada la secci&oacute;n.&nbsp;<strong><%= request.Cookies("licencia")("u") %></strong>&nbsp;
	es cliente, pero no tiene contratado  Info-Empresas.</p>
    <p style="margin-top:10px;">P&oacute;ngase en contacto con PropertyWeb.</p>
<% else %>
	<p style="margin-top:25px;">Para acceder a los contenidos del Archivo Hist&oacute;rico debe ser cliente.</p>
    <p style="margin-top:10px;">P&oacute;ngase en contacto con PropertyWeb.</p>
<% end if %>
</div>
<%
Set rsTmp = nothing
%>
</form>
<div style="clear:both;"></div>


<% sub noticias			
	sqlTmp = "SELECT COUNT(*) AS contar FROM C_NOTICIAS_INMOBILIARIAS WHERE " & calcular_sqlw("noticias")
	
	'test_inyeccion_sql sqlTmp
	rsTmp.Open sqlTmp, session("connPW")
	
	if session("pw_ws").accesoInfoEmpresa then 
		if rsTmp("contar")>0 and rsTmp("contar")<limitenoticias then
			swCheck = true
		else
			swCheck = false
		end if
	else
		swCheck = false
	end if
	
	response.Write(rsTmp("contar"))
	rsTmp.close
end sub %>

<% sub estudios			
	sqlTmp = "SELECT COUNT(*) AS contar FROM C_NOTICIAS_INMOBILIARIAS WHERE " & calcular_sqlw("estudios")
	'test_inyeccion_sql sqlTmp
	rsTmp.Open sqlTmp, session("connPW")
	
	if session("pw_ws").accesoInfoEmpresa then 
		if rsTmp("contar")>0 and rsTmp("contar")<limiteestudios then
			swCheck = true
		else
			swCheck = false
		end if
	else
		swCheck = false
	end if
	
	response.Write(rsTmp("contar"))
	rsTmp.close
end sub %>
<% sub cotilleos		
	sqlTmp = "SELECT COUNT(*) AS contar FROM C_NOTICIAS_INMOBILIARIAS WHERE " & calcular_sqlw("rumores")
	'test_inyeccion_sql sqlTmp
	rsTmp.Open sqlTmp, session("connPW")
	
	if session("pw_ws").accesoInfoEmpresa then 
		if rsTmp("contar")>0 and rsTmp("contar")<limiterumores then
			swCheck = true
		else
			swCheck = false
		end if
	else
		swCheck = false
	end if
	
	response.Write(rsTmp("contar"))
	rsTmp.close
end sub %>

<% sub operaciones(tipo)		
	sqlTmp = "SELECT COUNT(DISTINCT ID) AS contar FROM C_OPERACIONES_INTERMEDIARIOS WHERE " 
	select case tipo
	case "inversion"
		sqlTmp = sqlTmp & calcular_sqlw("ops_inversion")
	case "alquiler"
		sqlTmp = sqlTmp & calcular_sqlw("ops_alquiler")
	end select
	
	'test_inyeccion_sql sqlTmp
	rsTmp.Open sqlTmp, session("connPW")
	
	
	if session("pw_ws").accesoInfoEmpresa then 
		if rsTmp("contar")>0 and rsTmp("contar")<limiteoperaciones then
			swCheck = true
		else
			swCheck = false
		end if
	else
		swCheck=false
	end if
	
	response.Write(rsTmp("contar"))
	rsTmp.close
end sub %>

<% sub ofertas			
	sqlTmp = "SELECT COUNT(*) AS contar FROM c_ofertas WHERE " & calcular_sqlw("ofertas")
	test_inyeccion_sql sqlTmp
	rsTmp.Open sqlTmp, session("connPW")
	
	if rsTmp("contar")>0 then
		swCheck = true
	else
		swCheck = false
	end if
	
	response.Write(rsTmp("contar"))	
	rsTmp.close
end sub %>
<script type="text/javascript">
$(document).ready(function() { 
	$("#intervalo").ionRangeSlider({
		max: "2018",
		min: "1996",
		to: "<%= vMax %>",
		from: "<%= vMin %>",
		maxPostfix: "+",
		type: "double",
		step: 1,
		prettify: true,
		//hasGrid: true,
		hideMinMax: false,
		onFinish: carga_historico
	});
			
	function carga_historico() {
		$("#loader").fadeIn("fast");
		$("#result").html("");
		
		function onDataReceived(recibe) {
			$("#archivo_historico").html(recibe)
			$("#loader").fadeOut("fast");
		};
		
		function onError() {alert('err'); }
		$.ajax({
			url: "/info/empresa/articulos_resumen.asp",
			data: $("#frm_resumen").serialize(),
			type: "POST",
			dataType: "html",
			success: onDataReceived
			/* , error: onError */
		});
	 };
	
	var opciones= {
	   beforeSubmit: mostrarLoader, //funcion que se ejecuta antes de enviar el form
	   success: mostrarRespuesta, //funcion que se ejecuta una vez enviado el formulario
	};
	
	$("#frm_resumen").ajaxForm(opciones);
	
	function mostrarLoader(){
		$("#loader").fadeIn("slow");
	 };
	function mostrarRespuesta (responseText){
		//console.log(responseText)
		$("#result").html(responseText);
		
		$("#div_result").fadeIn("slow");
		$.scrollTo('#s_titulos',800);
		
		$("#loader").fadeOut("slow");
		
	 };
	
}); 

</script>
