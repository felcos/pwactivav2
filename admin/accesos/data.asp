<% for each elto in request.Form
	%><%= elto %>:<strong><%= request.Form(elto) %></strong> &nbsp; <%
next %>
<%
FechaI = request.QueryString("FechaI")
FechaF = request.QueryString("FechaF")

if FechaI="" then FechaI="01/01/2014"
sqlW = ""

if FechaI<>"" then sqlW = sqlW & "session_start>=CONVERT(DATETIME, '" & FechaI & " 00:00:00', 102)"
if FechaF<>"" then 
	if datediff("d", date, FechaF)>0 then
		if sqlW<>"" then sqlW = sqlW & " AND "
		sqlW = sqlW & "session_start<=CONVERT(DATETIME, '" & FechaF & " 00:00:00', 102)"
	end if
end if
if sqlW<>"" then sqlW = " WHERE (" & sqlW & ") "

sql = "SELECT CONVERT(varchar(10), session_start, 103) AS fecha, CONVERT(varchar(10), session_start, 111) AS ff, COUNT(id) AS accesos FROM reg_accesos "
sql = sql & sqlW
'	/* NOT (usuario_id IS NULL) AND */
'	session_start>=01/01/2014
sql = sql & "GROUP BY CONVERT(varchar(10), session_start, 111), CONVERT(varchar(10), session_start, 103) "
sql = sql & "ORDER BY CONVERT(varchar(10), session_start, 111)"

response.Write(sql)
response.End()

Set rs = Server.CreateObject("ADODB.Recordset")
'test_inyeccion_sql sql
rs.Open sql, session("connPWAcesos")	', 1, 1

nn = 0
vAccesos = ""

do while not rs.eof 
	nn=nn+1
	if vAccesos<>"" then vAccesos = vAccesos & ", "
	vAccesos = vAccesos & "['" & rs("fecha") & "', " & rs("accesos") & "]"
	rs.movenext
loop 

rs.close
set rs=nothing
%>
<%= vAccesos %>

