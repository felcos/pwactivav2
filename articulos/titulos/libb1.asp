<!--#include virtual="/articulos/sin_acceso.asp" -->
<!--#include virtual="/lib/funciones.asp" -->
<% '!-- include virtual="/busq/lib_acceso.asp" -- %>
<% function calcularSQLWB1(pTipo)	
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
	

	dim condicionesP 
	condicionesP=""
	condicionesP=compilarsqlB1("PALABRAS_CLAVES", busqueda)


	if busqueda<>"" and condicionesP<>"" then
		sqlW = sqlW & " " & condicionesP  &" "
	end if
	
	calcularSQLWB1 = sqlW
	'response.write(busqueda)
	'response.write(sqlw)
	session("PalabrasClave")=AcomodaBusq(trim(ucase(busqueda)))
end function %>

<% function calcularSQLWB1_subastas()	
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

	calcularSQLWB1_subastas = sqlW
	
end function %>

<% sub TablaTitulos(pSecc) 
	set rsTbl = Server.CreateObject("ADODB.Recordset")
	
	Select case pSecc
	case "not"
		cTipo = "N"
		cLink = "tit_noticias"
		cTit = "PW News Summary"
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
	dim xi
	xi=0
	dim condiciones
	condiciones=calcularSQLWB1(cTipo) 
	select case pSecc
	case "not", "rum", "est", "dem"	
		sql=""
		for xi=1 to 20
			sql = sql & " SELECT TOP 5 ID, TITULO, FECHA_ACTUALIZACION AS FECHA, SECCION AS APARTADO, TIPO_NOTICIA, NUMERO_FOTOS,ID_SECCION FROM w_noticias WHERE "
			sql = sql & " ID_SECCION=" & xi 
			if condiciones<>"" then sql=sql & " and " & condiciones end if
			if xi<20 then sql = sql & " union " end if
		next
		sql = sql & " ORDER BY TIPO_NOTICIA ASC, SECCION ASC, FECHA_ACTUALIZACION DESC;"
		
	case "sub"	
		sql = "SELECT TOP 5 id_concurso as id, tipo_concurso as APARTADO, FECHA_PUBLICACION AS FECHA, titulo FROM c_concursos_detalle WHERE ("
		sql = sql & calcularSQLWB1_subastas()
		sql = sql & ") ORDER BY APARTADO, FECHA_PUBLICACION DESC;"
		
	end select
	
	test_inyeccion_sql sql
	'response.write(sql)
	rsTbl.open sql, session("connPW")
	
	if rsTbl.eof then %>

        
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
			link = "/articulos/?" & pSecc & "=" & rsTbl("ID") & "&origen=flash&f=" & request.Form("pFechaLink") 
			
			'for each elto in request.Form
			'	link = link & "&" & elto & "=" & request.Form(elto)
			'next
			'response.write(link)
			%>
			<div class="fila">
				
				<a href="<%= link  %>" class="simplemodal">
<div class="list_titulo"><% if request.Cookies("dev")<>"" then response.Write("[" & num_titulo & "]&nbsp;") end if %><%= rsTbl("TITULO") %></div>
<div class="list_fecha"> &nbsp;<%= rsTbl("FECHA")%>&nbsp; </div>
				</a>
			</div>
			<% rsTbl.movenext

		loop %>
        	</div><!-- class="tabla" LAST -->
		</div>
        

        
	<% end if	'eof
	rsTbl.close
	set rsTbl = nothing
end sub %>

<% function compilarsqlB1(campo, busq) 	
	dim vari
	dim minisql
	vari = split(ucase(busq))
	minisql=""
	dim icontador
	icontador=0
	for each elto in vari
		
		if trim(elto)<>"" and (not IsNumeric(elto)) then
			
			elto = AcomodaBusq(elto)
			
			'if (minisql<>"" and (not IsNumeric(minisql))) then minisql = minisql & " and " 
			
				select case elto
				case "OFICINA", "OFICINAS"
					minisql= minisql  
				case "LOCAL", "LOCALES"
					minisql= minisql 
				case "COMERCIAL", "COMERCIALES"
					minisql= minisql 
				case "HOTEL", "HOTELES"
					minisql= minisql 
				case "VIVIENDA", "VIVIENDAS"
					minisql= minisql  
				case "RESIDENCIAL", "RESIDENCIALES"
					minisql= minisql  
				case "INDUSTRIAL", "INDUSTRIALES"
					minisql= minisql 
				case "CENTRO", "CENTROS"
					minisql= minisql 
				case "SOLAR", "SOLARES"
					minisql= minisql 
				case "PARQUE", "PARQUES"
					minisql= minisql  
				case "POLIGONO", "POLIGONOS"
					minisql= minisql 
				case else
					minisql= minisql & " and (" & campo & " LIKE '%" & elto & "%') " 
					icontador=icontador+1
				end select
			
		end if
		if icontador>2 Then Exit For 

	next
		
	
	
		
	compilarsqlB1 = minisql
	
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