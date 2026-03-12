<%
'origen="info-inmuebles"
on error resume next

if request.Cookies("dev")="" then
	limitenoticias = 500
	limiteestudios = 150		'75
	limiterumores = 150
	limiteoperaciones = 150
else
	limitenoticias=5000
	limiteestudios=1000
	limiterumores=1000
	limiteoperaciones=1000
end if

'Request.QueryString("tipobusqueda")'


tipobusqueda=lcase(request.form("seltipo"))

if tipobusqueda="" then
	tipobusqueda="edif"
end if

edificio = request.form("edificio")
if edificio="" then
	edificio = rsInmueble("nombre_completo")
end if

edificio = replace(edificio, "'", "''")
idedificio = request.Form("id_edificio")
if idedificio="" then
	idedificio=rId
end if

calle = request.form("calle")
if calle="" then
   calle = rsInmueble("nombre_calle")
end if

calle = replace(calle, "'", "''")
numerocalle = request.form("numerocalle")
numerocalle = replace(numerocalle, "'", "''")

zona = request.form("zona")
if zona="" then
   zona = rsInmueble("nombre_zona")
end if
if zona<>"" then zona = replace(zona, "'", "''")

select case tipobusqueda	
	case "edif", "prop"
		variable = edificio
	case "dir"
		variable = calle & " " & numerocalle
	case "zona"
		variable = zona
	'case "hotel"
	'	variable="hotel " & hotel
	'case "centro_comercial"
	'	variable = "CENTRO COMERCIAL " & zona 
	'case "poligono_industrial"
	'	variable = "POLIGONO INDUSTRIAL " & zona 
	'case "parque_empresarial"
	'	variable = "PARQUE EMPRESARIAL " & zona 
	'case "parque_comercial"
	'	variable = "PARQUE COMERCIAL " & zona 
end select

