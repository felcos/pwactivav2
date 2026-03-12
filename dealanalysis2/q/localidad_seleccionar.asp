<%
msg=""
for each elto in request.Form 
	if request.Form(elto)<>"" then 
		msg=msg & "[<b>" & elto & "</b>=" & request.Form(elto) & "]&nbsp;"
	end if 
next 
	
r_pais = request.form("pais")
r_buscar = request.form("buscar")

if not isnumeric(r_pais) then errMsg="error pais: " & r_pais
if trim(r_buscar)="" then errMsg="error buscar NADA"

if errMsg<>"" then
	'response.Write(errMsg)
	response.Write(msg)
	response.End()
end if

sql = "SELECT * FROM C_LOCALIDADES WHERE id_pais=" & r_pais & " AND NOMBRE='" & r_buscar & "'"

set rsTmp = Server.CreateObject("ADODB.Recordset")
rsTmp.open sql, session("connPW")

if rsTmp.eof then 
	response.Write("inexistente")
else
	response.Write(rsTmp("id"))
end if

rsTmp.close
set rsTmp=nothing

%>