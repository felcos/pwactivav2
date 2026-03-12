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
		enlace2 = "/articulos_informe/?ope=" & resultado("ID") '& "&origen=" & origen
		for each elto in request.Form
			enlace = enlace & "&" & elto & "=" & request.Form(elto)
		next
		%>
<style>
#borderConjunto {
    border: 1px dashed #1C6EA4;
    border-radius: 15px;
    padding: 15px;
}
</style>
<div id="borderConjunto" class="fila">

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
	<br>



	<div class="row datos">
		<div class="col-sm-12">

			
			<table class="tb-operacion">
				<tr><td>Fecha <span class="hidden-xs450">Operación</span>:</td><td><%= resultado("FECHA_OPERACION") %></td></tr>
				<tr><td>Tipo <span class="hidden-xs450">de Operación</span>:</td><td><%= resultado("TIPOOPERACION") %></td></tr>
				<tr><td>Uso:</td><td><% if resultado("id_seccion")=4 then %>RETAIL<% else %><%= resultado("seccion") %><% end if %></td></tr>
                <!-- solar : INI -->
				<% if resultado("SECCION")="SOLARES" then
					'if resultado("USO_SOLAR")<>"" then 
						%><tr><td>Uso del Solar:</td><td><%=lcase(resultado("USO_SOLAR"))%></td></tr><%
					'end if 
					
					numero=resultado("SUPERFICIE_EDIFICABLE")
					if isnull(numero) or numero =0 then
					'if numero =0 then
						resp = "n/d"
					else
						
						resp = formatnumber(numero,0)& " m2"
					end if %>
                    <tr><td>Superficie Edificable:</td><td><%= resp %></td></tr>
                <% end if %>
                <!-- solar : FIN -->
                <!-- centro comercial : INI -->
				<% if resultado("SECCION")="CENTROS COMERCIALES" then
					numero=resultado("SuperficieBA")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Br. Alq.: </td>
                        <td><%= resp %></td>
                    </tr>
                    
                    <% numero = resultado("SuperficieConstruida")
                    if isnull(numero) or numero =0 then
                        resp = "n/d"
                    else
                        resp = formatnumber(numero,0)& " m2"
                    end if %>
                    <tr>
                        <td>Superficie Construible: </td>
                        <td><%= resp %></td>
                    </tr>
                <% end if %>
                <!-- centro comercial : FIN -->
			</table>
            
		</div>
		    
	</div>


	<div class="row datos">
		<div class="col-sm-12">
		<h3>Plantas</h3>
			<div class="row ">
				<div class="col-xs-2">
<%
Set rsDetalles = Server.CreateObject("ADODB.Recordset")
rsDetalles.Open "SELECT * FROM C_OPERACIONES_DETALLE WHERE id_operacion=" & resultado("id") & " ORDER BY orden DESC", session("connPW")

' superficie_total
superficie_total = resultado("METROS_CUADRADOS")
if superficie_total = 0 then
superficie_total = "n/d"
else
superficie_total = formatnumber(superficie_total,0) & " m2"
end if

sumaSR=0
sumaBR=0
%>
<table class="tb-Gral planta">
<thead>
<tr>
	<th>Uso</th>
	<th>Plt</th>
	<th>M²</th>
	
</tr>
</thead>
<tbody>
<% do while not rsDetalles.eof 
'planta
if isnull(rsDetalles("planta")) then 
	planta = "N/D"
else 
	planta = rsDetalles("planta")
end if
seccion=" "
if isnull(rsDetalles("seccion")) then 
	seccion = "N/D"
else 
	seccion = rsDetalles("seccion")
end if
'superf
if rsDetalles("superficie")>0 then 
	superf = formatnumber(rsDetalles("superficie"),0)
	
	if rsDetalles("SobreRasante") then
		sumaSR = sumaSR + rsDetalles("superficie")
		'superf = superf & " S/R"
	else
		sumaBR = sumaBR + rsDetalles("superficie")
		'superf = superf & " B/R"
	end if
	
else
	superf = ""
end if
%>
<tr>
	<td class="tbl_plantas"><%= seccion %> </td>
	<td class="tbl_plantas"><%= planta %></td>
	<td class="tbl_plantas"><%= superf %></td>
</tr>
<% rsDetalles.movenext
loop 

%>
<tr class="total">
	<td> </td>
	<td>T </td>
	<td class="tbl_plantas"><% if resultado("METROS_CUADRADOS")>0 then %><%= FormatNumber(resultado("METROS_CUADRADOS"), 0) %><% else %>N/D<% end if %></td>
</tr>

</tbody>
</table>
				</div>

	
			</div>



		


	
	
		</div>


	<div class="descripcion">
		<div class="col-sm-11 ">
			<h3>AGENTES</h3>
			<div class="row">
<% 
' precio / renta    
if isnull(resultado("PRECIO_EUR")) then
importe = 0
ver_importe = "n/d"
else
importe = resultado("PRECIO_EUR")
if importe=0 then
ver_importe = "n/d"
elseif tipo_op="venta" and importe>1000 then
ver_importe = formatNumber(importe,0)
else
ver_importe = formatNumber(importe,2)
end if
end if

