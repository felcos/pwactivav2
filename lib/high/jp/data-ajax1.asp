<%
yy=2015
if yy = 2015 then 
	meses = month(date)
else
	meses = 12
end if

Set rs = Server.CreateObject("ADODB.Recordset")

sql = "SELECT TOP 5 ID, EMPRESA, NOMBRE_EMPRESA, NUM_LICENCIAS, LICENCIAS_ENVIADAS"
for ii=1 to 12
	sql = sql & ", dbo.regAccesosCliente_mes(ID, " & yy-1 & ", " & ii & ") AS m" & ii
next
for ii=1 to meses
	sql = sql & ", dbo.regAccesosCliente_mes(ID, " & yy & ", " & ii & ") AS m" & (ii+12)
	'sql = sql & ", dbo.regAccesosCliente_mes(ID, " & yy & ", " & ii & ") AS m" & ii
next
sql = sql & " FROM PW_clientes WHERE id=" & request.QueryString("id")

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	datos = ""
	for ii=1 to (meses+12)
	'for ii=1 to meses
		if datos<>"" then datos = datos & ", "
		datos = datos & rs("m" & ii)
	next
	
	datos = request.QueryString("id") & "; " & datos
	rs.movenext
loop 

rs.close
set rs=nothing

response.Write(datos)
%>