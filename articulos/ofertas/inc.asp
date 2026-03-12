<%
function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function ConvierteTexto(rSting)	
	tmp = cstr(rSting)
	
	tmp = replace(tmp, "'", "''")
	
	ConvierteTexto = tmp
end function 

function txtBD(rTexto)	
	txtP=rTexto
	if txtP<>"" then
		txtP=replace(txtP, "á", "&aacute;")
		txtP=replace(txtP, "Á", "&Aacute;")
		txtP=replace(txtP, "à", "&agrave;")
		txtP=replace(txtP, "À", "&Agrave;")
		txtP=replace(txtP, "é", "&eacute;")
		txtP=replace(txtP, "É", "&Eacute;")
		txtP=replace(txtP, "è", "&egrave;")
		txtP=replace(txtP, "È", "&Egrave;")
		txtP=replace(txtP, "í", "&iacute;")
		txtP=replace(txtP, "Í", "&Iacute;")
		txtP=replace(txtP, "ì", "&igrave;")
		txtP=replace(txtP, "Ì", "&Igrave;")
		txtP=replace(txtP, "ó", "&oacute;")
		txtP=replace(txtP, "Ó", "&Oacute;")
		txtP=replace(txtP, "ò", "&ograve;")
		txtP=replace(txtP, "Ò", "&Ograve;")
		txtP=replace(txtP, "ú", "&uacute;")
		txtP=replace(txtP, "Ú", "&Uacute;")
		txtP=replace(txtP, "ù", "&ugrave;")
		txtP=replace(txtP, "Ù", "&Ugrave;")
		txtP=replace(txtP, "ñ", "&ntilde;")
		txtP=replace(txtP, "Ñ", "&Ntilde;")
		txtP=replace(txtP, "ç", "&ccedil;")
		txtP=replace(txtP, "Ç", "&Ccedil;")
		
		txtP=replace(txtP, "€", "&euro;")
		txtP=replace(txtP, "¿", "&iquest;")
		txtP=replace(txtP, "º", "&deg;")
		txtP=replace(txtP, "ª", "&ordf;")
	end if
	txtBD=txtP
end function
%>