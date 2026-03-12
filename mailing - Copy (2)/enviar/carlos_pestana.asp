<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link href="/_inc/jm/estilos.css" rel="stylesheet" type="text/css">
    <!-- link href="/mailing/report/leer_jm.css" rel="stylesheet" type="text/css" -->
    <!-- link href="/mailing/report/css_jm.css" rel="stylesheet" type="text/css" -->
	<style>
    #main_read {
        border: 0px green solid;
        float:left;
        width:720px;
        padding:5px;
    }
    </style>
	<title>PropertyWeb - Tu servicio de Informaci&oacute;n Inmobiliaria</title>
	<!--#include virtual="/lib/funciones.asp" -->
	<!--#include virtual="/articulos/contenido/noticia.asp" -->
    <!--#include virtual="/articulos/contenido/rumor.asp" -->
    <!--#include virtual="/articulos/contenido/estudio.asp" -->
    
	<!--#include virtual="/articulos/contenido/demanda.asp" -->
    <!--#include virtual="/mailing/enviar/inc_operacion.asp" -->
</head>
<body>
<%
modo_report = true

f_desde = "02/12/2013"
f_hasta = "08/12/2013"
ver_sql = false

dim resultado
desde = "CONVERT(DATETIME, '" & year(f_desde) & "-" & month(f_desde) & "-" & day(f_desde) & " 00:00:00', 102)"
hasta = "CONVERT(DATETIME, '" & year(f_hasta) & "-" & month(f_hasta) & "-" & day(f_hasta) & " 00:00:00', 102)"
%>
<h2>PropertyWeb - Comercial - <%= f_desde %> - <%= f_hasta %></h2>
<div id="main_read">
<%
'sqlW = "PALABRAS_CLAVES LIKE '%comercial%' AND PALABRAS_CLAVES LIKE '%centro%' "
'sqlW = "PALABRAS_CLAVES LIKE '%comercial%' AND PALABRAS_CLAVES NOT LIKE '%centro%' "
'sqlW = "TIPOSECCION ='COMERCIAL' AND " & sqlW
sqlW = "TIPOSECCION ='COMERCIAL'"

'Noticias		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlNot = sql
	contNot = 0
	idsNot = ""
	do while not resultado.eof 
		call VerNoticia(resultado)
		
		if idsNot <> "" then idsNot = idsNot & ", "
		idsNot = idsNot & resultado("id")
		%><br><%
		
		resultado.movenext
		contNot = contNot + 1
	loop
	resultado.close
	
'Rumores		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='W' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlRum = sql
	contRum = 0
	idsRum = ""
	do while not resultado.eof 
		call VerRumor(resultado)
		
		if idsRum <> "" then idsRum = idsRum & ", "
		idsRum = idsRum & resultado("id")
		%><br><%
		
		resultado.movenext
		contRum = contRum + 1
	loop
	resultado.close
	
'Estudios		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='E' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlEst = sql
	contEst = 0
	idsEst = ""
	do while not resultado.eof 
		call VerEstudio(resultado)
		
		if idsEst <> "" then idsEst = idsEst & ", "
		idsEst = idsEst & resultado("id")
		%><br><%
		
		resultado.movenext
		contEst = contEst + 1
	loop
	resultado.close
	
'Demandas		
	'sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & art_id
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='B' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	Set resultado = session("connPW").execute(sql) 
	do while not resultado.eof 
		call VerDemanda(resultado)
		resultado.movenext
	loop
	resultado.close
	
	
'Operaciones	
	sqlW = "SECCION LIKE '%COMERCIAL%' AND "
	sqlW = sqlW & "(FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	
	sql = "SELECT * FROM C_OPERACIONES WHERE (web_es=1 AND (" & sqlW & ")) ORDER BY FECHA_ACTUALIZACION DESC"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql)
	contOpe = 0
	idsOpe = ""
	do while not resultado.eof 
		call OperacionesTablaEntera(resultado)
		
		if idsOpe <> "" then idsOpe = idsOpe & ", "
		idsOpe = idsOpe & resultado("id")
		%><br><%
		
		resultado.movenext
		contOpe = contOpe + 1
	loop
	resultado.close
	
