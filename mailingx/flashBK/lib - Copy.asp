<%
'dim busqueda
dim origen

dim bloque
dim strin
dim ErrMesage
'dim titulo  
dim num_titulo
dim apart
dim seccion2
dim tipowtb
dim ulwtb
Set resultado = Server.CreateObject("ADODB.Recordset")

public enlace
public target
public hoy

dim apart_primero
%>





<% sub BloqueTitulosT4ac()	
	apart=""
	apart_primero = true
	%>
	<div class="bloque">
	    <% do while not resultado.EOF

			
			num_titulo=num_titulo+1
			enlace = "/articulos/?" & strin &"=" & resultado("id") & origen
			
			%>
<div class="articulo"><input type="checkbox" name="<%= strin %>" value="<%= Resultado("id") %>"><a href="<%= enlace %>" class="simplemodal"><% TituloT4ac(resultado) %></a></div>
			<% resultado.movenext
		loop %>
	</div>
<% end sub %>


<% sub BloqueTitulosWTB()	
	apart=""
	apart_primero = true
	%>
	<div class="bloque">
	    <% do while not resultado.EOF

			if ulwtb<>Resultado("ID_NOTICIA") then
				ulwtb=Resultado("ID_NOTICIA")
			num_titulo=num_titulo+1
			if Resultado("TipoComentario")="N" or Resultado("TipoComentario")="W" or Resultado("TipoComentario")="E" or Resultado("TipoComentario")="T4AC" then 
				if (isnull(Resultado("TIPO_NOTICIA"))) then
					tipowtb="not"
				else
					if Resultado("TIPO_NOTICIA")="N" then
						tipowtb="not"
					end if
					if Resultado("TIPO_NOTICIA")="W" then
						tipowtb="rum"
					end if
					if Resultado("TIPO_NOTICIA")="E" then
						tipowtb="est"
					end if
					if Resultado("TipoComentario")="T4AC" then
						tipowtb="t4a"
					end if
				end if
				enlace = "/articulos/?" & tipowtb &"=" & resultado("ID_NOTICIA") & origen
				if tipowtb="t4a" then
%>
<div class="articulo"><input type="checkbox" name="<%= strin %>" value="<%= Resultado("ID_NOTICIA") %>"><a href="<%= enlace %>" class="simplemodal"><% TituloWTBt(resultado) %></a></div>
<% if (Resultado("Comentario")<>"-Like-") then %>
<p style="color:#759FB7;margin: 0px 0px 0px 33px;">
<%=Resultado("Comentario") %> 
</p>
<% end if  %>
<% 

				else
%>
<div class="articulo"><input type="checkbox" name="<%= strin %>" value="<%= Resultado("ID_NOTICIA") %>"><a href="<%= enlace %>" class="simplemodal"><% TituloWTBn(resultado) %></a></div>
<% if (Resultado("Comentario")<>"-Like-") then %>
<p style="color:#759FB7;margin: 0px 0px 0px 33px;">
<%=Resultado("Comentario") %> 
</p>
<% end if  %>


<% 
				end if



			else
				if Resultado("TipoComentario")="O" then
					enlace = "/articulos/?ope=" & resultado("IDOPERACION") & origen
%>
<div class="articulo"><input type="checkbox" name="<%= strin %>" value="<%= Resultado("IDOPERACION") %>"><a href="<%= enlace %>" class="simplemodal"><% TituloWTBo(resultado) %></a></div>

<% if (Resultado("Comentario")<>"-Like-") then %>
<p style="color:#759FB7;margin: 0px 0px 0px 33px;">
<%=Resultado("Comentario") %> 
</p>
<% end if  
				end if
			end if
			
			end if
			%>

			<% resultado.movenext
		loop %>
	</div>
<% end sub %>



<% sub BloqueTitulos()	
	apart=""
	apart_primero = true
	%>
	<div class="bloque">
	    <% do while not resultado.EOF
		    if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then
				apart = resultado("APARTADO")
				call Apartado(apart)
			end if
			
			num_titulo=num_titulo+1
			enlace = "/articulos/?" & strin &"=" & resultado("ID") & origen
			'enlace = strin &"=" & resultado("ID")
			%>
