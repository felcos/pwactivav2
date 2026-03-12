<html>
<% 'Pag.Sumario PDA
	Response.addHeader "pragma", "no-cache"
	Response.CacheControl = "Private"
	Response.ExpiresAbsolute = #1/1/2006 12:00:00#
%>
<!--#include virtual="/mailing/p/tablatitulos.asp" -->
<%
'''include virtual="/inc/reg_accesos.asp"
'''include virtual="/lib/funciones.asp" 

'on error resume next
'if request.querystring("R1")="" then response.end

'Variables P�blicas		
	Public Resultado
	Public Opciones
	public string1
	public idseccion
	public idtabla
	Public seccion
	Public x
	public fechaI
	public fechaF
	Public Total
	
	public ErrMesage
	public color
	public titulo
	public checked
	Public Origen
	Public Strin
	Public Ingles
	'Para saber en tabla titulos en que secci�n estoy
	Public Seccion2
	Public targetMain
	
	public bloque	'recoge el bloque en el que estamos, 6 letras (noticias, rumores, etc...)
	Public envio
	Public inversa
	
	public swMostradaListaFechas
	
targetMain="_blank"
origen="pagsuF"
Set Resultado = Server.CreateObject("ADODB.Recordset")

if Request.queryString ("C1") <>"" then checked="true"
if request.querystring("envio")<>"" then envio=true
if envio=true then
	'para que en el env�o se me conserven los frames
	origen="pagsum"
end if

'Fechas		
	if request.querystring("R1")="" then
		fecha=date()	
	else
		fecha=request.querystring("R1")
	end if
	if len(fecha)<12 then
		fechai=fecha
		fechaf=fecha
		semana=false
	else
		for b =1 to len(fecha)
			if mid(fecha,b,1)="-" then
				fechai=left(fecha,b-1)
				fechaf=right(fecha,len(fecha)-b)
			end if
		next
		semana=true
	end if
	fechai=formatdatetime(fechai,2)
	fechaf=formatdatetime(fechaf,2)

'T�tulos	
if semana=true then
	titulo = ".:: " & "Contenidos Property Web " & FormatDateTime(fechai,2) & " al " & FormatDateTime(fechaf,2) & " ::. "
	titulo2= "Contenidos Property Web " & FormatDateTime(fechai,2) & " al " & FormatDateTime(fechaf,2)
else 
	titulo = "Contenidos Property Web " & FormatDateTime(fechai,2)
	titulo2= "Contenidos Property Web " & FormatDateTime(fechai,2) & ". www.propertyweb.eu"
