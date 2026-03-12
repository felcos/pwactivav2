<% Public sub noticias		
	strin="not"
	titulo="NOTICIAS"
	color="roj"
	bloque="notici"
	
	sql = "SELECT ID, TITULO, TITULO_PT, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, icono_seccion FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("noticias")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
		
	server.ScriptTimeout=400
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1
	
	if resultado.eof and resultado.bof then
		N=0
		'if request.Cookies("dev")("sql")<>"" then response.Write(sql)
	else
		resultado.movelast
		N=resultado.recordCount
		resultado.movefirst
		'TITULO=titulo & " " & N
'		if cliente="true" then
			if clienteseccion="false" then ErrMesage="Usted es cliente pero no tiene contratada esta secci�n."
'			if N>limitenoticias then ErrMesage="Demasiadas noticias, l�mite " & limitenoticias & "."
			
			call TablaResultados("not")
'		end if
	end if
	resultado.close
	ErrMesage=""
end sub %>
<% Public sub estudios		
	strin="est"
	titulo="ESTUDIOS"
	color="mor"
	bloque="estudi"
	
	sql = "SELECT ID, TITULO, TITULO_PT, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, icono_seccion FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("estudios")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql,session("connPW"), 1, 1
	
	if resultado.eof and resultado.bof then
		E=0
	else
		resultado.movelast
		E=RESULTADO.RECORDCOUNT
		resultado.movefirst
		'TITULO=titulo & " " & E
'		if cliente="true" then
			if clienteseccion="false" then ErrMesage="Usted es cliente pero no tiene contratada esta secci�n."
'			if E>limiteestudios then ErrMesage="Demasiados Estudios, l�mite " & limiteestudios & "."
			
			call TablaResultados("est")
'		end if
	end if
	resultado.close
	ErrMesage=""
end sub %>
<% Public sub cotilleos		
	strin="rum"
	titulo="RUMORES"
	color="gri"
	bloque="rumore"
	sql = "SELECT ID, TITULO, TITULO_PT, FECHA_ACTUALIZACION, TIPOSECCION AS APARTADO, icono_seccion FROM C_NOTICIAS_INMOBILIARIAS"
	sql = sql & " WHERE " & calcular_sqlw("rumores")
	sql = sql & " ORDER BY TIPOSECCION, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql,session("connPW"), 1, 1

	if resultado.eof and resultado.bof then
		R=0
	else
		resultado.movelast
		R=RESULTADO.RECORDCOUNT
		resultado.movefirst
		'TITULO=titulo & " " & R
'		if cliente="true" then
			if clienteseccion="false" then ErrMesage="Usted es cliente pero no tiene contratada esta secci�n."
'			if R>limiterumores then ErrMesage="Demasiados Rumores, l�mite " & limiterumores & "."
			
			call TablaResultados("rum")
'		end if
	end if
	resultado.close
	ErrMesage=""
end sub %>

<% sub ofertas			
	strin="ofe"
	titulo="OFERTAS"
	bloque="oferta"
	
	sql = "SELECT ID, TITULO, TITULO_PT, FECHA_ACTUALIZACION, tipo_oferta AS APARTADO FROM c_ofertas WHERE "
	sql = sql & calcular_sqlw("ofertas")
	
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1

	if resultado.eof and resultado.bof then
		Of=0
	else
		resultado.movelast
		OP=resultado.recordcount
		resultado.movefirst
		'TITULO=titulo & " " & OP
'		if cliente="true" then
			if clienteseccion="false" then ErrMesage="Usted es cliente pero no tiene contratada esta secci�n."
'			if OP>limiteestudios then ErrMesage="Demasiadas Operaciones, l�mite " & limiteoperaciones & "."
			
			call TablaResultados("ofe")
'		end if
	end if
	resultado.close
	ErrMesage=""
end sub %>

<% sub operaciones(pTipo)		
	strin="ope"
	
	select case request.Form("seltipo")
	case "info-empresas", "empr"
		sql="SELECT * FROM C_OPERACIONES_INTERMEDIARIOS WHERE "
	'case "info-inmuebles", "edif", "dir"
	case else
		sql="SELECT * FROM C_OPERACIONES WHERE "
	end select
	
	select case pTipo
	case "inversion"
		sql = sql & calcular_sqlw("ops_inversion")
	case "alquiler"
		sql = sql & calcular_sqlw("ops_alquiler")
	case ""
		sql = sql & calcular_sqlw("ops")
	end select
	
	sql = sql & " ORDER BY seccion, FECHA_ACTUALIZACION DESC"
	
	'test_inyeccion_sql sql
	resultado.Open sql, session("connPW"), 1, 1

	if resultado.eof and resultado.bof then
		OP=0
	else
		resultado.movelast
		OP=resultado.recordcount
		resultado.movefirst
		'TITULO=titulo & " " & OP
'		if cliente="true" then
			if clienteseccion="false" then ErrMesage="Usted es cliente pero no tiene contratada esta secci�n."