moneda = lcase(resultado("tipoprecio"))
if instr(moneda, "pts") then
moneda = replace(moneda, "pts", "&euro;")
end if
if moneda="n/d" then moneda=""
%>
<table class="tb-Gral tb-Edif">
<thead>
<tr>
<th><% if tipo_op="INVERSIÓN" then %>Comprador<% else %>Inquilino<% end if %></th>
<% if tipo_op="INVERSIÓN" then %><th>Vendedor</th><% end if %> <!--solo en inversión-->
<th><% if tipo_op="INVERSIÓN" then %>Precio<% else %>Renta<% end if %><br><span class="renta">(<%= moneda %>)</span></th>
<% if resultado("ID_TIPO_OPERACION")=2 then %><th>Fecha Contrato</th><% end if %>
<th>Intermediario</th>
</tr>
</thead>
<tbody>
<tr>
<td><% call Agentes(resultado,"C") %></td>
<% if tipo_op="INVERSIÓN" then %><td><% call Agentes(resultado,"P") %></td><% end if %> <!--solo en inversión -->
<td>
<p><%= ver_importe %></p>
<% if resultado("PRECIO_SALIDA_EUR") <> 0 and resultado("PRECIO_SALIDA_EUR") <> "" then %>
<p><% if resultado("ID_TIPO_OPERACION")=1 or resultado("ID_TIPO_OPERACION")=3 then %>
  Pr.<% else %>
  Renta<% end if %> 
  Est. Salida:<br /><%=formatnumber(resultado("PRECIO_SALIDA_EUR"),2)%></p>
<% end if %>
</td>
<% if resultado("ID_TIPO_OPERACION")=2 then 
fIni = mid(resultado("FECHA_INICIO"), 4, 3) &  mid(resultado("FECHA_INICIO"), 9, 2)
fFin = mid(resultado("FECHA_FIN"), 4, 3) & mid(resultado("FECHA_FIN"), 9, 2)
%><td><%= fIni %>-<%= fFin %></td><% 
end if %>
<td><% call Agentes(resultado,"I") %></td>
</tr>
</tbody>
</table>
<%
rsDetalles.close
set rsDetalles=nothing
%>
		</div>
	</div>
</div>
</div>
	<div class="descripcion">

		<h3>COMENTARIOS</h3>
		<% 

		
		texto = resultado("COMENTARIOS")
		lista = split(texto, chr(13))
		
		for each elto in lista
			
			for ii=1 to 3
				if len(elto)<1 then exit for
				char = asc(mid(elto, 1,1))
				if char=10 or char=45 or char=32 then		 'or char=46	"."
					elto = mid(elto, 2, len(elto)-1)
				end if
			next
			if elto<>"" then
				%><p><%= elto %></p><%
			end if
		next
		%>
	</div>
	


	
</div>
<br>

<br>

	
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


<% sub Agentes(byRef resultado, pTipo) 
	Set rsAg = Server.CreateObject("ADODB.Recordset")	
	select case pTipo
		case "C"
			sql = "tipo='C'"
		case "P"
			sql = "tipo='P'"
		case "I"
			sql = "(tipo='CI' or tipo='PI')"
	end select
	
	sql = "SELECT * FROM C_CONTACTOS_OPERACIONES WHERE id_operacion=" & resultado("ID") & " AND " & sql
	
	if pTipo="I" then
		 sql = sql & " ORDER BY ACTIVIDAD, tipo"
	end if 
	
	rsAg.Open sql, session("connPW")
	if not rsAg.eof then %>
<div>
<% 
cActividad =""
do while not rsAg.eof 
	
	if pTipo="I" then
		if cActividad<>lcase(rsAg("ACTIVIDAD")) then
			cActividad = lcase(rsAg("ACTIVIDAD"))
			%><p><strong><%= cActividad %></strong></p><%
		end if
		
		if isnull(rsAg("foto")) then
			img=false
		else
			img=true
		end if
		if rsAg("tipo")="CI" then
			if resultado("ID_TIPO_OPERACION")=1 or resultado("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (C)" 
			else 
				cTipo = "  (I)"
			end if
			
		elseif rsAg("tipo")="PI" then
			if resultado("ID_TIPO_OPERACION")=1 or resultado("ID_TIPO_OPERACION")=3 then 
				cTipo = "  (V)"
			else 
				cTipo = "  (P)"
			end if
			
		end if
		
		
	else
		img=false
		cTipo = ""
	end if 
	img=false
	
	nombre = lcase(rsAg("NOMBRE"))
	
	%><!-- include virtual="/inc/fotos.asp" -->
<p><%= nombre %><%= cTipo %><% if img then %><img src="/img/clientes/<%= rsAg("foto") %>" height="32" /><% end if %></p>
	<% rsAg.movenext
    loop %>
</div>
	<% end if 
    rsAg.close
	%>
<% set rsArg = nothing
end sub %>