<div class="articulo"><input type="checkbox" name="<%= strin %>" value="<%= resultado("id") %>"><a href="<%= enlace %>" class="simplemodal"><% Titulo(resultado) %></a></div>
			<% resultado.movenext
		loop %>
	</div>
<% end sub %>
<% sub BloqueTitulosEasy()	
	apart=""	%>
	<div class="bloque">
	    <% 
		apart_primero = true
		do while not resultado.EOF
		    if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then
				apart = resultado("APARTADO")
				call Apartado(apart)
			end if
			
			num_titulo=num_titulo+1
			'enlace = "/articulos/?" & strin &"=" & resultado("ID")
			
			enlace = "https://www.easyproperty.es/ofertas/?id=" & resultado("ID")	' & "&orign=flash"
			'target="_blank"
			%>
<div class="articulo"><input type="checkbox" disabled="disabled" name="<%= strin %>" value="<%= Resultado("ID") %>"><a href="<%= enlace %>" class="simplemodal"><% Titulo(resultado) %></a></div>
			<% resultado.movenext
		loop %>
	</div>
<% end sub %>

<% sub BloqueVencimientos(byRef pRS)	
num_titulo=0
%>
<div class="bloque">
    <div class="vencim_encabezado">
        <div class="vencim_empresa">Tipo de Empresa</div>
        <div class="vencim_sup">M2 actuales</div>
        <div class="vencim_ubic">Ubicaci&oacute;n</div>
        <div style="clear:both;"></div>
    </div>
	<% apart= ""
    do while not pRS.EOF
        if apart<>pRS("APARTADO") and pRS("APARTADO")<>"NO" then 
        	apart = pRS("APARTADO")
			call Apartado(apart)
        end if
		
        num_titulo=num_titulo+1
        articulos=articulos+1
        
        enlace = enlace_base & strin &"=" & pRS("ID") & origen
        Hoy="false"	
        
        cTitulo=pRS("TITULO")
		if instr(lcase(cTitulo), "compr") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "compr")-2)
		elseif instr(lcase(cTitulo), "prealquil") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "prealquil")-2)
		elseif instr(lcase(cTitulo), "alquil") then
			cTitulo=left(cTitulo, instr(lcase(cTitulo), "alquil")-2)
		end if
	
		cUbicacion = pRS("localidad")
		if lcase(pRS("provincia"))<>lcase(pRS("localidad")) then
			if len(cUbicacion)>21 then cUbicacion = left(cUbicacion, 18) & "..."
			cUbicacion = cUbicacion & " (" & pRS("provincia") & ")"
		end if
		'if len(cUbicacion)>22 then cUbicacion = replace(cUbicacion, " (", " (")
		
		%>
        <div class="articulo">
            <div class="vencim_empresa"><input type="checkbox" name="<%=strin%>" value="<%= Resultado("ID") %>"><a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cTitulo %></a></div>
            <div class="vencim_sup"><a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= formatnumber(pRS("metros_cuadrados"),0)  %>&nbsp;M2&nbsp;</a></div>
            <div class="vencim_ubic"><a href="<%= enlace %>" <% if origen="DailyFlash" then %>target="_blank"<% else %>class="simplemodal"<% end if %>><%= cUbicacion %></a></div>
        	<div style="clear:both;"></div>
        </div>
		<% pRS.movenext
    loop %>
</div>
<% end sub %>

<% sub Apartado(pTit) 
	if session("modo")="daniel" then 
		%><h3><%= pTit %></h3><%
	else %>
	<div class="apartado<% if apart_primero then %>_primero<% end if %>"><%
		if session("modo")="old" or session("modo")="jm" then 
			%><img src="/img/flash/apunta.gif"><strong>&nbsp;<%= pTit %></strong><%
		else
			%><h3 class="tit_buscadores2"><%= pTit %></h3><%
		end if 
	%></div>
	<% end if
	
	apart_primero = false
	
end sub %>

