<%
ON ERROR RESUME NEXT

'Variables globales 
dim FechaI
dim FechaF
public sql
public ErrMesage

intermediario=left(request("intermediario"), 100)
if intermediario="CUALQUIERA" or intermediario="" then intermediario="%"

comprador=left(request("comprador"), 100)
if comprador="CUALQUIERA" or comprador="" then comprador="%"
tipoComprador=request("tipocomprador")

vendedor=left(request("vendedor"), 100)
if vendedor="CUALQUIERA" or vendedor ="" then vendedor="%"

calle=left(request("Calle"), 100)
zona=left(request("zona"), 100)
if zona="CUALQUIERA" or zona ="" then zona ="%"

zonainmobiliaria=request("zonainmobiliaria")
if zonainmobiliaria="" then zonainmobiliaria="%"


'sqlW

'Operación		
r_operacion=request("operacion")
'sqlW = sqlW & "(ID_TIPO_OPERACION = " & request("operacion") & ") AND "
select case r_operacion 
case ""
	ErrMesage = "Falta Operaci&oacute;n."
case "venta"
	sqlW = sqlW & "(ID_TIPO_OPERACION=1 OR ID_TIPO_OPERACION=3) AND "
case "alquiler"
	sqlW = sqlW & "(ID_TIPO_OPERACION=2 OR ID_TIPO_OPERACION=4) AND "
end select

'Sección		
r_seccion=request("sec")
if r_seccion="" then 
	ErrMesage = "Falta Uso."
else
	sqlW = sqlW & "(seccion LIKE '%" & r_seccion & "%') AND "
end if

'if zonainmobiliaria <> "%" then sqlW = sqlW & "AND (TIPOAREA='"& zonainmobiliaria & "')"
if zonainmobiliaria <> "%" then sqlW = sqlW & "(ID_TIPO_AREA="& zonainmobiliaria & ") AND "

'Cód. Postal	
dim buscar(10)
if request("codpostal")<>"" and 1=2 then	
	aux = 1
	count = 1
	valores=request("codpostal")
	'valores=trim(replace(valores,vbcrlf," "))	'jp
	For a = 1 To Len(valores)
		If Mid(valores, a, 1) = chr(13) Then 	'chr(13) <= " "
			buscar(count) = Mid(valores, aux, a-aux)
			aux = a+1
			count = count + 1
		End If
	Next
	buscar(count)=Mid(valores,aux,(Len(valores)-aux+1))
	
	sqlTmp = ""
	For b = 1 To (count)
		buscar(b)=trim(buscar(b))
		buscar(b)=replace(buscar(b), chr(10), "")
		buscar(b)=replace(buscar(b), chr(13), "")
		if trim(buscar(b))<>"" then
			if sqlTmp <> "" then sqlTmp = sqlTmp & " OR "
			sqlTmp = sqlTmp & "CODIGO_POSTAL='" & request("provincia_cp") & trim(buscar(b)) & "'"
		end if
	Next
	
	sqlW = sqlW & " AND (" & sqlTmp & ")"
end if
'Dirección	
'response.write(request("pais"))
'response.write(request("provincia"))  
select case request("pais")
case ""
	
	if request("provincia")="2" then
		'ErrMesage = "Otras Ciudades."
		'sqlW = sqlW & " ( web_es=1 and  (ID_PROVINCIA<>3 AND ID_PROVINCIA<>2  AND ID_PROVINCIA<>0) )  AND (id_region IN (1, 2, 3, 5)) and "
		sqlW = sqlW & " ( web_es=1 and  (ID_PROVINCIA<>3 AND ID_PROVINCIA<>2  AND ID_PROVINCIA<>0) )  AND (id_region = 1) and "
	else
	   if request("provincia")="3" then
		'ErrMesage = "Internacional"
		'sqlW = sqlW & " ( web_es=1  and (id_region<>1 and id_region<>2 and id_region<>3 and id_region<>5) ) and "
		sqlW = sqlW & " ( web_es=1  and id_region <> 1  ) and "
	   else
		ErrMesage = "Falta Pa&iacute;/Provincia/Localidad."
           end if
	end if
case "1" 
	if request("localidad")="" then
		if request("provincia")="%" then
			'sqlW = "(C_OPERACIONES.ID_PAIS = 1) AND "
			'sqlW = sqlW & "(ID_PAIS = 1) AND "
			'sqlW = sqlW & "(id_region IN (1, 2, 3, 5)) AND "
		else	'request("provincia")<>""
			'sqlW = sqlW & "(C_OPERACIONES.ID_PROVINCIA=" & request("provincia") & ") AND "
			'sqlW = sqlW & "(ID_PAIS = 1) AND "
			sqlW = sqlW & "(ID_PROVINCIA=" & request("provincia") & ") AND "
		end if
	else	'request("localicad")<>""
		'sqlW = sqlW & "(C_OPERACIONES.ID_LOCALIDAD=" & request("localidad") & ") AND "
		sqlW = sqlW & "(ID_LOCALIDAD=" & request("localidad") & ") AND "
	end if
