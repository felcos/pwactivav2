<%
'@LANGUAGE="VBSCRIPT"
'on error resume next

'No Cach�
'Response.addHeader "pragma", "no-cache"
'Response.CacheControl = "Private"
'response.expires=0
'response.buffer=false

'dim ContadoresOps(5, 2)
'dim ContadorVenc
'dim LimitesOps(5, 2)
'dim LimitesVenc
'LimitesOps(1,0)=30		'oficinas inversion
'LimitesOps(1,1)=50		'oficinas alquiler
'LimitesOps(2,0)=15		'locales inversion
'LimitesOps(2,1)=30		'locales alquiler
'LimitesOps(3,0)=10		'hoteles inversion
'LimitesOps(3,1)=10		'hoteles alquiler
'LimitesOps(4,0)=12		'naves inversion
'LimitesOps(4,1)=20		'naves alquiler
'LimitesVenc=35

call insert_reg_pag()

public sub insert_reg_pag() 
	'if request.Cookies("dev")("reg")<>"" then exit sub
	'if request.Cookies("licencia")("log")<>"" then exit sub
	if generando_report then exit sub
	
	resp_reg = session("pw_ws").Reg(request.ServerVariables("PATH_INFO"), request.Form, request.QueryString, request.ServerVariables("HTTP_REFERER"))
	
end sub

public sub insert_reg_articulo(pSeccion, pTipo, pId) 
	'on error exit sub
	'if request.Cookies("dev")("reg")<>"" then exit sub
	'if request.Cookies("licencia")("log")<>"" then exit sub
	if generando_report then exit sub
	'response.Write("HOLA....")
	secc = pSeccion
	if secc = "" then secc = pTipo 
	
	resp = session("pw_ws").RegArticulo(cstr(secc), cstr(pTipo), cstr(pId), cstr(session("origen")))
	'response.Write(resp)
	'response.write(cstr(secc)&"-"& cstr(pTipo)&"-"&  cstr(pId)&"-"&  cstr(session("origen")))

	if request.Cookies("dev")<>"" then 
		
		select case resp
		case 0
			msg_resp = "OK"
			tipo = "success"
		case 1
			msg_resp = "no insertado, art&iacute;culo ya le&iacute;do"
			
		case 100
			msg_resp = "modo NoTrack (RegAccesos deshabilitado)"
			tipo = "warning"
		case 101
			msg_resp = "RegAccesos no inicializado"
			tipo = "warning"
			
		case else
			msg_resp = "Error indefinido: " & resp
			tipo = "danger"
		end select
		
		select case pTipo
		case "ope", "ven"
			url = "/cliente/quotas.asp"
		case else
			url = "/cliente/leidos.asp"
		end select

		%><script>
        $(document).ready(function() {
            
			$.get("<%= url %>", function(recibe){
                $.notify(
                    {
                    message: "<p>RegArticulo (<%= pTipo %>,  <%= pId %>) : [<b><%= resp %></b>]</p><p>&nbsp; <%= msg_resp %></p><p>[secc: <%= pSeccion %>] [origen:<%= pOrigen %>]</p>",
                    //message: recibe
                    //title
                    }, 
                    {
                        <% if tipo<>"" then %>type: "<%= tipo %>",<% end if %>
                        animate: {
                            enter: "animated fadeInDown",
                            exit: "animated fadeOutUp"
                        },
                        placement: {
                            from: "top",
                            align: "left"
                        }, 
                        newest_on_top: true,
                        showProgressbar: true,
                        delay: 5000,
                        timer: 250,
                        mouse_over: "pause"
                    }
                );
            });
            
            $.get("/articulos/contador.asp?t=<%= pTipo %>", function(recibe){
                //console.log("secc:< %= pSeccion %>", "tipo:< %= pTipo %>", recibe)
                $("*[data-toggle='contador_leidos'][data-content='<%= pSeccion %>']").text(recibe)
            });
            
        });
        </script><%
		
	end if
	
