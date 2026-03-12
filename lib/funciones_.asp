<%
public sub test_inyeccion_sql(rSql)	
	cPasa=true
	crSql=lcase(rSql)
	
	if instr(crSql, "declare") then cPasa=false
	if instr(crSql, "update") then cPasa=false
	if instr(crSql, "chr(") then cPasa=false
	if instr(crSql, "http") then cPasa=false
	
	if not(cPasa) then
		
		sqlReg = "INSERT INTO ataques (session_id, fecha, hora, ip, querystring, form, cookie_pw, cookie_licencia, referer) VALUES ("
		sqlReg = sqlReg & "'" & session.SessionID & "', '" & date & "', '" & time & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("REMOTE_ADDR") & "', "
		
		sqlReg = sqlReg & "'" & AcomodaTexto(request.QueryString) & "', "
		sqlReg = sqlReg & "'" & AcomodaTexto(request.Form) & "', "

		sqlReg = sqlReg & "'" & request.Cookies("pw") & "', "
		sqlReg = sqlReg & "'" & request.Cookies("licencia") & "', "
		
		sqlReg = sqlReg & "'" & request.ServerVariables("HTTP_REFERER") & "'"
		
		sqlReg = sqlReg & ")"
		
		session("connPWAcesos").execute sqlReg
		
		'configurar servidor email 
		Dim myMail
		Set myMail = CreateObject("CDO.Message") 
		
		'This section provides the configuration information for the remote SMTP server.
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserver") ="smtp.propertyweb.eu"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
		
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
		
		myMail.From = "Servidor NAVIA <informatica@propertyweb.eu>"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="lcf013c"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="PWeu08"
		
		myMail.Configuration.Fields.Update
		
		myMail.Subject =  "Aviso de Ataque SQL"
		myMail.to = "informatica@propertyweb.eu"
		
		'Mail 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Se ha detectado un ataque SQL.</p>" & "<br>"
		txtMail = txtMail & "<p>" & date & " " & time & "</p>"
		txtMail = txtMail & "<p>REMOTE_ADDR: " & request.ServerVariables("REMOTE_ADDR") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>HTTP_REFERER:<br>" & request.ServerVariables("HTTP_REFERER") & "</p>" & "<hr>"
		txtMail = txtMail & "<p>QueryString:<br>" & request.QueryString & "</p>" & "<hr>"
		txtMail = txtMail & "<p>Form:<br>" & request.Form & "</p>" & "<hr>"
		txtMail = txtMail & "</BODY></HTML>"
		
		myMail.HTMLBody = txtMail
		
		On Error Resume Next
		myMail.Send
		
		Set myMail = Nothing
		
		response.End()
		
	end if
	
end sub

function AcomodaTexto(rSting)	
	tmp = trim(cstr("" & rSting))
	if tmp<>"" then
		tmp = replace(tmp, "'", "''")
	end if
	AcomodaTexto = tmp
end function
'ConvierteTexto(...) = AcomodaTexto(...)
function AcomodaBD(rTexto)	
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
	AcomodaBD=txtP
end function
'txtBD(...) = AcomodaBD(...)

public function EsMovil(pUA)	
	dim b, v
	if pUA="" then
		u = lcase(request.ServerVariables("HTTP_USER_AGENT"))
	else
		u = lcase(pUA)
	end if
	
	set b = new RegExp
	set v = new RegExp
	
	b.Pattern="(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino"
	v.Pattern="1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-"
	
	b.IgnoreCase=true
	v.IgnoreCase=true
	b.Global=true
	v.Global=true
	
	EsMovil = false
	if b.test(u) or v.test(Left(u,4)) then EsMovil = true
	
	
end function