case "0"
	
	if request("provincia")="2" then
		'ErrMesage = "Otras Ciudades."
		'sqlW = sqlW & " ( web_es=1 and  (ID_PROVINCIA<>3 AND ID_PROVINCIA<>2  AND ID_PROVINCIA<>0) )  AND (id_region IN (1, 2, 3, 5)) and "
		sqlW = sqlW & " ( web_es=1 and  (ID_PROVINCIA<>3 AND ID_PROVINCIA<>2  AND ID_PROVINCIA<>0) )  AND (id_region = 1) and "

	else
	   if request("provincia")="3" then
		'ErrMesage = "Internacional"
		'sqlW = sqlW & " ( web_es=1  and (id_region<>1 and id_region<>2 and id_region<>3 and id_region<>5) ) and "
		sqlW = sqlW & " ( web_es=1  and id_region <> 1 ) and "
	   else
		ErrMesage = "Falta Pa&iacute;/Provincia/Localidad."
           end if
	end if

case else
	sqlW = sqlW & "(ID_PAIS = " & request("pais") & ") AND "
	if request("localidad")<>"" then
		sqlW = sqlW & "(ID_LOCALIDAD=" & request("localidad") & ") AND "
	end if
end select

If request("valores")<>"" then	
	aux = 1
	count = 1
	valores=request("valores")
	valores=trim(replace(valores, ",", vbcrlf))	
	
	For a = 1 To Len(valores)
		If asc(Mid(valores, a, 1)) = 10 Then
			buscar(count) = Mid(valores, aux, a-aux)
			aux = a+1
			count = count + 1
		End If
	Next
	buscar(count)=Mid(valores,aux,(Len(valores)-aux+1))
	
	sqlTmp = ""
	For b = 1 To (count)
		buscar(b)=trim(buscar(b))
		buscar(b)=replace(buscar(b), chr(10), "")
		buscar(b)=replace(buscar(b), chr(13), "")
		if trim(buscar(b))<>"" then
			if sqlTmp <> "" then sqlTmp = sqlTmp & " OR "
			select case request("R1")
			case "calle"
				sqlTmp = sqlTmp & "NOMBRE_CALLE LIKE '%" & trim(buscar(b)) & "%'"
			case else
				sqlTmp = sqlTmp & "NOMBRE_ZONA LIKE '%" & trim(buscar(b)) & "%'"
			end select
		end if
	Next
	
	sqlW = sqlW & "(" & sqlTmp & ") AND "
end if



'Intermediario		
if intermediario <> "%" then 
	sqlW = sqlW & "((NOMBRE LIKE '%" & intermediario & "%' OR OTROS_NOMBRES LIKE '%" & intermediario & "%')  AND tipo LIKE '%I') AND "
end if
'Vendedor			
if vendedor <> "%" then 
	sqlW = sqlW & "((NOMBRE LIKE '%" & vendedor & "%' OR OTROS_NOMBRES LIKE '%" & vendedor & "%') AND tipo='P') AND "
end if
'Comprador			
if comprador <> "%" then 
	sqlW = sqlW & "((NOMBRE LIKE '%" & comprador & "%' OR OTROS_NOMBRES LIKE '%" & comprador & "%') AND tipo='C') AND "
end if

'Precios		
	pvpi=Request("pvpi")
	pvpf=Request("pvpf")
	'Moneda=Request("moneda")
	if 	pvpi<>"" or pvpf<>"" then	
		if pvpi="" then pvpi="0"
		if pvpf="" then pvpf="1E15"
		
		select case r_operacion 
		case "venta"
			TipoPrecio= Request("TipoPrecio")
			select case TipoPrecio
			case "euro"
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (8,5) AND (PRECIO_EUR BETWEEN " & pvpi & " AND " & pvpf & "))"	'€, pts
				
				sqlW = sqlW & " AND "
				
			case "euro/m2"
				sqlW = sqlW & "("
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (10,4) AND (PRECIO_EUR BETWEEN " & pvpi & " AND " & pvpf & "))"	'€/m2, pts/m2
				sqlW = sqlW & " OR "
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (8,5) AND (PRECIO_EUR BETWEEN " & pvpi & "*METROS_CUADRADOS AND " & pvpf & "*METROS_CUADRADOS))"	'€, pts
				
				sqlW = sqlW & ") AND "
				
			end select
			
		case "alquiler"
			TipoPrecio= Request("TipoRenta")
			select case TipoPrecio
			case "euro/mes"
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (9,2) AND (PRECIO_EUR BETWEEN " & pvpi & " AND " & pvpf & "))"	'€, pts
				
				sqlW = sqlW & " AND "
				
			case "euro/m2/mes"
				sqlW = sqlW & "("
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (11,1) AND (PRECIO_EUR BETWEEN " & pvpi & " AND " & pvpf & "))"	'€/m2/mes, pts/m2/mes
				sqlW = sqlW & " OR "
				sqlW = sqlW & "(ID_TIPO_PRECIO IN (9,2) AND (PRECIO_EUR BETWEEN " & pvpi & "*METROS_CUADRADOS AND " & pvpf & "*METROS_CUADRADOS))"	'€/mes, pts/mes
				
				sqlW = sqlW & ") AND "
			end select
		
		end select
		