%>
<br style="clear:both">
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>

<% RESPONSE.End() %>


<hr style="clear:both;">
<h2>PropertyWeb - Comercial - <%= f_desde %> - <%= f_hasta %></h2>
<div id="main_read">
<%
sqlW = "PALABRAS_CLAVES LIKE '%comercial%' AND PALABRAS_CLAVES NOT LIKE '%centro%' "
sqlW = "TIPOSECCION ='COMERCIAL' AND " & sqlW

'Noticias		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='N' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlNot = sql
	contNot = 0
	idsNot = ""
	do while not resultado.eof 
		call VerNoticia(resultado)
		
		if idsNot <> "" then idsNot = idsNot & ", "
		idsNot = idsNot & resultado("id")
		%><br><%
		
		resultado.movenext
		contNot = contNot + 1
	loop
	resultado.close
	
'Rumores			
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='W' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlRum = sql
	contRum = 0
	idsRum = ""
	do while not resultado.eof 
		call VerRumor(resultado)
		
		if idsRum <> "" then idsRum = idsRum & ", "
		idsRum = idsRum & resultado("id")
		%><br><%
		
		resultado.movenext
		contRum = contRum + 1
	loop
	resultado.close
	
'Estudios		
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='E' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql) 
	sqlEst = sql
	contEst = 0
	idsEst = ""
	do while not resultado.eof 
		call VerEstudio(resultado)
		
		if idsEst <> "" then idsEst = idsEst & ", "
		idsEst = idsEst & resultado("id")
		%><br><%
		
		resultado.movenext
		contEst = contEst + 1
	loop
	resultado.close
	
'Demandas			
	'sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE ID = " & art_id
	sql = "SELECT * FROM C_NOTICIAS_INMOBILIARIAS WHERE TIPO_NOTICIA='B' AND web_es=1 "
	sql = sql & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	sql = sql & " AND (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	Set resultado = session("connPW").execute(sql) 
	do while not resultado.eof 
		call VerDemanda(resultado)
		resultado.movenext
	loop
	resultado.close
	
'Operaciones			
	sqlWop = "SECCION LIKE '%COMERCIAL%' AND SECCION NOT LIKE '%CENTROS COMERCIAL%'"
	
	sqlWop = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 AND " & sqlWop
	sqlWop = sqlWop & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	
	sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & sqlWop & ") ORDER BY FECHA_ACTUALIZACION DESC"
	
	if ver_sql then
		%><div style="clear:both;"><%= sql %></div><%
	end if
	
	set resultado = session("connPW").execute(sql)
	contOpe = 0
	idsOpe = ""
	do while not resultado.eof 
		call OperacionesTablaEntera(resultado)
		
		if idsOpe <> "" then idsOpe = idsOpe & ", "
		idsOpe = idsOpe & resultado("id")
		%><br><%
		
		resultado.movenext
		contOpe = contOpe + 1
	loop
	resultado.close


%>
</div>


<% set resultado = nothing %>

<% if 1=2 then %>
<hr style="clear:both">
<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">Noticias: </td>
    <td width="10px"></td>
    <td valign="top"><%= contNot %></td>
    <td width="10px"></td>
    <td><%= idsNot %></td>
  </tr>
  <tr>
    <td valign="top">Rumores:</td>
    <td width="10px"></td>
    <td valign="top"><%= contRum %></td>
    <td width="10px"></td>
    <td><%= idsRum %></td>
  </tr>
  <tr>
    <td valign="top">Estudios:</td>
    <td width="10px"></td>
    <td valign="top"><%= contEst %></td>
    <td width="10px"></td>
    <td><%= idsEst %></td>
  </tr>
  <tr>
    <td valign="top">Operaciones:</td>
    <td width="10px"></td>
    <td valign="top"><%= contOpe %></td>
    <td width="10px"></td>
    <td><%= idsOpe %></td>
  </tr>
  <tr>
    <td valign="top">Demandas:</td>
    <td width="10px"></td>
    <td valign="top"><%= contDem %></td>
    <td width="10px"></td>
    <td><%= idsDem %></td>
  </tr>
</table>
<% end if %>

</body>
</html>