session("PalabrasClave")=ucase(variable)
'call simplifica(variable)
%>
<% Public function calcular_sqlw(pTipo)
	dim sqlw
	
	select case left(pTipo, 3)
	case "not"			
		sqlw = "(web_es<>0) AND TIPO_NOTICIA='N' "
		
		'select case tipobusqueda
		'case "edificio" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%EDIFICIO%' AND TEXTO_NOTICIA LIKE '%" & EDIFICIO & "%')"
		'case "hotel" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%HOTEL%' AND TEXTO_NOTICIA LIKE '%" & HOTEL & "%')"
		'case "calle"
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%" & calle & " " & numerocalle & "%')"
		'case else
		'	call compilarsql("TEXTO_NOTICIA")
		'	sql = sql & " AND (" & minisql &")"
		'	
		'end select
		
		sqlw = sqlw & " AND (" & compilarsql("PALABRAS_CLAVES", variable) &")"
		
	case "est"			
		sqlw = "(web_es<>0) AND TIPO_NOTICIA='E' "
		
		'select case tipobusqueda
		'case "edificio" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%EDIFICIO%' AND TEXTO_NOTICIA LIKE '%" & EDIFICIO & "%')"
		'	
		'case "hotel" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%HOTEL%' AND TEXTO_NOTICIA LIKE '%" & HOTEL & "%')"
		'case "calle"
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%" & calle & " " & numerocalle & "%')"
		'
		'case else
		'	call compilarsql("TEXTO_NOTICIA")
		'	sql = sql & " AND (" & minisql &")"
		'	
		'end select
		
		sqlw = sqlw & " AND (" & compilarsql("PALABRAS_CLAVES", variable) &")"
		
	case "rum"			
		sqlw = "(web_es<>0) AND (TIPO_NOTICIA LIKE 'W') "
		
		'select case tipobusqueda
		'case "edificio" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%EDIFICIO%' AND TEXTO_NOTICIA LIKE '%" & EDIFICIO & "%')"
		'	
		'case "hotel" 
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%HOTEL%' AND TEXTO_NOTICIA LIKE '%" & HOTEL & "%')"
		'case "calle"
		'	sql = sql & " AND (TEXTO_NOTICIA LIKE '%" & calle & " " & numerocalle & "%')"
		'	'sql = sql & " AND (TEXTO_NOTICIA LIKE '%" & calle & "%'AND (TEXTO_NOTICIA LIKE '% " & _
		'	'numerocalle & " %' OR TEXTO_NOTICIA LIKE '% " & numerocalle & ",%' OR TEXTO_NOTICIA LIKE '% " & numerocalle & ".%')))"
		'
		'case else
		'	call compilarsql("TEXTO_NOTICIA")
		'	sql = sql & " AND (" & minisql &")"
		'	
		'end select
		
		sqlw = sqlw & " AND (" & compilarsql("PALABRAS_CLAVES", variable) &")"
		
	case "ops"		
		sqlw = "(web_es<> 0) AND "
		
		select case tipobusqueda
		case "edif"
			sqlw = sqlw & "(ID_EDIFICIO = " & idedificio
			sqlw = sqlw & " OR id_complejo = " & idedificio
			
			if request.Form("id_complejo")<>"" then
				sqlw = sqlw & " OR id_edificio = " & request.Form("id_complejo")
			end if 
			
			if numerocalle<>"" then
				sqlw = sqlw & " OR (NOMBRE_CALLE = '" & calle & "' AND NUMERO_CALLE='" & numerocalle & "' AND ID_EDIFICIO=0)"
			end if
			
			sqlw = sqlw & ")"
			
		case "dir"
			'sqlw = sqlw & "(NOMBRE_CALLE LIKE '%" & calle & "%'"
			sqlw = sqlw & "(NOMBRE_CALLE = '" & calle & "'"
			if numerocalle<>"" then
				sqlw = sqlw & " AND NUMERO_CALLE='" & numerocalle & "'"
			end if
			sqlw = sqlw & ")"
			
			sqlw = sqlw & " AND (LOCALIDAD='" & request.Form("l") & "')"
			'sqlw = sqlw & "(NUMERO_CALLE='" & NUMEROCALLE & "' OR NUMERO_CALLE LIKE '" & NUMEROCALLE & "-%' OR NUMERO_CALLE LIKE '%-" & NUMEROCALLE & "')"
			
		case "zona" 
			sqlw = sqlw & "(NOMBRE_ZONA LIKE '%" & zona & "%')"
			
		case "centro_comercial"	
			sqlw = sqlw & "TIPOZONA LIKE '%centro%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "poligono_industrial"
			sqlw = sqlw & "TIPOZONA LIKE '%poligono%' AND TIPOZONA LIKE '%industrial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "parque_empresarial"
			sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%empresarial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "parque_comercial"
			sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
						
		End select
		
	case "ofe"			
		sqlw = "(web_es<> 0) AND "
		
		select case tipobusqueda
		case "edif"
			sqlw = sqlw & "(ID_EDIFICIO = " & idedificio & ")"
			
		case "dir"
			sqlw = sqlw & "(NOMBRE_CALLE LIKE '%" & calle & "%'"
			if numerocalle<>"" then
				sqlw = sqlw & " AND NUMERO_PORTAL='" & numerocalle & "'"
			end if
			sqlw = sqlw & ")"
			'sqlw = sqlw & "(NUMERO_CALLE='" & NUMEROCALLE & "' OR NUMERO_CALLE LIKE '" & NUMEROCALLE & "-%' OR NUMERO_CALLE LIKE '%-" & NUMEROCALLE & "')"
		
		case "zona" 
			sqlw = sqlw & "(NOMBRE_ZONA LIKE '%" & zona & "%')"
		
		case "centro_comercial"
			sqlw = sqlw & "TIPOZONA LIKE '%centro%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "poligono_industrial"
			sqlw = sqlw & "TIPOZONA LIKE '%poligono%' AND TIPOZONA LIKE '%industrial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "parque_empresarial"
			sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%empresarial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
		case "parque_comercial"
			sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
			
		End select	
		
	end select
	
	select case pTipo	'ops
	case "ops_inversion"	
		sqlw = sqlw & " AND (ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3)"
		
	case "ops_alquiler"		
		sqlw = sqlw & " AND (ID_TIPO_OPERACION=2 OR ID_TIPO_OPERACION=4)"
	end select
	
	calcular_sqlw = "(" & sqlw & ")"
	
end function %>

<% function compilarsql(campo, busq) 	
	dim vari
	dim minisql
	
	vari = split(ucase(busq))
	
	minisql=""
	for each elto in vari
		if trim(elto)<>"" then
			if minisql<>"" then minisql = minisql & " AND " 
			minisql= minisql & "(" & campo & " LIKE '%#" & elto & "#%')" 
		end if
	next
		
	compilarsql = minisql
	
end function %>

<% sub simplifica(byRef pVar)			
	pVar = ucase(pVar)
	
	pVar = replace(pVar, " Y ", " ")
	
	pVar = replace(pVar, " DE ", " ")
	pVar = replace(pVar, " DEL ", " ")
	
	pVar = replace(pVar, " EL ", " ")
	pVar = replace(pVar, " LA ", " ")
	pVar = replace(pVar, " LOS ", " ")
	pVar = replace(pVar, " LAS ", " ")
	
	do while instr(pVar, "  ")>0
		pVar = replace(pVar, "  ", " ")
	loop
end sub %>

