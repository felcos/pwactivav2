<% 'Variables globales 
	public num_titulo 
	public enlace
	public target
	public hoy
%>

<% SUB NUEVA_SECCION(ap) %>
	<tr><td width="100%" align="right">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr height="6"><td></td></tr>
    <tr><td valign="top" class="pagsum_apartados"><%= lcase(ap) %></td></tr>
    <tr height="2"><td></td></tr>
</table>
		</td></tr> 
<% end sub %>
<% SUB NUEVA_SECCION_OP(ap) %>
	<tr><td valign="top" class="pagsum_apartados"><%= CalcularSeccionOp(ap) %></td></tr> 
<% end sub %>

<% sub TablaResultados()	
num_titulo=0
target ="_blank" 
'en el caso de Noticias cuando cambie a rumor debe parar y rellenar otra tabla
if seccion="not" then tipo=Resultado("TIPO_NOTICIA")
'Esta variable me controla los apartados
apart= ""
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">	
<% do while not resultado.EOF
	if seccion="not" then
		if tipo<>Resultado("TIPO_NOTICIA") then exit do
		tipo=Resultado("TIPO_NOTICIA")
	end if
	if apart<>Resultado("APARTADO") and Resultado("APARTADO")<>"NO" then 
		if bloque="operac" then
			call NUEVA_SECCION_OP(Resultado("APARTADO"))
		else
			call NUEVA_SECCION(Resultado("APARTADO"))
		end if
	end if
	apart=Resultado("APARTADO")
	'a=a+1
	num_titulo=num_titulo+1
	contador=contador+1
	enlace="https://www.propertyweb.eu"
	
	if seccion2="Ofertas" then
		strin=resultado("secc")
	end if
	'response.write seccion2
	if Seccion2="Ofertas" then 
		enlace=enlace & "/anuncios/ver.asp?" & strin &"=" & Resultado("ID") & "&origen=" & origen
		hoy="false"
	else
		enlace=enlace & "/articulos/?" & strin &"=" & Resultado("ID") & "&origen=" & origen
		Hoy="false"
	end if
	%> 
    <tr><td><% TablaTitulos() %></td></tr>
    <tr><td colspan="4"></td></tr>            
	<% resultado.movenext
loop
%> 
</table>
<% end sub %>

<% sub CalcularTitulo()	
	IF LEN(resultado("TITULO"))<3 OR ISNULL(resultado("TITULO")) THEN 
		RESPONSE.WRITE Resultado("TITULO_AUX")
		'"<font class='azullink' color='#999999'>" & Resultado("TITULO_AUX") & "</FONT>"
	ELSE
		RESPONSE.WRITE Resultado("TITULO")
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

<% sub TablaTitulos	%>
<table border="0" width="100%">
	<tr>
		<td width="10">
<small><input type=checkbox name="<%=strin%>" value="<%=Resultado("ID")%>" <% if checked="true" then response.write "checked" %> class="chexbox"></small>
		</td>
		<td width="10" align="center" class="titroj">
<a href="<%= enlace %>" class="titroj" target="_blank"><%= num_titulo %></a>
		</td>
		<td width="100%" valign="center" class="titroj">
<a href="<%= enlace %>" class="titroj" target="_blank"><% CalcularTitulo() %></a>
		</td>
        <td width="10" class="titroj" valign="middle" align="right"><%=Resultado("FECHA_ACTUALIZACION")%></td>
	</tr>
</table>
<% end sub %>


<% sub TABLA_TITULOS() 
	select case bloque
	case "notici"
		imgBloque="actualidad.png"
	case "rumore"
		imgBloque="web_ha_oido.png"
	case "estudi"
		imgBloque="estudios.png"
	case "operac"
		imgBloque="dealanalisys.png"
	case "demand"
		imgBloque="demandas.png"
	case "subast"
		imgBloque="subastas.png"
	case else
		imgBloque="vacia.png"
	end select
	rr="/img/flash/" & imgBloque
%>
<table width="680" cellpadding="2" cellspacing="2" border="1" class="estilotabla">
	<tr><td class="tit_tabla"><img src="<%= rr %>" alt="<%=titulo%>"></td></tr>
<% if request.Cookies("dev")("sql")<>"" then %>
    <tr><td><p><%= resultado.source %></p></td></tr>
<% end if %>
	<tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF">
    <tr>
        <td>
<table width="100%" border="0" cellspacing="4" cellpadding="0" bgcolor="#FFFFFF"> 
	<tr><td><% TablaResultados() %></td></tr>
</table>
		</td>
		<td width="6" align="right"></td>
	</tr>
</table>
		</td></tr>
	<tr height="12"><td></td></tr>
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
