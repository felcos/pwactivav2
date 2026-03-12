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
    <!--#include virtual="/mailing/enviar/inc_operacion.asp" -->
</head>
<body>
<img src="/img/logo_cabecera.png"><br>
<div id="main_read">
<%
modo_report = true

'Operaciones			
	'sqlWop = "NOMBRE_ZONA LIKE '%22@%'"
	
	'sqlWop = "SELECT DISTINCT ID FROM C_OPERACIONES_TODO WHERE web_es=1 AND " & sqlWop
	'sqlWop = sqlWop & " AND (FECHA_ACTUALIZACION BETWEEN " & desde & " AND " & hasta & ")"
	
	'sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & sqlWop & ") ORDER BY FECHA_ACTUALIZACION DESC"
	sql = "SELECT * FROM C_OPERACIONES WHERE ID=22318"
	
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


<% set resultado = nothing %>

</body>
</html>