'	rEmail = session("pw_ws").Licencia
'	rFecha = date
'	
'	'oficinas
'	'if ContadoresOps(1,0)>=LimitesOps(1,0) then call Bloquear("oficinas inversion", rEmail, rFecha)
'	'if ContadoresOps(1,1)>=LimitesOps(1,1) then call Bloquear("oficinas alquiler", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("oficinas inversion")>=session("pw_ws").GetQuota("oficinas inversion") then call Bloquear("oficinas inversion", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("oficinas alquiler")>=session("pw_ws").GetQuota("oficinas alquiler") then call Bloquear("oficinas alquiler", rEmail, rFecha)
'	
'	'locales
'	'if ContadoresOps(2,0)>=LimitesOps(2,0) then call Bloquear("locales inversion", rEmail, rFecha)
'	'if ContadoresOps(2,1)>=LimitesOps(2,1) then call Bloquear("locales alquiler", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("locales inversion")>=session("pw_ws").GetQuota("locales inversion") then call Bloquear("locales inversion", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("locales alquiler")>=session("pw_ws").GetQuota("locales alquiler") then call Bloquear("locales alquiler", rEmail, rFecha)
'	
'	'hoteles
'	'if ContadoresOps(3,0)>=LimitesOps(3,0) then call Bloquear("hoteles inversion", rEmail, rFecha)
'	'if ContadoresOps(3,1)>=LimitesOps(3,1) then call Bloquear("hoteles alquiler", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("hoteles inversion")>=session("pw_ws").GetQuota("hoteles inversion") then call Bloquear("hoteles inversion", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("hoteles alquiler")>=session("pw_ws").GetQuota("hoteles alquiler") then call Bloquear("hoteles alquiler", rEmail, rFecha)
'	
'	'naves
'	'if ContadoresOps(4,0)>=LimitesOps(4,0) then call Bloquear("naves inversion", rEmail, rFecha)
'	'if ContadoresOps(4,1)>=LimitesOps(4,1) then call Bloquear("naves alquiler", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("naves inversion")>=session("pw_ws").GetQuota("naves inversion") then call Bloquear("naves inversion", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("naves alquiler")>=session("pw_ws").GetQuota("naves alquiler") then call Bloquear("naves alquiler", rEmail, rFecha)
'	
'	'vencimientos
'	'if ContadoresVenc>=LimitesVenc then call Bloquear("vencimientos", rEmail, rFecha)
'	if session("pw_ws").GetLeidos("vencimientos")>=session("pw_ws").GetQuota("vencimientos") then call Bloquear("vencimientos", rEmail, rFecha)
'	
end sub

public sub insert_reg_sql(pSql) 
	sqlReg = "INSERT INTO reg_sql (session_id, date, url, querystring, form, sql) "
	sqlReg = sqlReg & "VALUES ("
	sqlReg = sqlReg & "'" & session.SessionID & "', GETDATE(), "
	
	sqlReg = sqlReg & "'" & replace(lcase(request.ServerVariables("PATH_INFO")), "default.asp", "") & "', "
	if request.QueryString="" then 
		sqlReg = sqlReg & "NULL, "
	else
		sqlReg = sqlReg & "'" & AcomodaTexto(request.QueryString) & "', "
	end if
	if request.Form="" then 
		sqlReg = sqlReg & "NULL, "
	else
		for each elto in request.Form
			if rf<>"" then rf = rf & "&"
			rf = rf & elto & "=" & request.Form(elto)
		next
		rf = AcomodaTexto(rf)
		sqlReg = sqlReg & "'" & rf & "', "
	end if
	
	
	rSql = replace(pSql, "'", "''")
	sqlReg = sqlReg & "'" & rSql & "'"
	
	
	sqlReg = sqlReg & ")"
	
	'response.Write(sqlReg)
	'response.End()
	
	session("connPWAcesos").execute sqlReg
	
end sub

public sub Bloquear(tipo, rEmail, rFecha)	
	if instr(session("bloqueos"), "#" & tipo & "#") then exit sub
	
	set rsTmp = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT * FROM avisos WHERE licencia='" & rEmail & "' AND fecha='" & rFecha & "' AND aviso='" & tipo & "'"
	rsTmp.open sql, session("connPWAcesos")
	if rsTmp.eof then
		Dim myMail
		Set myMail = CreateObject("CDO.Message") 
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusing") = 2	'SMTP
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserver") ="smtp.propertyweb.eu"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1	'basic (clear-text)
	
		myMail.From = "Property Web <pw@propertyweb.eu>"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="mbm908c"
		myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="pweu9907"
		'myMail.From = "informatica@propertyweb.eu"
		'myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendusername") ="lcf013c"
		'myMail.Configuration.Fields.Item ("https://schemas.microsoft.com/cdo/configuration/sendpassword") ="PWeu08"
		
		myMail.Configuration.Fields.Update
		
'		if instr(rEmail, "@propertyweb.")>0 then
			myMail.to = "informatica@propertyweb.eu"
'			myMail.bcc = "pabloe@propertyweb.eu; propertywebeu@gmail.com"
'		else
'			myMail.to = "pw@propertyweb.eu"
'			myMail.bcc = "informatica@propertyweb.eu; comercial@propertyweb.eu"
'		end if
		
		myMail.Subject =  "Alerta PW - uso excesivo"
		
		verTipo = tipo
		verTipo = replace(verTipo, "inversion", "Inversi&oacute;n/Ocupaci&oacute;n Propia")
		verTipo = replace(verTipo, "alquiler", "Alquiler/Traspaso")
		
		'texto email 
		txtMail = "<HTML><BODY>"
		txtMail = txtMail & "<p>Alcanzado el l&iacute;mite para " & verTipo & ": m&aacute;x. "
		txtMail = txtMail & session("pw_ws").GetQuota(cstr(tipo))
		txtMail = txtMail & " art&iacute;culos.</p>"
		txtMail = txtMail & "<ul>"
		txtMail = txtMail & "<li>" & rEmail & "</li>"
		txtMail = txtMail & "<li>" & verTipo & "</li>"
		txtMail = txtMail & "<li>" & rFecha & "</li>"
		txtMail = txtMail & "</ul>"
		txtMail = txtMail & "<p></p>"
		txtMail = txtMail & "</BODY></HTML>"
		 
		myMail.HTMLBody = txtMail
		
		myMail.Send
		
		if Err = 0 then 
			sql = "INSERT INTO avisos (licencia, fecha, aviso, enviado) VALUES ('" & rEmail & "', '" & rFecha & "', '" & tipo & "', GETDATE())"
			session("connPWAcesos").execute sql
		end if
			 
		Set myMail = Nothing 
		
	else
		'ya avisado
		
	end if
	
	session("bloqueos") = session("bloqueos") & tipo & "#"
	
	rsTmp.close
	set rsTmp = nothing
end sub


public function LimiteSeleccionar(uso, operacion)
	LimiteSeleccionar=0
	
	select case uso
	case "oficinas"
		select case operacion
		case "venta"
			LimiteSeleccionar = 2000
		case "alquiler"
			LimiteSeleccionar = 3000
		end select
	
	case "locales comerciales"
		select case operacion
		case "venta"
			LimiteSeleccionar = 12
		case "alquiler"
			LimiteSeleccionar = 10
		end select
	
	case "centros comerciales"
		select case operacion
		case "venta"
			LimiteSeleccionar = 10
		'case "alquiler"	LIBRE
			'no existen
		'	LimiteSeleccionar = 
		end select
	
	case "hoteles"
		select case operacion
		case "venta"
			LimiteSeleccionar = 15
		case "alquiler"
			LimiteSeleccionar = 150
		end select

	case "solares"
		select case operacion
		case "venta"
			LimiteSeleccionar = 150
		case "alquiler"
			LimiteSeleccionar = 150
		end select

	case "vivienda/coliving"
		select case operacion
		case "venta"
			LimiteSeleccionar = 15
		case "alquiler"
			LimiteSeleccionar = 15
		end select	
	case "naves industriales"
		select case operacion
		case "venta"
			LimiteSeleccionar = 15
		case "alquiler"
			LimiteSeleccionar = 25
		end select

	case "viviendas residenciales"
		select case operacion
		case "venta"
			LimiteSeleccionar = 15
		'case "alquiler"	LIBRE
		'	LimiteSeleccionar = 
		end select
		
	end select
	
end function
%>