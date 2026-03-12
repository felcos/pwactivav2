<!--#include virtual="/inc/reg_accesos.asp" -->
<html>
<head>
<title>T&iacute;tulos Propertyweb</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/jp/inc/main.css" rel="stylesheet" media="screen">
</head>
<body bgcolor="#ffffff">
<img src="/img/flash/dealanalisys.png" width="425" height="32" border="0">
<%
'Variables globales 
public num_titulo 
public enlace
public target
public hoy

Public SQL
Public ErrMesage

Set resultado = Server.CreateObject("ADODB.Recordset")
resultado.PageSize = 10000

'sqlW = " (web_es<>0) AND (titulo LIKE '%lease%' OR comentarios LIKE '%lease%')"
sqlW = " (web_es<>0 AND id_pais=1 AND fecha_publicacion>='01/01/2007') AND id IN (SELECT * FROM _pilar_operaciones)"
'sqlW = " (web_es<>0 AND id IN (SELECT * FROM _operaciones_drago))"

sql = "SELECT C_OPERACIONES.*, C_OPERACIONES.seccion AS APARTADO FROM "
if request.QueryString("id")="" then	
	sql= sql &  "C_OPERACIONES "
else	'por si estamos en agentes
	sql = sql & "C_OPERACIONES LEFT OUTER JOIN OPERACIONES_CONTACTOS ON C_OPERACIONES.ID = OPERACIONES_CONTACTOS.id_operacion "
end if
sql = sql & "WHERE (" & sqlW & ") "
sql = sql & "ORDER BY C_OPERACIONES.seccion, C_OPERACIONES.FECHA_ACTUALIZACION DESC"

' �En qu� p�gina estamos?
if request.QueryString("pag")="" then
	Session("CurrentPage") = 1
else
	Session("CurrentPage") = request.QueryString("pag")
end if
'response.Write("<p>" & Session("CurrentPage") & "</p>")

seccion=Request.Form("seccion")
bloque="operac"
titulo="OPERACIONES"
color="pis"
Limite=500
'Limite=150
strin="operac"
origen="busope"

'call Abrir_Recordset()
if ErrMesage="" then
	session("connPW").CommandTimeout = 120
	response.flush
	'response.write sql
	'response.end
	
	resultado.Open SQL, session("connPW"), 1, 1
	'if limite<resultado.recordcount then ErrMesage=Resultado.recordcount & " Art�culos Encontrados " & limite & "<br>Depure la B�squeda"
	if resultado.EOF and resultado.EOF then ErrMesage= "No Existe ning�n resultado<br>Cambie los criterios de su b�squeda"
	
	if Session("CurrentPage") <= 1 then Session("CurrentPage") = 1
	if CLng(Session("CurrentPage")) >= CLng(resultado.PageCount) then Session("CurrentPage") = resultado.PageCount 
	if not resultado.eof then resultado.AbsolutePage = CLng(Session("CurrentPage"))
	
	num_titulo = resultado.PageSize * (resultado.AbsolutePage-1)
end if
%>
<form name="titulos" method="POST" align="center" action="/articulos/" target="_blank" class="noMargin">
<table width="100%" cellpadding="2" cellspacing="2" border="0" class="estilotabla">
	<% if request.Cookies("dev")("sql")<>"" then %>
    <tr><td colspan="2"><%= sqlW %></td></tr>
	<% end if %>
	<tr><td>
<% TablaResultados() %>		
		</td></tr>
<% if ErrMesage="" then %>
	<tr><td height="4" align="right"><% call paginar(resultado) %></td></tr>
    <tr><td height="4"></td></tr>
    <tr><td align="center"><input type="submit" id="B1" name="B1" value="Leer Art�culos Seleccionados"></td></tr>
<% end if %>    
</table>
<br>
</form>

<%
if ErrMesage="" then
	resultado.close
	set resultado=nothing
end if
%>
<% SUB NUEVA_SECCION_OP(ap) %>
	<tr><td valign="top" class="pagsum_apartados"><%= CalcularSeccionOp(ap) %></td></tr> 
<% end sub %>

<% sub TablaResultados()	
'num_titulo=0
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% if ErrMesage<>"" then %>
	<tr> 
		<td width="76%" class="txtTabla" align="center"><%= ErrMesage %></td>
	</tr>
	<tr> 
		<td width="76%" class="txtTabla" align="center"><br><a href="javascript:history.back();" class="titroj">volver al formulario de b&uacute;squeda</a></td>
	</tr>
<% else 'if ErrMesage<>""... 	
	target="main"
	'en el caso de Noticias cuando cambie a rumor debe parar y rellenar otra tabla
		if seccion="not" then tipo=Resultado("TIPO_NOTICIA")
		'Esta variable me controla los apartados
		apart= ""
		'Do While Not resultado.EOF
		For i = 1 To resultado.PageSize
			if resultado.eof then exit for
		
			if apart<>Resultado("seccion") and Resultado("seccion")<>"NO" then 
				call NUEVA_SECCION_OP(Resultado("seccion"))
			end if
			apart=Resultado("seccion")
			'a=a+1

			num_titulo=num_titulo+1
			contador=contador+1
			enlace="https://www.propertyweb.eu"
			enlace=enlace & "/articulos/?" & strin &"=" & Resultado("ID")
			Hoy="false"
	%> 
	<tr><td><% TablaTitulos() %></td></tr>
	<tr><td colspan="4"></td></tr>                
	<%	resultado.movenext
		next
		'loop
