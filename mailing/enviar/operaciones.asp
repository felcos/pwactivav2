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
    <!-- include virtual="/inc/reg_accesos.asp" -->
    <!--#include virtual="/lib/funciones.asp" -->
    <!--#include virtual="/mailing/enviar/inc_operacion.asp" -->
</head>
<body>
<img src="/img/logo_cabecera.png" width="260" height="105"><br>
<div id="main_read">
<%
dim resultado

'f_desde = "01/08/2013"
'f_hasta = "31/08/2013"
'sqlW = "(FECHA_ACTUALIZACION BETWEEN '" & f_desde & "' AND '" & f_hasta & "')"

'Operaciones			
'sql = "SELECT * FROM C_OPERACIONES WHERE ID IN (" & sqlW & ") ORDER BY FECHA_ACTUALIZACION DESC"
sql = "SELECT * FROM C_OPERACIONES WHERE ID IN ("
	sql = sql & "22094, 22095, 22108"
'	sql = sql & "20497, 20661, 20664, 20665, 20666, 20667, 20668, 20669, " 
'	sql = sql & "20670, 20671, 20672, 20673, 20674, 20675, 20676"
sql = sql & ") ORDER BY FECHA_ACTUALIZACION, id"
'sql = "SELECT * FROM C_OPERACIONES WHERE " & sqlW & " ORDER BY FECHA_ACTUALIZACION DESC"

set resultado = session("connPW").execute(sql)
sqlOpe = sql
contOpe = 0
do while not resultado.eof 
	call OperacionesTablaEntera(resultado)
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
    <td><%'= sqlNot %></td>
  </tr>
  <tr>
    <td valign="top">Rumores:</td>
    <td width="10px"></td>
    <td valign="top"><%= contRum %></td>
    <td width="10px"></td>
    <td><%'= sqlRum %></td>
  </tr>
  <tr>
    <td valign="top">Estudios:</td>
    <td width="10px"></td>
    <td valign="top"><%= contEst %></td>
    <td width="10px"></td>
    <td><%'= sqlEst %></td>
  </tr>
  <tr>
    <td valign="top">Operaciones:</td>
    <td width="10px"></td>
    <td valign="top"><%= contOpe %></td>
    <td width="10px"></td>
    <td><%= sqlOpe %></td>
  </tr>
</table>
<% end if %>
</body>
</html>

