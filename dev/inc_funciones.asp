<%
function calcular_http_mozilla(pStr) 
	str = lcase(pStr)
	str = left(str, instr(str, " "))
	
	calcular_http_mozilla = str
end function

function calcular_http_so(pStr) 
	str = pStr
	
	if instr(str, "Windows NT 6.3; WOW64") then
		calcular_http_so = "win 8.1 64"
	elseif instr(str, "Windows NT 6.3") then
		calcular_http_so = "win 8.1"
	elseif instr(str, "Windows NT 6.2; WOW64") then
		calcular_http_so = "win 8 64"
	elseif instr(str, "Windows NT 6.2") then
		calcular_http_so = "win 8"
		
	elseif instr(str, "Windows NT 6.1; WOW64") then
		calcular_http_so = "win 7 64"
	elseif instr(str, "Windows NT 6.1") then
		calcular_http_so = "win 7"
	
	elseif instr(str, "Windows NT 5.1") then
		calcular_http_so = "win XP"
		
	'mac OS
	elseif instr(str, "Macintosh; Intel Mac OS X 10") then
		calcular_http_so = "MacOS 10"
	
	'móviles
	elseif instr(str, "iPhone OS 7") then
		calcular_http_so = "iPhone 7"
	
	'Android
	elseif instr(str, "Android 4.4.2") then
		calcular_http_so = "Android"
	
	'Linux
	elseif instr(str, "Linux i686") then
		calcular_http_so = "Linux"
	elseif instr(str, "Linux x86_64") then
		calcular_http_so = "Linux"
		
	elseif instr(str, "https://") then
		calcular_http_so = "BOT"
	
	else
		if pStr="" then
			calcular_http_so = "BOT"
		else
			calcular_http_so = pStr
			if instr(calcular_http_so, "(") then
				calcular_http_so = left(calcular_http_so, instr(calcular_http_so, ")"))
				calcular_http_so = mid(calcular_http_so, instr(calcular_http_so, "(")+1, len(calcular_http_so))
			end if
			calcular_http_so = left(calcular_http_so, 15) & " ..."
		end if
	end if
	
end function

function calcular_http_navegador(pStr) 
	str = lcase(pStr)
	
	'explorer
	if instr(str, "rv:11.0") then
		calcular_http_navegador = "ie 11"
		
	elseif instr(str, "msie 10.0") then
		calcular_http_navegador = "ie 10"	
	elseif instr(str, "msie 9.0") then
		calcular_http_navegador = "ie 9"
	elseif instr(str, "msie 8.0") then
		calcular_http_navegador = "ie 8"
	elseif instr(str, "msie 7.0") then
		calcular_http_navegador = "ie 7"
	elseif instr(str, "msie 6.0") then
		calcular_http_navegador = "ie 6"
		
	'chrome
	elseif instr(str, "chrome") then
		calcular_http_navegador = "chrome"
	
	'firefox
	elseif instr(str, "firefox") then
		calcular_http_navegador = "firefox"
		
	'safari
	elseif instr(str, "safari") and instr(str, "macintosh") then
		calcular_http_navegador = "safari"
	elseif instr(str, "safari") and instr(str, "iphone") then
		calcular_http_navegador = "safari"
		
	'resto
	else
		calcular_http_navegador = left(pStr, instr(pStr, " "))
		calcular_http_navegador = left(calcular_http_navegador, 15) & "..."
		 
	end if
	
end function
%>