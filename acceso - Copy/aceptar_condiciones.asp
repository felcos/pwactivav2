<%
if request.Cookies("licencia")="" then 
	sw_pasa = false
else
	sw_pasa = true
	
	if session("PW_WS").Comprobar_Empresa(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"))<>0 then sw_pasa = false
	if session("PW_WS").Comprobar_Licencia(request.Cookies("licencia")("u"), request.Cookies("licencia")("p"), request.Cookies("licencia")("n"), request.Cookies("licencia")("user_id"))<>0 then sw_pasa = false
	
	if sw_pasa then
		session("PW_WS").boolAceptadasCondiciones = true
		response.Cookies("condiciones")="true"
		
	else
		response.Cookies("condiciones")=""
		
	end if
	
end if

response.Write(session("PW_WS").boolAceptadasCondiciones)
%>