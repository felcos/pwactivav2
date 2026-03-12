<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% Response.Buffer=true %>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>PropertyWeb - Pruebas</title>
</head>
<% 
set rs = Server.CreateObject("ADODB.Recordset")
timer_global_ini = Timer() 

%>
<body>
<h1>Pruebas response.flush</h1>
<p>probando carga</p>
<span style="float:right; width:50%;">
	<span style="float:left; width:50%;">
		art&iacute;culos encontrados: <span id="contar_1">[contar_1]</span>
    </span>
    <span style="float:left; width:50%;">
		tiempo de carga: <span id="contar_time_1">[time_1]</span>
    </span>
</span>
<h2>Listado 1</h2>
<% Response.Flush
starttime = Timer() 
nn=0

sql = "SELECT *, dbo.contar_visitas_articulo('not', ID) AS visitas FROM C_NOTICIAS_INMOBILIARIAS WHERE("
sql = sql & "(PALABRAS_CLAVES LIKE '%centro%') AND (PALABRAS_CLAVES LIKE '%comercial%') AND (PALABRAS_CLAVES LIKE '%alcala%') AND (PALABRAS_CLAVES LIKE '%norte%') "
sql = sql & ") ORDER BY FECHA_ACTUALIZACION DESC"

rs.open sql, session("connPW")
call tabla_not(rs)
rs.close

endtime = Timer() 
time_1 = endtime-starttime
%>
<hr />
<%
'Response.Flush
%>
<% public sub tabla_not(byRef pRS) 
	if not pRS.eof then
	%>
	<table width="100%" cellpadding="0" cellspacing="0">
	  <tr style="border: solid 1px black">
		<td width="40" nowrap="nowrap">Nº</td>
	<!--
		<td>Tipo</td>
		<td>Id</td>
	-->
		<td>T&iacute;tulo</td>
		<td>Secci&oacute;n</td>
		<td>Fecha Act.</td>
	  </tr>
	<% do while not pRS.eof 
		nn = nn+1
		select case pRS("tipo_noticia")
		case "N"
			link = "not"
		case "W"
			link = "rum"
		case "E"
			link = "est"
		case "B"
			link = "dem"
		end select
		link = "/articulos/?" & link & "=" & pRS("ID") 
		%>
	  <tr valign="top" onMouseOver="this.bgColor='#E1E1E1';" style="CURSOR: hand" onmouseout="this.bgColor='#FFFFFF';" >
		<td align="right"><a href="<%= link  %>" target="_blank"><%= nn %></a> &nbsp; </td>
	<!--
		<td>< %= pRS("tipo_noticia") %></td>
		<td>< %= pRS("id") %></td>
		
		onclick="document.location='/ofertas/?id=< %= pRS("ID") %>';"
	-->
		<td><a href="<%= link  %>" class="simplemodal"><%= pRS("titulo") %></a></td>
		<td><%= pRS("TIPOSECCION") %></td>
		<td><%= pRS("FECHA_ACTUALIZACION") %></td>
	  </tr>
	<% 	Response.Flush
	pRS.movenext
	loop 
	%>
	</table>
	<% 
	end if
end sub %>
</body>
<% 

%>
</html>
