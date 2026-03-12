<% 
	if session("PalabrasClave")<>"" then 
		%>Palabras Clave: [<strong><%= session("PalabrasClave") %></strong>]<br /><% 
	end if

'if request.Cookies("dev")<>"" or request.Cookies("licencia")("u")="PW" then 
	tmpTxt = ucase(pRS("PALABRAS_CLAVES"))
	'tmpTxt = replace(tmpTxt, vbcrlf, " # ")
	'tmpTxt = "<p># " & tmpTxt & " #</p>"
	'tmpTxt = replace(tmpTxt, vbcrlf, "</li><li>")
	'tmpTxt = "<li> " & tmpTxt & " </li>"
	
	palabras = split(session("PalabrasClave"))
	for each elto in palabras
		
		select case elto
		case "OFICINA", "OFICINAS"
			tmpTxt=replace(tmpTxt, "#OFICINAS#", "#¬OFICINAS#")
			tmpTxt=replace(tmpTxt, "#OFICINA#", "#¬OFICINA#")
			
		case "LOCAL", "LOCALES"
			tmpTxt=replace(tmpTxt, "#LOCALES#", "#¬LOCALES#")
			tmpTxt=replace(tmpTxt, "#LOCAL#", "#¬LOCAL#")
		case "COMERCIAL", "COMERCIALES"
			tmpTxt=replace(tmpTxt, "#COMERCIALES#", "#¬COMERCIALES#")
			tmpTxt=replace(tmpTxt, "#COMERCIAL#", "#¬COMERCIAL#")
		case "HOTEL", "HOTELES"
			tmpTxt=replace(tmpTxt, "#HOTELES#", "#¬HOTELES#")
			tmpTxt=replace(tmpTxt, "#HOTEL#", "#¬HOTEL#")
		case "VIVIENDA", "VIVIENDAS"
			tmpTxt=replace(tmpTxt, "#VIVIENDAS#", "#¬VIVIENDAS#")
			tmpTxt=replace(tmpTxt, "#VIVIENDA#", "#¬VIVIENDA#")
			
		case "RESIDENCIAL", "RESIDENCIALES"
			tmpTxt=replace(tmpTxt, "#RESIDENCIALES#", "#¬RESIDENCIALES#")
			tmpTxt=replace(tmpTxt, "#RESIDENCIAL#", "#¬RESIDENCIAL#")
		case "INDUSTRIAL", "INDUSTRIALES"
			tmpTxt=replace(tmpTxt, "#INDUSTRIALES#", "#¬INDUSTRIALES#")
			tmpTxt=replace(tmpTxt, "#INDUSTRIAL#", "#¬INDUSTRIAL#")
			
		case "CENTRO", "CENTROS"
			tmpTxt=replace(tmpTxt, "#CENTROS#", "#¬CENTROS#")
			tmpTxt=replace(tmpTxt, "#CENTRO#", "#¬CENTRO#")
		case "SOLAR", "SOLARES"
			tmpTxt=replace(tmpTxt, "#SOLARES#", "#¬SOLARES#")
			tmpTxt=replace(tmpTxt, "#SOLAR#", "#¬SOLAR#")
		case "PARQUE", "PARQUES"
			tmpTxt=replace(tmpTxt, "#PARQUES#", "#¬PARQUES#")
			tmpTxt=replace(tmpTxt, "#PARQUE#", "#¬PARQUE#")
		case "POLIGONO", "POLIGONOS"
			tmpTxt=replace(tmpTxt, "#POLIGONOS#", "#¬POLIGONOS#")
			tmpTxt=replace(tmpTxt, "#POLIGONO#", "#¬POLIGONO#")
			
		case else
			tmpTxt=replace(tmpTxt, "#" & elto & "#", "#¬" & elto & "#")
		end select
		
	next
	
	palabras = split(tmpTxt, "#")
	for each elto in palabras
		if left(elto, 1)="¬" then
			clase = "success"
			elto = mid(elto, 2)
		else
			clase = "primary"
		end if
		%><span class="label label-<%= clase %>"><%= lcase(elto) %></span> <%
	next
%>