<%
origen="info-empresas"

limitenoticias=250
limiteestudios=75
limiterumores=150
limiteoperaciones=250

annoi = request.form("vMin")
annof = request.form("vMax")

if request.Form("intervalo")<>"" then
	intervalo = split(request.Form("intervalo"),";")
	if intervalo(1) >= intervalo(0) then
		annoi = intervalo(0)
		annof = intervalo(1)
	else
		annoi = intervalo(1)
		annof = intervalo(0)
	end if
end if


empresa=request.form("empresa")
empresa_id=request.form("id")

variable = ucase(empresa)

'********************
session("PalabrasClave") = variable
'call simplifica(variable)
%>
<% Public function calcular_sqlw(pTipo)	
	dim sqlw
	
	select case pTipo
	case "noticias"			
		sqlw = "(web_es<>0) AND (TIPO_NOTICIA='N') "
		sqlw = sqlw & " AND (FECHA_NOTICIA BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) "
		sqlw = sqlw & " AND ((PALABRAS_CLAVES LIKE '%" & EMPRESA & "%')"
		sqlw = sqlw & " OR (" & compilarsql("PALABRAS_CLAVES", variable) &"))"
		calcular_sqlw = "(" & sqlw & ")"
		
	case "estudios"			
		sqlw = "(web_es<>0) AND (TIPO_NOTICIA='E') "
		sqlw = sqlw & " AND (FECHA_NOTICIA BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) "
		sqlw = sqlw & " AND ((PALABRAS_CLAVES LIKE '%" & EMPRESA & "%')"
		sqlw = sqlw & " OR (" & compilarsql("PALABRAS_CLAVES", variable) &"))"
		calcular_sqlw = "(" & sqlw & ")"
		
	case "rumores"			
		sqlw = "(web_es<>0) AND (TIPO_NOTICIA LIKE 'W') "
		sqlw = sqlw & " AND (FECHA_NOTICIA BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) "
		sqlw = sqlw & " AND ((PALABRAS_CLAVES LIKE '%" & EMPRESA & "%')"
		sqlw = sqlw & " OR (" & compilarsql("PALABRAS_CLAVES", variable) &"))"
		calcular_sqlw = "(" & sqlw & ")"
		
	case "ops"		
		sqlw = "(web_es<> 0) AND "
		sqlw = sqlw & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) AND "
		sqlw = sqlw & "(id_empresa=" & empresa_id & " OR id_sucursal=" & empresa_id & ")"
	
	case "ops_inversion"	
		sqlw = "(web_es<> 0) AND "
		sqlw = sqlw & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) AND "
		sqlw = sqlw & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) AND "
		sqlw = sqlw & "(id_empresa=" & empresa_id & " OR id_sucursal=" & empresa_id & ")"
		
	case "ops_alquiler"		
		sqlw = "(web_es<> 0) AND "
		sqlw = sqlw & "(ID_TIPO_OPERACION=2 OR ID_TIPO_OPERACION=4) AND "
		sqlw = sqlw & "(FECHA_ACTUALIZACION BETWEEN CONVERT(DATETIME, '01/01/" & annoi & "', 103) AND CONVERT(DATETIME, '31/12/" & annof & "', 103)) AND "
		sqlw = sqlw & "(id_empresa=" & empresa_id & " OR id_sucursal=" & empresa_id & ")"
		
	case "ofertas"			
		sqlw = "(web_es<> 0) AND "
		
		select case tipobusqueda
		case "edificio" 
			sqlw = sqlw & "(ID_EDIFICIO = " & idedificio & ")"
			
		case "direccion"
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
	
	'calcular_sqlw = "(" & sqlw & ")"
	calcular_sqlw = sqlw
	
end function %>

<% function compilarsql(campo, busq) 	
	dim vari
	dim minisql
	
	vari = split(ucase(busq))
	
	minisql=""
	for each elto in vari
		if trim(elto)<>"" and trim(elto)<>"&" then
			if minisql<>"" then minisql = minisql & " AND " 
			'minisql= minisql & "(" & campo & " LIKE '%#" & elto & "#%')" 
			minisql= minisql & "(" & campo & " LIKE '%" & elto & "%')" 
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

<% public sub empresar(empresita)		

' voy a depurar la futura búsqueda
empresita = empresita & " "

empresita = replace(empresita, "&", "")
empresita = replace(empresita, "¬", "")

c=1
for i = 1 to len(empresita)
	if mid(empresita,i,1) = " " then
		empres(c) = trim(left(empresita, i-1))
		'response.write "<li>empresc=[" & empres(c) & "]</li>"
		empresita = right(empresita,len(empresita)-i)
		i=1
		c=c+1
	end if
next
end sub %>
