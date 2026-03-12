<% sub VerEstudio(byRef pRS) 
	swMostrarDetalles = false
	
	if session("pw_ws").accesoActivo then
		if session("pw_ws").accesoEstudios then
			swMostrarDetalles=true
		elseif session("pw_ws").accesoEstudiosHoy then
			if abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))<=7 then
				swMostrarDetalles=true
			end if
		end if
		
		if not session("pw_ws").accesoInternacional then
			if pRS("nacional")<>1 then
				swMostrarDetalles=false
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
	
    <h3 class="encabezado_estudios">Estudios de Mercado</h3>
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
		if secc="" then secc = "est"
		insert_reg_articulo secc, "est", pRS("ID")
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
    'response.write strTextoHTML
	
	sFotos = pRS("fotos")
    %>
	<!--#include virtual="/inc/fotos.asp" -->
	<div class="cuerpo"><%= strTextoHTML %></div>
    <p></p>

	<% call ArchivosAdjuntos(pRS("id")) %>
	
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
		if session("pw_ws").ClienteId>0 then	'es cliente activo
			if not(session("pw_ws").accesoEstudiosHoy) then
				call SinAcceso("Estudios de Mercado")
				
			elseif abs(datediff("d", pRS("FECHA_ACTUALIZACION"), date))>7 and not(session("pw_ws").accesoEstudios) then
				call AccesoSoloHoy("Estudios de Mercado")
			
			elseif pRS("nacional")<>1 and not(session("pw_ws").accesoInternacional) then
				call AccesoSoloNacional("Estudios de Mercado")
				
			else
				call SinAcceso("Estudios de Mercado")
			end if
		else
			call SinAcceso("Estudios de Mercado")
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

<% sub ArchivosAdjuntos(pId) 
	sqlTmp = "SELECT * FROM articulos_adjuntos WHERE art_tabla='not' AND adj_tipo='pdf' AND art_id=" & pId
	Set rsTmp = session("connPW").execute(sqlTmp)
	'response.Write(sqltmp)
	
	if not(rsTmp.eof and rsTmp.bof) then 
%>
<div id="separator_line" style="clear:both"></div>
<span>Abrir Informe Completo (pdf)</span><br>
<table border="0" cellspacing="0" cellpadding="2">
	<% do while not rsTmp.eof 
		archivo = "/informes/" & rsTmp("ruta") & "/" &  rsTmp("archivo")
		archivo = replace(archivo, "//", "/")
		%>
        <tr>
        	<td class="txtTabla" width="20"></td>
            <td class="txtTabla" width="50"><a href="<%= archivo %>" target="_blank"><img src="/img/export.gif" border="0"/></a></td>
            <td class="txtTabla"><a href="<%= archivo %>" target="_blank"><%= rsTmp("comentario") %></a></td>
            <td class="txtTabla" align="right"><!-- include virtual="/lib/fuentes.asp" --></td>
        </tr>
	<% rsTmp.movenext
	loop %>
</table>
		
	<% end if
	rsTmp.close
	set rsTmp=nothing
end sub %>
