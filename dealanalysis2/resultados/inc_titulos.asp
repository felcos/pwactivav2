<% 
'if request.Cookies("dev")<>"" then
	if instr(r_seccion, "oficina") then ver_dir=true
	if instr(r_seccion, "local") then ver_dir=true
'end if 
	
	select case resultado("id_tipo_operacion")
	case 1, 3 
		titulo_importe = "Precio"
	case 2, 4
		titulo_importe = "Renta"
	end select
	%>
<div class="tabla ">
    <div class="fila cabecera">
        <div class="deals_contador tit"><%' call div_orden("null") %></div>
        <div class="deals_titulo tit">Direcci&oacute;n<% 'call div_orden("dir") %></div>
        <div class="deals_superf tit">Superficie<% 'call div_orden("superf") %></div>
        <div class="deals_precio tit"><%= titulo_importe %></div>
        <div class="deals_tipoprecio tit"><% 'call div_orden("eur") %></div>
        <div class="deals_fecha tit">Fecha Op.<% 'call div_orden("fecha") %></div>
    </div>
    
    <% if 1=2 then %>
    <div class="fila">
        <!--  <div class="deals_check tit" style="text-align:left;"><input type="checkbox" id="check_all" onChange="marcar();"></div>-->
        <div class="deals_contador tit"></div>
        <div class="deals_titulo tit">Operación
        	<a href="javascript:ordena('titulo', '');"><img src="/img/sort_both.png" width="19" height="19" alt="Ordenar" longdesc=""></a>
        </div>
        <div class="deals_superf tit">Superf.
        	<a href="javascript:ordena('superf', '');"><img src="/img/sort_both.png" width="19" height="19" alt="Ordenar" longdesc="Ordenar por Superficie"></a>
        </div>
        <div class="deals_precio tit">precio
        	<a href="javascript:ordena('eur', '');"><img src="/img/sort_both.png" width="19" height="19" alt="Ordenar" longdesc=""></a>
		</div>
        <div class="deals_tipoprecio tit"></div>
        <div class="deals_fecha tit">Fecha Op.
        	<a href="javascript:ordena('fecha', '');"><img src="/img/sort_both.png" width="19" height="19" alt="Ordenar" longdesc="Ordenar por Fecha de Operación"></a>
        </div>
    </div>
    <div class="fila"><a href="<%= c_link %>" onclick="$('#frm<%= contador %>').submit();return false;"></a>
        <div class="deals_check"><input type="checkbox" name="xxx" value="0" checked class="chexbox" /></div>
        <div class="deals_contador">999</div>
        <% if request.Cookies("dev")("deals")="" then %>
        <div class="deals_titulo">TITULO OPERACION</div>
        <% else %>
        <div class="deals_titulo"><a href="#">C/ Tobago 34<br />  Madrid</a></div>
        <% end if %>
        <% if 1=2 then 'request("sec")="oficinas" then %><div class="deals_area">DEC</div><% end if %>
        <% if 1=2 then %>
        <div class="deals_superf">ALQUILER</div>
        <% end if %>
        <div class="deals_superf">99999</div>
        <% if request.Cookies("dev")<>"" and session("modo")="foldy" then %>
        <div class="deals_precio">9999</div>
        <div class="deals_tipoprecio">&euro;/m&sup2;</div>
        <% end if %>
        <div class="deals_fecha">31/12/2012</div>
    </div>
    <% end if %>
</div>

	<%
    resultado.movefirst
    'For i = 1 To resultado.PageSize
    apart = resultado("seccion")
    %>
<% if r_orden="" then %><div class="tit_buscadores2"><h2><%= apart %></h2></div><% end if %>
<div class="tabla">
	<%
	do while not resultado.eof
if r_orden="" then
	if resultado("seccion")<>apart then 
		apart = resultado("seccion") %>
        </div>
        <div class="tit_buscadores2"><h2><%= apart %></h2></div>
        <div class="tabla">
    <% end if
