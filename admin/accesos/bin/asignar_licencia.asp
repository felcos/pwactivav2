<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% 
response.buffer = False 
global_starttime = Timer()
session("connPWAcesos").CommandTimeout = 0

'set rs = Server.CreateObject("ADODB.Recordset")

'if request.Cookies("dev")("request")<>"" then
	%><p>QueryString: &nbsp; <%
	for each elto in request.QueryString
		%><strong><%= elto %></strong>: <%= request.QueryString(elto) %>&nbsp; <%
	next
	%></p><%
	
	%><p>Form: &nbsp; <%
	for each elto in request.Form
		%><strong><%= elto %></strong>: <%= request.Form(elto) %>&nbsp; <%
	next
	%></p><% 
'end if 

u = replace(request.QueryString("u"), "'", "''")
uid = replace(request.QueryString("uid"), "'", "''")
l = replace(request.QueryString("l"), "'", "''")
dest = replace(request.QueryString("destino"), "'", "''")

%>
<hr>
<%
'reg_pags
starttime = Timer() 

sql = "UPDATE reg_pags SET "
sql = sql & "cookie_u='" & dest & "' "
'sql = "SELECT COUNT(*) FROM reg_pags "
sql = sql & "WHERE "
sql = sql & "cookie_l='" & l & "' AND "
sql = sql & "cookie_u='" & u & "'"

session("connPWAcesos").execute sql

endtime = Timer() 
time1 = endtime-starttime
%>
<p><%= sql %></p><p>time1: <%= time1 %></p>
<%

starttime = Timer() 

sql = "UPDATE reg_pags SET "
sql = sql & "session_nombre='" & dest & "' "
'sql = "SELECT COUNT(*) FROM reg_pags "
sql = sql & "WHERE "
sql = sql & "session_nombre='" & l & "' AND "
sql = sql & "session_usuario='" & u & "'"

session("connPWAcesos").execute sql
'rs.open sql, session("connPWAcesos")
'rs.close

endtime = Timer() 
time2 = endtime-starttime
%>
<p><%= sql %></p><p>time2: <%= time2 %></p><hr><%

'reg_accesos
starttime = Timer() 

sql = "UPDATE reg_accesos SET "
sql = sql & "cookie_l='" & dest & "' "
'sql = "SELECT COUNT(*) FROM reg_accesos "
sql = sql & "WHERE "
sql = sql & "cookie_l='" & l & "' AND "
sql = sql & "cookie_u='" & u & "' AND "
sql = sql & "cookie_uid=" & uid

session("connPWAcesos").execute sql
'rs.open sql, session("connPWAcesos")
'rs.close

endtime = Timer() 
time3 = endtime-starttime
%>
<p><%= sql %></p><p>time3: <%= time3 %></p><hr><%

'reg_articulos
starttime = Timer() 
sql = "UPDATE reg_articulos SET "
sql = sql & "licencia='" & dest & "' "
'sql = "SELECT COUNT(*) FROM reg_articulos "
sql = sql & "WHERE "
sql = sql & "licencia='" & l & "' AND "
sql = sql & "cliente='" & u & "' AND "
sql = sql & "id_cliente=" & uid

session("connPWAcesos").execute sql
'rs.open sql, session("connPWAcesos")
'rs.close

endtime = Timer() 
time4 = endtime-starttime
%>
<p><%= sql %></p><p>time4: <%= time4 %></p><hr>
<%

'set rs=nothing

url = "/admin/accesos/cliente/?"
url = url & "uid=" & uid
url = url & "&u=" & u
url = url & "&l=" & dest

'set rs=nothing
endtime = Timer()
%>
<p><%= url %>
<p><a href="<%= url %>">continuar ....</a></p>
<p>&nbsp;</p>
<p>Total: <%= endtime - global_starttime  %></p>


