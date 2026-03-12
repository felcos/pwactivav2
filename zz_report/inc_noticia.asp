<% sub VerNoticia(byRef pRS) 
	'''insert_reg_articulo "not", pRS("ID") %>
<a name="not<%= pRS("ID") %>" id="not<%= pRS("ID") %>"></a>
<div id="contenedor_articulos">
	<h3 class="encabezado_noticia">Noticias Inmobiliarias</h3>
	<h1 class="titulo_noticia"><%= pRS("TITULO") %></h1>
	<p style="font-family: georgia;">&nbsp;</p>
	
	<div id="descar_imprim">
	  <span class="txt_gris_claro" style="font-weight:bold;font-size:12px;"><% if pRS("nacional")=1 then %>nacional<% else %>internacional<% end if %></span>&nbsp;&nbsp;<% if pRS("nacional")=1 then %><img src="/img/artic_nacional.png"><% else %><img src="/img/artic_internacional.png"><% end if %>
	</div>
    
    <span class="txt_gris_claro" style="font-style: oblique;font-weight: bold;font-size:12px;position:relative;bottom:10px;"><%= pRS("Fecha_noticia") %></span>

<div class="cuerpo">
<% if pRS("NUMERO_FOTOS")>0 then
	response.Write("[[[ call TABLAFOTOS ]]]")
end if %>
	
<div>
<%
	strTextoHTML = pRS("TEXTO_NOTICIA")& chr(13)
    strTextoHTML = replace(strTextoHTML, Chr(10) & Chr(172) & Chr(172), "<table border='1' align='Center' class='txtTabla' width='90%'><tr><td>")
    strTextoHTML = replace(strTextoHTML, Chr(172) & Chr(172) & Chr(13), "</td></tr></table>")
    strTextoHTML = replace(strTextoHTML, Chr(172) & Chr(13), "</td></tr><tr><td>")
    strTextoHTML = replace(strTextoHTML, Chr(172), "</td><td>")
    
    if instr(strTextoHTML, chr(124) & chr(124)) then 
        strLinkExterno=mid(strTextoHTML, instr(strTextoHTML, chr(124) & chr(124))+2)
        strLinkExterno=left(strLinkExterno, instr(strLinkExterno, chr(124) & chr(124))-1)
        
        strTextoHTML = replace(strTextoHTML, chr(10) & chr(124) & chr(124) & strLinkExterno & chr(124) & chr(124) & chr(13) , "")
        
        strTextoLink=left(strLinkExterno, instr(strLinkExterno, ".")-1)
        strLinkExterno="/informes/" & strLinkExterno
    else
        strLinkExterno=""
    end if
    
    strTextoHTML = replace(strTextoHTML, Chr(10) & Chr(124), "<div align=center><img src='https://www.propertyweb.eu/fotos/noticias/")
    strTextoHTML = replace(strTextoHTML, Chr(124) & chr(13), ".jpg'></div>")
    
    strTextoHTML = replace(strTextoHTML, Chr(13), "<br>")
    'response.write strTextoHTML
    %>
<%= strTextoHTML %>
</div>

<div id="separador"></div>

<p class="cuerpo">Fuente: &nbsp; <%= pRS("FUENTE" )%></p><!--#include virtual="/lib/fuentes.asp" --><br><br>
<div id="separator_line" style="clear:both"></div>

<span>
	<% if pRS("NUMERO_PAGINA")<>"" and pRS("NUMERO_PAGINA")<>"0" then %>&nbsp;Pag: <%= pRS("NUMERO_PAGINA") %><% end if %>
</span>

<br style="clear:both;">

<table width="100%" border="0">
  <tr>
    <td><span class="txt_fecha">Fecha Publicaci&oacute;n:</span> <span class="txt_negrita" style="font-size: 10px;"><%= pRS("FECHA_NOTICIA") %></span></td>
    <td><span class="txt_fecha">Fecha Actualizaci&oacute;n:</span> <span class="txt_negrita" style="font-size: 10px;"><%= pRS("FECHA_ACTUALIZACION") %></span></td>
  </tr>
</table>
<!-- comentarios de los usuarios --> 

</div>

<div id="separator_line"></div>
<font size="1pt" style="font-family: Georgia;position: relative;left: 200px;top: 10px;font-size: 12px;">&copy; Property Web Espa�a</font>

</div>

<p>&nbsp;</p>

<% end sub %>
