<%@ LANGUAGE="VBSCRIPT" CODEPAGE="65001"%><%

function CalcularNavegador(pTxt)	
	dim strContent
	strContent = lcase(pTxt)
	
	
	if instr(strContent, "chrome") > 0 then
		CalcularNavegador = "chrome"
	elseif instr(strContent, "opera") > 0 then
		CalcularNavegador = "opera"
	
	elseif instr(strContent, "rv:11.0") then
		CalcularNavegador = "ie 11"
	elseif instr(strContent, "msie 10.0") then
		CalcularNavegador = "ie 10"	
	elseif instr(strContent, "msie 9.0") then
		CalcularNavegador = "ie 9"
	elseif instr(strContent, "msie 8.0") then
		CalcularNavegador = "ie 8"
	elseif instr(strContent, "msie 7.0") then
		CalcularNavegador = "ie 7"
	elseif instr(strContent, "msie 6.0") then
		CalcularNavegador = "ie 6"
		
	elseif instr(strContent, "firefox") > 0 then
		CalcularNavegador = "firefox"
	
		
	elseif instr(strContent, "safari") > 0 then
		CalcularNavegador = "safari"
		
	else
		CalcularNavegador = "--"
	end if
	
end function

function CalcularSO(pTxt)	
	str = lcase(pTxt)
	
	if instr(str, "windows nt 10.0")>0 then
		CalcularSO = "win 10"
	elseif instr(str, "nt 6.3")>0 then
		CalcularSO = "win 8.1"
	elseif instr(str, "windows nt 6.2")>0 then
		CalcularSO = "win 8"
	elseif instr(str, "windows nt 6.1")>0 then
		CalcularSO = "win 7"
	elseif instr(str, "windows nt 6.0")>0 then
		CalcularSO = "win Vista"
	elseif instr(str, "windows nt 5.2")>0 then
		CalcularSO = "win XP/2003"
	elseif instr(str, "windows nt 5.1")>0 then
		CalcularSO = "win XP"
	elseif instr(str, "windows nt 5.0")>0 then
		CalcularSO = "win 2000"
		
	'mac OS
	elseif instr(str, "macintosh")>0 and instr(str, "intel mac os x 10")>0 then
		CalcularSO = "MacOS 10"
	
	'iPad
	elseif instr(str, "ipad")>0 and instr(str, "like mac os x")>0 then
		CalcularSO = "iPad"
	
	'iPhone
	elseif instr(str, "iphone os 7")>0 then
		CalcularSO = "iOS 7"
	elseif instr(str, "iphone os 8")>0 then
		CalcularSO = "iOS 8"
		
	'Android
	elseif instr(str, "android")>0 then
		CalcularSO = "Android"
	
	'Linux
	elseif instr(str, "linux i686")>0 then
		CalcularSO = "Linux"
	elseif instr(str, "linux x86_64")>0 then
		CalcularSO = "Linux"
	
	else
		CalcularSO = ""
		
	end if
	
	'Win 64 bits
	if instr(str, "wow64") or instr(str, "x64") then
		CalcularSO = CalcularSO & " 64"
	end if
	
end function

function CalcularMozilla(pTxt)	
	str = lcase(pTxt)
	
	if instr(str, "mozilla/5.0") then
		CalcularMozilla = "Mozilla/5.0"
	elseif instr(str, "mozilla/4.0") then
		CalcularMozilla = "Mozilla/4.0"
	else
		CalcularMozilla = "-"
	end if
end function

function EsMovil(pTxt)	
	dim u
	dim b, v
	u = lcase(pTxt)
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

Set rs = Server.CreateObject("ADODB.Recordset")

FechaI = request.QueryString("FechaI")
FechaF = dateadd("d", 1, request.QueryString("FechaF"))

select case request("ver")
case "conlicencia"
	sql = "cookie_lid IS NOT NULL"
case "sinlicencia"
	sql = "cookie_lid IS NULL"
case else
	sql = ""
end select

if sql<>"" then sql = " AND (" & sql & ")"

sql = "session_start>='" & FechaI & "' AND session_start<'" & FechaF & "'" & sql

sql = "SELECT * FROM reg_accesos WHERE (" & sql & ") "

'sql = "SELECT http_user_agent, http_mozilla, http_navegador, http_so, COUNT(id) AS lineas FROM reg_accesos WHERE (" & sql & ") "
'sql = sql & " GROUP BY http_user_agent, http_mozilla, http_navegador, http_so"

req = ""
for each elto in request.QueryString
	if left(elto, 1)<>"_" then
		if req<>"" then req = req & " / "
		req = req & elto & ": " & request.QueryString(elto)
	end if
next
%>{
    "request": "<%= req %>",
	"sql": "<%= sql %>",
    "data": [
<%
rs.Open sql, session("connPWAcesos")

nn = 1
total = 0

do while not rs.eof 
	str = lcase(rs("http_user_agent"))
	
	movil = EsMovil(str)
	
	'calc. mozilla
	calc_mozilla = CalcularMozilla(rs("http_user_agent"))
	calc_so = CalcularSO(rs("http_user_agent"))
	calc_navegador = CalcularNavegador(rs("http_user_agent"))
	
	http_ua = rs("http_user_agent")
	http_ua = replace(http_ua, """", "'")
	
	'ver línea
	'pasa = (lcase(calc_mozilla) = trim(lcase(rs("http_mozilla"))))
	'pasa = (lcase(calc_so)) = trim(lcase(rs("http_so"))))
	'pasa = (rs("http_so")="")
	
	'pasa = instr(rs("http_user_agent"), """")
	'pasa = movil
	'pasa = false
	'if (lcase(calc_so)) <> trim(lcase(rs("http_so"))) then pasa = true
	'if calc_so="" then pasa=true
	pasa = true
	
	if pasa then
		%><% if nn>1 then %>, <% end if %>{
		"nn": "<%= nn %>",
		"session_start": "<%= rs("session_start") %>",
        
		"http_mozilla": "<%= rs("http_mozilla") %>",
		"http_navegador": "<%= rs("http_navegador") %>",
		"http_so": "<%= rs("http_so") %>",
		
		"calc_mozilla": "<%= calc_mozilla %>",
		"calc_navegador": "<%= calc_navegador %>",
		"calc_so": "<%= calc_so %>",
		
		"movil": "<%= movil %>",
		
        "licencia": "<%= rs("cookie_l") %>",
        "cliente": "<%= rs("cookie_u") %>",
        
		"http_ua": "<%= http_ua %>"
		}<% 
		nn=nn+1
	end if
	total=total+1
	rs.movenext
		
loop
	
	
rs.close
set rs=nothing
%>
    ],
    "total": "<%= total %>"
}