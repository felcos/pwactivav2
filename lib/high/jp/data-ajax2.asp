<%
yy = request.QueryString("yy")
if yy="" then yy=2015

meses = datediff("m", "01/01/" & yy, date)
dim datos()

redim datos(meses+1)

Set rs = Server.CreateObject("ADODB.Recordset")

sql = sql & "SELECT YEAR(fecha) AS yy, MONTH(fecha) AS mm, COUNT(id) AS articulos FROM reg_articulos "
sql = sql & "WHERE (id_cliente = " & request.QueryString("id") & " AND YEAR(fecha)>=" & yy & ") "
sql = sql & "GROUP BY YEAR(fecha), MONTH(fecha) "
sql = sql & "ORDER BY YEAR(fecha), MONTH(fecha)"

rs.Open sql, session("connPWAcesos")

do while not rs.eof
	mes = 12*(rs("yy")-yy)+rs("mm")
	datos(mes) = rs("articulos")
	rs.movenext
loop 

rs.close
set rs=nothing

resp = ""
ticks = ""

for ii=1 to meses+1
	if resp<>"" then 
		resp = resp & ", "
	end if
	
	if datos(ii)="" then
	'	if ii=1 then
	'		resp = resp & "null"
	'	else
	'		if datos(ii-1)="null" then
	'			resp = resp & "null"
	'		else
				resp = resp & "0"
	'		end if
	'	end if
	else
		resp = resp & datos(ii)
	end if
next

resp = request.QueryString("id") & "; " & yy & "; " & resp

response.Write(resp)
%>