IF 1=2 THEN
		select case tipoprecioZ 
		case "euro"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS') AND ((PRECIO_EUR) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & ")) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2') AND ((PRECIO_EUR * METROS_CUADRADOS) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		case "euro/m2"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS') AND (((PRECIO_EUR)) BETWEEN (" & int(pvpi) & "*METROS_CUADRADOS) AND (" & int(pvpf) & "*METROS_CUADRADOS) )) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2') AND ((PRECIO_EUR) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		case "euro/ano"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS' OR TIPOPRECIO LIKE '&euro;/MES' OR TIPOPRECIO LIKE 'PTS/MES') AND ((PRECIO_EUR*12) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & ")) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2' OR TIPOPRECIO LIKE '&euro;/M2/MES' OR TIPOPRECIO LIKE 'PTS/M2/MES') AND (((PRECIO_EUR * METROS_CUADRADOS) * 12) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		case "euro/mes"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS' OR TIPOPRECIO LIKE '&euro;/MES' OR TIPOPRECIO LIKE 'PTS/MES') AND ((PRECIO_EUR) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & ")) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2' OR TIPOPRECIO LIKE '&euro;/M2/MES' OR TIPOPRECIO LIKE 'PTS/M2/MES') AND ((PRECIO_EUR * METROS_CUADRADOS) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		case "euro/m2/ano"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS') AND (((PRECIO_EUR)*12/(METROS_CUADRADOS)) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & ")) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2') AND ((PRECIO_EUR*12) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		case "euro/m2/mes"
			sqlW = sqlW & "(((TIPOPRECIO LIKE '€' OR TIPOPRECIO LIKE 'PTS') AND (((PRECIO_EUR)/(METROS_CUADRADOS)) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & ")) OR "
			sqlW = sqlW & "((TIPOPRECIO LIKE '€/M2' OR TIPOPRECIO LIKE 'PTS/M2') AND ((PRECIO_EUR) BETWEEN " & int(pvpi) & " AND " & int(pvpf) & "))) AND "
		end select
END IF


	end if

'Superficie		
	select case request("superf")
	case "0"
		sqlTmp = "METROS_CUADRADOS<300"
	case "300"
		sqlTmp = "METROS_CUADRADOS>=300 AND METROS_CUADRADOS<700"
	case "700"
		sqlTmp = "METROS_CUADRADOS>=700 AND METROS_CUADRADOS<1500"
	case "1500"
		sqlTmp = "METROS_CUADRADOS>=1500 AND METROS_CUADRADOS<3000"
	case "3000"
		sqlTmp = "METROS_CUADRADOS>=3000"
	end select
	
	if sqlTmp<>"" then sqlTmp = "(" & sqlTmp & ") AND "
	sqlW = sqlW & sqlTmp
	
	'if request("m2i")<>"" or request("m2f")<>"" then
	'	sqlTmp = ""
	'	if request("m2i")<>"" then
	'		sqlTmp = sqlTmp & "METROS_CUADRADOS>=" & request("m2i")
	'	end if	
	'	if request("m2f")<>"" then
	'		if sqlTmp<>"" then sqlTmp = sqlTmp & " AND "
	'		sqlTmp = sqlTmp & "METROS_CUADRADOS<=" & request("m2f")
	'	end if
	'	sqlW = sqlW & "(" & sqlTmp & ") AND "
	'end if

'Fechas			
	if Request("FechaI")="" or Request("FechaF")="" then
		ErrMesage="Falta(n) la(s) fecha(s)."
	else
		FechaI = cdate(Request("FechaI"))
		FechaF = cdate(Request("FechaF"))
	end if
	
	sqlW = sqlW & " ("
	select case request("tipofecha")
	case "op"	
		sqlW = sqlW & "FECHA_OPERACION"
	case else
		'sqlW = sqlW & "FECHA_ACTUALIZACION"
		sqlW = sqlW & "FECHA_OPERACION"
	end select
	sqlW = sqlW & " BETWEEN CONVERT(DATETIME, '" & FechaI & "', 103) AND CONVERT(DATETIME, '" & FechaF & "', 103)) "
	
	sqlW = sqlW & "AND (web_es<>0) "
	
	'response.Write(sqlW)
%>