<% sub Titulo(byRef pRS)	
	IF len(resultado("TITULO"))<3 OR isnull(resultado("TITULO")) THEN 
		response.write pRS("TITULO_AUX")
	ELSE
		response.write pRS("TITULO")
	END IF
end sub %>

<% sub TituloT4ac(byRef pRS)	
	IF (isnull(resultado("Titulo"))) THEN 
		response.write pRS("Apellidos") & " " & pRS("Nombres") & " " & pRS("Posicion2")
	ELSE
		response.write pRS("Titulo") 
	END IF
end sub %>

<% sub TituloWTBo(byRef pRS)	
	IF (isnull(resultado("TITULO2"))) THEN 
		response.write "Op... WTB(" & pRS("NroComentariosO") & ")"
	ELSE
		response.write pRS("TITULO2") & " (" & pRS("NroComentariosO") & ") <img src='https://www.propertyweb.eu/rrss/likeicon.png' width='16px' />"
	END IF
end sub %>

<% sub TituloWTBn(byRef pRS)	
	IF (isnull(resultado("TITULO"))) THEN 
		response.write "Noticia... WTB(" & pRS("NroComentariosN") & ")"
	ELSE
		response.write pRS("TITULO") & " (" & pRS("NroComentariosN") & ") <img src='https://www.propertyweb.eu/rrss/likeicon.png' width='16px' />"
	END IF
end sub %>

<% sub TituloWTBt(byRef pRS)	
	IF (isnull(resultado("TITULOT4AC"))) THEN 
		response.write "Time4AChange... WTB(" & pRS("NroComentariosT") & ")"
	ELSE
		response.write pRS("TITULOT4AC") & " (" & pRS("NroComentariosT") & ") <img src='https://www.propertyweb.eu/rrss/likeicon.png' width='16px' />"
	END IF
end sub %>


<% sub ZZZ_TablaResultados(byRef pRS)	
num_titulo=0
%>
<table class="ResultItem" border="0" width="100%">
<tbody>
<% if request.Cookies("dev")("sql")<>"" and 1=2 then %>
    <tr><td colspan="4"><%= pRS.source %></td></tr>
<% end if %>
	<% if seccion2="VENCIMIENTOS" then %><tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="top">
	<td width="20"></td>
    <td>Tipo de Empresa</td>
	<td width="90" align="right">M2 actuales&nbsp;</td>
	<td width="145">&nbsp;Ubicaci&oacute;n&nbsp;</td>
  </tr>
</table>
		</td></tr><% end if %>
<% if ErrMesage<>"" then %>
	<tr> 
		<td width="76%" align="center"><%= ErrMesage %></td>
	</tr>
<% else 'if ErrMesage<>""... %>	  
	<%'en el caso de Noticias cuando cambie a rumor debe parar y rellenar otra tabla
		if seccion="not" then tipo=pRS("TIPO_NOTICIA")
		'Esta variable me controla los apartados
		apart= ""
		Do While Not pRS.EOF
			if seccion="not" then
				if tipo<>pRS("TIPO_NOTICIA") then exit do
				tipo=pRS("TIPO_NOTICIA")
			end if
			if apart<>pRS("APARTADO") and pRS("APARTADO")<>"NO" then 
				if bloque="operac" then
					call NUEVA_SECCION_OP(pRS("APARTADO"))
				else
					%><tr><td colspan="2"><div class="apartado_tit"><img src="/img/flash/apunta.gif"><strong>&nbsp;<%= resultado("APARTADO") %></strong></div><hr></td></tr><%
					'call NUEVA_SECCION(pRS("APARTADO"))
				end if
			end if
			apart=pRS("APARTADO")
			'a=a+1
			num_titulo=num_titulo+1
			articulos=articulos+1
			
			enlace = enlace_base & strin &"=" & pRS("ID") & "&origen=" & origen
			Hoy="false"	
			%>
    <tr><td class="firstRow"><% Titulo(pRS) %></td></tr>
	<tr><td colspan="4"></td></tr>
    <% pRS.movenext
		loop
	%>
<% end if %>
</tbody>
</table>
<% end sub %>