end if
		
		num_titulo=num_titulo+1
		contador=contador+1
		superficie = superficie + resultado("METROS_CUADRADOS")
		
		'enlace="https://www.propertyweb.eu"
		'enlace=enlace & "/articulos/?" & strin &"=" & resultado("ID")	' & "&origen=" & origen
		enlace = "/articulos/?ope=" & resultado("ID")	'& "&origen=" & origen
		'tab=list&
		for each elto in request.Form
			if request.Form(elto)<>"" then
				select case elto
				case "zoom", "lat", "lng", "tab"
				case else
					enlace = enlace & "&" & elto & "=" & request.Form(elto)
				end select
			end if
		next
		
		direccion = ""
		
		if isnull(resultado("id_edificio")) or resultado("id_edificio")=0 then
			linea = ""
		else
			linea = resultado("EDIFICIO") & ", "
		end if
		'if linea<>"" then direccion = direccion & linea
		
		linea = ""
		if resultado("NOMBRE_CALLE")<>"" then
			'quitado 27/11/2015
			'if resultado("TIPODIRECCION")<>"N/D" and resultado("TIPODIRECCION")<>"" then
			'	linea = linea & resultado("TIPODIRECCION") & " "
			'end if
			'if resultado("nombre_calle_pre")<>"" then
			'	linea = linea & resultado("nombre_calle_pre") & " "
			'end if
			'///////
			if request.Cookies("dev")<>"" then
				if resultado("TIPODIRECCION")<>"N/D" and resultado("TIPODIRECCION")<>"" then
					linea = linea & resultado("TIPODIRECCION") & " "
				end if
				if resultado("nombre_calle_pre")<>"" then
					linea = linea & resultado("nombre_calle_pre") & " "
				end if
			end if
			
			linea = linea & resultado("NOMBRE_CALLE")
			
			if request.Cookies("dev")<>"" then
				if resultado("NUMERO_CALLE")<>"N/D" and resultado("NUMERO_CALLE")<>"0" and resultado("NUMERO_CALLE")<>"" then
					linea = linea & " " & resultado("NUMERO_CALLE")
				end if
			end if
			if linea<>"" then direccion = direccion & linea
			
			if resultado("LOCALIDAD")<>"N/D" and resultado("LOCALIDAD")<>"" then
				localidad = resultado("LOCALIDAD")
				'localidad = UCase(Left(localidad,1)) & LCase(Right(localidad, Len(localidad) - 1))
				direccion = direccion & " <span>(" & localidad & ")</span>"
			end if
			
		else
			linea = linea & resultado("NOMBRE_ZONA")
			if linea<>"" then direccion = direccion  & linea & ", "
			if resultado("LOCALIDAD")<>"N/D" and resultado("LOCALIDAD")<>"" then
				direccion = direccion  & resultado("LOCALIDAD")
			else
				direccion = direccion & resultado("PAIS")
			end if
		end if
		
		direccion = trim(direccion)
		precio = 0 
		
		if IsNumeric(resultado("PRECIO_EUR")) then
			precio = resultado("PRECIO_EUR") 
		end if
		
		if precio = 0 then
			precio_ver = ""
			tipoprecio = ""
		else
			if precio>1000 then 
				precio_ver = FormatNumber(resultado("PRECIO_EUR"), 0)
			'	'precio_ver = resultado("PRECIO_EUR")
			else
			'	'if isnumeric(resultado("PRECIO_EUR")) then
					precio_ver = FormatNumber(resultado("PRECIO_EUR"), 2)
			'		'precio_ver = resultado("PRECIO_EUR")
			'	'end if
			end if
			
			if resultado("ID_TIPO_PRECIO")=0 then 
				tipoprecio = ""
			else
				tipoprecio = lcase(resultado("TIPOPRECIO"))
				tipoprecio = replace(tipoprecio, "€", "&euro;")
				tipoprecio = replace(tipoprecio, "m2", "m&sup2;")
			end if
		end if
		
		superf = FormatNumber(resultado("METROS_CUADRADOS"), 0)
		if superf>0 then 
			superf = superf & "&nbsp;<span style='font-size:85%;'>m&sup2;</span>"
		else
			superf = ""
		end if
		'articulo2(resultado) 
		' style="background-color:< % = color % >;"
		'
		'<img src="/dealanalysis/resultados/off.gif" class="chkImgOps" id="chkImgOps_< %= resultado("ID") % >"/>
		%>
<div class="fila <% if isnull(resultado("lat")) then response.Write("pw-warning") end if %>">
	<div class="deals_check"><input type="checkbox" name="ope" value="<%= resultado("ID") %>" <% if checked="true" then %>checked<% end if %> class="chexbox" id="chkOp<%= resultado("ID") %>"/></div>
    <div class="deals_contador"><%= num_titulo %></div>
    <a class="leer" id="op<%= resultado("ID") %>" onclick="ver_op(<%= resultado("ID") %>);">
	<%
	' href="/articulos/?ope=<%= resultado("ID") % ><%'= enlace % >"
	if ver_dir then %>
    <div class="deals_titulo"><% if request.Cookies("dev")<>"" then %>[<%= resultado("ID") %>] <% end if %><%= direccion %></div>
    <% else %>
    <div class="deals_titulo"><% if request.Cookies("dev")<>"" then %>[<%= resultado("ID") %>] <% end if %><%= resultado("TITULO") %></div>
    <% end if %>
    <div class="deals_superf"><%= superf %></div>
    <div class="deals_precio"><%= precio_ver %></div>
    <div class="deals_tipoprecio"><%= tipoprecio %></div>
    <div class="deals_fecha"><%= resultado("FECHA_OPERACION") %></div>
    </a>
</div>
        <% resultado.movenext
	loop %>
</div>