function QuitaCaracteresNoValidos(rTexto)	
	txtP=rTexto
	
	QuitaCaracteresNoValidos = ""
	
	for ii=1 to len(txtP)
		car = mid(txtP, ii, 1)
		
		car = ConvierteCaracterValido(car)
		
		QuitaCaracteresNoValidos = QuitaCaracteresNoValidos & car
		
	next
	
	if xxtxtP<>"" then
		txtP=replace(txtP, "á", "a")
		txtP=replace(txtP, "Á", "A")
		txtP=replace(txtP, "à", "a")
		txtP=replace(txtP, "À", "A")
		
		txtP=replace(txtP, "&aacute;", "a")
		txtP=replace(txtP, "&Aacute;", "A")
		txtP=replace(txtP, "&agrave;", "a")
		txtP=replace(txtP, "&Agrave;", "A")
		
		txtP=replace(txtP, "é", "e")
		txtP=replace(txtP, "É", "E")
		txtP=replace(txtP, "è", "e")
		txtP=replace(txtP, "È", "E")
		
		txtP=replace(txtP, "&eacute;", "e")
		txtP=replace(txtP, "&Eacute;", "E")
		txtP=replace(txtP, "&egrave;", "e")
		txtP=replace(txtP, "&Egrave;", "E")
		
		txtP=replace(txtP, "í", "i")
		txtP=replace(txtP, "Í", "I")
		txtP=replace(txtP, "ì", "i")
		txtP=replace(txtP, "Ì", "I")
		
		txtP=replace(txtP, "", "i")
		txtP=replace(txtP, "&Iacute;", "I")
		txtP=replace(txtP, "&igrave;", "i")
		txtP=replace(txtP, "", "I")
		
		txtP=replace(txtP, "ó", "o")
		txtP=replace(txtP, "Ó", "O")
		txtP=replace(txtP, "ò", "o")
		txtP=replace(txtP, "Ò", "O")
		
		txtP=replace(txtP, "&oacute;", "o")
		txtP=replace(txtP, "&Oacute;", "O")
		txtP=replace(txtP, "&ograve;", "o")
		txtP=replace(txtP, "&Ograve;", "O")
		
		txtP=replace(txtP, "ú", "u")
		txtP=replace(txtP, "Ú", "U")
		txtP=replace(txtP, "ù", "u")
		txtP=replace(txtP, "Ù", "U")
		
		txtP=replace(txtP, "&uacute;", "u")
		txtP=replace(txtP, "&Uacute;", "U")
		txtP=replace(txtP, "&ugrave;", "u")
		txtP=replace(txtP, "&Ugrave;", "U")
		
		'txtP=replace(txtP, "ñ", "&ntilde;")
		'txtP=replace(txtP, "Ñ", "&Ntilde;")
		'txtP=replace(txtP, "ç", "&ccedil;")
		'txtP=replace(txtP, "Ç", "&Ccedil;")
		
		'txtP=replace(txtP, "€", "&euro;")
		txtP=replace(txtP, "¿", "")
		txtP=replace(txtP, "º", "")
		txtP=replace(txtP, "ª", "")
		
		
	end if
	'QuitaCaracteresNoValidos=txtP
end function

function ConvierteCaracterValido(rCar)	
	vcar = asc(rCar)
	
	select case vcar
	case -15455, -15456, -15452, -15454 
		vcar = 97	'a
	case -15487, -15488, -15484, -15486 
		vcar = 65	'A
	
	case -15447, -15448, -15445, -15446 
		vcar = 101	'e
	case -15479, -15480, -15477, -15478 
		vcar = 69	'E
		
	case -15443, -15444 
		vcar = 105	'i
	case -15475, -15476 
		vcar = 73	'I
		
	case -15437, -15438  
		vcar = 111	'o
	case -15469, -15470  
		vcar = 79	'O
		
	case -15430, -15431   
		vcar = 117	'u
	case -15462, -15463 
		vcar = 85	'U
	
	end select
	
	ConvierteCaracterValido = vcar
end function



function FormatoFecha(rFecha)
	yy=year(rFecha)
	mm=month(rFecha)
	if mm<=9 then mm = "0" & mm
	dd=day(rFecha)
	if dd<=9 then dd = "0" & dd
	
	FormatoFecha = yy & "-" & mm & "-" & dd
end function

function FechaCorta(rFecha)
	if isdate(rFecha) then
		mm = month(rFecha)
		if len(cstr(mm))<2 then mm = "0" & mm
		
		yy = mid(year(rFecha), 3, 2)
		
		FechaCorta = mm & "/" & yy
	else
		FechaCorta = ""
	end if
end function

function VERSALITA(Caden) 
    VERSALITA = UCase(Left(Caden, 1)) & LCase(Right(Caden, Len(Caden) - 1))
end function

function VERSALITA_TODO(Caden) 
	dim a 
	dim wordsI(100)
	dim CuentPal
	dim IniPal
	dim cami 
	Caden = Caden & " "
	CuentPal = 1
	IniPal = 0
	for a = 1 to len(Caden)
		If mid(Caden, a, 1) = " " then
			wordsI(CuentPal) = lcase(mid(Caden, IniPal + 1, (a - IniPal)))
			if wordsI(CuentPal) <> "el " and _
			wordsI(CuentPal) <> "la " and  _
			wordsI(CuentPal) <> "los " and wordsI(CuentPal) <> "las " and _
			wordsI(CuentPal) <> "del " and wordsI(CuentPal) <> "de " then
				wordsI(CuentPal) = VERSALITA(wordsI(CuentPal))
			end if
			if wordsI(CuentPal) = "I " or wordsI(CuentPal) = "Ii " or _
			wordsI(CuentPal) = "Iii " or wordsI(CuentPal) = "Iv " or _
			wordsI(CuentPal) = "V " or wordsI(CuentPal) = "Vi " or _
			wordsI(CuentPal) = "Vii " or wordsI(CuentPal) = "Viii" or _
			wordsI(CuentPal) = "Ix " or wordsI(CuentPal) = "X " or _
			wordsI(CuentPal) = "Xi " or wordsI(CuentPal) = "Xii " or _
			wordsI(CuentPal) = "Xiii " or wordsI(CuentPal) = "Xiv" then
				wordsI(CuentPal) = UCase(wordsI(CuentPal))
			end if
			cami = cami & wordsI(CuentPal)
			IniPal = a
			cuenpal = cuenpal + 1
		end if
	next
	
	VERSALITA_TODO = Left(cami, Len(cami) - 1)
end function


%>