end if %> 
</table>
<% end sub %>

<% sub CalcularTitulo()	
	IF LEN(resultado("TITULO"))<3 OR ISNULL(resultado("TITULO")) THEN 
		RESPONSE.WRITE Resultado("TITULO_AUX")
	'	CalcularTitulo="<font class='azullink' color='#999999'>" & Resultado("TITULO_AUX") & "</FONT>"
	ELSE
		RESPONSE.WRITE Resultado("TITULO")
	'	CalcularTitulo=Resultado("TITULO")
	END IF
end sub %>

<% sub BotonEnviar()	%>
	<% if origen<>"infemp" then %>
		<input type="hidden" name="origen" value="<%= origen %>">
	<% end if %>
	<% if ErrMesage="" then %>
		<input type=image src="/images/buscar/es/<%= bloque %>.jpg" border="0" name="B1">
	<% end if %>
<% end sub %>

<% sub TablaTitulos		
target="_blank"
%>
<table width="100%" border="0">
	<tr>
		<% if no_form_send<>true then %>
		<td width="10">
			<small>
			<input type=checkbox name="<%=strin%>" value="<%=Resultado("ID")%>" 
			<% if checked="true" then response.write "checked" %> class="chexbox">
			</small>
		</td>
		<% end if %>
		<td width="10" align="center" class="tit<%= color %>">
			<a href="<%= enlace %>" class="tit<%= color %>" target="<%= target %>"><%= num_titulo %></a>
		</td>
		<td width="100%" valign="center" class="tit<%= color %>">
			<a href="<%= enlace %>" class="tit<%= color %>" <%' if envio<>true then %> target="<%= target %>" <%' end if %> >							
			<% CalcularTitulo() %>
			</a>
		</td>
		<% If hoy="true" then %>
		<td width="10" class="txtTabla" valign="top" align="right">
			<a href="<%= enlace %>" target="<%= target %>">
			<img src="/images/accesolibre.jpg" align="right" valign="center"  border="0">
			</a>
		</td>
		<% end if %>
		<% if origen<>"pagsum" and origen<>"pagsuF" then %>
			<td width="10" class="tit<%=color%>" valign="middle" align="right"><%=Resultado("FECHA_ACTUALIZACION")%></td>
		<% end if %>
	</tr>
</table>
<% end sub %>

<% function CalcularSeccionOp(pIds)	
	cIds = "," & pIds
	
	Set rsSecc = Server.CreateObject("ADODB.Recordset")
	rsSecc.open "SELECT * FROM TIPOS_DE_SECCIONES_OPERACIONES", session("connPW")	', 1, 1
	do while not rsSecc.eof
		
    	cIds = replace(cIds, "," & rsSecc("ID") & ",", lcase(rsSecc("NOMBRE")) & ",")
		rsSecc.movenext
	loop
	
	rsSecc.close
	set rsSecc=nothing
	
	'cIds = replace(cIds, ",", "/")
	'cIds = cIds & "/"
	'cIds = replace(cIds, "//", "")
	cIds = replace(cIds, ",", "")
	
	CalcularSeccionOp=cIds 
	
end function %>

<% sub paginar(byRef pRS) 	
	if pRS.PageCount<=1 then exit sub
	link_pag=""
	for each elto in request.QueryString
		if elto<>"pag" and request.QueryString(elto)<>"" then
			if link_pag<>"" then link_pag = link_pag & "&"
			link_pag = link_pag & elto & "=" & request.QueryString(elto)
		end if
	next
	if link_pag<>"" then link_pag = link_pag & "&"
	%>
<table border="0" cellspacing="0" cellpadding="0" style="border-top: 1px solid #999999;">
  <tr>
	<td align="center">p&aacute;g. <%= Session("CurrentPage") %> de <%= pRS.PageCount %> &nbsp; (<%= pRS.recordcount %> operaciones)</td>
    <td width="25"></td>
  	<td width="25" align="center" class="titpis"><a href="?<%= link_pag %>pag=1"><strong>&lt;&lt;</strong></a></td>
    <td width="15" align="center" class="titpis"><a href="?<%= link_pag %>pag=<%= Session("CurrentPage")-1 %>"><strong>&lt;</strong></a></td>
    <td width="15"></td>
<% for ii=1 to pRS.PageCount 
	if clng(ii)=clng(Session("CurrentPage")) then %>
    <td width="15" align="center" class="titpis"><strong><%= ii %></strong></td>
    <% else %>
    <td width="15" align="center" class="titpis"><a href="?<%= link_pag %>pag=<%= ii %>"><%= ii %></a></td>
	<% end if
next %>
    <td width="15"></td>
    <td width="15" align="center" class="titpis"><a href="?<%= link_pag %>pag=<%= Session("CurrentPage")+1 %>"><strong>&gt;</strong></a></td>
    <td width="25" align="center" class="titpis"><a href="?<%= link_pag %>pag=<%= pRS.PageCount %>"><strong>&gt;&gt;</strong></a></td>
  </tr>
</table>
	<% 
	'response.Write("<p>" & verGoogleMaps & "</p>")
end sub %>

</body>
</html>