'			if OP>limiteestudios then ErrMesage="Demasiadas Operaciones, l�mite " & limiteoperaciones & "."
			
			'call TablaResultados("ope")
			call TablaOperaciones()
'		end if
	end if
	resultado.close
	ErrMesage=""
end sub %>


<% sub TablaResultados(tipo)	
	num_titulo = 0
	apart = ""
	
	if not resultado.eof then %>
    <div id="tabla_titulares"><%
		
		do while not resultado.eof
			if apart<>resultado("APARTADO") and resultado("APARTADO")<>"NO" then 
				apart = resultado("APARTADO")
				apart_ver = lcase(apart)
				%><div><h3 class="tit_buscadores2"><%= apart_ver %></h3></div><%
			end if
			
			num_titulo = num_titulo + 1
			counter = counter + 1
			'enlace="https://www.propertyweb.eu"
			enlace = "/articulos/?" & tipo &"=" & resultado("ID") '& "&origen=" & origen
			
			for each elto in request.Form
				enlace = enlace & "&" & elto & "=" & request.Form(elto)
			next
			'enlace = enlace & "&frmInfo_tipo=" & request.Form("frmInfo_tipo")
			'enlace = enlace & "&frmInfo_busq=" & request.Form("frmInfo_busq")
			
			if request.Cookies("dev")<>"" then
				numero_articulo = "[" & num_titulo & "] &nbsp;"
			end if %>
			<div class="tabla">
            	<div class="fila">
<div class="list_check"><input type="checkbox" name="<%= tipo %>" value="<%= resultado("ID") %>" <% if checked="true" then response.write "checked" %>></div>
<a href="<%= enlace  %>" class="articulos">
	<div class="list_titulo"><% if request.Cookies("dev")<>"" then response.Write("[" & num_titulo & "]&nbsp; ") end if %><%= resultado("TITULO") %></div>
    <div class="list_fecha"> &nbsp;<%= resultado("FECHA_ACTUALIZACION")%>&nbsp; </div>
</a>
                </div>
			</div>
			<% resultado.movenext
		loop
		if request.Cookies("dev")("sql")<>"" then 
			%><div class="dev mini" style="margin-top:2em;"><%= resultado.source %></div><% 
		end if
    %></div><% 'tabla_titulares
	end if	
end sub %>

<% sub TablaOperaciones() 
	if request.Cookies("dev")="" then
		on error resume next
	end if
	'response.Write(resultado.source)
	'exit sub
	'swMostrarDetalles = false
	'if session("es_cliente") and session("acceso_activo") then 
	'	if session("acceso_operaciones") then swMostrarDetalles = true	
	'end if
	swMostrarDetalles = true
	
	superficie=0
	counter=0
	num_titulo=0
	
	apart = resultado("seccion")
	apart_ver = lcase(apart)
%>
<div class="tabla_cabecera">
    <div class="fila">
        <div class="deals_check tit"><a href="<%= c_link %>" onclick="$('#frm<%= counter %>').submit();return false;"></a>&nbsp;</div>
        <% if request.Cookies("dev")("sql")<>"" then %><div class="deals_contador tit">N&ordm;</div><% end if %>
        <% if request.Cookies("dev")("deals")="" then %>
        <div class="deals_titulo tit">T&iacute;tulo</div>
        <% else %>
        <div class="deals_titulo tit">Direcci&oacute;n</div>
        <% end if %>
        <% if session("modo")="foldy" then %>
        <div class="deals_precio tit">precio</div>
        <div class="deals_tipoprecio tit">tipo</div>
        <% end if %>
        <div class="deals_superf tit">Superf.</div>
        <% if session("modo")="foldy" then %><div class="deals_op tit">op.</div><% end if %>
        <div class="deals_fecha tit">Fecha Op.</div>
    </div>
	<% if 1=2 then %>
    <div class="fila"><a href="<%= c_link %>" onclick="$('#frm<%= counter %>').submit();return false;"></a>
        <div class="deals_check"><input type="checkbox" name="xxx" value="0" checked class="chexbox" /></div>
        <div class="deals_contador">999</div>
        <div class="deals_titulo">TITULO OPERACION</div>
        <% if request.Cookies("dev")("deals")="" then %>
        <div class="deals_titulo"><a href="#">TITULO OPERACION</a></div>
        <% else %>
        <div class="deals_titulo"><a href="#">C/ Tobago 34<br />  Madrid</a></div>
        <% end if %>
        <% if session("modo")="foldy" then %>
        <div class="deals_precio">9999</div>
        <div class="deals_tipoprecio">&euro;/m&sup2;</div>
        <% end if %>
        <div class="deals_superf">99999</div>
        <% if session("modo")="foldy" then %>
        <div class="deals_op">ALQUILER</div>
        <% end if %>
        <div class="deals_fecha">31/12/2012</div>
    </div>
	<% end if %>
