<!--#include virtual="/articulos/sin_acceso.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% '!-- include virtual="/busq/lib_acceso.asp" -- %>
<% function calcularSQLW(pTipo)	
	f_desde = cdate(request.Form("FechaI"))
	f_hasta = cdate(request.Form("FechaF"))
	busqueda = request.Form("busq")
	busqueda = replace(busqueda, "'", "''")
	uso = request.Form("uso")
	
	select case pTipo 
	case "*"
		sqlW = ""
	case "NW"
		sqlW = "TIPO_NOTICIA='N' OR TIPO_NOTICIA='W'"
	case else
		sqlW = "TIPO_NOTICIA='" & pTipo & "'"
	end select
	if sqlW<>"" then sqlW = "(" & sqlW & ") AND "
	
	sqlW = sqlW & "web_es<>0 AND "
	if uso<>"" then
		sqlW = sqlW & "(ID_SECCION=" & uso & ") AND "
	end if
	'sqlW = sqlW & "(FECHA_NOTICIA BETWEEN CONVERT(DATETIME, '" & f_desde & "', 103) AND CONVERT(DATETIME, '" & f_hasta & "', 103) OR "
	'sqlW = sqlW & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & f_desde & "', 103) AND CONVERT(DATETIME, '" & f_hasta & "', 103)) "
	sqlW = sqlW & "(FECHA_NOTICIA >= CONVERT(DATETIME, '" & f_desde & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & f_hasta & "', 103)) "
	
	if busqueda<>"" then
		sqlW = sqlW & " AND (" & compilarsql("PALABRAS_CLAVES", busqueda) &")"
	end if
	
	calcularSQLW = sqlW
	
	session("PalabrasClave")=AcomodaBusq(trim(ucase(busqueda)))
end function %>

<% function calcularSQLW_subastas()	
	f_desde = cdate(request.Form("FechaI"))
	f_hasta = cdate(request.Form("FechaF"))
	tipo_subastas = Request.Form("tiposubastas")
	seccion_subastas = Request.Form("seccion_subastas")
	uso_solar = Request.Form("uso_solar")
	provincia = Request.Form("provincia")
	localidad = Request.Form("localidad")
	
	sqlW = sqlW & "(web_es<>0) AND " 
	sqlW = sqlW & "("
	'sqlW = sqlW & "FECHA_PUBLICACION BETWEEN CONVERT(DATETIME, '" & cdate(f_desde) & "', 103) AND CONVERT(DATETIME, '" & cdate(f_hasta) & "', 103) OR "
	'sqlW = sqlW & "FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '" & cdate(f_desde) & "', 103) AND CONVERT(DATETIME, '" & cdate(f_hasta) & "', 103)"
	sqlW = sqlW & "(FECHA_PUBLICACION >= CONVERT(DATETIME, '" & f_desde & "', 103) AND FECHA_ACTUALIZACION <= CONVERT(DATETIME, '" & f_hasta & "', 103)) "
	sqlW = sqlW & ") "
	
	if tipo_subastas <> "%" then sqlW = sqlW & "AND (id_tipo_concurso=" & tipo_subastas & " OR id_tipo_concurso IS NULL) "
	if seccion_subastas <> "%" and seccion_subastas<>"" then sqlW = sqlW & "AND (id_seccion=" & seccion_subastas & ") "
	if uso_solar <> "%" then sqlW = sqlW & "AND (id_uso_solar=" & uso_solar & ") "
	
	if provincia <> "%" then sqlW = sqlW & "AND (id_provincia=" & provincia & ") "
	if (localidad <> "%" and localidad <> "0") then sqlW = sqlW & "AND (id_localidad=" & localidad & ") "
	'sql = sql & ")"

	calcularSQLW_subastas = sqlW
	
end function %>

<% sub TablaTitulos(pSecc) 
	set rsTbl = Server.CreateObject("ADODB.Recordset")
	
	Select case pSecc
	case "not"
		cTipo = "N"
		cLink = "tit_noticias"
		cTit = "Noticias"
	case "rum"
		cTipo = "W"
		cLink = "tit_web"
		cTit = "Web ha o&iacute;do..."
	case "est"
		cTipo = "E"
		cLink = "tit_est"
		cTit = "Estudios de Mercado"
	case "dem"
		cTipo = "B"
		cLink = "tit_dem"
		cTit = "Demandas"
	case "sub"
		cTit = "Subastas, Concursos de Obras, Venta de Suelo..."
	end select
	
	select case pSecc
	case "not", "rum", "est", "dem"	
		sql = "SELECT ID, TITULO, FECHA_ACTUALIZACION AS FECHA, SECCION AS APARTADO, TIPO_NOTICIA, NUMERO_FOTOS FROM w_noticias WHERE "
		sql = sql & calcularSQLW(cTipo)
		sql = sql & " ORDER BY TIPO_NOTICIA ASC, SECCION ASC, FECHA_ACTUALIZACION DESC"
		
	case "sub"	
		sql = "SELECT id_concurso as id, tipo_concurso as APARTADO, FECHA_PUBLICACION AS FECHA, titulo FROM c_concursos_detalle WHERE ("
		sql = sql & calcularSQLW_subastas()
		sql = sql & ") ORDER BY APARTADO, FECHA_PUBLICACION DESC;"
		
	end select
	
	test_inyeccion_sql sql
	rsTbl.open sql, session("connPW")
	
	if rsTbl.eof then %>
		<div style="padding:10px; margin:2px;">
            <p id="result_noencontrado">Ning&uacute;n art&iacute;culo encontrado.</p>
            <% if request.Cookies("dev")("sql")<>"" then 
				%><div class="dev mini"><%= rsTbl.source %></div><% 
			end if %>
        </div>
        
	<% else %>
		<a name="<%= cLink %>" id="<%= cLink %>"></a>
		<% if request.Form("origen")<>"articulos" then %>
			<h2 class="tit_buscadores"><%= cTit %></h2>
		<% end if %>
        
		<div id="tabla_titulares">
		
		<% if request.Cookies("dev")("sql")<>"" then 
			%><div class="dev mini"><%= rsTbl.source %></div><% 
		end if
		
		ap=""
		ap_actual=""
		num_titulo=0
		ap_first = true
		
		do while not rsTbl.eof 
			ap=rsTbl("APARTADO")	'AcomodaBD()
			if ap_actual<>ap then
				ap_actual=ap %>
                <% if not ap_first then %></div><% end if %>
				<div><% 
					if request.Form("uso")="" then
						%><h3 class="tit_buscadores2"><%= ap_actual %></h3><%
					end if %>
                </div>
                <div class="tabla">
				<% if ap_first then
					ap_first = false
				end if 
				
			end if 
			
			num_titulo=num_titulo+1 
			link = "/articulos/?" & pSecc & "=" & rsTbl("ID")
			
			for each elto in request.Form
				link = link & "&" & elto & "=" & request.Form(elto)
			next
			%>
                <div class="fila">
                	<div class="list_check"><input type="checkbox" name="<%= pSecc %>" value="<%= rsTbl("ID") %>" class="chexbox"></div>
                    <a href="<%= link  %>" class="simplemodal">
