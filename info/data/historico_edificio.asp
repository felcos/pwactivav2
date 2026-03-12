<!--#include virtual="/lib/aspjson/JSON_2.0.4.asp" -->
<%
if request.Form("informa")<>"" then
	response.Write("<li>")
	for each elto in request.Form
		response.Write(elto & ": " & request.Form(elto) & " &nbsp;//&nbsp; ")
	next
	response.Write("</li>")
end if

origen="info-inmuebles"

tipobusqueda=lcase(request.form("seltipo"))

idedificio = request.Form("id_edificio")
edificio = request.form("edificio")
edificio = replace(edificio, "'", "''")

calle = request.form("calle")
calle = replace(calle, "'", "''")
numerocalle = request.form("numerocalle")
numerocalle = replace(numerocalle, "'", "''")

zona = request.form("zona")
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

'session("PalabrasClave") = ucase(variable)

dim sql
set resultado = Server.CreateObject("ADODB.Recordset")
'session("connPW").CommandTimeout = 120

Dim member
Set member = jsObject()

sql = "(web_es<>0)"

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

sql = sql & " AND (" & compilarsql("PALABRAS_CLAVES", variable) &")"

sql = "SELECT TIPO_NOTICIA, COUNT(ID) AS contar FROM NOTICIAS_INMOBILIARIAS WHERE (" & sql & ") "
sql = sql & "GROUP BY TIPO_NOTICIA"

if request.Form("informa")="" then
	nots = 0
	rums = 0
	ests = 0
	
	resultado.Open sql, session("connPW")
	do while not resultado.eof
		select case resultado("TIPO_NOTICIA")
		case "N"
			nots = resultado("contar")
		case "W"
			rums = resultado("contar")
		case "E"
			ests = resultado("contar")
		end select
		
		resultado.movenext
	loop
	resultado.close
	
	member("not") = nots
	member("rum") = rums
	member("est") = ests

else
	response.Write("<li>" & sql & "</li>")
end if


'operaciones
sqlw = "(web_es<> 0) AND "

select case tipobusqueda
case "edif"
	sqlw = sqlw & "(id_edificio = " & idedificio
	sqlw = sqlw & " OR id_complejo = " & idedificio
	if request.Form("id_complejo")<>"" then
		sqlw = sqlw & " OR id_edificio=" & request.Form("id_complejo")
	end if
	if numerocalle<>"" then
		sqlw = sqlw & " OR (id_edificio=0 AND NOMBRE_CALLE = '" & calle & "' AND NUMERO_CALLE='" & numerocalle & "')"
	end if
	
	'if request.Form("id_complejo")<>"" then
	'	sqlw = sqlw & " OR id_complejo = " & request.Form("id_complejo")
	'end if 
	
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

'case "centro_comercial"
'	sqlw = sqlw & "TIPOZONA LIKE '%centro%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
'case "poligono_industrial"
'	sqlw = sqlw & "TIPOZONA LIKE '%poligono%' AND TIPOZONA LIKE '%industrial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
'case "parque_empresarial"
'	sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%empresarial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
'case "parque_comercial"
'	sqlw = sqlw & "TIPOZONA LIKE '%parque%' AND TIPOZONA LIKE '%comercial%' AND NOMBRE_ZONA LIKE '%" & ZONA & "%'"
				
End select

sql = "SELECT ID_TIPO_OPERACION, COUNT(ID) AS contar FROM C_OPERACIONES WHERE " & sqlw
sql = sql & " GROUP BY ID_TIPO_OPERACION"

if request.Form("informa")="" then
	ops_alq = 0
	ops_inv = 0
	
	resultado.Open sql, session("connPW")
	do while not resultado.eof
		select case resultado("ID_TIPO_OPERACION")
		case 1, 3	
			ops_inv = ops_inv + resultado("contar")
		case 2, 4
			ops_alq = ops_alq + resultado("contar")
		end select
		
		resultado.movenext
	loop
	resultado.close
		
	member("op_alq") = ops_alq
	member("op_inv") = ops_inv

else
	response.Write("<li>" & sql & "</li>")
	
	response.End()
	
end if

member.Flush

Set resultado = nothing


sub ofertas			
	sql = "SELECT COUNT(*) AS contar FROM c_ofertas WHERE " & calcular_sqlw("ofertas")
	'''test_inyeccion_sql sql
	resultado.Open sql, session("connPW")
	
	if resultado("contar")>0 then
		swCheck = true
	else
		swCheck = false
	end if
	
	response.Write(resultado("contar"))	
	resultado.close
end sub



function compilarsql(campo, busq) 	
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
	
end function

sub simplifica(byRef pVar)			
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
end sub
%>