</div>
<div class="tit_buscadores2"><h2>&nbsp;<%= apart_ver %></h2></div>
<div class="tabla">
	<% do while not resultado.eof	
		if apart<>resultado("seccion") then 
			apart = resultado("seccion") 
			apart_ver = lcase(apart) %>
            </div>
            <div class="tit_buscadores2"><h2>&nbsp;<%= apart_ver %></h2></div>
            <div class="tabla">
		<% end if
		
		num_titulo=num_titulo+1
		counter=counter+1
		superficie = superficie + resultado("METROS_CUADRADOS")
		
		'direcci�n		
		direccion = ""
		
		if resultado("EDIFICIO")<>"N/D" AND resultado("EDIFICIO")<>"" THEN
			'direccion = "Edificio " & resultado("EDIFICIO") & " &nbsp; "
			direccion = resultado("EDIFICIO") & " &nbsp; "
		END IF
		
		'zona	
		linea = ""
		'if resultado("TIPOZONA")<>"N/D" and resultado("TIPOZONA")<>"" then 
		'	if resultado("ID_TIPO_ZONA")=1 then
		'		linea = "Parque "
		'	elseif resultado("ID_TIPO_ZONA")=2 then
		'		linea = "Pol&iacute;gono "
		'	end if
		'end if
		linea = linea & resultado("NOMBRE_ZONA")
		if linea<>"" then direccion = direccion  & linea & " &nbsp; "
		
		'calle
		linea = ""
		IF resultado("TIPODIRECCION")<>"N/D" and resultado("TIPODIRECCION")<>"" THEN
			linea = resultado("TIPODIRECCION") & " "
		END IF	
		linea = linea & resultado("NOMBRE_CALLE")
		IF resultado("NUMERO_CALLE")<>"N/D" and resultado("NUMERO_CALLE")<>"0" and resultado("NUMERO_CALLE")<>"" THEN
			linea = linea & " " & resultado("NUMERO_CALLE")
		END IF
		if linea<>"" then direccion = direccion & linea
		
		'localidad
		direccion = direccion & " &nbsp; (" & resultado("LOCALIDAD") & ")"
		
		superf = "" & FormatNumber(resultado("METROS_CUADRADOS"),0)
		if superf = "0" then
			superf = "&nbsp;N/D"
		else
			superf = superf & "&nbsp;m<sup>2</sup>"
		end if
		'articulo2(resultado) 
		
		precio = resultado("PRECIO_EUR") 
		if precio = 0 then
			precio_ver = ""
			tipoprecio = ""
		else
			if precio>1000 then 
				precio_ver = FormatNumber(resultado("PRECIO_EUR"), 0)
			else
				precio_ver = FormatNumber(resultado("PRECIO_EUR"), 2)
			end if
			
			if resultado("ID_TIPO_PRECIO")=0 then 
				tipoprecio = ""
			else
				tipoprecio = lcase(resultado("TIPOPRECIO"))
				tipoprecio = replace(tipoprecio, "pts", "&euro;")
				tipoprecio = replace(tipoprecio, "�", "&euro;")
				tipoprecio = replace(tipoprecio, "m2", "m&sup2;")
			end if
		end if
		
		tipo_op = resultado("TIPOOPERACION")
		if session("modo")="foldy" then tipo_op = lcase(left(tipo_op, 3))
		
		enlace = "/articulos/?ope=" & resultado("ID") '& "&origen=" & origen
		
		for each elto in request.Form
			enlace = enlace & "&" & elto & "=" & request.Form(elto)
		next
		%>
<div class="fila">
	<div class="deals_check"><input type="checkbox" name="ope" value="<%= resultado("ID") %>" <% if checked="true" then %>checked<% end if %> class="chexbox"></div>
    <% if request.Cookies("dev")("sql")<>"" then %><div class="deals_contador"><%= num_titulo %></div><% end if %>
    <a href="<%= enlace %>" class="articulos">
        <div class="deals_titulo"><% 
            if request.Cookies("dev")("deals")="" then %><%= resultado("TITULO") %><% else %><%= direccion %><% end if
        %></div>
		
        <% if session("modo")="foldy" then %>
        <div class="deals_precio"><%= precio_ver %></div>
        <div class="deals_tipoprecio"><%= tipoprecio %></div>
        <% end if %>
        
        <div class="deals_superf"><%= superf %></div>
        
        <% if session("modo")="foldy" then %>
        <div class="deals_op"><%= tipo_op %></div>
        <% end if %>
        <div class="deals_fecha"><%= resultado("FECHA_OPERACION") %></div>
    </a>
</div>
		<% resultado.movenext
	'next
	loop 

if counter=0 then 
	%><p style="padding-left:4px; padding-top:15px; padding-bottom:10px;">No se ha encontardo ninguna operaci&oacute;n.</p><% 
end if %>
</div>
<% if request.Cookies("dev")("sql")<>"" then 
	%><div class="dev mini" style="margin-top:2em;"><%= resultado.source %></div><% 
end if %>
<% end sub %>

