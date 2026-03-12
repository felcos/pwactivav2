<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
if 1=2 then
    Function isEmailValid(email) 
        Set regEx = New RegExp 
        regEx.Pattern = "^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w{2,}$" 
        isEmailValid = regEx.Test(trim(email)) 
    End Function 
 
' now, test it: 
 
    Function testEmail(email) 
        response.write "<p>" & email & " (" & _ 
            isEmailValid(email) & ")" 
    End Function 
 
    testEmail("bob") 
    testEmail("aaron@!whatever.com") 
    testEmail("aaron@whatever.com") 
	
	response.End()
end if
%>
<%

id = request.QueryString("id")
email = request.QueryString("email")


if isEmailValid(email) then 
	email = "'" & email & "'"
else
	email = "NULL"
end if

sql = "UPDATE clientes_licencias SET email=" & email & " WHERE id=" & id
'comprobar que no se está utilizando ya en otro cliente
response.Write(sql)


Function isEmailValid(rmail) 
	Set regEx = New RegExp 
	regEx.Pattern = "^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w{2,}$" 
	isEmailValid = regEx.Test(trim(rmail)) 
End Function 
%>