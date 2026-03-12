<% sub VerNoticia(byRef pRS) 
	'comprobar permisos
	swMostrarDetalles = true
	'ini_cliente = session("pw_ws").IniCliente(request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))
	'ini_cliente = session("pw_ws").IniCliente(request.Cookies("licencia")("user_id"), request.Cookies("licencia")("n"), request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("movil"))
	
	'if session("es_cliente") and session("acceso_activo") then
	if session("pw_ws").accesoActivo then
		if session("pw_ws").accesoNoticias then
			swMostrarDetalles=true
		elseif session("pw_ws").accesoNoticiasHoy then
			if abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))<=7 then
				swMostrarDetalles=true
			end if
		end if
		
		if not session("pw_ws").accesoInternacional then
			if pRS("nacional")<>1 then
				'swMostrarDetalles=false fc
				swMostrarDetalles=true
			end if
		end if
		
		'origen
		select case session("origen")
		case "invers"
			if session("pw_ws").accesoInversores then swMostrarDetalles=true
		case "infinm"
			if session("pw_ws").accesoInfoEdificio then swMostrarDetalles=true
		case "infemp"
			if session("pw_ws").accesoInfoEmpresa then swMostrarDetalles=true
		end select
		
		select case session("secc")
		case "empr"
			if session("pw_ws").accesoInfoEmpresa then swMostrarDetalles=true
		case "edif"
			if session("pw_ws").accesoInfoEdificio then swMostrarDetalles=true
		case "prop"
			if session("pw_ws").accesoInfoPropietario then swMostrarDetalles=true
		end select
	end if
	
	if modo_report then swMostrarDetalles = true
	%>
<div id="contenedor_articulos" class="<% if modo_report then %>caja<% end if %>">
	<h3 class="encabezado_noticia">Noticias Inmobiliarias<% if request.Cookies("dev")<>"" and modo_report then %> &nbsp; <span class="dev">MODO REPORT</span><% end if %></h3>
    <h1 class="titulo_noticia"><%= pRS("TITULO") %></h1>
	
	<div id="descar_imprim">
		<% if not(modo_report) then %><a href="javascript:void(0);" onclick="imprimir();"><span class="txt_gris_claro" style="font-weight:bold;font-size:12px;">imprimir</span>&nbsp;&nbsp;<img src="/img/imprimir.png"></a>&nbsp;&nbsp;<% end if %>
		<span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("nacional")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("nacional")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>
	</div>
    
    <p class="txt_gris_claro">Fecha Noticia: <%= pRS("Fecha_noticia") %></p>
    
    <div style="clear:both;"></div>
	<% if request.Cookies("dev")="" then %>
    <div id="separator_line"></div>
    <% else %>
	<div class="dev">
    	swMostrarDetalles: <%= swMostrarDetalles %>
    </div>
	<% end if %>
    
<% if swMostrarDetalles then 
	if not modo_report then
		secc = session("secc")
		if secc="" then secc = "not"
		insert_reg_articulo secc, "not", pRS("ID")
		'response.Write(modo_report)
		'response.Write(pRS("ID"))

	end if
	
	strTextoHTML = pRS("TEXTO_NOTICIA")& chr(13)
    'Chr(172) = ¬ 
    strTextoHTML = replace(strTextoHTML, Chr(10) & "¬" & "¬", "<table border='1' align='Center' class='txtTabla' width='90%'><tr><td>")
    strTextoHTML = replace(strTextoHTML, "¬" & "¬" & Chr(13), "</td></tr></table>")
    strTextoHTML = replace(strTextoHTML, "¬" & Chr(13), "</td></tr><tr><td>")
    strTextoHTML = replace(strTextoHTML, "¬", "</td><td>")
	    
    'Chr(124) = |
    strTextoHTML = replace(strTextoHTML, Chr(10) & "|", "<div align=center><img src='https://www.propertyweb.eu/fotos/noticias/")
    strTextoHTML = replace(strTextoHTML, "|" & chr(13), ".jpg'></div>")
	
    strTextoHTML = replace(strTextoHTML, Chr(13), "<br>")
	
	sFotos = pRS("fotos") 
	%>
	<!--#include virtual="/inc/fotos.asp" -->
    <div class="cuerpo"><%= strTextoHTML %></div>
    <p></p>
    
    <% if pRS("ID_FUENTE")>0 then %>
    	<div id="separator_line" style="clear:both;"></div>
        <div class="fuente">
            Fuente: <!--#include virtual="/lib/fuentes.asp" -->
            <% if pRS("NUMERO_PAGINA")<>"" and pRS("NUMERO_PAGINA")<>"0" then %><br>&nbsp;P&aacute;g: <%= pRS("NUMERO_PAGINA") %></span><% end if %>
        </div>
    <% end if %>
    
	<% if request.Cookies("dev")<>"" and not(modo_report) then %>
    	<div class="caja dev" style="margin-bottom:10px;">
            <li>Fecha Publicaci&oacute;n: <strong><%= pRS("FECHA_NOTICIA") %></strong></li>
            <li>Fecha Actualizaci&oacute;n: <strong><%= pRS("FECHA_ACTUALIZACION") %></strong></li>
            <div id="separator_line" style="clear:both;"></div>
            <!--#include virtual="/articulos/palabras_clave.asp" -->
        </div>
    <% end if %>
	
<% else	'swMostrarDetalles
	if request.Cookies("licencia")="" then
		call NoCliente
	else
		'if ini_cliente=0 then	'es cliente activo
		if session("pw_ws").LicenciaId>0 then
			if not(session("pw_ws").accesoNoticiasHoy) then
			
				call SinAcceso("Noticias Inmobiliarias")
				
			elseif abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))>7 and not(session("pw_ws").accesoNoticias) then
				call AccesoSoloHoy("Noticias Inmobiliarias")
			
			elseif pRS("nacional")<>1 and not(session("pw_ws").accesoInternacional) then
				call AccesoSoloNacional("Noticias Inmobiliarias")
				
			else
				call SinAcceso("Noticias Inmobiliarias")
			end if
		else
			call SinAcceso("Noticias Inmobiliarias")
		end if
	end if
	
end if	'swMostrarDetalles 

if modo_report then
	%><div style="clear:both"></div><%
else %>
	<div id="separator_line" style="clear:both"></div><br />
	<p class="copyright_articulo">&copy; Property Web Espa&ntilde;a</p>
<% end if %>
</div>

<% end sub %>