end if
%> 
<head>
<title><%= titulo2 %></title>
<style type="text/css">
<!--
BODY {FONT-SIZE: 11px; MARGIN: 0px; COLOR: #000000; FONT-FAMILY: Arial, Helvetica, sans-serif; BACKGROUND-COLOR: #ffffff; TEXT-DECORATION: none}
TD {FONT-SIZE: 8pt; FONT-FAMILY: Arial, Helvetica, sans-serif}
INPUT {FONT-WEIGHT: bold; FONT-SIZE: 8pt; FONT-FAMILY: Arial, Helvetica, sans-serif}
SELECT {FONT-WEIGHT: bold; FONT-SIZE: 8pt; FONT-FAMILY: Arial, Helvetica, sans-serif}

.estilotabla {BORDER-RIGHT: #666666 0px solid; BORDER-TOP: #666666 0px solid; BORDER-LEFT: #666666 0px solid; BORDER-BOTTOM: #666666 0px solid; BACKGROUND-COLOR: #ffffff}
td.mor2 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; BACKGROUND-COLOR: #cccccc}
.negro {FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #000000;}

td.estiloceldaprincipal {FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #ffffff; FONT-FAMILY: Verdana; BACKGROUND-COLOR: #0066cc}
td.estilocelda3 {FONT-WEIGHT: bold; FONT-SIZE: 10pt; COLOR: #333333; BACKGROUND-COLOR: #ff9900; padding:4px;}

td.titroj {
	FONT-SIZE: 10px; COLOR: #ff6600; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
td.titroj A:link {
	FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
td.titroj A:visited {
	FONT-SIZE: 10px; COLOR: #000000; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}
td.titroj A:hover {
	FONT-SIZE: 10px; COLOR: #ff6600; FONT-FAMILY: Arial, Helvetica, sans-serif; TEXT-DECORATION: none
}

a {font-family: Arial, Helvetica, sans-serif;font-size: 9px;color: #000000;}
a:link {text-decoration: none;}
a:visited {text-decoration: none;color: #999999;}
a:hover {text-decoration: none;color: #FF9900;}
a:active {text-decoration: none;color: #FF3300;}

-->
</style>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form method="GET" action="https://www.propertyweb.eu" id="form1" name="form1">
<div align="left">
<table width="100%" border="0">
  <tr>
	<td><% BarraTitulo() %><input name="vers" type="hidden" value="pda"></td>
	<!--td><% if request.QueryString("envio")="" then 	call BarraFecha() %></td-->
  </tr>
</table>
</div>
</form>
<!-- Tabla de Resultados -->		
<table width="99%" border="0" cellspacing="2" cellpadding="2" align="center" >
	<tr  valign="top">
		<td  valign="top">
<% 
	call noticias()
	call cotilleos()
	call estudios()
	call operaciones()
	call demandas()
	call subastas()
	
	call ofertas()
%>
		</td>
	</tr>
</table>
<br>
<!-- Tabla de resultados: FIN -->
<%
'session("connPW").close
set resultado=nothing

if envio<>"" then %>
	<!-- Contacto -->	
<table width="80%" border="0" cellspacing="5" cellpadding="5" align="center">
  <tr> 
    <td align="center">
	  <b>Le comunicamos que el env�o de esta informaci�n est� sometida al cumplimiento de la LSSI-CE. La finalidad de nuestros env�os de email es, �nica y exclusivamente, la de mantenerle informado con las noticias del d�a, dando de esta manera su consentimiento expreso para recibirla. Si desea rectificar, modificar o cancelar sus datos puede ponerse en contacto con nosotros mediante la siguiente direcci�n de correo electr�nico: 
		<a href="mailto:pw@propertyweb.eu?subject=Petici�n sobre el envio de la P�gina Sumario&body=Escriba aqui su solicitud indicando siempre la direcci�n de correo electr�nico afectado."  class="blancolink">pw@propertyweb.eu</a>
	  </b>
</td>
  </tr>
</table>
<br>
<% end if %>

</body>
</html>

<% sub noticias()		
	bloque="notici"
	strin="not"
	ErrMesage=""
	TITULO= "NOTICIAS"
	color="roj"
	Seccion2="NOTICIAS"
	Opciones = Request.QueryString("Opcion")
	
	SQL = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX,"
	SQL = SQL & "icono_seccion FROM C_NOTICIAS_INMOBILIARIAS "

	SQL = SQL & "WHERE (FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"	
	SQL = SQL & "AND TIPO_NOTICIA = 'N' "
	
	SQL=SQL & "AND web_es<> 0 " 
	
	SQL = SQL & "ORDER BY TIPOSECCION "
	
	test_inyeccion_sql sql
	Resultado.Open SQL,session("connPW"),1,1
	If Resultado.EOF and Resultado.BOF Then 
		ErrMesage="0 Noticias encontradas"
		call TABLA_TITULOS
		Resultado.Close
		Exit Sub
	End If
	
	call TABLA_TITULOS
	Resultado.Close
	ErrMesage=""
End Sub %>

<% sub cotilleos		
	bloque="rumore"
	strin="rum"
	TITULO= "RUMORES"
	'color="gri"
	color="roj"
	ErrMesage=""
	Seccion2="RUMORES"
	
	SQL = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX, icono_seccion "
	SQL = SQL & "FROM C_NOTICIAS_INMOBILIARIAS WHERE ("

	SQL = SQL & "FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"	
	SQL = SQL & "AND TIPO_NOTICIA = 'W' "

	SQL=SQL & "AND web_es<> 0 " 
	
	SQL = SQL & "ORDER BY TIPOSECCION " 
	
	test_inyeccion_sql sql
	Resultado.Open SQL,session("connPW"),1,1
	If Resultado.EOF and Resultado.BOF Then 
		ErrMesage="0 Rumores encontradas"
		call TABLA_TITULOS
		Resultado.Close
		Exit Sub
	End If

	call TABLA_TITULOS
	Resultado.Close
	ErrMesage=""
	
End Sub %>

<% sub estudios			
	bloque="estudi"
	strin="est"
	TITULO= "ESTUDIOS"
	'color="mor"
	color="roj"
	Seccion2="ESTUDIOS"
	ErrMesage=""

	SQL = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX, icono_seccion "
	SQL = SQL & "FROM C_NOTICIAS_INMOBILIARIAS WHERE ("
	
	SQL = SQL & "FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"	
	SQL = SQL & "AND TIPO_NOTICIA = 'E' "
	
	SQL=SQL & "AND web_es<> 0 " 
	
	SQL = SQL & "ORDER BY TIPOSECCION " 
	'SQL = SQL & "AND NOTICIAS_INMOBILIARIAS.ID_SECCION =" & IDseccion
	
	test_inyeccion_sql sql
	Resultado.Open SQL,session("connPW"),1,1
	If Resultado.EOF and Resultado.BOF Then 
		ErrMesage="0 Estudios encontrados"
			call TABLA_TITULOS
		Resultado.Close
		Exit Sub
	End If

call TABLA_TITULOS
Resultado.Close
ErrMesage=""
'RESPONSE.END
End Sub %>

<% sub demandas			
	bloque="demand"
	strin="dem"
	TITULO="ANUNCIOS"
	'color="mor"
	color="roj"
	Seccion2="DEMANDAS"
	ErrMesage=""

	SQL = "SELECT TITULO, ID, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, TITULO_ING AS TITULO_AUX, icono_seccion "
	SQL = SQL & "FROM C_NOTICIAS_INMOBILIARIAS WHERE ("
	
	SQL = SQL & "FECHA_NOTICIA BETWEEN  CONVERT(DATETIME, '" & dateadd("d",-7,fechaI) & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & dateadd("d",-7,fechaI) & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"	
	SQL = SQL & "AND TIPO_NOTICIA = 'B' AND web_es<> 0 "
	
	SQL = SQL & "ORDER BY TIPOSECCION " 
	'SQL = SQL & "AND NOTICIAS_INMOBILIARIAS.ID_SECCION =" & IDseccion
'	test_inyeccion_sql sql
'	Resultado.Open SQL,session("connPW"),1,1
'	If Resultado.EOF and Resultado.BOF Then 
'		ErrMesage="0 Anuncios de demandas encontrados"
'		call TABLA_TITULOS
'		Resultado.Close
'		Exit Sub
'	End If

'call TABLA_TITULOS
'Resultado.Close
ErrMesage=""
'RESPONSE.END
End Sub %>

<% sub ofertas			
	bloque="oferta"
	strin="ofertas"
	TITULO= "OFERTAS"
	bloque="oferta"
	Total = 0
	a = 0
	seccion2="Ofertas"
	ErrMesage=""
	'color = "ver"
	color="roj"
	
	sql = "SELECT * FROM anuncios_envio "
	sql = sql & "WHERE ("
	
	sql = sql & "(web_es<>0) AND ("
	sql = sql & "(FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) OR "
	sql = sql & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) OR "
	sql = sql & "NOT(FechaVisibleHasta < CONVERT(DATETIME, '" & FechaI & "', 103) OR FechaVisibleDesde > CONVERT(DATETIME, '" & FechaF & "', 103)) "
	sql = sql & ")"
	sql = sql & ") ORDER BY id_seccion, id_pais, provincia desc"
	
	test_inyeccion_sql sql
	Resultado.Open SQL,session("connPW"),1,1
	If Resultado.EOF and Resultado.BOF Then 
		Resultado.Close
		Exit Sub
	End If

	call TABLA_TITULOS
	Resultado.Close
	ErrMesage=""
End sub %>

<% sub operaciones()	
	bloque="operac"	
	strin = "ope"
	titulo = "OPERACIONES"
	'color = "pis"
	color="roj"
	Seccion2 = "OPERACIONES"
	ErrMesage = ""
	
	SQL = "SELECT ID, TITULO,TITULO_pt AS TITULO_AUX, FECHA_ACTUALIZACION, SECCION AS APARTADO "
	SQL = SQL & "FROM C_OPERACIONES "
	SQL = SQL & "WHERE (FECHA_PUBLICACION BETWEEN  CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
	SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103))"	
	
	'SQL=SQL & "AND web_pt<>0 " 
	SQL=SQL & "AND web_es<>0 " 
	SQL = SQL & "ORDER BY SECCION" 
	
	test_inyeccion_sql sql
	Resultado.Open SQL,session("connPW"),1,1
	If Resultado.EOF and Resultado.BOF Then 
		ErrMesage="0 Operaciones encontradas"
		call TABLA_TITULOS
		Resultado.Close
		Exit Sub
	End If

call TABLA_TITULOS
Resultado.Close
ErrMesage=""
End Sub %>

<% sub subastas			
bloque="subast"
strin="sub"
TITULO= "SUBASTAS"
'color="mor"
color="roj"
Seccion2="SUBASTAS2"
ErrMesage=""
SQL = "SELECT TITULO, Id_Concurso AS ID, FECHA_ACTUALIZACION, tipo_concurso AS APARTADO, icono_seccion "
SQL = SQL & "FROM C_CONCURSOS_DETALLE "
SQL = SQL & "WHERE ("
SQL = SQL & "FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103) OR "
SQL = SQL & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)"
SQL = SQL & ") AND web_es <> 0 "

SQL = SQL & "ORDER BY APARTADO "

test_inyeccion_sql sql
Resultado.Open SQL,session("connPW"),1,1
If Resultado.EOF and Resultado.BOF Then 
	ErrMesage="0 Subastas/Concursos encontrados"
	call TABLA_TITULOS
	Resultado.Close
	Exit Sub
End If
call TABLA_TITULOS
Resultado.Close
ErrMesage=""
End Sub %>

<% sub BarraTitulo %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td class="estiloceldaprincipal" width="495"><%= titulo %></td>
	</tr>
	<% if request.QueryString("envio")="Z_1" then %>
	<tr>
		<td class="blancolink">
		<a href="#notici">noticias</a>&nbsp;|&nbsp;
		<a href="#rumore">rumores</a>&nbsp;|&nbsp;
		<a href="#estudi">estudios</a>&nbsp;|&nbsp;
		<a href="#operac">operaciones</a>&nbsp;|&nbsp;
		<a href="#oferta">ofertas</a>&nbsp;|&nbsp;
		<a href="#demand">anuncios</a>&nbsp;|&nbsp;
		<a href="#subast">subastas</a>
		</td>
	</tr>
	<% end if %>
</table>
<% end sub %>

<% sub BarraFecha() 	
'if envio=true and inversa<>true then
	diasemana=weekday(fechai,1)
	select case left(diasemana,5)	
		case 2 
			lmxjv="0"
			lun=datevalue(fecha)
			mar=datevalue(fecha)-6
			mie=datevalue(fecha)-5
			jue=datevalue(fecha)-4
			vie=datevalue(fecha)-3
		case 3 
			lmxjv="1"
			lun=datevalue(fecha)-1
			mar=datevalue(fecha)
			mie=datevalue(fecha)-6
			jue=datevalue(fecha)-5
			vie=datevalue(fecha)-4
		case 4 
			lmxjv="2"
			lun=datevalue(fecha)-2
			mar=datevalue(fecha)-1
			mie=datevalue(fecha)
			jue=datevalue(fecha)-6
			vie=datevalue(fecha)-5
		case 5 
			lmxjv="3"
			lun=datevalue(fecha)-3
			mar=datevalue(fecha)-2
			mie=datevalue(fecha)-1
			jue=datevalue(fecha)
			vie=datevalue(fecha)-6
		case 6 
			lmxjv="4"
			lun=datevalue(fecha)-4
			mar=datevalue(fecha)-3
			mie=datevalue(fecha)-2
			jue=datevalue(fecha)-1
			vie=datevalue(fecha)
		case 7 
			lmxjv="4"
			lun=datevalue(fecha)-5
			mar=datevalue(fecha)-4
			mie=datevalue(fecha)-3
			jue=datevalue(fecha)-2
			vie=datevalue(fecha)-1
		case 1 
			lmxjv="4"
			lun=datevalue(fecha)-6
			mar=datevalue(fecha)-5
			mie=datevalue(fecha)-4
			jue=datevalue(fecha)-3
			vie=datevalue(fecha)-2
	end select

	iniciosemana=datevalue(fecha)-6
	finalsemana=datevalue(iniciosemana)+ 6
	iniciosemana2=datevalue(iniciosemana)-7

	if semana=true then lmxjv=5
	sem=iniciosemana & "-" & finalsemana
	if semana=true then
		fecha=sem
	end if
'end if
%>
<table width="100%" cellspacing=2 cellpadding=2>
	<tr>
		<td>
<% 'if envio=true and swMostradaListaFechas<>true then %>
P&aacute;g. Sumario: 
	  <select name="R1">
			<option value="<%=lun%>" <% if lmxjv=0 then response.Write "selected" %>>Lunes &nbsp; <%= lun %></option>
			<option value="<%=mar%>" <% if lmxjv=1 then response.Write "selected" %>>Martes &nbsp; <%= mar %></option>
			<option value="<%=mie%>" <% if lmxjv=2 then response.Write "selected" %>>Mi&eacute;rcoles &nbsp; <%= mie %></option>
			<option value="<%=jue%>" <% if lmxjv=3 then response.Write "selected" %>>Jueves &nbsp; <%= jue %></option>
			<option value="<%=vie%>" <% if lmxjv=4 then response.Write "selected" %>>Viernes &nbsp; <%= vie %></option>
		  </select>
		  <input name="cmdVer" type="submit" value="Fecha">
<% 'end if
swMostradaListaFechas=true
%>
		</td>
	</tr>
</table>

<% end sub %>

<% sub test_inyeccion_sql(rSql)	
	cPasa=true
	crSql=lcase(rSql)
	
	if instr(crSql, "declare") then cPasa=false
	if instr(crSql, "update") then cPasa=false
	if instr(crSql, "chr(") then cPasa=false
	if instr(crSql, "http") then cPasa=false
	
	if not(cPasa) then
		
		sqlReg = "INSERT INTO ataques (session_id, fecha, hora, ip, querystring, form, cookie_pw, cookie_licencia, referer) VALUES ("
		sqlReg = sqlReg & "'" & session.SessionID & "', '" & date & "', '" & time & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("REMOTE_ADDR") & "', "
		
		sqlReg = sqlReg & "'" & AcomodaTexto(request.QueryString) & "', "
		sqlReg = sqlReg & "'" & AcomodaTexto(request.Form) & "', "

		sqlReg = sqlReg & "'" & request.Cookies("pw") & "', "
		sqlReg = sqlReg & "'" & request.Cookies("licencia") & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("HTTP_REFERER") & "'"
		
		sqlReg = sqlReg & ")"
		
		session("connPWAcesos").execute sqlReg
		
		'configurar servidor email 
		Set Mail = Server.CreateObject("Persits.MailSender")
		Mail.Host = "smtp.propertyweb.eu"
		Mail.Port = 25 
		Mail.Username = "lcf013c"
		Mail.Password = "PWeu08"
		
		'Variables Mail  
		Mail.From = "informatica@propertyweb.eu"
		Mail.FromName = "Servidor NAVIA"
		
		Mail.AddAddress "informatica@propertyweb.eu", "jp"
		Mail.Subject = "Aviso de Ataque SQL"
	
		'Mail 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Se ha detectado un ataque SQL.</p>" & "<br>"
		txtMail = txtMail & "<p>" & date & " " & time & "</p>"
		txtMail = txtMail & "<p>REMOTE_ADDR: " & request.ServerVariables("REMOTE_ADDR") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>HTTP_REFERER:<br>" & request.ServerVariables("HTTP_REFERER") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>QueryString:<br>" & request.QueryString & "</p>" & "<hr>"
		txtMail = txtMail & "<p>Form:<br>" & request.Form & "</p>" & "<hr>"
		txtMail = txtMail & "</BODY></HTML>"
		
		Mail.Body = txtMail
		Mail.IsHTML = True
		
		'Enviar 
		On Error Resume Next
		Mail.Send 
		
		response.End()
	end if
	
end sub %>