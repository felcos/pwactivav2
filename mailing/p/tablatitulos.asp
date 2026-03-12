<% 
'tablatitulos PDA

'Variables globales 
public num_titulo 
public enlace
public target
public hoy
%>
<% sub TABLA_TITULOS() %>
<!--<br>-->

<a name="<%= bloque %>"></a>
	<table class="estilotabla" width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td class="estilocelda3"><%= titulo %></td>
		</tr>
	</table>
	<% TablaResultados() %>
	<br />

<% end sub %>

<% sub NUEVA_SECCION(ap) %>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td width="100%" valign="top" class="mor2"><%= ap %></td>	
</tr>
<% end sub %>


<% sub TablaTitulos	
target="_blank"
%>
<table border="0" width="100%">
	<tr>

		<td width="10" align="center" valign="top" class="negro"><%= num_titulo %></td>
		<td valign="center" class="tit<%= color %>">
			<a href="<%= enlace %>" class="tit<%= color %>" <%' if envio<>true then %> target="<%= target %>" <%' end if %> >							
			<% CalcularTitulo() %>
			</a>
		</td>
<% if origen<>"pagsum" and origen<>"pagsuF" then %>
		<td width="10" class="tit<%=color%>" valign="middle" align="right"><%=resultado("FECHA_ACTUALIZACION")%></td>
<% end if %>
	</tr>
</table>
<% end sub %>

<% sub CalcularTitulo()	
	IF LEN(resultado("TITULO"))<3 OR ISNULL(resultado("TITULO")) THEN 
		RESPONSE.WRITE resultado("TITULO_AUX")
	ELSE
		RESPONSE.WRITE resultado("TITULO")
	END IF
end sub %>

<% sub TablaResultados()	
num_titulo=0
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<% if ErrMesage<>"" then %>
	<tr> 
		<td class="txtTabla" align="center"><%= ErrMesage %></td>
	</tr>
<% else 
		'en el caso de Noticias cuando cambie a rumor debe parar y rellenar otra tabla
		if seccion="not" then tipo=resultado("TIPO_NOTICIA")
		'Esta variable me controla los apartados
		apart= ""
		Do While Not resultado.EOF
			if seccion="not" then
				if tipo<>resultado("TIPO_NOTICIA") then exit do
				tipo=resultado("TIPO_NOTICIA")
			end if
			if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then 
				call NUEVA_SECCION(resultado("APARTADO"))
			end if
			apart=resultado("APARTADO")
			num_titulo=num_titulo+1
			contador=contador+1
			
			if bloque="oferta" then
				enlace="https://www.easyproperty.es"
				enlace = enlace & "/ofertas/?id=" & resultado("ID") & "&origen=mail_pda"
			else
				enlace="https://www.propertyweb.eu"
				enlace = enlace & "/articulos/?" & strin &"=" & resultado("ID") & "&origen=mail_pda"
			end if
			
			hoy = "false"
%> 
                  <tr> 
					<td><% TablaTitulos() %></td>
  </tr>     
<% resultado.movenext
		loop
end if %> 
</table>
<% end sub %>
