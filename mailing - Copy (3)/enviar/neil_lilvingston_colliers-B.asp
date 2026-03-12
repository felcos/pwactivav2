<!-- include virtual="/inc/reg_accesos.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<!--#include virtual="/mailing/enviar/titulos_lib.asp" -->
<html>
<head>
<title>T&iacute;tulos PropertyWeb - 22@</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/mailing/enviar/titulos.css" rel="stylesheet" media="screen">
</head>
<body bgcolor="#ffffff">
<form name="titulos" method="POST" align="center" action="/articulos/" target="_blank" >
<%
'On Error Resume Next
set resultado = Server.CreateObject("ADODB.Recordset")
public sql
public ErrMesage

public FechaI
public FechaF
FechaI="01/11/2010"
FechaF="13/11/2013"

public tabla
origen="mailing"

'Noticias		
seccion="not"
bloque="notici"
titulo="Noticias"
color="roj"
seccion2="Noticias"
strin="notici"
sign="N"

Call NotEstRumSub			
call Abrir_Recordset()
call TABLA_TITULOS
If not Resultado.EOF then 
	titulo="RUMORES"
	color="gri"
	seccion2="Rumores"
	strin="rumores"
	bloque="rumore"
	Call TABLA_TITULOS
end if
Resultado.close

'Estudios		
seccion="est"	
bloque="estudi"
titulo="ESTUDIOS"
color="mor"
seccion2="Estudios"
tabla="C_NOTICIAS_INMOBILIARIAS"
sign="E"
Limite=250
strin="estudios"
Call NotEstRumSub

call Abrir_Recordset()
call TABLA_TITULOS
Resultado.close

'Operaciones	
seccio="ope"
bloque="operac"
titulo="OPERACIONES"
color="pis"
Call OperacionesSub
Limite=250
strin="operac"
'origen="busope"
call Abrir_Recordset()
call TABLA_TITULOS
Resultado.close
%>
<br>
<% if ErrMesage="" then %>
  <div align="center"><input type="submit" id="B1" name="B1" value="Leer Artículos Seleccionados"></div>
<% end if %>
<br>
</form>

</body>
</html>

<% sub Abrir_Recordset()	
	if ErrMesage="" then
		session("connPW").CommandTimeout = 120
		response.flush
		'response.write sql
		'response.end
		
		Resultado.Open SQL, session("connPW"), 1, 1
		if limite<Resultado.recordcount then ErrMesage=Resultado.recordcount & " Artículos Encontrados " & limite & "<br>Depure la Búsqueda."
		'Depure la Búsqueda"
		if resultado.EOF and resultado.EOF then ErrMesage = "No Existe ningún resultado<br>Cambie los criterios de su búsqueda"
	end if
end sub %>

<% Sub NotEstRumSUB		
	sql = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX, TIPO_NOTICIA, icono_seccion "
	sql = sql & "FROM C_NOTICIAS_INMOBILIARIAS WHERE ("
	sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) "	
	sql = sql & "AND web_es<>0 "
	
	sql = sql & "AND PALABRAS_CLAVES LIKE '%22@%' "
	
	if seccion="not" then	
		sql = sql & " AND (TIPO_NOTICIA LIKE 'N' OR TIPO_NOTICIA LIKE 'W') "
		reg_bloque="noticias"
	else
		sql = sql & "AND (TIPO_NOTICIA LIKE 'E') "
		reg_bloque="estudios"
	end if
	sql = sql & " ORDER BY TIPO_NOTICIA ASC,TIPOSECCION ASC,FECHA_ACTUALIZACION DESC"
End sub %>

<% Sub OperacionesSUB	
	sql = "SELECT ID, TITULO, TITULO_EN AS TITULO_AUX, FECHA_ACTUALIZACION, seccion AS APARTADO FROM C_OPERACIONES WHERE ("
	sql = sql & "(FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	sql = sql & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) "
	sql = sql & "AND (web_es<>0) "
	
	sql = sql & "AND (NOMBRE_ZONA LIKE '%22@%')"
	
	sql = sql & ") "
	sql = sql & "ORDER BY seccion, FECHA_ACTUALIZACION DESC;"
End Sub %>