<div class="list_titulo"><% if request.Cookies("dev")<>"" then response.Write("[" & num_titulo & "]&nbsp;") end if %><%= rsTbl("TITULO") %></div>
<div class="list_fecha"> &nbsp;<%= rsTbl("FECHA")%>&nbsp; </div>
					</a>
                </div>
            <% rsTbl.movenext
		loop %>
        	</div><!-- class="tabla" LAST -->
		</div>
        
        <div style="margin-top:2em; margin-bottom:3em; text-align:center;">
            <input type="submit" class="btn_3" value="Leer art&iacute;culos seleccionados">
        </div>
        
	<% end if	'eof
	rsTbl.close
	set rsTbl = nothing
end sub %>

<% function compilarsql(campo, busq) 	
	dim vari
	dim minisql
	
	vari = split(ucase(busq))
	
	minisql=""
	for each elto in vari
		if trim(elto)<>"" then
			
			elto = AcomodaBusq(elto)
			
			if minisql<>"" then minisql = minisql & " AND " 
			
			select case elto
			case "OFICINA", "OFICINAS"
				minisql= minisql & "(" & campo & " LIKE '%#OFICINA#%' OR " & campo & " LIKE '%#OFICINAS#%')" 
			case "LOCAL", "LOCALES"
				minisql= minisql & "(" & campo & " LIKE '%#LOCAL#%' OR " & campo & " LIKE '%#LOCALES#%')" 
			case "COMERCIAL", "COMERCIALES"
				minisql= minisql & "(" & campo & " LIKE '%#COMERCIAL#%' OR " & campo & " LIKE '%#COMERCIALES#%')" 
			case "HOTEL", "HOTELES"
				minisql= minisql & "(" & campo & " LIKE '%#HOTEL#%' OR " & campo & " LIKE '%#HOTELES#%')" 
			case "VIVIENDA", "VIVIENDAS"
				minisql= minisql & "(" & campo & " LIKE '%#VIVIENDA#%' OR " & campo & " LIKE '%#VIVIENDAS#%')" 
				
			case "RESIDENCIAL", "RESIDENCIALES"
				minisql= minisql & "(" & campo & " LIKE '%#RESIDENCIAL#%' OR " & campo & " LIKE '%#RESIDENCIALES#%')" 
			case "INDUSTRIAL", "INDUSTRIALES"
				minisql= minisql & "(" & campo & " LIKE '%#INDUSTRIAL#%' OR " & campo & " LIKE '%#INDUSTRIALES#%')" 
				
			case "CENTRO", "CENTROS"
				minisql= minisql & "(" & campo & " LIKE '%#CENTRO#%' OR " & campo & " LIKE '%#CENTROS#%')" 
			case "SOLAR", "SOLARES"
				minisql= minisql & "(" & campo & " LIKE '%#SOLAR#%' OR " & campo & " LIKE '%#SOLARES#%')" 
			case "PARQUE", "PARQUES"
				minisql= minisql & "(" & campo & " LIKE '%#PARQUE#%' OR " & campo & " LIKE '%#PARQUES#%')" 
			case "POLIGONO", "POLIGONOS"
				minisql= minisql & "(" & campo & " LIKE '%#POLIGONO#%' OR " & campo & " LIKE '%#POLIGONOS#%')" 
				
			case else
				minisql= minisql & "(" & campo & " LIKE '%#" & elto & "#%')" 
			end select
		end if
	next
		
	compilarsql = minisql
	
end function %>

<% function AcomodaBusq(rTexto)	
	txtP=rTexto
	if txtP<>"" then
		txtP=replace(txtP, "Á", "A")
		txtP=replace(txtP, "À", "A")

		txtP=replace(txtP, "É", "E")
		txtP=replace(txtP, "È", "E")

		txtP=replace(txtP, "Í", "I")
		txtP=replace(txtP, "Ì", "I")

		txtP=replace(txtP, "Ó", "O")
		txtP=replace(txtP, "Ò", "O")

		txtP=replace(txtP, "Ú", "U")
		txtP=replace(txtP, "Ù", "U")
		
		txtP=replace(txtP, "'", "''")
		txtP=replace(txtP, "¿", "")
	end if
	AcomodaBusq=txtP
end function
%>